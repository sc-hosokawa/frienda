import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql/client.dart';
import '../providers/user_provider.dart';
import '../providers/client_provider.dart';
import '../providers/app_lifecycle_provider.dart';

class BalanceState {
  final int fspBalance;
  final int fspBalanceTemp;
  final int credentialBalance;

  const BalanceState({
    this.fspBalance = 0,
    this.fspBalanceTemp = 0,
    this.credentialBalance = 0,
  });

  BalanceState copyWith({
    int? fspBalance,
    int? fspBalanceTemp,
    int? credentialBalance,
  }) {
    return BalanceState(
      fspBalance: fspBalance ?? this.fspBalance,
      fspBalanceTemp: fspBalanceTemp ?? this.fspBalanceTemp,
      credentialBalance: credentialBalance ?? this.credentialBalance,
    );
  }
}

final balanceStateProvider =
    StateNotifierProvider<BalanceStateNotifier, BalanceState>((ref) {
  return BalanceStateNotifier();
});

class BalanceStateNotifier extends StateNotifier<BalanceState> {
  BalanceStateNotifier() : super(const BalanceState());

  void updateBalances({
    int? fspBalance,
    int? fspBalanceTemp,
    int? credentialBalance,
  }) {
    state = state.copyWith(
      fspBalance: fspBalance ?? state.fspBalance,
      fspBalanceTemp: fspBalanceTemp ?? state.fspBalanceTemp,
      credentialBalance: credentialBalance ?? state.credentialBalance,
    );
  }
}

final balanceStreamProvider =
    StreamProvider.autoDispose<BalanceState>((ref) async* {
  final user = ref.watch(userProvider);
  if (user == null) {
    yield const BalanceState();
    return;
  }

  // 初期値を提供
  ref.read(balanceStateProvider.notifier).updateBalances(
        fspBalance: user.fspBalance,
      );
  yield ref.read(balanceStateProvider);

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
                query getUserPointBalance(\$userId: String!) {
                  getUserPointBalance(userId: \$userId) {
                    fspBalance
                    fspBalanceTemp
                    credentialBalance
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
        final data = result.data!['getUserPointBalance'];
        ref.read(balanceStateProvider.notifier).updateBalances(
              fspBalance: data['fspBalance'] as int,
              fspBalanceTemp: data['fspBalanceTemp'] as int,
              credentialBalance: data['credentialBalance'] as int,
            );
        yield ref.read(balanceStateProvider);
      }
    } catch (e) {
      print('Failed to fetch balances: $e');
      continue;
    }
  }
});
