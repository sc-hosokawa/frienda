use chrono::{Duration, FixedOffset, NaiveDate, Utc};

pub(crate) fn today_jst() -> NaiveDate {
    let jst = FixedOffset::east_opt(9 * 3600).unwrap();
    Utc::now().with_timezone(&jst).date_naive()
}

pub(crate) fn recent_data_excluded_window() -> (NaiveDate, NaiveDate) {
    let today = today_jst();
    (today - Duration::days(9), today - Duration::days(3))
}
