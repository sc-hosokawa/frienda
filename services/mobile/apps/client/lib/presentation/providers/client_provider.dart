import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:http/io_client.dart';
// import 'package:client/presentation/providers/auth_provider.dart';

class TimeoutHttpClient extends http.BaseClient {
  final Duration timeout;
  late final http.Client _inner;

  TimeoutHttpClient({required this.timeout}) {
    final ioClient = HttpClient();
    ioClient.connectionTimeout = timeout;
    _inner = IOClient(ioClient);
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _inner.send(request).timeout(timeout);
  }
}

final graphQLClientProvider = Provider<GraphQLClient>((ref) {
  // 認証トークンプロバイダーなどから token を取得
  // final token = ref.watch(authTokenProvider);

  final httpLink = HttpLink(
    //'http://127.0.0.1:8080/graphql',
    'https://frienda-server-962498306731.asia-northeast1.run.app/graphql',
    httpClient: TimeoutHttpClient(timeout: const Duration(seconds: 30)),
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
