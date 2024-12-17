import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:http/io_client.dart';
// import 'package:client/presentation/providers/auth_provider.dart';

final graphQLClientProvider = Provider<GraphQLClient>((ref) {
  // 認証トークンプロバイダーなどから token を取得
  // final token = ref.watch(authTokenProvider);

  final httpLink = HttpLink(
    //'http://127.0.0.1:8080/graphql',
    'https://frienda-server-962498306731.asia-northeast1.run.app/graphql',
    defaultHeaders: {
      'Content-Type': 'application/json',
    },
  );

/*
  final authLink = AuthLink(
    getToken: () async => token != null ? 'Bearer $token' : null,
  );
  final link = authLink.concat(httpLink);
  */

  return GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(
      store: HiveStore(),
    ),
  );
});
