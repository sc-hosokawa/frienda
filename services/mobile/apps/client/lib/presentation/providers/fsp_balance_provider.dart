import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql/client.dart';
import '../providers/user_provider.dart';
import '../providers/client_provider.dart';
import '../providers/app_lifecycle_provider.dart';

final fspBalanceProvider = StreamProvider.autoDispose<int>((ref) async* {
  final user = ref.watch(userProvider);
  if (user == null) {
    yield 0;
    return;
  }

  // 初期値を即座に提供
  yield user.fspBalance;

  // アプリのライフサイクル状態を監視
  ref.listen(appLifecycleProvider, (previous, next) {
    // ライフサイクルの変更を監視できます（必要な場合）
  });

  while (true) {
    await Future.delayed(const Duration(seconds: 5));

    // 現在のライフサイクル状態をチェック
    if (ref.read(appLifecycleProvider) != AppLifecycleState.resumed) {
      continue;
    }

    try {
      final result = await ref.read(graphQLClientProvider).query(
            QueryOptions(
              document: gql('''
                query GetUserFspBalance(\$userId: String!) {
                  getUser(userId: \$userId) {
                    fspBalance
                  }
                }
              '''),
              variables: {
                'userId': user.id,
              },
              fetchPolicy: FetchPolicy.networkOnly,
            ),
          );

      if (result.data != null) {
        final newBalance = result.data!['getUser']['fspBalance'] as int;
        ref.read(userProvider.notifier).updateBalance(newBalance);
        yield newBalance;
      }
    } catch (e) {
      print('Failed to fetch FSP balance: $e');
      continue;
    }
  }
});
