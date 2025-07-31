use async_trait::async_trait;
use chrono::{Datelike, Duration, Local, TimeZone};
use std::collections::HashMap;
use std::collections::HashSet;
use std::sync::Arc;

use domain::entities::plays_daily::Model as PlaysDaily;
use domain::entities::plays_monthly::Model as PlaysMonthly;
use domain::entities::product_track::Model as ProductTrack;
use domain::entities::products::Model as Products;
use domain::entities::tracks::Model as Track;

use domain::repositories::artists_repo::ArtistsRepository;
use domain::repositories::plays_daily_repo::PlaysDailyRepository;
use domain::repositories::plays_monthly_repo::PlaysMonthlyRepository;
use domain::repositories::product_track_repo::ProductTrackRepository;
use domain::repositories::products_repo::ProductsRepository;
use domain::repositories::tracks_repo::TracksRepository;

pub struct GetTrendingUsecaseInput {
    pub artist_id: String,
    pub user_id: String,
}

pub struct GetTrendingUsecaseOutput {
    pub trending: Vec<TrendTrack>,
}
pub struct TrendTrack {
    pub isrc: String,
    pub track_title: Option<String>,
    pub upc_title: Option<String>,
    pub image_url: Option<String>, // img_url of UPC
    pub total_play_count: i32,
    pub weekly_play_count: i32,
    pub total_play_count_details: PlayCountDetails,
    pub weekly_play_count_details: PlayCountDetails,
}

pub struct GetTrendingByUpcUsecaseInput {
    pub user_id: String,
    pub upc: String,
}
pub struct GetTrendingByUpcUsecaseOutput {
    pub artist_name: String,
    pub product_img_url: Option<String>,
    pub product_title: String,
    pub trending: Vec<TrendTrack>,
}

#[derive(Clone)]
pub struct PlayCountDetails {
    pub spotify: i32,
    pub apple: i32,
    pub line: i32,
    pub amazon: i32,
    pub youtube: i32,
}

#[async_trait]
pub trait GetTrendingUsecaseTrait: Send + Sync {
    async fn get_trending(
        &self,
        input: GetTrendingUsecaseInput,
    ) -> Result<GetTrendingUsecaseOutput, anyhow::Error>;
    async fn get_trending_by_upc(
        &self,
        input: GetTrendingByUpcUsecaseInput,
    ) -> Result<GetTrendingByUpcUsecaseOutput, anyhow::Error>;
}

pub struct GetTrendingUsecase {
    plays_monthly_repo: Arc<dyn PlaysMonthlyRepository>,
    plays_daily_repo: Arc<dyn PlaysDailyRepository>,
    products_repo: Arc<dyn ProductsRepository>,
    tracks_repo: Arc<dyn TracksRepository>,
    product_track_repo: Arc<dyn ProductTrackRepository>,
    artists_repo: Arc<dyn ArtistsRepository>,
}

impl GetTrendingUsecase {
    pub fn new(
        plays_monthly_repo: Arc<dyn PlaysMonthlyRepository>,
        plays_daily_repo: Arc<dyn PlaysDailyRepository>,
        products_repo: Arc<dyn ProductsRepository>,
        tracks_repo: Arc<dyn TracksRepository>,
        product_track_repo: Arc<dyn ProductTrackRepository>,
        artists_repo: Arc<dyn ArtistsRepository>,
    ) -> Self {
        Self {
            plays_monthly_repo,
            plays_daily_repo,
            products_repo,
            tracks_repo,
            product_track_repo,
            artists_repo,
        }
    }
}

