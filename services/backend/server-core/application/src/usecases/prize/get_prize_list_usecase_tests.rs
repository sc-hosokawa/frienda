// services/backend/server-core/application/tests/prize/get_prize_list_test.rs

use crate::test_support::mocks::exchange_prize_history_mock::MockMockExchangePrizeHistoryRepo;
use crate::test_support::mocks::prize_mock::MockMockPrizesRepo;
use crate::test_support::mocks::user_mock::MockMockUsersRepo;
use crate::usecases::prize::get_prize_list_usecase::{
    GetPrizeListByUserIdOutput, GetPrizeListInput, GetPrizeListUsecase, GetPrizeListUsecaseTrait,
};
use domain::entities::prizes::Model as Prize;
use std::sync::Arc;

// テストデータ作成用のヘルパー関数
fn create_test_prize(id: i32, name: &str) -> Prize {
    Prize {
        id,
        name: name.to_string(),
        description: format!("Description for {}", name),
        img_url: Some(format!("http://example.com/{}.jpg", name)),
        point: 100,
        representation: "".to_string(),
        condition: None,
        publicity: false,
    }
}

fn create_test_prizes(count: i32) -> Vec<Prize> {
    (0..count)
        .map(|i| create_test_prize(i, &format!("Prize {}", i)))
        .collect()
}

#[tokio::test]
async fn test_get_prize_list_success() {
    // Arrange
    let mut mock_repo = MockMockPrizesRepo::new();
    let expected_prizes = create_test_prizes(3);
    let mut mock_exchange_prize_history_repo = MockMockExchangePrizeHistoryRepo::new();
    mock_repo
        .expect_mock_list()
        .returning(move |_limit, _offset| {
            let prizes = expected_prizes.clone();
            Ok(prizes)
        });

    let mock_users_repo = MockMockUsersRepo::new();
    let usecase = GetPrizeListUsecase::new(
        Arc::new(mock_repo),
        Arc::new(mock_exchange_prize_history_repo),
        Arc::new(mock_users_repo),
    );
    let input = GetPrizeListInput {
        limit: 10,
        offset: 0,
    };

    // Act
    let result = usecase.get_prize_list(input).await;

    // Assert
    assert!(result.is_ok());
    let output = result.unwrap();
    assert_eq!(output.prizes.len(), 3);

    // 返された各プライズの内容を検証
    for (i, prize) in output.prizes.iter().enumerate() {
        assert_eq!(prize.id, i as i32);
        assert_eq!(prize.name, format!("Prize {}", i));
        assert_eq!(prize.description, format!("Description for Prize {}", i));
        assert_eq!(
            prize.img_url,
            Some(format!("http://example.com/Prize {}.jpg", i))
        );
        assert_eq!(prize.point, 100);
        assert_eq!(prize.representation, "".to_string());
        assert_eq!(prize.condition, None);
        assert_eq!(prize.publicity, false);
    }
}

#[tokio::test]
async fn test_get_prize_list_empty() {
    // Arrange
    let mut mock_repo = MockMockPrizesRepo::new();

    mock_repo.expect_mock_list().returning(|_, _| Ok(vec![]));

    let mut mock_exchange_prize_history_repo = MockMockExchangePrizeHistoryRepo::new();
    mock_exchange_prize_history_repo
        .expect_mock_get_by_user_id()
        .returning(|user_id| Ok(vec![]));

    let mock_users_repo = MockMockUsersRepo::new();
    let usecase = GetPrizeListUsecase::new(
        Arc::new(mock_repo),
        Arc::new(mock_exchange_prize_history_repo),
        Arc::new(mock_users_repo),
    );
    let input = GetPrizeListInput {
        limit: 10,
        offset: 0,
    };

    // Act
    let result = usecase.get_prize_list(input).await;

    // Assert
    assert!(result.is_ok());
    let output = result.unwrap();
    assert_eq!(output.prizes.len(), 0);
}

#[tokio::test]
async fn test_get_prize_list_with_pagination() {
    // Arrange
    let mut mock_repo = MockMockPrizesRepo::new();
    let mut mock_exchange_prize_history_repo = MockMockExchangePrizeHistoryRepo::new();
    let all_prizes = create_test_prizes(5);

    mock_repo
        .expect_mock_list()
        .returning(move |limit, offset| {
            let prizes = all_prizes.clone();
            let start = offset as usize;
            let end = std::cmp::min(start + limit as usize, prizes.len());
            Ok(prizes[start..end].to_vec())
        });

    let mock_users_repo = MockMockUsersRepo::new();
    let usecase = GetPrizeListUsecase::new(
        Arc::new(mock_repo),
        Arc::new(mock_exchange_prize_history_repo),
        Arc::new(mock_users_repo),
    );
    let input = GetPrizeListInput {
        limit: 2,
        offset: 1,
    };

    // Act
    let result = usecase.get_prize_list(input).await;

    // Assert
    assert!(result.is_ok());
    let output = result.unwrap();
    assert_eq!(output.prizes.len(), 2);
    assert_eq!(output.prizes[0].id, 1);
    assert_eq!(output.prizes[1].id, 2);
}
