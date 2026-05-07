use crate::graphql::models;
use application::usecases::artist::cancel_request_to_access_usecase::{
    CancelRequestToAccessError, CancelRequestToAccessUsecaseInput,
};
use application::usecases::artist::leave_belonged_artist_usecase::{
    LeaveBelongedArtistError, LeaveBelongedArtistUsecaseInput,
};
use application::usecases::artist::request_to_access_usecase::{
    RequestToAccessArtistRequest, RequestToAccessUsecaseInput,
};
use application::usecases::artist::resend_request_to_access_usecase::{
    ResendRequestToAccessError, ResendRequestToAccessUsecaseInput,
};
use async_graphql::{Context, Error, ErrorExtensions, Object, Result};
use registry::Usecases;
use shared::error::domain_err::DomainError;
use std::sync::Arc;

use domain::entities::sea_orm_active_enums::UserArtistStatus;

#[derive(Default)]
pub struct ArtistMutation;

fn graphql_error(message: impl Into<String>, code: &'static str) -> Error {
    Error::new(message).extend_with(|_, extensions| {
        extensions.set("code", code);
    })
}

fn bad_user_input(message: impl Into<String>) -> Error {
    graphql_error(message, "BAD_USER_INPUT")
}

fn map_request_to_access_error(error: DomainError) -> Error {
    match error {
        DomainError::NotFound => graphql_error("Artist not found", "NOT_FOUND"),
        DomainError::ValidationError(message) | DomainError::InvalidParameter(message) => {
            bad_user_input(message)
        }
        DomainError::AuthorizationError(message) => graphql_error(message, "FORBIDDEN"),
        other => graphql_error(other.to_string(), "INTERNAL_SERVER_ERROR"),
    }
}

fn map_resend_request_to_access_error(error: ResendRequestToAccessError) -> Error {
    match error {
        ResendRequestToAccessError::BadUserInput(message) => bad_user_input(message),
        ResendRequestToAccessError::NotFound => {
            graphql_error("Artist request mapping not found", "NOT_FOUND")
        }
        ResendRequestToAccessError::InvalidState(message) => {
            graphql_error(message, "INVALID_STATE")
        }
        ResendRequestToAccessError::Domain(DomainError::AuthorizationError(message)) => {
            graphql_error(message, "FORBIDDEN")
        }
        ResendRequestToAccessError::Domain(other) => {
            graphql_error(other.to_string(), "INTERNAL_SERVER_ERROR")
        }
    }
}

fn map_cancel_request_to_access_error(error: CancelRequestToAccessError) -> Error {
    match error {
        CancelRequestToAccessError::NotFound => {
            graphql_error("Artist request mapping not found", "NOT_FOUND")
        }
        CancelRequestToAccessError::InvalidState(message) => {
            graphql_error(message, "INVALID_STATE")
        }
        CancelRequestToAccessError::Domain(DomainError::AuthorizationError(message)) => {
            graphql_error(message, "FORBIDDEN")
        }
        CancelRequestToAccessError::Domain(other) => {
            graphql_error(other.to_string(), "INTERNAL_SERVER_ERROR")
        }
    }
}

fn map_leave_belonged_artist_error(error: LeaveBelongedArtistError) -> Error {
    match error {
        LeaveBelongedArtistError::NotFound => {
            graphql_error("Belonged artist not found", "NOT_FOUND")
        }
        LeaveBelongedArtistError::Forbidden(message) => graphql_error(message, "FORBIDDEN"),
        LeaveBelongedArtistError::InvalidState(message) => graphql_error(message, "INVALID_STATE"),
        LeaveBelongedArtistError::Domain(DomainError::AuthorizationError(message)) => {
            graphql_error(message, "FORBIDDEN")
        }
        LeaveBelongedArtistError::Domain(other) => {
            graphql_error(other.to_string(), "INTERNAL_SERVER_ERROR")
        }
    }
}

