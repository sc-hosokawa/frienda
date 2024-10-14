import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ferry/ferry.dart';
import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:client/presentation/providers/client_provider.dart';
// ferry
import 'package:client/graphql/__generated__/schema.schema.gql.dart';
import 'package:client/graphql/query/__generated__/query.data.gql.dart';
import 'package:client/graphql/query/__generated__/query.req.gql.dart';
import 'package:client/graphql/query/__generated__/query.var.gql.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientAsync = ref.watch(clientProvider);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Home Page'),
          ElevatedButton(
            onPressed: () => _performHealthCheck(context, clientAsync),
            child: Text('ヘルスチェック実行'),
          ),
        ],
      ),
    );
  }

  void _performHealthCheck(
      BuildContext context, AsyncValue<Client> clientAsync) async {
    if (clientAsync.value == null) {
      _showSnackBar(context, 'クライアントが初期化されていません');
      return;
    }

    final healthCheckReq =
        GHealthCheckReq((b) => b..fetchPolicy = FetchPolicy.NoCache);
    try {
      await for (var response in clientAsync.value!.request(healthCheckReq)) {
        if (response.hasErrors) {
          _showSnackBar(context, 'エラー: ${response.graphqlErrors}');
        } else {
          _showSnackBar(context, 'ヘルスチェック成功');
        }
      }
    } catch (e) {
      _showSnackBar(context, '予期せぬエラー: $e');
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
