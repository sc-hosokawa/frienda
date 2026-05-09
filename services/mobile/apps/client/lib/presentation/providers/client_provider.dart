import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final graphQLClientProvider = Provider<GraphQLClient>((ref) {
  final apiUrl = const String.fromEnvironment('apiUrl');
  print('GraphQL API URL:::: $apiUrl');

  final httpLink = HttpLink(
    //'http://127.0.0.1:8080/graphql',
    apiUrl,
    defaultHeaders: {
      'Content-Type': 'application/json',
    },
  );

  final authLink = AuthLink(
    getToken: () async {
      final token = await FirebaseAuth.instance.currentUser?.getIdToken();
      return token != null ? 'Bearer $token' : null;
    },
  );
  final link = authLink.concat(httpLink);

  return GraphQLClient(
    link: link,
    cache: GraphQLCache(
      store: HiveStore(),
    ),
  );
});