pub(crate) fn normalize_request_to_access_input(
    input: models::artists::RequestToAccessArtistInput,
) -> Result<RequestToAccessUsecaseInput> {
    let has_requests = input.requests.is_some();
    let has_artist_ids = input.artist_ids.is_some();

    if has_requests == has_artist_ids {
        return Err(bad_user_input(
            "Specify exactly one of requests or artistIds",
        ));
    }

    let requests = if let Some(requests) = input.requests {
        requests
            .into_iter()
            .map(|request| {
                validate_request_message(request.message.as_ref())?;
                Ok(RequestToAccessArtistRequest {
                    artist_id: request.artist_id,
                    message: request.message,
                })
            })
            .collect::<Result<Vec<_>>>()?
    } else {
        input
            .artist_ids
            .unwrap_or_default()
            .into_iter()
            .map(|artist_id| RequestToAccessArtistRequest {
                artist_id,
                message: None,
            })
            .collect()
    };

    Ok(RequestToAccessUsecaseInput {
        user_id: input.user_id,
        requests,
    })
}

fn validate_request_message(message: Option<&String>) -> Result<()> {
    if let Some(message) = message {
        if message.is_empty() {
            return Err(bad_user_input("request message must not be empty"));
        }
        if message.chars().count() > 200 {
            return Err(bad_user_input(
                "request message must be 200 characters or fewer",
            ));
        }
    }

    Ok(())
}

pub(crate) fn normalize_resend_request_to_access_input(
    input: models::artists::ResendRequestToAccessArtistInput,
) -> Result<ResendRequestToAccessUsecaseInput> {
    validate_request_message(input.message.as_ref())?;

    Ok(ResendRequestToAccessUsecaseInput {
        user_id: input.user_id,
        artist_id: input.artist_id,
        message: input.message,
    })
}

pub(crate) fn normalize_cancel_request_to_access_input(
    input: models::artists::CancelRequestToAccessArtistInput,
) -> CancelRequestToAccessUsecaseInput {
    CancelRequestToAccessUsecaseInput {
        user_id: input.user_id,
        artist_id: input.artist_id,
    }
}

pub(crate) fn normalize_leave_belonged_artist_input(
    input: models::artists::LeaveBelongedArtistInput,
) -> LeaveBelongedArtistUsecaseInput {
    LeaveBelongedArtistUsecaseInput {
        operator_user_id: input.operator_user_id,
        user_id: input.user_id,
        artist_id: input.artist_id,
    }
}

