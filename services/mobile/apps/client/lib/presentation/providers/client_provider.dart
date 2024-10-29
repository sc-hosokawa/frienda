import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:ferry/ferry.dart';
import 'package:ferry_hive_store/ferry_hive_store.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/data/graphql/__generated__/schema.schema.gql.dart';

final clientProvider = StateProvider<Client?>((ref) => null);

Future<Client> initClient() async {
  await Hive.initFlutter();
  final box = await Hive.openBox('graphql');
  final store = HiveStore(box);
  final cache = Cache(store: store, possibleTypes: possibleTypesMap);
  final link = HttpLink(
      'https://frienda-server-962498306731.asia-northeast1.run.app/graphql');
  final client = Client(link: link, cache: cache);
  return client;
}
