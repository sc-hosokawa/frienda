use crate::utils::db::establish_connection;
use sea_orm::DbErr;

pub async fn save_playback() -> Result<(), DbErr> {
    let db = establish_connection().await?;
    todo!()
}
