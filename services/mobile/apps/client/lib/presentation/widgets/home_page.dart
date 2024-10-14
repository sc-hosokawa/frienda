import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ferry/ferry.dart';
import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:client/presentation/providers/client_provider.dart';

import 'package:client/graphql/__generated__/schema.schema.gql.dart';
import 'package:client/graphql/query/__generated__/query.data.gql.dart';
import 'package:client/graphql/query/__generated__/query.req.gql.dart';
import 'package:client/graphql/query/__generated__/query.var.gql.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _isLoading = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Home Page'),
          ValueListenableBuilder<bool>(
            valueListenable: _isLoading,
            builder: (context, isLoading, child) {
              return ElevatedButton(
                onPressed:
                    isLoading ? null : () => _performHealthCheck(context),
                child: isLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text('ヘルスチェック実行'),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _performHealthCheck(BuildContext context) async {
    final clientAsync = ref.read(clientProvider);
    if (clientAsync == null) return;

    _isLoading.value = true;

    final healthCheckReq =
        GHealthCheckReq((b) => b..fetchPolicy = FetchPolicy.NoCache);
    try {
      final response = await clientAsync.request(healthCheckReq).first;
      if (response.hasErrors) {
        _showSnackBar(context, 'エラー: ${response.graphqlErrors}');
      } else {
        _showSnackBar(context, 'ヘルスチェック成功');
      }
    } catch (e) {
      _showSnackBar(context, '予期せぬエラー: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
