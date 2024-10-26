use async_graphql::{InputObject, SimpleObject};

// ===== for Query =====

#[derive(SimpleObject)]
pub struct ArtistData {
    pub id: String,
    pub name: String,
    pub fsp: i32,
    pub image_url: Option<String>,
}

#[derive(SimpleObject)]
pub struct ArtistsData {
    pub artist_list: Vec<ArtistData>,
}

#[derive(SimpleObject)]
pub struct ArtistByUserData {
    pub id: String,
    pub name: String,
    pub image_url: Option<String>,
    pub is_accepted: bool,
}

#[derive(SimpleObject)]
pub struct ArtistByUserDataList {
    pub artist_list: Vec<ArtistByUserData>,
}

#[derive(SimpleObject)]
pub struct ArtistFullData {
    pub id: String, // uuid
    pub name: String,
    pub img_url: Option<String>,
    pub fsp: i32,
    pub status: Option<String>, // hiden, visible
    pub since: Option<String>,
    pub universal_id: Option<String>,
    pub apple_key: Option<String>,
    pub spotify_key: Option<String>,
    pub line_key: Option<String>,
    pub amazon_key: Option<String>,
    pub youtube_key: Option<String>,
}

// ===== for Mutation =====

#[derive(InputObject)]
pub struct CreateNewArtistInput {
    pub name: String,
    pub img_url: Option<String>,
    pub fsp: i32,
    pub status: Option<String>, // hiden, visible
    pub since: Option<String>,
    pub universal_id: Option<String>,
    pub apple_key: Option<String>,
    pub spotify_key: Option<String>,
    pub line_key: Option<String>,
    pub amazon_key: Option<String>,
    pub youtube_key: Option<String>,
}

#[derive(SimpleObject)]
pub struct CreateNewArtistResponse {
    pub id: String, // uuid
    pub name: String,
}

#[derive(InputObject)]
pub struct DeleteArtistInput {
    pub id: String, // uuid
}

#[derive(SimpleObject)]
pub struct DeleteArtistResponse {
    pub id: String, // uuid
}

#[derive(InputObject)]
pub struct UpdateArtistInput {
    pub id: String, // uuid
    pub name: Option<String>,
    pub img_url: Option<String>,
    pub fsp: Option<i32>,
    pub status: Option<String>, // hiden, visible
    pub since: Option<String>,
    pub universal_id: Option<String>,
    pub apple_key: Option<String>,
    pub spotify_key: Option<String>,
    pub line_key: Option<String>,
    pub amazon_key: Option<String>,
    pub youtube_key: Option<String>,
}

#[derive(SimpleObject)]
pub struct UpdateArtistResponse {
    pub id: String, // uuid
}