#[async_trait]
impl GetTrendingUsecaseTrait for GetTrendingUsecase {
    async fn get_trending(
        &self,
        input: GetTrendingUsecaseInput,
    ) -> Result<GetTrendingUsecaseOutput, anyhow::Error> {
        let products: Vec<Products> = self
            .products_repo
            .find_by_artist_id(&input.artist_id)
            .await?;
        let upcs: Vec<String> = products
            .iter()
            .map(|p| p.upc.clone())
            .collect::<Vec<String>>();
        let product_tracks: Vec<ProductTrack> = self.product_track_repo.get_by_upcs(upcs).await?;
        let isrcs: Vec<String> = product_tracks
            .iter()
            .map(|p| p.isrc.clone())
            .collect::<HashSet<String>>()
            .into_iter()
            .collect();

        let plays_monthly: Vec<PlaysMonthly> =
            self.plays_monthly_repo.find_by_isrcs(isrcs.clone()).await?;

        // 全 ISRC の日次データを取得（月次の補完用）
        let plays_daily_all: Vec<PlaysDaily> =
            self.plays_daily_repo.find_by_isrcs(isrcs.clone()).await?;

        // 日本時間基準での現在時刻を取得
        let jst = chrono::FixedOffset::east_opt(9 * 3600).unwrap();
        let today_jst = chrono::Utc::now().with_timezone(&jst).date_naive();
        let day = today_jst.day();

        // データ更新タイミングを考慮した月次データの選択
        let effective_monthly_data = if day < 4 {
            // 4日未満の場合、前月までの月次データのみ使用
            let last_month = if today_jst.month() == 1 {
                12
            } else {
                today_jst.month() - 1
            };
            let last_month_year = if today_jst.month() == 1 {
                today_jst.year() - 1
            } else {
                today_jst.year()
            };

            plays_monthly
                .iter()
                .filter(|p| {
                    if let Some(month_date) = p.month {
                        month_date.year() < last_month_year
                            || (month_date.year() == last_month_year
                                && month_date.month() <= last_month)
                    } else {
                        false
                    }
                })
                .collect::<Vec<_>>()
        } else {
            // 4日以降の場合、全月次データを使用
            plays_monthly.iter().collect::<Vec<_>>()
        };

        // ISRCごとのDSP別合計を計算
        let mut plays_by_isrc: HashMap<String, i32> = HashMap::new();
        let mut plays_by_isrc_details: HashMap<String, PlayCountDetails> = HashMap::new();

        // 有効な月次データのみを処理
        for play in effective_monthly_data {
            if let Some(isrc) = play.isrc.clone() {
                let details =
                    plays_by_isrc_details
                        .entry(isrc.clone())
                        .or_insert(PlayCountDetails {
                            spotify: 0,
                            apple: 0,
                            line: 0,
                            amazon: 0,
                            youtube: 0,
                        });

                details.spotify += play.spotify;
                details.apple += play.apple;
                details.line += play.line;
                details.amazon += play.amazon;
                details.youtube += play.youtube;

                *plays_by_isrc.entry(isrc).or_insert(0) += play.sum.unwrap_or(0);
            }
        }

        // データ更新タイミングを考慮した日次データの集計
        let year = today_jst.year();
        let month = today_jst.month();
        let first_day_of_month = jst.ymd(year, month, 1).naive_local();

        if day < 4 {
            // 4日未満の場合: 前月分の日次データ + 当月分の日次データ
            let last_month = if month == 1 { 12 } else { month - 1 };
            let last_month_year = if month == 1 { year - 1 } else { year };
            let first_day_of_last_month = jst.ymd(last_month_year, last_month, 1).naive_local();
            let last_day_of_last_month = jst
                .ymd(last_month_year, last_month, 1)
                .naive_local()
                .with_month(last_month)
                .unwrap()
                .with_day(if last_month == 2 {
                    if last_month_year % 4 == 0
                        && (last_month_year % 100 != 0 || last_month_year % 400 == 0)
                    {
                        29
                    } else {
                        28
                    }
                } else if [4, 6, 9, 11].contains(&last_month) {
                    30
                } else {
                    31
                })
                .unwrap();

            // 前月分の日次データ
            for play in &plays_daily_all {
                if let (Some(date), Some(isrc)) = (play.date, play.isrc.clone()) {
                    if date >= first_day_of_last_month && date <= last_day_of_last_month {
                        let details =
                            plays_by_isrc_details
                                .entry(isrc.clone())
                                .or_insert(PlayCountDetails {
                                    spotify: 0,
                                    apple: 0,
                                    line: 0,
                                    amazon: 0,
                                    youtube: 0,
                                });

                        details.spotify += play.spotify;
                        details.apple += play.apple;
                        details.line += play.line;
                        details.amazon += play.amazon.unwrap_or(0);
                        details.youtube += play.youtube.unwrap_or(0);

                        *plays_by_isrc.entry(isrc).or_insert(0) += play.sum.unwrap_or(0);
                    }
                }
            }

            // 当月分の日次データ（昨日まで）
            for play in &plays_daily_all {
                if let (Some(date), Some(isrc)) = (play.date, play.isrc.clone()) {
                    // 当月分は今日から3日引いた日付が当月内の場合のみ取得
                    let end_date = today_jst - Duration::days(3);
                    if end_date >= first_day_of_month {
                        // 当月分の日次データを取得
                        if date >= first_day_of_month && date <= end_date {
                            let details =
                                plays_by_isrc_details
                                    .entry(isrc.clone())
                                    .or_insert(PlayCountDetails {
                                        spotify: 0,
                                        apple: 0,
                                        line: 0,
                                        amazon: 0,
                                        youtube: 0,
                                    });

                            details.spotify += play.spotify;
                            details.apple += play.apple;
                            details.line += play.line;
                            details.amazon += play.amazon.unwrap_or(0);
                            details.youtube += play.youtube.unwrap_or(0);

                            *plays_by_isrc.entry(isrc).or_insert(0) += play.sum.unwrap_or(0);
                        }
                    }
                    // 当月分はデータなし（前月分のみ使用）の場合は何もしない
                }
            }
        } else {
            // 4日以降の場合: 当月分の日次データのみ（昨日まで）
            for play in &plays_daily_all {
                if let (Some(date), Some(isrc)) = (play.date, play.isrc.clone()) {
                    if date >= first_day_of_month && date <= today_jst - Duration::days(3) {
                        let details =
                            plays_by_isrc_details
                                .entry(isrc.clone())
                                .or_insert(PlayCountDetails {
                                    spotify: 0,
                                    apple: 0,
                                    line: 0,
                                    amazon: 0,
                                    youtube: 0,
                                });

                        details.spotify += play.spotify;
                        details.apple += play.apple;
                        details.line += play.line;
                        details.amazon += play.amazon.unwrap_or(0);
                        details.youtube += play.youtube.unwrap_or(0);

                        *plays_by_isrc.entry(isrc).or_insert(0) += play.sum.unwrap_or(0);
                    }
                }
            }
        }

        // 再生数で降順ソートして上位5件を取得
        let mut top_plays: Vec<(String, i32)> = plays_by_isrc.into_iter().collect();
        top_plays.sort_by(|a, b| b.1.cmp(&a.1));
        let top_5_isrcs: Vec<String> = top_plays
            .iter()
            .take(5)
            .map(|(isrc, _)| isrc.clone())
            .collect();
        tracing::info!("top_5_isrcs: {:?}", top_5_isrcs);

        // 過去7日間の再生数を取得
        let jst = chrono::FixedOffset::east_opt(9 * 3600).unwrap();
        let today_jst = chrono::Utc::now().with_timezone(&jst).date_naive();
        let start_date = today_jst - Duration::days(9); 
        let end_date = today_jst - Duration::days(3);

        let plays_daily_in_top5: Vec<PlaysDaily> = self
            .plays_daily_repo
            .find_by_isrcs(top_5_isrcs.clone())
            .await?;

        let mut plays_by_isrc_daily: HashMap<String, i32> = HashMap::new();
        let mut plays_by_isrc_daily_details: HashMap<String, PlayCountDetails> = HashMap::new();

        for play in plays_daily_in_top5 {
            if let Some(date) = play.date {
                if date <= end_date && date >= start_date {
                    if let Some(isrc) = play.isrc.clone() {
                        let details = plays_by_isrc_daily_details.entry(isrc.clone()).or_insert(
                            PlayCountDetails {
                                spotify: 0,
                                apple: 0,
                                line: 0,
                                amazon: 0,
                                youtube: 0,
                            },
                        );

                        details.spotify += play.spotify;
                        details.apple += play.apple;
                        details.line += play.line;
                        details.amazon += play.amazon.unwrap_or(0);
                        details.youtube += play.youtube.unwrap_or(0);

                        *plays_by_isrc_daily.entry(isrc).or_insert(0) += play.sum.unwrap_or(0);
                    }
                }
            }
        }

        let tracks: Vec<Track> = self.tracks_repo.get_by_isrcs(top_5_isrcs).await?;

        let mut trending: Vec<TrendTrack> = vec![];

        for track in tracks {
            let mapping: Vec<ProductTrack> =
                self.product_track_repo.get_by_isrc(&track.isrc).await?;
            let product_in_top5: Option<ProductTrack> = mapping.first().cloned();
            let product_upc_in_top5 = product_in_top5.unwrap().upc;
            let product_info = products.iter().find(|p| p.upc == product_upc_in_top5);
            let product_title = product_info.map(|p| p.title.clone());
            let product_img_url = product_info.map(|p| p.img_url.clone().unwrap());
            trending.push(TrendTrack {
                isrc: track.isrc.clone(),
                track_title: Some(track.title),
                upc_title: product_title,
                image_url: product_img_url,
                total_play_count: top_plays
                    .iter()
                    .find(|(isrc, _)| isrc == &track.isrc)
                    .map(|(_, count)| *count)
                    .unwrap_or(0),
                weekly_play_count: plays_by_isrc_daily.get(&track.isrc).copied().unwrap_or(0),
                total_play_count_details: plays_by_isrc_details
                    .get(&track.isrc)
                    .cloned()
                    .unwrap_or(PlayCountDetails {
                        spotify: 0,
                        apple: 0,
                        line: 0,
                        amazon: 0,
                        youtube: 0,
                    }),
                weekly_play_count_details: plays_by_isrc_daily_details
                    .get(&track.isrc)
                    .cloned()
                    .unwrap_or(PlayCountDetails {
                        spotify: 0,
                        apple: 0,
                        line: 0,
                        amazon: 0,
                        youtube: 0,
                    }),
            });
        }

        Ok(GetTrendingUsecaseOutput { trending })
    }

