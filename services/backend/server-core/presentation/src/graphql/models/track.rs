use async_graphql::{InputObject, SimpleObject};

// ===== for Query =====

#[derive(SimpleObject)]
pub struct TrackData {
    pub isrc: String,
    pub img_url: Option<String>,
    pub title: String,
}

// ===== for Mutation =====

#[derive(InputObject)]
pub struct TrackInput {
    pub isrc: String,
    pub img_url: Option<String>,
    pub title: Option<String>,
}
