//! `SeaORM` Entity for notification recipient snapshots.

use sea_orm::entity::prelude::*;

#[derive(Clone, Debug, PartialEq, DeriveEntityModel, Eq)]
#[sea_orm(table_name = "notification_recipients")]
pub struct Model {
    #[sea_orm(primary_key, auto_increment = false)]
    pub notification_id: i32,
    #[sea_orm(primary_key, auto_increment = false)]
    pub user_id: String,
    pub created_at: DateTime,
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
    #[sea_orm(
        belongs_to = "super::users::Entity",
        from = "Column::UserId",
        to = "super::users::Column::Id",
        on_update = "NoAction",
        on_delete = "NoAction"
    )]
    Users,
}

impl Related<super::notifications::Entity> for Entity {
    fn to() -> RelationDef {
        Relation::Notifications.def()
    }
}

impl Related<super::users::Entity> for Entity {
    fn to() -> RelationDef {
        Relation::Users.def()
    }
}

impl ActiveModelBehavior for ActiveModel {}
