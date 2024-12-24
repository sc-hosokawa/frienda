use async_graphql::SimpleObject;
use domain::entities::sea_orm_active_enums::UserCategory;
// ===== Query =====

#[derive(SimpleObject)]
pub struct ConnectedUsersData {
    pub community: Vec<UserConnectionData>,
}

#[derive(SimpleObject)]
pub struct UserConnectionData {
    pub id: String,
    pub name: String,
    pub image_url: Option<String>,
    pub category: String,
    pub favorite_id: Option<String>,
    pub short_note_id: Option<String>,
    pub short_note: Option<String>,
    pub last_logged_in: Option<String>,
    pub connections: Vec<String>,
    pub weight: i32,
}

// ===== Mutation =====
#[derive(SimpleObject)]
pub struct AddShortnoteResponse {
    pub id: String, // uuid
}

#[derive(SimpleObject)]
pub struct EditShortnoteResponse {
    pub id: String, // uuid
}

#[derive(SimpleObject)]
pub struct DeleteShortnoteResponse {
    pub id: String, // uuid
}

#[derive(SimpleObject)]
pub struct MarkFavoriteResponse {
    pub id: String, // uuid
}

impl From<application::usecases::community::get_user_connections_usecase::UserConnection>
    for UserConnectionData
{
    fn from(
        user_connection: application::usecases::community::get_user_connections_usecase::UserConnection,
    ) -> Self {
        Self {
            id: user_connection.id,
            name: user_connection.name,
            image_url: user_connection.image_url,
            category: match user_connection.category {
                UserCategory::Musician => "musician".to_string(),
                UserCategory::Creator => "creator".to_string(),
                UserCategory::Curator => "curator".to_string(),
                UserCategory::Supporter => "supporter".to_string(),
            },
            favorite_id: user_connection.favorite_id.map(|id| id.to_string()),
            short_note_id: user_connection.short_note_id.map(|id| id.to_string()),
            short_note: user_connection.short_note,
            last_logged_in: user_connection.last_logged_in,
            connections: user_connection.connections,
            weight: user_connection.weight,
        }
    }
}