#[Object]
impl ArtistMutation {
    async fn create_new_artist(
        &self,
        ctx: &Context<'_>,
        input: Vec<models::artists::CreateNewArtistInput>,
    ) -> Result<models::artists::CreateNewArtistsResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let res = usecases
            .manage_artists
            .add_artists(
                application::usecases::artist::manage_artists_usecase::AddArtistsInput {
                    artists: input
                        .into_iter()
                        .map(|input| {
                            application::usecases::artist::manage_artists_usecase::AddArtistInput {
                                display_name_jp: input.display_name_jp,
                                display_name_en: input.display_name_en,
                                display_name_kana: input.display_name_kana,
                                img_url: input.img_url,
                                fsp: input.fsp.unwrap_or(0),
                                status: input.status.unwrap_or("visible".to_string()),
                                universal_id: input.universal_id,
                                apple_key: input.apple_key,
                                spotify_key: input.spotify_key,
                                line_key: input.line_key,
                                amazon_key: input.amazon_key,
                                youtube_key: input.youtube_key,
                            }
                        })
                        .collect(),
                },
            )
            .await?;
        Ok(models::artists::CreateNewArtistsResponse {
            added_artists: res
                .added_artists
                .into_iter()
                .map(|artist| models::artists::CreateNewArtistData {
                    artist_id: artist.artist_id,
                    display_name_jp: artist.display_name_jp,
                })
                .collect(),
        })
    }

    async fn update_artist(
        &self,
        ctx: &Context<'_>,
        input: models::artists::UpdateArtistInput,
    ) -> Result<models::artists::UpdateArtistResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let res = usecases
            .manage_artists
            .update_artists(
                application::usecases::artist::manage_artists_usecase::UpdateArtistsInput {
                    artist_id: input.artist_id,
                    display_name_jp: input.display_name_jp,
                    display_name_en: input.display_name_en,
                    display_name_kana: input.display_name_kana,
                    img_url: input.img_url,
                    fsp: input.fsp,
                    status: input.status,
                    universal_id: input.universal_id,
                    apple_key: input.apple_key,
                    spotify_key: input.spotify_key,
                    line_key: input.line_key,
                    amazon_key: input.amazon_key,
                    youtube_key: input.youtube_key,
                },
            )
            .await?;
        Ok(models::artists::UpdateArtistResponse { artist_id: res })
    }

    async fn request_to_access_artist(
        &self,
        ctx: &Context<'_>,
        input: models::artists::RequestToAccessArtistInput,
    ) -> Result<models::artists::RequestToAccessArtistResponse> {
        let input = normalize_request_to_access_input(input)?;
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let res = usecases
            .request_to_access
            .request_to_access(input)
            .await
            .map_err(map_request_to_access_error)?;
        Ok(models::artists::RequestToAccessArtistResponse {
            created_mappings: res
                .created_mappings
                .into_iter()
                .map(|mapping| {
                    models::artists::ArtistByUserDataWithMappingId::from_domain_on_request_to_access(mapping)
                        .unwrap()
                })
            .collect(),
        })
    }

    async fn resend_request_to_access_artist(
        &self,
        ctx: &Context<'_>,
        input: models::artists::ResendRequestToAccessArtistInput,
    ) -> Result<models::artists::ResendRequestToAccessArtistResponse> {
        let input = normalize_resend_request_to_access_input(input)?;
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let res = usecases
            .resend_request_to_access
            .resend_request_to_access(input)
            .await
            .map_err(map_resend_request_to_access_error)?;
        Ok(models::artists::ResendRequestToAccessArtistResponse {
            updated_mapping:
                models::artists::ArtistByUserDataWithMappingId::from_domain_on_request_to_access(
                    res.updated_mapping,
                )
                .unwrap(),
        })
    }

    async fn cancel_request_to_access_artist(
        &self,
        ctx: &Context<'_>,
        input: models::artists::CancelRequestToAccessArtistInput,
    ) -> Result<models::artists::CancelRequestToAccessArtistResponse> {
        let input = normalize_cancel_request_to_access_input(input);
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let res = usecases
            .cancel_request_to_access
            .cancel_request_to_access(input)
            .await
            .map_err(map_cancel_request_to_access_error)?;
        Ok(models::artists::CancelRequestToAccessArtistResponse {
            canceled_mapping:
                models::artists::ArtistByUserDataWithMappingId::from_domain_on_request_to_access(
                    res.canceled_mapping,
                )
                .unwrap(),
        })
    }

    async fn leave_belonged_artist(
        &self,
        ctx: &Context<'_>,
        input: models::artists::LeaveBelongedArtistInput,
    ) -> Result<models::artists::LeaveBelongedArtistResponse> {
        let input = normalize_leave_belonged_artist_input(input);
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let res = usecases
            .leave_belonged_artist
            .leave_belonged_artist(input)
            .await
            .map_err(map_leave_belonged_artist_error)?;
        Ok(models::artists::LeaveBelongedArtistResponse {
            left_artist: models::artists::ArtistByUserData::from_domain(res.left_artist).unwrap(),
        })
    }

    async fn mark_as_member(
        &self,
        ctx: &Context<'_>,
        input: models::artists::MarkAsMemberInput,
    ) -> Result<models::artists::MarkAsMemberResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let res = usecases
            .mark_as_member
            .mark_as_member(
                application::usecases::artist::mark_as_member_usecase::MarkAsMemberUsecaseInput {
                    artist_id: input.artist_id,
                    member: input.member,
                    mapping: input
                        .mapping
                        .into_iter()
                        .map(|status_user| {
                            Ok(
                                application::usecases::artist::mark_as_member_usecase::UserStatus {
                                    user_id: status_user.user_id,
                                    status: match status_user.status.as_str() {
                                        "Check" => UserArtistStatus::Check,
                                        "Accept" => UserArtistStatus::Accept,
                                        "Reject" => UserArtistStatus::Reject,
                                        "Canceled" => UserArtistStatus::Canceled,
                                        _ => {
                                            return Err(async_graphql::Error::new("Invalid status"))
                                        }
                                    },
                                },
                            )
                        })
                        .collect::<Result<Vec<_>, _>>()?,
                },
            )
            .await?;
        Ok(models::artists::MarkAsMemberResponse {
            checked_user_id: res
                .iter()
                .map(|user_artist| user_artist.user_id.to_string())
                .collect(),
        })
    }

    async fn mark_as_admin(
        &self,
        ctx: &Context<'_>,
        input: models::artists::MarkAsAdminInput,
    ) -> Result<models::artists::MarkAsAdminResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let res = usecases
            .mark_as_member
            .mark_as_admin(
                application::usecases::artist::mark_as_member_usecase::MarkAsAdminUsecaseInput {
                    admin_member: input.admin_member,
                    artist_id: input.artist_id,
                    user_id: input.user_id,
                },
            )
            .await?;
        Ok(models::artists::MarkAsAdminResponse {
            checked_user_id: res.user_id.to_string(),
        })
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn input(
        requests: Option<Vec<models::artists::RequestToAccessArtistItemInput>>,
        artist_ids: Option<Vec<String>>,
    ) -> models::artists::RequestToAccessArtistInput {
        models::artists::RequestToAccessArtistInput {
            user_id: "user123".to_string(),
            requests,
            artist_ids,
        }
    }

    fn resend_input(message: Option<String>) -> models::artists::ResendRequestToAccessArtistInput {
        models::artists::ResendRequestToAccessArtistInput {
            user_id: "user123".to_string(),
            artist_id: "artist123".to_string(),
            message,
        }
    }

    fn cancel_input() -> models::artists::CancelRequestToAccessArtistInput {
        models::artists::CancelRequestToAccessArtistInput {
            user_id: "user123".to_string(),
            artist_id: "artist123".to_string(),
        }
    }

    fn leave_input() -> models::artists::LeaveBelongedArtistInput {
        models::artists::LeaveBelongedArtistInput {
            operator_user_id: "operator123".to_string(),
            user_id: "user123".to_string(),
            artist_id: "artist123".to_string(),
        }
    }

    fn error_code(error: &Error) -> Option<String> {
        error.extensions.as_ref().and_then(|extensions| {
            extensions
                .get("code")
                .map(|value| value.to_string().trim_matches('"').to_string())
        })
    }

    #[test]
    fn normalize_request_to_access_accepts_requests() {
        let normalized = normalize_request_to_access_input(input(
            Some(vec![models::artists::RequestToAccessArtistItemInput {
                artist_id: "artist123".to_string(),
                message: Some("所属申請をお願いします。".to_string()),
            }]),
            None,
        ))
        .expect("requests input should be accepted");

        assert_eq!(normalized.user_id, "user123");
        assert_eq!(normalized.requests.len(), 1);
        assert_eq!(normalized.requests[0].artist_id, "artist123");
        assert_eq!(
            normalized.requests[0].message,
            Some("所属申請をお願いします。".to_string())
        );
    }

    #[test]
    fn normalize_request_to_access_accepts_legacy_artist_ids() {
        let normalized =
            normalize_request_to_access_input(input(None, Some(vec!["artist123".to_string()])))
                .expect("artistIds input should be accepted");

        assert_eq!(normalized.requests.len(), 1);
        assert_eq!(normalized.requests[0].artist_id, "artist123");
        assert_eq!(normalized.requests[0].message, None);
    }

    #[test]
    fn normalize_request_to_access_rejects_both_input_shapes() {
        let error = normalize_request_to_access_input(input(
            Some(vec![]),
            Some(vec!["artist123".to_string()]),
        ))
        .expect_err("both input shapes should be rejected");

        assert_eq!(error_code(&error), Some("BAD_USER_INPUT".to_string()));
    }

    #[test]
    fn normalize_request_to_access_rejects_missing_input_shapes() {
        let error = normalize_request_to_access_input(input(None, None))
            .expect_err("missing input shapes should be rejected");

        assert_eq!(error_code(&error), Some("BAD_USER_INPUT".to_string()));
    }

    #[test]
    fn normalize_request_to_access_rejects_empty_message() {
        let error = normalize_request_to_access_input(input(
            Some(vec![models::artists::RequestToAccessArtistItemInput {
                artist_id: "artist123".to_string(),
                message: Some(String::new()),
            }]),
            None,
        ))
        .expect_err("empty message should be rejected");

        assert_eq!(error_code(&error), Some("BAD_USER_INPUT".to_string()));
    }

    #[test]
    fn normalize_request_to_access_rejects_message_over_200_chars() {
        let error = normalize_request_to_access_input(input(
            Some(vec![models::artists::RequestToAccessArtistItemInput {
                artist_id: "artist123".to_string(),
                message: Some("あ".repeat(201)),
            }]),
            None,
        ))
        .expect_err("message over 200 chars should be rejected");

        assert_eq!(error_code(&error), Some("BAD_USER_INPUT".to_string()));
    }

    #[test]
    fn normalize_resend_request_to_access_accepts_optional_message() {
        let normalized = normalize_resend_request_to_access_input(resend_input(Some(
            "再申請します".to_string(),
        )))
        .expect("resend input should be accepted");

        assert_eq!(normalized.user_id, "user123");
        assert_eq!(normalized.artist_id, "artist123");
        assert_eq!(normalized.message, Some("再申請します".to_string()));

        let normalized = normalize_resend_request_to_access_input(resend_input(None))
            .expect("empty optional message should be accepted");
        assert_eq!(normalized.message, None);
    }

    #[test]
    fn normalize_resend_request_to_access_rejects_invalid_message() {
        let error = normalize_resend_request_to_access_input(resend_input(Some(String::new())))
            .expect_err("empty message should be rejected");
        assert_eq!(error_code(&error), Some("BAD_USER_INPUT".to_string()));

        let error = normalize_resend_request_to_access_input(resend_input(Some("あ".repeat(201))))
            .expect_err("message over 200 chars should be rejected");
        assert_eq!(error_code(&error), Some("BAD_USER_INPUT".to_string()));
    }

    #[test]
    fn map_resend_request_to_access_errors_sets_graphql_codes() {
        let not_found = map_resend_request_to_access_error(ResendRequestToAccessError::NotFound);
        assert_eq!(error_code(&not_found), Some("NOT_FOUND".to_string()));

        let invalid_state = map_resend_request_to_access_error(
            ResendRequestToAccessError::InvalidState("cannot resend".to_string()),
        );
        assert_eq!(
            error_code(&invalid_state),
            Some("INVALID_STATE".to_string())
        );
    }

    #[test]
    fn normalize_cancel_request_to_access_maps_input() {
        let normalized = normalize_cancel_request_to_access_input(cancel_input());

        assert_eq!(normalized.user_id, "user123");
        assert_eq!(normalized.artist_id, "artist123");
    }

    #[test]
    fn map_cancel_request_to_access_errors_sets_graphql_codes() {
        let not_found = map_cancel_request_to_access_error(CancelRequestToAccessError::NotFound);
        assert_eq!(error_code(&not_found), Some("NOT_FOUND".to_string()));

        let invalid_state = map_cancel_request_to_access_error(
            CancelRequestToAccessError::InvalidState("cannot cancel".to_string()),
        );
        assert_eq!(
            error_code(&invalid_state),
            Some("INVALID_STATE".to_string())
        );
    }

    #[test]
    fn normalize_leave_belonged_artist_maps_input() {
        let normalized = normalize_leave_belonged_artist_input(leave_input());

        assert_eq!(normalized.operator_user_id, "operator123");
        assert_eq!(normalized.user_id, "user123");
        assert_eq!(normalized.artist_id, "artist123");
    }

    #[test]
    fn map_leave_belonged_artist_errors_sets_graphql_codes() {
        let not_found = map_leave_belonged_artist_error(LeaveBelongedArtistError::NotFound);
        assert_eq!(error_code(&not_found), Some("NOT_FOUND".to_string()));

        let forbidden = map_leave_belonged_artist_error(LeaveBelongedArtistError::Forbidden(
            "not allowed".to_string(),
        ));
        assert_eq!(error_code(&forbidden), Some("FORBIDDEN".to_string()));

        let invalid_state = map_leave_belonged_artist_error(
            LeaveBelongedArtistError::InvalidState("cannot leave".to_string()),
        );
        assert_eq!(
            error_code(&invalid_state),
            Some("INVALID_STATE".to_string())
        );
    }
}