    async fn get_trending_by_upc(
        &self,
        input: GetTrendingByUpcUsecaseInput,
    ) -> Result<GetTrendingByUpcUsecaseOutput, anyhow::Error> {
        let product: Option<Products> = self.products_repo.get_by_upc(&input.upc).await?;
        let artist_id: String = product.clone().unwrap().artist_id.unwrap();
        let artist = self.artists_repo.find_by_id(&artist_id).await?;
        let artist_name: String = artist.unwrap().display_name_jp;
        let product_img_url: Option<String> = product.clone().unwrap().img_url;
        let product_title: String = product.clone().unwrap().title;

        let mut product_tracks: Vec<ProductTrack> =
            self.product_track_repo.get_by_upc(&input.upc).await?;

        // Sort product_tracks by track_no
        product_tracks.sort_by_key(|pt| pt.track_no.unwrap_or(i32::MAX));

        let isrcs_in_upc: Vec<String> = product_tracks.iter().map(|p| p.isrc.clone()).collect();

        let plays_monthly: Vec<PlaysMonthly> = self
            .plays_monthly_repo
            .find_by_isrcs(isrcs_in_upc.clone())
            .await?;

        // 日本時間基準での現在時刻を取得
        let jst = chrono::FixedOffset::east_opt(9 * 3600).unwrap();
        let today_jst = chrono::Utc::now().with_timezone(&jst).date_naive();
        let day = today_jst.day();

        // データ更新タイミングを考慮した月次データの選択
        let effective_monthly_data = if day < 4 {
            // 4日未満の場合、前月までの月次データのみ使用
            let last_month = if today_jst.month() == 1 {
                12
            } else {
                today_jst.month() - 1
            };
            let last_month_year = if today_jst.month() == 1 {
                today_jst.year() - 1
            } else {
                today_jst.year()
            };

            plays_monthly
                .iter()
                .filter(|p| {
                    if let Some(month_date) = p.month {
                        month_date.year() < last_month_year
                            || (month_date.year() == last_month_year
                                && month_date.month() <= last_month)
                    } else {
                        false
                    }
                })
                .collect::<Vec<_>>()
        } else {
            // 4日以降の場合、全月次データを使用
            plays_monthly.iter().collect::<Vec<_>>()
        };

        // 月間再生数の集計とDSP別内訳の計算
        let mut plays_by_isrc: HashMap<String, i32> = HashMap::new();
        let mut plays_by_isrc_details: HashMap<String, PlayCountDetails> = HashMap::new();

        // 有効な月次データのみを処理
        for play in effective_monthly_data {
            if let Some(isrc) = play.isrc.clone() {
                let details =
                    plays_by_isrc_details
                        .entry(isrc.clone())
                        .or_insert(PlayCountDetails {
                            spotify: 0,
                            apple: 0,
                            line: 0,
                            amazon: 0,
                            youtube: 0,
                        });

                details.spotify += play.spotify;
                details.apple += play.apple;
                details.line += play.line;
                details.amazon += play.amazon;
                details.youtube += play.youtube;

                *plays_by_isrc.entry(isrc).or_insert(0) += play.sum.unwrap_or(0);
            }
        }

        // データ更新タイミングを考慮した日次データの集計
        let year = today_jst.year();
        let month = today_jst.month();
        let first_day_of_month = jst.ymd(year, month, 1).naive_local();

        if day < 4 {
            // 4日未満の場合: 前月分の日次データ + 当月分の日次データ
            let last_month = if month == 1 { 12 } else { month - 1 };
            let last_month_year = if month == 1 { year - 1 } else { year };
            let first_day_of_last_month = jst.ymd(last_month_year, last_month, 1).naive_local();
            let last_day_of_last_month = jst
                .ymd(last_month_year, last_month, 1)
                .naive_local()
                .with_month(last_month)
                .unwrap()
                .with_day(if last_month == 2 {
                    if last_month_year % 4 == 0
                        && (last_month_year % 100 != 0 || last_month_year % 400 == 0)
                    {
                        29
                    } else {
                        28
                    }
                } else if [4, 6, 9, 11].contains(&last_month) {
                    30
                } else {
                    31
                })
                .unwrap();

            // 前月分の日次データ
            let plays_daily: Vec<PlaysDaily> = self
                .plays_daily_repo
                .find_by_isrcs(isrcs_in_upc.clone())
                .await?;
            for play in &plays_daily {
                if let (Some(date), Some(isrc)) = (play.date, play.isrc.clone()) {
                    if date >= first_day_of_last_month && date <= last_day_of_last_month {
                        let details =
                            plays_by_isrc_details
                                .entry(isrc.clone())
                                .or_insert(PlayCountDetails {
                                    spotify: 0,
                                    apple: 0,
                                    line: 0,
                                    amazon: 0,
                                    youtube: 0,
                                });

                        details.spotify += play.spotify;
                        details.apple += play.apple;
                        details.line += play.line;
                        details.amazon += play.amazon.unwrap_or(0);
                        details.youtube += play.youtube.unwrap_or(0);

                        *plays_by_isrc.entry(isrc).or_insert(0) += play.sum.unwrap_or(0);
                    }
                }
            }

            // 当月分の日次データ（昨日まで）
            for play in &plays_daily {
                if let (Some(date), Some(isrc)) = (play.date, play.isrc.clone()) {
                    // 当月分は今日から3日引いた日付が当月内の場合のみ取得
                    let end_date = today_jst - Duration::days(3);
                    if end_date >= first_day_of_month {
                        // 当月分の日次データを取得
                        if date >= first_day_of_month && date <= end_date {
                            let details =
                                plays_by_isrc_details
                                    .entry(isrc.clone())
                                    .or_insert(PlayCountDetails {
                                        spotify: 0,
                                        apple: 0,
                                        line: 0,
                                        amazon: 0,
                                        youtube: 0,
                                    });

                            details.spotify += play.spotify;
                            details.apple += play.apple;
                            details.line += play.line;
                            details.amazon += play.amazon.unwrap_or(0);
                            details.youtube += play.youtube.unwrap_or(0);

                            *plays_by_isrc.entry(isrc).or_insert(0) += play.sum.unwrap_or(0);
                        }
                    }
                    // 当月分はデータなし（前月分のみ使用）の場合は何もしない
                }
            }
        } else {
            // 4日以降の場合: 当月分の日次データのみ（昨日まで）
            let plays_daily: Vec<PlaysDaily> = self
                .plays_daily_repo
                .find_by_isrcs(isrcs_in_upc.clone())
                .await?;
            for play in &plays_daily {
                if let (Some(date), Some(isrc)) = (play.date, play.isrc.clone()) {
                    if date >= first_day_of_month && date <= today_jst - Duration::days(3) {
                        let details =
                            plays_by_isrc_details
                                .entry(isrc.clone())
                                .or_insert(PlayCountDetails {
                                    spotify: 0,
                                    apple: 0,
                                    line: 0,
                                    amazon: 0,
                                    youtube: 0,
                                });

                        details.spotify += play.spotify;
                        details.apple += play.apple;
                        details.line += play.line;
                        details.amazon += play.amazon.unwrap_or(0);
                        details.youtube += play.youtube.unwrap_or(0);

                        *plays_by_isrc.entry(isrc).or_insert(0) += play.sum.unwrap_or(0);
                    }
                }
            }
        }

        // 週間再生数の集計とDSP別内訳の計算
        let mut plays_by_isrc_daily: HashMap<String, i32> = HashMap::new();
        let mut plays_by_isrc_daily_details: HashMap<String, PlayCountDetails> = HashMap::new();

        // 日本時間基準での週間集計
        let jst = chrono::FixedOffset::east_opt(9 * 3600).unwrap();
        let today_jst = chrono::Utc::now().with_timezone(&jst).date_naive();
        let start_date = today_jst - Duration::days(9); // 9日前
        let end_date = today_jst - Duration::days(3); // 3日前

        // フィルタリング処理
        let plays_daily: Vec<PlaysDaily> = self
            .plays_daily_repo
            .find_by_isrcs(isrcs_in_upc.clone())
            .await?;
        for play in plays_daily {
            if let Some(date) = play.date {
                if date <= end_date && date >= start_date {
                    // 週間集計に含める
                    if let Some(isrc) = play.isrc.clone() {
                        let details = plays_by_isrc_daily_details.entry(isrc.clone()).or_insert(
                            PlayCountDetails {
                                spotify: 0,
                                apple: 0,
                                line: 0,
                                amazon: 0,
                                youtube: 0,
                            },
                        );

                        details.spotify += play.spotify;
                        details.apple += play.apple;
                        details.line += play.line;
                        details.amazon += play.amazon.unwrap_or(0);
                        details.youtube += play.youtube.unwrap_or(0);

                        *plays_by_isrc_daily.entry(isrc).or_insert(0) += play.sum.unwrap_or(0);
                    }
                }
            }
        }

        let mut tracks: Vec<Track> = self.tracks_repo.get_by_isrcs(isrcs_in_upc).await?;

        // Sort tracks according to the product_tracks order
        let isrc_order: std::collections::HashMap<String, usize> = product_tracks
            .iter()
            .enumerate()
            .map(|(index, pt)| (pt.isrc.clone(), index))
            .collect();

        tracks.sort_by_key(|track| isrc_order.get(&track.isrc).copied().unwrap_or(usize::MAX));

        let mut trending: Vec<TrendTrack> = vec![];

        for track in tracks {
            let isrc = track.isrc.clone();
            trending.push(TrendTrack {
                isrc: isrc.clone(),
                track_title: Some(track.title),
                upc_title: None,
                image_url: None,
                total_play_count: plays_by_isrc.get(&isrc).unwrap_or(&0).clone(),
                weekly_play_count: plays_by_isrc_daily.get(&isrc).unwrap_or(&0).clone(),
                total_play_count_details: plays_by_isrc_details.get(&isrc).cloned().unwrap_or(
                    PlayCountDetails {
                        spotify: 0,
                        apple: 0,
                        line: 0,
                        amazon: 0,
                        youtube: 0,
                    },
                ),
                weekly_play_count_details: plays_by_isrc_daily_details
                    .get(&isrc)
                    .cloned()
                    .unwrap_or(PlayCountDetails {
                        spotify: 0,
                        apple: 0,
                        line: 0,
                        amazon: 0,
                        youtube: 0,
                    }),
            });
        }

        Ok(GetTrendingByUpcUsecaseOutput {
            artist_name,
            product_img_url,
            product_title,
            trending,
        })
    }
}
