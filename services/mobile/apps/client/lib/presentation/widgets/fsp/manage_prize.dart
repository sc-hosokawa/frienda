import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/presentation/providers/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ManagePrize extends ConsumerWidget {
  final String prizeId;

  const ManagePrize({
    super.key,
    required this.prizeId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('管理者メニュー'),
          actions: [
            IconButton(
              icon: const Icon(Icons.qr_code_scanner),
              onPressed: () => _showQRScanner(context, user?.id ?? ''),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'リクエスト中'),
              Tab(text: '交換済み'),
              Tab(text: '使用済み'),
            ],
          ),
        ),
        body: Query(
          options: QueryOptions(
            document: gql('''
              query GetPrizeHistoryByUser(\$userId: String!, \$prizeId: Int!) {
                getPrizeHistoryByUserId(userId: \$userId, prizeId: \$prizeId) {
                  unusedHistory {
                    id
                    prizeId
                    userId
                    imgUrl
                    username
                    realname
                    email
                    pointUsed
                    amount
                    exchangedAt
                  }
                  requestedHistory {
                    id
                    prizeId
                    userId
                    imgUrl
                    username
                    realname
                    email
                    pointUsed
                    amount
                    exchangedAt
                    requestedAt
                  }
                  usedHistory {
                    id
                    prizeId
                    userId
                    imgUrl
                    username
                    realname
                    email
                    pointUsed
                    amount
                    exchangedAt
                    usedAt
                  }
                }
              }
            '''),
            variables: {
              'userId': user?.id ?? '',
              'prizeId': int.parse(prizeId),
            },
            fetchPolicy: FetchPolicy.networkOnly,
            pollInterval: const Duration(seconds: 1),
          ),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              return Center(
                  child: Text('エラーが発生しました: ${result.exception.toString()}'));
            }

            if (result.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final historyData = result.data!['getPrizeHistoryByUserId'];

            return TabBarView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: _buildRequestedList(
                      context,
                      historyData['requestedHistory'] ?? [],
                      user?.id ?? '',
                      refetch),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: _buildUnusedList(historyData['unusedHistory'] ?? []),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: _buildUsedList(historyData['usedHistory'] ?? []),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showQRScanner(BuildContext context, String representationUserId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _QRScannerScreen(
          prizeId: prizeId,
          representationUserId: representationUserId,
        ),
      ),
    );
  }

  // QRコードスキャン用の承認処理
  Future<void> _approveRequestFromQR(
    BuildContext context,
    String targetUserId,
    String representationUserId,
    String scannedPrizeId,
  ) async {
    try {
      final client = GraphQLProvider.of(context).value;
      final prizeIdInt = int.parse(scannedPrizeId);

      final result = await client.mutate(
        MutationOptions(
          document: gql('''
            mutation UsePrize(\$input: UsePrizeInput!) {
              usePrize(input: \$input) {
                id
              }
            }
          '''),
          variables: {
            'input': {
              'representationUserId': representationUserId,
              'userId': targetUserId,
              'prizeId': prizeIdInt,
            },
          },
        ),
      );

      if (result.hasException) {
        throw result.exception!;
      }

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('QRコードによる承認が完了しました')),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('QRコードによる承認に失敗しました'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // 既存の承認ボタン用の処理（確認ダイアログあり）
  Future<void> _approveRequest(BuildContext context, String targetUserId,
      String representationUserId, VoidCallback? refetch) async {
    // 確認ダイアログを表示
    final confirmed = await showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('確認'),
          content: const Text('このリクエストを承認しますか？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('キャンセル'),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('承認する'),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !context.mounted) return;

    try {
      final client = GraphQLProvider.of(context).value;
      final prizeIdInt = int.parse(prizeId);

      final result = await client.mutate(
        MutationOptions(
          document: gql('''
            mutation UsePrize(\$input: UsePrizeInput!) {
              usePrize(input: \$input) {
                id
              }
            }
          '''),
          variables: {
            'input': {
              'representationUserId': representationUserId,
              'userId': targetUserId,
              'prizeId': prizeIdInt,
            },
          },
        ),
      );

      if (result.hasException) {
        throw result.exception!;
      }

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('承認が完了しました')),
      );

      refetch?.call();
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('承認に失敗しました'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildUnusedList(List<dynamic> history) {
    if (history.isEmpty) {
      return const Center(
        child: Text('交換済みの景品はありません'),
      );
    }

    // ユーザーIDごとに履歴をグループ化
    final groupedHistory = _groupHistoryByExchangeDate(history);

    return ListView.builder(
      itemCount: groupedHistory.length,
      itemBuilder: (context, index) {
        final userHistory = groupedHistory[index];
        final firstItem = userHistory.first;
        final totalAmount = userHistory.fold<int>(
          0,
          (sum, item) => sum + (item['amount'] as int),
        );

        return _buildUserCard(
          firstItem,
          trailing: Text(
            '合計数量: $totalAmount個',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          additionalInfo: Text(
            '交換日: ${DateFormat('yyyy/MM/dd').format(DateTime.parse(firstItem['exchangedAt']))}',
            style: const TextStyle(color: Colors.grey),
          ),
        );
      },
    );
  }

  // 交換済みリスト用のグループ化メソッド
  List<List<dynamic>> _groupHistoryByExchangeDate(List<dynamic> history) {
    final map = <String, List<dynamic>>{};

    for (var item in history) {
      final userId = item['userId'] as String;
      map.putIfAbsent(userId, () => []).add(item);
    }

    final grouped = map.values.toList();
    for (var group in grouped) {
      group.sort((a, b) => DateTime.parse(b['exchangedAt'])
          .compareTo(DateTime.parse(a['exchangedAt'])));
    }

    grouped.sort((a, b) => DateTime.parse(b.first['exchangedAt'])
        .compareTo(DateTime.parse(a.first['exchangedAt'])));

    return grouped;
  }

  Widget _buildRequestedList(BuildContext context, List<dynamic> history,
      String userId, VoidCallback? refetch) {
    if (history.isEmpty) {
      return const Center(
        child: Text('リクエスト待ちの景品はありません'),
      );
    }

    // ユーザーIDごとに履歴をグループ化
    final groupedHistory = _groupHistoryByRequestDate(history);

    return ListView.builder(
      itemCount: groupedHistory.length,
      itemBuilder: (context, index) {
        final userHistory = groupedHistory[index];
        final firstItem = userHistory.first;
        final totalAmount = userHistory.fold<int>(
          0,
          (sum, item) => sum + (item['amount'] as int),
        );

        return _buildUserCard(
          firstItem,
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
            onPressed: () =>
                _approveRequest(context, firstItem['userId'], userId, refetch),
            child: const Text('承認'),
          ),
          additionalInfo: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '合計数量: $totalAmount個',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '最新リクエスト: ${DateFormat('yyyy/MM/dd').format(DateTime.parse(firstItem['requestedAt']))}',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        );
      },
    );
  }

  // リクエスト中リスト用のグループ化メソッド
  List<List<dynamic>> _groupHistoryByRequestDate(List<dynamic> history) {
    final map = <String, List<dynamic>>{};

    for (var item in history) {
      final userId = item['userId'] as String;
      map.putIfAbsent(userId, () => []).add(item);
    }

    final grouped = map.values.toList();
    for (var group in grouped) {
      group.sort((a, b) => DateTime.parse(b['requestedAt'])
          .compareTo(DateTime.parse(a['requestedAt'])));
    }

    grouped.sort((a, b) => DateTime.parse(b.first['requestedAt'])
        .compareTo(DateTime.parse(a.first['requestedAt'])));

    return grouped;
  }

  Widget _buildUsedList(List<dynamic> history) {
    if (history.isEmpty) {
      return const Center(
        child: Text('使用済みの景品はありません'),
      );
    }

    // ユーザーIDごとに履歴をグループ化
    final groupedHistory = _groupHistoryByUser(history);

    return ListView.builder(
      itemCount: groupedHistory.length,
      itemBuilder: (context, index) {
        final userHistory = groupedHistory[index];
        final firstItem = userHistory.first;
        final totalAmount = userHistory.fold<int>(
          0,
          (sum, item) => sum + (item['amount'] as int),
        );

        return _buildUserCard(
          firstItem,
          trailing: Text(
            '合計数量: $totalAmount個',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          additionalInfo: Text(
            '最終使用日: ${DateFormat('yyyy/MM/dd').format(DateTime.parse(userHistory.last['usedAt']))}',
            style: const TextStyle(color: Colors.grey),
          ),
        );
      },
    );
  }

  List<List<dynamic>> _groupHistoryByUser(List<dynamic> history) {
    // ユーザーIDでグループ化
    final map = <String, List<dynamic>>{};

    for (var item in history) {
      final userId = item['userId'] as String;
      map.putIfAbsent(userId, () => []).add(item);
    }

    // 使用日でソート（新しい順）
    final grouped = map.values.toList();
    for (var group in grouped) {
      group.sort((a, b) =>
          DateTime.parse(b['usedAt']).compareTo(DateTime.parse(a['usedAt'])));
    }

    grouped.sort((a, b) => DateTime.parse(b.last['usedAt'])
        .compareTo(DateTime.parse(a.last['usedAt'])));

    return grouped;
  }

  Widget _buildUserCard(dynamic item,
      {required Widget trailing, Widget? additionalInfo}) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage:
              NetworkImage(item['imgUrl'] ?? 'assets/logo_visualonly.jpg'),
          onBackgroundImageError: (_, __) {
            Image.asset('assets/logo_visualonly.jpg');
          },
        ),
        title: Text(item['username'] ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item['realname'] ?? ''),
            Text(item['email'] ?? ''),
            if (additionalInfo != null) additionalInfo,
          ],
        ),
        trailing: trailing,
      ),
    );
  }
}

