use async_graphql::{InputObject, SimpleObject};

#[derive(SimpleObject)]
pub struct ArtistData {
    pub id: String,
    pub name: String,
    pub image_url: String,
    pub created_at: String,
    pub updated_at: String,
}

#[derive(SimpleObject)]
pub struct ArtistPlaybackOverviewData {
    pub id: String,
    pub name: String,
    pub image_url: String,
    pub created_at: String,
    pub updated_at: String,
}

#[derive(InputObject)]
pub struct ArtistsInput {
    pub id: String,
    pub name: String,
    pub image_url: String,
    pub created_at: String,
    pub updated_at: String,
}
