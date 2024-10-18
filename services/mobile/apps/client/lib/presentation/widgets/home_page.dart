import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ferry/ferry.dart';
import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:client/presentation/providers/client_provider.dart';

import 'package:client/data/graphql/__generated__/schema.schema.gql.dart';
import 'package:client/data/graphql/query/__generated__/query.data.gql.dart';
import 'package:client/data/graphql/query/__generated__/query.req.gql.dart';
import 'package:client/data/graphql/query/__generated__/query.var.gql.dart';
import 'package:client/data/model/health_check/health_check.dart';
import 'package:client/presentation/widgets/home/notifications.dart'; // Notificationsウィジェットをインポート

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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildActionsSection(),
          _buildNotificationsSection(),
          _buildNewsSection(),
        ],
      ),
    );
  }

  Widget _buildActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Actions', style: Theme.of(context).textTheme.titleSmall),
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.only(left: 16, right: index == 4 ? 16 : 0),
                child: SizedBox(
                  width: 100,
                  child: Center(child: Text('Action ${index + 1}')),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Notifications',
                  style: Theme.of(context).textTheme.titleSmall),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Notifications()),
                  );
                },
                child: Text('View all'),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Notification ${index + 1}'),
              subtitle: Text('This is a notification description'),
            );
          },
        ),
      ],
    );
  }

  Widget _buildNewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('News', style: Theme.of(context).textTheme.titleSmall),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5, // 仮のアイテム数
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.only(left: 16, right: index == 4 ? 16 : 0),
                child: SizedBox(
                  width: 300,
                  child: Center(child: Text('News ${index + 1}')),
                ),
              );
            },
          ),
        ),
      ],
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
        final healthcheck =
            Healthcheck.fromJson(response.data!.healthCheck.toJson());
        _showSnackBar(context, 'ステータス: ${healthcheck.status}');
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