// QRスキャナー用の新しいStatefulWidget
class _QRScannerScreen extends StatefulWidget {
  final String prizeId;
  final String representationUserId;

  const _QRScannerScreen({
    required this.prizeId,
    required this.representationUserId,
  });

  @override
  State<_QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<_QRScannerScreen> {
  late MobileScannerController cameraController;

  @override
  void initState() {
    super.initState();
    cameraController = MobileScannerController();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) async {
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final String? code = barcodes.first.rawValue;
      if (code != null) {
        try {
          final parts = code.split('|');
          if (parts.length == 2) {
            final userId = parts[0];
            final scannedPrizeId = parts[1];

            if (scannedPrizeId == widget.prizeId) {
              // BuildContextを使用する前にmountedチェック
              if (!mounted) return;

              // スキャナー画面を閉じて元の画面に戻る
              Navigator.of(context).pop();

              // 新しい画面遷移が完了するのを待つ
              await Future.microtask(() {});

              // 再度BuildContextを使用する前にmountedチェック
              if (!mounted) return;

              // QR専用の承認処理を実行
              await _approveRequestFromQR(
                context,
                userId,
                widget.representationUserId,
                scannedPrizeId,
              );
            }
          }
        } catch (e) {
          print('Error in QR scan: $e');
        }
      }
    }
  }

  // QRコードスキャン用の承認処理
  Future<void> _approveRequestFromQR(
    BuildContext context,
    String targetUserId,
    String representationUserId,
    String scannedPrizeId,
  ) async {
    try {
      final client = GraphQLProvider.of(context).value;
      final prizeIdInt = int.parse(scannedPrizeId);

      final result = await client.mutate(
        MutationOptions(
          document: gql('''
            mutation UsePrize(\$input: UsePrizeInput!) {
              usePrize(input: \$input) {
                id
              }
            }
          '''),
          variables: {
            'input': {
              'representationUserId': representationUserId,
              'userId': targetUserId,
              'prizeId': prizeIdInt,
            },
          },
        ),
      );

      if (result.hasException) {
        throw result.exception!;
      }

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('QRコードによる承認が完了しました')),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('QRコードによる承認に失敗しました'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QRコードをスキャン'),
      ),
      body: MobileScanner(
        controller: cameraController,
        onDetect: _onDetect,
      ),
    );
  }
}
