//! `SeaORM` Entity for notification delivery channels.

use sea_orm::entity::prelude::*;

#[derive(Clone, Debug, PartialEq, DeriveEntityModel, Eq)]
#[sea_orm(table_name = "notification_channels")]
pub struct Model {
    #[sea_orm(primary_key, auto_increment = false)]
    pub notification_id: i32,
    #[sea_orm(primary_key, auto_increment = false)]
    pub channel: String,
}

#[derive(Copy, Clone, Debug, EnumIter, DeriveRelation)]
pub enum Relation {
    #[sea_orm(
        belongs_to = "super::notifications::Entity",
        from = "Column::NotificationId",
        to = "super::notifications::Column::Id",
        on_update = "NoAction",
        on_delete = "Cascade"
    )]
    Notifications,
}

impl Related<super::notifications::Entity> for Entity {
    fn to() -> RelationDef {
        Relation::Notifications.def()
    }
}

impl ActiveModelBehavior for ActiveModel {}
