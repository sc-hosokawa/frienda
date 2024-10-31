import 'dart:async';
import 'package:flutter/widgets.dart' as widgets;
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:graphql_flutter/graphql_flutter.dart' as graphql_flutter;
import 'schema.graphql.dart';

class Query$HealthCheck {
  Query$HealthCheck({
    required this.healthCheck,
    this.$__typename = 'QueryRoot',
  });

  factory Query$HealthCheck.fromJson(Map<String, dynamic> json) {
    final l$healthCheck = json['healthCheck'];
    final l$$__typename = json['__typename'];
    return Query$HealthCheck(
      healthCheck: Query$HealthCheck$healthCheck.fromJson(
          (l$healthCheck as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$HealthCheck$healthCheck healthCheck;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$healthCheck = healthCheck;
    _resultData['healthCheck'] = l$healthCheck.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$healthCheck = healthCheck;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$healthCheck,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$HealthCheck) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$healthCheck = healthCheck;
    final lOther$healthCheck = other.healthCheck;
    if (l$healthCheck != lOther$healthCheck) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$HealthCheck on Query$HealthCheck {
  CopyWith$Query$HealthCheck<Query$HealthCheck> get copyWith =>
      CopyWith$Query$HealthCheck(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$HealthCheck<TRes> {
  factory CopyWith$Query$HealthCheck(
    Query$HealthCheck instance,
    TRes Function(Query$HealthCheck) then,
  ) = _CopyWithImpl$Query$HealthCheck;

  factory CopyWith$Query$HealthCheck.stub(TRes res) =
      _CopyWithStubImpl$Query$HealthCheck;

  TRes call({
    Query$HealthCheck$healthCheck? healthCheck,
    String? $__typename,
  });
  CopyWith$Query$HealthCheck$healthCheck<TRes> get healthCheck;
}

class _CopyWithImpl$Query$HealthCheck<TRes>
    implements CopyWith$Query$HealthCheck<TRes> {
  _CopyWithImpl$Query$HealthCheck(
    this._instance,
    this._then,
  );

  final Query$HealthCheck _instance;

  final TRes Function(Query$HealthCheck) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? healthCheck = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$HealthCheck(
        healthCheck: healthCheck == _undefined || healthCheck == null
            ? _instance.healthCheck
            : (healthCheck as Query$HealthCheck$healthCheck),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$HealthCheck$healthCheck<TRes> get healthCheck {
    final local$healthCheck = _instance.healthCheck;
    return CopyWith$Query$HealthCheck$healthCheck(
        local$healthCheck, (e) => call(healthCheck: e));
  }
}

class _CopyWithStubImpl$Query$HealthCheck<TRes>
    implements CopyWith$Query$HealthCheck<TRes> {
  _CopyWithStubImpl$Query$HealthCheck(this._res);

  TRes _res;

  call({
    Query$HealthCheck$healthCheck? healthCheck,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$HealthCheck$healthCheck<TRes> get healthCheck =>
      CopyWith$Query$HealthCheck$healthCheck.stub(_res);
}

const documentNodeQueryHealthCheck = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'HealthCheck'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'healthCheck'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'status'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$HealthCheck _parserFn$Query$HealthCheck(Map<String, dynamic> data) =>
    Query$HealthCheck.fromJson(data);
typedef OnQueryComplete$Query$HealthCheck = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$HealthCheck?,
);

class Options$Query$HealthCheck
    extends graphql.QueryOptions<Query$HealthCheck> {
  Options$Query$HealthCheck({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$HealthCheck? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$HealthCheck? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null ? null : _parserFn$Query$HealthCheck(data),
                  ),
          onError: onError,
          document: documentNodeQueryHealthCheck,
          parserFn: _parserFn$Query$HealthCheck,
        );

  final OnQueryComplete$Query$HealthCheck? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$HealthCheck
    extends graphql.WatchQueryOptions<Query$HealthCheck> {
  WatchOptions$Query$HealthCheck({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$HealthCheck? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryHealthCheck,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$HealthCheck,
        );
}

class FetchMoreOptions$Query$HealthCheck extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$HealthCheck({required graphql.UpdateQuery updateQuery})
      : super(
          updateQuery: updateQuery,
          document: documentNodeQueryHealthCheck,
        );
}

extension ClientExtension$Query$HealthCheck on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$HealthCheck>> query$HealthCheck(
          [Options$Query$HealthCheck? options]) async =>
      await this.query(options ?? Options$Query$HealthCheck());
  graphql.ObservableQuery<Query$HealthCheck> watchQuery$HealthCheck(
          [WatchOptions$Query$HealthCheck? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$HealthCheck());
  void writeQuery$HealthCheck({
    required Query$HealthCheck data,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
            operation:
                graphql.Operation(document: documentNodeQueryHealthCheck)),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$HealthCheck? readQuery$HealthCheck({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
          operation: graphql.Operation(document: documentNodeQueryHealthCheck)),
      optimistic: optimistic,
    );
    return result == null ? null : Query$HealthCheck.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$HealthCheck> useQuery$HealthCheck(
        [Options$Query$HealthCheck? options]) =>
    graphql_flutter.useQuery(options ?? Options$Query$HealthCheck());
graphql.ObservableQuery<Query$HealthCheck> useWatchQuery$HealthCheck(
        [WatchOptions$Query$HealthCheck? options]) =>
    graphql_flutter.useWatchQuery(options ?? WatchOptions$Query$HealthCheck());

class Query$HealthCheck$Widget
    extends graphql_flutter.Query<Query$HealthCheck> {
  Query$HealthCheck$Widget({
    widgets.Key? key,
    Options$Query$HealthCheck? options,
    required graphql_flutter.QueryBuilder<Query$HealthCheck> builder,
  }) : super(
          key: key,
          options: options ?? Options$Query$HealthCheck(),
          builder: builder,
        );
}

class Query$HealthCheck$healthCheck {
  Query$HealthCheck$healthCheck({
    required this.status,
    this.$__typename = 'HealthCheck',
  });

  factory Query$HealthCheck$healthCheck.fromJson(Map<String, dynamic> json) {
    final l$status = json['status'];
    final l$$__typename = json['__typename'];
    return Query$HealthCheck$healthCheck(
      status: (l$status as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String status;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$status = status;
    _resultData['status'] = l$status;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$status = status;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$status,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$HealthCheck$healthCheck) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$HealthCheck$healthCheck
    on Query$HealthCheck$healthCheck {
  CopyWith$Query$HealthCheck$healthCheck<Query$HealthCheck$healthCheck>
      get copyWith => CopyWith$Query$HealthCheck$healthCheck(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$HealthCheck$healthCheck<TRes> {
  factory CopyWith$Query$HealthCheck$healthCheck(
    Query$HealthCheck$healthCheck instance,
    TRes Function(Query$HealthCheck$healthCheck) then,
  ) = _CopyWithImpl$Query$HealthCheck$healthCheck;

  factory CopyWith$Query$HealthCheck$healthCheck.stub(TRes res) =
      _CopyWithStubImpl$Query$HealthCheck$healthCheck;

  TRes call({
    String? status,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$HealthCheck$healthCheck<TRes>
    implements CopyWith$Query$HealthCheck$healthCheck<TRes> {
  _CopyWithImpl$Query$HealthCheck$healthCheck(
    this._instance,
    this._then,
  );

  final Query$HealthCheck$healthCheck _instance;

  final TRes Function(Query$HealthCheck$healthCheck) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? status = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$HealthCheck$healthCheck(
        status: status == _undefined || status == null
            ? _instance.status
            : (status as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$HealthCheck$healthCheck<TRes>
    implements CopyWith$Query$HealthCheck$healthCheck<TRes> {
  _CopyWithStubImpl$Query$HealthCheck$healthCheck(this._res);

  TRes _res;

  call({
    String? status,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Query$GetOverviewData {
  factory Variables$Query$GetOverviewData({String? artistId}) =>
      Variables$Query$GetOverviewData._({
        if (artistId != null) r'artistId': artistId,
      });

  Variables$Query$GetOverviewData._(this._$data);

  factory Variables$Query$GetOverviewData.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('artistId')) {
      final l$artistId = data['artistId'];
      result$data['artistId'] = (l$artistId as String?);
    }
    return Variables$Query$GetOverviewData._(result$data);
  }

  Map<String, dynamic> _$data;

  String? get artistId => (_$data['artistId'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('artistId')) {
      final l$artistId = artistId;
      result$data['artistId'] = l$artistId;
    }
    return result$data;
  }

  CopyWith$Variables$Query$GetOverviewData<Variables$Query$GetOverviewData>
      get copyWith => CopyWith$Variables$Query$GetOverviewData(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$GetOverviewData) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$artistId = artistId;
    final lOther$artistId = other.artistId;
    if (_$data.containsKey('artistId') !=
        other._$data.containsKey('artistId')) {
      return false;
    }
    if (l$artistId != lOther$artistId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$artistId = artistId;
    return Object.hashAll(
        [_$data.containsKey('artistId') ? l$artistId : const {}]);
  }
}

abstract class CopyWith$Variables$Query$GetOverviewData<TRes> {
  factory CopyWith$Variables$Query$GetOverviewData(
    Variables$Query$GetOverviewData instance,
    TRes Function(Variables$Query$GetOverviewData) then,
  ) = _CopyWithImpl$Variables$Query$GetOverviewData;

  factory CopyWith$Variables$Query$GetOverviewData.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$GetOverviewData;

  TRes call({String? artistId});
}

class _CopyWithImpl$Variables$Query$GetOverviewData<TRes>
    implements CopyWith$Variables$Query$GetOverviewData<TRes> {
  _CopyWithImpl$Variables$Query$GetOverviewData(
    this._instance,
    this._then,
  );

  final Variables$Query$GetOverviewData _instance;

  final TRes Function(Variables$Query$GetOverviewData) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? artistId = _undefined}) =>
      _then(Variables$Query$GetOverviewData._({
        ..._instance._$data,
        if (artistId != _undefined) 'artistId': (artistId as String?),
      }));
}

class _CopyWithStubImpl$Variables$Query$GetOverviewData<TRes>
    implements CopyWith$Variables$Query$GetOverviewData<TRes> {
  _CopyWithStubImpl$Variables$Query$GetOverviewData(this._res);

  TRes _res;

  call({String? artistId}) => _res;
}

class Query$GetOverviewData {
  Query$GetOverviewData({
    required this.getOverviewData,
    this.$__typename = 'QueryRoot',
  });

  factory Query$GetOverviewData.fromJson(Map<String, dynamic> json) {
    final l$getOverviewData = json['getOverviewData'];
    final l$$__typename = json['__typename'];
    return Query$GetOverviewData(
      getOverviewData: Query$GetOverviewData$getOverviewData.fromJson(
          (l$getOverviewData as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetOverviewData$getOverviewData getOverviewData;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getOverviewData = getOverviewData;
    _resultData['getOverviewData'] = l$getOverviewData.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getOverviewData = getOverviewData;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$getOverviewData,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetOverviewData) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$getOverviewData = getOverviewData;
    final lOther$getOverviewData = other.getOverviewData;
    if (l$getOverviewData != lOther$getOverviewData) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetOverviewData on Query$GetOverviewData {
  CopyWith$Query$GetOverviewData<Query$GetOverviewData> get copyWith =>
      CopyWith$Query$GetOverviewData(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetOverviewData<TRes> {
  factory CopyWith$Query$GetOverviewData(
    Query$GetOverviewData instance,
    TRes Function(Query$GetOverviewData) then,
  ) = _CopyWithImpl$Query$GetOverviewData;

  factory CopyWith$Query$GetOverviewData.stub(TRes res) =
      _CopyWithStubImpl$Query$GetOverviewData;

  TRes call({
    Query$GetOverviewData$getOverviewData? getOverviewData,
    String? $__typename,
  });
  CopyWith$Query$GetOverviewData$getOverviewData<TRes> get getOverviewData;
}

class _CopyWithImpl$Query$GetOverviewData<TRes>
    implements CopyWith$Query$GetOverviewData<TRes> {
  _CopyWithImpl$Query$GetOverviewData(
    this._instance,
    this._then,
  );

  final Query$GetOverviewData _instance;

  final TRes Function(Query$GetOverviewData) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getOverviewData = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetOverviewData(
        getOverviewData:
            getOverviewData == _undefined || getOverviewData == null
                ? _instance.getOverviewData
                : (getOverviewData as Query$GetOverviewData$getOverviewData),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetOverviewData$getOverviewData<TRes> get getOverviewData {
    final local$getOverviewData = _instance.getOverviewData;
    return CopyWith$Query$GetOverviewData$getOverviewData(
        local$getOverviewData, (e) => call(getOverviewData: e));
  }
}

class _CopyWithStubImpl$Query$GetOverviewData<TRes>
    implements CopyWith$Query$GetOverviewData<TRes> {
  _CopyWithStubImpl$Query$GetOverviewData(this._res);

  TRes _res;

  call({
    Query$GetOverviewData$getOverviewData? getOverviewData,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetOverviewData$getOverviewData<TRes> get getOverviewData =>
      CopyWith$Query$GetOverviewData$getOverviewData.stub(_res);
}

const documentNodeQueryGetOverviewData = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetOverviewData'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'artistId')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'getOverviewData'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'artistId'),
            value: VariableNode(name: NameNode(value: 'artistId')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'totalPlaybacks'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'weeklyPlaybacks'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$GetOverviewData _parserFn$Query$GetOverviewData(
        Map<String, dynamic> data) =>
    Query$GetOverviewData.fromJson(data);
typedef OnQueryComplete$Query$GetOverviewData = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$GetOverviewData?,
);

class Options$Query$GetOverviewData
    extends graphql.QueryOptions<Query$GetOverviewData> {
  Options$Query$GetOverviewData({
    String? operationName,
    Variables$Query$GetOverviewData? variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetOverviewData? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetOverviewData? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          variables: variables?.toJson() ?? {},
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null ? null : _parserFn$Query$GetOverviewData(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetOverviewData,
          parserFn: _parserFn$Query$GetOverviewData,
        );

  final OnQueryComplete$Query$GetOverviewData? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetOverviewData
    extends graphql.WatchQueryOptions<Query$GetOverviewData> {
  WatchOptions$Query$GetOverviewData({
    String? operationName,
    Variables$Query$GetOverviewData? variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetOverviewData? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables?.toJson() ?? {},
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryGetOverviewData,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetOverviewData,
        );
}

class FetchMoreOptions$Query$GetOverviewData extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetOverviewData({
    required graphql.UpdateQuery updateQuery,
    Variables$Query$GetOverviewData? variables,
  }) : super(
          updateQuery: updateQuery,
          variables: variables?.toJson() ?? {},
          document: documentNodeQueryGetOverviewData,
        );
}

extension ClientExtension$Query$GetOverviewData on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetOverviewData>> query$GetOverviewData(
          [Options$Query$GetOverviewData? options]) async =>
      await this.query(options ?? Options$Query$GetOverviewData());
  graphql.ObservableQuery<Query$GetOverviewData> watchQuery$GetOverviewData(
          [WatchOptions$Query$GetOverviewData? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$GetOverviewData());
  void writeQuery$GetOverviewData({
    required Query$GetOverviewData data,
    Variables$Query$GetOverviewData? variables,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
          operation:
              graphql.Operation(document: documentNodeQueryGetOverviewData),
          variables: variables?.toJson() ?? const {},
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetOverviewData? readQuery$GetOverviewData({
    Variables$Query$GetOverviewData? variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation:
            graphql.Operation(document: documentNodeQueryGetOverviewData),
        variables: variables?.toJson() ?? const {},
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetOverviewData.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetOverviewData> useQuery$GetOverviewData(
        [Options$Query$GetOverviewData? options]) =>
    graphql_flutter.useQuery(options ?? Options$Query$GetOverviewData());
graphql.ObservableQuery<Query$GetOverviewData> useWatchQuery$GetOverviewData(
        [WatchOptions$Query$GetOverviewData? options]) =>
    graphql_flutter
        .useWatchQuery(options ?? WatchOptions$Query$GetOverviewData());

class Query$GetOverviewData$Widget
    extends graphql_flutter.Query<Query$GetOverviewData> {
  Query$GetOverviewData$Widget({
    widgets.Key? key,
    Options$Query$GetOverviewData? options,
    required graphql_flutter.QueryBuilder<Query$GetOverviewData> builder,
  }) : super(
          key: key,
          options: options ?? Options$Query$GetOverviewData(),
          builder: builder,
        );
}

class Query$GetOverviewData$getOverviewData {
  Query$GetOverviewData$getOverviewData({
    required this.totalPlaybacks,
    required this.weeklyPlaybacks,
    this.$__typename = 'TotalOverviewData',
  });

  factory Query$GetOverviewData$getOverviewData.fromJson(
      Map<String, dynamic> json) {
    final l$totalPlaybacks = json['totalPlaybacks'];
    final l$weeklyPlaybacks = json['weeklyPlaybacks'];
    final l$$__typename = json['__typename'];
    return Query$GetOverviewData$getOverviewData(
      totalPlaybacks: (l$totalPlaybacks as int),
      weeklyPlaybacks: (l$weeklyPlaybacks as int),
      $__typename: (l$$__typename as String),
    );
  }

  final int totalPlaybacks;

  final int weeklyPlaybacks;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$totalPlaybacks = totalPlaybacks;
    _resultData['totalPlaybacks'] = l$totalPlaybacks;
    final l$weeklyPlaybacks = weeklyPlaybacks;
    _resultData['weeklyPlaybacks'] = l$weeklyPlaybacks;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$totalPlaybacks = totalPlaybacks;
    final l$weeklyPlaybacks = weeklyPlaybacks;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$totalPlaybacks,
      l$weeklyPlaybacks,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetOverviewData$getOverviewData) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$totalPlaybacks = totalPlaybacks;
    final lOther$totalPlaybacks = other.totalPlaybacks;
    if (l$totalPlaybacks != lOther$totalPlaybacks) {
      return false;
    }
    final l$weeklyPlaybacks = weeklyPlaybacks;
    final lOther$weeklyPlaybacks = other.weeklyPlaybacks;
    if (l$weeklyPlaybacks != lOther$weeklyPlaybacks) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetOverviewData$getOverviewData
    on Query$GetOverviewData$getOverviewData {
  CopyWith$Query$GetOverviewData$getOverviewData<
          Query$GetOverviewData$getOverviewData>
      get copyWith => CopyWith$Query$GetOverviewData$getOverviewData(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetOverviewData$getOverviewData<TRes> {
  factory CopyWith$Query$GetOverviewData$getOverviewData(
    Query$GetOverviewData$getOverviewData instance,
    TRes Function(Query$GetOverviewData$getOverviewData) then,
  ) = _CopyWithImpl$Query$GetOverviewData$getOverviewData;

  factory CopyWith$Query$GetOverviewData$getOverviewData.stub(TRes res) =
      _CopyWithStubImpl$Query$GetOverviewData$getOverviewData;

  TRes call({
    int? totalPlaybacks,
    int? weeklyPlaybacks,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetOverviewData$getOverviewData<TRes>
    implements CopyWith$Query$GetOverviewData$getOverviewData<TRes> {
  _CopyWithImpl$Query$GetOverviewData$getOverviewData(
    this._instance,
    this._then,
  );

  final Query$GetOverviewData$getOverviewData _instance;

  final TRes Function(Query$GetOverviewData$getOverviewData) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? totalPlaybacks = _undefined,
    Object? weeklyPlaybacks = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetOverviewData$getOverviewData(
        totalPlaybacks: totalPlaybacks == _undefined || totalPlaybacks == null
            ? _instance.totalPlaybacks
            : (totalPlaybacks as int),
        weeklyPlaybacks:
            weeklyPlaybacks == _undefined || weeklyPlaybacks == null
                ? _instance.weeklyPlaybacks
                : (weeklyPlaybacks as int),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetOverviewData$getOverviewData<TRes>
    implements CopyWith$Query$GetOverviewData$getOverviewData<TRes> {
  _CopyWithStubImpl$Query$GetOverviewData$getOverviewData(this._res);

  TRes _res;

  call({
    int? totalPlaybacks,
    int? weeklyPlaybacks,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Query$GetTrendingData {
  factory Variables$Query$GetTrendingData({String? artistId}) =>
      Variables$Query$GetTrendingData._({
        if (artistId != null) r'artistId': artistId,
      });

  Variables$Query$GetTrendingData._(this._$data);

  factory Variables$Query$GetTrendingData.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('artistId')) {
      final l$artistId = data['artistId'];
      result$data['artistId'] = (l$artistId as String?);
    }
    return Variables$Query$GetTrendingData._(result$data);
  }

  Map<String, dynamic> _$data;

  String? get artistId => (_$data['artistId'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('artistId')) {
      final l$artistId = artistId;
      result$data['artistId'] = l$artistId;
    }
    return result$data;
  }

  CopyWith$Variables$Query$GetTrendingData<Variables$Query$GetTrendingData>
      get copyWith => CopyWith$Variables$Query$GetTrendingData(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$GetTrendingData) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$artistId = artistId;
    final lOther$artistId = other.artistId;
    if (_$data.containsKey('artistId') !=
        other._$data.containsKey('artistId')) {
      return false;
    }
    if (l$artistId != lOther$artistId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$artistId = artistId;
    return Object.hashAll(
        [_$data.containsKey('artistId') ? l$artistId : const {}]);
  }
}

abstract class CopyWith$Variables$Query$GetTrendingData<TRes> {
  factory CopyWith$Variables$Query$GetTrendingData(
    Variables$Query$GetTrendingData instance,
    TRes Function(Variables$Query$GetTrendingData) then,
  ) = _CopyWithImpl$Variables$Query$GetTrendingData;

  factory CopyWith$Variables$Query$GetTrendingData.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$GetTrendingData;

  TRes call({String? artistId});
}

class _CopyWithImpl$Variables$Query$GetTrendingData<TRes>
    implements CopyWith$Variables$Query$GetTrendingData<TRes> {
  _CopyWithImpl$Variables$Query$GetTrendingData(
    this._instance,
    this._then,
  );

  final Variables$Query$GetTrendingData _instance;

  final TRes Function(Variables$Query$GetTrendingData) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? artistId = _undefined}) =>
      _then(Variables$Query$GetTrendingData._({
        ..._instance._$data,
        if (artistId != _undefined) 'artistId': (artistId as String?),
      }));
}

class _CopyWithStubImpl$Variables$Query$GetTrendingData<TRes>
    implements CopyWith$Variables$Query$GetTrendingData<TRes> {
  _CopyWithStubImpl$Variables$Query$GetTrendingData(this._res);

  TRes _res;

  call({String? artistId}) => _res;
}

class Query$GetTrendingData {
  Query$GetTrendingData({
    required this.getTrendingData,
    this.$__typename = 'QueryRoot',
  });

  factory Query$GetTrendingData.fromJson(Map<String, dynamic> json) {
    final l$getTrendingData = json['getTrendingData'];
    final l$$__typename = json['__typename'];
    return Query$GetTrendingData(
      getTrendingData: Query$GetTrendingData$getTrendingData.fromJson(
          (l$getTrendingData as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetTrendingData$getTrendingData getTrendingData;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getTrendingData = getTrendingData;
    _resultData['getTrendingData'] = l$getTrendingData.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getTrendingData = getTrendingData;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$getTrendingData,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetTrendingData) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$getTrendingData = getTrendingData;
    final lOther$getTrendingData = other.getTrendingData;
    if (l$getTrendingData != lOther$getTrendingData) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetTrendingData on Query$GetTrendingData {
  CopyWith$Query$GetTrendingData<Query$GetTrendingData> get copyWith =>
      CopyWith$Query$GetTrendingData(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetTrendingData<TRes> {
  factory CopyWith$Query$GetTrendingData(
    Query$GetTrendingData instance,
    TRes Function(Query$GetTrendingData) then,
  ) = _CopyWithImpl$Query$GetTrendingData;

  factory CopyWith$Query$GetTrendingData.stub(TRes res) =
      _CopyWithStubImpl$Query$GetTrendingData;

  TRes call({
    Query$GetTrendingData$getTrendingData? getTrendingData,
    String? $__typename,
  });
  CopyWith$Query$GetTrendingData$getTrendingData<TRes> get getTrendingData;
}

class _CopyWithImpl$Query$GetTrendingData<TRes>
    implements CopyWith$Query$GetTrendingData<TRes> {
  _CopyWithImpl$Query$GetTrendingData(
    this._instance,
    this._then,
  );

  final Query$GetTrendingData _instance;

  final TRes Function(Query$GetTrendingData) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getTrendingData = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetTrendingData(
        getTrendingData:
            getTrendingData == _undefined || getTrendingData == null
                ? _instance.getTrendingData
                : (getTrendingData as Query$GetTrendingData$getTrendingData),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetTrendingData$getTrendingData<TRes> get getTrendingData {
    final local$getTrendingData = _instance.getTrendingData;
    return CopyWith$Query$GetTrendingData$getTrendingData(
        local$getTrendingData, (e) => call(getTrendingData: e));
  }
}

class _CopyWithStubImpl$Query$GetTrendingData<TRes>
    implements CopyWith$Query$GetTrendingData<TRes> {
  _CopyWithStubImpl$Query$GetTrendingData(this._res);

  TRes _res;

  call({
    Query$GetTrendingData$getTrendingData? getTrendingData,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetTrendingData$getTrendingData<TRes> get getTrendingData =>
      CopyWith$Query$GetTrendingData$getTrendingData.stub(_res);
}

const documentNodeQueryGetTrendingData = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetTrendingData'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'artistId')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'getTrendingData'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'artistId'),
            value: VariableNode(name: NameNode(value: 'artistId')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'trendingTracks'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'isrc'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'imgUrl'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'title'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$GetTrendingData _parserFn$Query$GetTrendingData(
        Map<String, dynamic> data) =>
    Query$GetTrendingData.fromJson(data);
typedef OnQueryComplete$Query$GetTrendingData = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$GetTrendingData?,
);

class Options$Query$GetTrendingData
    extends graphql.QueryOptions<Query$GetTrendingData> {
  Options$Query$GetTrendingData({
    String? operationName,
    Variables$Query$GetTrendingData? variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetTrendingData? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetTrendingData? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          variables: variables?.toJson() ?? {},
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null ? null : _parserFn$Query$GetTrendingData(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetTrendingData,
          parserFn: _parserFn$Query$GetTrendingData,
        );

  final OnQueryComplete$Query$GetTrendingData? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetTrendingData
    extends graphql.WatchQueryOptions<Query$GetTrendingData> {
  WatchOptions$Query$GetTrendingData({
    String? operationName,
    Variables$Query$GetTrendingData? variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetTrendingData? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables?.toJson() ?? {},
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryGetTrendingData,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetTrendingData,
        );
}

class FetchMoreOptions$Query$GetTrendingData extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetTrendingData({
    required graphql.UpdateQuery updateQuery,
    Variables$Query$GetTrendingData? variables,
  }) : super(
          updateQuery: updateQuery,
          variables: variables?.toJson() ?? {},
          document: documentNodeQueryGetTrendingData,
        );
}

extension ClientExtension$Query$GetTrendingData on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetTrendingData>> query$GetTrendingData(
          [Options$Query$GetTrendingData? options]) async =>
      await this.query(options ?? Options$Query$GetTrendingData());
  graphql.ObservableQuery<Query$GetTrendingData> watchQuery$GetTrendingData(
          [WatchOptions$Query$GetTrendingData? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$GetTrendingData());
  void writeQuery$GetTrendingData({
    required Query$GetTrendingData data,
    Variables$Query$GetTrendingData? variables,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
          operation:
              graphql.Operation(document: documentNodeQueryGetTrendingData),
          variables: variables?.toJson() ?? const {},
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetTrendingData? readQuery$GetTrendingData({
    Variables$Query$GetTrendingData? variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation:
            graphql.Operation(document: documentNodeQueryGetTrendingData),
        variables: variables?.toJson() ?? const {},
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetTrendingData.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetTrendingData> useQuery$GetTrendingData(
        [Options$Query$GetTrendingData? options]) =>
    graphql_flutter.useQuery(options ?? Options$Query$GetTrendingData());
graphql.ObservableQuery<Query$GetTrendingData> useWatchQuery$GetTrendingData(
        [WatchOptions$Query$GetTrendingData? options]) =>
    graphql_flutter
        .useWatchQuery(options ?? WatchOptions$Query$GetTrendingData());

class Query$GetTrendingData$Widget
    extends graphql_flutter.Query<Query$GetTrendingData> {
  Query$GetTrendingData$Widget({
    widgets.Key? key,
    Options$Query$GetTrendingData? options,
    required graphql_flutter.QueryBuilder<Query$GetTrendingData> builder,
  }) : super(
          key: key,
          options: options ?? Options$Query$GetTrendingData(),
          builder: builder,
        );
}

class Query$GetTrendingData$getTrendingData {
  Query$GetTrendingData$getTrendingData({
    required this.trendingTracks,
    this.$__typename = 'TrendingData',
  });

  factory Query$GetTrendingData$getTrendingData.fromJson(
      Map<String, dynamic> json) {
    final l$trendingTracks = json['trendingTracks'];
    final l$$__typename = json['__typename'];
    return Query$GetTrendingData$getTrendingData(
      trendingTracks: (l$trendingTracks as List<dynamic>)
          .map((e) =>
              Query$GetTrendingData$getTrendingData$trendingTracks.fromJson(
                  (e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$GetTrendingData$getTrendingData$trendingTracks>
      trendingTracks;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$trendingTracks = trendingTracks;
    _resultData['trendingTracks'] =
        l$trendingTracks.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$trendingTracks = trendingTracks;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$trendingTracks.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetTrendingData$getTrendingData) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$trendingTracks = trendingTracks;
    final lOther$trendingTracks = other.trendingTracks;
    if (l$trendingTracks.length != lOther$trendingTracks.length) {
      return false;
    }
    for (int i = 0; i < l$trendingTracks.length; i++) {
      final l$trendingTracks$entry = l$trendingTracks[i];
      final lOther$trendingTracks$entry = lOther$trendingTracks[i];
      if (l$trendingTracks$entry != lOther$trendingTracks$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetTrendingData$getTrendingData
    on Query$GetTrendingData$getTrendingData {
  CopyWith$Query$GetTrendingData$getTrendingData<
          Query$GetTrendingData$getTrendingData>
      get copyWith => CopyWith$Query$GetTrendingData$getTrendingData(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetTrendingData$getTrendingData<TRes> {
  factory CopyWith$Query$GetTrendingData$getTrendingData(
    Query$GetTrendingData$getTrendingData instance,
    TRes Function(Query$GetTrendingData$getTrendingData) then,
  ) = _CopyWithImpl$Query$GetTrendingData$getTrendingData;

  factory CopyWith$Query$GetTrendingData$getTrendingData.stub(TRes res) =
      _CopyWithStubImpl$Query$GetTrendingData$getTrendingData;

  TRes call({
    List<Query$GetTrendingData$getTrendingData$trendingTracks>? trendingTracks,
    String? $__typename,
  });
  TRes trendingTracks(
      Iterable<Query$GetTrendingData$getTrendingData$trendingTracks> Function(
              Iterable<
                  CopyWith$Query$GetTrendingData$getTrendingData$trendingTracks<
                      Query$GetTrendingData$getTrendingData$trendingTracks>>)
          _fn);
}

class _CopyWithImpl$Query$GetTrendingData$getTrendingData<TRes>
    implements CopyWith$Query$GetTrendingData$getTrendingData<TRes> {
  _CopyWithImpl$Query$GetTrendingData$getTrendingData(
    this._instance,
    this._then,
  );

  final Query$GetTrendingData$getTrendingData _instance;

  final TRes Function(Query$GetTrendingData$getTrendingData) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? trendingTracks = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetTrendingData$getTrendingData(
        trendingTracks: trendingTracks == _undefined || trendingTracks == null
            ? _instance.trendingTracks
            : (trendingTracks
                as List<Query$GetTrendingData$getTrendingData$trendingTracks>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes trendingTracks(
          Iterable<Query$GetTrendingData$getTrendingData$trendingTracks> Function(
                  Iterable<
                      CopyWith$Query$GetTrendingData$getTrendingData$trendingTracks<
                          Query$GetTrendingData$getTrendingData$trendingTracks>>)
              _fn) =>
      call(
          trendingTracks: _fn(_instance.trendingTracks.map((e) =>
              CopyWith$Query$GetTrendingData$getTrendingData$trendingTracks(
                e,
                (i) => i,
              ))).toList());
}

class _CopyWithStubImpl$Query$GetTrendingData$getTrendingData<TRes>
    implements CopyWith$Query$GetTrendingData$getTrendingData<TRes> {
  _CopyWithStubImpl$Query$GetTrendingData$getTrendingData(this._res);

  TRes _res;

  call({
    List<Query$GetTrendingData$getTrendingData$trendingTracks>? trendingTracks,
    String? $__typename,
  }) =>
      _res;

  trendingTracks(_fn) => _res;
}

class Query$GetTrendingData$getTrendingData$trendingTracks {
  Query$GetTrendingData$getTrendingData$trendingTracks({
    required this.isrc,
    this.imgUrl,
    required this.title,
    this.$__typename = 'TrackData',
  });

  factory Query$GetTrendingData$getTrendingData$trendingTracks.fromJson(
      Map<String, dynamic> json) {
    final l$isrc = json['isrc'];
    final l$imgUrl = json['imgUrl'];
    final l$title = json['title'];
    final l$$__typename = json['__typename'];
    return Query$GetTrendingData$getTrendingData$trendingTracks(
      isrc: (l$isrc as String),
      imgUrl: (l$imgUrl as String?),
      title: (l$title as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String isrc;

  final String? imgUrl;

  final String title;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$isrc = isrc;
    _resultData['isrc'] = l$isrc;
    final l$imgUrl = imgUrl;
    _resultData['imgUrl'] = l$imgUrl;
    final l$title = title;
    _resultData['title'] = l$title;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$isrc = isrc;
    final l$imgUrl = imgUrl;
    final l$title = title;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$isrc,
      l$imgUrl,
      l$title,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetTrendingData$getTrendingData$trendingTracks) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$isrc = isrc;
    final lOther$isrc = other.isrc;
    if (l$isrc != lOther$isrc) {
      return false;
    }
    final l$imgUrl = imgUrl;
    final lOther$imgUrl = other.imgUrl;
    if (l$imgUrl != lOther$imgUrl) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetTrendingData$getTrendingData$trendingTracks
    on Query$GetTrendingData$getTrendingData$trendingTracks {
  CopyWith$Query$GetTrendingData$getTrendingData$trendingTracks<
          Query$GetTrendingData$getTrendingData$trendingTracks>
      get copyWith =>
          CopyWith$Query$GetTrendingData$getTrendingData$trendingTracks(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetTrendingData$getTrendingData$trendingTracks<
    TRes> {
  factory CopyWith$Query$GetTrendingData$getTrendingData$trendingTracks(
    Query$GetTrendingData$getTrendingData$trendingTracks instance,
    TRes Function(Query$GetTrendingData$getTrendingData$trendingTracks) then,
  ) = _CopyWithImpl$Query$GetTrendingData$getTrendingData$trendingTracks;

  factory CopyWith$Query$GetTrendingData$getTrendingData$trendingTracks.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetTrendingData$getTrendingData$trendingTracks;

  TRes call({
    String? isrc,
    String? imgUrl,
    String? title,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetTrendingData$getTrendingData$trendingTracks<TRes>
    implements
        CopyWith$Query$GetTrendingData$getTrendingData$trendingTracks<TRes> {
  _CopyWithImpl$Query$GetTrendingData$getTrendingData$trendingTracks(
    this._instance,
    this._then,
  );

  final Query$GetTrendingData$getTrendingData$trendingTracks _instance;

  final TRes Function(Query$GetTrendingData$getTrendingData$trendingTracks)
      _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? isrc = _undefined,
    Object? imgUrl = _undefined,
    Object? title = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetTrendingData$getTrendingData$trendingTracks(
        isrc: isrc == _undefined || isrc == null
            ? _instance.isrc
            : (isrc as String),
        imgUrl: imgUrl == _undefined ? _instance.imgUrl : (imgUrl as String?),
        title: title == _undefined || title == null
            ? _instance.title
            : (title as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetTrendingData$getTrendingData$trendingTracks<
        TRes>
    implements
        CopyWith$Query$GetTrendingData$getTrendingData$trendingTracks<TRes> {
  _CopyWithStubImpl$Query$GetTrendingData$getTrendingData$trendingTracks(
      this._res);

  TRes _res;

  call({
    String? isrc,
    String? imgUrl,
    String? title,
    String? $__typename,
  }) =>
      _res;
}

class Query$GetAllUsers {
  Query$GetAllUsers({
    required this.getAllUsers,
    this.$__typename = 'QueryRoot',
  });

  factory Query$GetAllUsers.fromJson(Map<String, dynamic> json) {
    final l$getAllUsers = json['getAllUsers'];
    final l$$__typename = json['__typename'];
    return Query$GetAllUsers(
      getAllUsers: Query$GetAllUsers$getAllUsers.fromJson(
          (l$getAllUsers as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetAllUsers$getAllUsers getAllUsers;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getAllUsers = getAllUsers;
    _resultData['getAllUsers'] = l$getAllUsers.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getAllUsers = getAllUsers;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$getAllUsers,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetAllUsers) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$getAllUsers = getAllUsers;
    final lOther$getAllUsers = other.getAllUsers;
    if (l$getAllUsers != lOther$getAllUsers) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetAllUsers on Query$GetAllUsers {
  CopyWith$Query$GetAllUsers<Query$GetAllUsers> get copyWith =>
      CopyWith$Query$GetAllUsers(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetAllUsers<TRes> {
  factory CopyWith$Query$GetAllUsers(
    Query$GetAllUsers instance,
    TRes Function(Query$GetAllUsers) then,
  ) = _CopyWithImpl$Query$GetAllUsers;

  factory CopyWith$Query$GetAllUsers.stub(TRes res) =
      _CopyWithStubImpl$Query$GetAllUsers;

  TRes call({
    Query$GetAllUsers$getAllUsers? getAllUsers,
    String? $__typename,
  });
  CopyWith$Query$GetAllUsers$getAllUsers<TRes> get getAllUsers;
}

class _CopyWithImpl$Query$GetAllUsers<TRes>
    implements CopyWith$Query$GetAllUsers<TRes> {
  _CopyWithImpl$Query$GetAllUsers(
    this._instance,
    this._then,
  );

  final Query$GetAllUsers _instance;

  final TRes Function(Query$GetAllUsers) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getAllUsers = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetAllUsers(
        getAllUsers: getAllUsers == _undefined || getAllUsers == null
            ? _instance.getAllUsers
            : (getAllUsers as Query$GetAllUsers$getAllUsers),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetAllUsers$getAllUsers<TRes> get getAllUsers {
    final local$getAllUsers = _instance.getAllUsers;
    return CopyWith$Query$GetAllUsers$getAllUsers(
        local$getAllUsers, (e) => call(getAllUsers: e));
  }
}

class _CopyWithStubImpl$Query$GetAllUsers<TRes>
    implements CopyWith$Query$GetAllUsers<TRes> {
  _CopyWithStubImpl$Query$GetAllUsers(this._res);

  TRes _res;

  call({
    Query$GetAllUsers$getAllUsers? getAllUsers,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetAllUsers$getAllUsers<TRes> get getAllUsers =>
      CopyWith$Query$GetAllUsers$getAllUsers.stub(_res);
}

const documentNodeQueryGetAllUsers = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetAllUsers'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'getAllUsers'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'users'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'name'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'imageUrl'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$GetAllUsers _parserFn$Query$GetAllUsers(Map<String, dynamic> data) =>
    Query$GetAllUsers.fromJson(data);
typedef OnQueryComplete$Query$GetAllUsers = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$GetAllUsers?,
);

class Options$Query$GetAllUsers
    extends graphql.QueryOptions<Query$GetAllUsers> {
  Options$Query$GetAllUsers({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetAllUsers? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetAllUsers? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null ? null : _parserFn$Query$GetAllUsers(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetAllUsers,
          parserFn: _parserFn$Query$GetAllUsers,
        );

  final OnQueryComplete$Query$GetAllUsers? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetAllUsers
    extends graphql.WatchQueryOptions<Query$GetAllUsers> {
  WatchOptions$Query$GetAllUsers({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetAllUsers? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryGetAllUsers,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetAllUsers,
        );
}

class FetchMoreOptions$Query$GetAllUsers extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetAllUsers({required graphql.UpdateQuery updateQuery})
      : super(
          updateQuery: updateQuery,
          document: documentNodeQueryGetAllUsers,
        );
}

extension ClientExtension$Query$GetAllUsers on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetAllUsers>> query$GetAllUsers(
          [Options$Query$GetAllUsers? options]) async =>
      await this.query(options ?? Options$Query$GetAllUsers());
  graphql.ObservableQuery<Query$GetAllUsers> watchQuery$GetAllUsers(
          [WatchOptions$Query$GetAllUsers? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$GetAllUsers());
  void writeQuery$GetAllUsers({
    required Query$GetAllUsers data,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
            operation:
                graphql.Operation(document: documentNodeQueryGetAllUsers)),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetAllUsers? readQuery$GetAllUsers({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
          operation: graphql.Operation(document: documentNodeQueryGetAllUsers)),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetAllUsers.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetAllUsers> useQuery$GetAllUsers(
        [Options$Query$GetAllUsers? options]) =>
    graphql_flutter.useQuery(options ?? Options$Query$GetAllUsers());
graphql.ObservableQuery<Query$GetAllUsers> useWatchQuery$GetAllUsers(
        [WatchOptions$Query$GetAllUsers? options]) =>
    graphql_flutter.useWatchQuery(options ?? WatchOptions$Query$GetAllUsers());

class Query$GetAllUsers$Widget
    extends graphql_flutter.Query<Query$GetAllUsers> {
  Query$GetAllUsers$Widget({
    widgets.Key? key,
    Options$Query$GetAllUsers? options,
    required graphql_flutter.QueryBuilder<Query$GetAllUsers> builder,
  }) : super(
          key: key,
          options: options ?? Options$Query$GetAllUsers(),
          builder: builder,
        );
}

class Query$GetAllUsers$getAllUsers {
  Query$GetAllUsers$getAllUsers({
    required this.users,
    this.$__typename = 'AllUsersData',
  });

  factory Query$GetAllUsers$getAllUsers.fromJson(Map<String, dynamic> json) {
    final l$users = json['users'];
    final l$$__typename = json['__typename'];
    return Query$GetAllUsers$getAllUsers(
      users: (l$users as List<dynamic>)
          .map((e) => Query$GetAllUsers$getAllUsers$users.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$GetAllUsers$getAllUsers$users> users;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$users = users;
    _resultData['users'] = l$users.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$users = users;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$users.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetAllUsers$getAllUsers) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$users = users;
    final lOther$users = other.users;
    if (l$users.length != lOther$users.length) {
      return false;
    }
    for (int i = 0; i < l$users.length; i++) {
      final l$users$entry = l$users[i];
      final lOther$users$entry = lOther$users[i];
      if (l$users$entry != lOther$users$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetAllUsers$getAllUsers
    on Query$GetAllUsers$getAllUsers {
  CopyWith$Query$GetAllUsers$getAllUsers<Query$GetAllUsers$getAllUsers>
      get copyWith => CopyWith$Query$GetAllUsers$getAllUsers(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetAllUsers$getAllUsers<TRes> {
  factory CopyWith$Query$GetAllUsers$getAllUsers(
    Query$GetAllUsers$getAllUsers instance,
    TRes Function(Query$GetAllUsers$getAllUsers) then,
  ) = _CopyWithImpl$Query$GetAllUsers$getAllUsers;

  factory CopyWith$Query$GetAllUsers$getAllUsers.stub(TRes res) =
      _CopyWithStubImpl$Query$GetAllUsers$getAllUsers;

  TRes call({
    List<Query$GetAllUsers$getAllUsers$users>? users,
    String? $__typename,
  });
  TRes users(
      Iterable<Query$GetAllUsers$getAllUsers$users> Function(
              Iterable<
                  CopyWith$Query$GetAllUsers$getAllUsers$users<
                      Query$GetAllUsers$getAllUsers$users>>)
          _fn);
}

class _CopyWithImpl$Query$GetAllUsers$getAllUsers<TRes>
    implements CopyWith$Query$GetAllUsers$getAllUsers<TRes> {
  _CopyWithImpl$Query$GetAllUsers$getAllUsers(
    this._instance,
    this._then,
  );

  final Query$GetAllUsers$getAllUsers _instance;

  final TRes Function(Query$GetAllUsers$getAllUsers) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? users = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetAllUsers$getAllUsers(
        users: users == _undefined || users == null
            ? _instance.users
            : (users as List<Query$GetAllUsers$getAllUsers$users>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes users(
          Iterable<Query$GetAllUsers$getAllUsers$users> Function(
                  Iterable<
                      CopyWith$Query$GetAllUsers$getAllUsers$users<
                          Query$GetAllUsers$getAllUsers$users>>)
              _fn) =>
      call(
          users: _fn(_instance.users
              .map((e) => CopyWith$Query$GetAllUsers$getAllUsers$users(
                    e,
                    (i) => i,
                  ))).toList());
}

class _CopyWithStubImpl$Query$GetAllUsers$getAllUsers<TRes>
    implements CopyWith$Query$GetAllUsers$getAllUsers<TRes> {
  _CopyWithStubImpl$Query$GetAllUsers$getAllUsers(this._res);

  TRes _res;

  call({
    List<Query$GetAllUsers$getAllUsers$users>? users,
    String? $__typename,
  }) =>
      _res;

  users(_fn) => _res;
}

class Query$GetAllUsers$getAllUsers$users {
  Query$GetAllUsers$getAllUsers$users({
    required this.id,
    required this.name,
    this.imageUrl,
    this.$__typename = 'UserSimpleData',
  });

  factory Query$GetAllUsers$getAllUsers$users.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$imageUrl = json['imageUrl'];
    final l$$__typename = json['__typename'];
    return Query$GetAllUsers$getAllUsers$users(
      id: (l$id as String),
      name: (l$name as String),
      imageUrl: (l$imageUrl as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String name;

  final String? imageUrl;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$imageUrl = imageUrl;
    _resultData['imageUrl'] = l$imageUrl;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$imageUrl = imageUrl;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$name,
      l$imageUrl,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetAllUsers$getAllUsers$users) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$imageUrl = imageUrl;
    final lOther$imageUrl = other.imageUrl;
    if (l$imageUrl != lOther$imageUrl) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetAllUsers$getAllUsers$users
    on Query$GetAllUsers$getAllUsers$users {
  CopyWith$Query$GetAllUsers$getAllUsers$users<
          Query$GetAllUsers$getAllUsers$users>
      get copyWith => CopyWith$Query$GetAllUsers$getAllUsers$users(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetAllUsers$getAllUsers$users<TRes> {
  factory CopyWith$Query$GetAllUsers$getAllUsers$users(
    Query$GetAllUsers$getAllUsers$users instance,
    TRes Function(Query$GetAllUsers$getAllUsers$users) then,
  ) = _CopyWithImpl$Query$GetAllUsers$getAllUsers$users;

  factory CopyWith$Query$GetAllUsers$getAllUsers$users.stub(TRes res) =
      _CopyWithStubImpl$Query$GetAllUsers$getAllUsers$users;

  TRes call({
    String? id,
    String? name,
    String? imageUrl,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetAllUsers$getAllUsers$users<TRes>
    implements CopyWith$Query$GetAllUsers$getAllUsers$users<TRes> {
  _CopyWithImpl$Query$GetAllUsers$getAllUsers$users(
    this._instance,
    this._then,
  );

  final Query$GetAllUsers$getAllUsers$users _instance;

  final TRes Function(Query$GetAllUsers$getAllUsers$users) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? imageUrl = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetAllUsers$getAllUsers$users(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        imageUrl:
            imageUrl == _undefined ? _instance.imageUrl : (imageUrl as String?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetAllUsers$getAllUsers$users<TRes>
    implements CopyWith$Query$GetAllUsers$getAllUsers$users<TRes> {
  _CopyWithStubImpl$Query$GetAllUsers$getAllUsers$users(this._res);

  TRes _res;

  call({
    String? id,
    String? name,
    String? imageUrl,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Query$GetLineChartData {
  factory Variables$Query$GetLineChartData({
    String? artistId,
    String? isrc,
    String? dsp,
    String? period,
  }) =>
      Variables$Query$GetLineChartData._({
        if (artistId != null) r'artistId': artistId,
        if (isrc != null) r'isrc': isrc,
        if (dsp != null) r'dsp': dsp,
        if (period != null) r'period': period,
      });

  Variables$Query$GetLineChartData._(this._$data);

  factory Variables$Query$GetLineChartData.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('artistId')) {
      final l$artistId = data['artistId'];
      result$data['artistId'] = (l$artistId as String?);
    }
    if (data.containsKey('isrc')) {
      final l$isrc = data['isrc'];
      result$data['isrc'] = (l$isrc as String?);
    }
    if (data.containsKey('dsp')) {
      final l$dsp = data['dsp'];
      result$data['dsp'] = (l$dsp as String?);
    }
    if (data.containsKey('period')) {
      final l$period = data['period'];
      result$data['period'] = (l$period as String?);
    }
    return Variables$Query$GetLineChartData._(result$data);
  }

  Map<String, dynamic> _$data;

  String? get artistId => (_$data['artistId'] as String?);

  String? get isrc => (_$data['isrc'] as String?);

  String? get dsp => (_$data['dsp'] as String?);

  String? get period => (_$data['period'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('artistId')) {
      final l$artistId = artistId;
      result$data['artistId'] = l$artistId;
    }
    if (_$data.containsKey('isrc')) {
      final l$isrc = isrc;
      result$data['isrc'] = l$isrc;
    }
    if (_$data.containsKey('dsp')) {
      final l$dsp = dsp;
      result$data['dsp'] = l$dsp;
    }
    if (_$data.containsKey('period')) {
      final l$period = period;
      result$data['period'] = l$period;
    }
    return result$data;
  }

  CopyWith$Variables$Query$GetLineChartData<Variables$Query$GetLineChartData>
      get copyWith => CopyWith$Variables$Query$GetLineChartData(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$GetLineChartData) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$artistId = artistId;
    final lOther$artistId = other.artistId;
    if (_$data.containsKey('artistId') !=
        other._$data.containsKey('artistId')) {
      return false;
    }
    if (l$artistId != lOther$artistId) {
      return false;
    }
    final l$isrc = isrc;
    final lOther$isrc = other.isrc;
    if (_$data.containsKey('isrc') != other._$data.containsKey('isrc')) {
      return false;
    }
    if (l$isrc != lOther$isrc) {
      return false;
    }
    final l$dsp = dsp;
    final lOther$dsp = other.dsp;
    if (_$data.containsKey('dsp') != other._$data.containsKey('dsp')) {
      return false;
    }
    if (l$dsp != lOther$dsp) {
      return false;
    }
    final l$period = period;
    final lOther$period = other.period;
    if (_$data.containsKey('period') != other._$data.containsKey('period')) {
      return false;
    }
    if (l$period != lOther$period) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$artistId = artistId;
    final l$isrc = isrc;
    final l$dsp = dsp;
    final l$period = period;
    return Object.hashAll([
      _$data.containsKey('artistId') ? l$artistId : const {},
      _$data.containsKey('isrc') ? l$isrc : const {},
      _$data.containsKey('dsp') ? l$dsp : const {},
      _$data.containsKey('period') ? l$period : const {},
    ]);
  }
}

abstract class CopyWith$Variables$Query$GetLineChartData<TRes> {
  factory CopyWith$Variables$Query$GetLineChartData(
    Variables$Query$GetLineChartData instance,
    TRes Function(Variables$Query$GetLineChartData) then,
  ) = _CopyWithImpl$Variables$Query$GetLineChartData;

  factory CopyWith$Variables$Query$GetLineChartData.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$GetLineChartData;

  TRes call({
    String? artistId,
    String? isrc,
    String? dsp,
    String? period,
  });
}

class _CopyWithImpl$Variables$Query$GetLineChartData<TRes>
    implements CopyWith$Variables$Query$GetLineChartData<TRes> {
  _CopyWithImpl$Variables$Query$GetLineChartData(
    this._instance,
    this._then,
  );

  final Variables$Query$GetLineChartData _instance;

  final TRes Function(Variables$Query$GetLineChartData) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? artistId = _undefined,
    Object? isrc = _undefined,
    Object? dsp = _undefined,
    Object? period = _undefined,
  }) =>
      _then(Variables$Query$GetLineChartData._({
        ..._instance._$data,
        if (artistId != _undefined) 'artistId': (artistId as String?),
        if (isrc != _undefined) 'isrc': (isrc as String?),
        if (dsp != _undefined) 'dsp': (dsp as String?),
        if (period != _undefined) 'period': (period as String?),
      }));
}

class _CopyWithStubImpl$Variables$Query$GetLineChartData<TRes>
    implements CopyWith$Variables$Query$GetLineChartData<TRes> {
  _CopyWithStubImpl$Variables$Query$GetLineChartData(this._res);

  TRes _res;

  call({
    String? artistId,
    String? isrc,
    String? dsp,
    String? period,
  }) =>
      _res;
}

class Query$GetLineChartData {
  Query$GetLineChartData({
    required this.getLineChartData,
    this.$__typename = 'QueryRoot',
  });

  factory Query$GetLineChartData.fromJson(Map<String, dynamic> json) {
    final l$getLineChartData = json['getLineChartData'];
    final l$$__typename = json['__typename'];
    return Query$GetLineChartData(
      getLineChartData: Query$GetLineChartData$getLineChartData.fromJson(
          (l$getLineChartData as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetLineChartData$getLineChartData getLineChartData;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getLineChartData = getLineChartData;
    _resultData['getLineChartData'] = l$getLineChartData.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getLineChartData = getLineChartData;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$getLineChartData,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetLineChartData) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$getLineChartData = getLineChartData;
    final lOther$getLineChartData = other.getLineChartData;
    if (l$getLineChartData != lOther$getLineChartData) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetLineChartData on Query$GetLineChartData {
  CopyWith$Query$GetLineChartData<Query$GetLineChartData> get copyWith =>
      CopyWith$Query$GetLineChartData(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetLineChartData<TRes> {
  factory CopyWith$Query$GetLineChartData(
    Query$GetLineChartData instance,
    TRes Function(Query$GetLineChartData) then,
  ) = _CopyWithImpl$Query$GetLineChartData;

  factory CopyWith$Query$GetLineChartData.stub(TRes res) =
      _CopyWithStubImpl$Query$GetLineChartData;

  TRes call({
    Query$GetLineChartData$getLineChartData? getLineChartData,
    String? $__typename,
  });
  CopyWith$Query$GetLineChartData$getLineChartData<TRes> get getLineChartData;
}

class _CopyWithImpl$Query$GetLineChartData<TRes>
    implements CopyWith$Query$GetLineChartData<TRes> {
  _CopyWithImpl$Query$GetLineChartData(
    this._instance,
    this._then,
  );

  final Query$GetLineChartData _instance;

  final TRes Function(Query$GetLineChartData) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getLineChartData = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetLineChartData(
        getLineChartData:
            getLineChartData == _undefined || getLineChartData == null
                ? _instance.getLineChartData
                : (getLineChartData as Query$GetLineChartData$getLineChartData),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetLineChartData$getLineChartData<TRes> get getLineChartData {
    final local$getLineChartData = _instance.getLineChartData;
    return CopyWith$Query$GetLineChartData$getLineChartData(
        local$getLineChartData, (e) => call(getLineChartData: e));
  }
}

class _CopyWithStubImpl$Query$GetLineChartData<TRes>
    implements CopyWith$Query$GetLineChartData<TRes> {
  _CopyWithStubImpl$Query$GetLineChartData(this._res);

  TRes _res;

  call({
    Query$GetLineChartData$getLineChartData? getLineChartData,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetLineChartData$getLineChartData<TRes> get getLineChartData =>
      CopyWith$Query$GetLineChartData$getLineChartData.stub(_res);
}

const documentNodeQueryGetLineChartData = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetLineChartData'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'artistId')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'isrc')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'dsp')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'period')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'getLineChartData'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'artistId'),
            value: VariableNode(name: NameNode(value: 'artistId')),
          ),
          ArgumentNode(
            name: NameNode(value: 'isrc'),
            value: VariableNode(name: NameNode(value: 'isrc')),
          ),
          ArgumentNode(
            name: NameNode(value: 'dsp'),
            value: VariableNode(name: NameNode(value: 'dsp')),
          ),
          ArgumentNode(
            name: NameNode(value: 'period'),
            value: VariableNode(name: NameNode(value: 'period')),
          ),
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'lineChartData'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$GetLineChartData _parserFn$Query$GetLineChartData(
        Map<String, dynamic> data) =>
    Query$GetLineChartData.fromJson(data);
typedef OnQueryComplete$Query$GetLineChartData = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$GetLineChartData?,
);

class Options$Query$GetLineChartData
    extends graphql.QueryOptions<Query$GetLineChartData> {
  Options$Query$GetLineChartData({
    String? operationName,
    Variables$Query$GetLineChartData? variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetLineChartData? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetLineChartData? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          variables: variables?.toJson() ?? {},
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null
                        ? null
                        : _parserFn$Query$GetLineChartData(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetLineChartData,
          parserFn: _parserFn$Query$GetLineChartData,
        );

  final OnQueryComplete$Query$GetLineChartData? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetLineChartData
    extends graphql.WatchQueryOptions<Query$GetLineChartData> {
  WatchOptions$Query$GetLineChartData({
    String? operationName,
    Variables$Query$GetLineChartData? variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetLineChartData? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables?.toJson() ?? {},
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryGetLineChartData,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetLineChartData,
        );
}

class FetchMoreOptions$Query$GetLineChartData extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetLineChartData({
    required graphql.UpdateQuery updateQuery,
    Variables$Query$GetLineChartData? variables,
  }) : super(
          updateQuery: updateQuery,
          variables: variables?.toJson() ?? {},
          document: documentNodeQueryGetLineChartData,
        );
}

extension ClientExtension$Query$GetLineChartData on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetLineChartData>> query$GetLineChartData(
          [Options$Query$GetLineChartData? options]) async =>
      await this.query(options ?? Options$Query$GetLineChartData());
  graphql.ObservableQuery<Query$GetLineChartData> watchQuery$GetLineChartData(
          [WatchOptions$Query$GetLineChartData? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$GetLineChartData());
  void writeQuery$GetLineChartData({
    required Query$GetLineChartData data,
    Variables$Query$GetLineChartData? variables,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
          operation:
              graphql.Operation(document: documentNodeQueryGetLineChartData),
          variables: variables?.toJson() ?? const {},
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetLineChartData? readQuery$GetLineChartData({
    Variables$Query$GetLineChartData? variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation:
            graphql.Operation(document: documentNodeQueryGetLineChartData),
        variables: variables?.toJson() ?? const {},
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetLineChartData.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetLineChartData>
    useQuery$GetLineChartData([Options$Query$GetLineChartData? options]) =>
        graphql_flutter.useQuery(options ?? Options$Query$GetLineChartData());
graphql.ObservableQuery<Query$GetLineChartData> useWatchQuery$GetLineChartData(
        [WatchOptions$Query$GetLineChartData? options]) =>
    graphql_flutter
        .useWatchQuery(options ?? WatchOptions$Query$GetLineChartData());

class Query$GetLineChartData$Widget
    extends graphql_flutter.Query<Query$GetLineChartData> {
  Query$GetLineChartData$Widget({
    widgets.Key? key,
    Options$Query$GetLineChartData? options,
    required graphql_flutter.QueryBuilder<Query$GetLineChartData> builder,
  }) : super(
          key: key,
          options: options ?? Options$Query$GetLineChartData(),
          builder: builder,
        );
}

class Query$GetLineChartData$getLineChartData {
  Query$GetLineChartData$getLineChartData({
    required this.lineChartData,
    this.$__typename = 'ChartData',
  });

  factory Query$GetLineChartData$getLineChartData.fromJson(
      Map<String, dynamic> json) {
    final l$lineChartData = json['lineChartData'];
    final l$$__typename = json['__typename'];
    return Query$GetLineChartData$getLineChartData(
      lineChartData:
          (l$lineChartData as List<dynamic>).map((e) => (e as int)).toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<int> lineChartData;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$lineChartData = lineChartData;
    _resultData['lineChartData'] = l$lineChartData.map((e) => e).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$lineChartData = lineChartData;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$lineChartData.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetLineChartData$getLineChartData) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$lineChartData = lineChartData;
    final lOther$lineChartData = other.lineChartData;
    if (l$lineChartData.length != lOther$lineChartData.length) {
      return false;
    }
    for (int i = 0; i < l$lineChartData.length; i++) {
      final l$lineChartData$entry = l$lineChartData[i];
      final lOther$lineChartData$entry = lOther$lineChartData[i];
      if (l$lineChartData$entry != lOther$lineChartData$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetLineChartData$getLineChartData
    on Query$GetLineChartData$getLineChartData {
  CopyWith$Query$GetLineChartData$getLineChartData<
          Query$GetLineChartData$getLineChartData>
      get copyWith => CopyWith$Query$GetLineChartData$getLineChartData(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetLineChartData$getLineChartData<TRes> {
  factory CopyWith$Query$GetLineChartData$getLineChartData(
    Query$GetLineChartData$getLineChartData instance,
    TRes Function(Query$GetLineChartData$getLineChartData) then,
  ) = _CopyWithImpl$Query$GetLineChartData$getLineChartData;

  factory CopyWith$Query$GetLineChartData$getLineChartData.stub(TRes res) =
      _CopyWithStubImpl$Query$GetLineChartData$getLineChartData;

  TRes call({
    List<int>? lineChartData,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetLineChartData$getLineChartData<TRes>
    implements CopyWith$Query$GetLineChartData$getLineChartData<TRes> {
  _CopyWithImpl$Query$GetLineChartData$getLineChartData(
    this._instance,
    this._then,
  );

  final Query$GetLineChartData$getLineChartData _instance;

  final TRes Function(Query$GetLineChartData$getLineChartData) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? lineChartData = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetLineChartData$getLineChartData(
        lineChartData: lineChartData == _undefined || lineChartData == null
            ? _instance.lineChartData
            : (lineChartData as List<int>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetLineChartData$getLineChartData<TRes>
    implements CopyWith$Query$GetLineChartData$getLineChartData<TRes> {
  _CopyWithStubImpl$Query$GetLineChartData$getLineChartData(this._res);

  TRes _res;

  call({
    List<int>? lineChartData,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Query$GetPlaybacksByGenderData {
  factory Variables$Query$GetPlaybacksByGenderData({
    String? artistId,
    String? isrc,
    String? dsp,
    String? period,
  }) =>
      Variables$Query$GetPlaybacksByGenderData._({
        if (artistId != null) r'artistId': artistId,
        if (isrc != null) r'isrc': isrc,
        if (dsp != null) r'dsp': dsp,
        if (period != null) r'period': period,
      });

  Variables$Query$GetPlaybacksByGenderData._(this._$data);

  factory Variables$Query$GetPlaybacksByGenderData.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('artistId')) {
      final l$artistId = data['artistId'];
      result$data['artistId'] = (l$artistId as String?);
    }
    if (data.containsKey('isrc')) {
      final l$isrc = data['isrc'];
      result$data['isrc'] = (l$isrc as String?);
    }
    if (data.containsKey('dsp')) {
      final l$dsp = data['dsp'];
      result$data['dsp'] = (l$dsp as String?);
    }
    if (data.containsKey('period')) {
      final l$period = data['period'];
      result$data['period'] = (l$period as String?);
    }
    return Variables$Query$GetPlaybacksByGenderData._(result$data);
  }

  Map<String, dynamic> _$data;

  String? get artistId => (_$data['artistId'] as String?);

  String? get isrc => (_$data['isrc'] as String?);

  String? get dsp => (_$data['dsp'] as String?);

  String? get period => (_$data['period'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('artistId')) {
      final l$artistId = artistId;
      result$data['artistId'] = l$artistId;
    }
    if (_$data.containsKey('isrc')) {
      final l$isrc = isrc;
      result$data['isrc'] = l$isrc;
    }
    if (_$data.containsKey('dsp')) {
      final l$dsp = dsp;
      result$data['dsp'] = l$dsp;
    }
    if (_$data.containsKey('period')) {
      final l$period = period;
      result$data['period'] = l$period;
    }
    return result$data;
  }

  CopyWith$Variables$Query$GetPlaybacksByGenderData<
          Variables$Query$GetPlaybacksByGenderData>
      get copyWith => CopyWith$Variables$Query$GetPlaybacksByGenderData(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$GetPlaybacksByGenderData) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$artistId = artistId;
    final lOther$artistId = other.artistId;
    if (_$data.containsKey('artistId') !=
        other._$data.containsKey('artistId')) {
      return false;
    }
    if (l$artistId != lOther$artistId) {
      return false;
    }
    final l$isrc = isrc;
    final lOther$isrc = other.isrc;
    if (_$data.containsKey('isrc') != other._$data.containsKey('isrc')) {
      return false;
    }
    if (l$isrc != lOther$isrc) {
      return false;
    }
    final l$dsp = dsp;
    final lOther$dsp = other.dsp;
    if (_$data.containsKey('dsp') != other._$data.containsKey('dsp')) {
      return false;
    }
    if (l$dsp != lOther$dsp) {
      return false;
    }
    final l$period = period;
    final lOther$period = other.period;
    if (_$data.containsKey('period') != other._$data.containsKey('period')) {
      return false;
    }
    if (l$period != lOther$period) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$artistId = artistId;
    final l$isrc = isrc;
    final l$dsp = dsp;
    final l$period = period;
    return Object.hashAll([
      _$data.containsKey('artistId') ? l$artistId : const {},
      _$data.containsKey('isrc') ? l$isrc : const {},
      _$data.containsKey('dsp') ? l$dsp : const {},
      _$data.containsKey('period') ? l$period : const {},
    ]);
  }
}

abstract class CopyWith$Variables$Query$GetPlaybacksByGenderData<TRes> {
  factory CopyWith$Variables$Query$GetPlaybacksByGenderData(
    Variables$Query$GetPlaybacksByGenderData instance,
    TRes Function(Variables$Query$GetPlaybacksByGenderData) then,
  ) = _CopyWithImpl$Variables$Query$GetPlaybacksByGenderData;

  factory CopyWith$Variables$Query$GetPlaybacksByGenderData.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$GetPlaybacksByGenderData;

  TRes call({
    String? artistId,
    String? isrc,
    String? dsp,
    String? period,
  });
}

class _CopyWithImpl$Variables$Query$GetPlaybacksByGenderData<TRes>
    implements CopyWith$Variables$Query$GetPlaybacksByGenderData<TRes> {
  _CopyWithImpl$Variables$Query$GetPlaybacksByGenderData(
    this._instance,
    this._then,
  );

  final Variables$Query$GetPlaybacksByGenderData _instance;

  final TRes Function(Variables$Query$GetPlaybacksByGenderData) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? artistId = _undefined,
    Object? isrc = _undefined,
    Object? dsp = _undefined,
    Object? period = _undefined,
  }) =>
      _then(Variables$Query$GetPlaybacksByGenderData._({
        ..._instance._$data,
        if (artistId != _undefined) 'artistId': (artistId as String?),
        if (isrc != _undefined) 'isrc': (isrc as String?),
        if (dsp != _undefined) 'dsp': (dsp as String?),
        if (period != _undefined) 'period': (period as String?),
      }));
}

class _CopyWithStubImpl$Variables$Query$GetPlaybacksByGenderData<TRes>
    implements CopyWith$Variables$Query$GetPlaybacksByGenderData<TRes> {
  _CopyWithStubImpl$Variables$Query$GetPlaybacksByGenderData(this._res);

  TRes _res;

  call({
    String? artistId,
    String? isrc,
    String? dsp,
    String? period,
  }) =>
      _res;
}

class Query$GetPlaybacksByGenderData {
  Query$GetPlaybacksByGenderData({
    required this.getPlaybacksByGenderData,
    this.$__typename = 'QueryRoot',
  });

  factory Query$GetPlaybacksByGenderData.fromJson(Map<String, dynamic> json) {
    final l$getPlaybacksByGenderData = json['getPlaybacksByGenderData'];
    final l$$__typename = json['__typename'];
    return Query$GetPlaybacksByGenderData(
      getPlaybacksByGenderData:
          Query$GetPlaybacksByGenderData$getPlaybacksByGenderData.fromJson(
              (l$getPlaybacksByGenderData as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetPlaybacksByGenderData$getPlaybacksByGenderData
      getPlaybacksByGenderData;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getPlaybacksByGenderData = getPlaybacksByGenderData;
    _resultData['getPlaybacksByGenderData'] =
        l$getPlaybacksByGenderData.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getPlaybacksByGenderData = getPlaybacksByGenderData;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$getPlaybacksByGenderData,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetPlaybacksByGenderData) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$getPlaybacksByGenderData = getPlaybacksByGenderData;
    final lOther$getPlaybacksByGenderData = other.getPlaybacksByGenderData;
    if (l$getPlaybacksByGenderData != lOther$getPlaybacksByGenderData) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetPlaybacksByGenderData
    on Query$GetPlaybacksByGenderData {
  CopyWith$Query$GetPlaybacksByGenderData<Query$GetPlaybacksByGenderData>
      get copyWith => CopyWith$Query$GetPlaybacksByGenderData(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetPlaybacksByGenderData<TRes> {
  factory CopyWith$Query$GetPlaybacksByGenderData(
    Query$GetPlaybacksByGenderData instance,
    TRes Function(Query$GetPlaybacksByGenderData) then,
  ) = _CopyWithImpl$Query$GetPlaybacksByGenderData;

  factory CopyWith$Query$GetPlaybacksByGenderData.stub(TRes res) =
      _CopyWithStubImpl$Query$GetPlaybacksByGenderData;

  TRes call({
    Query$GetPlaybacksByGenderData$getPlaybacksByGenderData?
        getPlaybacksByGenderData,
    String? $__typename,
  });
  CopyWith$Query$GetPlaybacksByGenderData$getPlaybacksByGenderData<TRes>
      get getPlaybacksByGenderData;
}

class _CopyWithImpl$Query$GetPlaybacksByGenderData<TRes>
    implements CopyWith$Query$GetPlaybacksByGenderData<TRes> {
  _CopyWithImpl$Query$GetPlaybacksByGenderData(
    this._instance,
    this._then,
  );

  final Query$GetPlaybacksByGenderData _instance;

  final TRes Function(Query$GetPlaybacksByGenderData) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getPlaybacksByGenderData = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetPlaybacksByGenderData(
        getPlaybacksByGenderData: getPlaybacksByGenderData == _undefined ||
                getPlaybacksByGenderData == null
            ? _instance.getPlaybacksByGenderData
            : (getPlaybacksByGenderData
                as Query$GetPlaybacksByGenderData$getPlaybacksByGenderData),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetPlaybacksByGenderData$getPlaybacksByGenderData<TRes>
      get getPlaybacksByGenderData {
    final local$getPlaybacksByGenderData = _instance.getPlaybacksByGenderData;
    return CopyWith$Query$GetPlaybacksByGenderData$getPlaybacksByGenderData(
        local$getPlaybacksByGenderData,
        (e) => call(getPlaybacksByGenderData: e));
  }
}

class _CopyWithStubImpl$Query$GetPlaybacksByGenderData<TRes>
    implements CopyWith$Query$GetPlaybacksByGenderData<TRes> {
  _CopyWithStubImpl$Query$GetPlaybacksByGenderData(this._res);

  TRes _res;

  call({
    Query$GetPlaybacksByGenderData$getPlaybacksByGenderData?
        getPlaybacksByGenderData,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetPlaybacksByGenderData$getPlaybacksByGenderData<TRes>
      get getPlaybacksByGenderData =>
          CopyWith$Query$GetPlaybacksByGenderData$getPlaybacksByGenderData.stub(
              _res);
}

const documentNodeQueryGetPlaybacksByGenderData = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetPlaybacksByGenderData'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'artistId')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'isrc')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'dsp')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'period')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'getPlaybacksByGenderData'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'artistId'),
            value: VariableNode(name: NameNode(value: 'artistId')),
          ),
          ArgumentNode(
            name: NameNode(value: 'isrc'),
            value: VariableNode(name: NameNode(value: 'isrc')),
          ),
          ArgumentNode(
            name: NameNode(value: 'dsp'),
            value: VariableNode(name: NameNode(value: 'dsp')),
          ),
          ArgumentNode(
            name: NameNode(value: 'period'),
            value: VariableNode(name: NameNode(value: 'period')),
          ),
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'malePlaybacks'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'femalePlaybacks'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'unknownPlaybacks'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$GetPlaybacksByGenderData _parserFn$Query$GetPlaybacksByGenderData(
        Map<String, dynamic> data) =>
    Query$GetPlaybacksByGenderData.fromJson(data);
typedef OnQueryComplete$Query$GetPlaybacksByGenderData = FutureOr<void>
    Function(
  Map<String, dynamic>?,
  Query$GetPlaybacksByGenderData?,
);

class Options$Query$GetPlaybacksByGenderData
    extends graphql.QueryOptions<Query$GetPlaybacksByGenderData> {
  Options$Query$GetPlaybacksByGenderData({
    String? operationName,
    Variables$Query$GetPlaybacksByGenderData? variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetPlaybacksByGenderData? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetPlaybacksByGenderData? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          variables: variables?.toJson() ?? {},
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null
                        ? null
                        : _parserFn$Query$GetPlaybacksByGenderData(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetPlaybacksByGenderData,
          parserFn: _parserFn$Query$GetPlaybacksByGenderData,
        );

  final OnQueryComplete$Query$GetPlaybacksByGenderData? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetPlaybacksByGenderData
    extends graphql.WatchQueryOptions<Query$GetPlaybacksByGenderData> {
  WatchOptions$Query$GetPlaybacksByGenderData({
    String? operationName,
    Variables$Query$GetPlaybacksByGenderData? variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetPlaybacksByGenderData? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables?.toJson() ?? {},
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryGetPlaybacksByGenderData,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetPlaybacksByGenderData,
        );
}

class FetchMoreOptions$Query$GetPlaybacksByGenderData
    extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetPlaybacksByGenderData({
    required graphql.UpdateQuery updateQuery,
    Variables$Query$GetPlaybacksByGenderData? variables,
  }) : super(
          updateQuery: updateQuery,
          variables: variables?.toJson() ?? {},
          document: documentNodeQueryGetPlaybacksByGenderData,
        );
}

extension ClientExtension$Query$GetPlaybacksByGenderData
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetPlaybacksByGenderData>>
      query$GetPlaybacksByGenderData(
              [Options$Query$GetPlaybacksByGenderData? options]) async =>
          await this.query(options ?? Options$Query$GetPlaybacksByGenderData());
  graphql.ObservableQuery<
      Query$GetPlaybacksByGenderData> watchQuery$GetPlaybacksByGenderData(
          [WatchOptions$Query$GetPlaybacksByGenderData? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$GetPlaybacksByGenderData());
  void writeQuery$GetPlaybacksByGenderData({
    required Query$GetPlaybacksByGenderData data,
    Variables$Query$GetPlaybacksByGenderData? variables,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
          operation: graphql.Operation(
              document: documentNodeQueryGetPlaybacksByGenderData),
          variables: variables?.toJson() ?? const {},
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetPlaybacksByGenderData? readQuery$GetPlaybacksByGenderData({
    Variables$Query$GetPlaybacksByGenderData? variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(
            document: documentNodeQueryGetPlaybacksByGenderData),
        variables: variables?.toJson() ?? const {},
      ),
      optimistic: optimistic,
    );
    return result == null
        ? null
        : Query$GetPlaybacksByGenderData.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetPlaybacksByGenderData>
    useQuery$GetPlaybacksByGenderData(
            [Options$Query$GetPlaybacksByGenderData? options]) =>
        graphql_flutter
            .useQuery(options ?? Options$Query$GetPlaybacksByGenderData());
graphql.ObservableQuery<Query$GetPlaybacksByGenderData>
    useWatchQuery$GetPlaybacksByGenderData(
            [WatchOptions$Query$GetPlaybacksByGenderData? options]) =>
        graphql_flutter.useWatchQuery(
            options ?? WatchOptions$Query$GetPlaybacksByGenderData());

class Query$GetPlaybacksByGenderData$Widget
    extends graphql_flutter.Query<Query$GetPlaybacksByGenderData> {
  Query$GetPlaybacksByGenderData$Widget({
    widgets.Key? key,
    Options$Query$GetPlaybacksByGenderData? options,
    required graphql_flutter.QueryBuilder<Query$GetPlaybacksByGenderData>
        builder,
  }) : super(
          key: key,
          options: options ?? Options$Query$GetPlaybacksByGenderData(),
          builder: builder,
        );
}

class Query$GetPlaybacksByGenderData$getPlaybacksByGenderData {
  Query$GetPlaybacksByGenderData$getPlaybacksByGenderData({
    required this.malePlaybacks,
    required this.femalePlaybacks,
    required this.unknownPlaybacks,
    this.$__typename = 'PlaybacksByGenderData',
  });

  factory Query$GetPlaybacksByGenderData$getPlaybacksByGenderData.fromJson(
      Map<String, dynamic> json) {
    final l$malePlaybacks = json['malePlaybacks'];
    final l$femalePlaybacks = json['femalePlaybacks'];
    final l$unknownPlaybacks = json['unknownPlaybacks'];
    final l$$__typename = json['__typename'];
    return Query$GetPlaybacksByGenderData$getPlaybacksByGenderData(
      malePlaybacks: (l$malePlaybacks as int),
      femalePlaybacks: (l$femalePlaybacks as int),
      unknownPlaybacks: (l$unknownPlaybacks as int),
      $__typename: (l$$__typename as String),
    );
  }

  final int malePlaybacks;

  final int femalePlaybacks;

  final int unknownPlaybacks;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$malePlaybacks = malePlaybacks;
    _resultData['malePlaybacks'] = l$malePlaybacks;
    final l$femalePlaybacks = femalePlaybacks;
    _resultData['femalePlaybacks'] = l$femalePlaybacks;
    final l$unknownPlaybacks = unknownPlaybacks;
    _resultData['unknownPlaybacks'] = l$unknownPlaybacks;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$malePlaybacks = malePlaybacks;
    final l$femalePlaybacks = femalePlaybacks;
    final l$unknownPlaybacks = unknownPlaybacks;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$malePlaybacks,
      l$femalePlaybacks,
      l$unknownPlaybacks,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetPlaybacksByGenderData$getPlaybacksByGenderData) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$malePlaybacks = malePlaybacks;
    final lOther$malePlaybacks = other.malePlaybacks;
    if (l$malePlaybacks != lOther$malePlaybacks) {
      return false;
    }
    final l$femalePlaybacks = femalePlaybacks;
    final lOther$femalePlaybacks = other.femalePlaybacks;
    if (l$femalePlaybacks != lOther$femalePlaybacks) {
      return false;
    }
    final l$unknownPlaybacks = unknownPlaybacks;
    final lOther$unknownPlaybacks = other.unknownPlaybacks;
    if (l$unknownPlaybacks != lOther$unknownPlaybacks) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetPlaybacksByGenderData$getPlaybacksByGenderData
    on Query$GetPlaybacksByGenderData$getPlaybacksByGenderData {
  CopyWith$Query$GetPlaybacksByGenderData$getPlaybacksByGenderData<
          Query$GetPlaybacksByGenderData$getPlaybacksByGenderData>
      get copyWith =>
          CopyWith$Query$GetPlaybacksByGenderData$getPlaybacksByGenderData(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetPlaybacksByGenderData$getPlaybacksByGenderData<
    TRes> {
  factory CopyWith$Query$GetPlaybacksByGenderData$getPlaybacksByGenderData(
    Query$GetPlaybacksByGenderData$getPlaybacksByGenderData instance,
    TRes Function(Query$GetPlaybacksByGenderData$getPlaybacksByGenderData) then,
  ) = _CopyWithImpl$Query$GetPlaybacksByGenderData$getPlaybacksByGenderData;

  factory CopyWith$Query$GetPlaybacksByGenderData$getPlaybacksByGenderData.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetPlaybacksByGenderData$getPlaybacksByGenderData;

  TRes call({
    int? malePlaybacks,
    int? femalePlaybacks,
    int? unknownPlaybacks,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetPlaybacksByGenderData$getPlaybacksByGenderData<
        TRes>
    implements
        CopyWith$Query$GetPlaybacksByGenderData$getPlaybacksByGenderData<TRes> {
  _CopyWithImpl$Query$GetPlaybacksByGenderData$getPlaybacksByGenderData(
    this._instance,
    this._then,
  );

  final Query$GetPlaybacksByGenderData$getPlaybacksByGenderData _instance;

  final TRes Function(Query$GetPlaybacksByGenderData$getPlaybacksByGenderData)
      _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? malePlaybacks = _undefined,
    Object? femalePlaybacks = _undefined,
    Object? unknownPlaybacks = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetPlaybacksByGenderData$getPlaybacksByGenderData(
        malePlaybacks: malePlaybacks == _undefined || malePlaybacks == null
            ? _instance.malePlaybacks
            : (malePlaybacks as int),
        femalePlaybacks:
            femalePlaybacks == _undefined || femalePlaybacks == null
                ? _instance.femalePlaybacks
                : (femalePlaybacks as int),
        unknownPlaybacks:
            unknownPlaybacks == _undefined || unknownPlaybacks == null
                ? _instance.unknownPlaybacks
                : (unknownPlaybacks as int),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetPlaybacksByGenderData$getPlaybacksByGenderData<
        TRes>
    implements
        CopyWith$Query$GetPlaybacksByGenderData$getPlaybacksByGenderData<TRes> {
  _CopyWithStubImpl$Query$GetPlaybacksByGenderData$getPlaybacksByGenderData(
      this._res);

  TRes _res;

  call({
    int? malePlaybacks,
    int? femalePlaybacks,
    int? unknownPlaybacks,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Query$GetPlaybacksByGenerationData {
  factory Variables$Query$GetPlaybacksByGenerationData({
    String? artistId,
    String? isrc,
    String? dsp,
    String? period,
  }) =>
      Variables$Query$GetPlaybacksByGenerationData._({
        if (artistId != null) r'artistId': artistId,
        if (isrc != null) r'isrc': isrc,
        if (dsp != null) r'dsp': dsp,
        if (period != null) r'period': period,
      });

  Variables$Query$GetPlaybacksByGenerationData._(this._$data);

  factory Variables$Query$GetPlaybacksByGenerationData.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('artistId')) {
      final l$artistId = data['artistId'];
      result$data['artistId'] = (l$artistId as String?);
    }
    if (data.containsKey('isrc')) {
      final l$isrc = data['isrc'];
      result$data['isrc'] = (l$isrc as String?);
    }
    if (data.containsKey('dsp')) {
      final l$dsp = data['dsp'];
      result$data['dsp'] = (l$dsp as String?);
    }
    if (data.containsKey('period')) {
      final l$period = data['period'];
      result$data['period'] = (l$period as String?);
    }
    return Variables$Query$GetPlaybacksByGenerationData._(result$data);
  }

  Map<String, dynamic> _$data;

  String? get artistId => (_$data['artistId'] as String?);

  String? get isrc => (_$data['isrc'] as String?);

  String? get dsp => (_$data['dsp'] as String?);

  String? get period => (_$data['period'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('artistId')) {
      final l$artistId = artistId;
      result$data['artistId'] = l$artistId;
    }
    if (_$data.containsKey('isrc')) {
      final l$isrc = isrc;
      result$data['isrc'] = l$isrc;
    }
    if (_$data.containsKey('dsp')) {
      final l$dsp = dsp;
      result$data['dsp'] = l$dsp;
    }
    if (_$data.containsKey('period')) {
      final l$period = period;
      result$data['period'] = l$period;
    }
    return result$data;
  }

  CopyWith$Variables$Query$GetPlaybacksByGenerationData<
          Variables$Query$GetPlaybacksByGenerationData>
      get copyWith => CopyWith$Variables$Query$GetPlaybacksByGenerationData(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$GetPlaybacksByGenerationData) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$artistId = artistId;
    final lOther$artistId = other.artistId;
    if (_$data.containsKey('artistId') !=
        other._$data.containsKey('artistId')) {
      return false;
    }
    if (l$artistId != lOther$artistId) {
      return false;
    }
    final l$isrc = isrc;
    final lOther$isrc = other.isrc;
    if (_$data.containsKey('isrc') != other._$data.containsKey('isrc')) {
      return false;
    }
    if (l$isrc != lOther$isrc) {
      return false;
    }
    final l$dsp = dsp;
    final lOther$dsp = other.dsp;
    if (_$data.containsKey('dsp') != other._$data.containsKey('dsp')) {
      return false;
    }
    if (l$dsp != lOther$dsp) {
      return false;
    }
    final l$period = period;
    final lOther$period = other.period;
    if (_$data.containsKey('period') != other._$data.containsKey('period')) {
      return false;
    }
    if (l$period != lOther$period) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$artistId = artistId;
    final l$isrc = isrc;
    final l$dsp = dsp;
    final l$period = period;
    return Object.hashAll([
      _$data.containsKey('artistId') ? l$artistId : const {},
      _$data.containsKey('isrc') ? l$isrc : const {},
      _$data.containsKey('dsp') ? l$dsp : const {},
      _$data.containsKey('period') ? l$period : const {},
    ]);
  }
}

abstract class CopyWith$Variables$Query$GetPlaybacksByGenerationData<TRes> {
  factory CopyWith$Variables$Query$GetPlaybacksByGenerationData(
    Variables$Query$GetPlaybacksByGenerationData instance,
    TRes Function(Variables$Query$GetPlaybacksByGenerationData) then,
  ) = _CopyWithImpl$Variables$Query$GetPlaybacksByGenerationData;

  factory CopyWith$Variables$Query$GetPlaybacksByGenerationData.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$GetPlaybacksByGenerationData;

  TRes call({
    String? artistId,
    String? isrc,
    String? dsp,
    String? period,
  });
}

class _CopyWithImpl$Variables$Query$GetPlaybacksByGenerationData<TRes>
    implements CopyWith$Variables$Query$GetPlaybacksByGenerationData<TRes> {
  _CopyWithImpl$Variables$Query$GetPlaybacksByGenerationData(
    this._instance,
    this._then,
  );

  final Variables$Query$GetPlaybacksByGenerationData _instance;

  final TRes Function(Variables$Query$GetPlaybacksByGenerationData) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? artistId = _undefined,
    Object? isrc = _undefined,
    Object? dsp = _undefined,
    Object? period = _undefined,
  }) =>
      _then(Variables$Query$GetPlaybacksByGenerationData._({
        ..._instance._$data,
        if (artistId != _undefined) 'artistId': (artistId as String?),
        if (isrc != _undefined) 'isrc': (isrc as String?),
        if (dsp != _undefined) 'dsp': (dsp as String?),
        if (period != _undefined) 'period': (period as String?),
      }));
}

class _CopyWithStubImpl$Variables$Query$GetPlaybacksByGenerationData<TRes>
    implements CopyWith$Variables$Query$GetPlaybacksByGenerationData<TRes> {
  _CopyWithStubImpl$Variables$Query$GetPlaybacksByGenerationData(this._res);

  TRes _res;

  call({
    String? artistId,
    String? isrc,
    String? dsp,
    String? period,
  }) =>
      _res;
}

class Query$GetPlaybacksByGenerationData {
  Query$GetPlaybacksByGenerationData({
    required this.getPlaybacksByGenerationData,
    this.$__typename = 'QueryRoot',
  });

  factory Query$GetPlaybacksByGenerationData.fromJson(
      Map<String, dynamic> json) {
    final l$getPlaybacksByGenerationData = json['getPlaybacksByGenerationData'];
    final l$$__typename = json['__typename'];
    return Query$GetPlaybacksByGenerationData(
      getPlaybacksByGenerationData:
          Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData
              .fromJson(
                  (l$getPlaybacksByGenerationData as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData
      getPlaybacksByGenerationData;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getPlaybacksByGenerationData = getPlaybacksByGenerationData;
    _resultData['getPlaybacksByGenerationData'] =
        l$getPlaybacksByGenerationData.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getPlaybacksByGenerationData = getPlaybacksByGenerationData;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$getPlaybacksByGenerationData,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetPlaybacksByGenerationData) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$getPlaybacksByGenerationData = getPlaybacksByGenerationData;
    final lOther$getPlaybacksByGenerationData =
        other.getPlaybacksByGenerationData;
    if (l$getPlaybacksByGenerationData != lOther$getPlaybacksByGenerationData) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetPlaybacksByGenerationData
    on Query$GetPlaybacksByGenerationData {
  CopyWith$Query$GetPlaybacksByGenerationData<
          Query$GetPlaybacksByGenerationData>
      get copyWith => CopyWith$Query$GetPlaybacksByGenerationData(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetPlaybacksByGenerationData<TRes> {
  factory CopyWith$Query$GetPlaybacksByGenerationData(
    Query$GetPlaybacksByGenerationData instance,
    TRes Function(Query$GetPlaybacksByGenerationData) then,
  ) = _CopyWithImpl$Query$GetPlaybacksByGenerationData;

  factory CopyWith$Query$GetPlaybacksByGenerationData.stub(TRes res) =
      _CopyWithStubImpl$Query$GetPlaybacksByGenerationData;

  TRes call({
    Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData?
        getPlaybacksByGenerationData,
    String? $__typename,
  });
  CopyWith$Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData<TRes>
      get getPlaybacksByGenerationData;
}

class _CopyWithImpl$Query$GetPlaybacksByGenerationData<TRes>
    implements CopyWith$Query$GetPlaybacksByGenerationData<TRes> {
  _CopyWithImpl$Query$GetPlaybacksByGenerationData(
    this._instance,
    this._then,
  );

  final Query$GetPlaybacksByGenerationData _instance;

  final TRes Function(Query$GetPlaybacksByGenerationData) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getPlaybacksByGenerationData = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetPlaybacksByGenerationData(
        getPlaybacksByGenerationData: getPlaybacksByGenerationData ==
                    _undefined ||
                getPlaybacksByGenerationData == null
            ? _instance.getPlaybacksByGenerationData
            : (getPlaybacksByGenerationData
                as Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData<TRes>
      get getPlaybacksByGenerationData {
    final local$getPlaybacksByGenerationData =
        _instance.getPlaybacksByGenerationData;
    return CopyWith$Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData(
        local$getPlaybacksByGenerationData,
        (e) => call(getPlaybacksByGenerationData: e));
  }
}

class _CopyWithStubImpl$Query$GetPlaybacksByGenerationData<TRes>
    implements CopyWith$Query$GetPlaybacksByGenerationData<TRes> {
  _CopyWithStubImpl$Query$GetPlaybacksByGenerationData(this._res);

  TRes _res;

  call({
    Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData?
        getPlaybacksByGenerationData,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData<TRes>
      get getPlaybacksByGenerationData =>
          CopyWith$Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData
              .stub(_res);
}

const documentNodeQueryGetPlaybacksByGenerationData =
    DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetPlaybacksByGenerationData'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'artistId')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'isrc')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'dsp')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'period')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'getPlaybacksByGenerationData'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'artistId'),
            value: VariableNode(name: NameNode(value: 'artistId')),
          ),
          ArgumentNode(
            name: NameNode(value: 'isrc'),
            value: VariableNode(name: NameNode(value: 'isrc')),
          ),
          ArgumentNode(
            name: NameNode(value: 'dsp'),
            value: VariableNode(name: NameNode(value: 'dsp')),
          ),
          ArgumentNode(
            name: NameNode(value: 'period'),
            value: VariableNode(name: NameNode(value: 'period')),
          ),
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'playbacksOver60'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'playbacks50S'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'playbacks40S'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'playbacks30S'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'playbacks20S'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'playbacksUnder10S'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$GetPlaybacksByGenerationData _parserFn$Query$GetPlaybacksByGenerationData(
        Map<String, dynamic> data) =>
    Query$GetPlaybacksByGenerationData.fromJson(data);
typedef OnQueryComplete$Query$GetPlaybacksByGenerationData = FutureOr<void>
    Function(
  Map<String, dynamic>?,
  Query$GetPlaybacksByGenerationData?,
);

class Options$Query$GetPlaybacksByGenerationData
    extends graphql.QueryOptions<Query$GetPlaybacksByGenerationData> {
  Options$Query$GetPlaybacksByGenerationData({
    String? operationName,
    Variables$Query$GetPlaybacksByGenerationData? variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetPlaybacksByGenerationData? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetPlaybacksByGenerationData? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          variables: variables?.toJson() ?? {},
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null
                        ? null
                        : _parserFn$Query$GetPlaybacksByGenerationData(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetPlaybacksByGenerationData,
          parserFn: _parserFn$Query$GetPlaybacksByGenerationData,
        );

  final OnQueryComplete$Query$GetPlaybacksByGenerationData?
      onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetPlaybacksByGenerationData
    extends graphql.WatchQueryOptions<Query$GetPlaybacksByGenerationData> {
  WatchOptions$Query$GetPlaybacksByGenerationData({
    String? operationName,
    Variables$Query$GetPlaybacksByGenerationData? variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetPlaybacksByGenerationData? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables?.toJson() ?? {},
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryGetPlaybacksByGenerationData,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetPlaybacksByGenerationData,
        );
}

class FetchMoreOptions$Query$GetPlaybacksByGenerationData
    extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetPlaybacksByGenerationData({
    required graphql.UpdateQuery updateQuery,
    Variables$Query$GetPlaybacksByGenerationData? variables,
  }) : super(
          updateQuery: updateQuery,
          variables: variables?.toJson() ?? {},
          document: documentNodeQueryGetPlaybacksByGenerationData,
        );
}

extension ClientExtension$Query$GetPlaybacksByGenerationData
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetPlaybacksByGenerationData>>
      query$GetPlaybacksByGenerationData(
              [Options$Query$GetPlaybacksByGenerationData? options]) async =>
          await this
              .query(options ?? Options$Query$GetPlaybacksByGenerationData());
  graphql.ObservableQuery<Query$GetPlaybacksByGenerationData>
      watchQuery$GetPlaybacksByGenerationData(
              [WatchOptions$Query$GetPlaybacksByGenerationData? options]) =>
          this.watchQuery(
              options ?? WatchOptions$Query$GetPlaybacksByGenerationData());
  void writeQuery$GetPlaybacksByGenerationData({
    required Query$GetPlaybacksByGenerationData data,
    Variables$Query$GetPlaybacksByGenerationData? variables,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
          operation: graphql.Operation(
              document: documentNodeQueryGetPlaybacksByGenerationData),
          variables: variables?.toJson() ?? const {},
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetPlaybacksByGenerationData? readQuery$GetPlaybacksByGenerationData({
    Variables$Query$GetPlaybacksByGenerationData? variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(
            document: documentNodeQueryGetPlaybacksByGenerationData),
        variables: variables?.toJson() ?? const {},
      ),
      optimistic: optimistic,
    );
    return result == null
        ? null
        : Query$GetPlaybacksByGenerationData.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetPlaybacksByGenerationData>
    useQuery$GetPlaybacksByGenerationData(
            [Options$Query$GetPlaybacksByGenerationData? options]) =>
        graphql_flutter
            .useQuery(options ?? Options$Query$GetPlaybacksByGenerationData());
graphql.ObservableQuery<Query$GetPlaybacksByGenerationData>
    useWatchQuery$GetPlaybacksByGenerationData(
            [WatchOptions$Query$GetPlaybacksByGenerationData? options]) =>
        graphql_flutter.useWatchQuery(
            options ?? WatchOptions$Query$GetPlaybacksByGenerationData());

class Query$GetPlaybacksByGenerationData$Widget
    extends graphql_flutter.Query<Query$GetPlaybacksByGenerationData> {
  Query$GetPlaybacksByGenerationData$Widget({
    widgets.Key? key,
    Options$Query$GetPlaybacksByGenerationData? options,
    required graphql_flutter.QueryBuilder<Query$GetPlaybacksByGenerationData>
        builder,
  }) : super(
          key: key,
          options: options ?? Options$Query$GetPlaybacksByGenerationData(),
          builder: builder,
        );
}

class Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData {
  Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData({
    required this.playbacksOver60,
    required this.playbacks50S,
    required this.playbacks40S,
    required this.playbacks30S,
    required this.playbacks20S,
    required this.playbacksUnder10S,
    this.$__typename = 'PlaybacksByGenerationData',
  });

  factory Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData.fromJson(
      Map<String, dynamic> json) {
    final l$playbacksOver60 = json['playbacksOver60'];
    final l$playbacks50S = json['playbacks50S'];
    final l$playbacks40S = json['playbacks40S'];
    final l$playbacks30S = json['playbacks30S'];
    final l$playbacks20S = json['playbacks20S'];
    final l$playbacksUnder10S = json['playbacksUnder10S'];
    final l$$__typename = json['__typename'];
    return Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData(
      playbacksOver60: (l$playbacksOver60 as int),
      playbacks50S: (l$playbacks50S as int),
      playbacks40S: (l$playbacks40S as int),
      playbacks30S: (l$playbacks30S as int),
      playbacks20S: (l$playbacks20S as int),
      playbacksUnder10S: (l$playbacksUnder10S as int),
      $__typename: (l$$__typename as String),
    );
  }

  final int playbacksOver60;

  final int playbacks50S;

  final int playbacks40S;

  final int playbacks30S;

  final int playbacks20S;

  final int playbacksUnder10S;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$playbacksOver60 = playbacksOver60;
    _resultData['playbacksOver60'] = l$playbacksOver60;
    final l$playbacks50S = playbacks50S;
    _resultData['playbacks50S'] = l$playbacks50S;
    final l$playbacks40S = playbacks40S;
    _resultData['playbacks40S'] = l$playbacks40S;
    final l$playbacks30S = playbacks30S;
    _resultData['playbacks30S'] = l$playbacks30S;
    final l$playbacks20S = playbacks20S;
    _resultData['playbacks20S'] = l$playbacks20S;
    final l$playbacksUnder10S = playbacksUnder10S;
    _resultData['playbacksUnder10S'] = l$playbacksUnder10S;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$playbacksOver60 = playbacksOver60;
    final l$playbacks50S = playbacks50S;
    final l$playbacks40S = playbacks40S;
    final l$playbacks30S = playbacks30S;
    final l$playbacks20S = playbacks20S;
    final l$playbacksUnder10S = playbacksUnder10S;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$playbacksOver60,
      l$playbacks50S,
      l$playbacks40S,
      l$playbacks30S,
      l$playbacks20S,
      l$playbacksUnder10S,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other
            is Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$playbacksOver60 = playbacksOver60;
    final lOther$playbacksOver60 = other.playbacksOver60;
    if (l$playbacksOver60 != lOther$playbacksOver60) {
      return false;
    }
    final l$playbacks50S = playbacks50S;
    final lOther$playbacks50S = other.playbacks50S;
    if (l$playbacks50S != lOther$playbacks50S) {
      return false;
    }
    final l$playbacks40S = playbacks40S;
    final lOther$playbacks40S = other.playbacks40S;
    if (l$playbacks40S != lOther$playbacks40S) {
      return false;
    }
    final l$playbacks30S = playbacks30S;
    final lOther$playbacks30S = other.playbacks30S;
    if (l$playbacks30S != lOther$playbacks30S) {
      return false;
    }
    final l$playbacks20S = playbacks20S;
    final lOther$playbacks20S = other.playbacks20S;
    if (l$playbacks20S != lOther$playbacks20S) {
      return false;
    }
    final l$playbacksUnder10S = playbacksUnder10S;
    final lOther$playbacksUnder10S = other.playbacksUnder10S;
    if (l$playbacksUnder10S != lOther$playbacksUnder10S) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData
    on Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData {
  CopyWith$Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData<
          Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData>
      get copyWith =>
          CopyWith$Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData<
    TRes> {
  factory CopyWith$Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData(
    Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData instance,
    TRes Function(
            Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData)
        then,
  ) = _CopyWithImpl$Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData;

  factory CopyWith$Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData;

  TRes call({
    int? playbacksOver60,
    int? playbacks50S,
    int? playbacks40S,
    int? playbacks30S,
    int? playbacks20S,
    int? playbacksUnder10S,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData<
        TRes>
    implements
        CopyWith$Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData<
            TRes> {
  _CopyWithImpl$Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData(
    this._instance,
    this._then,
  );

  final Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData
      _instance;

  final TRes Function(
      Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? playbacksOver60 = _undefined,
    Object? playbacks50S = _undefined,
    Object? playbacks40S = _undefined,
    Object? playbacks30S = _undefined,
    Object? playbacks20S = _undefined,
    Object? playbacksUnder10S = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData(
        playbacksOver60:
            playbacksOver60 == _undefined || playbacksOver60 == null
                ? _instance.playbacksOver60
                : (playbacksOver60 as int),
        playbacks50S: playbacks50S == _undefined || playbacks50S == null
            ? _instance.playbacks50S
            : (playbacks50S as int),
        playbacks40S: playbacks40S == _undefined || playbacks40S == null
            ? _instance.playbacks40S
            : (playbacks40S as int),
        playbacks30S: playbacks30S == _undefined || playbacks30S == null
            ? _instance.playbacks30S
            : (playbacks30S as int),
        playbacks20S: playbacks20S == _undefined || playbacks20S == null
            ? _instance.playbacks20S
            : (playbacks20S as int),
        playbacksUnder10S:
            playbacksUnder10S == _undefined || playbacksUnder10S == null
                ? _instance.playbacksUnder10S
                : (playbacksUnder10S as int),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData<
        TRes>
    implements
        CopyWith$Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData<
            TRes> {
  _CopyWithStubImpl$Query$GetPlaybacksByGenerationData$getPlaybacksByGenerationData(
      this._res);

  TRes _res;

  call({
    int? playbacksOver60,
    int? playbacks50S,
    int? playbacks40S,
    int? playbacks30S,
    int? playbacks20S,
    int? playbacksUnder10S,
    String? $__typename,
  }) =>
      _res;
}

class Query$GetCommunities {
  Query$GetCommunities({
    required this.getCommunities,
    this.$__typename = 'QueryRoot',
  });

  factory Query$GetCommunities.fromJson(Map<String, dynamic> json) {
    final l$getCommunities = json['getCommunities'];
    final l$$__typename = json['__typename'];
    return Query$GetCommunities(
      getCommunities: Query$GetCommunities$getCommunities.fromJson(
          (l$getCommunities as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetCommunities$getCommunities getCommunities;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getCommunities = getCommunities;
    _resultData['getCommunities'] = l$getCommunities.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getCommunities = getCommunities;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$getCommunities,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetCommunities) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$getCommunities = getCommunities;
    final lOther$getCommunities = other.getCommunities;
    if (l$getCommunities != lOther$getCommunities) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetCommunities on Query$GetCommunities {
  CopyWith$Query$GetCommunities<Query$GetCommunities> get copyWith =>
      CopyWith$Query$GetCommunities(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetCommunities<TRes> {
  factory CopyWith$Query$GetCommunities(
    Query$GetCommunities instance,
    TRes Function(Query$GetCommunities) then,
  ) = _CopyWithImpl$Query$GetCommunities;

  factory CopyWith$Query$GetCommunities.stub(TRes res) =
      _CopyWithStubImpl$Query$GetCommunities;

  TRes call({
    Query$GetCommunities$getCommunities? getCommunities,
    String? $__typename,
  });
  CopyWith$Query$GetCommunities$getCommunities<TRes> get getCommunities;
}

class _CopyWithImpl$Query$GetCommunities<TRes>
    implements CopyWith$Query$GetCommunities<TRes> {
  _CopyWithImpl$Query$GetCommunities(
    this._instance,
    this._then,
  );

  final Query$GetCommunities _instance;

  final TRes Function(Query$GetCommunities) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getCommunities = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetCommunities(
        getCommunities: getCommunities == _undefined || getCommunities == null
            ? _instance.getCommunities
            : (getCommunities as Query$GetCommunities$getCommunities),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetCommunities$getCommunities<TRes> get getCommunities {
    final local$getCommunities = _instance.getCommunities;
    return CopyWith$Query$GetCommunities$getCommunities(
        local$getCommunities, (e) => call(getCommunities: e));
  }
}

class _CopyWithStubImpl$Query$GetCommunities<TRes>
    implements CopyWith$Query$GetCommunities<TRes> {
  _CopyWithStubImpl$Query$GetCommunities(this._res);

  TRes _res;

  call({
    Query$GetCommunities$getCommunities? getCommunities,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetCommunities$getCommunities<TRes> get getCommunities =>
      CopyWith$Query$GetCommunities$getCommunities.stub(_res);
}

const documentNodeQueryGetCommunities = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetCommunities'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'getCommunities'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'connectedUserList'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'connectedUser'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: SelectionSetNode(selections: [
                  FieldNode(
                    name: NameNode(value: 'id'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'name'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'imageUrl'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'role'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'primaryRole'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'primaryArtist'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FieldNode(
                        name: NameNode(value: 'id'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'name'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'imageUrl'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'fsp'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'status'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'isAdmin'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: '__typename'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                    ]),
                  ),
                  FieldNode(
                    name: NameNode(value: '__typename'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                ]),
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: 'countOfUsers'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$GetCommunities _parserFn$Query$GetCommunities(
        Map<String, dynamic> data) =>
    Query$GetCommunities.fromJson(data);
typedef OnQueryComplete$Query$GetCommunities = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$GetCommunities?,
);

class Options$Query$GetCommunities
    extends graphql.QueryOptions<Query$GetCommunities> {
  Options$Query$GetCommunities({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetCommunities? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetCommunities? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null ? null : _parserFn$Query$GetCommunities(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetCommunities,
          parserFn: _parserFn$Query$GetCommunities,
        );

  final OnQueryComplete$Query$GetCommunities? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetCommunities
    extends graphql.WatchQueryOptions<Query$GetCommunities> {
  WatchOptions$Query$GetCommunities({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetCommunities? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryGetCommunities,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetCommunities,
        );
}

class FetchMoreOptions$Query$GetCommunities extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetCommunities(
      {required graphql.UpdateQuery updateQuery})
      : super(
          updateQuery: updateQuery,
          document: documentNodeQueryGetCommunities,
        );
}

extension ClientExtension$Query$GetCommunities on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetCommunities>> query$GetCommunities(
          [Options$Query$GetCommunities? options]) async =>
      await this.query(options ?? Options$Query$GetCommunities());
  graphql.ObservableQuery<Query$GetCommunities> watchQuery$GetCommunities(
          [WatchOptions$Query$GetCommunities? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$GetCommunities());
  void writeQuery$GetCommunities({
    required Query$GetCommunities data,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
            operation:
                graphql.Operation(document: documentNodeQueryGetCommunities)),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetCommunities? readQuery$GetCommunities({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
          operation:
              graphql.Operation(document: documentNodeQueryGetCommunities)),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetCommunities.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetCommunities> useQuery$GetCommunities(
        [Options$Query$GetCommunities? options]) =>
    graphql_flutter.useQuery(options ?? Options$Query$GetCommunities());
graphql.ObservableQuery<Query$GetCommunities> useWatchQuery$GetCommunities(
        [WatchOptions$Query$GetCommunities? options]) =>
    graphql_flutter
        .useWatchQuery(options ?? WatchOptions$Query$GetCommunities());

class Query$GetCommunities$Widget
    extends graphql_flutter.Query<Query$GetCommunities> {
  Query$GetCommunities$Widget({
    widgets.Key? key,
    Options$Query$GetCommunities? options,
    required graphql_flutter.QueryBuilder<Query$GetCommunities> builder,
  }) : super(
          key: key,
          options: options ?? Options$Query$GetCommunities(),
          builder: builder,
        );
}

class Query$GetCommunities$getCommunities {
  Query$GetCommunities$getCommunities({
    required this.connectedUserList,
    this.countOfUsers,
    this.$__typename = 'ConnectedUsersData',
  });

  factory Query$GetCommunities$getCommunities.fromJson(
      Map<String, dynamic> json) {
    final l$connectedUserList = json['connectedUserList'];
    final l$countOfUsers = json['countOfUsers'];
    final l$$__typename = json['__typename'];
    return Query$GetCommunities$getCommunities(
      connectedUserList: (l$connectedUserList as List<dynamic>)
          .map((e) =>
              Query$GetCommunities$getCommunities$connectedUserList.fromJson(
                  (e as Map<String, dynamic>)))
          .toList(),
      countOfUsers: (l$countOfUsers as int?),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$GetCommunities$getCommunities$connectedUserList>
      connectedUserList;

  final int? countOfUsers;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$connectedUserList = connectedUserList;
    _resultData['connectedUserList'] =
        l$connectedUserList.map((e) => e.toJson()).toList();
    final l$countOfUsers = countOfUsers;
    _resultData['countOfUsers'] = l$countOfUsers;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$connectedUserList = connectedUserList;
    final l$countOfUsers = countOfUsers;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$connectedUserList.map((v) => v)),
      l$countOfUsers,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetCommunities$getCommunities) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$connectedUserList = connectedUserList;
    final lOther$connectedUserList = other.connectedUserList;
    if (l$connectedUserList.length != lOther$connectedUserList.length) {
      return false;
    }
    for (int i = 0; i < l$connectedUserList.length; i++) {
      final l$connectedUserList$entry = l$connectedUserList[i];
      final lOther$connectedUserList$entry = lOther$connectedUserList[i];
      if (l$connectedUserList$entry != lOther$connectedUserList$entry) {
        return false;
      }
    }
    final l$countOfUsers = countOfUsers;
    final lOther$countOfUsers = other.countOfUsers;
    if (l$countOfUsers != lOther$countOfUsers) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetCommunities$getCommunities
    on Query$GetCommunities$getCommunities {
  CopyWith$Query$GetCommunities$getCommunities<
          Query$GetCommunities$getCommunities>
      get copyWith => CopyWith$Query$GetCommunities$getCommunities(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetCommunities$getCommunities<TRes> {
  factory CopyWith$Query$GetCommunities$getCommunities(
    Query$GetCommunities$getCommunities instance,
    TRes Function(Query$GetCommunities$getCommunities) then,
  ) = _CopyWithImpl$Query$GetCommunities$getCommunities;

  factory CopyWith$Query$GetCommunities$getCommunities.stub(TRes res) =
      _CopyWithStubImpl$Query$GetCommunities$getCommunities;

  TRes call({
    List<Query$GetCommunities$getCommunities$connectedUserList>?
        connectedUserList,
    int? countOfUsers,
    String? $__typename,
  });
  TRes connectedUserList(
      Iterable<Query$GetCommunities$getCommunities$connectedUserList> Function(
              Iterable<
                  CopyWith$Query$GetCommunities$getCommunities$connectedUserList<
                      Query$GetCommunities$getCommunities$connectedUserList>>)
          _fn);
}

class _CopyWithImpl$Query$GetCommunities$getCommunities<TRes>
    implements CopyWith$Query$GetCommunities$getCommunities<TRes> {
  _CopyWithImpl$Query$GetCommunities$getCommunities(
    this._instance,
    this._then,
  );

  final Query$GetCommunities$getCommunities _instance;

  final TRes Function(Query$GetCommunities$getCommunities) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? connectedUserList = _undefined,
    Object? countOfUsers = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetCommunities$getCommunities(
        connectedUserList: connectedUserList == _undefined ||
                connectedUserList == null
            ? _instance.connectedUserList
            : (connectedUserList
                as List<Query$GetCommunities$getCommunities$connectedUserList>),
        countOfUsers: countOfUsers == _undefined
            ? _instance.countOfUsers
            : (countOfUsers as int?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes connectedUserList(
          Iterable<Query$GetCommunities$getCommunities$connectedUserList> Function(
                  Iterable<
                      CopyWith$Query$GetCommunities$getCommunities$connectedUserList<
                          Query$GetCommunities$getCommunities$connectedUserList>>)
              _fn) =>
      call(
          connectedUserList: _fn(_instance.connectedUserList.map((e) =>
              CopyWith$Query$GetCommunities$getCommunities$connectedUserList(
                e,
                (i) => i,
              ))).toList());
}

class _CopyWithStubImpl$Query$GetCommunities$getCommunities<TRes>
    implements CopyWith$Query$GetCommunities$getCommunities<TRes> {
  _CopyWithStubImpl$Query$GetCommunities$getCommunities(this._res);

  TRes _res;

  call({
    List<Query$GetCommunities$getCommunities$connectedUserList>?
        connectedUserList,
    int? countOfUsers,
    String? $__typename,
  }) =>
      _res;

  connectedUserList(_fn) => _res;
}

class Query$GetCommunities$getCommunities$connectedUserList {
  Query$GetCommunities$getCommunities$connectedUserList({
    required this.id,
    required this.connectedUser,
    this.$__typename = 'ConnectedUserByUserData',
  });

  factory Query$GetCommunities$getCommunities$connectedUserList.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$connectedUser = json['connectedUser'];
    final l$$__typename = json['__typename'];
    return Query$GetCommunities$getCommunities$connectedUserList(
      id: (l$id as String),
      connectedUser:
          Query$GetCommunities$getCommunities$connectedUserList$connectedUser
              .fromJson((l$connectedUser as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final Query$GetCommunities$getCommunities$connectedUserList$connectedUser
      connectedUser;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$connectedUser = connectedUser;
    _resultData['connectedUser'] = l$connectedUser.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$connectedUser = connectedUser;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$connectedUser,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetCommunities$getCommunities$connectedUserList) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$connectedUser = connectedUser;
    final lOther$connectedUser = other.connectedUser;
    if (l$connectedUser != lOther$connectedUser) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetCommunities$getCommunities$connectedUserList
    on Query$GetCommunities$getCommunities$connectedUserList {
  CopyWith$Query$GetCommunities$getCommunities$connectedUserList<
          Query$GetCommunities$getCommunities$connectedUserList>
      get copyWith =>
          CopyWith$Query$GetCommunities$getCommunities$connectedUserList(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetCommunities$getCommunities$connectedUserList<
    TRes> {
  factory CopyWith$Query$GetCommunities$getCommunities$connectedUserList(
    Query$GetCommunities$getCommunities$connectedUserList instance,
    TRes Function(Query$GetCommunities$getCommunities$connectedUserList) then,
  ) = _CopyWithImpl$Query$GetCommunities$getCommunities$connectedUserList;

  factory CopyWith$Query$GetCommunities$getCommunities$connectedUserList.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetCommunities$getCommunities$connectedUserList;

  TRes call({
    String? id,
    Query$GetCommunities$getCommunities$connectedUserList$connectedUser?
        connectedUser,
    String? $__typename,
  });
  CopyWith$Query$GetCommunities$getCommunities$connectedUserList$connectedUser<
      TRes> get connectedUser;
}

class _CopyWithImpl$Query$GetCommunities$getCommunities$connectedUserList<TRes>
    implements
        CopyWith$Query$GetCommunities$getCommunities$connectedUserList<TRes> {
  _CopyWithImpl$Query$GetCommunities$getCommunities$connectedUserList(
    this._instance,
    this._then,
  );

  final Query$GetCommunities$getCommunities$connectedUserList _instance;

  final TRes Function(Query$GetCommunities$getCommunities$connectedUserList)
      _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? connectedUser = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetCommunities$getCommunities$connectedUserList(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        connectedUser: connectedUser == _undefined || connectedUser == null
            ? _instance.connectedUser
            : (connectedUser
                as Query$GetCommunities$getCommunities$connectedUserList$connectedUser),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetCommunities$getCommunities$connectedUserList$connectedUser<
      TRes> get connectedUser {
    final local$connectedUser = _instance.connectedUser;
    return CopyWith$Query$GetCommunities$getCommunities$connectedUserList$connectedUser(
        local$connectedUser, (e) => call(connectedUser: e));
  }
}

class _CopyWithStubImpl$Query$GetCommunities$getCommunities$connectedUserList<
        TRes>
    implements
        CopyWith$Query$GetCommunities$getCommunities$connectedUserList<TRes> {
  _CopyWithStubImpl$Query$GetCommunities$getCommunities$connectedUserList(
      this._res);

  TRes _res;

  call({
    String? id,
    Query$GetCommunities$getCommunities$connectedUserList$connectedUser?
        connectedUser,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetCommunities$getCommunities$connectedUserList$connectedUser<
          TRes>
      get connectedUser =>
          CopyWith$Query$GetCommunities$getCommunities$connectedUserList$connectedUser
              .stub(_res);
}

class Query$GetCommunities$getCommunities$connectedUserList$connectedUser {
  Query$GetCommunities$getCommunities$connectedUserList$connectedUser({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.role,
    required this.primaryRole,
    this.primaryArtist,
    this.$__typename = 'UserBasicData',
  });

  factory Query$GetCommunities$getCommunities$connectedUserList$connectedUser.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$imageUrl = json['imageUrl'];
    final l$role = json['role'];
    final l$primaryRole = json['primaryRole'];
    final l$primaryArtist = json['primaryArtist'];
    final l$$__typename = json['__typename'];
    return Query$GetCommunities$getCommunities$connectedUserList$connectedUser(
      id: (l$id as String),
      name: (l$name as String),
      imageUrl: (l$imageUrl as String?),
      role: (l$role as String),
      primaryRole: (l$primaryRole as String),
      primaryArtist: l$primaryArtist == null
          ? null
          : Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist
              .fromJson((l$primaryArtist as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String name;

  final String? imageUrl;

  final String role;

  final String primaryRole;

  final Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist?
      primaryArtist;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$imageUrl = imageUrl;
    _resultData['imageUrl'] = l$imageUrl;
    final l$role = role;
    _resultData['role'] = l$role;
    final l$primaryRole = primaryRole;
    _resultData['primaryRole'] = l$primaryRole;
    final l$primaryArtist = primaryArtist;
    _resultData['primaryArtist'] = l$primaryArtist?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$imageUrl = imageUrl;
    final l$role = role;
    final l$primaryRole = primaryRole;
    final l$primaryArtist = primaryArtist;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$name,
      l$imageUrl,
      l$role,
      l$primaryRole,
      l$primaryArtist,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other
            is Query$GetCommunities$getCommunities$connectedUserList$connectedUser) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$imageUrl = imageUrl;
    final lOther$imageUrl = other.imageUrl;
    if (l$imageUrl != lOther$imageUrl) {
      return false;
    }
    final l$role = role;
    final lOther$role = other.role;
    if (l$role != lOther$role) {
      return false;
    }
    final l$primaryRole = primaryRole;
    final lOther$primaryRole = other.primaryRole;
    if (l$primaryRole != lOther$primaryRole) {
      return false;
    }
    final l$primaryArtist = primaryArtist;
    final lOther$primaryArtist = other.primaryArtist;
    if (l$primaryArtist != lOther$primaryArtist) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetCommunities$getCommunities$connectedUserList$connectedUser
    on Query$GetCommunities$getCommunities$connectedUserList$connectedUser {
  CopyWith$Query$GetCommunities$getCommunities$connectedUserList$connectedUser<
          Query$GetCommunities$getCommunities$connectedUserList$connectedUser>
      get copyWith =>
          CopyWith$Query$GetCommunities$getCommunities$connectedUserList$connectedUser(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetCommunities$getCommunities$connectedUserList$connectedUser<
    TRes> {
  factory CopyWith$Query$GetCommunities$getCommunities$connectedUserList$connectedUser(
    Query$GetCommunities$getCommunities$connectedUserList$connectedUser
        instance,
    TRes Function(
            Query$GetCommunities$getCommunities$connectedUserList$connectedUser)
        then,
  ) = _CopyWithImpl$Query$GetCommunities$getCommunities$connectedUserList$connectedUser;

  factory CopyWith$Query$GetCommunities$getCommunities$connectedUserList$connectedUser.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetCommunities$getCommunities$connectedUserList$connectedUser;

  TRes call({
    String? id,
    String? name,
    String? imageUrl,
    String? role,
    String? primaryRole,
    Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist?
        primaryArtist,
    String? $__typename,
  });
  CopyWith$Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist<
      TRes> get primaryArtist;
}

class _CopyWithImpl$Query$GetCommunities$getCommunities$connectedUserList$connectedUser<
        TRes>
    implements
        CopyWith$Query$GetCommunities$getCommunities$connectedUserList$connectedUser<
            TRes> {
  _CopyWithImpl$Query$GetCommunities$getCommunities$connectedUserList$connectedUser(
    this._instance,
    this._then,
  );

  final Query$GetCommunities$getCommunities$connectedUserList$connectedUser
      _instance;

  final TRes Function(
          Query$GetCommunities$getCommunities$connectedUserList$connectedUser)
      _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? imageUrl = _undefined,
    Object? role = _undefined,
    Object? primaryRole = _undefined,
    Object? primaryArtist = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetCommunities$getCommunities$connectedUserList$connectedUser(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        imageUrl:
            imageUrl == _undefined ? _instance.imageUrl : (imageUrl as String?),
        role: role == _undefined || role == null
            ? _instance.role
            : (role as String),
        primaryRole: primaryRole == _undefined || primaryRole == null
            ? _instance.primaryRole
            : (primaryRole as String),
        primaryArtist: primaryArtist == _undefined
            ? _instance.primaryArtist
            : (primaryArtist
                as Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist<
      TRes> get primaryArtist {
    final local$primaryArtist = _instance.primaryArtist;
    return local$primaryArtist == null
        ? CopyWith$Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist
            .stub(_then(_instance))
        : CopyWith$Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist(
            local$primaryArtist, (e) => call(primaryArtist: e));
  }
}

class _CopyWithStubImpl$Query$GetCommunities$getCommunities$connectedUserList$connectedUser<
        TRes>
    implements
        CopyWith$Query$GetCommunities$getCommunities$connectedUserList$connectedUser<
            TRes> {
  _CopyWithStubImpl$Query$GetCommunities$getCommunities$connectedUserList$connectedUser(
      this._res);

  TRes _res;

  call({
    String? id,
    String? name,
    String? imageUrl,
    String? role,
    String? primaryRole,
    Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist?
        primaryArtist,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist<
          TRes>
      get primaryArtist =>
          CopyWith$Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist
              .stub(_res);
}

class Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist {
  Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.fsp,
    required this.status,
    required this.isAdmin,
    this.$__typename = 'ArtistByUserData',
  });

  factory Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$imageUrl = json['imageUrl'];
    final l$fsp = json['fsp'];
    final l$status = json['status'];
    final l$isAdmin = json['isAdmin'];
    final l$$__typename = json['__typename'];
    return Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist(
      id: (l$id as String),
      name: (l$name as String),
      imageUrl: (l$imageUrl as String?),
      fsp: (l$fsp as int),
      status: (l$status as String),
      isAdmin: (l$isAdmin as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String name;

  final String? imageUrl;

  final int fsp;

  final String status;

  final bool isAdmin;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$imageUrl = imageUrl;
    _resultData['imageUrl'] = l$imageUrl;
    final l$fsp = fsp;
    _resultData['fsp'] = l$fsp;
    final l$status = status;
    _resultData['status'] = l$status;
    final l$isAdmin = isAdmin;
    _resultData['isAdmin'] = l$isAdmin;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$imageUrl = imageUrl;
    final l$fsp = fsp;
    final l$status = status;
    final l$isAdmin = isAdmin;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$name,
      l$imageUrl,
      l$fsp,
      l$status,
      l$isAdmin,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other
            is Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$imageUrl = imageUrl;
    final lOther$imageUrl = other.imageUrl;
    if (l$imageUrl != lOther$imageUrl) {
      return false;
    }
    final l$fsp = fsp;
    final lOther$fsp = other.fsp;
    if (l$fsp != lOther$fsp) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    final l$isAdmin = isAdmin;
    final lOther$isAdmin = other.isAdmin;
    if (l$isAdmin != lOther$isAdmin) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist
    on Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist {
  CopyWith$Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist<
          Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist>
      get copyWith =>
          CopyWith$Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist<
    TRes> {
  factory CopyWith$Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist(
    Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist
        instance,
    TRes Function(
            Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist)
        then,
  ) = _CopyWithImpl$Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist;

  factory CopyWith$Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist;

  TRes call({
    String? id,
    String? name,
    String? imageUrl,
    int? fsp,
    String? status,
    bool? isAdmin,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist<
        TRes>
    implements
        CopyWith$Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist<
            TRes> {
  _CopyWithImpl$Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist(
    this._instance,
    this._then,
  );

  final Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist
      _instance;

  final TRes Function(
          Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist)
      _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? imageUrl = _undefined,
    Object? fsp = _undefined,
    Object? status = _undefined,
    Object? isAdmin = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(
          Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        imageUrl:
            imageUrl == _undefined ? _instance.imageUrl : (imageUrl as String?),
        fsp: fsp == _undefined || fsp == null ? _instance.fsp : (fsp as int),
        status: status == _undefined || status == null
            ? _instance.status
            : (status as String),
        isAdmin: isAdmin == _undefined || isAdmin == null
            ? _instance.isAdmin
            : (isAdmin as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist<
        TRes>
    implements
        CopyWith$Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist<
            TRes> {
  _CopyWithStubImpl$Query$GetCommunities$getCommunities$connectedUserList$connectedUser$primaryArtist(
      this._res);

  TRes _res;

  call({
    String? id,
    String? name,
    String? imageUrl,
    int? fsp,
    String? status,
    bool? isAdmin,
    String? $__typename,
  }) =>
      _res;
}

class Query$GetUserInfo {
  Query$GetUserInfo({
    required this.getUserInfo,
    this.$__typename = 'QueryRoot',
  });

  factory Query$GetUserInfo.fromJson(Map<String, dynamic> json) {
    final l$getUserInfo = json['getUserInfo'];
    final l$$__typename = json['__typename'];
    return Query$GetUserInfo(
      getUserInfo: Query$GetUserInfo$getUserInfo.fromJson(
          (l$getUserInfo as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetUserInfo$getUserInfo getUserInfo;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getUserInfo = getUserInfo;
    _resultData['getUserInfo'] = l$getUserInfo.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getUserInfo = getUserInfo;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$getUserInfo,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetUserInfo) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$getUserInfo = getUserInfo;
    final lOther$getUserInfo = other.getUserInfo;
    if (l$getUserInfo != lOther$getUserInfo) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetUserInfo on Query$GetUserInfo {
  CopyWith$Query$GetUserInfo<Query$GetUserInfo> get copyWith =>
      CopyWith$Query$GetUserInfo(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetUserInfo<TRes> {
  factory CopyWith$Query$GetUserInfo(
    Query$GetUserInfo instance,
    TRes Function(Query$GetUserInfo) then,
  ) = _CopyWithImpl$Query$GetUserInfo;

  factory CopyWith$Query$GetUserInfo.stub(TRes res) =
      _CopyWithStubImpl$Query$GetUserInfo;

  TRes call({
    Query$GetUserInfo$getUserInfo? getUserInfo,
    String? $__typename,
  });
  CopyWith$Query$GetUserInfo$getUserInfo<TRes> get getUserInfo;
}

class _CopyWithImpl$Query$GetUserInfo<TRes>
    implements CopyWith$Query$GetUserInfo<TRes> {
  _CopyWithImpl$Query$GetUserInfo(
    this._instance,
    this._then,
  );

  final Query$GetUserInfo _instance;

  final TRes Function(Query$GetUserInfo) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getUserInfo = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetUserInfo(
        getUserInfo: getUserInfo == _undefined || getUserInfo == null
            ? _instance.getUserInfo
            : (getUserInfo as Query$GetUserInfo$getUserInfo),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetUserInfo$getUserInfo<TRes> get getUserInfo {
    final local$getUserInfo = _instance.getUserInfo;
    return CopyWith$Query$GetUserInfo$getUserInfo(
        local$getUserInfo, (e) => call(getUserInfo: e));
  }
}

class _CopyWithStubImpl$Query$GetUserInfo<TRes>
    implements CopyWith$Query$GetUserInfo<TRes> {
  _CopyWithStubImpl$Query$GetUserInfo(this._res);

  TRes _res;

  call({
    Query$GetUserInfo$getUserInfo? getUserInfo,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetUserInfo$getUserInfo<TRes> get getUserInfo =>
      CopyWith$Query$GetUserInfo$getUserInfo.stub(_res);
}

const documentNodeQueryGetUserInfo = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetUserInfo'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'getUserInfo'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'userInfo'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'email'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'name'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'imageUrl'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'fspBalance'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'credentialBalance'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'role'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'primaryRole'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'belongsToArtists'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: SelectionSetNode(selections: [
                  FieldNode(
                    name: NameNode(value: 'id'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'name'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'imageUrl'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'fsp'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'status'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'isAdmin'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: '__typename'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                ]),
              ),
              FieldNode(
                name: NameNode(value: 'primaryArtist'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: SelectionSetNode(selections: [
                  FieldNode(
                    name: NameNode(value: 'id'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'name'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'imageUrl'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'fsp'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'status'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'isAdmin'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: '__typename'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                ]),
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$GetUserInfo _parserFn$Query$GetUserInfo(Map<String, dynamic> data) =>
    Query$GetUserInfo.fromJson(data);
typedef OnQueryComplete$Query$GetUserInfo = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$GetUserInfo?,
);

class Options$Query$GetUserInfo
    extends graphql.QueryOptions<Query$GetUserInfo> {
  Options$Query$GetUserInfo({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetUserInfo? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetUserInfo? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null ? null : _parserFn$Query$GetUserInfo(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetUserInfo,
          parserFn: _parserFn$Query$GetUserInfo,
        );

  final OnQueryComplete$Query$GetUserInfo? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetUserInfo
    extends graphql.WatchQueryOptions<Query$GetUserInfo> {
  WatchOptions$Query$GetUserInfo({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetUserInfo? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryGetUserInfo,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetUserInfo,
        );
}

class FetchMoreOptions$Query$GetUserInfo extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetUserInfo({required graphql.UpdateQuery updateQuery})
      : super(
          updateQuery: updateQuery,
          document: documentNodeQueryGetUserInfo,
        );
}

extension ClientExtension$Query$GetUserInfo on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetUserInfo>> query$GetUserInfo(
          [Options$Query$GetUserInfo? options]) async =>
      await this.query(options ?? Options$Query$GetUserInfo());
  graphql.ObservableQuery<Query$GetUserInfo> watchQuery$GetUserInfo(
          [WatchOptions$Query$GetUserInfo? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$GetUserInfo());
  void writeQuery$GetUserInfo({
    required Query$GetUserInfo data,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
            operation:
                graphql.Operation(document: documentNodeQueryGetUserInfo)),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetUserInfo? readQuery$GetUserInfo({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
          operation: graphql.Operation(document: documentNodeQueryGetUserInfo)),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetUserInfo.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetUserInfo> useQuery$GetUserInfo(
        [Options$Query$GetUserInfo? options]) =>
    graphql_flutter.useQuery(options ?? Options$Query$GetUserInfo());
graphql.ObservableQuery<Query$GetUserInfo> useWatchQuery$GetUserInfo(
        [WatchOptions$Query$GetUserInfo? options]) =>
    graphql_flutter.useWatchQuery(options ?? WatchOptions$Query$GetUserInfo());

class Query$GetUserInfo$Widget
    extends graphql_flutter.Query<Query$GetUserInfo> {
  Query$GetUserInfo$Widget({
    widgets.Key? key,
    Options$Query$GetUserInfo? options,
    required graphql_flutter.QueryBuilder<Query$GetUserInfo> builder,
  }) : super(
          key: key,
          options: options ?? Options$Query$GetUserInfo(),
          builder: builder,
        );
}

class Query$GetUserInfo$getUserInfo {
  Query$GetUserInfo$getUserInfo({
    required this.userInfo,
    this.$__typename = 'UserFullData',
  });

  factory Query$GetUserInfo$getUserInfo.fromJson(Map<String, dynamic> json) {
    final l$userInfo = json['userInfo'];
    final l$$__typename = json['__typename'];
    return Query$GetUserInfo$getUserInfo(
      userInfo: Query$GetUserInfo$getUserInfo$userInfo.fromJson(
          (l$userInfo as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetUserInfo$getUserInfo$userInfo userInfo;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$userInfo = userInfo;
    _resultData['userInfo'] = l$userInfo.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$userInfo = userInfo;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$userInfo,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetUserInfo$getUserInfo) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$userInfo = userInfo;
    final lOther$userInfo = other.userInfo;
    if (l$userInfo != lOther$userInfo) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetUserInfo$getUserInfo
    on Query$GetUserInfo$getUserInfo {
  CopyWith$Query$GetUserInfo$getUserInfo<Query$GetUserInfo$getUserInfo>
      get copyWith => CopyWith$Query$GetUserInfo$getUserInfo(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetUserInfo$getUserInfo<TRes> {
  factory CopyWith$Query$GetUserInfo$getUserInfo(
    Query$GetUserInfo$getUserInfo instance,
    TRes Function(Query$GetUserInfo$getUserInfo) then,
  ) = _CopyWithImpl$Query$GetUserInfo$getUserInfo;

  factory CopyWith$Query$GetUserInfo$getUserInfo.stub(TRes res) =
      _CopyWithStubImpl$Query$GetUserInfo$getUserInfo;

  TRes call({
    Query$GetUserInfo$getUserInfo$userInfo? userInfo,
    String? $__typename,
  });
  CopyWith$Query$GetUserInfo$getUserInfo$userInfo<TRes> get userInfo;
}

class _CopyWithImpl$Query$GetUserInfo$getUserInfo<TRes>
    implements CopyWith$Query$GetUserInfo$getUserInfo<TRes> {
  _CopyWithImpl$Query$GetUserInfo$getUserInfo(
    this._instance,
    this._then,
  );

  final Query$GetUserInfo$getUserInfo _instance;

  final TRes Function(Query$GetUserInfo$getUserInfo) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? userInfo = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetUserInfo$getUserInfo(
        userInfo: userInfo == _undefined || userInfo == null
            ? _instance.userInfo
            : (userInfo as Query$GetUserInfo$getUserInfo$userInfo),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetUserInfo$getUserInfo$userInfo<TRes> get userInfo {
    final local$userInfo = _instance.userInfo;
    return CopyWith$Query$GetUserInfo$getUserInfo$userInfo(
        local$userInfo, (e) => call(userInfo: e));
  }
}

class _CopyWithStubImpl$Query$GetUserInfo$getUserInfo<TRes>
    implements CopyWith$Query$GetUserInfo$getUserInfo<TRes> {
  _CopyWithStubImpl$Query$GetUserInfo$getUserInfo(this._res);

  TRes _res;

  call({
    Query$GetUserInfo$getUserInfo$userInfo? userInfo,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetUserInfo$getUserInfo$userInfo<TRes> get userInfo =>
      CopyWith$Query$GetUserInfo$getUserInfo$userInfo.stub(_res);
}

class Query$GetUserInfo$getUserInfo$userInfo {
  Query$GetUserInfo$getUserInfo$userInfo({
    required this.id,
    required this.email,
    required this.name,
    this.imageUrl,
    required this.fspBalance,
    required this.credentialBalance,
    required this.role,
    required this.primaryRole,
    required this.belongsToArtists,
    this.primaryArtist,
    this.$__typename = 'UserDetailData',
  });

  factory Query$GetUserInfo$getUserInfo$userInfo.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$email = json['email'];
    final l$name = json['name'];
    final l$imageUrl = json['imageUrl'];
    final l$fspBalance = json['fspBalance'];
    final l$credentialBalance = json['credentialBalance'];
    final l$role = json['role'];
    final l$primaryRole = json['primaryRole'];
    final l$belongsToArtists = json['belongsToArtists'];
    final l$primaryArtist = json['primaryArtist'];
    final l$$__typename = json['__typename'];
    return Query$GetUserInfo$getUserInfo$userInfo(
      id: (l$id as String),
      email: (l$email as String),
      name: (l$name as String),
      imageUrl: (l$imageUrl as String?),
      fspBalance: (l$fspBalance as int),
      credentialBalance: (l$credentialBalance as int),
      role: (l$role as String),
      primaryRole: (l$primaryRole as String),
      belongsToArtists: (l$belongsToArtists as List<dynamic>)
          .map((e) =>
              Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists.fromJson(
                  (e as Map<String, dynamic>)))
          .toList(),
      primaryArtist: l$primaryArtist == null
          ? null
          : Query$GetUserInfo$getUserInfo$userInfo$primaryArtist.fromJson(
              (l$primaryArtist as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String email;

  final String name;

  final String? imageUrl;

  final int fspBalance;

  final int credentialBalance;

  final String role;

  final String primaryRole;

  final List<Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists>
      belongsToArtists;

  final Query$GetUserInfo$getUserInfo$userInfo$primaryArtist? primaryArtist;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$email = email;
    _resultData['email'] = l$email;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$imageUrl = imageUrl;
    _resultData['imageUrl'] = l$imageUrl;
    final l$fspBalance = fspBalance;
    _resultData['fspBalance'] = l$fspBalance;
    final l$credentialBalance = credentialBalance;
    _resultData['credentialBalance'] = l$credentialBalance;
    final l$role = role;
    _resultData['role'] = l$role;
    final l$primaryRole = primaryRole;
    _resultData['primaryRole'] = l$primaryRole;
    final l$belongsToArtists = belongsToArtists;
    _resultData['belongsToArtists'] =
        l$belongsToArtists.map((e) => e.toJson()).toList();
    final l$primaryArtist = primaryArtist;
    _resultData['primaryArtist'] = l$primaryArtist?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$email = email;
    final l$name = name;
    final l$imageUrl = imageUrl;
    final l$fspBalance = fspBalance;
    final l$credentialBalance = credentialBalance;
    final l$role = role;
    final l$primaryRole = primaryRole;
    final l$belongsToArtists = belongsToArtists;
    final l$primaryArtist = primaryArtist;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$email,
      l$name,
      l$imageUrl,
      l$fspBalance,
      l$credentialBalance,
      l$role,
      l$primaryRole,
      Object.hashAll(l$belongsToArtists.map((v) => v)),
      l$primaryArtist,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetUserInfo$getUserInfo$userInfo) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (l$email != lOther$email) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$imageUrl = imageUrl;
    final lOther$imageUrl = other.imageUrl;
    if (l$imageUrl != lOther$imageUrl) {
      return false;
    }
    final l$fspBalance = fspBalance;
    final lOther$fspBalance = other.fspBalance;
    if (l$fspBalance != lOther$fspBalance) {
      return false;
    }
    final l$credentialBalance = credentialBalance;
    final lOther$credentialBalance = other.credentialBalance;
    if (l$credentialBalance != lOther$credentialBalance) {
      return false;
    }
    final l$role = role;
    final lOther$role = other.role;
    if (l$role != lOther$role) {
      return false;
    }
    final l$primaryRole = primaryRole;
    final lOther$primaryRole = other.primaryRole;
    if (l$primaryRole != lOther$primaryRole) {
      return false;
    }
    final l$belongsToArtists = belongsToArtists;
    final lOther$belongsToArtists = other.belongsToArtists;
    if (l$belongsToArtists.length != lOther$belongsToArtists.length) {
      return false;
    }
    for (int i = 0; i < l$belongsToArtists.length; i++) {
      final l$belongsToArtists$entry = l$belongsToArtists[i];
      final lOther$belongsToArtists$entry = lOther$belongsToArtists[i];
      if (l$belongsToArtists$entry != lOther$belongsToArtists$entry) {
        return false;
      }
    }
    final l$primaryArtist = primaryArtist;
    final lOther$primaryArtist = other.primaryArtist;
    if (l$primaryArtist != lOther$primaryArtist) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetUserInfo$getUserInfo$userInfo
    on Query$GetUserInfo$getUserInfo$userInfo {
  CopyWith$Query$GetUserInfo$getUserInfo$userInfo<
          Query$GetUserInfo$getUserInfo$userInfo>
      get copyWith => CopyWith$Query$GetUserInfo$getUserInfo$userInfo(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetUserInfo$getUserInfo$userInfo<TRes> {
  factory CopyWith$Query$GetUserInfo$getUserInfo$userInfo(
    Query$GetUserInfo$getUserInfo$userInfo instance,
    TRes Function(Query$GetUserInfo$getUserInfo$userInfo) then,
  ) = _CopyWithImpl$Query$GetUserInfo$getUserInfo$userInfo;

  factory CopyWith$Query$GetUserInfo$getUserInfo$userInfo.stub(TRes res) =
      _CopyWithStubImpl$Query$GetUserInfo$getUserInfo$userInfo;

  TRes call({
    String? id,
    String? email,
    String? name,
    String? imageUrl,
    int? fspBalance,
    int? credentialBalance,
    String? role,
    String? primaryRole,
    List<Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists>?
        belongsToArtists,
    Query$GetUserInfo$getUserInfo$userInfo$primaryArtist? primaryArtist,
    String? $__typename,
  });
  TRes belongsToArtists(
      Iterable<Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists> Function(
              Iterable<
                  CopyWith$Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists<
                      Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists>>)
          _fn);
  CopyWith$Query$GetUserInfo$getUserInfo$userInfo$primaryArtist<TRes>
      get primaryArtist;
}

class _CopyWithImpl$Query$GetUserInfo$getUserInfo$userInfo<TRes>
    implements CopyWith$Query$GetUserInfo$getUserInfo$userInfo<TRes> {
  _CopyWithImpl$Query$GetUserInfo$getUserInfo$userInfo(
    this._instance,
    this._then,
  );

  final Query$GetUserInfo$getUserInfo$userInfo _instance;

  final TRes Function(Query$GetUserInfo$getUserInfo$userInfo) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? email = _undefined,
    Object? name = _undefined,
    Object? imageUrl = _undefined,
    Object? fspBalance = _undefined,
    Object? credentialBalance = _undefined,
    Object? role = _undefined,
    Object? primaryRole = _undefined,
    Object? belongsToArtists = _undefined,
    Object? primaryArtist = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetUserInfo$getUserInfo$userInfo(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        email: email == _undefined || email == null
            ? _instance.email
            : (email as String),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        imageUrl:
            imageUrl == _undefined ? _instance.imageUrl : (imageUrl as String?),
        fspBalance: fspBalance == _undefined || fspBalance == null
            ? _instance.fspBalance
            : (fspBalance as int),
        credentialBalance:
            credentialBalance == _undefined || credentialBalance == null
                ? _instance.credentialBalance
                : (credentialBalance as int),
        role: role == _undefined || role == null
            ? _instance.role
            : (role as String),
        primaryRole: primaryRole == _undefined || primaryRole == null
            ? _instance.primaryRole
            : (primaryRole as String),
        belongsToArtists:
            belongsToArtists == _undefined || belongsToArtists == null
                ? _instance.belongsToArtists
                : (belongsToArtists as List<
                    Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists>),
        primaryArtist: primaryArtist == _undefined
            ? _instance.primaryArtist
            : (primaryArtist
                as Query$GetUserInfo$getUserInfo$userInfo$primaryArtist?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes belongsToArtists(
          Iterable<Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists> Function(
                  Iterable<
                      CopyWith$Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists<
                          Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists>>)
              _fn) =>
      call(
          belongsToArtists: _fn(_instance.belongsToArtists.map((e) =>
              CopyWith$Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists(
                e,
                (i) => i,
              ))).toList());

  CopyWith$Query$GetUserInfo$getUserInfo$userInfo$primaryArtist<TRes>
      get primaryArtist {
    final local$primaryArtist = _instance.primaryArtist;
    return local$primaryArtist == null
        ? CopyWith$Query$GetUserInfo$getUserInfo$userInfo$primaryArtist.stub(
            _then(_instance))
        : CopyWith$Query$GetUserInfo$getUserInfo$userInfo$primaryArtist(
            local$primaryArtist, (e) => call(primaryArtist: e));
  }
}

class _CopyWithStubImpl$Query$GetUserInfo$getUserInfo$userInfo<TRes>
    implements CopyWith$Query$GetUserInfo$getUserInfo$userInfo<TRes> {
  _CopyWithStubImpl$Query$GetUserInfo$getUserInfo$userInfo(this._res);

  TRes _res;

  call({
    String? id,
    String? email,
    String? name,
    String? imageUrl,
    int? fspBalance,
    int? credentialBalance,
    String? role,
    String? primaryRole,
    List<Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists>?
        belongsToArtists,
    Query$GetUserInfo$getUserInfo$userInfo$primaryArtist? primaryArtist,
    String? $__typename,
  }) =>
      _res;

  belongsToArtists(_fn) => _res;

  CopyWith$Query$GetUserInfo$getUserInfo$userInfo$primaryArtist<TRes>
      get primaryArtist =>
          CopyWith$Query$GetUserInfo$getUserInfo$userInfo$primaryArtist.stub(
              _res);
}

class Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists {
  Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.fsp,
    required this.status,
    required this.isAdmin,
    this.$__typename = 'ArtistByUserData',
  });

  factory Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$imageUrl = json['imageUrl'];
    final l$fsp = json['fsp'];
    final l$status = json['status'];
    final l$isAdmin = json['isAdmin'];
    final l$$__typename = json['__typename'];
    return Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists(
      id: (l$id as String),
      name: (l$name as String),
      imageUrl: (l$imageUrl as String?),
      fsp: (l$fsp as int),
      status: (l$status as String),
      isAdmin: (l$isAdmin as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String name;

  final String? imageUrl;

  final int fsp;

  final String status;

  final bool isAdmin;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$imageUrl = imageUrl;
    _resultData['imageUrl'] = l$imageUrl;
    final l$fsp = fsp;
    _resultData['fsp'] = l$fsp;
    final l$status = status;
    _resultData['status'] = l$status;
    final l$isAdmin = isAdmin;
    _resultData['isAdmin'] = l$isAdmin;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$imageUrl = imageUrl;
    final l$fsp = fsp;
    final l$status = status;
    final l$isAdmin = isAdmin;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$name,
      l$imageUrl,
      l$fsp,
      l$status,
      l$isAdmin,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$imageUrl = imageUrl;
    final lOther$imageUrl = other.imageUrl;
    if (l$imageUrl != lOther$imageUrl) {
      return false;
    }
    final l$fsp = fsp;
    final lOther$fsp = other.fsp;
    if (l$fsp != lOther$fsp) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    final l$isAdmin = isAdmin;
    final lOther$isAdmin = other.isAdmin;
    if (l$isAdmin != lOther$isAdmin) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists
    on Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists {
  CopyWith$Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists<
          Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists>
      get copyWith =>
          CopyWith$Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists<
    TRes> {
  factory CopyWith$Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists(
    Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists instance,
    TRes Function(Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists) then,
  ) = _CopyWithImpl$Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists;

  factory CopyWith$Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists;

  TRes call({
    String? id,
    String? name,
    String? imageUrl,
    int? fsp,
    String? status,
    bool? isAdmin,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists<
        TRes>
    implements
        CopyWith$Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists<TRes> {
  _CopyWithImpl$Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists(
    this._instance,
    this._then,
  );

  final Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists _instance;

  final TRes Function(Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists)
      _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? imageUrl = _undefined,
    Object? fsp = _undefined,
    Object? status = _undefined,
    Object? isAdmin = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        imageUrl:
            imageUrl == _undefined ? _instance.imageUrl : (imageUrl as String?),
        fsp: fsp == _undefined || fsp == null ? _instance.fsp : (fsp as int),
        status: status == _undefined || status == null
            ? _instance.status
            : (status as String),
        isAdmin: isAdmin == _undefined || isAdmin == null
            ? _instance.isAdmin
            : (isAdmin as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists<
        TRes>
    implements
        CopyWith$Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists<TRes> {
  _CopyWithStubImpl$Query$GetUserInfo$getUserInfo$userInfo$belongsToArtists(
      this._res);

  TRes _res;

  call({
    String? id,
    String? name,
    String? imageUrl,
    int? fsp,
    String? status,
    bool? isAdmin,
    String? $__typename,
  }) =>
      _res;
}

class Query$GetUserInfo$getUserInfo$userInfo$primaryArtist {
  Query$GetUserInfo$getUserInfo$userInfo$primaryArtist({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.fsp,
    required this.status,
    required this.isAdmin,
    this.$__typename = 'ArtistByUserData',
  });

  factory Query$GetUserInfo$getUserInfo$userInfo$primaryArtist.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$imageUrl = json['imageUrl'];
    final l$fsp = json['fsp'];
    final l$status = json['status'];
    final l$isAdmin = json['isAdmin'];
    final l$$__typename = json['__typename'];
    return Query$GetUserInfo$getUserInfo$userInfo$primaryArtist(
      id: (l$id as String),
      name: (l$name as String),
      imageUrl: (l$imageUrl as String?),
      fsp: (l$fsp as int),
      status: (l$status as String),
      isAdmin: (l$isAdmin as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String name;

  final String? imageUrl;

  final int fsp;

  final String status;

  final bool isAdmin;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$imageUrl = imageUrl;
    _resultData['imageUrl'] = l$imageUrl;
    final l$fsp = fsp;
    _resultData['fsp'] = l$fsp;
    final l$status = status;
    _resultData['status'] = l$status;
    final l$isAdmin = isAdmin;
    _resultData['isAdmin'] = l$isAdmin;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$imageUrl = imageUrl;
    final l$fsp = fsp;
    final l$status = status;
    final l$isAdmin = isAdmin;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$name,
      l$imageUrl,
      l$fsp,
      l$status,
      l$isAdmin,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetUserInfo$getUserInfo$userInfo$primaryArtist) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$imageUrl = imageUrl;
    final lOther$imageUrl = other.imageUrl;
    if (l$imageUrl != lOther$imageUrl) {
      return false;
    }
    final l$fsp = fsp;
    final lOther$fsp = other.fsp;
    if (l$fsp != lOther$fsp) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    final l$isAdmin = isAdmin;
    final lOther$isAdmin = other.isAdmin;
    if (l$isAdmin != lOther$isAdmin) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetUserInfo$getUserInfo$userInfo$primaryArtist
    on Query$GetUserInfo$getUserInfo$userInfo$primaryArtist {
  CopyWith$Query$GetUserInfo$getUserInfo$userInfo$primaryArtist<
          Query$GetUserInfo$getUserInfo$userInfo$primaryArtist>
      get copyWith =>
          CopyWith$Query$GetUserInfo$getUserInfo$userInfo$primaryArtist(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetUserInfo$getUserInfo$userInfo$primaryArtist<
    TRes> {
  factory CopyWith$Query$GetUserInfo$getUserInfo$userInfo$primaryArtist(
    Query$GetUserInfo$getUserInfo$userInfo$primaryArtist instance,
    TRes Function(Query$GetUserInfo$getUserInfo$userInfo$primaryArtist) then,
  ) = _CopyWithImpl$Query$GetUserInfo$getUserInfo$userInfo$primaryArtist;

  factory CopyWith$Query$GetUserInfo$getUserInfo$userInfo$primaryArtist.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetUserInfo$getUserInfo$userInfo$primaryArtist;

  TRes call({
    String? id,
    String? name,
    String? imageUrl,
    int? fsp,
    String? status,
    bool? isAdmin,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetUserInfo$getUserInfo$userInfo$primaryArtist<TRes>
    implements
        CopyWith$Query$GetUserInfo$getUserInfo$userInfo$primaryArtist<TRes> {
  _CopyWithImpl$Query$GetUserInfo$getUserInfo$userInfo$primaryArtist(
    this._instance,
    this._then,
  );

  final Query$GetUserInfo$getUserInfo$userInfo$primaryArtist _instance;

  final TRes Function(Query$GetUserInfo$getUserInfo$userInfo$primaryArtist)
      _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? imageUrl = _undefined,
    Object? fsp = _undefined,
    Object? status = _undefined,
    Object? isAdmin = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetUserInfo$getUserInfo$userInfo$primaryArtist(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        imageUrl:
            imageUrl == _undefined ? _instance.imageUrl : (imageUrl as String?),
        fsp: fsp == _undefined || fsp == null ? _instance.fsp : (fsp as int),
        status: status == _undefined || status == null
            ? _instance.status
            : (status as String),
        isAdmin: isAdmin == _undefined || isAdmin == null
            ? _instance.isAdmin
            : (isAdmin as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetUserInfo$getUserInfo$userInfo$primaryArtist<
        TRes>
    implements
        CopyWith$Query$GetUserInfo$getUserInfo$userInfo$primaryArtist<TRes> {
  _CopyWithStubImpl$Query$GetUserInfo$getUserInfo$userInfo$primaryArtist(
      this._res);

  TRes _res;

  call({
    String? id,
    String? name,
    String? imageUrl,
    int? fsp,
    String? status,
    bool? isAdmin,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Query$GetOfferStatsByUser {
  factory Variables$Query$GetOfferStatsByUser({required String userId}) =>
      Variables$Query$GetOfferStatsByUser._({
        r'userId': userId,
      });

  Variables$Query$GetOfferStatsByUser._(this._$data);

  factory Variables$Query$GetOfferStatsByUser.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    return Variables$Query$GetOfferStatsByUser._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$userId = userId;
    result$data['userId'] = l$userId;
    return result$data;
  }

  CopyWith$Variables$Query$GetOfferStatsByUser<
          Variables$Query$GetOfferStatsByUser>
      get copyWith => CopyWith$Variables$Query$GetOfferStatsByUser(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$GetOfferStatsByUser) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    return Object.hashAll([l$userId]);
  }
}

abstract class CopyWith$Variables$Query$GetOfferStatsByUser<TRes> {
  factory CopyWith$Variables$Query$GetOfferStatsByUser(
    Variables$Query$GetOfferStatsByUser instance,
    TRes Function(Variables$Query$GetOfferStatsByUser) then,
  ) = _CopyWithImpl$Variables$Query$GetOfferStatsByUser;

  factory CopyWith$Variables$Query$GetOfferStatsByUser.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$GetOfferStatsByUser;

  TRes call({String? userId});
}

class _CopyWithImpl$Variables$Query$GetOfferStatsByUser<TRes>
    implements CopyWith$Variables$Query$GetOfferStatsByUser<TRes> {
  _CopyWithImpl$Variables$Query$GetOfferStatsByUser(
    this._instance,
    this._then,
  );

  final Variables$Query$GetOfferStatsByUser _instance;

  final TRes Function(Variables$Query$GetOfferStatsByUser) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? userId = _undefined}) =>
      _then(Variables$Query$GetOfferStatsByUser._({
        ..._instance._$data,
        if (userId != _undefined && userId != null)
          'userId': (userId as String),
      }));
}

class _CopyWithStubImpl$Variables$Query$GetOfferStatsByUser<TRes>
    implements CopyWith$Variables$Query$GetOfferStatsByUser<TRes> {
  _CopyWithStubImpl$Variables$Query$GetOfferStatsByUser(this._res);

  TRes _res;

  call({String? userId}) => _res;
}

class Query$GetOfferStatsByUser {
  Query$GetOfferStatsByUser({
    required this.getOfferStatsByUser,
    this.$__typename = 'QueryRoot',
  });

  factory Query$GetOfferStatsByUser.fromJson(Map<String, dynamic> json) {
    final l$getOfferStatsByUser = json['getOfferStatsByUser'];
    final l$$__typename = json['__typename'];
    return Query$GetOfferStatsByUser(
      getOfferStatsByUser:
          Query$GetOfferStatsByUser$getOfferStatsByUser.fromJson(
              (l$getOfferStatsByUser as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetOfferStatsByUser$getOfferStatsByUser getOfferStatsByUser;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getOfferStatsByUser = getOfferStatsByUser;
    _resultData['getOfferStatsByUser'] = l$getOfferStatsByUser.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getOfferStatsByUser = getOfferStatsByUser;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$getOfferStatsByUser,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetOfferStatsByUser) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$getOfferStatsByUser = getOfferStatsByUser;
    final lOther$getOfferStatsByUser = other.getOfferStatsByUser;
    if (l$getOfferStatsByUser != lOther$getOfferStatsByUser) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetOfferStatsByUser
    on Query$GetOfferStatsByUser {
  CopyWith$Query$GetOfferStatsByUser<Query$GetOfferStatsByUser> get copyWith =>
      CopyWith$Query$GetOfferStatsByUser(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetOfferStatsByUser<TRes> {
  factory CopyWith$Query$GetOfferStatsByUser(
    Query$GetOfferStatsByUser instance,
    TRes Function(Query$GetOfferStatsByUser) then,
  ) = _CopyWithImpl$Query$GetOfferStatsByUser;

  factory CopyWith$Query$GetOfferStatsByUser.stub(TRes res) =
      _CopyWithStubImpl$Query$GetOfferStatsByUser;

  TRes call({
    Query$GetOfferStatsByUser$getOfferStatsByUser? getOfferStatsByUser,
    String? $__typename,
  });
  CopyWith$Query$GetOfferStatsByUser$getOfferStatsByUser<TRes>
      get getOfferStatsByUser;
}

class _CopyWithImpl$Query$GetOfferStatsByUser<TRes>
    implements CopyWith$Query$GetOfferStatsByUser<TRes> {
  _CopyWithImpl$Query$GetOfferStatsByUser(
    this._instance,
    this._then,
  );

  final Query$GetOfferStatsByUser _instance;

  final TRes Function(Query$GetOfferStatsByUser) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getOfferStatsByUser = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetOfferStatsByUser(
        getOfferStatsByUser:
            getOfferStatsByUser == _undefined || getOfferStatsByUser == null
                ? _instance.getOfferStatsByUser
                : (getOfferStatsByUser
                    as Query$GetOfferStatsByUser$getOfferStatsByUser),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetOfferStatsByUser$getOfferStatsByUser<TRes>
      get getOfferStatsByUser {
    final local$getOfferStatsByUser = _instance.getOfferStatsByUser;
    return CopyWith$Query$GetOfferStatsByUser$getOfferStatsByUser(
        local$getOfferStatsByUser, (e) => call(getOfferStatsByUser: e));
  }
}

class _CopyWithStubImpl$Query$GetOfferStatsByUser<TRes>
    implements CopyWith$Query$GetOfferStatsByUser<TRes> {
  _CopyWithStubImpl$Query$GetOfferStatsByUser(this._res);

  TRes _res;

  call({
    Query$GetOfferStatsByUser$getOfferStatsByUser? getOfferStatsByUser,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetOfferStatsByUser$getOfferStatsByUser<TRes>
      get getOfferStatsByUser =>
          CopyWith$Query$GetOfferStatsByUser$getOfferStatsByUser.stub(_res);
}

const documentNodeQueryGetOfferStatsByUser = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetOfferStatsByUser'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'userId')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'getOfferStatsByUser'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'userId'),
            value: VariableNode(name: NameNode(value: 'userId')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'totalOffers'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'ongoingOffers'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'appliedOffers'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'completedOffers'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'totalEarnings'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$GetOfferStatsByUser _parserFn$Query$GetOfferStatsByUser(
        Map<String, dynamic> data) =>
    Query$GetOfferStatsByUser.fromJson(data);
typedef OnQueryComplete$Query$GetOfferStatsByUser = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$GetOfferStatsByUser?,
);

class Options$Query$GetOfferStatsByUser
    extends graphql.QueryOptions<Query$GetOfferStatsByUser> {
  Options$Query$GetOfferStatsByUser({
    String? operationName,
    required Variables$Query$GetOfferStatsByUser variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetOfferStatsByUser? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetOfferStatsByUser? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null
                        ? null
                        : _parserFn$Query$GetOfferStatsByUser(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetOfferStatsByUser,
          parserFn: _parserFn$Query$GetOfferStatsByUser,
        );

  final OnQueryComplete$Query$GetOfferStatsByUser? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetOfferStatsByUser
    extends graphql.WatchQueryOptions<Query$GetOfferStatsByUser> {
  WatchOptions$Query$GetOfferStatsByUser({
    String? operationName,
    required Variables$Query$GetOfferStatsByUser variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetOfferStatsByUser? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryGetOfferStatsByUser,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetOfferStatsByUser,
        );
}

class FetchMoreOptions$Query$GetOfferStatsByUser
    extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetOfferStatsByUser({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$GetOfferStatsByUser variables,
  }) : super(
          updateQuery: updateQuery,
          variables: variables.toJson(),
          document: documentNodeQueryGetOfferStatsByUser,
        );
}

extension ClientExtension$Query$GetOfferStatsByUser on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetOfferStatsByUser>>
      query$GetOfferStatsByUser(
              Options$Query$GetOfferStatsByUser options) async =>
          await this.query(options);
  graphql.ObservableQuery<Query$GetOfferStatsByUser>
      watchQuery$GetOfferStatsByUser(
              WatchOptions$Query$GetOfferStatsByUser options) =>
          this.watchQuery(options);
  void writeQuery$GetOfferStatsByUser({
    required Query$GetOfferStatsByUser data,
    required Variables$Query$GetOfferStatsByUser variables,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
          operation:
              graphql.Operation(document: documentNodeQueryGetOfferStatsByUser),
          variables: variables.toJson(),
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetOfferStatsByUser? readQuery$GetOfferStatsByUser({
    required Variables$Query$GetOfferStatsByUser variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation:
            graphql.Operation(document: documentNodeQueryGetOfferStatsByUser),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetOfferStatsByUser.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetOfferStatsByUser>
    useQuery$GetOfferStatsByUser(Options$Query$GetOfferStatsByUser options) =>
        graphql_flutter.useQuery(options);
graphql.ObservableQuery<Query$GetOfferStatsByUser>
    useWatchQuery$GetOfferStatsByUser(
            WatchOptions$Query$GetOfferStatsByUser options) =>
        graphql_flutter.useWatchQuery(options);

class Query$GetOfferStatsByUser$Widget
    extends graphql_flutter.Query<Query$GetOfferStatsByUser> {
  Query$GetOfferStatsByUser$Widget({
    widgets.Key? key,
    required Options$Query$GetOfferStatsByUser options,
    required graphql_flutter.QueryBuilder<Query$GetOfferStatsByUser> builder,
  }) : super(
          key: key,
          options: options,
          builder: builder,
        );
}

class Query$GetOfferStatsByUser$getOfferStatsByUser {
  Query$GetOfferStatsByUser$getOfferStatsByUser({
    required this.totalOffers,
    required this.ongoingOffers,
    required this.appliedOffers,
    required this.completedOffers,
    required this.totalEarnings,
    this.$__typename = 'OfferStatsByUserData',
  });

  factory Query$GetOfferStatsByUser$getOfferStatsByUser.fromJson(
      Map<String, dynamic> json) {
    final l$totalOffers = json['totalOffers'];
    final l$ongoingOffers = json['ongoingOffers'];
    final l$appliedOffers = json['appliedOffers'];
    final l$completedOffers = json['completedOffers'];
    final l$totalEarnings = json['totalEarnings'];
    final l$$__typename = json['__typename'];
    return Query$GetOfferStatsByUser$getOfferStatsByUser(
      totalOffers: (l$totalOffers as int),
      ongoingOffers: (l$ongoingOffers as int),
      appliedOffers: (l$appliedOffers as int),
      completedOffers: (l$completedOffers as int),
      totalEarnings: (l$totalEarnings as int),
      $__typename: (l$$__typename as String),
    );
  }

  final int totalOffers;

  final int ongoingOffers;

  final int appliedOffers;

  final int completedOffers;

  final int totalEarnings;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$totalOffers = totalOffers;
    _resultData['totalOffers'] = l$totalOffers;
    final l$ongoingOffers = ongoingOffers;
    _resultData['ongoingOffers'] = l$ongoingOffers;
    final l$appliedOffers = appliedOffers;
    _resultData['appliedOffers'] = l$appliedOffers;
    final l$completedOffers = completedOffers;
    _resultData['completedOffers'] = l$completedOffers;
    final l$totalEarnings = totalEarnings;
    _resultData['totalEarnings'] = l$totalEarnings;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$totalOffers = totalOffers;
    final l$ongoingOffers = ongoingOffers;
    final l$appliedOffers = appliedOffers;
    final l$completedOffers = completedOffers;
    final l$totalEarnings = totalEarnings;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$totalOffers,
      l$ongoingOffers,
      l$appliedOffers,
      l$completedOffers,
      l$totalEarnings,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetOfferStatsByUser$getOfferStatsByUser) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$totalOffers = totalOffers;
    final lOther$totalOffers = other.totalOffers;
    if (l$totalOffers != lOther$totalOffers) {
      return false;
    }
    final l$ongoingOffers = ongoingOffers;
    final lOther$ongoingOffers = other.ongoingOffers;
    if (l$ongoingOffers != lOther$ongoingOffers) {
      return false;
    }
    final l$appliedOffers = appliedOffers;
    final lOther$appliedOffers = other.appliedOffers;
    if (l$appliedOffers != lOther$appliedOffers) {
      return false;
    }
    final l$completedOffers = completedOffers;
    final lOther$completedOffers = other.completedOffers;
    if (l$completedOffers != lOther$completedOffers) {
      return false;
    }
    final l$totalEarnings = totalEarnings;
    final lOther$totalEarnings = other.totalEarnings;
    if (l$totalEarnings != lOther$totalEarnings) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetOfferStatsByUser$getOfferStatsByUser
    on Query$GetOfferStatsByUser$getOfferStatsByUser {
  CopyWith$Query$GetOfferStatsByUser$getOfferStatsByUser<
          Query$GetOfferStatsByUser$getOfferStatsByUser>
      get copyWith => CopyWith$Query$GetOfferStatsByUser$getOfferStatsByUser(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetOfferStatsByUser$getOfferStatsByUser<TRes> {
  factory CopyWith$Query$GetOfferStatsByUser$getOfferStatsByUser(
    Query$GetOfferStatsByUser$getOfferStatsByUser instance,
    TRes Function(Query$GetOfferStatsByUser$getOfferStatsByUser) then,
  ) = _CopyWithImpl$Query$GetOfferStatsByUser$getOfferStatsByUser;

  factory CopyWith$Query$GetOfferStatsByUser$getOfferStatsByUser.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetOfferStatsByUser$getOfferStatsByUser;

  TRes call({
    int? totalOffers,
    int? ongoingOffers,
    int? appliedOffers,
    int? completedOffers,
    int? totalEarnings,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetOfferStatsByUser$getOfferStatsByUser<TRes>
    implements CopyWith$Query$GetOfferStatsByUser$getOfferStatsByUser<TRes> {
  _CopyWithImpl$Query$GetOfferStatsByUser$getOfferStatsByUser(
    this._instance,
    this._then,
  );

  final Query$GetOfferStatsByUser$getOfferStatsByUser _instance;

  final TRes Function(Query$GetOfferStatsByUser$getOfferStatsByUser) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? totalOffers = _undefined,
    Object? ongoingOffers = _undefined,
    Object? appliedOffers = _undefined,
    Object? completedOffers = _undefined,
    Object? totalEarnings = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetOfferStatsByUser$getOfferStatsByUser(
        totalOffers: totalOffers == _undefined || totalOffers == null
            ? _instance.totalOffers
            : (totalOffers as int),
        ongoingOffers: ongoingOffers == _undefined || ongoingOffers == null
            ? _instance.ongoingOffers
            : (ongoingOffers as int),
        appliedOffers: appliedOffers == _undefined || appliedOffers == null
            ? _instance.appliedOffers
            : (appliedOffers as int),
        completedOffers:
            completedOffers == _undefined || completedOffers == null
                ? _instance.completedOffers
                : (completedOffers as int),
        totalEarnings: totalEarnings == _undefined || totalEarnings == null
            ? _instance.totalEarnings
            : (totalEarnings as int),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetOfferStatsByUser$getOfferStatsByUser<TRes>
    implements CopyWith$Query$GetOfferStatsByUser$getOfferStatsByUser<TRes> {
  _CopyWithStubImpl$Query$GetOfferStatsByUser$getOfferStatsByUser(this._res);

  TRes _res;

  call({
    int? totalOffers,
    int? ongoingOffers,
    int? appliedOffers,
    int? completedOffers,
    int? totalEarnings,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Query$GetOffersByOwner {
  factory Variables$Query$GetOffersByOwner({required String userId}) =>
      Variables$Query$GetOffersByOwner._({
        r'userId': userId,
      });

  Variables$Query$GetOffersByOwner._(this._$data);

  factory Variables$Query$GetOffersByOwner.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    return Variables$Query$GetOffersByOwner._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$userId = userId;
    result$data['userId'] = l$userId;
    return result$data;
  }

  CopyWith$Variables$Query$GetOffersByOwner<Variables$Query$GetOffersByOwner>
      get copyWith => CopyWith$Variables$Query$GetOffersByOwner(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$GetOffersByOwner) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    return Object.hashAll([l$userId]);
  }
}

abstract class CopyWith$Variables$Query$GetOffersByOwner<TRes> {
  factory CopyWith$Variables$Query$GetOffersByOwner(
    Variables$Query$GetOffersByOwner instance,
    TRes Function(Variables$Query$GetOffersByOwner) then,
  ) = _CopyWithImpl$Variables$Query$GetOffersByOwner;

  factory CopyWith$Variables$Query$GetOffersByOwner.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$GetOffersByOwner;

  TRes call({String? userId});
}

class _CopyWithImpl$Variables$Query$GetOffersByOwner<TRes>
    implements CopyWith$Variables$Query$GetOffersByOwner<TRes> {
  _CopyWithImpl$Variables$Query$GetOffersByOwner(
    this._instance,
    this._then,
  );

  final Variables$Query$GetOffersByOwner _instance;

  final TRes Function(Variables$Query$GetOffersByOwner) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? userId = _undefined}) =>
      _then(Variables$Query$GetOffersByOwner._({
        ..._instance._$data,
        if (userId != _undefined && userId != null)
          'userId': (userId as String),
      }));
}

class _CopyWithStubImpl$Variables$Query$GetOffersByOwner<TRes>
    implements CopyWith$Variables$Query$GetOffersByOwner<TRes> {
  _CopyWithStubImpl$Variables$Query$GetOffersByOwner(this._res);

  TRes _res;

  call({String? userId}) => _res;
}

class Query$GetOffersByOwner {
  Query$GetOffersByOwner({
    required this.getOffersByOwner,
    this.$__typename = 'QueryRoot',
  });

  factory Query$GetOffersByOwner.fromJson(Map<String, dynamic> json) {
    final l$getOffersByOwner = json['getOffersByOwner'];
    final l$$__typename = json['__typename'];
    return Query$GetOffersByOwner(
      getOffersByOwner: Query$GetOffersByOwner$getOffersByOwner.fromJson(
          (l$getOffersByOwner as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetOffersByOwner$getOffersByOwner getOffersByOwner;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getOffersByOwner = getOffersByOwner;
    _resultData['getOffersByOwner'] = l$getOffersByOwner.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getOffersByOwner = getOffersByOwner;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$getOffersByOwner,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetOffersByOwner) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$getOffersByOwner = getOffersByOwner;
    final lOther$getOffersByOwner = other.getOffersByOwner;
    if (l$getOffersByOwner != lOther$getOffersByOwner) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetOffersByOwner on Query$GetOffersByOwner {
  CopyWith$Query$GetOffersByOwner<Query$GetOffersByOwner> get copyWith =>
      CopyWith$Query$GetOffersByOwner(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetOffersByOwner<TRes> {
  factory CopyWith$Query$GetOffersByOwner(
    Query$GetOffersByOwner instance,
    TRes Function(Query$GetOffersByOwner) then,
  ) = _CopyWithImpl$Query$GetOffersByOwner;

  factory CopyWith$Query$GetOffersByOwner.stub(TRes res) =
      _CopyWithStubImpl$Query$GetOffersByOwner;

  TRes call({
    Query$GetOffersByOwner$getOffersByOwner? getOffersByOwner,
    String? $__typename,
  });
  CopyWith$Query$GetOffersByOwner$getOffersByOwner<TRes> get getOffersByOwner;
}

class _CopyWithImpl$Query$GetOffersByOwner<TRes>
    implements CopyWith$Query$GetOffersByOwner<TRes> {
  _CopyWithImpl$Query$GetOffersByOwner(
    this._instance,
    this._then,
  );

  final Query$GetOffersByOwner _instance;

  final TRes Function(Query$GetOffersByOwner) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getOffersByOwner = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetOffersByOwner(
        getOffersByOwner:
            getOffersByOwner == _undefined || getOffersByOwner == null
                ? _instance.getOffersByOwner
                : (getOffersByOwner as Query$GetOffersByOwner$getOffersByOwner),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetOffersByOwner$getOffersByOwner<TRes> get getOffersByOwner {
    final local$getOffersByOwner = _instance.getOffersByOwner;
    return CopyWith$Query$GetOffersByOwner$getOffersByOwner(
        local$getOffersByOwner, (e) => call(getOffersByOwner: e));
  }
}

class _CopyWithStubImpl$Query$GetOffersByOwner<TRes>
    implements CopyWith$Query$GetOffersByOwner<TRes> {
  _CopyWithStubImpl$Query$GetOffersByOwner(this._res);

  TRes _res;

  call({
    Query$GetOffersByOwner$getOffersByOwner? getOffersByOwner,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetOffersByOwner$getOffersByOwner<TRes> get getOffersByOwner =>
      CopyWith$Query$GetOffersByOwner$getOffersByOwner.stub(_res);
}

const documentNodeQueryGetOffersByOwner = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetOffersByOwner'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'userId')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'getOffersByOwner'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'userId'),
            value: VariableNode(name: NameNode(value: 'userId')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'offerList'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'title'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'description'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'imageUrl'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'fee'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'category'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$GetOffersByOwner _parserFn$Query$GetOffersByOwner(
        Map<String, dynamic> data) =>
    Query$GetOffersByOwner.fromJson(data);
typedef OnQueryComplete$Query$GetOffersByOwner = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$GetOffersByOwner?,
);

class Options$Query$GetOffersByOwner
    extends graphql.QueryOptions<Query$GetOffersByOwner> {
  Options$Query$GetOffersByOwner({
    String? operationName,
    required Variables$Query$GetOffersByOwner variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetOffersByOwner? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetOffersByOwner? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null
                        ? null
                        : _parserFn$Query$GetOffersByOwner(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetOffersByOwner,
          parserFn: _parserFn$Query$GetOffersByOwner,
        );

  final OnQueryComplete$Query$GetOffersByOwner? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetOffersByOwner
    extends graphql.WatchQueryOptions<Query$GetOffersByOwner> {
  WatchOptions$Query$GetOffersByOwner({
    String? operationName,
    required Variables$Query$GetOffersByOwner variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetOffersByOwner? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryGetOffersByOwner,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetOffersByOwner,
        );
}

class FetchMoreOptions$Query$GetOffersByOwner extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetOffersByOwner({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$GetOffersByOwner variables,
  }) : super(
          updateQuery: updateQuery,
          variables: variables.toJson(),
          document: documentNodeQueryGetOffersByOwner,
        );
}

extension ClientExtension$Query$GetOffersByOwner on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetOffersByOwner>> query$GetOffersByOwner(
          Options$Query$GetOffersByOwner options) async =>
      await this.query(options);
  graphql.ObservableQuery<Query$GetOffersByOwner> watchQuery$GetOffersByOwner(
          WatchOptions$Query$GetOffersByOwner options) =>
      this.watchQuery(options);
  void writeQuery$GetOffersByOwner({
    required Query$GetOffersByOwner data,
    required Variables$Query$GetOffersByOwner variables,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
          operation:
              graphql.Operation(document: documentNodeQueryGetOffersByOwner),
          variables: variables.toJson(),
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetOffersByOwner? readQuery$GetOffersByOwner({
    required Variables$Query$GetOffersByOwner variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation:
            graphql.Operation(document: documentNodeQueryGetOffersByOwner),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetOffersByOwner.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetOffersByOwner>
    useQuery$GetOffersByOwner(Options$Query$GetOffersByOwner options) =>
        graphql_flutter.useQuery(options);
graphql.ObservableQuery<Query$GetOffersByOwner> useWatchQuery$GetOffersByOwner(
        WatchOptions$Query$GetOffersByOwner options) =>
    graphql_flutter.useWatchQuery(options);

class Query$GetOffersByOwner$Widget
    extends graphql_flutter.Query<Query$GetOffersByOwner> {
  Query$GetOffersByOwner$Widget({
    widgets.Key? key,
    required Options$Query$GetOffersByOwner options,
    required graphql_flutter.QueryBuilder<Query$GetOffersByOwner> builder,
  }) : super(
          key: key,
          options: options,
          builder: builder,
        );
}

class Query$GetOffersByOwner$getOffersByOwner {
  Query$GetOffersByOwner$getOffersByOwner({
    required this.offerList,
    this.$__typename = 'OffersData',
  });

  factory Query$GetOffersByOwner$getOffersByOwner.fromJson(
      Map<String, dynamic> json) {
    final l$offerList = json['offerList'];
    final l$$__typename = json['__typename'];
    return Query$GetOffersByOwner$getOffersByOwner(
      offerList: (l$offerList as List<dynamic>)
          .map((e) =>
              Query$GetOffersByOwner$getOffersByOwner$offerList.fromJson(
                  (e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$GetOffersByOwner$getOffersByOwner$offerList> offerList;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$offerList = offerList;
    _resultData['offerList'] = l$offerList.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$offerList = offerList;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$offerList.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetOffersByOwner$getOffersByOwner) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$offerList = offerList;
    final lOther$offerList = other.offerList;
    if (l$offerList.length != lOther$offerList.length) {
      return false;
    }
    for (int i = 0; i < l$offerList.length; i++) {
      final l$offerList$entry = l$offerList[i];
      final lOther$offerList$entry = lOther$offerList[i];
      if (l$offerList$entry != lOther$offerList$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetOffersByOwner$getOffersByOwner
    on Query$GetOffersByOwner$getOffersByOwner {
  CopyWith$Query$GetOffersByOwner$getOffersByOwner<
          Query$GetOffersByOwner$getOffersByOwner>
      get copyWith => CopyWith$Query$GetOffersByOwner$getOffersByOwner(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetOffersByOwner$getOffersByOwner<TRes> {
  factory CopyWith$Query$GetOffersByOwner$getOffersByOwner(
    Query$GetOffersByOwner$getOffersByOwner instance,
    TRes Function(Query$GetOffersByOwner$getOffersByOwner) then,
  ) = _CopyWithImpl$Query$GetOffersByOwner$getOffersByOwner;

  factory CopyWith$Query$GetOffersByOwner$getOffersByOwner.stub(TRes res) =
      _CopyWithStubImpl$Query$GetOffersByOwner$getOffersByOwner;

  TRes call({
    List<Query$GetOffersByOwner$getOffersByOwner$offerList>? offerList,
    String? $__typename,
  });
  TRes offerList(
      Iterable<Query$GetOffersByOwner$getOffersByOwner$offerList> Function(
              Iterable<
                  CopyWith$Query$GetOffersByOwner$getOffersByOwner$offerList<
                      Query$GetOffersByOwner$getOffersByOwner$offerList>>)
          _fn);
}

class _CopyWithImpl$Query$GetOffersByOwner$getOffersByOwner<TRes>
    implements CopyWith$Query$GetOffersByOwner$getOffersByOwner<TRes> {
  _CopyWithImpl$Query$GetOffersByOwner$getOffersByOwner(
    this._instance,
    this._then,
  );

  final Query$GetOffersByOwner$getOffersByOwner _instance;

  final TRes Function(Query$GetOffersByOwner$getOffersByOwner) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? offerList = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetOffersByOwner$getOffersByOwner(
        offerList: offerList == _undefined || offerList == null
            ? _instance.offerList
            : (offerList
                as List<Query$GetOffersByOwner$getOffersByOwner$offerList>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes offerList(
          Iterable<Query$GetOffersByOwner$getOffersByOwner$offerList> Function(
                  Iterable<
                      CopyWith$Query$GetOffersByOwner$getOffersByOwner$offerList<
                          Query$GetOffersByOwner$getOffersByOwner$offerList>>)
              _fn) =>
      call(
          offerList: _fn(_instance.offerList.map(
              (e) => CopyWith$Query$GetOffersByOwner$getOffersByOwner$offerList(
                    e,
                    (i) => i,
                  ))).toList());
}

class _CopyWithStubImpl$Query$GetOffersByOwner$getOffersByOwner<TRes>
    implements CopyWith$Query$GetOffersByOwner$getOffersByOwner<TRes> {
  _CopyWithStubImpl$Query$GetOffersByOwner$getOffersByOwner(this._res);

  TRes _res;

  call({
    List<Query$GetOffersByOwner$getOffersByOwner$offerList>? offerList,
    String? $__typename,
  }) =>
      _res;

  offerList(_fn) => _res;
}

class Query$GetOffersByOwner$getOffersByOwner$offerList {
  Query$GetOffersByOwner$getOffersByOwner$offerList({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.fee,
    this.category,
    this.$__typename = 'OfferData',
  });

  factory Query$GetOffersByOwner$getOffersByOwner$offerList.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$title = json['title'];
    final l$description = json['description'];
    final l$imageUrl = json['imageUrl'];
    final l$fee = json['fee'];
    final l$category = json['category'];
    final l$$__typename = json['__typename'];
    return Query$GetOffersByOwner$getOffersByOwner$offerList(
      id: (l$id as int),
      title: (l$title as String),
      description: (l$description as String),
      imageUrl: (l$imageUrl as String?),
      fee: (l$fee as int),
      category: (l$category as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final int id;

  final String title;

  final String description;

  final String? imageUrl;

  final int fee;

  final String? category;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$title = title;
    _resultData['title'] = l$title;
    final l$description = description;
    _resultData['description'] = l$description;
    final l$imageUrl = imageUrl;
    _resultData['imageUrl'] = l$imageUrl;
    final l$fee = fee;
    _resultData['fee'] = l$fee;
    final l$category = category;
    _resultData['category'] = l$category;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$title = title;
    final l$description = description;
    final l$imageUrl = imageUrl;
    final l$fee = fee;
    final l$category = category;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$title,
      l$description,
      l$imageUrl,
      l$fee,
      l$category,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetOffersByOwner$getOffersByOwner$offerList) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    final l$imageUrl = imageUrl;
    final lOther$imageUrl = other.imageUrl;
    if (l$imageUrl != lOther$imageUrl) {
      return false;
    }
    final l$fee = fee;
    final lOther$fee = other.fee;
    if (l$fee != lOther$fee) {
      return false;
    }
    final l$category = category;
    final lOther$category = other.category;
    if (l$category != lOther$category) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetOffersByOwner$getOffersByOwner$offerList
    on Query$GetOffersByOwner$getOffersByOwner$offerList {
  CopyWith$Query$GetOffersByOwner$getOffersByOwner$offerList<
          Query$GetOffersByOwner$getOffersByOwner$offerList>
      get copyWith =>
          CopyWith$Query$GetOffersByOwner$getOffersByOwner$offerList(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetOffersByOwner$getOffersByOwner$offerList<
    TRes> {
  factory CopyWith$Query$GetOffersByOwner$getOffersByOwner$offerList(
    Query$GetOffersByOwner$getOffersByOwner$offerList instance,
    TRes Function(Query$GetOffersByOwner$getOffersByOwner$offerList) then,
  ) = _CopyWithImpl$Query$GetOffersByOwner$getOffersByOwner$offerList;

  factory CopyWith$Query$GetOffersByOwner$getOffersByOwner$offerList.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetOffersByOwner$getOffersByOwner$offerList;

  TRes call({
    int? id,
    String? title,
    String? description,
    String? imageUrl,
    int? fee,
    String? category,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetOffersByOwner$getOffersByOwner$offerList<TRes>
    implements
        CopyWith$Query$GetOffersByOwner$getOffersByOwner$offerList<TRes> {
  _CopyWithImpl$Query$GetOffersByOwner$getOffersByOwner$offerList(
    this._instance,
    this._then,
  );

  final Query$GetOffersByOwner$getOffersByOwner$offerList _instance;

  final TRes Function(Query$GetOffersByOwner$getOffersByOwner$offerList) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? title = _undefined,
    Object? description = _undefined,
    Object? imageUrl = _undefined,
    Object? fee = _undefined,
    Object? category = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetOffersByOwner$getOffersByOwner$offerList(
        id: id == _undefined || id == null ? _instance.id : (id as int),
        title: title == _undefined || title == null
            ? _instance.title
            : (title as String),
        description: description == _undefined || description == null
            ? _instance.description
            : (description as String),
        imageUrl:
            imageUrl == _undefined ? _instance.imageUrl : (imageUrl as String?),
        fee: fee == _undefined || fee == null ? _instance.fee : (fee as int),
        category:
            category == _undefined ? _instance.category : (category as String?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetOffersByOwner$getOffersByOwner$offerList<TRes>
    implements
        CopyWith$Query$GetOffersByOwner$getOffersByOwner$offerList<TRes> {
  _CopyWithStubImpl$Query$GetOffersByOwner$getOffersByOwner$offerList(
      this._res);

  TRes _res;

  call({
    int? id,
    String? title,
    String? description,
    String? imageUrl,
    int? fee,
    String? category,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Query$GetOffersByStatus {
  factory Variables$Query$GetOffersByStatus({required String userId}) =>
      Variables$Query$GetOffersByStatus._({
        r'userId': userId,
      });

  Variables$Query$GetOffersByStatus._(this._$data);

  factory Variables$Query$GetOffersByStatus.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    return Variables$Query$GetOffersByStatus._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$userId = userId;
    result$data['userId'] = l$userId;
    return result$data;
  }

  CopyWith$Variables$Query$GetOffersByStatus<Variables$Query$GetOffersByStatus>
      get copyWith => CopyWith$Variables$Query$GetOffersByStatus(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$GetOffersByStatus) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    return Object.hashAll([l$userId]);
  }
}

abstract class CopyWith$Variables$Query$GetOffersByStatus<TRes> {
  factory CopyWith$Variables$Query$GetOffersByStatus(
    Variables$Query$GetOffersByStatus instance,
    TRes Function(Variables$Query$GetOffersByStatus) then,
  ) = _CopyWithImpl$Variables$Query$GetOffersByStatus;

  factory CopyWith$Variables$Query$GetOffersByStatus.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$GetOffersByStatus;

  TRes call({String? userId});
}

class _CopyWithImpl$Variables$Query$GetOffersByStatus<TRes>
    implements CopyWith$Variables$Query$GetOffersByStatus<TRes> {
  _CopyWithImpl$Variables$Query$GetOffersByStatus(
    this._instance,
    this._then,
  );

  final Variables$Query$GetOffersByStatus _instance;

  final TRes Function(Variables$Query$GetOffersByStatus) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? userId = _undefined}) =>
      _then(Variables$Query$GetOffersByStatus._({
        ..._instance._$data,
        if (userId != _undefined && userId != null)
          'userId': (userId as String),
      }));
}

class _CopyWithStubImpl$Variables$Query$GetOffersByStatus<TRes>
    implements CopyWith$Variables$Query$GetOffersByStatus<TRes> {
  _CopyWithStubImpl$Variables$Query$GetOffersByStatus(this._res);

  TRes _res;

  call({String? userId}) => _res;
}

class Query$GetOffersByStatus {
  Query$GetOffersByStatus({
    required this.getOffersByStatus,
    this.$__typename = 'QueryRoot',
  });

  factory Query$GetOffersByStatus.fromJson(Map<String, dynamic> json) {
    final l$getOffersByStatus = json['getOffersByStatus'];
    final l$$__typename = json['__typename'];
    return Query$GetOffersByStatus(
      getOffersByStatus: Query$GetOffersByStatus$getOffersByStatus.fromJson(
          (l$getOffersByStatus as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetOffersByStatus$getOffersByStatus getOffersByStatus;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getOffersByStatus = getOffersByStatus;
    _resultData['getOffersByStatus'] = l$getOffersByStatus.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getOffersByStatus = getOffersByStatus;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$getOffersByStatus,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetOffersByStatus) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$getOffersByStatus = getOffersByStatus;
    final lOther$getOffersByStatus = other.getOffersByStatus;
    if (l$getOffersByStatus != lOther$getOffersByStatus) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetOffersByStatus on Query$GetOffersByStatus {
  CopyWith$Query$GetOffersByStatus<Query$GetOffersByStatus> get copyWith =>
      CopyWith$Query$GetOffersByStatus(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetOffersByStatus<TRes> {
  factory CopyWith$Query$GetOffersByStatus(
    Query$GetOffersByStatus instance,
    TRes Function(Query$GetOffersByStatus) then,
  ) = _CopyWithImpl$Query$GetOffersByStatus;

  factory CopyWith$Query$GetOffersByStatus.stub(TRes res) =
      _CopyWithStubImpl$Query$GetOffersByStatus;

  TRes call({
    Query$GetOffersByStatus$getOffersByStatus? getOffersByStatus,
    String? $__typename,
  });
  CopyWith$Query$GetOffersByStatus$getOffersByStatus<TRes>
      get getOffersByStatus;
}

class _CopyWithImpl$Query$GetOffersByStatus<TRes>
    implements CopyWith$Query$GetOffersByStatus<TRes> {
  _CopyWithImpl$Query$GetOffersByStatus(
    this._instance,
    this._then,
  );

  final Query$GetOffersByStatus _instance;

  final TRes Function(Query$GetOffersByStatus) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getOffersByStatus = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetOffersByStatus(
        getOffersByStatus: getOffersByStatus == _undefined ||
                getOffersByStatus == null
            ? _instance.getOffersByStatus
            : (getOffersByStatus as Query$GetOffersByStatus$getOffersByStatus),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetOffersByStatus$getOffersByStatus<TRes>
      get getOffersByStatus {
    final local$getOffersByStatus = _instance.getOffersByStatus;
    return CopyWith$Query$GetOffersByStatus$getOffersByStatus(
        local$getOffersByStatus, (e) => call(getOffersByStatus: e));
  }
}

class _CopyWithStubImpl$Query$GetOffersByStatus<TRes>
    implements CopyWith$Query$GetOffersByStatus<TRes> {
  _CopyWithStubImpl$Query$GetOffersByStatus(this._res);

  TRes _res;

  call({
    Query$GetOffersByStatus$getOffersByStatus? getOffersByStatus,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetOffersByStatus$getOffersByStatus<TRes>
      get getOffersByStatus =>
          CopyWith$Query$GetOffersByStatus$getOffersByStatus.stub(_res);
}

const documentNodeQueryGetOffersByStatus = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetOffersByStatus'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'userId')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'getOffersByStatus'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'userId'),
            value: VariableNode(name: NameNode(value: 'userId')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'inprogressOffers'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'title'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'description'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'imageUrl'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'fee'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'category'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: 'appliedOffers'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'title'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'description'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'imageUrl'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'fee'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'category'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$GetOffersByStatus _parserFn$Query$GetOffersByStatus(
        Map<String, dynamic> data) =>
    Query$GetOffersByStatus.fromJson(data);
typedef OnQueryComplete$Query$GetOffersByStatus = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$GetOffersByStatus?,
);

class Options$Query$GetOffersByStatus
    extends graphql.QueryOptions<Query$GetOffersByStatus> {
  Options$Query$GetOffersByStatus({
    String? operationName,
    required Variables$Query$GetOffersByStatus variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetOffersByStatus? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetOffersByStatus? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null
                        ? null
                        : _parserFn$Query$GetOffersByStatus(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetOffersByStatus,
          parserFn: _parserFn$Query$GetOffersByStatus,
        );

  final OnQueryComplete$Query$GetOffersByStatus? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetOffersByStatus
    extends graphql.WatchQueryOptions<Query$GetOffersByStatus> {
  WatchOptions$Query$GetOffersByStatus({
    String? operationName,
    required Variables$Query$GetOffersByStatus variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetOffersByStatus? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryGetOffersByStatus,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetOffersByStatus,
        );
}

class FetchMoreOptions$Query$GetOffersByStatus
    extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetOffersByStatus({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$GetOffersByStatus variables,
  }) : super(
          updateQuery: updateQuery,
          variables: variables.toJson(),
          document: documentNodeQueryGetOffersByStatus,
        );
}

extension ClientExtension$Query$GetOffersByStatus on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetOffersByStatus>> query$GetOffersByStatus(
          Options$Query$GetOffersByStatus options) async =>
      await this.query(options);
  graphql.ObservableQuery<Query$GetOffersByStatus> watchQuery$GetOffersByStatus(
          WatchOptions$Query$GetOffersByStatus options) =>
      this.watchQuery(options);
  void writeQuery$GetOffersByStatus({
    required Query$GetOffersByStatus data,
    required Variables$Query$GetOffersByStatus variables,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
          operation:
              graphql.Operation(document: documentNodeQueryGetOffersByStatus),
          variables: variables.toJson(),
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetOffersByStatus? readQuery$GetOffersByStatus({
    required Variables$Query$GetOffersByStatus variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation:
            graphql.Operation(document: documentNodeQueryGetOffersByStatus),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetOffersByStatus.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetOffersByStatus>
    useQuery$GetOffersByStatus(Options$Query$GetOffersByStatus options) =>
        graphql_flutter.useQuery(options);
graphql.ObservableQuery<Query$GetOffersByStatus>
    useWatchQuery$GetOffersByStatus(
            WatchOptions$Query$GetOffersByStatus options) =>
        graphql_flutter.useWatchQuery(options);

class Query$GetOffersByStatus$Widget
    extends graphql_flutter.Query<Query$GetOffersByStatus> {
  Query$GetOffersByStatus$Widget({
    widgets.Key? key,
    required Options$Query$GetOffersByStatus options,
    required graphql_flutter.QueryBuilder<Query$GetOffersByStatus> builder,
  }) : super(
          key: key,
          options: options,
          builder: builder,
        );
}

class Query$GetOffersByStatus$getOffersByStatus {
  Query$GetOffersByStatus$getOffersByStatus({
    required this.inprogressOffers,
    required this.appliedOffers,
    this.$__typename = 'OfferByStatusData',
  });

  factory Query$GetOffersByStatus$getOffersByStatus.fromJson(
      Map<String, dynamic> json) {
    final l$inprogressOffers = json['inprogressOffers'];
    final l$appliedOffers = json['appliedOffers'];
    final l$$__typename = json['__typename'];
    return Query$GetOffersByStatus$getOffersByStatus(
      inprogressOffers: (l$inprogressOffers as List<dynamic>)
          .map((e) => Query$GetOffersByStatus$getOffersByStatus$inprogressOffers
              .fromJson((e as Map<String, dynamic>)))
          .toList(),
      appliedOffers: (l$appliedOffers as List<dynamic>)
          .map((e) =>
              Query$GetOffersByStatus$getOffersByStatus$appliedOffers.fromJson(
                  (e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$GetOffersByStatus$getOffersByStatus$inprogressOffers>
      inprogressOffers;

  final List<Query$GetOffersByStatus$getOffersByStatus$appliedOffers>
      appliedOffers;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$inprogressOffers = inprogressOffers;
    _resultData['inprogressOffers'] =
        l$inprogressOffers.map((e) => e.toJson()).toList();
    final l$appliedOffers = appliedOffers;
    _resultData['appliedOffers'] =
        l$appliedOffers.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$inprogressOffers = inprogressOffers;
    final l$appliedOffers = appliedOffers;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$inprogressOffers.map((v) => v)),
      Object.hashAll(l$appliedOffers.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetOffersByStatus$getOffersByStatus) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$inprogressOffers = inprogressOffers;
    final lOther$inprogressOffers = other.inprogressOffers;
    if (l$inprogressOffers.length != lOther$inprogressOffers.length) {
      return false;
    }
    for (int i = 0; i < l$inprogressOffers.length; i++) {
      final l$inprogressOffers$entry = l$inprogressOffers[i];
      final lOther$inprogressOffers$entry = lOther$inprogressOffers[i];
      if (l$inprogressOffers$entry != lOther$inprogressOffers$entry) {
        return false;
      }
    }
    final l$appliedOffers = appliedOffers;
    final lOther$appliedOffers = other.appliedOffers;
    if (l$appliedOffers.length != lOther$appliedOffers.length) {
      return false;
    }
    for (int i = 0; i < l$appliedOffers.length; i++) {
      final l$appliedOffers$entry = l$appliedOffers[i];
      final lOther$appliedOffers$entry = lOther$appliedOffers[i];
      if (l$appliedOffers$entry != lOther$appliedOffers$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetOffersByStatus$getOffersByStatus
    on Query$GetOffersByStatus$getOffersByStatus {
  CopyWith$Query$GetOffersByStatus$getOffersByStatus<
          Query$GetOffersByStatus$getOffersByStatus>
      get copyWith => CopyWith$Query$GetOffersByStatus$getOffersByStatus(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetOffersByStatus$getOffersByStatus<TRes> {
  factory CopyWith$Query$GetOffersByStatus$getOffersByStatus(
    Query$GetOffersByStatus$getOffersByStatus instance,
    TRes Function(Query$GetOffersByStatus$getOffersByStatus) then,
  ) = _CopyWithImpl$Query$GetOffersByStatus$getOffersByStatus;

  factory CopyWith$Query$GetOffersByStatus$getOffersByStatus.stub(TRes res) =
      _CopyWithStubImpl$Query$GetOffersByStatus$getOffersByStatus;

  TRes call({
    List<Query$GetOffersByStatus$getOffersByStatus$inprogressOffers>?
        inprogressOffers,
    List<Query$GetOffersByStatus$getOffersByStatus$appliedOffers>?
        appliedOffers,
    String? $__typename,
  });
  TRes inprogressOffers(
      Iterable<Query$GetOffersByStatus$getOffersByStatus$inprogressOffers> Function(
              Iterable<
                  CopyWith$Query$GetOffersByStatus$getOffersByStatus$inprogressOffers<
                      Query$GetOffersByStatus$getOffersByStatus$inprogressOffers>>)
          _fn);
  TRes appliedOffers(
      Iterable<Query$GetOffersByStatus$getOffersByStatus$appliedOffers> Function(
              Iterable<
                  CopyWith$Query$GetOffersByStatus$getOffersByStatus$appliedOffers<
                      Query$GetOffersByStatus$getOffersByStatus$appliedOffers>>)
          _fn);
}

class _CopyWithImpl$Query$GetOffersByStatus$getOffersByStatus<TRes>
    implements CopyWith$Query$GetOffersByStatus$getOffersByStatus<TRes> {
  _CopyWithImpl$Query$GetOffersByStatus$getOffersByStatus(
    this._instance,
    this._then,
  );

  final Query$GetOffersByStatus$getOffersByStatus _instance;

  final TRes Function(Query$GetOffersByStatus$getOffersByStatus) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? inprogressOffers = _undefined,
    Object? appliedOffers = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetOffersByStatus$getOffersByStatus(
        inprogressOffers: inprogressOffers == _undefined ||
                inprogressOffers == null
            ? _instance.inprogressOffers
            : (inprogressOffers as List<
                Query$GetOffersByStatus$getOffersByStatus$inprogressOffers>),
        appliedOffers: appliedOffers == _undefined || appliedOffers == null
            ? _instance.appliedOffers
            : (appliedOffers as List<
                Query$GetOffersByStatus$getOffersByStatus$appliedOffers>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes inprogressOffers(
          Iterable<Query$GetOffersByStatus$getOffersByStatus$inprogressOffers> Function(
                  Iterable<
                      CopyWith$Query$GetOffersByStatus$getOffersByStatus$inprogressOffers<
                          Query$GetOffersByStatus$getOffersByStatus$inprogressOffers>>)
              _fn) =>
      call(
          inprogressOffers: _fn(_instance.inprogressOffers.map((e) =>
              CopyWith$Query$GetOffersByStatus$getOffersByStatus$inprogressOffers(
                e,
                (i) => i,
              ))).toList());

  TRes appliedOffers(
          Iterable<Query$GetOffersByStatus$getOffersByStatus$appliedOffers> Function(
                  Iterable<
                      CopyWith$Query$GetOffersByStatus$getOffersByStatus$appliedOffers<
                          Query$GetOffersByStatus$getOffersByStatus$appliedOffers>>)
              _fn) =>
      call(
          appliedOffers: _fn(_instance.appliedOffers.map((e) =>
              CopyWith$Query$GetOffersByStatus$getOffersByStatus$appliedOffers(
                e,
                (i) => i,
              ))).toList());
}

class _CopyWithStubImpl$Query$GetOffersByStatus$getOffersByStatus<TRes>
    implements CopyWith$Query$GetOffersByStatus$getOffersByStatus<TRes> {
  _CopyWithStubImpl$Query$GetOffersByStatus$getOffersByStatus(this._res);

  TRes _res;

  call({
    List<Query$GetOffersByStatus$getOffersByStatus$inprogressOffers>?
        inprogressOffers,
    List<Query$GetOffersByStatus$getOffersByStatus$appliedOffers>?
        appliedOffers,
    String? $__typename,
  }) =>
      _res;

  inprogressOffers(_fn) => _res;

  appliedOffers(_fn) => _res;
}

class Query$GetOffersByStatus$getOffersByStatus$inprogressOffers {
  Query$GetOffersByStatus$getOffersByStatus$inprogressOffers({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.fee,
    this.category,
    this.$__typename = 'OfferData',
  });

  factory Query$GetOffersByStatus$getOffersByStatus$inprogressOffers.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$title = json['title'];
    final l$description = json['description'];
    final l$imageUrl = json['imageUrl'];
    final l$fee = json['fee'];
    final l$category = json['category'];
    final l$$__typename = json['__typename'];
    return Query$GetOffersByStatus$getOffersByStatus$inprogressOffers(
      id: (l$id as int),
      title: (l$title as String),
      description: (l$description as String),
      imageUrl: (l$imageUrl as String?),
      fee: (l$fee as int),
      category: (l$category as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final int id;

  final String title;

  final String description;

  final String? imageUrl;

  final int fee;

  final String? category;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$title = title;
    _resultData['title'] = l$title;
    final l$description = description;
    _resultData['description'] = l$description;
    final l$imageUrl = imageUrl;
    _resultData['imageUrl'] = l$imageUrl;
    final l$fee = fee;
    _resultData['fee'] = l$fee;
    final l$category = category;
    _resultData['category'] = l$category;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$title = title;
    final l$description = description;
    final l$imageUrl = imageUrl;
    final l$fee = fee;
    final l$category = category;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$title,
      l$description,
      l$imageUrl,
      l$fee,
      l$category,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other
            is Query$GetOffersByStatus$getOffersByStatus$inprogressOffers) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    final l$imageUrl = imageUrl;
    final lOther$imageUrl = other.imageUrl;
    if (l$imageUrl != lOther$imageUrl) {
      return false;
    }
    final l$fee = fee;
    final lOther$fee = other.fee;
    if (l$fee != lOther$fee) {
      return false;
    }
    final l$category = category;
    final lOther$category = other.category;
    if (l$category != lOther$category) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetOffersByStatus$getOffersByStatus$inprogressOffers
    on Query$GetOffersByStatus$getOffersByStatus$inprogressOffers {
  CopyWith$Query$GetOffersByStatus$getOffersByStatus$inprogressOffers<
          Query$GetOffersByStatus$getOffersByStatus$inprogressOffers>
      get copyWith =>
          CopyWith$Query$GetOffersByStatus$getOffersByStatus$inprogressOffers(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetOffersByStatus$getOffersByStatus$inprogressOffers<
    TRes> {
  factory CopyWith$Query$GetOffersByStatus$getOffersByStatus$inprogressOffers(
    Query$GetOffersByStatus$getOffersByStatus$inprogressOffers instance,
    TRes Function(Query$GetOffersByStatus$getOffersByStatus$inprogressOffers)
        then,
  ) = _CopyWithImpl$Query$GetOffersByStatus$getOffersByStatus$inprogressOffers;

  factory CopyWith$Query$GetOffersByStatus$getOffersByStatus$inprogressOffers.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetOffersByStatus$getOffersByStatus$inprogressOffers;

  TRes call({
    int? id,
    String? title,
    String? description,
    String? imageUrl,
    int? fee,
    String? category,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetOffersByStatus$getOffersByStatus$inprogressOffers<
        TRes>
    implements
        CopyWith$Query$GetOffersByStatus$getOffersByStatus$inprogressOffers<
            TRes> {
  _CopyWithImpl$Query$GetOffersByStatus$getOffersByStatus$inprogressOffers(
    this._instance,
    this._then,
  );

  final Query$GetOffersByStatus$getOffersByStatus$inprogressOffers _instance;

  final TRes Function(
      Query$GetOffersByStatus$getOffersByStatus$inprogressOffers) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? title = _undefined,
    Object? description = _undefined,
    Object? imageUrl = _undefined,
    Object? fee = _undefined,
    Object? category = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetOffersByStatus$getOffersByStatus$inprogressOffers(
        id: id == _undefined || id == null ? _instance.id : (id as int),
        title: title == _undefined || title == null
            ? _instance.title
            : (title as String),
        description: description == _undefined || description == null
            ? _instance.description
            : (description as String),
        imageUrl:
            imageUrl == _undefined ? _instance.imageUrl : (imageUrl as String?),
        fee: fee == _undefined || fee == null ? _instance.fee : (fee as int),
        category:
            category == _undefined ? _instance.category : (category as String?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetOffersByStatus$getOffersByStatus$inprogressOffers<
        TRes>
    implements
        CopyWith$Query$GetOffersByStatus$getOffersByStatus$inprogressOffers<
            TRes> {
  _CopyWithStubImpl$Query$GetOffersByStatus$getOffersByStatus$inprogressOffers(
      this._res);

  TRes _res;

  call({
    int? id,
    String? title,
    String? description,
    String? imageUrl,
    int? fee,
    String? category,
    String? $__typename,
  }) =>
      _res;
}

class Query$GetOffersByStatus$getOffersByStatus$appliedOffers {
  Query$GetOffersByStatus$getOffersByStatus$appliedOffers({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.fee,
    this.category,
    this.$__typename = 'OfferData',
  });

  factory Query$GetOffersByStatus$getOffersByStatus$appliedOffers.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$title = json['title'];
    final l$description = json['description'];
    final l$imageUrl = json['imageUrl'];
    final l$fee = json['fee'];
    final l$category = json['category'];
    final l$$__typename = json['__typename'];
    return Query$GetOffersByStatus$getOffersByStatus$appliedOffers(
      id: (l$id as int),
      title: (l$title as String),
      description: (l$description as String),
      imageUrl: (l$imageUrl as String?),
      fee: (l$fee as int),
      category: (l$category as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final int id;

  final String title;

  final String description;

  final String? imageUrl;

  final int fee;

  final String? category;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$title = title;
    _resultData['title'] = l$title;
    final l$description = description;
    _resultData['description'] = l$description;
    final l$imageUrl = imageUrl;
    _resultData['imageUrl'] = l$imageUrl;
    final l$fee = fee;
    _resultData['fee'] = l$fee;
    final l$category = category;
    _resultData['category'] = l$category;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$title = title;
    final l$description = description;
    final l$imageUrl = imageUrl;
    final l$fee = fee;
    final l$category = category;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$title,
      l$description,
      l$imageUrl,
      l$fee,
      l$category,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetOffersByStatus$getOffersByStatus$appliedOffers) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    final l$imageUrl = imageUrl;
    final lOther$imageUrl = other.imageUrl;
    if (l$imageUrl != lOther$imageUrl) {
      return false;
    }
    final l$fee = fee;
    final lOther$fee = other.fee;
    if (l$fee != lOther$fee) {
      return false;
    }
    final l$category = category;
    final lOther$category = other.category;
    if (l$category != lOther$category) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetOffersByStatus$getOffersByStatus$appliedOffers
    on Query$GetOffersByStatus$getOffersByStatus$appliedOffers {
  CopyWith$Query$GetOffersByStatus$getOffersByStatus$appliedOffers<
          Query$GetOffersByStatus$getOffersByStatus$appliedOffers>
      get copyWith =>
          CopyWith$Query$GetOffersByStatus$getOffersByStatus$appliedOffers(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetOffersByStatus$getOffersByStatus$appliedOffers<
    TRes> {
  factory CopyWith$Query$GetOffersByStatus$getOffersByStatus$appliedOffers(
    Query$GetOffersByStatus$getOffersByStatus$appliedOffers instance,
    TRes Function(Query$GetOffersByStatus$getOffersByStatus$appliedOffers) then,
  ) = _CopyWithImpl$Query$GetOffersByStatus$getOffersByStatus$appliedOffers;

  factory CopyWith$Query$GetOffersByStatus$getOffersByStatus$appliedOffers.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetOffersByStatus$getOffersByStatus$appliedOffers;

  TRes call({
    int? id,
    String? title,
    String? description,
    String? imageUrl,
    int? fee,
    String? category,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetOffersByStatus$getOffersByStatus$appliedOffers<
        TRes>
    implements
        CopyWith$Query$GetOffersByStatus$getOffersByStatus$appliedOffers<TRes> {
  _CopyWithImpl$Query$GetOffersByStatus$getOffersByStatus$appliedOffers(
    this._instance,
    this._then,
  );

  final Query$GetOffersByStatus$getOffersByStatus$appliedOffers _instance;

  final TRes Function(Query$GetOffersByStatus$getOffersByStatus$appliedOffers)
      _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? title = _undefined,
    Object? description = _undefined,
    Object? imageUrl = _undefined,
    Object? fee = _undefined,
    Object? category = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetOffersByStatus$getOffersByStatus$appliedOffers(
        id: id == _undefined || id == null ? _instance.id : (id as int),
        title: title == _undefined || title == null
            ? _instance.title
            : (title as String),
        description: description == _undefined || description == null
            ? _instance.description
            : (description as String),
        imageUrl:
            imageUrl == _undefined ? _instance.imageUrl : (imageUrl as String?),
        fee: fee == _undefined || fee == null ? _instance.fee : (fee as int),
        category:
            category == _undefined ? _instance.category : (category as String?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetOffersByStatus$getOffersByStatus$appliedOffers<
        TRes>
    implements
        CopyWith$Query$GetOffersByStatus$getOffersByStatus$appliedOffers<TRes> {
  _CopyWithStubImpl$Query$GetOffersByStatus$getOffersByStatus$appliedOffers(
      this._res);

  TRes _res;

  call({
    int? id,
    String? title,
    String? description,
    String? imageUrl,
    int? fee,
    String? category,
    String? $__typename,
  }) =>
      _res;
}

class Query$GetOffers {
  Query$GetOffers({
    required this.getOffers,
    this.$__typename = 'QueryRoot',
  });

  factory Query$GetOffers.fromJson(Map<String, dynamic> json) {
    final l$getOffers = json['getOffers'];
    final l$$__typename = json['__typename'];
    return Query$GetOffers(
      getOffers: Query$GetOffers$getOffers.fromJson(
          (l$getOffers as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetOffers$getOffers getOffers;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getOffers = getOffers;
    _resultData['getOffers'] = l$getOffers.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getOffers = getOffers;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$getOffers,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetOffers) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$getOffers = getOffers;
    final lOther$getOffers = other.getOffers;
    if (l$getOffers != lOther$getOffers) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetOffers on Query$GetOffers {
  CopyWith$Query$GetOffers<Query$GetOffers> get copyWith =>
      CopyWith$Query$GetOffers(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetOffers<TRes> {
  factory CopyWith$Query$GetOffers(
    Query$GetOffers instance,
    TRes Function(Query$GetOffers) then,
  ) = _CopyWithImpl$Query$GetOffers;

  factory CopyWith$Query$GetOffers.stub(TRes res) =
      _CopyWithStubImpl$Query$GetOffers;

  TRes call({
    Query$GetOffers$getOffers? getOffers,
    String? $__typename,
  });
  CopyWith$Query$GetOffers$getOffers<TRes> get getOffers;
}

class _CopyWithImpl$Query$GetOffers<TRes>
    implements CopyWith$Query$GetOffers<TRes> {
  _CopyWithImpl$Query$GetOffers(
    this._instance,
    this._then,
  );

  final Query$GetOffers _instance;

  final TRes Function(Query$GetOffers) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getOffers = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetOffers(
        getOffers: getOffers == _undefined || getOffers == null
            ? _instance.getOffers
            : (getOffers as Query$GetOffers$getOffers),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetOffers$getOffers<TRes> get getOffers {
    final local$getOffers = _instance.getOffers;
    return CopyWith$Query$GetOffers$getOffers(
        local$getOffers, (e) => call(getOffers: e));
  }
}

class _CopyWithStubImpl$Query$GetOffers<TRes>
    implements CopyWith$Query$GetOffers<TRes> {
  _CopyWithStubImpl$Query$GetOffers(this._res);

  TRes _res;

  call({
    Query$GetOffers$getOffers? getOffers,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetOffers$getOffers<TRes> get getOffers =>
      CopyWith$Query$GetOffers$getOffers.stub(_res);
}

const documentNodeQueryGetOffers = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetOffers'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'getOffers'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'offerList'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'title'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'description'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'imageUrl'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'fee'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'category'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$GetOffers _parserFn$Query$GetOffers(Map<String, dynamic> data) =>
    Query$GetOffers.fromJson(data);
typedef OnQueryComplete$Query$GetOffers = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$GetOffers?,
);

class Options$Query$GetOffers extends graphql.QueryOptions<Query$GetOffers> {
  Options$Query$GetOffers({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetOffers? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetOffers? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null ? null : _parserFn$Query$GetOffers(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetOffers,
          parserFn: _parserFn$Query$GetOffers,
        );

  final OnQueryComplete$Query$GetOffers? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetOffers
    extends graphql.WatchQueryOptions<Query$GetOffers> {
  WatchOptions$Query$GetOffers({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetOffers? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryGetOffers,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetOffers,
        );
}

class FetchMoreOptions$Query$GetOffers extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetOffers({required graphql.UpdateQuery updateQuery})
      : super(
          updateQuery: updateQuery,
          document: documentNodeQueryGetOffers,
        );
}

extension ClientExtension$Query$GetOffers on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetOffers>> query$GetOffers(
          [Options$Query$GetOffers? options]) async =>
      await this.query(options ?? Options$Query$GetOffers());
  graphql.ObservableQuery<Query$GetOffers> watchQuery$GetOffers(
          [WatchOptions$Query$GetOffers? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$GetOffers());
  void writeQuery$GetOffers({
    required Query$GetOffers data,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
            operation: graphql.Operation(document: documentNodeQueryGetOffers)),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetOffers? readQuery$GetOffers({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
          operation: graphql.Operation(document: documentNodeQueryGetOffers)),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetOffers.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetOffers> useQuery$GetOffers(
        [Options$Query$GetOffers? options]) =>
    graphql_flutter.useQuery(options ?? Options$Query$GetOffers());
graphql.ObservableQuery<Query$GetOffers> useWatchQuery$GetOffers(
        [WatchOptions$Query$GetOffers? options]) =>
    graphql_flutter.useWatchQuery(options ?? WatchOptions$Query$GetOffers());

class Query$GetOffers$Widget extends graphql_flutter.Query<Query$GetOffers> {
  Query$GetOffers$Widget({
    widgets.Key? key,
    Options$Query$GetOffers? options,
    required graphql_flutter.QueryBuilder<Query$GetOffers> builder,
  }) : super(
          key: key,
          options: options ?? Options$Query$GetOffers(),
          builder: builder,
        );
}

class Query$GetOffers$getOffers {
  Query$GetOffers$getOffers({
    required this.offerList,
    this.$__typename = 'OffersData',
  });

  factory Query$GetOffers$getOffers.fromJson(Map<String, dynamic> json) {
    final l$offerList = json['offerList'];
    final l$$__typename = json['__typename'];
    return Query$GetOffers$getOffers(
      offerList: (l$offerList as List<dynamic>)
          .map((e) => Query$GetOffers$getOffers$offerList.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$GetOffers$getOffers$offerList> offerList;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$offerList = offerList;
    _resultData['offerList'] = l$offerList.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$offerList = offerList;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$offerList.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetOffers$getOffers) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$offerList = offerList;
    final lOther$offerList = other.offerList;
    if (l$offerList.length != lOther$offerList.length) {
      return false;
    }
    for (int i = 0; i < l$offerList.length; i++) {
      final l$offerList$entry = l$offerList[i];
      final lOther$offerList$entry = lOther$offerList[i];
      if (l$offerList$entry != lOther$offerList$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetOffers$getOffers
    on Query$GetOffers$getOffers {
  CopyWith$Query$GetOffers$getOffers<Query$GetOffers$getOffers> get copyWith =>
      CopyWith$Query$GetOffers$getOffers(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetOffers$getOffers<TRes> {
  factory CopyWith$Query$GetOffers$getOffers(
    Query$GetOffers$getOffers instance,
    TRes Function(Query$GetOffers$getOffers) then,
  ) = _CopyWithImpl$Query$GetOffers$getOffers;

  factory CopyWith$Query$GetOffers$getOffers.stub(TRes res) =
      _CopyWithStubImpl$Query$GetOffers$getOffers;

  TRes call({
    List<Query$GetOffers$getOffers$offerList>? offerList,
    String? $__typename,
  });
  TRes offerList(
      Iterable<Query$GetOffers$getOffers$offerList> Function(
              Iterable<
                  CopyWith$Query$GetOffers$getOffers$offerList<
                      Query$GetOffers$getOffers$offerList>>)
          _fn);
}

class _CopyWithImpl$Query$GetOffers$getOffers<TRes>
    implements CopyWith$Query$GetOffers$getOffers<TRes> {
  _CopyWithImpl$Query$GetOffers$getOffers(
    this._instance,
    this._then,
  );

  final Query$GetOffers$getOffers _instance;

  final TRes Function(Query$GetOffers$getOffers) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? offerList = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetOffers$getOffers(
        offerList: offerList == _undefined || offerList == null
            ? _instance.offerList
            : (offerList as List<Query$GetOffers$getOffers$offerList>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes offerList(
          Iterable<Query$GetOffers$getOffers$offerList> Function(
                  Iterable<
                      CopyWith$Query$GetOffers$getOffers$offerList<
                          Query$GetOffers$getOffers$offerList>>)
              _fn) =>
      call(
          offerList: _fn(_instance.offerList
              .map((e) => CopyWith$Query$GetOffers$getOffers$offerList(
                    e,
                    (i) => i,
                  ))).toList());
}

class _CopyWithStubImpl$Query$GetOffers$getOffers<TRes>
    implements CopyWith$Query$GetOffers$getOffers<TRes> {
  _CopyWithStubImpl$Query$GetOffers$getOffers(this._res);

  TRes _res;

  call({
    List<Query$GetOffers$getOffers$offerList>? offerList,
    String? $__typename,
  }) =>
      _res;

  offerList(_fn) => _res;
}

class Query$GetOffers$getOffers$offerList {
  Query$GetOffers$getOffers$offerList({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.fee,
    this.category,
    this.$__typename = 'OfferData',
  });

  factory Query$GetOffers$getOffers$offerList.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$title = json['title'];
    final l$description = json['description'];
    final l$imageUrl = json['imageUrl'];
    final l$fee = json['fee'];
    final l$category = json['category'];
    final l$$__typename = json['__typename'];
    return Query$GetOffers$getOffers$offerList(
      id: (l$id as int),
      title: (l$title as String),
      description: (l$description as String),
      imageUrl: (l$imageUrl as String?),
      fee: (l$fee as int),
      category: (l$category as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final int id;

  final String title;

  final String description;

  final String? imageUrl;

  final int fee;

  final String? category;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$title = title;
    _resultData['title'] = l$title;
    final l$description = description;
    _resultData['description'] = l$description;
    final l$imageUrl = imageUrl;
    _resultData['imageUrl'] = l$imageUrl;
    final l$fee = fee;
    _resultData['fee'] = l$fee;
    final l$category = category;
    _resultData['category'] = l$category;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$title = title;
    final l$description = description;
    final l$imageUrl = imageUrl;
    final l$fee = fee;
    final l$category = category;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$title,
      l$description,
      l$imageUrl,
      l$fee,
      l$category,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetOffers$getOffers$offerList) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    final l$imageUrl = imageUrl;
    final lOther$imageUrl = other.imageUrl;
    if (l$imageUrl != lOther$imageUrl) {
      return false;
    }
    final l$fee = fee;
    final lOther$fee = other.fee;
    if (l$fee != lOther$fee) {
      return false;
    }
    final l$category = category;
    final lOther$category = other.category;
    if (l$category != lOther$category) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetOffers$getOffers$offerList
    on Query$GetOffers$getOffers$offerList {
  CopyWith$Query$GetOffers$getOffers$offerList<
          Query$GetOffers$getOffers$offerList>
      get copyWith => CopyWith$Query$GetOffers$getOffers$offerList(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetOffers$getOffers$offerList<TRes> {
  factory CopyWith$Query$GetOffers$getOffers$offerList(
    Query$GetOffers$getOffers$offerList instance,
    TRes Function(Query$GetOffers$getOffers$offerList) then,
  ) = _CopyWithImpl$Query$GetOffers$getOffers$offerList;

  factory CopyWith$Query$GetOffers$getOffers$offerList.stub(TRes res) =
      _CopyWithStubImpl$Query$GetOffers$getOffers$offerList;

  TRes call({
    int? id,
    String? title,
    String? description,
    String? imageUrl,
    int? fee,
    String? category,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetOffers$getOffers$offerList<TRes>
    implements CopyWith$Query$GetOffers$getOffers$offerList<TRes> {
  _CopyWithImpl$Query$GetOffers$getOffers$offerList(
    this._instance,
    this._then,
  );

  final Query$GetOffers$getOffers$offerList _instance;

  final TRes Function(Query$GetOffers$getOffers$offerList) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? title = _undefined,
    Object? description = _undefined,
    Object? imageUrl = _undefined,
    Object? fee = _undefined,
    Object? category = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetOffers$getOffers$offerList(
        id: id == _undefined || id == null ? _instance.id : (id as int),
        title: title == _undefined || title == null
            ? _instance.title
            : (title as String),
        description: description == _undefined || description == null
            ? _instance.description
            : (description as String),
        imageUrl:
            imageUrl == _undefined ? _instance.imageUrl : (imageUrl as String?),
        fee: fee == _undefined || fee == null ? _instance.fee : (fee as int),
        category:
            category == _undefined ? _instance.category : (category as String?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetOffers$getOffers$offerList<TRes>
    implements CopyWith$Query$GetOffers$getOffers$offerList<TRes> {
  _CopyWithStubImpl$Query$GetOffers$getOffers$offerList(this._res);

  TRes _res;

  call({
    int? id,
    String? title,
    String? description,
    String? imageUrl,
    int? fee,
    String? category,
    String? $__typename,
  }) =>
      _res;
}

class Query$GetAllOffers {
  Query$GetAllOffers({
    required this.getAllOffers,
    this.$__typename = 'QueryRoot',
  });

  factory Query$GetAllOffers.fromJson(Map<String, dynamic> json) {
    final l$getAllOffers = json['getAllOffers'];
    final l$$__typename = json['__typename'];
    return Query$GetAllOffers(
      getAllOffers: (l$getAllOffers as List<dynamic>)
          .map((e) => Query$GetAllOffers$getAllOffers.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$GetAllOffers$getAllOffers> getAllOffers;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getAllOffers = getAllOffers;
    _resultData['getAllOffers'] =
        l$getAllOffers.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getAllOffers = getAllOffers;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$getAllOffers.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetAllOffers) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$getAllOffers = getAllOffers;
    final lOther$getAllOffers = other.getAllOffers;
    if (l$getAllOffers.length != lOther$getAllOffers.length) {
      return false;
    }
    for (int i = 0; i < l$getAllOffers.length; i++) {
      final l$getAllOffers$entry = l$getAllOffers[i];
      final lOther$getAllOffers$entry = lOther$getAllOffers[i];
      if (l$getAllOffers$entry != lOther$getAllOffers$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetAllOffers on Query$GetAllOffers {
  CopyWith$Query$GetAllOffers<Query$GetAllOffers> get copyWith =>
      CopyWith$Query$GetAllOffers(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetAllOffers<TRes> {
  factory CopyWith$Query$GetAllOffers(
    Query$GetAllOffers instance,
    TRes Function(Query$GetAllOffers) then,
  ) = _CopyWithImpl$Query$GetAllOffers;

  factory CopyWith$Query$GetAllOffers.stub(TRes res) =
      _CopyWithStubImpl$Query$GetAllOffers;

  TRes call({
    List<Query$GetAllOffers$getAllOffers>? getAllOffers,
    String? $__typename,
  });
  TRes getAllOffers(
      Iterable<Query$GetAllOffers$getAllOffers> Function(
              Iterable<
                  CopyWith$Query$GetAllOffers$getAllOffers<
                      Query$GetAllOffers$getAllOffers>>)
          _fn);
}

class _CopyWithImpl$Query$GetAllOffers<TRes>
    implements CopyWith$Query$GetAllOffers<TRes> {
  _CopyWithImpl$Query$GetAllOffers(
    this._instance,
    this._then,
  );

  final Query$GetAllOffers _instance;

  final TRes Function(Query$GetAllOffers) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getAllOffers = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetAllOffers(
        getAllOffers: getAllOffers == _undefined || getAllOffers == null
            ? _instance.getAllOffers
            : (getAllOffers as List<Query$GetAllOffers$getAllOffers>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes getAllOffers(
          Iterable<Query$GetAllOffers$getAllOffers> Function(
                  Iterable<
                      CopyWith$Query$GetAllOffers$getAllOffers<
                          Query$GetAllOffers$getAllOffers>>)
              _fn) =>
      call(
          getAllOffers: _fn(_instance.getAllOffers
              .map((e) => CopyWith$Query$GetAllOffers$getAllOffers(
                    e,
                    (i) => i,
                  ))).toList());
}

class _CopyWithStubImpl$Query$GetAllOffers<TRes>
    implements CopyWith$Query$GetAllOffers<TRes> {
  _CopyWithStubImpl$Query$GetAllOffers(this._res);

  TRes _res;

  call({
    List<Query$GetAllOffers$getAllOffers>? getAllOffers,
    String? $__typename,
  }) =>
      _res;

  getAllOffers(_fn) => _res;
}

const documentNodeQueryGetAllOffers = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetAllOffers'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'getAllOffers'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'title'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'description'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'imageUrl'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'fee'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'category'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$GetAllOffers _parserFn$Query$GetAllOffers(Map<String, dynamic> data) =>
    Query$GetAllOffers.fromJson(data);
typedef OnQueryComplete$Query$GetAllOffers = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$GetAllOffers?,
);

class Options$Query$GetAllOffers
    extends graphql.QueryOptions<Query$GetAllOffers> {
  Options$Query$GetAllOffers({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetAllOffers? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetAllOffers? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null ? null : _parserFn$Query$GetAllOffers(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetAllOffers,
          parserFn: _parserFn$Query$GetAllOffers,
        );

  final OnQueryComplete$Query$GetAllOffers? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetAllOffers
    extends graphql.WatchQueryOptions<Query$GetAllOffers> {
  WatchOptions$Query$GetAllOffers({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetAllOffers? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryGetAllOffers,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetAllOffers,
        );
}

class FetchMoreOptions$Query$GetAllOffers extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetAllOffers(
      {required graphql.UpdateQuery updateQuery})
      : super(
          updateQuery: updateQuery,
          document: documentNodeQueryGetAllOffers,
        );
}

extension ClientExtension$Query$GetAllOffers on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetAllOffers>> query$GetAllOffers(
          [Options$Query$GetAllOffers? options]) async =>
      await this.query(options ?? Options$Query$GetAllOffers());
  graphql.ObservableQuery<Query$GetAllOffers> watchQuery$GetAllOffers(
          [WatchOptions$Query$GetAllOffers? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$GetAllOffers());
  void writeQuery$GetAllOffers({
    required Query$GetAllOffers data,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
            operation:
                graphql.Operation(document: documentNodeQueryGetAllOffers)),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetAllOffers? readQuery$GetAllOffers({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
          operation:
              graphql.Operation(document: documentNodeQueryGetAllOffers)),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetAllOffers.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetAllOffers> useQuery$GetAllOffers(
        [Options$Query$GetAllOffers? options]) =>
    graphql_flutter.useQuery(options ?? Options$Query$GetAllOffers());
graphql.ObservableQuery<Query$GetAllOffers> useWatchQuery$GetAllOffers(
        [WatchOptions$Query$GetAllOffers? options]) =>
    graphql_flutter.useWatchQuery(options ?? WatchOptions$Query$GetAllOffers());

class Query$GetAllOffers$Widget
    extends graphql_flutter.Query<Query$GetAllOffers> {
  Query$GetAllOffers$Widget({
    widgets.Key? key,
    Options$Query$GetAllOffers? options,
    required graphql_flutter.QueryBuilder<Query$GetAllOffers> builder,
  }) : super(
          key: key,
          options: options ?? Options$Query$GetAllOffers(),
          builder: builder,
        );
}

class Query$GetAllOffers$getAllOffers {
  Query$GetAllOffers$getAllOffers({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.fee,
    this.category,
    this.$__typename = 'OfferData',
  });

  factory Query$GetAllOffers$getAllOffers.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$title = json['title'];
    final l$description = json['description'];
    final l$imageUrl = json['imageUrl'];
    final l$fee = json['fee'];
    final l$category = json['category'];
    final l$$__typename = json['__typename'];
    return Query$GetAllOffers$getAllOffers(
      id: (l$id as int),
      title: (l$title as String),
      description: (l$description as String),
      imageUrl: (l$imageUrl as String?),
      fee: (l$fee as int),
      category: (l$category as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final int id;

  final String title;

  final String description;

  final String? imageUrl;

  final int fee;

  final String? category;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$title = title;
    _resultData['title'] = l$title;
    final l$description = description;
    _resultData['description'] = l$description;
    final l$imageUrl = imageUrl;
    _resultData['imageUrl'] = l$imageUrl;
    final l$fee = fee;
    _resultData['fee'] = l$fee;
    final l$category = category;
    _resultData['category'] = l$category;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$title = title;
    final l$description = description;
    final l$imageUrl = imageUrl;
    final l$fee = fee;
    final l$category = category;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$title,
      l$description,
      l$imageUrl,
      l$fee,
      l$category,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetAllOffers$getAllOffers) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    final l$imageUrl = imageUrl;
    final lOther$imageUrl = other.imageUrl;
    if (l$imageUrl != lOther$imageUrl) {
      return false;
    }
    final l$fee = fee;
    final lOther$fee = other.fee;
    if (l$fee != lOther$fee) {
      return false;
    }
    final l$category = category;
    final lOther$category = other.category;
    if (l$category != lOther$category) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetAllOffers$getAllOffers
    on Query$GetAllOffers$getAllOffers {
  CopyWith$Query$GetAllOffers$getAllOffers<Query$GetAllOffers$getAllOffers>
      get copyWith => CopyWith$Query$GetAllOffers$getAllOffers(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetAllOffers$getAllOffers<TRes> {
  factory CopyWith$Query$GetAllOffers$getAllOffers(
    Query$GetAllOffers$getAllOffers instance,
    TRes Function(Query$GetAllOffers$getAllOffers) then,
  ) = _CopyWithImpl$Query$GetAllOffers$getAllOffers;

  factory CopyWith$Query$GetAllOffers$getAllOffers.stub(TRes res) =
      _CopyWithStubImpl$Query$GetAllOffers$getAllOffers;

  TRes call({
    int? id,
    String? title,
    String? description,
    String? imageUrl,
    int? fee,
    String? category,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetAllOffers$getAllOffers<TRes>
    implements CopyWith$Query$GetAllOffers$getAllOffers<TRes> {
  _CopyWithImpl$Query$GetAllOffers$getAllOffers(
    this._instance,
    this._then,
  );

  final Query$GetAllOffers$getAllOffers _instance;

  final TRes Function(Query$GetAllOffers$getAllOffers) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? title = _undefined,
    Object? description = _undefined,
    Object? imageUrl = _undefined,
    Object? fee = _undefined,
    Object? category = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetAllOffers$getAllOffers(
        id: id == _undefined || id == null ? _instance.id : (id as int),
        title: title == _undefined || title == null
            ? _instance.title
            : (title as String),
        description: description == _undefined || description == null
            ? _instance.description
            : (description as String),
        imageUrl:
            imageUrl == _undefined ? _instance.imageUrl : (imageUrl as String?),
        fee: fee == _undefined || fee == null ? _instance.fee : (fee as int),
        category:
            category == _undefined ? _instance.category : (category as String?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetAllOffers$getAllOffers<TRes>
    implements CopyWith$Query$GetAllOffers$getAllOffers<TRes> {
  _CopyWithStubImpl$Query$GetAllOffers$getAllOffers(this._res);

  TRes _res;

  call({
    int? id,
    String? title,
    String? description,
    String? imageUrl,
    int? fee,
    String? category,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Query$GetOffersByCategory {
  factory Variables$Query$GetOffersByCategory({required String category}) =>
      Variables$Query$GetOffersByCategory._({
        r'category': category,
      });

  Variables$Query$GetOffersByCategory._(this._$data);

  factory Variables$Query$GetOffersByCategory.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$category = data['category'];
    result$data['category'] = (l$category as String);
    return Variables$Query$GetOffersByCategory._(result$data);
  }

  Map<String, dynamic> _$data;

  String get category => (_$data['category'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$category = category;
    result$data['category'] = l$category;
    return result$data;
  }

  CopyWith$Variables$Query$GetOffersByCategory<
          Variables$Query$GetOffersByCategory>
      get copyWith => CopyWith$Variables$Query$GetOffersByCategory(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$GetOffersByCategory) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$category = category;
    final lOther$category = other.category;
    if (l$category != lOther$category) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$category = category;
    return Object.hashAll([l$category]);
  }
}

abstract class CopyWith$Variables$Query$GetOffersByCategory<TRes> {
  factory CopyWith$Variables$Query$GetOffersByCategory(
    Variables$Query$GetOffersByCategory instance,
    TRes Function(Variables$Query$GetOffersByCategory) then,
  ) = _CopyWithImpl$Variables$Query$GetOffersByCategory;

  factory CopyWith$Variables$Query$GetOffersByCategory.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$GetOffersByCategory;

  TRes call({String? category});
}

class _CopyWithImpl$Variables$Query$GetOffersByCategory<TRes>
    implements CopyWith$Variables$Query$GetOffersByCategory<TRes> {
  _CopyWithImpl$Variables$Query$GetOffersByCategory(
    this._instance,
    this._then,
  );

  final Variables$Query$GetOffersByCategory _instance;

  final TRes Function(Variables$Query$GetOffersByCategory) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? category = _undefined}) =>
      _then(Variables$Query$GetOffersByCategory._({
        ..._instance._$data,
        if (category != _undefined && category != null)
          'category': (category as String),
      }));
}

class _CopyWithStubImpl$Variables$Query$GetOffersByCategory<TRes>
    implements CopyWith$Variables$Query$GetOffersByCategory<TRes> {
  _CopyWithStubImpl$Variables$Query$GetOffersByCategory(this._res);

  TRes _res;

  call({String? category}) => _res;
}

class Query$GetOffersByCategory {
  Query$GetOffersByCategory({
    required this.getOffersByCategory,
    this.$__typename = 'QueryRoot',
  });

  factory Query$GetOffersByCategory.fromJson(Map<String, dynamic> json) {
    final l$getOffersByCategory = json['getOffersByCategory'];
    final l$$__typename = json['__typename'];
    return Query$GetOffersByCategory(
      getOffersByCategory:
          Query$GetOffersByCategory$getOffersByCategory.fromJson(
              (l$getOffersByCategory as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetOffersByCategory$getOffersByCategory getOffersByCategory;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getOffersByCategory = getOffersByCategory;
    _resultData['getOffersByCategory'] = l$getOffersByCategory.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getOffersByCategory = getOffersByCategory;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$getOffersByCategory,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetOffersByCategory) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$getOffersByCategory = getOffersByCategory;
    final lOther$getOffersByCategory = other.getOffersByCategory;
    if (l$getOffersByCategory != lOther$getOffersByCategory) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetOffersByCategory
    on Query$GetOffersByCategory {
  CopyWith$Query$GetOffersByCategory<Query$GetOffersByCategory> get copyWith =>
      CopyWith$Query$GetOffersByCategory(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetOffersByCategory<TRes> {
  factory CopyWith$Query$GetOffersByCategory(
    Query$GetOffersByCategory instance,
    TRes Function(Query$GetOffersByCategory) then,
  ) = _CopyWithImpl$Query$GetOffersByCategory;

  factory CopyWith$Query$GetOffersByCategory.stub(TRes res) =
      _CopyWithStubImpl$Query$GetOffersByCategory;

  TRes call({
    Query$GetOffersByCategory$getOffersByCategory? getOffersByCategory,
    String? $__typename,
  });
  CopyWith$Query$GetOffersByCategory$getOffersByCategory<TRes>
      get getOffersByCategory;
}

class _CopyWithImpl$Query$GetOffersByCategory<TRes>
    implements CopyWith$Query$GetOffersByCategory<TRes> {
  _CopyWithImpl$Query$GetOffersByCategory(
    this._instance,
    this._then,
  );

  final Query$GetOffersByCategory _instance;

  final TRes Function(Query$GetOffersByCategory) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getOffersByCategory = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetOffersByCategory(
        getOffersByCategory:
            getOffersByCategory == _undefined || getOffersByCategory == null
                ? _instance.getOffersByCategory
                : (getOffersByCategory
                    as Query$GetOffersByCategory$getOffersByCategory),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetOffersByCategory$getOffersByCategory<TRes>
      get getOffersByCategory {
    final local$getOffersByCategory = _instance.getOffersByCategory;
    return CopyWith$Query$GetOffersByCategory$getOffersByCategory(
        local$getOffersByCategory, (e) => call(getOffersByCategory: e));
  }
}

class _CopyWithStubImpl$Query$GetOffersByCategory<TRes>
    implements CopyWith$Query$GetOffersByCategory<TRes> {
  _CopyWithStubImpl$Query$GetOffersByCategory(this._res);

  TRes _res;

  call({
    Query$GetOffersByCategory$getOffersByCategory? getOffersByCategory,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetOffersByCategory$getOffersByCategory<TRes>
      get getOffersByCategory =>
          CopyWith$Query$GetOffersByCategory$getOffersByCategory.stub(_res);
}

const documentNodeQueryGetOffersByCategory = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetOffersByCategory'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'category')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'getOffersByCategory'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'category'),
            value: VariableNode(name: NameNode(value: 'category')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'offerList'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'title'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'description'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'imageUrl'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'fee'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'category'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$GetOffersByCategory _parserFn$Query$GetOffersByCategory(
        Map<String, dynamic> data) =>
    Query$GetOffersByCategory.fromJson(data);
typedef OnQueryComplete$Query$GetOffersByCategory = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$GetOffersByCategory?,
);

class Options$Query$GetOffersByCategory
    extends graphql.QueryOptions<Query$GetOffersByCategory> {
  Options$Query$GetOffersByCategory({
    String? operationName,
    required Variables$Query$GetOffersByCategory variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetOffersByCategory? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetOffersByCategory? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null
                        ? null
                        : _parserFn$Query$GetOffersByCategory(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetOffersByCategory,
          parserFn: _parserFn$Query$GetOffersByCategory,
        );

  final OnQueryComplete$Query$GetOffersByCategory? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetOffersByCategory
    extends graphql.WatchQueryOptions<Query$GetOffersByCategory> {
  WatchOptions$Query$GetOffersByCategory({
    String? operationName,
    required Variables$Query$GetOffersByCategory variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetOffersByCategory? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryGetOffersByCategory,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetOffersByCategory,
        );
}

class FetchMoreOptions$Query$GetOffersByCategory
    extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetOffersByCategory({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$GetOffersByCategory variables,
  }) : super(
          updateQuery: updateQuery,
          variables: variables.toJson(),
          document: documentNodeQueryGetOffersByCategory,
        );
}

extension ClientExtension$Query$GetOffersByCategory on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetOffersByCategory>>
      query$GetOffersByCategory(
              Options$Query$GetOffersByCategory options) async =>
          await this.query(options);
  graphql.ObservableQuery<Query$GetOffersByCategory>
      watchQuery$GetOffersByCategory(
              WatchOptions$Query$GetOffersByCategory options) =>
          this.watchQuery(options);
  void writeQuery$GetOffersByCategory({
    required Query$GetOffersByCategory data,
    required Variables$Query$GetOffersByCategory variables,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
          operation:
              graphql.Operation(document: documentNodeQueryGetOffersByCategory),
          variables: variables.toJson(),
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetOffersByCategory? readQuery$GetOffersByCategory({
    required Variables$Query$GetOffersByCategory variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation:
            graphql.Operation(document: documentNodeQueryGetOffersByCategory),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetOffersByCategory.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetOffersByCategory>
    useQuery$GetOffersByCategory(Options$Query$GetOffersByCategory options) =>
        graphql_flutter.useQuery(options);
graphql.ObservableQuery<Query$GetOffersByCategory>
    useWatchQuery$GetOffersByCategory(
            WatchOptions$Query$GetOffersByCategory options) =>
        graphql_flutter.useWatchQuery(options);

class Query$GetOffersByCategory$Widget
    extends graphql_flutter.Query<Query$GetOffersByCategory> {
  Query$GetOffersByCategory$Widget({
    widgets.Key? key,
    required Options$Query$GetOffersByCategory options,
    required graphql_flutter.QueryBuilder<Query$GetOffersByCategory> builder,
  }) : super(
          key: key,
          options: options,
          builder: builder,
        );
}

class Query$GetOffersByCategory$getOffersByCategory {
  Query$GetOffersByCategory$getOffersByCategory({
    required this.offerList,
    this.$__typename = 'OffersData',
  });

  factory Query$GetOffersByCategory$getOffersByCategory.fromJson(
      Map<String, dynamic> json) {
    final l$offerList = json['offerList'];
    final l$$__typename = json['__typename'];
    return Query$GetOffersByCategory$getOffersByCategory(
      offerList: (l$offerList as List<dynamic>)
          .map((e) =>
              Query$GetOffersByCategory$getOffersByCategory$offerList.fromJson(
                  (e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$GetOffersByCategory$getOffersByCategory$offerList> offerList;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$offerList = offerList;
    _resultData['offerList'] = l$offerList.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$offerList = offerList;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$offerList.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetOffersByCategory$getOffersByCategory) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$offerList = offerList;
    final lOther$offerList = other.offerList;
    if (l$offerList.length != lOther$offerList.length) {
      return false;
    }
    for (int i = 0; i < l$offerList.length; i++) {
      final l$offerList$entry = l$offerList[i];
      final lOther$offerList$entry = lOther$offerList[i];
      if (l$offerList$entry != lOther$offerList$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetOffersByCategory$getOffersByCategory
    on Query$GetOffersByCategory$getOffersByCategory {
  CopyWith$Query$GetOffersByCategory$getOffersByCategory<
          Query$GetOffersByCategory$getOffersByCategory>
      get copyWith => CopyWith$Query$GetOffersByCategory$getOffersByCategory(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetOffersByCategory$getOffersByCategory<TRes> {
  factory CopyWith$Query$GetOffersByCategory$getOffersByCategory(
    Query$GetOffersByCategory$getOffersByCategory instance,
    TRes Function(Query$GetOffersByCategory$getOffersByCategory) then,
  ) = _CopyWithImpl$Query$GetOffersByCategory$getOffersByCategory;

  factory CopyWith$Query$GetOffersByCategory$getOffersByCategory.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetOffersByCategory$getOffersByCategory;

  TRes call({
    List<Query$GetOffersByCategory$getOffersByCategory$offerList>? offerList,
    String? $__typename,
  });
  TRes offerList(
      Iterable<Query$GetOffersByCategory$getOffersByCategory$offerList> Function(
              Iterable<
                  CopyWith$Query$GetOffersByCategory$getOffersByCategory$offerList<
                      Query$GetOffersByCategory$getOffersByCategory$offerList>>)
          _fn);
}

class _CopyWithImpl$Query$GetOffersByCategory$getOffersByCategory<TRes>
    implements CopyWith$Query$GetOffersByCategory$getOffersByCategory<TRes> {
  _CopyWithImpl$Query$GetOffersByCategory$getOffersByCategory(
    this._instance,
    this._then,
  );

  final Query$GetOffersByCategory$getOffersByCategory _instance;

  final TRes Function(Query$GetOffersByCategory$getOffersByCategory) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? offerList = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetOffersByCategory$getOffersByCategory(
        offerList: offerList == _undefined || offerList == null
            ? _instance.offerList
            : (offerList as List<
                Query$GetOffersByCategory$getOffersByCategory$offerList>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes offerList(
          Iterable<Query$GetOffersByCategory$getOffersByCategory$offerList> Function(
                  Iterable<
                      CopyWith$Query$GetOffersByCategory$getOffersByCategory$offerList<
                          Query$GetOffersByCategory$getOffersByCategory$offerList>>)
              _fn) =>
      call(
          offerList: _fn(_instance.offerList.map((e) =>
              CopyWith$Query$GetOffersByCategory$getOffersByCategory$offerList(
                e,
                (i) => i,
              ))).toList());
}

class _CopyWithStubImpl$Query$GetOffersByCategory$getOffersByCategory<TRes>
    implements CopyWith$Query$GetOffersByCategory$getOffersByCategory<TRes> {
  _CopyWithStubImpl$Query$GetOffersByCategory$getOffersByCategory(this._res);

  TRes _res;

  call({
    List<Query$GetOffersByCategory$getOffersByCategory$offerList>? offerList,
    String? $__typename,
  }) =>
      _res;

  offerList(_fn) => _res;
}

class Query$GetOffersByCategory$getOffersByCategory$offerList {
  Query$GetOffersByCategory$getOffersByCategory$offerList({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.fee,
    this.category,
    this.$__typename = 'OfferData',
  });

  factory Query$GetOffersByCategory$getOffersByCategory$offerList.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$title = json['title'];
    final l$description = json['description'];
    final l$imageUrl = json['imageUrl'];
    final l$fee = json['fee'];
    final l$category = json['category'];
    final l$$__typename = json['__typename'];
    return Query$GetOffersByCategory$getOffersByCategory$offerList(
      id: (l$id as int),
      title: (l$title as String),
      description: (l$description as String),
      imageUrl: (l$imageUrl as String?),
      fee: (l$fee as int),
      category: (l$category as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final int id;

  final String title;

  final String description;

  final String? imageUrl;

  final int fee;

  final String? category;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$title = title;
    _resultData['title'] = l$title;
    final l$description = description;
    _resultData['description'] = l$description;
    final l$imageUrl = imageUrl;
    _resultData['imageUrl'] = l$imageUrl;
    final l$fee = fee;
    _resultData['fee'] = l$fee;
    final l$category = category;
    _resultData['category'] = l$category;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$title = title;
    final l$description = description;
    final l$imageUrl = imageUrl;
    final l$fee = fee;
    final l$category = category;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$title,
      l$description,
      l$imageUrl,
      l$fee,
      l$category,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetOffersByCategory$getOffersByCategory$offerList) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    final l$imageUrl = imageUrl;
    final lOther$imageUrl = other.imageUrl;
    if (l$imageUrl != lOther$imageUrl) {
      return false;
    }
    final l$fee = fee;
    final lOther$fee = other.fee;
    if (l$fee != lOther$fee) {
      return false;
    }
    final l$category = category;
    final lOther$category = other.category;
    if (l$category != lOther$category) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetOffersByCategory$getOffersByCategory$offerList
    on Query$GetOffersByCategory$getOffersByCategory$offerList {
  CopyWith$Query$GetOffersByCategory$getOffersByCategory$offerList<
          Query$GetOffersByCategory$getOffersByCategory$offerList>
      get copyWith =>
          CopyWith$Query$GetOffersByCategory$getOffersByCategory$offerList(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetOffersByCategory$getOffersByCategory$offerList<
    TRes> {
  factory CopyWith$Query$GetOffersByCategory$getOffersByCategory$offerList(
    Query$GetOffersByCategory$getOffersByCategory$offerList instance,
    TRes Function(Query$GetOffersByCategory$getOffersByCategory$offerList) then,
  ) = _CopyWithImpl$Query$GetOffersByCategory$getOffersByCategory$offerList;

  factory CopyWith$Query$GetOffersByCategory$getOffersByCategory$offerList.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetOffersByCategory$getOffersByCategory$offerList;

  TRes call({
    int? id,
    String? title,
    String? description,
    String? imageUrl,
    int? fee,
    String? category,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetOffersByCategory$getOffersByCategory$offerList<
        TRes>
    implements
        CopyWith$Query$GetOffersByCategory$getOffersByCategory$offerList<TRes> {
  _CopyWithImpl$Query$GetOffersByCategory$getOffersByCategory$offerList(
    this._instance,
    this._then,
  );

  final Query$GetOffersByCategory$getOffersByCategory$offerList _instance;

  final TRes Function(Query$GetOffersByCategory$getOffersByCategory$offerList)
      _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? title = _undefined,
    Object? description = _undefined,
    Object? imageUrl = _undefined,
    Object? fee = _undefined,
    Object? category = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetOffersByCategory$getOffersByCategory$offerList(
        id: id == _undefined || id == null ? _instance.id : (id as int),
        title: title == _undefined || title == null
            ? _instance.title
            : (title as String),
        description: description == _undefined || description == null
            ? _instance.description
            : (description as String),
        imageUrl:
            imageUrl == _undefined ? _instance.imageUrl : (imageUrl as String?),
        fee: fee == _undefined || fee == null ? _instance.fee : (fee as int),
        category:
            category == _undefined ? _instance.category : (category as String?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetOffersByCategory$getOffersByCategory$offerList<
        TRes>
    implements
        CopyWith$Query$GetOffersByCategory$getOffersByCategory$offerList<TRes> {
  _CopyWithStubImpl$Query$GetOffersByCategory$getOffersByCategory$offerList(
      this._res);

  TRes _res;

  call({
    int? id,
    String? title,
    String? description,
    String? imageUrl,
    int? fee,
    String? category,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Query$GetMessageRooms {
  factory Variables$Query$GetMessageRooms({required String userId}) =>
      Variables$Query$GetMessageRooms._({
        r'userId': userId,
      });

  Variables$Query$GetMessageRooms._(this._$data);

  factory Variables$Query$GetMessageRooms.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    return Variables$Query$GetMessageRooms._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$userId = userId;
    result$data['userId'] = l$userId;
    return result$data;
  }

  CopyWith$Variables$Query$GetMessageRooms<Variables$Query$GetMessageRooms>
      get copyWith => CopyWith$Variables$Query$GetMessageRooms(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$GetMessageRooms) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    return Object.hashAll([l$userId]);
  }
}

abstract class CopyWith$Variables$Query$GetMessageRooms<TRes> {
  factory CopyWith$Variables$Query$GetMessageRooms(
    Variables$Query$GetMessageRooms instance,
    TRes Function(Variables$Query$GetMessageRooms) then,
  ) = _CopyWithImpl$Variables$Query$GetMessageRooms;

  factory CopyWith$Variables$Query$GetMessageRooms.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$GetMessageRooms;

  TRes call({String? userId});
}

class _CopyWithImpl$Variables$Query$GetMessageRooms<TRes>
    implements CopyWith$Variables$Query$GetMessageRooms<TRes> {
  _CopyWithImpl$Variables$Query$GetMessageRooms(
    this._instance,
    this._then,
  );

  final Variables$Query$GetMessageRooms _instance;

  final TRes Function(Variables$Query$GetMessageRooms) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? userId = _undefined}) =>
      _then(Variables$Query$GetMessageRooms._({
        ..._instance._$data,
        if (userId != _undefined && userId != null)
          'userId': (userId as String),
      }));
}

class _CopyWithStubImpl$Variables$Query$GetMessageRooms<TRes>
    implements CopyWith$Variables$Query$GetMessageRooms<TRes> {
  _CopyWithStubImpl$Variables$Query$GetMessageRooms(this._res);

  TRes _res;

  call({String? userId}) => _res;
}

class Query$GetMessageRooms {
  Query$GetMessageRooms({
    required this.getMessageRooms,
    this.$__typename = 'QueryRoot',
  });

  factory Query$GetMessageRooms.fromJson(Map<String, dynamic> json) {
    final l$getMessageRooms = json['getMessageRooms'];
    final l$$__typename = json['__typename'];
    return Query$GetMessageRooms(
      getMessageRooms: Query$GetMessageRooms$getMessageRooms.fromJson(
          (l$getMessageRooms as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetMessageRooms$getMessageRooms getMessageRooms;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getMessageRooms = getMessageRooms;
    _resultData['getMessageRooms'] = l$getMessageRooms.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getMessageRooms = getMessageRooms;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$getMessageRooms,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetMessageRooms) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$getMessageRooms = getMessageRooms;
    final lOther$getMessageRooms = other.getMessageRooms;
    if (l$getMessageRooms != lOther$getMessageRooms) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMessageRooms on Query$GetMessageRooms {
  CopyWith$Query$GetMessageRooms<Query$GetMessageRooms> get copyWith =>
      CopyWith$Query$GetMessageRooms(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetMessageRooms<TRes> {
  factory CopyWith$Query$GetMessageRooms(
    Query$GetMessageRooms instance,
    TRes Function(Query$GetMessageRooms) then,
  ) = _CopyWithImpl$Query$GetMessageRooms;

  factory CopyWith$Query$GetMessageRooms.stub(TRes res) =
      _CopyWithStubImpl$Query$GetMessageRooms;

  TRes call({
    Query$GetMessageRooms$getMessageRooms? getMessageRooms,
    String? $__typename,
  });
  CopyWith$Query$GetMessageRooms$getMessageRooms<TRes> get getMessageRooms;
}

class _CopyWithImpl$Query$GetMessageRooms<TRes>
    implements CopyWith$Query$GetMessageRooms<TRes> {
  _CopyWithImpl$Query$GetMessageRooms(
    this._instance,
    this._then,
  );

  final Query$GetMessageRooms _instance;

  final TRes Function(Query$GetMessageRooms) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getMessageRooms = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetMessageRooms(
        getMessageRooms:
            getMessageRooms == _undefined || getMessageRooms == null
                ? _instance.getMessageRooms
                : (getMessageRooms as Query$GetMessageRooms$getMessageRooms),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetMessageRooms$getMessageRooms<TRes> get getMessageRooms {
    final local$getMessageRooms = _instance.getMessageRooms;
    return CopyWith$Query$GetMessageRooms$getMessageRooms(
        local$getMessageRooms, (e) => call(getMessageRooms: e));
  }
}

class _CopyWithStubImpl$Query$GetMessageRooms<TRes>
    implements CopyWith$Query$GetMessageRooms<TRes> {
  _CopyWithStubImpl$Query$GetMessageRooms(this._res);

  TRes _res;

  call({
    Query$GetMessageRooms$getMessageRooms? getMessageRooms,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetMessageRooms$getMessageRooms<TRes> get getMessageRooms =>
      CopyWith$Query$GetMessageRooms$getMessageRooms.stub(_res);
}

const documentNodeQueryGetMessageRooms = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetMessageRooms'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'userId')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'getMessageRooms'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'userId'),
            value: VariableNode(name: NameNode(value: 'userId')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'messageRoomList'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'category'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'latestMessage'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'latestSentAt'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'isRead'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'users'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: SelectionSetNode(selections: [
                  FieldNode(
                    name: NameNode(value: 'id'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'name'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'imageUrl'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: '__typename'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                ]),
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: 'countOfMessageRooms'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$GetMessageRooms _parserFn$Query$GetMessageRooms(
        Map<String, dynamic> data) =>
    Query$GetMessageRooms.fromJson(data);
typedef OnQueryComplete$Query$GetMessageRooms = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$GetMessageRooms?,
);

class Options$Query$GetMessageRooms
    extends graphql.QueryOptions<Query$GetMessageRooms> {
  Options$Query$GetMessageRooms({
    String? operationName,
    required Variables$Query$GetMessageRooms variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetMessageRooms? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetMessageRooms? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null ? null : _parserFn$Query$GetMessageRooms(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetMessageRooms,
          parserFn: _parserFn$Query$GetMessageRooms,
        );

  final OnQueryComplete$Query$GetMessageRooms? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetMessageRooms
    extends graphql.WatchQueryOptions<Query$GetMessageRooms> {
  WatchOptions$Query$GetMessageRooms({
    String? operationName,
    required Variables$Query$GetMessageRooms variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetMessageRooms? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryGetMessageRooms,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetMessageRooms,
        );
}

class FetchMoreOptions$Query$GetMessageRooms extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetMessageRooms({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$GetMessageRooms variables,
  }) : super(
          updateQuery: updateQuery,
          variables: variables.toJson(),
          document: documentNodeQueryGetMessageRooms,
        );
}

extension ClientExtension$Query$GetMessageRooms on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetMessageRooms>> query$GetMessageRooms(
          Options$Query$GetMessageRooms options) async =>
      await this.query(options);
  graphql.ObservableQuery<Query$GetMessageRooms> watchQuery$GetMessageRooms(
          WatchOptions$Query$GetMessageRooms options) =>
      this.watchQuery(options);
  void writeQuery$GetMessageRooms({
    required Query$GetMessageRooms data,
    required Variables$Query$GetMessageRooms variables,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
          operation:
              graphql.Operation(document: documentNodeQueryGetMessageRooms),
          variables: variables.toJson(),
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetMessageRooms? readQuery$GetMessageRooms({
    required Variables$Query$GetMessageRooms variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation:
            graphql.Operation(document: documentNodeQueryGetMessageRooms),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetMessageRooms.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetMessageRooms> useQuery$GetMessageRooms(
        Options$Query$GetMessageRooms options) =>
    graphql_flutter.useQuery(options);
graphql.ObservableQuery<Query$GetMessageRooms> useWatchQuery$GetMessageRooms(
        WatchOptions$Query$GetMessageRooms options) =>
    graphql_flutter.useWatchQuery(options);

class Query$GetMessageRooms$Widget
    extends graphql_flutter.Query<Query$GetMessageRooms> {
  Query$GetMessageRooms$Widget({
    widgets.Key? key,
    required Options$Query$GetMessageRooms options,
    required graphql_flutter.QueryBuilder<Query$GetMessageRooms> builder,
  }) : super(
          key: key,
          options: options,
          builder: builder,
        );
}

class Query$GetMessageRooms$getMessageRooms {
  Query$GetMessageRooms$getMessageRooms({
    required this.messageRoomList,
    required this.countOfMessageRooms,
    this.$__typename = 'MessageRoomsByUserData',
  });

  factory Query$GetMessageRooms$getMessageRooms.fromJson(
      Map<String, dynamic> json) {
    final l$messageRoomList = json['messageRoomList'];
    final l$countOfMessageRooms = json['countOfMessageRooms'];
    final l$$__typename = json['__typename'];
    return Query$GetMessageRooms$getMessageRooms(
      messageRoomList: (l$messageRoomList as List<dynamic>)
          .map((e) =>
              Query$GetMessageRooms$getMessageRooms$messageRoomList.fromJson(
                  (e as Map<String, dynamic>)))
          .toList(),
      countOfMessageRooms: (l$countOfMessageRooms as int),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$GetMessageRooms$getMessageRooms$messageRoomList>
      messageRoomList;

  final int countOfMessageRooms;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$messageRoomList = messageRoomList;
    _resultData['messageRoomList'] =
        l$messageRoomList.map((e) => e.toJson()).toList();
    final l$countOfMessageRooms = countOfMessageRooms;
    _resultData['countOfMessageRooms'] = l$countOfMessageRooms;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$messageRoomList = messageRoomList;
    final l$countOfMessageRooms = countOfMessageRooms;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$messageRoomList.map((v) => v)),
      l$countOfMessageRooms,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetMessageRooms$getMessageRooms) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$messageRoomList = messageRoomList;
    final lOther$messageRoomList = other.messageRoomList;
    if (l$messageRoomList.length != lOther$messageRoomList.length) {
      return false;
    }
    for (int i = 0; i < l$messageRoomList.length; i++) {
      final l$messageRoomList$entry = l$messageRoomList[i];
      final lOther$messageRoomList$entry = lOther$messageRoomList[i];
      if (l$messageRoomList$entry != lOther$messageRoomList$entry) {
        return false;
      }
    }
    final l$countOfMessageRooms = countOfMessageRooms;
    final lOther$countOfMessageRooms = other.countOfMessageRooms;
    if (l$countOfMessageRooms != lOther$countOfMessageRooms) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMessageRooms$getMessageRooms
    on Query$GetMessageRooms$getMessageRooms {
  CopyWith$Query$GetMessageRooms$getMessageRooms<
          Query$GetMessageRooms$getMessageRooms>
      get copyWith => CopyWith$Query$GetMessageRooms$getMessageRooms(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetMessageRooms$getMessageRooms<TRes> {
  factory CopyWith$Query$GetMessageRooms$getMessageRooms(
    Query$GetMessageRooms$getMessageRooms instance,
    TRes Function(Query$GetMessageRooms$getMessageRooms) then,
  ) = _CopyWithImpl$Query$GetMessageRooms$getMessageRooms;

  factory CopyWith$Query$GetMessageRooms$getMessageRooms.stub(TRes res) =
      _CopyWithStubImpl$Query$GetMessageRooms$getMessageRooms;

  TRes call({
    List<Query$GetMessageRooms$getMessageRooms$messageRoomList>?
        messageRoomList,
    int? countOfMessageRooms,
    String? $__typename,
  });
  TRes messageRoomList(
      Iterable<Query$GetMessageRooms$getMessageRooms$messageRoomList> Function(
              Iterable<
                  CopyWith$Query$GetMessageRooms$getMessageRooms$messageRoomList<
                      Query$GetMessageRooms$getMessageRooms$messageRoomList>>)
          _fn);
}

class _CopyWithImpl$Query$GetMessageRooms$getMessageRooms<TRes>
    implements CopyWith$Query$GetMessageRooms$getMessageRooms<TRes> {
  _CopyWithImpl$Query$GetMessageRooms$getMessageRooms(
    this._instance,
    this._then,
  );

  final Query$GetMessageRooms$getMessageRooms _instance;

  final TRes Function(Query$GetMessageRooms$getMessageRooms) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? messageRoomList = _undefined,
    Object? countOfMessageRooms = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetMessageRooms$getMessageRooms(
        messageRoomList: messageRoomList == _undefined ||
                messageRoomList == null
            ? _instance.messageRoomList
            : (messageRoomList
                as List<Query$GetMessageRooms$getMessageRooms$messageRoomList>),
        countOfMessageRooms:
            countOfMessageRooms == _undefined || countOfMessageRooms == null
                ? _instance.countOfMessageRooms
                : (countOfMessageRooms as int),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes messageRoomList(
          Iterable<Query$GetMessageRooms$getMessageRooms$messageRoomList> Function(
                  Iterable<
                      CopyWith$Query$GetMessageRooms$getMessageRooms$messageRoomList<
                          Query$GetMessageRooms$getMessageRooms$messageRoomList>>)
              _fn) =>
      call(
          messageRoomList: _fn(_instance.messageRoomList.map((e) =>
              CopyWith$Query$GetMessageRooms$getMessageRooms$messageRoomList(
                e,
                (i) => i,
              ))).toList());
}

class _CopyWithStubImpl$Query$GetMessageRooms$getMessageRooms<TRes>
    implements CopyWith$Query$GetMessageRooms$getMessageRooms<TRes> {
  _CopyWithStubImpl$Query$GetMessageRooms$getMessageRooms(this._res);

  TRes _res;

  call({
    List<Query$GetMessageRooms$getMessageRooms$messageRoomList>?
        messageRoomList,
    int? countOfMessageRooms,
    String? $__typename,
  }) =>
      _res;

  messageRoomList(_fn) => _res;
}

class Query$GetMessageRooms$getMessageRooms$messageRoomList {
  Query$GetMessageRooms$getMessageRooms$messageRoomList({
    required this.id,
    this.category,
    this.latestMessage,
    this.latestSentAt,
    required this.isRead,
    required this.users,
    this.$__typename = 'MessageRoomData',
  });

  factory Query$GetMessageRooms$getMessageRooms$messageRoomList.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$category = json['category'];
    final l$latestMessage = json['latestMessage'];
    final l$latestSentAt = json['latestSentAt'];
    final l$isRead = json['isRead'];
    final l$users = json['users'];
    final l$$__typename = json['__typename'];
    return Query$GetMessageRooms$getMessageRooms$messageRoomList(
      id: (l$id as String),
      category: (l$category as String?),
      latestMessage: (l$latestMessage as String?),
      latestSentAt: (l$latestSentAt as String?),
      isRead: (l$isRead as bool),
      users: (l$users as List<dynamic>)
          .map((e) =>
              Query$GetMessageRooms$getMessageRooms$messageRoomList$users
                  .fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String? category;

  final String? latestMessage;

  final String? latestSentAt;

  final bool isRead;

  final List<Query$GetMessageRooms$getMessageRooms$messageRoomList$users> users;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$category = category;
    _resultData['category'] = l$category;
    final l$latestMessage = latestMessage;
    _resultData['latestMessage'] = l$latestMessage;
    final l$latestSentAt = latestSentAt;
    _resultData['latestSentAt'] = l$latestSentAt;
    final l$isRead = isRead;
    _resultData['isRead'] = l$isRead;
    final l$users = users;
    _resultData['users'] = l$users.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$category = category;
    final l$latestMessage = latestMessage;
    final l$latestSentAt = latestSentAt;
    final l$isRead = isRead;
    final l$users = users;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$category,
      l$latestMessage,
      l$latestSentAt,
      l$isRead,
      Object.hashAll(l$users.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetMessageRooms$getMessageRooms$messageRoomList) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$category = category;
    final lOther$category = other.category;
    if (l$category != lOther$category) {
      return false;
    }
    final l$latestMessage = latestMessage;
    final lOther$latestMessage = other.latestMessage;
    if (l$latestMessage != lOther$latestMessage) {
      return false;
    }
    final l$latestSentAt = latestSentAt;
    final lOther$latestSentAt = other.latestSentAt;
    if (l$latestSentAt != lOther$latestSentAt) {
      return false;
    }
    final l$isRead = isRead;
    final lOther$isRead = other.isRead;
    if (l$isRead != lOther$isRead) {
      return false;
    }
    final l$users = users;
    final lOther$users = other.users;
    if (l$users.length != lOther$users.length) {
      return false;
    }
    for (int i = 0; i < l$users.length; i++) {
      final l$users$entry = l$users[i];
      final lOther$users$entry = lOther$users[i];
      if (l$users$entry != lOther$users$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMessageRooms$getMessageRooms$messageRoomList
    on Query$GetMessageRooms$getMessageRooms$messageRoomList {
  CopyWith$Query$GetMessageRooms$getMessageRooms$messageRoomList<
          Query$GetMessageRooms$getMessageRooms$messageRoomList>
      get copyWith =>
          CopyWith$Query$GetMessageRooms$getMessageRooms$messageRoomList(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetMessageRooms$getMessageRooms$messageRoomList<
    TRes> {
  factory CopyWith$Query$GetMessageRooms$getMessageRooms$messageRoomList(
    Query$GetMessageRooms$getMessageRooms$messageRoomList instance,
    TRes Function(Query$GetMessageRooms$getMessageRooms$messageRoomList) then,
  ) = _CopyWithImpl$Query$GetMessageRooms$getMessageRooms$messageRoomList;

  factory CopyWith$Query$GetMessageRooms$getMessageRooms$messageRoomList.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetMessageRooms$getMessageRooms$messageRoomList;

  TRes call({
    String? id,
    String? category,
    String? latestMessage,
    String? latestSentAt,
    bool? isRead,
    List<Query$GetMessageRooms$getMessageRooms$messageRoomList$users>? users,
    String? $__typename,
  });
  TRes users(
      Iterable<Query$GetMessageRooms$getMessageRooms$messageRoomList$users> Function(
              Iterable<
                  CopyWith$Query$GetMessageRooms$getMessageRooms$messageRoomList$users<
                      Query$GetMessageRooms$getMessageRooms$messageRoomList$users>>)
          _fn);
}

class _CopyWithImpl$Query$GetMessageRooms$getMessageRooms$messageRoomList<TRes>
    implements
        CopyWith$Query$GetMessageRooms$getMessageRooms$messageRoomList<TRes> {
  _CopyWithImpl$Query$GetMessageRooms$getMessageRooms$messageRoomList(
    this._instance,
    this._then,
  );

  final Query$GetMessageRooms$getMessageRooms$messageRoomList _instance;

  final TRes Function(Query$GetMessageRooms$getMessageRooms$messageRoomList)
      _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? category = _undefined,
    Object? latestMessage = _undefined,
    Object? latestSentAt = _undefined,
    Object? isRead = _undefined,
    Object? users = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetMessageRooms$getMessageRooms$messageRoomList(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        category:
            category == _undefined ? _instance.category : (category as String?),
        latestMessage: latestMessage == _undefined
            ? _instance.latestMessage
            : (latestMessage as String?),
        latestSentAt: latestSentAt == _undefined
            ? _instance.latestSentAt
            : (latestSentAt as String?),
        isRead: isRead == _undefined || isRead == null
            ? _instance.isRead
            : (isRead as bool),
        users: users == _undefined || users == null
            ? _instance.users
            : (users as List<
                Query$GetMessageRooms$getMessageRooms$messageRoomList$users>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes users(
          Iterable<Query$GetMessageRooms$getMessageRooms$messageRoomList$users> Function(
                  Iterable<
                      CopyWith$Query$GetMessageRooms$getMessageRooms$messageRoomList$users<
                          Query$GetMessageRooms$getMessageRooms$messageRoomList$users>>)
              _fn) =>
      call(
          users: _fn(_instance.users.map((e) =>
              CopyWith$Query$GetMessageRooms$getMessageRooms$messageRoomList$users(
                e,
                (i) => i,
              ))).toList());
}

class _CopyWithStubImpl$Query$GetMessageRooms$getMessageRooms$messageRoomList<
        TRes>
    implements
        CopyWith$Query$GetMessageRooms$getMessageRooms$messageRoomList<TRes> {
  _CopyWithStubImpl$Query$GetMessageRooms$getMessageRooms$messageRoomList(
      this._res);

  TRes _res;

  call({
    String? id,
    String? category,
    String? latestMessage,
    String? latestSentAt,
    bool? isRead,
    List<Query$GetMessageRooms$getMessageRooms$messageRoomList$users>? users,
    String? $__typename,
  }) =>
      _res;

  users(_fn) => _res;
}

class Query$GetMessageRooms$getMessageRooms$messageRoomList$users {
  Query$GetMessageRooms$getMessageRooms$messageRoomList$users({
    required this.id,
    required this.name,
    this.imageUrl,
    this.$__typename = 'UserSimpleData',
  });

  factory Query$GetMessageRooms$getMessageRooms$messageRoomList$users.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$imageUrl = json['imageUrl'];
    final l$$__typename = json['__typename'];
    return Query$GetMessageRooms$getMessageRooms$messageRoomList$users(
      id: (l$id as String),
      name: (l$name as String),
      imageUrl: (l$imageUrl as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String name;

  final String? imageUrl;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$imageUrl = imageUrl;
    _resultData['imageUrl'] = l$imageUrl;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$imageUrl = imageUrl;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$name,
      l$imageUrl,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other
            is Query$GetMessageRooms$getMessageRooms$messageRoomList$users) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$imageUrl = imageUrl;
    final lOther$imageUrl = other.imageUrl;
    if (l$imageUrl != lOther$imageUrl) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMessageRooms$getMessageRooms$messageRoomList$users
    on Query$GetMessageRooms$getMessageRooms$messageRoomList$users {
  CopyWith$Query$GetMessageRooms$getMessageRooms$messageRoomList$users<
          Query$GetMessageRooms$getMessageRooms$messageRoomList$users>
      get copyWith =>
          CopyWith$Query$GetMessageRooms$getMessageRooms$messageRoomList$users(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetMessageRooms$getMessageRooms$messageRoomList$users<
    TRes> {
  factory CopyWith$Query$GetMessageRooms$getMessageRooms$messageRoomList$users(
    Query$GetMessageRooms$getMessageRooms$messageRoomList$users instance,
    TRes Function(Query$GetMessageRooms$getMessageRooms$messageRoomList$users)
        then,
  ) = _CopyWithImpl$Query$GetMessageRooms$getMessageRooms$messageRoomList$users;

  factory CopyWith$Query$GetMessageRooms$getMessageRooms$messageRoomList$users.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetMessageRooms$getMessageRooms$messageRoomList$users;

  TRes call({
    String? id,
    String? name,
    String? imageUrl,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetMessageRooms$getMessageRooms$messageRoomList$users<
        TRes>
    implements
        CopyWith$Query$GetMessageRooms$getMessageRooms$messageRoomList$users<
            TRes> {
  _CopyWithImpl$Query$GetMessageRooms$getMessageRooms$messageRoomList$users(
    this._instance,
    this._then,
  );

  final Query$GetMessageRooms$getMessageRooms$messageRoomList$users _instance;

  final TRes Function(
      Query$GetMessageRooms$getMessageRooms$messageRoomList$users) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? imageUrl = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetMessageRooms$getMessageRooms$messageRoomList$users(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        imageUrl:
            imageUrl == _undefined ? _instance.imageUrl : (imageUrl as String?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetMessageRooms$getMessageRooms$messageRoomList$users<
        TRes>
    implements
        CopyWith$Query$GetMessageRooms$getMessageRooms$messageRoomList$users<
            TRes> {
  _CopyWithStubImpl$Query$GetMessageRooms$getMessageRooms$messageRoomList$users(
      this._res);

  TRes _res;

  call({
    String? id,
    String? name,
    String? imageUrl,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Query$GetMessagesInProgress {
  factory Variables$Query$GetMessagesInProgress({required String userId}) =>
      Variables$Query$GetMessagesInProgress._({
        r'userId': userId,
      });

  Variables$Query$GetMessagesInProgress._(this._$data);

  factory Variables$Query$GetMessagesInProgress.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    return Variables$Query$GetMessagesInProgress._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$userId = userId;
    result$data['userId'] = l$userId;
    return result$data;
  }

  CopyWith$Variables$Query$GetMessagesInProgress<
          Variables$Query$GetMessagesInProgress>
      get copyWith => CopyWith$Variables$Query$GetMessagesInProgress(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$GetMessagesInProgress) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    return Object.hashAll([l$userId]);
  }
}

abstract class CopyWith$Variables$Query$GetMessagesInProgress<TRes> {
  factory CopyWith$Variables$Query$GetMessagesInProgress(
    Variables$Query$GetMessagesInProgress instance,
    TRes Function(Variables$Query$GetMessagesInProgress) then,
  ) = _CopyWithImpl$Variables$Query$GetMessagesInProgress;

  factory CopyWith$Variables$Query$GetMessagesInProgress.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$GetMessagesInProgress;

  TRes call({String? userId});
}

class _CopyWithImpl$Variables$Query$GetMessagesInProgress<TRes>
    implements CopyWith$Variables$Query$GetMessagesInProgress<TRes> {
  _CopyWithImpl$Variables$Query$GetMessagesInProgress(
    this._instance,
    this._then,
  );

  final Variables$Query$GetMessagesInProgress _instance;

  final TRes Function(Variables$Query$GetMessagesInProgress) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? userId = _undefined}) =>
      _then(Variables$Query$GetMessagesInProgress._({
        ..._instance._$data,
        if (userId != _undefined && userId != null)
          'userId': (userId as String),
      }));
}

class _CopyWithStubImpl$Variables$Query$GetMessagesInProgress<TRes>
    implements CopyWith$Variables$Query$GetMessagesInProgress<TRes> {
  _CopyWithStubImpl$Variables$Query$GetMessagesInProgress(this._res);

  TRes _res;

  call({String? userId}) => _res;
}

class Query$GetMessagesInProgress {
  Query$GetMessagesInProgress({
    required this.getMessagesInProgress,
    this.$__typename = 'QueryRoot',
  });

  factory Query$GetMessagesInProgress.fromJson(Map<String, dynamic> json) {
    final l$getMessagesInProgress = json['getMessagesInProgress'];
    final l$$__typename = json['__typename'];
    return Query$GetMessagesInProgress(
      getMessagesInProgress:
          Query$GetMessagesInProgress$getMessagesInProgress.fromJson(
              (l$getMessagesInProgress as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetMessagesInProgress$getMessagesInProgress getMessagesInProgress;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getMessagesInProgress = getMessagesInProgress;
    _resultData['getMessagesInProgress'] = l$getMessagesInProgress.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getMessagesInProgress = getMessagesInProgress;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$getMessagesInProgress,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetMessagesInProgress) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$getMessagesInProgress = getMessagesInProgress;
    final lOther$getMessagesInProgress = other.getMessagesInProgress;
    if (l$getMessagesInProgress != lOther$getMessagesInProgress) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMessagesInProgress
    on Query$GetMessagesInProgress {
  CopyWith$Query$GetMessagesInProgress<Query$GetMessagesInProgress>
      get copyWith => CopyWith$Query$GetMessagesInProgress(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetMessagesInProgress<TRes> {
  factory CopyWith$Query$GetMessagesInProgress(
    Query$GetMessagesInProgress instance,
    TRes Function(Query$GetMessagesInProgress) then,
  ) = _CopyWithImpl$Query$GetMessagesInProgress;

  factory CopyWith$Query$GetMessagesInProgress.stub(TRes res) =
      _CopyWithStubImpl$Query$GetMessagesInProgress;

  TRes call({
    Query$GetMessagesInProgress$getMessagesInProgress? getMessagesInProgress,
    String? $__typename,
  });
  CopyWith$Query$GetMessagesInProgress$getMessagesInProgress<TRes>
      get getMessagesInProgress;
}

class _CopyWithImpl$Query$GetMessagesInProgress<TRes>
    implements CopyWith$Query$GetMessagesInProgress<TRes> {
  _CopyWithImpl$Query$GetMessagesInProgress(
    this._instance,
    this._then,
  );

  final Query$GetMessagesInProgress _instance;

  final TRes Function(Query$GetMessagesInProgress) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getMessagesInProgress = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetMessagesInProgress(
        getMessagesInProgress:
            getMessagesInProgress == _undefined || getMessagesInProgress == null
                ? _instance.getMessagesInProgress
                : (getMessagesInProgress
                    as Query$GetMessagesInProgress$getMessagesInProgress),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetMessagesInProgress$getMessagesInProgress<TRes>
      get getMessagesInProgress {
    final local$getMessagesInProgress = _instance.getMessagesInProgress;
    return CopyWith$Query$GetMessagesInProgress$getMessagesInProgress(
        local$getMessagesInProgress, (e) => call(getMessagesInProgress: e));
  }
}

class _CopyWithStubImpl$Query$GetMessagesInProgress<TRes>
    implements CopyWith$Query$GetMessagesInProgress<TRes> {
  _CopyWithStubImpl$Query$GetMessagesInProgress(this._res);

  TRes _res;

  call({
    Query$GetMessagesInProgress$getMessagesInProgress? getMessagesInProgress,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetMessagesInProgress$getMessagesInProgress<TRes>
      get getMessagesInProgress =>
          CopyWith$Query$GetMessagesInProgress$getMessagesInProgress.stub(_res);
}

const documentNodeQueryGetMessagesInProgress = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetMessagesInProgress'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'userId')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'getMessagesInProgress'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'userId'),
            value: VariableNode(name: NameNode(value: 'userId')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'messageRoomList'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'category'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'latestMessage'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'latestSentAt'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'isRead'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: 'countOfMessageRooms'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$GetMessagesInProgress _parserFn$Query$GetMessagesInProgress(
        Map<String, dynamic> data) =>
    Query$GetMessagesInProgress.fromJson(data);
typedef OnQueryComplete$Query$GetMessagesInProgress = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$GetMessagesInProgress?,
);

class Options$Query$GetMessagesInProgress
    extends graphql.QueryOptions<Query$GetMessagesInProgress> {
  Options$Query$GetMessagesInProgress({
    String? operationName,
    required Variables$Query$GetMessagesInProgress variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetMessagesInProgress? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetMessagesInProgress? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null
                        ? null
                        : _parserFn$Query$GetMessagesInProgress(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetMessagesInProgress,
          parserFn: _parserFn$Query$GetMessagesInProgress,
        );

  final OnQueryComplete$Query$GetMessagesInProgress? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetMessagesInProgress
    extends graphql.WatchQueryOptions<Query$GetMessagesInProgress> {
  WatchOptions$Query$GetMessagesInProgress({
    String? operationName,
    required Variables$Query$GetMessagesInProgress variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetMessagesInProgress? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryGetMessagesInProgress,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetMessagesInProgress,
        );
}

class FetchMoreOptions$Query$GetMessagesInProgress
    extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetMessagesInProgress({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$GetMessagesInProgress variables,
  }) : super(
          updateQuery: updateQuery,
          variables: variables.toJson(),
          document: documentNodeQueryGetMessagesInProgress,
        );
}

extension ClientExtension$Query$GetMessagesInProgress on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetMessagesInProgress>>
      query$GetMessagesInProgress(
              Options$Query$GetMessagesInProgress options) async =>
          await this.query(options);
  graphql.ObservableQuery<Query$GetMessagesInProgress>
      watchQuery$GetMessagesInProgress(
              WatchOptions$Query$GetMessagesInProgress options) =>
          this.watchQuery(options);
  void writeQuery$GetMessagesInProgress({
    required Query$GetMessagesInProgress data,
    required Variables$Query$GetMessagesInProgress variables,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
          operation: graphql.Operation(
              document: documentNodeQueryGetMessagesInProgress),
          variables: variables.toJson(),
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetMessagesInProgress? readQuery$GetMessagesInProgress({
    required Variables$Query$GetMessagesInProgress variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation:
            graphql.Operation(document: documentNodeQueryGetMessagesInProgress),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetMessagesInProgress.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetMessagesInProgress>
    useQuery$GetMessagesInProgress(
            Options$Query$GetMessagesInProgress options) =>
        graphql_flutter.useQuery(options);
graphql.ObservableQuery<Query$GetMessagesInProgress>
    useWatchQuery$GetMessagesInProgress(
            WatchOptions$Query$GetMessagesInProgress options) =>
        graphql_flutter.useWatchQuery(options);

class Query$GetMessagesInProgress$Widget
    extends graphql_flutter.Query<Query$GetMessagesInProgress> {
  Query$GetMessagesInProgress$Widget({
    widgets.Key? key,
    required Options$Query$GetMessagesInProgress options,
    required graphql_flutter.QueryBuilder<Query$GetMessagesInProgress> builder,
  }) : super(
          key: key,
          options: options,
          builder: builder,
        );
}

class Query$GetMessagesInProgress$getMessagesInProgress {
  Query$GetMessagesInProgress$getMessagesInProgress({
    required this.messageRoomList,
    required this.countOfMessageRooms,
    this.$__typename = 'MessageRoomsByUserData',
  });

  factory Query$GetMessagesInProgress$getMessagesInProgress.fromJson(
      Map<String, dynamic> json) {
    final l$messageRoomList = json['messageRoomList'];
    final l$countOfMessageRooms = json['countOfMessageRooms'];
    final l$$__typename = json['__typename'];
    return Query$GetMessagesInProgress$getMessagesInProgress(
      messageRoomList: (l$messageRoomList as List<dynamic>)
          .map((e) =>
              Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList
                  .fromJson((e as Map<String, dynamic>)))
          .toList(),
      countOfMessageRooms: (l$countOfMessageRooms as int),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList>
      messageRoomList;

  final int countOfMessageRooms;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$messageRoomList = messageRoomList;
    _resultData['messageRoomList'] =
        l$messageRoomList.map((e) => e.toJson()).toList();
    final l$countOfMessageRooms = countOfMessageRooms;
    _resultData['countOfMessageRooms'] = l$countOfMessageRooms;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$messageRoomList = messageRoomList;
    final l$countOfMessageRooms = countOfMessageRooms;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$messageRoomList.map((v) => v)),
      l$countOfMessageRooms,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetMessagesInProgress$getMessagesInProgress) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$messageRoomList = messageRoomList;
    final lOther$messageRoomList = other.messageRoomList;
    if (l$messageRoomList.length != lOther$messageRoomList.length) {
      return false;
    }
    for (int i = 0; i < l$messageRoomList.length; i++) {
      final l$messageRoomList$entry = l$messageRoomList[i];
      final lOther$messageRoomList$entry = lOther$messageRoomList[i];
      if (l$messageRoomList$entry != lOther$messageRoomList$entry) {
        return false;
      }
    }
    final l$countOfMessageRooms = countOfMessageRooms;
    final lOther$countOfMessageRooms = other.countOfMessageRooms;
    if (l$countOfMessageRooms != lOther$countOfMessageRooms) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMessagesInProgress$getMessagesInProgress
    on Query$GetMessagesInProgress$getMessagesInProgress {
  CopyWith$Query$GetMessagesInProgress$getMessagesInProgress<
          Query$GetMessagesInProgress$getMessagesInProgress>
      get copyWith =>
          CopyWith$Query$GetMessagesInProgress$getMessagesInProgress(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetMessagesInProgress$getMessagesInProgress<
    TRes> {
  factory CopyWith$Query$GetMessagesInProgress$getMessagesInProgress(
    Query$GetMessagesInProgress$getMessagesInProgress instance,
    TRes Function(Query$GetMessagesInProgress$getMessagesInProgress) then,
  ) = _CopyWithImpl$Query$GetMessagesInProgress$getMessagesInProgress;

  factory CopyWith$Query$GetMessagesInProgress$getMessagesInProgress.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetMessagesInProgress$getMessagesInProgress;

  TRes call({
    List<Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList>?
        messageRoomList,
    int? countOfMessageRooms,
    String? $__typename,
  });
  TRes messageRoomList(
      Iterable<Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList> Function(
              Iterable<
                  CopyWith$Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList<
                      Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList>>)
          _fn);
}

class _CopyWithImpl$Query$GetMessagesInProgress$getMessagesInProgress<TRes>
    implements
        CopyWith$Query$GetMessagesInProgress$getMessagesInProgress<TRes> {
  _CopyWithImpl$Query$GetMessagesInProgress$getMessagesInProgress(
    this._instance,
    this._then,
  );

  final Query$GetMessagesInProgress$getMessagesInProgress _instance;

  final TRes Function(Query$GetMessagesInProgress$getMessagesInProgress) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? messageRoomList = _undefined,
    Object? countOfMessageRooms = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetMessagesInProgress$getMessagesInProgress(
        messageRoomList: messageRoomList == _undefined ||
                messageRoomList == null
            ? _instance.messageRoomList
            : (messageRoomList as List<
                Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList>),
        countOfMessageRooms:
            countOfMessageRooms == _undefined || countOfMessageRooms == null
                ? _instance.countOfMessageRooms
                : (countOfMessageRooms as int),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes messageRoomList(
          Iterable<Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList> Function(
                  Iterable<
                      CopyWith$Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList<
                          Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList>>)
              _fn) =>
      call(
          messageRoomList: _fn(_instance.messageRoomList.map((e) =>
              CopyWith$Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList(
                e,
                (i) => i,
              ))).toList());
}

class _CopyWithStubImpl$Query$GetMessagesInProgress$getMessagesInProgress<TRes>
    implements
        CopyWith$Query$GetMessagesInProgress$getMessagesInProgress<TRes> {
  _CopyWithStubImpl$Query$GetMessagesInProgress$getMessagesInProgress(
      this._res);

  TRes _res;

  call({
    List<Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList>?
        messageRoomList,
    int? countOfMessageRooms,
    String? $__typename,
  }) =>
      _res;

  messageRoomList(_fn) => _res;
}

class Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList {
  Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList({
    required this.id,
    this.category,
    this.latestMessage,
    this.latestSentAt,
    required this.isRead,
    this.$__typename = 'MessageRoomData',
  });

  factory Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$category = json['category'];
    final l$latestMessage = json['latestMessage'];
    final l$latestSentAt = json['latestSentAt'];
    final l$isRead = json['isRead'];
    final l$$__typename = json['__typename'];
    return Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList(
      id: (l$id as String),
      category: (l$category as String?),
      latestMessage: (l$latestMessage as String?),
      latestSentAt: (l$latestSentAt as String?),
      isRead: (l$isRead as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String? category;

  final String? latestMessage;

  final String? latestSentAt;

  final bool isRead;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$category = category;
    _resultData['category'] = l$category;
    final l$latestMessage = latestMessage;
    _resultData['latestMessage'] = l$latestMessage;
    final l$latestSentAt = latestSentAt;
    _resultData['latestSentAt'] = l$latestSentAt;
    final l$isRead = isRead;
    _resultData['isRead'] = l$isRead;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$category = category;
    final l$latestMessage = latestMessage;
    final l$latestSentAt = latestSentAt;
    final l$isRead = isRead;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$category,
      l$latestMessage,
      l$latestSentAt,
      l$isRead,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other
            is Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$category = category;
    final lOther$category = other.category;
    if (l$category != lOther$category) {
      return false;
    }
    final l$latestMessage = latestMessage;
    final lOther$latestMessage = other.latestMessage;
    if (l$latestMessage != lOther$latestMessage) {
      return false;
    }
    final l$latestSentAt = latestSentAt;
    final lOther$latestSentAt = other.latestSentAt;
    if (l$latestSentAt != lOther$latestSentAt) {
      return false;
    }
    final l$isRead = isRead;
    final lOther$isRead = other.isRead;
    if (l$isRead != lOther$isRead) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList
    on Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList {
  CopyWith$Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList<
          Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList>
      get copyWith =>
          CopyWith$Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList<
    TRes> {
  factory CopyWith$Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList(
    Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList instance,
    TRes Function(
            Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList)
        then,
  ) = _CopyWithImpl$Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList;

  factory CopyWith$Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList;

  TRes call({
    String? id,
    String? category,
    String? latestMessage,
    String? latestSentAt,
    bool? isRead,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList<
        TRes>
    implements
        CopyWith$Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList<
            TRes> {
  _CopyWithImpl$Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList(
    this._instance,
    this._then,
  );

  final Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList
      _instance;

  final TRes Function(
      Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? category = _undefined,
    Object? latestMessage = _undefined,
    Object? latestSentAt = _undefined,
    Object? isRead = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        category:
            category == _undefined ? _instance.category : (category as String?),
        latestMessage: latestMessage == _undefined
            ? _instance.latestMessage
            : (latestMessage as String?),
        latestSentAt: latestSentAt == _undefined
            ? _instance.latestSentAt
            : (latestSentAt as String?),
        isRead: isRead == _undefined || isRead == null
            ? _instance.isRead
            : (isRead as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList<
        TRes>
    implements
        CopyWith$Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList<
            TRes> {
  _CopyWithStubImpl$Query$GetMessagesInProgress$getMessagesInProgress$messageRoomList(
      this._res);

  TRes _res;

  call({
    String? id,
    String? category,
    String? latestMessage,
    String? latestSentAt,
    bool? isRead,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Query$GetMessagesByMessageRoomId {
  factory Variables$Query$GetMessagesByMessageRoomId({
    required String userId,
    required String messageRoomId,
  }) =>
      Variables$Query$GetMessagesByMessageRoomId._({
        r'userId': userId,
        r'messageRoomId': messageRoomId,
      });

  Variables$Query$GetMessagesByMessageRoomId._(this._$data);

  factory Variables$Query$GetMessagesByMessageRoomId.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    final l$messageRoomId = data['messageRoomId'];
    result$data['messageRoomId'] = (l$messageRoomId as String);
    return Variables$Query$GetMessagesByMessageRoomId._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  String get messageRoomId => (_$data['messageRoomId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$userId = userId;
    result$data['userId'] = l$userId;
    final l$messageRoomId = messageRoomId;
    result$data['messageRoomId'] = l$messageRoomId;
    return result$data;
  }

  CopyWith$Variables$Query$GetMessagesByMessageRoomId<
          Variables$Query$GetMessagesByMessageRoomId>
      get copyWith => CopyWith$Variables$Query$GetMessagesByMessageRoomId(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$GetMessagesByMessageRoomId) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$messageRoomId = messageRoomId;
    final lOther$messageRoomId = other.messageRoomId;
    if (l$messageRoomId != lOther$messageRoomId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$messageRoomId = messageRoomId;
    return Object.hashAll([
      l$userId,
      l$messageRoomId,
    ]);
  }
}

abstract class CopyWith$Variables$Query$GetMessagesByMessageRoomId<TRes> {
  factory CopyWith$Variables$Query$GetMessagesByMessageRoomId(
    Variables$Query$GetMessagesByMessageRoomId instance,
    TRes Function(Variables$Query$GetMessagesByMessageRoomId) then,
  ) = _CopyWithImpl$Variables$Query$GetMessagesByMessageRoomId;

  factory CopyWith$Variables$Query$GetMessagesByMessageRoomId.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$GetMessagesByMessageRoomId;

  TRes call({
    String? userId,
    String? messageRoomId,
  });
}

class _CopyWithImpl$Variables$Query$GetMessagesByMessageRoomId<TRes>
    implements CopyWith$Variables$Query$GetMessagesByMessageRoomId<TRes> {
  _CopyWithImpl$Variables$Query$GetMessagesByMessageRoomId(
    this._instance,
    this._then,
  );

  final Variables$Query$GetMessagesByMessageRoomId _instance;

  final TRes Function(Variables$Query$GetMessagesByMessageRoomId) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? userId = _undefined,
    Object? messageRoomId = _undefined,
  }) =>
      _then(Variables$Query$GetMessagesByMessageRoomId._({
        ..._instance._$data,
        if (userId != _undefined && userId != null)
          'userId': (userId as String),
        if (messageRoomId != _undefined && messageRoomId != null)
          'messageRoomId': (messageRoomId as String),
      }));
}

class _CopyWithStubImpl$Variables$Query$GetMessagesByMessageRoomId<TRes>
    implements CopyWith$Variables$Query$GetMessagesByMessageRoomId<TRes> {
  _CopyWithStubImpl$Variables$Query$GetMessagesByMessageRoomId(this._res);

  TRes _res;

  call({
    String? userId,
    String? messageRoomId,
  }) =>
      _res;
}

class Query$GetMessagesByMessageRoomId {
  Query$GetMessagesByMessageRoomId({
    required this.getMessagesByMessageRoomId,
    this.$__typename = 'QueryRoot',
  });

  factory Query$GetMessagesByMessageRoomId.fromJson(Map<String, dynamic> json) {
    final l$getMessagesByMessageRoomId = json['getMessagesByMessageRoomId'];
    final l$$__typename = json['__typename'];
    return Query$GetMessagesByMessageRoomId(
      getMessagesByMessageRoomId:
          Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId.fromJson(
              (l$getMessagesByMessageRoomId as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId
      getMessagesByMessageRoomId;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getMessagesByMessageRoomId = getMessagesByMessageRoomId;
    _resultData['getMessagesByMessageRoomId'] =
        l$getMessagesByMessageRoomId.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getMessagesByMessageRoomId = getMessagesByMessageRoomId;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$getMessagesByMessageRoomId,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetMessagesByMessageRoomId) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$getMessagesByMessageRoomId = getMessagesByMessageRoomId;
    final lOther$getMessagesByMessageRoomId = other.getMessagesByMessageRoomId;
    if (l$getMessagesByMessageRoomId != lOther$getMessagesByMessageRoomId) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMessagesByMessageRoomId
    on Query$GetMessagesByMessageRoomId {
  CopyWith$Query$GetMessagesByMessageRoomId<Query$GetMessagesByMessageRoomId>
      get copyWith => CopyWith$Query$GetMessagesByMessageRoomId(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetMessagesByMessageRoomId<TRes> {
  factory CopyWith$Query$GetMessagesByMessageRoomId(
    Query$GetMessagesByMessageRoomId instance,
    TRes Function(Query$GetMessagesByMessageRoomId) then,
  ) = _CopyWithImpl$Query$GetMessagesByMessageRoomId;

  factory CopyWith$Query$GetMessagesByMessageRoomId.stub(TRes res) =
      _CopyWithStubImpl$Query$GetMessagesByMessageRoomId;

  TRes call({
    Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId?
        getMessagesByMessageRoomId,
    String? $__typename,
  });
  CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId<TRes>
      get getMessagesByMessageRoomId;
}

class _CopyWithImpl$Query$GetMessagesByMessageRoomId<TRes>
    implements CopyWith$Query$GetMessagesByMessageRoomId<TRes> {
  _CopyWithImpl$Query$GetMessagesByMessageRoomId(
    this._instance,
    this._then,
  );

  final Query$GetMessagesByMessageRoomId _instance;

  final TRes Function(Query$GetMessagesByMessageRoomId) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getMessagesByMessageRoomId = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetMessagesByMessageRoomId(
        getMessagesByMessageRoomId: getMessagesByMessageRoomId == _undefined ||
                getMessagesByMessageRoomId == null
            ? _instance.getMessagesByMessageRoomId
            : (getMessagesByMessageRoomId
                as Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId<TRes>
      get getMessagesByMessageRoomId {
    final local$getMessagesByMessageRoomId =
        _instance.getMessagesByMessageRoomId;
    return CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId(
        local$getMessagesByMessageRoomId,
        (e) => call(getMessagesByMessageRoomId: e));
  }
}

class _CopyWithStubImpl$Query$GetMessagesByMessageRoomId<TRes>
    implements CopyWith$Query$GetMessagesByMessageRoomId<TRes> {
  _CopyWithStubImpl$Query$GetMessagesByMessageRoomId(this._res);

  TRes _res;

  call({
    Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId?
        getMessagesByMessageRoomId,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId<TRes>
      get getMessagesByMessageRoomId =>
          CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId
              .stub(_res);
}

const documentNodeQueryGetMessagesByMessageRoomId = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetMessagesByMessageRoomId'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'userId')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'messageRoomId')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'getMessagesByMessageRoomId'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'userId'),
            value: VariableNode(name: NameNode(value: 'userId')),
          ),
          ArgumentNode(
            name: NameNode(value: 'messageRoomId'),
            value: VariableNode(name: NameNode(value: 'messageRoomId')),
          ),
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'to'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'name'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'imageUrl'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: 'messageList'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'content'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'sentAt'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$GetMessagesByMessageRoomId _parserFn$Query$GetMessagesByMessageRoomId(
        Map<String, dynamic> data) =>
    Query$GetMessagesByMessageRoomId.fromJson(data);
typedef OnQueryComplete$Query$GetMessagesByMessageRoomId = FutureOr<void>
    Function(
  Map<String, dynamic>?,
  Query$GetMessagesByMessageRoomId?,
);

class Options$Query$GetMessagesByMessageRoomId
    extends graphql.QueryOptions<Query$GetMessagesByMessageRoomId> {
  Options$Query$GetMessagesByMessageRoomId({
    String? operationName,
    required Variables$Query$GetMessagesByMessageRoomId variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetMessagesByMessageRoomId? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetMessagesByMessageRoomId? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null
                        ? null
                        : _parserFn$Query$GetMessagesByMessageRoomId(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetMessagesByMessageRoomId,
          parserFn: _parserFn$Query$GetMessagesByMessageRoomId,
        );

  final OnQueryComplete$Query$GetMessagesByMessageRoomId? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetMessagesByMessageRoomId
    extends graphql.WatchQueryOptions<Query$GetMessagesByMessageRoomId> {
  WatchOptions$Query$GetMessagesByMessageRoomId({
    String? operationName,
    required Variables$Query$GetMessagesByMessageRoomId variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetMessagesByMessageRoomId? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryGetMessagesByMessageRoomId,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetMessagesByMessageRoomId,
        );
}

class FetchMoreOptions$Query$GetMessagesByMessageRoomId
    extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetMessagesByMessageRoomId({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$GetMessagesByMessageRoomId variables,
  }) : super(
          updateQuery: updateQuery,
          variables: variables.toJson(),
          document: documentNodeQueryGetMessagesByMessageRoomId,
        );
}

extension ClientExtension$Query$GetMessagesByMessageRoomId
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetMessagesByMessageRoomId>>
      query$GetMessagesByMessageRoomId(
              Options$Query$GetMessagesByMessageRoomId options) async =>
          await this.query(options);
  graphql.ObservableQuery<Query$GetMessagesByMessageRoomId>
      watchQuery$GetMessagesByMessageRoomId(
              WatchOptions$Query$GetMessagesByMessageRoomId options) =>
          this.watchQuery(options);
  void writeQuery$GetMessagesByMessageRoomId({
    required Query$GetMessagesByMessageRoomId data,
    required Variables$Query$GetMessagesByMessageRoomId variables,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
          operation: graphql.Operation(
              document: documentNodeQueryGetMessagesByMessageRoomId),
          variables: variables.toJson(),
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetMessagesByMessageRoomId? readQuery$GetMessagesByMessageRoomId({
    required Variables$Query$GetMessagesByMessageRoomId variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(
            document: documentNodeQueryGetMessagesByMessageRoomId),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null
        ? null
        : Query$GetMessagesByMessageRoomId.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetMessagesByMessageRoomId>
    useQuery$GetMessagesByMessageRoomId(
            Options$Query$GetMessagesByMessageRoomId options) =>
        graphql_flutter.useQuery(options);
graphql.ObservableQuery<Query$GetMessagesByMessageRoomId>
    useWatchQuery$GetMessagesByMessageRoomId(
            WatchOptions$Query$GetMessagesByMessageRoomId options) =>
        graphql_flutter.useWatchQuery(options);

class Query$GetMessagesByMessageRoomId$Widget
    extends graphql_flutter.Query<Query$GetMessagesByMessageRoomId> {
  Query$GetMessagesByMessageRoomId$Widget({
    widgets.Key? key,
    required Options$Query$GetMessagesByMessageRoomId options,
    required graphql_flutter.QueryBuilder<Query$GetMessagesByMessageRoomId>
        builder,
  }) : super(
          key: key,
          options: options,
          builder: builder,
        );
}

class Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId {
  Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId({
    required this.id,
    required this.to,
    required this.messageList,
    this.$__typename = 'MessagesByRoomIdByUserData',
  });

  factory Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$to = json['to'];
    final l$messageList = json['messageList'];
    final l$$__typename = json['__typename'];
    return Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId(
      id: (l$id as String),
      to: Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to
          .fromJson((l$to as Map<String, dynamic>)),
      messageList: (l$messageList as List<dynamic>)
          .map((e) =>
              Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList
                  .fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to to;

  final List<
          Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList>
      messageList;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$to = to;
    _resultData['to'] = l$to.toJson();
    final l$messageList = messageList;
    _resultData['messageList'] = l$messageList.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$to = to;
    final l$messageList = messageList;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$to,
      Object.hashAll(l$messageList.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other
            is Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$to = to;
    final lOther$to = other.to;
    if (l$to != lOther$to) {
      return false;
    }
    final l$messageList = messageList;
    final lOther$messageList = other.messageList;
    if (l$messageList.length != lOther$messageList.length) {
      return false;
    }
    for (int i = 0; i < l$messageList.length; i++) {
      final l$messageList$entry = l$messageList[i];
      final lOther$messageList$entry = lOther$messageList[i];
      if (l$messageList$entry != lOther$messageList$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId
    on Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId {
  CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId<
          Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId>
      get copyWith =>
          CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId<
    TRes> {
  factory CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId(
    Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId instance,
    TRes Function(Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId)
        then,
  ) = _CopyWithImpl$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId;

  factory CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId;

  TRes call({
    String? id,
    Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to? to,
    List<Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList>?
        messageList,
    String? $__typename,
  });
  CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to<TRes>
      get to;
  TRes messageList(
      Iterable<Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList> Function(
              Iterable<
                  CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList<
                      Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList>>)
          _fn);
}

class _CopyWithImpl$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId<
        TRes>
    implements
        CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId<
            TRes> {
  _CopyWithImpl$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId(
    this._instance,
    this._then,
  );

  final Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId _instance;

  final TRes Function(
      Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? to = _undefined,
    Object? messageList = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        to: to == _undefined || to == null
            ? _instance.to
            : (to
                as Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to),
        messageList: messageList == _undefined || messageList == null
            ? _instance.messageList
            : (messageList as List<
                Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to<TRes>
      get to {
    final local$to = _instance.to;
    return CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to(
        local$to, (e) => call(to: e));
  }

  TRes messageList(
          Iterable<Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList> Function(
                  Iterable<
                      CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList<
                          Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList>>)
              _fn) =>
      call(
          messageList: _fn(_instance.messageList.map((e) =>
              CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList(
                e,
                (i) => i,
              ))).toList());
}

class _CopyWithStubImpl$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId<
        TRes>
    implements
        CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId<
            TRes> {
  _CopyWithStubImpl$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId(
      this._res);

  TRes _res;

  call({
    String? id,
    Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to? to,
    List<Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList>?
        messageList,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to<TRes>
      get to =>
          CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to
              .stub(_res);

  messageList(_fn) => _res;
}

class Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to {
  Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to({
    required this.id,
    required this.name,
    this.imageUrl,
    this.$__typename = 'UserSimpleData',
  });

  factory Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$imageUrl = json['imageUrl'];
    final l$$__typename = json['__typename'];
    return Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to(
      id: (l$id as String),
      name: (l$name as String),
      imageUrl: (l$imageUrl as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String name;

  final String? imageUrl;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$imageUrl = imageUrl;
    _resultData['imageUrl'] = l$imageUrl;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$imageUrl = imageUrl;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$name,
      l$imageUrl,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other
            is Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$imageUrl = imageUrl;
    final lOther$imageUrl = other.imageUrl;
    if (l$imageUrl != lOther$imageUrl) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to
    on Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to {
  CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to<
          Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to>
      get copyWith =>
          CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to<
    TRes> {
  factory CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to(
    Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to instance,
    TRes Function(
            Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to)
        then,
  ) = _CopyWithImpl$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to;

  factory CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to;

  TRes call({
    String? id,
    String? name,
    String? imageUrl,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to<
        TRes>
    implements
        CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to<
            TRes> {
  _CopyWithImpl$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to(
    this._instance,
    this._then,
  );

  final Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to
      _instance;

  final TRes Function(
      Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? imageUrl = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        imageUrl:
            imageUrl == _undefined ? _instance.imageUrl : (imageUrl as String?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to<
        TRes>
    implements
        CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to<
            TRes> {
  _CopyWithStubImpl$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$to(
      this._res);

  TRes _res;

  call({
    String? id,
    String? name,
    String? imageUrl,
    String? $__typename,
  }) =>
      _res;
}

class Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList {
  Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList({
    required this.id,
    required this.content,
    required this.sentAt,
    this.$__typename = 'MessageTempData',
  });

  factory Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$content = json['content'];
    final l$sentAt = json['sentAt'];
    final l$$__typename = json['__typename'];
    return Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList(
      id: (l$id as String),
      content: (l$content as String),
      sentAt: (l$sentAt as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String content;

  final String sentAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$content = content;
    _resultData['content'] = l$content;
    final l$sentAt = sentAt;
    _resultData['sentAt'] = l$sentAt;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$content = content;
    final l$sentAt = sentAt;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$content,
      l$sentAt,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other
            is Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$content = content;
    final lOther$content = other.content;
    if (l$content != lOther$content) {
      return false;
    }
    final l$sentAt = sentAt;
    final lOther$sentAt = other.sentAt;
    if (l$sentAt != lOther$sentAt) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList
    on Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList {
  CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList<
          Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList>
      get copyWith =>
          CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList<
    TRes> {
  factory CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList(
    Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList
        instance,
    TRes Function(
            Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList)
        then,
  ) = _CopyWithImpl$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList;

  factory CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList;

  TRes call({
    String? id,
    String? content,
    String? sentAt,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList<
        TRes>
    implements
        CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList<
            TRes> {
  _CopyWithImpl$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList(
    this._instance,
    this._then,
  );

  final Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList
      _instance;

  final TRes Function(
          Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList)
      _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? content = _undefined,
    Object? sentAt = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(
          Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        content: content == _undefined || content == null
            ? _instance.content
            : (content as String),
        sentAt: sentAt == _undefined || sentAt == null
            ? _instance.sentAt
            : (sentAt as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList<
        TRes>
    implements
        CopyWith$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList<
            TRes> {
  _CopyWithStubImpl$Query$GetMessagesByMessageRoomId$getMessagesByMessageRoomId$messageList(
      this._res);

  TRes _res;

  call({
    String? id,
    String? content,
    String? sentAt,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Query$GetNotifications {
  factory Variables$Query$GetNotifications({
    required int count,
    required int offset,
  }) =>
      Variables$Query$GetNotifications._({
        r'count': count,
        r'offset': offset,
      });

  Variables$Query$GetNotifications._(this._$data);

  factory Variables$Query$GetNotifications.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$count = data['count'];
    result$data['count'] = (l$count as int);
    final l$offset = data['offset'];
    result$data['offset'] = (l$offset as int);
    return Variables$Query$GetNotifications._(result$data);
  }

  Map<String, dynamic> _$data;

  int get count => (_$data['count'] as int);

  int get offset => (_$data['offset'] as int);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$count = count;
    result$data['count'] = l$count;
    final l$offset = offset;
    result$data['offset'] = l$offset;
    return result$data;
  }

  CopyWith$Variables$Query$GetNotifications<Variables$Query$GetNotifications>
      get copyWith => CopyWith$Variables$Query$GetNotifications(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$GetNotifications) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$count = count;
    final lOther$count = other.count;
    if (l$count != lOther$count) {
      return false;
    }
    final l$offset = offset;
    final lOther$offset = other.offset;
    if (l$offset != lOther$offset) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$count = count;
    final l$offset = offset;
    return Object.hashAll([
      l$count,
      l$offset,
    ]);
  }
}

abstract class CopyWith$Variables$Query$GetNotifications<TRes> {
  factory CopyWith$Variables$Query$GetNotifications(
    Variables$Query$GetNotifications instance,
    TRes Function(Variables$Query$GetNotifications) then,
  ) = _CopyWithImpl$Variables$Query$GetNotifications;

  factory CopyWith$Variables$Query$GetNotifications.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$GetNotifications;

  TRes call({
    int? count,
    int? offset,
  });
}

class _CopyWithImpl$Variables$Query$GetNotifications<TRes>
    implements CopyWith$Variables$Query$GetNotifications<TRes> {
  _CopyWithImpl$Variables$Query$GetNotifications(
    this._instance,
    this._then,
  );

  final Variables$Query$GetNotifications _instance;

  final TRes Function(Variables$Query$GetNotifications) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? count = _undefined,
    Object? offset = _undefined,
  }) =>
      _then(Variables$Query$GetNotifications._({
        ..._instance._$data,
        if (count != _undefined && count != null) 'count': (count as int),
        if (offset != _undefined && offset != null) 'offset': (offset as int),
      }));
}

class _CopyWithStubImpl$Variables$Query$GetNotifications<TRes>
    implements CopyWith$Variables$Query$GetNotifications<TRes> {
  _CopyWithStubImpl$Variables$Query$GetNotifications(this._res);

  TRes _res;

  call({
    int? count,
    int? offset,
  }) =>
      _res;
}

class Query$GetNotifications {
  Query$GetNotifications({
    required this.getNotifications,
    this.$__typename = 'QueryRoot',
  });

  factory Query$GetNotifications.fromJson(Map<String, dynamic> json) {
    final l$getNotifications = json['getNotifications'];
    final l$$__typename = json['__typename'];
    return Query$GetNotifications(
      getNotifications: Query$GetNotifications$getNotifications.fromJson(
          (l$getNotifications as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetNotifications$getNotifications getNotifications;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getNotifications = getNotifications;
    _resultData['getNotifications'] = l$getNotifications.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getNotifications = getNotifications;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$getNotifications,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetNotifications) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$getNotifications = getNotifications;
    final lOther$getNotifications = other.getNotifications;
    if (l$getNotifications != lOther$getNotifications) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetNotifications on Query$GetNotifications {
  CopyWith$Query$GetNotifications<Query$GetNotifications> get copyWith =>
      CopyWith$Query$GetNotifications(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetNotifications<TRes> {
  factory CopyWith$Query$GetNotifications(
    Query$GetNotifications instance,
    TRes Function(Query$GetNotifications) then,
  ) = _CopyWithImpl$Query$GetNotifications;

  factory CopyWith$Query$GetNotifications.stub(TRes res) =
      _CopyWithStubImpl$Query$GetNotifications;

  TRes call({
    Query$GetNotifications$getNotifications? getNotifications,
    String? $__typename,
  });
  CopyWith$Query$GetNotifications$getNotifications<TRes> get getNotifications;
}

class _CopyWithImpl$Query$GetNotifications<TRes>
    implements CopyWith$Query$GetNotifications<TRes> {
  _CopyWithImpl$Query$GetNotifications(
    this._instance,
    this._then,
  );

  final Query$GetNotifications _instance;

  final TRes Function(Query$GetNotifications) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getNotifications = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetNotifications(
        getNotifications:
            getNotifications == _undefined || getNotifications == null
                ? _instance.getNotifications
                : (getNotifications as Query$GetNotifications$getNotifications),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetNotifications$getNotifications<TRes> get getNotifications {
    final local$getNotifications = _instance.getNotifications;
    return CopyWith$Query$GetNotifications$getNotifications(
        local$getNotifications, (e) => call(getNotifications: e));
  }
}

class _CopyWithStubImpl$Query$GetNotifications<TRes>
    implements CopyWith$Query$GetNotifications<TRes> {
  _CopyWithStubImpl$Query$GetNotifications(this._res);

  TRes _res;

  call({
    Query$GetNotifications$getNotifications? getNotifications,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetNotifications$getNotifications<TRes> get getNotifications =>
      CopyWith$Query$GetNotifications$getNotifications.stub(_res);
}

const documentNodeQueryGetNotifications = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetNotifications'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'count')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'offset')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'getNotifications'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'count'),
            value: VariableNode(name: NameNode(value: 'count')),
          ),
          ArgumentNode(
            name: NameNode(value: 'offset'),
            value: VariableNode(name: NameNode(value: 'offset')),
          ),
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'notifications'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'title'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'content'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'createdAt'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'updatedAt'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$GetNotifications _parserFn$Query$GetNotifications(
        Map<String, dynamic> data) =>
    Query$GetNotifications.fromJson(data);
typedef OnQueryComplete$Query$GetNotifications = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$GetNotifications?,
);

class Options$Query$GetNotifications
    extends graphql.QueryOptions<Query$GetNotifications> {
  Options$Query$GetNotifications({
    String? operationName,
    required Variables$Query$GetNotifications variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetNotifications? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetNotifications? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null
                        ? null
                        : _parserFn$Query$GetNotifications(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetNotifications,
          parserFn: _parserFn$Query$GetNotifications,
        );

  final OnQueryComplete$Query$GetNotifications? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetNotifications
    extends graphql.WatchQueryOptions<Query$GetNotifications> {
  WatchOptions$Query$GetNotifications({
    String? operationName,
    required Variables$Query$GetNotifications variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetNotifications? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryGetNotifications,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetNotifications,
        );
}

class FetchMoreOptions$Query$GetNotifications extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetNotifications({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$GetNotifications variables,
  }) : super(
          updateQuery: updateQuery,
          variables: variables.toJson(),
          document: documentNodeQueryGetNotifications,
        );
}

extension ClientExtension$Query$GetNotifications on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetNotifications>> query$GetNotifications(
          Options$Query$GetNotifications options) async =>
      await this.query(options);
  graphql.ObservableQuery<Query$GetNotifications> watchQuery$GetNotifications(
          WatchOptions$Query$GetNotifications options) =>
      this.watchQuery(options);
  void writeQuery$GetNotifications({
    required Query$GetNotifications data,
    required Variables$Query$GetNotifications variables,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
          operation:
              graphql.Operation(document: documentNodeQueryGetNotifications),
          variables: variables.toJson(),
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetNotifications? readQuery$GetNotifications({
    required Variables$Query$GetNotifications variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation:
            graphql.Operation(document: documentNodeQueryGetNotifications),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetNotifications.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetNotifications>
    useQuery$GetNotifications(Options$Query$GetNotifications options) =>
        graphql_flutter.useQuery(options);
graphql.ObservableQuery<Query$GetNotifications> useWatchQuery$GetNotifications(
        WatchOptions$Query$GetNotifications options) =>
    graphql_flutter.useWatchQuery(options);

class Query$GetNotifications$Widget
    extends graphql_flutter.Query<Query$GetNotifications> {
  Query$GetNotifications$Widget({
    widgets.Key? key,
    required Options$Query$GetNotifications options,
    required graphql_flutter.QueryBuilder<Query$GetNotifications> builder,
  }) : super(
          key: key,
          options: options,
          builder: builder,
        );
}

class Query$GetNotifications$getNotifications {
  Query$GetNotifications$getNotifications({
    required this.notifications,
    this.$__typename = 'NotificationsData',
  });

  factory Query$GetNotifications$getNotifications.fromJson(
      Map<String, dynamic> json) {
    final l$notifications = json['notifications'];
    final l$$__typename = json['__typename'];
    return Query$GetNotifications$getNotifications(
      notifications: (l$notifications as List<dynamic>)
          .map((e) =>
              Query$GetNotifications$getNotifications$notifications.fromJson(
                  (e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$GetNotifications$getNotifications$notifications>
      notifications;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$notifications = notifications;
    _resultData['notifications'] =
        l$notifications.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$notifications = notifications;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$notifications.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetNotifications$getNotifications) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$notifications = notifications;
    final lOther$notifications = other.notifications;
    if (l$notifications.length != lOther$notifications.length) {
      return false;
    }
    for (int i = 0; i < l$notifications.length; i++) {
      final l$notifications$entry = l$notifications[i];
      final lOther$notifications$entry = lOther$notifications[i];
      if (l$notifications$entry != lOther$notifications$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetNotifications$getNotifications
    on Query$GetNotifications$getNotifications {
  CopyWith$Query$GetNotifications$getNotifications<
          Query$GetNotifications$getNotifications>
      get copyWith => CopyWith$Query$GetNotifications$getNotifications(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetNotifications$getNotifications<TRes> {
  factory CopyWith$Query$GetNotifications$getNotifications(
    Query$GetNotifications$getNotifications instance,
    TRes Function(Query$GetNotifications$getNotifications) then,
  ) = _CopyWithImpl$Query$GetNotifications$getNotifications;

  factory CopyWith$Query$GetNotifications$getNotifications.stub(TRes res) =
      _CopyWithStubImpl$Query$GetNotifications$getNotifications;

  TRes call({
    List<Query$GetNotifications$getNotifications$notifications>? notifications,
    String? $__typename,
  });
  TRes notifications(
      Iterable<Query$GetNotifications$getNotifications$notifications> Function(
              Iterable<
                  CopyWith$Query$GetNotifications$getNotifications$notifications<
                      Query$GetNotifications$getNotifications$notifications>>)
          _fn);
}

class _CopyWithImpl$Query$GetNotifications$getNotifications<TRes>
    implements CopyWith$Query$GetNotifications$getNotifications<TRes> {
  _CopyWithImpl$Query$GetNotifications$getNotifications(
    this._instance,
    this._then,
  );

  final Query$GetNotifications$getNotifications _instance;

  final TRes Function(Query$GetNotifications$getNotifications) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? notifications = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetNotifications$getNotifications(
        notifications: notifications == _undefined || notifications == null
            ? _instance.notifications
            : (notifications
                as List<Query$GetNotifications$getNotifications$notifications>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes notifications(
          Iterable<Query$GetNotifications$getNotifications$notifications> Function(
                  Iterable<
                      CopyWith$Query$GetNotifications$getNotifications$notifications<
                          Query$GetNotifications$getNotifications$notifications>>)
              _fn) =>
      call(
          notifications: _fn(_instance.notifications.map((e) =>
              CopyWith$Query$GetNotifications$getNotifications$notifications(
                e,
                (i) => i,
              ))).toList());
}

class _CopyWithStubImpl$Query$GetNotifications$getNotifications<TRes>
    implements CopyWith$Query$GetNotifications$getNotifications<TRes> {
  _CopyWithStubImpl$Query$GetNotifications$getNotifications(this._res);

  TRes _res;

  call({
    List<Query$GetNotifications$getNotifications$notifications>? notifications,
    String? $__typename,
  }) =>
      _res;

  notifications(_fn) => _res;
}

class Query$GetNotifications$getNotifications$notifications {
  Query$GetNotifications$getNotifications$notifications({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    this.$__typename = 'NotificationData',
  });

  factory Query$GetNotifications$getNotifications$notifications.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$title = json['title'];
    final l$content = json['content'];
    final l$createdAt = json['createdAt'];
    final l$updatedAt = json['updatedAt'];
    final l$$__typename = json['__typename'];
    return Query$GetNotifications$getNotifications$notifications(
      id: (l$id as String),
      title: (l$title as String),
      content: (l$content as String),
      createdAt: (l$createdAt as String),
      updatedAt: (l$updatedAt as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String title;

  final String content;

  final String createdAt;

  final String updatedAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$title = title;
    _resultData['title'] = l$title;
    final l$content = content;
    _resultData['content'] = l$content;
    final l$createdAt = createdAt;
    _resultData['createdAt'] = l$createdAt;
    final l$updatedAt = updatedAt;
    _resultData['updatedAt'] = l$updatedAt;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$title = title;
    final l$content = content;
    final l$createdAt = createdAt;
    final l$updatedAt = updatedAt;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$title,
      l$content,
      l$createdAt,
      l$updatedAt,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetNotifications$getNotifications$notifications) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$content = content;
    final lOther$content = other.content;
    if (l$content != lOther$content) {
      return false;
    }
    final l$createdAt = createdAt;
    final lOther$createdAt = other.createdAt;
    if (l$createdAt != lOther$createdAt) {
      return false;
    }
    final l$updatedAt = updatedAt;
    final lOther$updatedAt = other.updatedAt;
    if (l$updatedAt != lOther$updatedAt) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetNotifications$getNotifications$notifications
    on Query$GetNotifications$getNotifications$notifications {
  CopyWith$Query$GetNotifications$getNotifications$notifications<
          Query$GetNotifications$getNotifications$notifications>
      get copyWith =>
          CopyWith$Query$GetNotifications$getNotifications$notifications(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetNotifications$getNotifications$notifications<
    TRes> {
  factory CopyWith$Query$GetNotifications$getNotifications$notifications(
    Query$GetNotifications$getNotifications$notifications instance,
    TRes Function(Query$GetNotifications$getNotifications$notifications) then,
  ) = _CopyWithImpl$Query$GetNotifications$getNotifications$notifications;

  factory CopyWith$Query$GetNotifications$getNotifications$notifications.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetNotifications$getNotifications$notifications;

  TRes call({
    String? id,
    String? title,
    String? content,
    String? createdAt,
    String? updatedAt,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetNotifications$getNotifications$notifications<TRes>
    implements
        CopyWith$Query$GetNotifications$getNotifications$notifications<TRes> {
  _CopyWithImpl$Query$GetNotifications$getNotifications$notifications(
    this._instance,
    this._then,
  );

  final Query$GetNotifications$getNotifications$notifications _instance;

  final TRes Function(Query$GetNotifications$getNotifications$notifications)
      _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? title = _undefined,
    Object? content = _undefined,
    Object? createdAt = _undefined,
    Object? updatedAt = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetNotifications$getNotifications$notifications(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        title: title == _undefined || title == null
            ? _instance.title
            : (title as String),
        content: content == _undefined || content == null
            ? _instance.content
            : (content as String),
        createdAt: createdAt == _undefined || createdAt == null
            ? _instance.createdAt
            : (createdAt as String),
        updatedAt: updatedAt == _undefined || updatedAt == null
            ? _instance.updatedAt
            : (updatedAt as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetNotifications$getNotifications$notifications<
        TRes>
    implements
        CopyWith$Query$GetNotifications$getNotifications$notifications<TRes> {
  _CopyWithStubImpl$Query$GetNotifications$getNotifications$notifications(
      this._res);

  TRes _res;

  call({
    String? id,
    String? title,
    String? content,
    String? createdAt,
    String? updatedAt,
    String? $__typename,
  }) =>
      _res;
}

class Query$GetAllNotifications {
  Query$GetAllNotifications({
    required this.getAllNotifications,
    this.$__typename = 'QueryRoot',
  });

  factory Query$GetAllNotifications.fromJson(Map<String, dynamic> json) {
    final l$getAllNotifications = json['getAllNotifications'];
    final l$$__typename = json['__typename'];
    return Query$GetAllNotifications(
      getAllNotifications:
          Query$GetAllNotifications$getAllNotifications.fromJson(
              (l$getAllNotifications as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetAllNotifications$getAllNotifications getAllNotifications;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getAllNotifications = getAllNotifications;
    _resultData['getAllNotifications'] = l$getAllNotifications.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getAllNotifications = getAllNotifications;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$getAllNotifications,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetAllNotifications) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$getAllNotifications = getAllNotifications;
    final lOther$getAllNotifications = other.getAllNotifications;
    if (l$getAllNotifications != lOther$getAllNotifications) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetAllNotifications
    on Query$GetAllNotifications {
  CopyWith$Query$GetAllNotifications<Query$GetAllNotifications> get copyWith =>
      CopyWith$Query$GetAllNotifications(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetAllNotifications<TRes> {
  factory CopyWith$Query$GetAllNotifications(
    Query$GetAllNotifications instance,
    TRes Function(Query$GetAllNotifications) then,
  ) = _CopyWithImpl$Query$GetAllNotifications;

  factory CopyWith$Query$GetAllNotifications.stub(TRes res) =
      _CopyWithStubImpl$Query$GetAllNotifications;

  TRes call({
    Query$GetAllNotifications$getAllNotifications? getAllNotifications,
    String? $__typename,
  });
  CopyWith$Query$GetAllNotifications$getAllNotifications<TRes>
      get getAllNotifications;
}

class _CopyWithImpl$Query$GetAllNotifications<TRes>
    implements CopyWith$Query$GetAllNotifications<TRes> {
  _CopyWithImpl$Query$GetAllNotifications(
    this._instance,
    this._then,
  );

  final Query$GetAllNotifications _instance;

  final TRes Function(Query$GetAllNotifications) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getAllNotifications = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetAllNotifications(
        getAllNotifications:
            getAllNotifications == _undefined || getAllNotifications == null
                ? _instance.getAllNotifications
                : (getAllNotifications
                    as Query$GetAllNotifications$getAllNotifications),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetAllNotifications$getAllNotifications<TRes>
      get getAllNotifications {
    final local$getAllNotifications = _instance.getAllNotifications;
    return CopyWith$Query$GetAllNotifications$getAllNotifications(
        local$getAllNotifications, (e) => call(getAllNotifications: e));
  }
}

class _CopyWithStubImpl$Query$GetAllNotifications<TRes>
    implements CopyWith$Query$GetAllNotifications<TRes> {
  _CopyWithStubImpl$Query$GetAllNotifications(this._res);

  TRes _res;

  call({
    Query$GetAllNotifications$getAllNotifications? getAllNotifications,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetAllNotifications$getAllNotifications<TRes>
      get getAllNotifications =>
          CopyWith$Query$GetAllNotifications$getAllNotifications.stub(_res);
}

const documentNodeQueryGetAllNotifications = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetAllNotifications'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'getAllNotifications'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'notifications'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'title'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'content'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'createdAt'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'updatedAt'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$GetAllNotifications _parserFn$Query$GetAllNotifications(
        Map<String, dynamic> data) =>
    Query$GetAllNotifications.fromJson(data);
typedef OnQueryComplete$Query$GetAllNotifications = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$GetAllNotifications?,
);

class Options$Query$GetAllNotifications
    extends graphql.QueryOptions<Query$GetAllNotifications> {
  Options$Query$GetAllNotifications({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetAllNotifications? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetAllNotifications? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null
                        ? null
                        : _parserFn$Query$GetAllNotifications(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetAllNotifications,
          parserFn: _parserFn$Query$GetAllNotifications,
        );

  final OnQueryComplete$Query$GetAllNotifications? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetAllNotifications
    extends graphql.WatchQueryOptions<Query$GetAllNotifications> {
  WatchOptions$Query$GetAllNotifications({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetAllNotifications? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryGetAllNotifications,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetAllNotifications,
        );
}

class FetchMoreOptions$Query$GetAllNotifications
    extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetAllNotifications(
      {required graphql.UpdateQuery updateQuery})
      : super(
          updateQuery: updateQuery,
          document: documentNodeQueryGetAllNotifications,
        );
}

extension ClientExtension$Query$GetAllNotifications on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetAllNotifications>>
      query$GetAllNotifications(
              [Options$Query$GetAllNotifications? options]) async =>
          await this.query(options ?? Options$Query$GetAllNotifications());
  graphql.ObservableQuery<Query$GetAllNotifications>
      watchQuery$GetAllNotifications(
              [WatchOptions$Query$GetAllNotifications? options]) =>
          this.watchQuery(options ?? WatchOptions$Query$GetAllNotifications());
  void writeQuery$GetAllNotifications({
    required Query$GetAllNotifications data,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
            operation: graphql.Operation(
                document: documentNodeQueryGetAllNotifications)),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetAllNotifications? readQuery$GetAllNotifications(
      {bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
          operation: graphql.Operation(
              document: documentNodeQueryGetAllNotifications)),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetAllNotifications.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetAllNotifications>
    useQuery$GetAllNotifications(
            [Options$Query$GetAllNotifications? options]) =>
        graphql_flutter
            .useQuery(options ?? Options$Query$GetAllNotifications());
graphql.ObservableQuery<Query$GetAllNotifications>
    useWatchQuery$GetAllNotifications(
            [WatchOptions$Query$GetAllNotifications? options]) =>
        graphql_flutter
            .useWatchQuery(options ?? WatchOptions$Query$GetAllNotifications());

class Query$GetAllNotifications$Widget
    extends graphql_flutter.Query<Query$GetAllNotifications> {
  Query$GetAllNotifications$Widget({
    widgets.Key? key,
    Options$Query$GetAllNotifications? options,
    required graphql_flutter.QueryBuilder<Query$GetAllNotifications> builder,
  }) : super(
          key: key,
          options: options ?? Options$Query$GetAllNotifications(),
          builder: builder,
        );
}

class Query$GetAllNotifications$getAllNotifications {
  Query$GetAllNotifications$getAllNotifications({
    required this.notifications,
    this.$__typename = 'NotificationsData',
  });

  factory Query$GetAllNotifications$getAllNotifications.fromJson(
      Map<String, dynamic> json) {
    final l$notifications = json['notifications'];
    final l$$__typename = json['__typename'];
    return Query$GetAllNotifications$getAllNotifications(
      notifications: (l$notifications as List<dynamic>)
          .map((e) =>
              Query$GetAllNotifications$getAllNotifications$notifications
                  .fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$GetAllNotifications$getAllNotifications$notifications>
      notifications;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$notifications = notifications;
    _resultData['notifications'] =
        l$notifications.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$notifications = notifications;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$notifications.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetAllNotifications$getAllNotifications) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$notifications = notifications;
    final lOther$notifications = other.notifications;
    if (l$notifications.length != lOther$notifications.length) {
      return false;
    }
    for (int i = 0; i < l$notifications.length; i++) {
      final l$notifications$entry = l$notifications[i];
      final lOther$notifications$entry = lOther$notifications[i];
      if (l$notifications$entry != lOther$notifications$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetAllNotifications$getAllNotifications
    on Query$GetAllNotifications$getAllNotifications {
  CopyWith$Query$GetAllNotifications$getAllNotifications<
          Query$GetAllNotifications$getAllNotifications>
      get copyWith => CopyWith$Query$GetAllNotifications$getAllNotifications(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetAllNotifications$getAllNotifications<TRes> {
  factory CopyWith$Query$GetAllNotifications$getAllNotifications(
    Query$GetAllNotifications$getAllNotifications instance,
    TRes Function(Query$GetAllNotifications$getAllNotifications) then,
  ) = _CopyWithImpl$Query$GetAllNotifications$getAllNotifications;

  factory CopyWith$Query$GetAllNotifications$getAllNotifications.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetAllNotifications$getAllNotifications;

  TRes call({
    List<Query$GetAllNotifications$getAllNotifications$notifications>?
        notifications,
    String? $__typename,
  });
  TRes notifications(
      Iterable<Query$GetAllNotifications$getAllNotifications$notifications> Function(
              Iterable<
                  CopyWith$Query$GetAllNotifications$getAllNotifications$notifications<
                      Query$GetAllNotifications$getAllNotifications$notifications>>)
          _fn);
}

class _CopyWithImpl$Query$GetAllNotifications$getAllNotifications<TRes>
    implements CopyWith$Query$GetAllNotifications$getAllNotifications<TRes> {
  _CopyWithImpl$Query$GetAllNotifications$getAllNotifications(
    this._instance,
    this._then,
  );

  final Query$GetAllNotifications$getAllNotifications _instance;

  final TRes Function(Query$GetAllNotifications$getAllNotifications) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? notifications = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetAllNotifications$getAllNotifications(
        notifications: notifications == _undefined || notifications == null
            ? _instance.notifications
            : (notifications as List<
                Query$GetAllNotifications$getAllNotifications$notifications>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes notifications(
          Iterable<Query$GetAllNotifications$getAllNotifications$notifications> Function(
                  Iterable<
                      CopyWith$Query$GetAllNotifications$getAllNotifications$notifications<
                          Query$GetAllNotifications$getAllNotifications$notifications>>)
              _fn) =>
      call(
          notifications: _fn(_instance.notifications.map((e) =>
              CopyWith$Query$GetAllNotifications$getAllNotifications$notifications(
                e,
                (i) => i,
              ))).toList());
}

class _CopyWithStubImpl$Query$GetAllNotifications$getAllNotifications<TRes>
    implements CopyWith$Query$GetAllNotifications$getAllNotifications<TRes> {
  _CopyWithStubImpl$Query$GetAllNotifications$getAllNotifications(this._res);

  TRes _res;

  call({
    List<Query$GetAllNotifications$getAllNotifications$notifications>?
        notifications,
    String? $__typename,
  }) =>
      _res;

  notifications(_fn) => _res;
}

class Query$GetAllNotifications$getAllNotifications$notifications {
  Query$GetAllNotifications$getAllNotifications$notifications({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    this.$__typename = 'NotificationData',
  });

  factory Query$GetAllNotifications$getAllNotifications$notifications.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$title = json['title'];
    final l$content = json['content'];
    final l$createdAt = json['createdAt'];
    final l$updatedAt = json['updatedAt'];
    final l$$__typename = json['__typename'];
    return Query$GetAllNotifications$getAllNotifications$notifications(
      id: (l$id as String),
      title: (l$title as String),
      content: (l$content as String),
      createdAt: (l$createdAt as String),
      updatedAt: (l$updatedAt as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String title;

  final String content;

  final String createdAt;

  final String updatedAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$title = title;
    _resultData['title'] = l$title;
    final l$content = content;
    _resultData['content'] = l$content;
    final l$createdAt = createdAt;
    _resultData['createdAt'] = l$createdAt;
    final l$updatedAt = updatedAt;
    _resultData['updatedAt'] = l$updatedAt;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$title = title;
    final l$content = content;
    final l$createdAt = createdAt;
    final l$updatedAt = updatedAt;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$title,
      l$content,
      l$createdAt,
      l$updatedAt,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other
            is Query$GetAllNotifications$getAllNotifications$notifications) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$content = content;
    final lOther$content = other.content;
    if (l$content != lOther$content) {
      return false;
    }
    final l$createdAt = createdAt;
    final lOther$createdAt = other.createdAt;
    if (l$createdAt != lOther$createdAt) {
      return false;
    }
    final l$updatedAt = updatedAt;
    final lOther$updatedAt = other.updatedAt;
    if (l$updatedAt != lOther$updatedAt) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetAllNotifications$getAllNotifications$notifications
    on Query$GetAllNotifications$getAllNotifications$notifications {
  CopyWith$Query$GetAllNotifications$getAllNotifications$notifications<
          Query$GetAllNotifications$getAllNotifications$notifications>
      get copyWith =>
          CopyWith$Query$GetAllNotifications$getAllNotifications$notifications(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetAllNotifications$getAllNotifications$notifications<
    TRes> {
  factory CopyWith$Query$GetAllNotifications$getAllNotifications$notifications(
    Query$GetAllNotifications$getAllNotifications$notifications instance,
    TRes Function(Query$GetAllNotifications$getAllNotifications$notifications)
        then,
  ) = _CopyWithImpl$Query$GetAllNotifications$getAllNotifications$notifications;

  factory CopyWith$Query$GetAllNotifications$getAllNotifications$notifications.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetAllNotifications$getAllNotifications$notifications;

  TRes call({
    String? id,
    String? title,
    String? content,
    String? createdAt,
    String? updatedAt,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetAllNotifications$getAllNotifications$notifications<
        TRes>
    implements
        CopyWith$Query$GetAllNotifications$getAllNotifications$notifications<
            TRes> {
  _CopyWithImpl$Query$GetAllNotifications$getAllNotifications$notifications(
    this._instance,
    this._then,
  );

  final Query$GetAllNotifications$getAllNotifications$notifications _instance;

  final TRes Function(
      Query$GetAllNotifications$getAllNotifications$notifications) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? title = _undefined,
    Object? content = _undefined,
    Object? createdAt = _undefined,
    Object? updatedAt = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetAllNotifications$getAllNotifications$notifications(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        title: title == _undefined || title == null
            ? _instance.title
            : (title as String),
        content: content == _undefined || content == null
            ? _instance.content
            : (content as String),
        createdAt: createdAt == _undefined || createdAt == null
            ? _instance.createdAt
            : (createdAt as String),
        updatedAt: updatedAt == _undefined || updatedAt == null
            ? _instance.updatedAt
            : (updatedAt as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetAllNotifications$getAllNotifications$notifications<
        TRes>
    implements
        CopyWith$Query$GetAllNotifications$getAllNotifications$notifications<
            TRes> {
  _CopyWithStubImpl$Query$GetAllNotifications$getAllNotifications$notifications(
      this._res);

  TRes _res;

  call({
    String? id,
    String? title,
    String? content,
    String? createdAt,
    String? updatedAt,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Query$GetUserData {
  factory Variables$Query$GetUserData({required String userId}) =>
      Variables$Query$GetUserData._({
        r'userId': userId,
      });

  Variables$Query$GetUserData._(this._$data);

  factory Variables$Query$GetUserData.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    return Variables$Query$GetUserData._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$userId = userId;
    result$data['userId'] = l$userId;
    return result$data;
  }

  CopyWith$Variables$Query$GetUserData<Variables$Query$GetUserData>
      get copyWith => CopyWith$Variables$Query$GetUserData(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$GetUserData) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    return Object.hashAll([l$userId]);
  }
}

abstract class CopyWith$Variables$Query$GetUserData<TRes> {
  factory CopyWith$Variables$Query$GetUserData(
    Variables$Query$GetUserData instance,
    TRes Function(Variables$Query$GetUserData) then,
  ) = _CopyWithImpl$Variables$Query$GetUserData;

  factory CopyWith$Variables$Query$GetUserData.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$GetUserData;

  TRes call({String? userId});
}

class _CopyWithImpl$Variables$Query$GetUserData<TRes>
    implements CopyWith$Variables$Query$GetUserData<TRes> {
  _CopyWithImpl$Variables$Query$GetUserData(
    this._instance,
    this._then,
  );

  final Variables$Query$GetUserData _instance;

  final TRes Function(Variables$Query$GetUserData) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? userId = _undefined}) =>
      _then(Variables$Query$GetUserData._({
        ..._instance._$data,
        if (userId != _undefined && userId != null)
          'userId': (userId as String),
      }));
}

class _CopyWithStubImpl$Variables$Query$GetUserData<TRes>
    implements CopyWith$Variables$Query$GetUserData<TRes> {
  _CopyWithStubImpl$Variables$Query$GetUserData(this._res);

  TRes _res;

  call({String? userId}) => _res;
}

class Query$GetUserData {
  Query$GetUserData({
    required this.getUserData,
    this.$__typename = 'QueryRoot',
  });

  factory Query$GetUserData.fromJson(Map<String, dynamic> json) {
    final l$getUserData = json['getUserData'];
    final l$$__typename = json['__typename'];
    return Query$GetUserData(
      getUserData: Query$GetUserData$getUserData.fromJson(
          (l$getUserData as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetUserData$getUserData getUserData;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getUserData = getUserData;
    _resultData['getUserData'] = l$getUserData.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getUserData = getUserData;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$getUserData,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetUserData) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$getUserData = getUserData;
    final lOther$getUserData = other.getUserData;
    if (l$getUserData != lOther$getUserData) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetUserData on Query$GetUserData {
  CopyWith$Query$GetUserData<Query$GetUserData> get copyWith =>
      CopyWith$Query$GetUserData(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetUserData<TRes> {
  factory CopyWith$Query$GetUserData(
    Query$GetUserData instance,
    TRes Function(Query$GetUserData) then,
  ) = _CopyWithImpl$Query$GetUserData;

  factory CopyWith$Query$GetUserData.stub(TRes res) =
      _CopyWithStubImpl$Query$GetUserData;

  TRes call({
    Query$GetUserData$getUserData? getUserData,
    String? $__typename,
  });
  CopyWith$Query$GetUserData$getUserData<TRes> get getUserData;
}

class _CopyWithImpl$Query$GetUserData<TRes>
    implements CopyWith$Query$GetUserData<TRes> {
  _CopyWithImpl$Query$GetUserData(
    this._instance,
    this._then,
  );

  final Query$GetUserData _instance;

  final TRes Function(Query$GetUserData) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getUserData = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetUserData(
        getUserData: getUserData == _undefined || getUserData == null
            ? _instance.getUserData
            : (getUserData as Query$GetUserData$getUserData),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetUserData$getUserData<TRes> get getUserData {
    final local$getUserData = _instance.getUserData;
    return CopyWith$Query$GetUserData$getUserData(
        local$getUserData, (e) => call(getUserData: e));
  }
}

class _CopyWithStubImpl$Query$GetUserData<TRes>
    implements CopyWith$Query$GetUserData<TRes> {
  _CopyWithStubImpl$Query$GetUserData(this._res);

  TRes _res;

  call({
    Query$GetUserData$getUserData? getUserData,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetUserData$getUserData<TRes> get getUserData =>
      CopyWith$Query$GetUserData$getUserData.stub(_res);
}

const documentNodeQueryGetUserData = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetUserData'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'userId')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'getUserData'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'userId'),
            value: VariableNode(name: NameNode(value: 'userId')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'email'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'name'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'imageUrl'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'fspBalance'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'credentialBalance'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'role'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'primaryRole'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'belongsToArtists'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'name'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'imageUrl'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'fsp'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'status'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'isAdmin'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: 'primaryArtist'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'name'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'imageUrl'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'fsp'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'status'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'isAdmin'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$GetUserData _parserFn$Query$GetUserData(Map<String, dynamic> data) =>
    Query$GetUserData.fromJson(data);
typedef OnQueryComplete$Query$GetUserData = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$GetUserData?,
);

class Options$Query$GetUserData
    extends graphql.QueryOptions<Query$GetUserData> {
  Options$Query$GetUserData({
    String? operationName,
    required Variables$Query$GetUserData variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetUserData? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetUserData? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null ? null : _parserFn$Query$GetUserData(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetUserData,
          parserFn: _parserFn$Query$GetUserData,
        );

  final OnQueryComplete$Query$GetUserData? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetUserData
    extends graphql.WatchQueryOptions<Query$GetUserData> {
  WatchOptions$Query$GetUserData({
    String? operationName,
    required Variables$Query$GetUserData variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetUserData? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryGetUserData,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetUserData,
        );
}

class FetchMoreOptions$Query$GetUserData extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetUserData({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$GetUserData variables,
  }) : super(
          updateQuery: updateQuery,
          variables: variables.toJson(),
          document: documentNodeQueryGetUserData,
        );
}

extension ClientExtension$Query$GetUserData on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetUserData>> query$GetUserData(
          Options$Query$GetUserData options) async =>
      await this.query(options);
  graphql.ObservableQuery<Query$GetUserData> watchQuery$GetUserData(
          WatchOptions$Query$GetUserData options) =>
      this.watchQuery(options);
  void writeQuery$GetUserData({
    required Query$GetUserData data,
    required Variables$Query$GetUserData variables,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
          operation: graphql.Operation(document: documentNodeQueryGetUserData),
          variables: variables.toJson(),
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetUserData? readQuery$GetUserData({
    required Variables$Query$GetUserData variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryGetUserData),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetUserData.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetUserData> useQuery$GetUserData(
        Options$Query$GetUserData options) =>
    graphql_flutter.useQuery(options);
graphql.ObservableQuery<Query$GetUserData> useWatchQuery$GetUserData(
        WatchOptions$Query$GetUserData options) =>
    graphql_flutter.useWatchQuery(options);

class Query$GetUserData$Widget
    extends graphql_flutter.Query<Query$GetUserData> {
  Query$GetUserData$Widget({
    widgets.Key? key,
    required Options$Query$GetUserData options,
    required graphql_flutter.QueryBuilder<Query$GetUserData> builder,
  }) : super(
          key: key,
          options: options,
          builder: builder,
        );
}

class Query$GetUserData$getUserData {
  Query$GetUserData$getUserData({
    required this.id,
    required this.email,
    required this.name,
    this.imageUrl,
    required this.fspBalance,
    required this.credentialBalance,
    required this.role,
    required this.primaryRole,
    required this.belongsToArtists,
    this.primaryArtist,
    this.$__typename = 'UserDetailData',
  });

  factory Query$GetUserData$getUserData.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$email = json['email'];
    final l$name = json['name'];
    final l$imageUrl = json['imageUrl'];
    final l$fspBalance = json['fspBalance'];
    final l$credentialBalance = json['credentialBalance'];
    final l$role = json['role'];
    final l$primaryRole = json['primaryRole'];
    final l$belongsToArtists = json['belongsToArtists'];
    final l$primaryArtist = json['primaryArtist'];
    final l$$__typename = json['__typename'];
    return Query$GetUserData$getUserData(
      id: (l$id as String),
      email: (l$email as String),
      name: (l$name as String),
      imageUrl: (l$imageUrl as String?),
      fspBalance: (l$fspBalance as int),
      credentialBalance: (l$credentialBalance as int),
      role: (l$role as String),
      primaryRole: (l$primaryRole as String),
      belongsToArtists: (l$belongsToArtists as List<dynamic>)
          .map((e) => Query$GetUserData$getUserData$belongsToArtists.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      primaryArtist: l$primaryArtist == null
          ? null
          : Query$GetUserData$getUserData$primaryArtist.fromJson(
              (l$primaryArtist as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String email;

  final String name;

  final String? imageUrl;

  final int fspBalance;

  final int credentialBalance;

  final String role;

  final String primaryRole;

  final List<Query$GetUserData$getUserData$belongsToArtists> belongsToArtists;

  final Query$GetUserData$getUserData$primaryArtist? primaryArtist;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$email = email;
    _resultData['email'] = l$email;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$imageUrl = imageUrl;
    _resultData['imageUrl'] = l$imageUrl;
    final l$fspBalance = fspBalance;
    _resultData['fspBalance'] = l$fspBalance;
    final l$credentialBalance = credentialBalance;
    _resultData['credentialBalance'] = l$credentialBalance;
    final l$role = role;
    _resultData['role'] = l$role;
    final l$primaryRole = primaryRole;
    _resultData['primaryRole'] = l$primaryRole;
    final l$belongsToArtists = belongsToArtists;
    _resultData['belongsToArtists'] =
        l$belongsToArtists.map((e) => e.toJson()).toList();
    final l$primaryArtist = primaryArtist;
    _resultData['primaryArtist'] = l$primaryArtist?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$email = email;
    final l$name = name;
    final l$imageUrl = imageUrl;
    final l$fspBalance = fspBalance;
    final l$credentialBalance = credentialBalance;
    final l$role = role;
    final l$primaryRole = primaryRole;
    final l$belongsToArtists = belongsToArtists;
    final l$primaryArtist = primaryArtist;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$email,
      l$name,
      l$imageUrl,
      l$fspBalance,
      l$credentialBalance,
      l$role,
      l$primaryRole,
      Object.hashAll(l$belongsToArtists.map((v) => v)),
      l$primaryArtist,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetUserData$getUserData) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (l$email != lOther$email) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$imageUrl = imageUrl;
    final lOther$imageUrl = other.imageUrl;
    if (l$imageUrl != lOther$imageUrl) {
      return false;
    }
    final l$fspBalance = fspBalance;
    final lOther$fspBalance = other.fspBalance;
    if (l$fspBalance != lOther$fspBalance) {
      return false;
    }
    final l$credentialBalance = credentialBalance;
    final lOther$credentialBalance = other.credentialBalance;
    if (l$credentialBalance != lOther$credentialBalance) {
      return false;
    }
    final l$role = role;
    final lOther$role = other.role;
    if (l$role != lOther$role) {
      return false;
    }
    final l$primaryRole = primaryRole;
    final lOther$primaryRole = other.primaryRole;
    if (l$primaryRole != lOther$primaryRole) {
      return false;
    }
    final l$belongsToArtists = belongsToArtists;
    final lOther$belongsToArtists = other.belongsToArtists;
    if (l$belongsToArtists.length != lOther$belongsToArtists.length) {
      return false;
    }
    for (int i = 0; i < l$belongsToArtists.length; i++) {
      final l$belongsToArtists$entry = l$belongsToArtists[i];
      final lOther$belongsToArtists$entry = lOther$belongsToArtists[i];
      if (l$belongsToArtists$entry != lOther$belongsToArtists$entry) {
        return false;
      }
    }
    final l$primaryArtist = primaryArtist;
    final lOther$primaryArtist = other.primaryArtist;
    if (l$primaryArtist != lOther$primaryArtist) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetUserData$getUserData
    on Query$GetUserData$getUserData {
  CopyWith$Query$GetUserData$getUserData<Query$GetUserData$getUserData>
      get copyWith => CopyWith$Query$GetUserData$getUserData(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetUserData$getUserData<TRes> {
  factory CopyWith$Query$GetUserData$getUserData(
    Query$GetUserData$getUserData instance,
    TRes Function(Query$GetUserData$getUserData) then,
  ) = _CopyWithImpl$Query$GetUserData$getUserData;

  factory CopyWith$Query$GetUserData$getUserData.stub(TRes res) =
      _CopyWithStubImpl$Query$GetUserData$getUserData;

  TRes call({
    String? id,
    String? email,
    String? name,
    String? imageUrl,
    int? fspBalance,
    int? credentialBalance,
    String? role,
    String? primaryRole,
    List<Query$GetUserData$getUserData$belongsToArtists>? belongsToArtists,
    Query$GetUserData$getUserData$primaryArtist? primaryArtist,
    String? $__typename,
  });
  TRes belongsToArtists(
      Iterable<Query$GetUserData$getUserData$belongsToArtists> Function(
              Iterable<
                  CopyWith$Query$GetUserData$getUserData$belongsToArtists<
                      Query$GetUserData$getUserData$belongsToArtists>>)
          _fn);
  CopyWith$Query$GetUserData$getUserData$primaryArtist<TRes> get primaryArtist;
}

class _CopyWithImpl$Query$GetUserData$getUserData<TRes>
    implements CopyWith$Query$GetUserData$getUserData<TRes> {
  _CopyWithImpl$Query$GetUserData$getUserData(
    this._instance,
    this._then,
  );

  final Query$GetUserData$getUserData _instance;

  final TRes Function(Query$GetUserData$getUserData) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? email = _undefined,
    Object? name = _undefined,
    Object? imageUrl = _undefined,
    Object? fspBalance = _undefined,
    Object? credentialBalance = _undefined,
    Object? role = _undefined,
    Object? primaryRole = _undefined,
    Object? belongsToArtists = _undefined,
    Object? primaryArtist = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetUserData$getUserData(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        email: email == _undefined || email == null
            ? _instance.email
            : (email as String),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        imageUrl:
            imageUrl == _undefined ? _instance.imageUrl : (imageUrl as String?),
        fspBalance: fspBalance == _undefined || fspBalance == null
            ? _instance.fspBalance
            : (fspBalance as int),
        credentialBalance:
            credentialBalance == _undefined || credentialBalance == null
                ? _instance.credentialBalance
                : (credentialBalance as int),
        role: role == _undefined || role == null
            ? _instance.role
            : (role as String),
        primaryRole: primaryRole == _undefined || primaryRole == null
            ? _instance.primaryRole
            : (primaryRole as String),
        belongsToArtists:
            belongsToArtists == _undefined || belongsToArtists == null
                ? _instance.belongsToArtists
                : (belongsToArtists
                    as List<Query$GetUserData$getUserData$belongsToArtists>),
        primaryArtist: primaryArtist == _undefined
            ? _instance.primaryArtist
            : (primaryArtist as Query$GetUserData$getUserData$primaryArtist?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes belongsToArtists(
          Iterable<Query$GetUserData$getUserData$belongsToArtists> Function(
                  Iterable<
                      CopyWith$Query$GetUserData$getUserData$belongsToArtists<
                          Query$GetUserData$getUserData$belongsToArtists>>)
              _fn) =>
      call(
          belongsToArtists: _fn(_instance.belongsToArtists.map(
              (e) => CopyWith$Query$GetUserData$getUserData$belongsToArtists(
                    e,
                    (i) => i,
                  ))).toList());

  CopyWith$Query$GetUserData$getUserData$primaryArtist<TRes> get primaryArtist {
    final local$primaryArtist = _instance.primaryArtist;
    return local$primaryArtist == null
        ? CopyWith$Query$GetUserData$getUserData$primaryArtist.stub(
            _then(_instance))
        : CopyWith$Query$GetUserData$getUserData$primaryArtist(
            local$primaryArtist, (e) => call(primaryArtist: e));
  }
}

class _CopyWithStubImpl$Query$GetUserData$getUserData<TRes>
    implements CopyWith$Query$GetUserData$getUserData<TRes> {
  _CopyWithStubImpl$Query$GetUserData$getUserData(this._res);

  TRes _res;

  call({
    String? id,
    String? email,
    String? name,
    String? imageUrl,
    int? fspBalance,
    int? credentialBalance,
    String? role,
    String? primaryRole,
    List<Query$GetUserData$getUserData$belongsToArtists>? belongsToArtists,
    Query$GetUserData$getUserData$primaryArtist? primaryArtist,
    String? $__typename,
  }) =>
      _res;

  belongsToArtists(_fn) => _res;

  CopyWith$Query$GetUserData$getUserData$primaryArtist<TRes>
      get primaryArtist =>
          CopyWith$Query$GetUserData$getUserData$primaryArtist.stub(_res);
}

class Query$GetUserData$getUserData$belongsToArtists {
  Query$GetUserData$getUserData$belongsToArtists({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.fsp,
    required this.status,
    required this.isAdmin,
    this.$__typename = 'ArtistByUserData',
  });

  factory Query$GetUserData$getUserData$belongsToArtists.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$imageUrl = json['imageUrl'];
    final l$fsp = json['fsp'];
    final l$status = json['status'];
    final l$isAdmin = json['isAdmin'];
    final l$$__typename = json['__typename'];
    return Query$GetUserData$getUserData$belongsToArtists(
      id: (l$id as String),
      name: (l$name as String),
      imageUrl: (l$imageUrl as String?),
      fsp: (l$fsp as int),
      status: (l$status as String),
      isAdmin: (l$isAdmin as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String name;

  final String? imageUrl;

  final int fsp;

  final String status;

  final bool isAdmin;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$imageUrl = imageUrl;
    _resultData['imageUrl'] = l$imageUrl;
    final l$fsp = fsp;
    _resultData['fsp'] = l$fsp;
    final l$status = status;
    _resultData['status'] = l$status;
    final l$isAdmin = isAdmin;
    _resultData['isAdmin'] = l$isAdmin;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$imageUrl = imageUrl;
    final l$fsp = fsp;
    final l$status = status;
    final l$isAdmin = isAdmin;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$name,
      l$imageUrl,
      l$fsp,
      l$status,
      l$isAdmin,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetUserData$getUserData$belongsToArtists) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$imageUrl = imageUrl;
    final lOther$imageUrl = other.imageUrl;
    if (l$imageUrl != lOther$imageUrl) {
      return false;
    }
    final l$fsp = fsp;
    final lOther$fsp = other.fsp;
    if (l$fsp != lOther$fsp) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    final l$isAdmin = isAdmin;
    final lOther$isAdmin = other.isAdmin;
    if (l$isAdmin != lOther$isAdmin) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetUserData$getUserData$belongsToArtists
    on Query$GetUserData$getUserData$belongsToArtists {
  CopyWith$Query$GetUserData$getUserData$belongsToArtists<
          Query$GetUserData$getUserData$belongsToArtists>
      get copyWith => CopyWith$Query$GetUserData$getUserData$belongsToArtists(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetUserData$getUserData$belongsToArtists<TRes> {
  factory CopyWith$Query$GetUserData$getUserData$belongsToArtists(
    Query$GetUserData$getUserData$belongsToArtists instance,
    TRes Function(Query$GetUserData$getUserData$belongsToArtists) then,
  ) = _CopyWithImpl$Query$GetUserData$getUserData$belongsToArtists;

  factory CopyWith$Query$GetUserData$getUserData$belongsToArtists.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetUserData$getUserData$belongsToArtists;

  TRes call({
    String? id,
    String? name,
    String? imageUrl,
    int? fsp,
    String? status,
    bool? isAdmin,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetUserData$getUserData$belongsToArtists<TRes>
    implements CopyWith$Query$GetUserData$getUserData$belongsToArtists<TRes> {
  _CopyWithImpl$Query$GetUserData$getUserData$belongsToArtists(
    this._instance,
    this._then,
  );

  final Query$GetUserData$getUserData$belongsToArtists _instance;

  final TRes Function(Query$GetUserData$getUserData$belongsToArtists) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? imageUrl = _undefined,
    Object? fsp = _undefined,
    Object? status = _undefined,
    Object? isAdmin = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetUserData$getUserData$belongsToArtists(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        imageUrl:
            imageUrl == _undefined ? _instance.imageUrl : (imageUrl as String?),
        fsp: fsp == _undefined || fsp == null ? _instance.fsp : (fsp as int),
        status: status == _undefined || status == null
            ? _instance.status
            : (status as String),
        isAdmin: isAdmin == _undefined || isAdmin == null
            ? _instance.isAdmin
            : (isAdmin as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetUserData$getUserData$belongsToArtists<TRes>
    implements CopyWith$Query$GetUserData$getUserData$belongsToArtists<TRes> {
  _CopyWithStubImpl$Query$GetUserData$getUserData$belongsToArtists(this._res);

  TRes _res;

  call({
    String? id,
    String? name,
    String? imageUrl,
    int? fsp,
    String? status,
    bool? isAdmin,
    String? $__typename,
  }) =>
      _res;
}

class Query$GetUserData$getUserData$primaryArtist {
  Query$GetUserData$getUserData$primaryArtist({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.fsp,
    required this.status,
    required this.isAdmin,
    this.$__typename = 'ArtistByUserData',
  });

  factory Query$GetUserData$getUserData$primaryArtist.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$imageUrl = json['imageUrl'];
    final l$fsp = json['fsp'];
    final l$status = json['status'];
    final l$isAdmin = json['isAdmin'];
    final l$$__typename = json['__typename'];
    return Query$GetUserData$getUserData$primaryArtist(
      id: (l$id as String),
      name: (l$name as String),
      imageUrl: (l$imageUrl as String?),
      fsp: (l$fsp as int),
      status: (l$status as String),
      isAdmin: (l$isAdmin as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String name;

  final String? imageUrl;

  final int fsp;

  final String status;

  final bool isAdmin;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$imageUrl = imageUrl;
    _resultData['imageUrl'] = l$imageUrl;
    final l$fsp = fsp;
    _resultData['fsp'] = l$fsp;
    final l$status = status;
    _resultData['status'] = l$status;
    final l$isAdmin = isAdmin;
    _resultData['isAdmin'] = l$isAdmin;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$imageUrl = imageUrl;
    final l$fsp = fsp;
    final l$status = status;
    final l$isAdmin = isAdmin;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$name,
      l$imageUrl,
      l$fsp,
      l$status,
      l$isAdmin,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetUserData$getUserData$primaryArtist) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$imageUrl = imageUrl;
    final lOther$imageUrl = other.imageUrl;
    if (l$imageUrl != lOther$imageUrl) {
      return false;
    }
    final l$fsp = fsp;
    final lOther$fsp = other.fsp;
    if (l$fsp != lOther$fsp) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    final l$isAdmin = isAdmin;
    final lOther$isAdmin = other.isAdmin;
    if (l$isAdmin != lOther$isAdmin) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetUserData$getUserData$primaryArtist
    on Query$GetUserData$getUserData$primaryArtist {
  CopyWith$Query$GetUserData$getUserData$primaryArtist<
          Query$GetUserData$getUserData$primaryArtist>
      get copyWith => CopyWith$Query$GetUserData$getUserData$primaryArtist(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetUserData$getUserData$primaryArtist<TRes> {
  factory CopyWith$Query$GetUserData$getUserData$primaryArtist(
    Query$GetUserData$getUserData$primaryArtist instance,
    TRes Function(Query$GetUserData$getUserData$primaryArtist) then,
  ) = _CopyWithImpl$Query$GetUserData$getUserData$primaryArtist;

  factory CopyWith$Query$GetUserData$getUserData$primaryArtist.stub(TRes res) =
      _CopyWithStubImpl$Query$GetUserData$getUserData$primaryArtist;

  TRes call({
    String? id,
    String? name,
    String? imageUrl,
    int? fsp,
    String? status,
    bool? isAdmin,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetUserData$getUserData$primaryArtist<TRes>
    implements CopyWith$Query$GetUserData$getUserData$primaryArtist<TRes> {
  _CopyWithImpl$Query$GetUserData$getUserData$primaryArtist(
    this._instance,
    this._then,
  );

  final Query$GetUserData$getUserData$primaryArtist _instance;

  final TRes Function(Query$GetUserData$getUserData$primaryArtist) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? imageUrl = _undefined,
    Object? fsp = _undefined,
    Object? status = _undefined,
    Object? isAdmin = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetUserData$getUserData$primaryArtist(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        imageUrl:
            imageUrl == _undefined ? _instance.imageUrl : (imageUrl as String?),
        fsp: fsp == _undefined || fsp == null ? _instance.fsp : (fsp as int),
        status: status == _undefined || status == null
            ? _instance.status
            : (status as String),
        isAdmin: isAdmin == _undefined || isAdmin == null
            ? _instance.isAdmin
            : (isAdmin as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetUserData$getUserData$primaryArtist<TRes>
    implements CopyWith$Query$GetUserData$getUserData$primaryArtist<TRes> {
  _CopyWithStubImpl$Query$GetUserData$getUserData$primaryArtist(this._res);

  TRes _res;

  call({
    String? id,
    String? name,
    String? imageUrl,
    int? fsp,
    String? status,
    bool? isAdmin,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Query$GetBelongedArtists {
  factory Variables$Query$GetBelongedArtists({required String userId}) =>
      Variables$Query$GetBelongedArtists._({
        r'userId': userId,
      });

  Variables$Query$GetBelongedArtists._(this._$data);

  factory Variables$Query$GetBelongedArtists.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    return Variables$Query$GetBelongedArtists._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$userId = userId;
    result$data['userId'] = l$userId;
    return result$data;
  }

  CopyWith$Variables$Query$GetBelongedArtists<
          Variables$Query$GetBelongedArtists>
      get copyWith => CopyWith$Variables$Query$GetBelongedArtists(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$GetBelongedArtists) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    return Object.hashAll([l$userId]);
  }
}

abstract class CopyWith$Variables$Query$GetBelongedArtists<TRes> {
  factory CopyWith$Variables$Query$GetBelongedArtists(
    Variables$Query$GetBelongedArtists instance,
    TRes Function(Variables$Query$GetBelongedArtists) then,
  ) = _CopyWithImpl$Variables$Query$GetBelongedArtists;

  factory CopyWith$Variables$Query$GetBelongedArtists.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$GetBelongedArtists;

  TRes call({String? userId});
}

class _CopyWithImpl$Variables$Query$GetBelongedArtists<TRes>
    implements CopyWith$Variables$Query$GetBelongedArtists<TRes> {
  _CopyWithImpl$Variables$Query$GetBelongedArtists(
    this._instance,
    this._then,
  );

  final Variables$Query$GetBelongedArtists _instance;

  final TRes Function(Variables$Query$GetBelongedArtists) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? userId = _undefined}) =>
      _then(Variables$Query$GetBelongedArtists._({
        ..._instance._$data,
        if (userId != _undefined && userId != null)
          'userId': (userId as String),
      }));
}

class _CopyWithStubImpl$Variables$Query$GetBelongedArtists<TRes>
    implements CopyWith$Variables$Query$GetBelongedArtists<TRes> {
  _CopyWithStubImpl$Variables$Query$GetBelongedArtists(this._res);

  TRes _res;

  call({String? userId}) => _res;
}

class Query$GetBelongedArtists {
  Query$GetBelongedArtists({
    required this.getBelongedArtists,
    this.$__typename = 'QueryRoot',
  });

  factory Query$GetBelongedArtists.fromJson(Map<String, dynamic> json) {
    final l$getBelongedArtists = json['getBelongedArtists'];
    final l$$__typename = json['__typename'];
    return Query$GetBelongedArtists(
      getBelongedArtists: Query$GetBelongedArtists$getBelongedArtists.fromJson(
          (l$getBelongedArtists as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetBelongedArtists$getBelongedArtists getBelongedArtists;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getBelongedArtists = getBelongedArtists;
    _resultData['getBelongedArtists'] = l$getBelongedArtists.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getBelongedArtists = getBelongedArtists;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$getBelongedArtists,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetBelongedArtists) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$getBelongedArtists = getBelongedArtists;
    final lOther$getBelongedArtists = other.getBelongedArtists;
    if (l$getBelongedArtists != lOther$getBelongedArtists) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetBelongedArtists
    on Query$GetBelongedArtists {
  CopyWith$Query$GetBelongedArtists<Query$GetBelongedArtists> get copyWith =>
      CopyWith$Query$GetBelongedArtists(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetBelongedArtists<TRes> {
  factory CopyWith$Query$GetBelongedArtists(
    Query$GetBelongedArtists instance,
    TRes Function(Query$GetBelongedArtists) then,
  ) = _CopyWithImpl$Query$GetBelongedArtists;

  factory CopyWith$Query$GetBelongedArtists.stub(TRes res) =
      _CopyWithStubImpl$Query$GetBelongedArtists;

  TRes call({
    Query$GetBelongedArtists$getBelongedArtists? getBelongedArtists,
    String? $__typename,
  });
  CopyWith$Query$GetBelongedArtists$getBelongedArtists<TRes>
      get getBelongedArtists;
}

class _CopyWithImpl$Query$GetBelongedArtists<TRes>
    implements CopyWith$Query$GetBelongedArtists<TRes> {
  _CopyWithImpl$Query$GetBelongedArtists(
    this._instance,
    this._then,
  );

  final Query$GetBelongedArtists _instance;

  final TRes Function(Query$GetBelongedArtists) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getBelongedArtists = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetBelongedArtists(
        getBelongedArtists:
            getBelongedArtists == _undefined || getBelongedArtists == null
                ? _instance.getBelongedArtists
                : (getBelongedArtists
                    as Query$GetBelongedArtists$getBelongedArtists),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetBelongedArtists$getBelongedArtists<TRes>
      get getBelongedArtists {
    final local$getBelongedArtists = _instance.getBelongedArtists;
    return CopyWith$Query$GetBelongedArtists$getBelongedArtists(
        local$getBelongedArtists, (e) => call(getBelongedArtists: e));
  }
}

class _CopyWithStubImpl$Query$GetBelongedArtists<TRes>
    implements CopyWith$Query$GetBelongedArtists<TRes> {
  _CopyWithStubImpl$Query$GetBelongedArtists(this._res);

  TRes _res;

  call({
    Query$GetBelongedArtists$getBelongedArtists? getBelongedArtists,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetBelongedArtists$getBelongedArtists<TRes>
      get getBelongedArtists =>
          CopyWith$Query$GetBelongedArtists$getBelongedArtists.stub(_res);
}

const documentNodeQueryGetBelongedArtists = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetBelongedArtists'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'userId')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'getBelongedArtists'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'userId'),
            value: VariableNode(name: NameNode(value: 'userId')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'artistList'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'name'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'imageUrl'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'fsp'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'status'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'isAdmin'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$GetBelongedArtists _parserFn$Query$GetBelongedArtists(
        Map<String, dynamic> data) =>
    Query$GetBelongedArtists.fromJson(data);
typedef OnQueryComplete$Query$GetBelongedArtists = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$GetBelongedArtists?,
);

class Options$Query$GetBelongedArtists
    extends graphql.QueryOptions<Query$GetBelongedArtists> {
  Options$Query$GetBelongedArtists({
    String? operationName,
    required Variables$Query$GetBelongedArtists variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetBelongedArtists? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetBelongedArtists? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null
                        ? null
                        : _parserFn$Query$GetBelongedArtists(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetBelongedArtists,
          parserFn: _parserFn$Query$GetBelongedArtists,
        );

  final OnQueryComplete$Query$GetBelongedArtists? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetBelongedArtists
    extends graphql.WatchQueryOptions<Query$GetBelongedArtists> {
  WatchOptions$Query$GetBelongedArtists({
    String? operationName,
    required Variables$Query$GetBelongedArtists variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetBelongedArtists? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryGetBelongedArtists,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetBelongedArtists,
        );
}

class FetchMoreOptions$Query$GetBelongedArtists
    extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetBelongedArtists({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$GetBelongedArtists variables,
  }) : super(
          updateQuery: updateQuery,
          variables: variables.toJson(),
          document: documentNodeQueryGetBelongedArtists,
        );
}

extension ClientExtension$Query$GetBelongedArtists on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetBelongedArtists>>
      query$GetBelongedArtists(
              Options$Query$GetBelongedArtists options) async =>
          await this.query(options);
  graphql.ObservableQuery<Query$GetBelongedArtists>
      watchQuery$GetBelongedArtists(
              WatchOptions$Query$GetBelongedArtists options) =>
          this.watchQuery(options);
  void writeQuery$GetBelongedArtists({
    required Query$GetBelongedArtists data,
    required Variables$Query$GetBelongedArtists variables,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
          operation:
              graphql.Operation(document: documentNodeQueryGetBelongedArtists),
          variables: variables.toJson(),
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetBelongedArtists? readQuery$GetBelongedArtists({
    required Variables$Query$GetBelongedArtists variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation:
            graphql.Operation(document: documentNodeQueryGetBelongedArtists),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetBelongedArtists.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetBelongedArtists>
    useQuery$GetBelongedArtists(Options$Query$GetBelongedArtists options) =>
        graphql_flutter.useQuery(options);
graphql.ObservableQuery<Query$GetBelongedArtists>
    useWatchQuery$GetBelongedArtists(
            WatchOptions$Query$GetBelongedArtists options) =>
        graphql_flutter.useWatchQuery(options);

class Query$GetBelongedArtists$Widget
    extends graphql_flutter.Query<Query$GetBelongedArtists> {
  Query$GetBelongedArtists$Widget({
    widgets.Key? key,
    required Options$Query$GetBelongedArtists options,
    required graphql_flutter.QueryBuilder<Query$GetBelongedArtists> builder,
  }) : super(
          key: key,
          options: options,
          builder: builder,
        );
}

class Query$GetBelongedArtists$getBelongedArtists {
  Query$GetBelongedArtists$getBelongedArtists({
    required this.artistList,
    this.$__typename = 'ArtistByUserDataList',
  });

  factory Query$GetBelongedArtists$getBelongedArtists.fromJson(
      Map<String, dynamic> json) {
    final l$artistList = json['artistList'];
    final l$$__typename = json['__typename'];
    return Query$GetBelongedArtists$getBelongedArtists(
      artistList: (l$artistList as List<dynamic>)
          .map((e) =>
              Query$GetBelongedArtists$getBelongedArtists$artistList.fromJson(
                  (e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$GetBelongedArtists$getBelongedArtists$artistList> artistList;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$artistList = artistList;
    _resultData['artistList'] = l$artistList.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$artistList = artistList;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$artistList.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetBelongedArtists$getBelongedArtists) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$artistList = artistList;
    final lOther$artistList = other.artistList;
    if (l$artistList.length != lOther$artistList.length) {
      return false;
    }
    for (int i = 0; i < l$artistList.length; i++) {
      final l$artistList$entry = l$artistList[i];
      final lOther$artistList$entry = lOther$artistList[i];
      if (l$artistList$entry != lOther$artistList$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetBelongedArtists$getBelongedArtists
    on Query$GetBelongedArtists$getBelongedArtists {
  CopyWith$Query$GetBelongedArtists$getBelongedArtists<
          Query$GetBelongedArtists$getBelongedArtists>
      get copyWith => CopyWith$Query$GetBelongedArtists$getBelongedArtists(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetBelongedArtists$getBelongedArtists<TRes> {
  factory CopyWith$Query$GetBelongedArtists$getBelongedArtists(
    Query$GetBelongedArtists$getBelongedArtists instance,
    TRes Function(Query$GetBelongedArtists$getBelongedArtists) then,
  ) = _CopyWithImpl$Query$GetBelongedArtists$getBelongedArtists;

  factory CopyWith$Query$GetBelongedArtists$getBelongedArtists.stub(TRes res) =
      _CopyWithStubImpl$Query$GetBelongedArtists$getBelongedArtists;

  TRes call({
    List<Query$GetBelongedArtists$getBelongedArtists$artistList>? artistList,
    String? $__typename,
  });
  TRes artistList(
      Iterable<Query$GetBelongedArtists$getBelongedArtists$artistList> Function(
              Iterable<
                  CopyWith$Query$GetBelongedArtists$getBelongedArtists$artistList<
                      Query$GetBelongedArtists$getBelongedArtists$artistList>>)
          _fn);
}

class _CopyWithImpl$Query$GetBelongedArtists$getBelongedArtists<TRes>
    implements CopyWith$Query$GetBelongedArtists$getBelongedArtists<TRes> {
  _CopyWithImpl$Query$GetBelongedArtists$getBelongedArtists(
    this._instance,
    this._then,
  );

  final Query$GetBelongedArtists$getBelongedArtists _instance;

  final TRes Function(Query$GetBelongedArtists$getBelongedArtists) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? artistList = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetBelongedArtists$getBelongedArtists(
        artistList: artistList == _undefined || artistList == null
            ? _instance.artistList
            : (artistList as List<
                Query$GetBelongedArtists$getBelongedArtists$artistList>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes artistList(
          Iterable<Query$GetBelongedArtists$getBelongedArtists$artistList> Function(
                  Iterable<
                      CopyWith$Query$GetBelongedArtists$getBelongedArtists$artistList<
                          Query$GetBelongedArtists$getBelongedArtists$artistList>>)
              _fn) =>
      call(
          artistList: _fn(_instance.artistList.map((e) =>
              CopyWith$Query$GetBelongedArtists$getBelongedArtists$artistList(
                e,
                (i) => i,
              ))).toList());
}

class _CopyWithStubImpl$Query$GetBelongedArtists$getBelongedArtists<TRes>
    implements CopyWith$Query$GetBelongedArtists$getBelongedArtists<TRes> {
  _CopyWithStubImpl$Query$GetBelongedArtists$getBelongedArtists(this._res);

  TRes _res;

  call({
    List<Query$GetBelongedArtists$getBelongedArtists$artistList>? artistList,
    String? $__typename,
  }) =>
      _res;

  artistList(_fn) => _res;
}

class Query$GetBelongedArtists$getBelongedArtists$artistList {
  Query$GetBelongedArtists$getBelongedArtists$artistList({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.fsp,
    required this.status,
    required this.isAdmin,
    this.$__typename = 'ArtistByUserData',
  });

  factory Query$GetBelongedArtists$getBelongedArtists$artistList.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$imageUrl = json['imageUrl'];
    final l$fsp = json['fsp'];
    final l$status = json['status'];
    final l$isAdmin = json['isAdmin'];
    final l$$__typename = json['__typename'];
    return Query$GetBelongedArtists$getBelongedArtists$artistList(
      id: (l$id as String),
      name: (l$name as String),
      imageUrl: (l$imageUrl as String?),
      fsp: (l$fsp as int),
      status: (l$status as String),
      isAdmin: (l$isAdmin as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String name;

  final String? imageUrl;

  final int fsp;

  final String status;

  final bool isAdmin;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$imageUrl = imageUrl;
    _resultData['imageUrl'] = l$imageUrl;
    final l$fsp = fsp;
    _resultData['fsp'] = l$fsp;
    final l$status = status;
    _resultData['status'] = l$status;
    final l$isAdmin = isAdmin;
    _resultData['isAdmin'] = l$isAdmin;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$imageUrl = imageUrl;
    final l$fsp = fsp;
    final l$status = status;
    final l$isAdmin = isAdmin;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$name,
      l$imageUrl,
      l$fsp,
      l$status,
      l$isAdmin,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetBelongedArtists$getBelongedArtists$artistList) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$imageUrl = imageUrl;
    final lOther$imageUrl = other.imageUrl;
    if (l$imageUrl != lOther$imageUrl) {
      return false;
    }
    final l$fsp = fsp;
    final lOther$fsp = other.fsp;
    if (l$fsp != lOther$fsp) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    final l$isAdmin = isAdmin;
    final lOther$isAdmin = other.isAdmin;
    if (l$isAdmin != lOther$isAdmin) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetBelongedArtists$getBelongedArtists$artistList
    on Query$GetBelongedArtists$getBelongedArtists$artistList {
  CopyWith$Query$GetBelongedArtists$getBelongedArtists$artistList<
          Query$GetBelongedArtists$getBelongedArtists$artistList>
      get copyWith =>
          CopyWith$Query$GetBelongedArtists$getBelongedArtists$artistList(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetBelongedArtists$getBelongedArtists$artistList<
    TRes> {
  factory CopyWith$Query$GetBelongedArtists$getBelongedArtists$artistList(
    Query$GetBelongedArtists$getBelongedArtists$artistList instance,
    TRes Function(Query$GetBelongedArtists$getBelongedArtists$artistList) then,
  ) = _CopyWithImpl$Query$GetBelongedArtists$getBelongedArtists$artistList;

  factory CopyWith$Query$GetBelongedArtists$getBelongedArtists$artistList.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetBelongedArtists$getBelongedArtists$artistList;

  TRes call({
    String? id,
    String? name,
    String? imageUrl,
    int? fsp,
    String? status,
    bool? isAdmin,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetBelongedArtists$getBelongedArtists$artistList<TRes>
    implements
        CopyWith$Query$GetBelongedArtists$getBelongedArtists$artistList<TRes> {
  _CopyWithImpl$Query$GetBelongedArtists$getBelongedArtists$artistList(
    this._instance,
    this._then,
  );

  final Query$GetBelongedArtists$getBelongedArtists$artistList _instance;

  final TRes Function(Query$GetBelongedArtists$getBelongedArtists$artistList)
      _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? imageUrl = _undefined,
    Object? fsp = _undefined,
    Object? status = _undefined,
    Object? isAdmin = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetBelongedArtists$getBelongedArtists$artistList(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        imageUrl:
            imageUrl == _undefined ? _instance.imageUrl : (imageUrl as String?),
        fsp: fsp == _undefined || fsp == null ? _instance.fsp : (fsp as int),
        status: status == _undefined || status == null
            ? _instance.status
            : (status as String),
        isAdmin: isAdmin == _undefined || isAdmin == null
            ? _instance.isAdmin
            : (isAdmin as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetBelongedArtists$getBelongedArtists$artistList<
        TRes>
    implements
        CopyWith$Query$GetBelongedArtists$getBelongedArtists$artistList<TRes> {
  _CopyWithStubImpl$Query$GetBelongedArtists$getBelongedArtists$artistList(
      this._res);

  TRes _res;

  call({
    String? id,
    String? name,
    String? imageUrl,
    int? fsp,
    String? status,
    bool? isAdmin,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Query$GetUserDetailProfile {
  factory Variables$Query$GetUserDetailProfile({required String userId}) =>
      Variables$Query$GetUserDetailProfile._({
        r'userId': userId,
      });

  Variables$Query$GetUserDetailProfile._(this._$data);

  factory Variables$Query$GetUserDetailProfile.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    return Variables$Query$GetUserDetailProfile._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$userId = userId;
    result$data['userId'] = l$userId;
    return result$data;
  }

  CopyWith$Variables$Query$GetUserDetailProfile<
          Variables$Query$GetUserDetailProfile>
      get copyWith => CopyWith$Variables$Query$GetUserDetailProfile(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$GetUserDetailProfile) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    return Object.hashAll([l$userId]);
  }
}

abstract class CopyWith$Variables$Query$GetUserDetailProfile<TRes> {
  factory CopyWith$Variables$Query$GetUserDetailProfile(
    Variables$Query$GetUserDetailProfile instance,
    TRes Function(Variables$Query$GetUserDetailProfile) then,
  ) = _CopyWithImpl$Variables$Query$GetUserDetailProfile;

  factory CopyWith$Variables$Query$GetUserDetailProfile.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$GetUserDetailProfile;

  TRes call({String? userId});
}

class _CopyWithImpl$Variables$Query$GetUserDetailProfile<TRes>
    implements CopyWith$Variables$Query$GetUserDetailProfile<TRes> {
  _CopyWithImpl$Variables$Query$GetUserDetailProfile(
    this._instance,
    this._then,
  );

  final Variables$Query$GetUserDetailProfile _instance;

  final TRes Function(Variables$Query$GetUserDetailProfile) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? userId = _undefined}) =>
      _then(Variables$Query$GetUserDetailProfile._({
        ..._instance._$data,
        if (userId != _undefined && userId != null)
          'userId': (userId as String),
      }));
}

class _CopyWithStubImpl$Variables$Query$GetUserDetailProfile<TRes>
    implements CopyWith$Variables$Query$GetUserDetailProfile<TRes> {
  _CopyWithStubImpl$Variables$Query$GetUserDetailProfile(this._res);

  TRes _res;

  call({String? userId}) => _res;
}

class Query$GetUserDetailProfile {
  Query$GetUserDetailProfile({
    required this.getUserDetailProfile,
    this.$__typename = 'QueryRoot',
  });

  factory Query$GetUserDetailProfile.fromJson(Map<String, dynamic> json) {
    final l$getUserDetailProfile = json['getUserDetailProfile'];
    final l$$__typename = json['__typename'];
    return Query$GetUserDetailProfile(
      getUserDetailProfile:
          Query$GetUserDetailProfile$getUserDetailProfile.fromJson(
              (l$getUserDetailProfile as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetUserDetailProfile$getUserDetailProfile getUserDetailProfile;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getUserDetailProfile = getUserDetailProfile;
    _resultData['getUserDetailProfile'] = l$getUserDetailProfile.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getUserDetailProfile = getUserDetailProfile;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$getUserDetailProfile,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetUserDetailProfile) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$getUserDetailProfile = getUserDetailProfile;
    final lOther$getUserDetailProfile = other.getUserDetailProfile;
    if (l$getUserDetailProfile != lOther$getUserDetailProfile) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetUserDetailProfile
    on Query$GetUserDetailProfile {
  CopyWith$Query$GetUserDetailProfile<Query$GetUserDetailProfile>
      get copyWith => CopyWith$Query$GetUserDetailProfile(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetUserDetailProfile<TRes> {
  factory CopyWith$Query$GetUserDetailProfile(
    Query$GetUserDetailProfile instance,
    TRes Function(Query$GetUserDetailProfile) then,
  ) = _CopyWithImpl$Query$GetUserDetailProfile;

  factory CopyWith$Query$GetUserDetailProfile.stub(TRes res) =
      _CopyWithStubImpl$Query$GetUserDetailProfile;

  TRes call({
    Query$GetUserDetailProfile$getUserDetailProfile? getUserDetailProfile,
    String? $__typename,
  });
  CopyWith$Query$GetUserDetailProfile$getUserDetailProfile<TRes>
      get getUserDetailProfile;
}

class _CopyWithImpl$Query$GetUserDetailProfile<TRes>
    implements CopyWith$Query$GetUserDetailProfile<TRes> {
  _CopyWithImpl$Query$GetUserDetailProfile(
    this._instance,
    this._then,
  );

  final Query$GetUserDetailProfile _instance;

  final TRes Function(Query$GetUserDetailProfile) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getUserDetailProfile = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetUserDetailProfile(
        getUserDetailProfile:
            getUserDetailProfile == _undefined || getUserDetailProfile == null
                ? _instance.getUserDetailProfile
                : (getUserDetailProfile
                    as Query$GetUserDetailProfile$getUserDetailProfile),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetUserDetailProfile$getUserDetailProfile<TRes>
      get getUserDetailProfile {
    final local$getUserDetailProfile = _instance.getUserDetailProfile;
    return CopyWith$Query$GetUserDetailProfile$getUserDetailProfile(
        local$getUserDetailProfile, (e) => call(getUserDetailProfile: e));
  }
}

class _CopyWithStubImpl$Query$GetUserDetailProfile<TRes>
    implements CopyWith$Query$GetUserDetailProfile<TRes> {
  _CopyWithStubImpl$Query$GetUserDetailProfile(this._res);

  TRes _res;

  call({
    Query$GetUserDetailProfile$getUserDetailProfile? getUserDetailProfile,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetUserDetailProfile$getUserDetailProfile<TRes>
      get getUserDetailProfile =>
          CopyWith$Query$GetUserDetailProfile$getUserDetailProfile.stub(_res);
}

const documentNodeQueryGetUserDetailProfile = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetUserDetailProfile'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'userId')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'getUserDetailProfile'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'userId'),
            value: VariableNode(name: NameNode(value: 'userId')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'email'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'name'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'imageUrl'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'fspBalance'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'credentialBalance'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'role'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'primaryRole'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'belongsToArtists'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'name'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'imageUrl'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'fsp'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'status'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'isAdmin'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: 'primaryArtist'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'name'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'imageUrl'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'fsp'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'status'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'isAdmin'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$GetUserDetailProfile _parserFn$Query$GetUserDetailProfile(
        Map<String, dynamic> data) =>
    Query$GetUserDetailProfile.fromJson(data);
typedef OnQueryComplete$Query$GetUserDetailProfile = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$GetUserDetailProfile?,
);

class Options$Query$GetUserDetailProfile
    extends graphql.QueryOptions<Query$GetUserDetailProfile> {
  Options$Query$GetUserDetailProfile({
    String? operationName,
    required Variables$Query$GetUserDetailProfile variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetUserDetailProfile? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetUserDetailProfile? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null
                        ? null
                        : _parserFn$Query$GetUserDetailProfile(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetUserDetailProfile,
          parserFn: _parserFn$Query$GetUserDetailProfile,
        );

  final OnQueryComplete$Query$GetUserDetailProfile? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetUserDetailProfile
    extends graphql.WatchQueryOptions<Query$GetUserDetailProfile> {
  WatchOptions$Query$GetUserDetailProfile({
    String? operationName,
    required Variables$Query$GetUserDetailProfile variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetUserDetailProfile? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryGetUserDetailProfile,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetUserDetailProfile,
        );
}

class FetchMoreOptions$Query$GetUserDetailProfile
    extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetUserDetailProfile({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$GetUserDetailProfile variables,
  }) : super(
          updateQuery: updateQuery,
          variables: variables.toJson(),
          document: documentNodeQueryGetUserDetailProfile,
        );
}

extension ClientExtension$Query$GetUserDetailProfile on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetUserDetailProfile>>
      query$GetUserDetailProfile(
              Options$Query$GetUserDetailProfile options) async =>
          await this.query(options);
  graphql.ObservableQuery<Query$GetUserDetailProfile>
      watchQuery$GetUserDetailProfile(
              WatchOptions$Query$GetUserDetailProfile options) =>
          this.watchQuery(options);
  void writeQuery$GetUserDetailProfile({
    required Query$GetUserDetailProfile data,
    required Variables$Query$GetUserDetailProfile variables,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
          operation: graphql.Operation(
              document: documentNodeQueryGetUserDetailProfile),
          variables: variables.toJson(),
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetUserDetailProfile? readQuery$GetUserDetailProfile({
    required Variables$Query$GetUserDetailProfile variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation:
            graphql.Operation(document: documentNodeQueryGetUserDetailProfile),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetUserDetailProfile.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetUserDetailProfile>
    useQuery$GetUserDetailProfile(Options$Query$GetUserDetailProfile options) =>
        graphql_flutter.useQuery(options);
graphql.ObservableQuery<Query$GetUserDetailProfile>
    useWatchQuery$GetUserDetailProfile(
            WatchOptions$Query$GetUserDetailProfile options) =>
        graphql_flutter.useWatchQuery(options);

class Query$GetUserDetailProfile$Widget
    extends graphql_flutter.Query<Query$GetUserDetailProfile> {
  Query$GetUserDetailProfile$Widget({
    widgets.Key? key,
    required Options$Query$GetUserDetailProfile options,
    required graphql_flutter.QueryBuilder<Query$GetUserDetailProfile> builder,
  }) : super(
          key: key,
          options: options,
          builder: builder,
        );
}

class Query$GetUserDetailProfile$getUserDetailProfile {
  Query$GetUserDetailProfile$getUserDetailProfile({
    required this.id,
    required this.email,
    required this.name,
    this.imageUrl,
    required this.fspBalance,
    required this.credentialBalance,
    required this.role,
    required this.primaryRole,
    required this.belongsToArtists,
    this.primaryArtist,
    this.$__typename = 'UserDetailData',
  });

  factory Query$GetUserDetailProfile$getUserDetailProfile.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$email = json['email'];
    final l$name = json['name'];
    final l$imageUrl = json['imageUrl'];
    final l$fspBalance = json['fspBalance'];
    final l$credentialBalance = json['credentialBalance'];
    final l$role = json['role'];
    final l$primaryRole = json['primaryRole'];
    final l$belongsToArtists = json['belongsToArtists'];
    final l$primaryArtist = json['primaryArtist'];
    final l$$__typename = json['__typename'];
    return Query$GetUserDetailProfile$getUserDetailProfile(
      id: (l$id as String),
      email: (l$email as String),
      name: (l$name as String),
      imageUrl: (l$imageUrl as String?),
      fspBalance: (l$fspBalance as int),
      credentialBalance: (l$credentialBalance as int),
      role: (l$role as String),
      primaryRole: (l$primaryRole as String),
      belongsToArtists: (l$belongsToArtists as List<dynamic>)
          .map((e) =>
              Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists
                  .fromJson((e as Map<String, dynamic>)))
          .toList(),
      primaryArtist: l$primaryArtist == null
          ? null
          : Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist
              .fromJson((l$primaryArtist as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String email;

  final String name;

  final String? imageUrl;

  final int fspBalance;

  final int credentialBalance;

  final String role;

  final String primaryRole;

  final List<Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists>
      belongsToArtists;

  final Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist?
      primaryArtist;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$email = email;
    _resultData['email'] = l$email;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$imageUrl = imageUrl;
    _resultData['imageUrl'] = l$imageUrl;
    final l$fspBalance = fspBalance;
    _resultData['fspBalance'] = l$fspBalance;
    final l$credentialBalance = credentialBalance;
    _resultData['credentialBalance'] = l$credentialBalance;
    final l$role = role;
    _resultData['role'] = l$role;
    final l$primaryRole = primaryRole;
    _resultData['primaryRole'] = l$primaryRole;
    final l$belongsToArtists = belongsToArtists;
    _resultData['belongsToArtists'] =
        l$belongsToArtists.map((e) => e.toJson()).toList();
    final l$primaryArtist = primaryArtist;
    _resultData['primaryArtist'] = l$primaryArtist?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$email = email;
    final l$name = name;
    final l$imageUrl = imageUrl;
    final l$fspBalance = fspBalance;
    final l$credentialBalance = credentialBalance;
    final l$role = role;
    final l$primaryRole = primaryRole;
    final l$belongsToArtists = belongsToArtists;
    final l$primaryArtist = primaryArtist;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$email,
      l$name,
      l$imageUrl,
      l$fspBalance,
      l$credentialBalance,
      l$role,
      l$primaryRole,
      Object.hashAll(l$belongsToArtists.map((v) => v)),
      l$primaryArtist,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetUserDetailProfile$getUserDetailProfile) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (l$email != lOther$email) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$imageUrl = imageUrl;
    final lOther$imageUrl = other.imageUrl;
    if (l$imageUrl != lOther$imageUrl) {
      return false;
    }
    final l$fspBalance = fspBalance;
    final lOther$fspBalance = other.fspBalance;
    if (l$fspBalance != lOther$fspBalance) {
      return false;
    }
    final l$credentialBalance = credentialBalance;
    final lOther$credentialBalance = other.credentialBalance;
    if (l$credentialBalance != lOther$credentialBalance) {
      return false;
    }
    final l$role = role;
    final lOther$role = other.role;
    if (l$role != lOther$role) {
      return false;
    }
    final l$primaryRole = primaryRole;
    final lOther$primaryRole = other.primaryRole;
    if (l$primaryRole != lOther$primaryRole) {
      return false;
    }
    final l$belongsToArtists = belongsToArtists;
    final lOther$belongsToArtists = other.belongsToArtists;
    if (l$belongsToArtists.length != lOther$belongsToArtists.length) {
      return false;
    }
    for (int i = 0; i < l$belongsToArtists.length; i++) {
      final l$belongsToArtists$entry = l$belongsToArtists[i];
      final lOther$belongsToArtists$entry = lOther$belongsToArtists[i];
      if (l$belongsToArtists$entry != lOther$belongsToArtists$entry) {
        return false;
      }
    }
    final l$primaryArtist = primaryArtist;
    final lOther$primaryArtist = other.primaryArtist;
    if (l$primaryArtist != lOther$primaryArtist) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetUserDetailProfile$getUserDetailProfile
    on Query$GetUserDetailProfile$getUserDetailProfile {
  CopyWith$Query$GetUserDetailProfile$getUserDetailProfile<
          Query$GetUserDetailProfile$getUserDetailProfile>
      get copyWith => CopyWith$Query$GetUserDetailProfile$getUserDetailProfile(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetUserDetailProfile$getUserDetailProfile<TRes> {
  factory CopyWith$Query$GetUserDetailProfile$getUserDetailProfile(
    Query$GetUserDetailProfile$getUserDetailProfile instance,
    TRes Function(Query$GetUserDetailProfile$getUserDetailProfile) then,
  ) = _CopyWithImpl$Query$GetUserDetailProfile$getUserDetailProfile;

  factory CopyWith$Query$GetUserDetailProfile$getUserDetailProfile.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetUserDetailProfile$getUserDetailProfile;

  TRes call({
    String? id,
    String? email,
    String? name,
    String? imageUrl,
    int? fspBalance,
    int? credentialBalance,
    String? role,
    String? primaryRole,
    List<Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists>?
        belongsToArtists,
    Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist?
        primaryArtist,
    String? $__typename,
  });
  TRes belongsToArtists(
      Iterable<Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists> Function(
              Iterable<
                  CopyWith$Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists<
                      Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists>>)
          _fn);
  CopyWith$Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist<TRes>
      get primaryArtist;
}

class _CopyWithImpl$Query$GetUserDetailProfile$getUserDetailProfile<TRes>
    implements CopyWith$Query$GetUserDetailProfile$getUserDetailProfile<TRes> {
  _CopyWithImpl$Query$GetUserDetailProfile$getUserDetailProfile(
    this._instance,
    this._then,
  );

  final Query$GetUserDetailProfile$getUserDetailProfile _instance;

  final TRes Function(Query$GetUserDetailProfile$getUserDetailProfile) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? email = _undefined,
    Object? name = _undefined,
    Object? imageUrl = _undefined,
    Object? fspBalance = _undefined,
    Object? credentialBalance = _undefined,
    Object? role = _undefined,
    Object? primaryRole = _undefined,
    Object? belongsToArtists = _undefined,
    Object? primaryArtist = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetUserDetailProfile$getUserDetailProfile(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        email: email == _undefined || email == null
            ? _instance.email
            : (email as String),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        imageUrl:
            imageUrl == _undefined ? _instance.imageUrl : (imageUrl as String?),
        fspBalance: fspBalance == _undefined || fspBalance == null
            ? _instance.fspBalance
            : (fspBalance as int),
        credentialBalance:
            credentialBalance == _undefined || credentialBalance == null
                ? _instance.credentialBalance
                : (credentialBalance as int),
        role: role == _undefined || role == null
            ? _instance.role
            : (role as String),
        primaryRole: primaryRole == _undefined || primaryRole == null
            ? _instance.primaryRole
            : (primaryRole as String),
        belongsToArtists: belongsToArtists == _undefined ||
                belongsToArtists == null
            ? _instance.belongsToArtists
            : (belongsToArtists as List<
                Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists>),
        primaryArtist: primaryArtist == _undefined
            ? _instance.primaryArtist
            : (primaryArtist
                as Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes belongsToArtists(
          Iterable<Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists> Function(
                  Iterable<
                      CopyWith$Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists<
                          Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists>>)
              _fn) =>
      call(
          belongsToArtists: _fn(_instance.belongsToArtists.map((e) =>
              CopyWith$Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists(
                e,
                (i) => i,
              ))).toList());

  CopyWith$Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist<TRes>
      get primaryArtist {
    final local$primaryArtist = _instance.primaryArtist;
    return local$primaryArtist == null
        ? CopyWith$Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist
            .stub(_then(_instance))
        : CopyWith$Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist(
            local$primaryArtist, (e) => call(primaryArtist: e));
  }
}

class _CopyWithStubImpl$Query$GetUserDetailProfile$getUserDetailProfile<TRes>
    implements CopyWith$Query$GetUserDetailProfile$getUserDetailProfile<TRes> {
  _CopyWithStubImpl$Query$GetUserDetailProfile$getUserDetailProfile(this._res);

  TRes _res;

  call({
    String? id,
    String? email,
    String? name,
    String? imageUrl,
    int? fspBalance,
    int? credentialBalance,
    String? role,
    String? primaryRole,
    List<Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists>?
        belongsToArtists,
    Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist?
        primaryArtist,
    String? $__typename,
  }) =>
      _res;

  belongsToArtists(_fn) => _res;

  CopyWith$Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist<TRes>
      get primaryArtist =>
          CopyWith$Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist
              .stub(_res);
}

class Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists {
  Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.fsp,
    required this.status,
    required this.isAdmin,
    this.$__typename = 'ArtistByUserData',
  });

  factory Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$imageUrl = json['imageUrl'];
    final l$fsp = json['fsp'];
    final l$status = json['status'];
    final l$isAdmin = json['isAdmin'];
    final l$$__typename = json['__typename'];
    return Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists(
      id: (l$id as String),
      name: (l$name as String),
      imageUrl: (l$imageUrl as String?),
      fsp: (l$fsp as int),
      status: (l$status as String),
      isAdmin: (l$isAdmin as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String name;

  final String? imageUrl;

  final int fsp;

  final String status;

  final bool isAdmin;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$imageUrl = imageUrl;
    _resultData['imageUrl'] = l$imageUrl;
    final l$fsp = fsp;
    _resultData['fsp'] = l$fsp;
    final l$status = status;
    _resultData['status'] = l$status;
    final l$isAdmin = isAdmin;
    _resultData['isAdmin'] = l$isAdmin;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$imageUrl = imageUrl;
    final l$fsp = fsp;
    final l$status = status;
    final l$isAdmin = isAdmin;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$name,
      l$imageUrl,
      l$fsp,
      l$status,
      l$isAdmin,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other
            is Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$imageUrl = imageUrl;
    final lOther$imageUrl = other.imageUrl;
    if (l$imageUrl != lOther$imageUrl) {
      return false;
    }
    final l$fsp = fsp;
    final lOther$fsp = other.fsp;
    if (l$fsp != lOther$fsp) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    final l$isAdmin = isAdmin;
    final lOther$isAdmin = other.isAdmin;
    if (l$isAdmin != lOther$isAdmin) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists
    on Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists {
  CopyWith$Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists<
          Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists>
      get copyWith =>
          CopyWith$Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists<
    TRes> {
  factory CopyWith$Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists(
    Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists instance,
    TRes Function(
            Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists)
        then,
  ) = _CopyWithImpl$Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists;

  factory CopyWith$Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists;

  TRes call({
    String? id,
    String? name,
    String? imageUrl,
    int? fsp,
    String? status,
    bool? isAdmin,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists<
        TRes>
    implements
        CopyWith$Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists<
            TRes> {
  _CopyWithImpl$Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists(
    this._instance,
    this._then,
  );

  final Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists
      _instance;

  final TRes Function(
      Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? imageUrl = _undefined,
    Object? fsp = _undefined,
    Object? status = _undefined,
    Object? isAdmin = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        imageUrl:
            imageUrl == _undefined ? _instance.imageUrl : (imageUrl as String?),
        fsp: fsp == _undefined || fsp == null ? _instance.fsp : (fsp as int),
        status: status == _undefined || status == null
            ? _instance.status
            : (status as String),
        isAdmin: isAdmin == _undefined || isAdmin == null
            ? _instance.isAdmin
            : (isAdmin as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists<
        TRes>
    implements
        CopyWith$Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists<
            TRes> {
  _CopyWithStubImpl$Query$GetUserDetailProfile$getUserDetailProfile$belongsToArtists(
      this._res);

  TRes _res;

  call({
    String? id,
    String? name,
    String? imageUrl,
    int? fsp,
    String? status,
    bool? isAdmin,
    String? $__typename,
  }) =>
      _res;
}

class Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist {
  Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.fsp,
    required this.status,
    required this.isAdmin,
    this.$__typename = 'ArtistByUserData',
  });

  factory Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$imageUrl = json['imageUrl'];
    final l$fsp = json['fsp'];
    final l$status = json['status'];
    final l$isAdmin = json['isAdmin'];
    final l$$__typename = json['__typename'];
    return Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist(
      id: (l$id as String),
      name: (l$name as String),
      imageUrl: (l$imageUrl as String?),
      fsp: (l$fsp as int),
      status: (l$status as String),
      isAdmin: (l$isAdmin as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String name;

  final String? imageUrl;

  final int fsp;

  final String status;

  final bool isAdmin;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$imageUrl = imageUrl;
    _resultData['imageUrl'] = l$imageUrl;
    final l$fsp = fsp;
    _resultData['fsp'] = l$fsp;
    final l$status = status;
    _resultData['status'] = l$status;
    final l$isAdmin = isAdmin;
    _resultData['isAdmin'] = l$isAdmin;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$imageUrl = imageUrl;
    final l$fsp = fsp;
    final l$status = status;
    final l$isAdmin = isAdmin;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$name,
      l$imageUrl,
      l$fsp,
      l$status,
      l$isAdmin,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other
            is Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$imageUrl = imageUrl;
    final lOther$imageUrl = other.imageUrl;
    if (l$imageUrl != lOther$imageUrl) {
      return false;
    }
    final l$fsp = fsp;
    final lOther$fsp = other.fsp;
    if (l$fsp != lOther$fsp) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    final l$isAdmin = isAdmin;
    final lOther$isAdmin = other.isAdmin;
    if (l$isAdmin != lOther$isAdmin) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist
    on Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist {
  CopyWith$Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist<
          Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist>
      get copyWith =>
          CopyWith$Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist<
    TRes> {
  factory CopyWith$Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist(
    Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist instance,
    TRes Function(Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist)
        then,
  ) = _CopyWithImpl$Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist;

  factory CopyWith$Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist;

  TRes call({
    String? id,
    String? name,
    String? imageUrl,
    int? fsp,
    String? status,
    bool? isAdmin,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist<
        TRes>
    implements
        CopyWith$Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist<
            TRes> {
  _CopyWithImpl$Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist(
    this._instance,
    this._then,
  );

  final Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist _instance;

  final TRes Function(
      Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? imageUrl = _undefined,
    Object? fsp = _undefined,
    Object? status = _undefined,
    Object? isAdmin = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        imageUrl:
            imageUrl == _undefined ? _instance.imageUrl : (imageUrl as String?),
        fsp: fsp == _undefined || fsp == null ? _instance.fsp : (fsp as int),
        status: status == _undefined || status == null
            ? _instance.status
            : (status as String),
        isAdmin: isAdmin == _undefined || isAdmin == null
            ? _instance.isAdmin
            : (isAdmin as bool),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist<
        TRes>
    implements
        CopyWith$Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist<
            TRes> {
  _CopyWithStubImpl$Query$GetUserDetailProfile$getUserDetailProfile$primaryArtist(
      this._res);

  TRes _res;

  call({
    String? id,
    String? name,
    String? imageUrl,
    int? fsp,
    String? status,
    bool? isAdmin,
    String? $__typename,
  }) =>
      _res;
}

class Query$GetAllArtists {
  Query$GetAllArtists({
    required this.getAllArtists,
    this.$__typename = 'QueryRoot',
  });

  factory Query$GetAllArtists.fromJson(Map<String, dynamic> json) {
    final l$getAllArtists = json['getAllArtists'];
    final l$$__typename = json['__typename'];
    return Query$GetAllArtists(
      getAllArtists: Query$GetAllArtists$getAllArtists.fromJson(
          (l$getAllArtists as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetAllArtists$getAllArtists getAllArtists;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getAllArtists = getAllArtists;
    _resultData['getAllArtists'] = l$getAllArtists.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getAllArtists = getAllArtists;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$getAllArtists,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetAllArtists) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$getAllArtists = getAllArtists;
    final lOther$getAllArtists = other.getAllArtists;
    if (l$getAllArtists != lOther$getAllArtists) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetAllArtists on Query$GetAllArtists {
  CopyWith$Query$GetAllArtists<Query$GetAllArtists> get copyWith =>
      CopyWith$Query$GetAllArtists(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetAllArtists<TRes> {
  factory CopyWith$Query$GetAllArtists(
    Query$GetAllArtists instance,
    TRes Function(Query$GetAllArtists) then,
  ) = _CopyWithImpl$Query$GetAllArtists;

  factory CopyWith$Query$GetAllArtists.stub(TRes res) =
      _CopyWithStubImpl$Query$GetAllArtists;

  TRes call({
    Query$GetAllArtists$getAllArtists? getAllArtists,
    String? $__typename,
  });
  CopyWith$Query$GetAllArtists$getAllArtists<TRes> get getAllArtists;
}

class _CopyWithImpl$Query$GetAllArtists<TRes>
    implements CopyWith$Query$GetAllArtists<TRes> {
  _CopyWithImpl$Query$GetAllArtists(
    this._instance,
    this._then,
  );

  final Query$GetAllArtists _instance;

  final TRes Function(Query$GetAllArtists) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getAllArtists = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetAllArtists(
        getAllArtists: getAllArtists == _undefined || getAllArtists == null
            ? _instance.getAllArtists
            : (getAllArtists as Query$GetAllArtists$getAllArtists),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetAllArtists$getAllArtists<TRes> get getAllArtists {
    final local$getAllArtists = _instance.getAllArtists;
    return CopyWith$Query$GetAllArtists$getAllArtists(
        local$getAllArtists, (e) => call(getAllArtists: e));
  }
}

class _CopyWithStubImpl$Query$GetAllArtists<TRes>
    implements CopyWith$Query$GetAllArtists<TRes> {
  _CopyWithStubImpl$Query$GetAllArtists(this._res);

  TRes _res;

  call({
    Query$GetAllArtists$getAllArtists? getAllArtists,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetAllArtists$getAllArtists<TRes> get getAllArtists =>
      CopyWith$Query$GetAllArtists$getAllArtists.stub(_res);
}

const documentNodeQueryGetAllArtists = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetAllArtists'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'getAllArtists'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'artistList'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'name'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'fsp'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'imageUrl'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$GetAllArtists _parserFn$Query$GetAllArtists(Map<String, dynamic> data) =>
    Query$GetAllArtists.fromJson(data);
typedef OnQueryComplete$Query$GetAllArtists = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$GetAllArtists?,
);

class Options$Query$GetAllArtists
    extends graphql.QueryOptions<Query$GetAllArtists> {
  Options$Query$GetAllArtists({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetAllArtists? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetAllArtists? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null ? null : _parserFn$Query$GetAllArtists(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetAllArtists,
          parserFn: _parserFn$Query$GetAllArtists,
        );

  final OnQueryComplete$Query$GetAllArtists? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetAllArtists
    extends graphql.WatchQueryOptions<Query$GetAllArtists> {
  WatchOptions$Query$GetAllArtists({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetAllArtists? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryGetAllArtists,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetAllArtists,
        );
}

class FetchMoreOptions$Query$GetAllArtists extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetAllArtists(
      {required graphql.UpdateQuery updateQuery})
      : super(
          updateQuery: updateQuery,
          document: documentNodeQueryGetAllArtists,
        );
}

extension ClientExtension$Query$GetAllArtists on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetAllArtists>> query$GetAllArtists(
          [Options$Query$GetAllArtists? options]) async =>
      await this.query(options ?? Options$Query$GetAllArtists());
  graphql.ObservableQuery<Query$GetAllArtists> watchQuery$GetAllArtists(
          [WatchOptions$Query$GetAllArtists? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$GetAllArtists());
  void writeQuery$GetAllArtists({
    required Query$GetAllArtists data,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
            operation:
                graphql.Operation(document: documentNodeQueryGetAllArtists)),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetAllArtists? readQuery$GetAllArtists({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
          operation:
              graphql.Operation(document: documentNodeQueryGetAllArtists)),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetAllArtists.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetAllArtists> useQuery$GetAllArtists(
        [Options$Query$GetAllArtists? options]) =>
    graphql_flutter.useQuery(options ?? Options$Query$GetAllArtists());
graphql.ObservableQuery<Query$GetAllArtists> useWatchQuery$GetAllArtists(
        [WatchOptions$Query$GetAllArtists? options]) =>
    graphql_flutter
        .useWatchQuery(options ?? WatchOptions$Query$GetAllArtists());

class Query$GetAllArtists$Widget
    extends graphql_flutter.Query<Query$GetAllArtists> {
  Query$GetAllArtists$Widget({
    widgets.Key? key,
    Options$Query$GetAllArtists? options,
    required graphql_flutter.QueryBuilder<Query$GetAllArtists> builder,
  }) : super(
          key: key,
          options: options ?? Options$Query$GetAllArtists(),
          builder: builder,
        );
}

class Query$GetAllArtists$getAllArtists {
  Query$GetAllArtists$getAllArtists({
    required this.artistList,
    this.$__typename = 'ArtistsData',
  });

  factory Query$GetAllArtists$getAllArtists.fromJson(
      Map<String, dynamic> json) {
    final l$artistList = json['artistList'];
    final l$$__typename = json['__typename'];
    return Query$GetAllArtists$getAllArtists(
      artistList: (l$artistList as List<dynamic>)
          .map((e) => Query$GetAllArtists$getAllArtists$artistList.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$GetAllArtists$getAllArtists$artistList> artistList;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$artistList = artistList;
    _resultData['artistList'] = l$artistList.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$artistList = artistList;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$artistList.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetAllArtists$getAllArtists) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$artistList = artistList;
    final lOther$artistList = other.artistList;
    if (l$artistList.length != lOther$artistList.length) {
      return false;
    }
    for (int i = 0; i < l$artistList.length; i++) {
      final l$artistList$entry = l$artistList[i];
      final lOther$artistList$entry = lOther$artistList[i];
      if (l$artistList$entry != lOther$artistList$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetAllArtists$getAllArtists
    on Query$GetAllArtists$getAllArtists {
  CopyWith$Query$GetAllArtists$getAllArtists<Query$GetAllArtists$getAllArtists>
      get copyWith => CopyWith$Query$GetAllArtists$getAllArtists(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetAllArtists$getAllArtists<TRes> {
  factory CopyWith$Query$GetAllArtists$getAllArtists(
    Query$GetAllArtists$getAllArtists instance,
    TRes Function(Query$GetAllArtists$getAllArtists) then,
  ) = _CopyWithImpl$Query$GetAllArtists$getAllArtists;

  factory CopyWith$Query$GetAllArtists$getAllArtists.stub(TRes res) =
      _CopyWithStubImpl$Query$GetAllArtists$getAllArtists;

  TRes call({
    List<Query$GetAllArtists$getAllArtists$artistList>? artistList,
    String? $__typename,
  });
  TRes artistList(
      Iterable<Query$GetAllArtists$getAllArtists$artistList> Function(
              Iterable<
                  CopyWith$Query$GetAllArtists$getAllArtists$artistList<
                      Query$GetAllArtists$getAllArtists$artistList>>)
          _fn);
}

class _CopyWithImpl$Query$GetAllArtists$getAllArtists<TRes>
    implements CopyWith$Query$GetAllArtists$getAllArtists<TRes> {
  _CopyWithImpl$Query$GetAllArtists$getAllArtists(
    this._instance,
    this._then,
  );

  final Query$GetAllArtists$getAllArtists _instance;

  final TRes Function(Query$GetAllArtists$getAllArtists) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? artistList = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetAllArtists$getAllArtists(
        artistList: artistList == _undefined || artistList == null
            ? _instance.artistList
            : (artistList
                as List<Query$GetAllArtists$getAllArtists$artistList>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes artistList(
          Iterable<Query$GetAllArtists$getAllArtists$artistList> Function(
                  Iterable<
                      CopyWith$Query$GetAllArtists$getAllArtists$artistList<
                          Query$GetAllArtists$getAllArtists$artistList>>)
              _fn) =>
      call(
          artistList: _fn(_instance.artistList
              .map((e) => CopyWith$Query$GetAllArtists$getAllArtists$artistList(
                    e,
                    (i) => i,
                  ))).toList());
}

class _CopyWithStubImpl$Query$GetAllArtists$getAllArtists<TRes>
    implements CopyWith$Query$GetAllArtists$getAllArtists<TRes> {
  _CopyWithStubImpl$Query$GetAllArtists$getAllArtists(this._res);

  TRes _res;

  call({
    List<Query$GetAllArtists$getAllArtists$artistList>? artistList,
    String? $__typename,
  }) =>
      _res;

  artistList(_fn) => _res;
}

class Query$GetAllArtists$getAllArtists$artistList {
  Query$GetAllArtists$getAllArtists$artistList({
    required this.id,
    required this.name,
    required this.fsp,
    this.imageUrl,
    this.$__typename = 'ArtistData',
  });

  factory Query$GetAllArtists$getAllArtists$artistList.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$fsp = json['fsp'];
    final l$imageUrl = json['imageUrl'];
    final l$$__typename = json['__typename'];
    return Query$GetAllArtists$getAllArtists$artistList(
      id: (l$id as String),
      name: (l$name as String),
      fsp: (l$fsp as int),
      imageUrl: (l$imageUrl as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String name;

  final int fsp;

  final String? imageUrl;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$fsp = fsp;
    _resultData['fsp'] = l$fsp;
    final l$imageUrl = imageUrl;
    _resultData['imageUrl'] = l$imageUrl;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$fsp = fsp;
    final l$imageUrl = imageUrl;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$name,
      l$fsp,
      l$imageUrl,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetAllArtists$getAllArtists$artistList) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$fsp = fsp;
    final lOther$fsp = other.fsp;
    if (l$fsp != lOther$fsp) {
      return false;
    }
    final l$imageUrl = imageUrl;
    final lOther$imageUrl = other.imageUrl;
    if (l$imageUrl != lOther$imageUrl) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetAllArtists$getAllArtists$artistList
    on Query$GetAllArtists$getAllArtists$artistList {
  CopyWith$Query$GetAllArtists$getAllArtists$artistList<
          Query$GetAllArtists$getAllArtists$artistList>
      get copyWith => CopyWith$Query$GetAllArtists$getAllArtists$artistList(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetAllArtists$getAllArtists$artistList<TRes> {
  factory CopyWith$Query$GetAllArtists$getAllArtists$artistList(
    Query$GetAllArtists$getAllArtists$artistList instance,
    TRes Function(Query$GetAllArtists$getAllArtists$artistList) then,
  ) = _CopyWithImpl$Query$GetAllArtists$getAllArtists$artistList;

  factory CopyWith$Query$GetAllArtists$getAllArtists$artistList.stub(TRes res) =
      _CopyWithStubImpl$Query$GetAllArtists$getAllArtists$artistList;

  TRes call({
    String? id,
    String? name,
    int? fsp,
    String? imageUrl,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetAllArtists$getAllArtists$artistList<TRes>
    implements CopyWith$Query$GetAllArtists$getAllArtists$artistList<TRes> {
  _CopyWithImpl$Query$GetAllArtists$getAllArtists$artistList(
    this._instance,
    this._then,
  );

  final Query$GetAllArtists$getAllArtists$artistList _instance;

  final TRes Function(Query$GetAllArtists$getAllArtists$artistList) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? fsp = _undefined,
    Object? imageUrl = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetAllArtists$getAllArtists$artistList(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        fsp: fsp == _undefined || fsp == null ? _instance.fsp : (fsp as int),
        imageUrl:
            imageUrl == _undefined ? _instance.imageUrl : (imageUrl as String?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetAllArtists$getAllArtists$artistList<TRes>
    implements CopyWith$Query$GetAllArtists$getAllArtists$artistList<TRes> {
  _CopyWithStubImpl$Query$GetAllArtists$getAllArtists$artistList(this._res);

  TRes _res;

  call({
    String? id,
    String? name,
    int? fsp,
    String? imageUrl,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Query$GetArtistById {
  factory Variables$Query$GetArtistById({required String artistId}) =>
      Variables$Query$GetArtistById._({
        r'artistId': artistId,
      });

  Variables$Query$GetArtistById._(this._$data);

  factory Variables$Query$GetArtistById.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$artistId = data['artistId'];
    result$data['artistId'] = (l$artistId as String);
    return Variables$Query$GetArtistById._(result$data);
  }

  Map<String, dynamic> _$data;

  String get artistId => (_$data['artistId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$artistId = artistId;
    result$data['artistId'] = l$artistId;
    return result$data;
  }

  CopyWith$Variables$Query$GetArtistById<Variables$Query$GetArtistById>
      get copyWith => CopyWith$Variables$Query$GetArtistById(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$GetArtistById) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$artistId = artistId;
    final lOther$artistId = other.artistId;
    if (l$artistId != lOther$artistId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$artistId = artistId;
    return Object.hashAll([l$artistId]);
  }
}

abstract class CopyWith$Variables$Query$GetArtistById<TRes> {
  factory CopyWith$Variables$Query$GetArtistById(
    Variables$Query$GetArtistById instance,
    TRes Function(Variables$Query$GetArtistById) then,
  ) = _CopyWithImpl$Variables$Query$GetArtistById;

  factory CopyWith$Variables$Query$GetArtistById.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$GetArtistById;

  TRes call({String? artistId});
}

class _CopyWithImpl$Variables$Query$GetArtistById<TRes>
    implements CopyWith$Variables$Query$GetArtistById<TRes> {
  _CopyWithImpl$Variables$Query$GetArtistById(
    this._instance,
    this._then,
  );

  final Variables$Query$GetArtistById _instance;

  final TRes Function(Variables$Query$GetArtistById) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? artistId = _undefined}) =>
      _then(Variables$Query$GetArtistById._({
        ..._instance._$data,
        if (artistId != _undefined && artistId != null)
          'artistId': (artistId as String),
      }));
}

class _CopyWithStubImpl$Variables$Query$GetArtistById<TRes>
    implements CopyWith$Variables$Query$GetArtistById<TRes> {
  _CopyWithStubImpl$Variables$Query$GetArtistById(this._res);

  TRes _res;

  call({String? artistId}) => _res;
}

class Query$GetArtistById {
  Query$GetArtistById({
    required this.getArtistById,
    this.$__typename = 'QueryRoot',
  });

  factory Query$GetArtistById.fromJson(Map<String, dynamic> json) {
    final l$getArtistById = json['getArtistById'];
    final l$$__typename = json['__typename'];
    return Query$GetArtistById(
      getArtistById: Query$GetArtistById$getArtistById.fromJson(
          (l$getArtistById as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetArtistById$getArtistById getArtistById;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getArtistById = getArtistById;
    _resultData['getArtistById'] = l$getArtistById.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getArtistById = getArtistById;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$getArtistById,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetArtistById) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$getArtistById = getArtistById;
    final lOther$getArtistById = other.getArtistById;
    if (l$getArtistById != lOther$getArtistById) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetArtistById on Query$GetArtistById {
  CopyWith$Query$GetArtistById<Query$GetArtistById> get copyWith =>
      CopyWith$Query$GetArtistById(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetArtistById<TRes> {
  factory CopyWith$Query$GetArtistById(
    Query$GetArtistById instance,
    TRes Function(Query$GetArtistById) then,
  ) = _CopyWithImpl$Query$GetArtistById;

  factory CopyWith$Query$GetArtistById.stub(TRes res) =
      _CopyWithStubImpl$Query$GetArtistById;

  TRes call({
    Query$GetArtistById$getArtistById? getArtistById,
    String? $__typename,
  });
  CopyWith$Query$GetArtistById$getArtistById<TRes> get getArtistById;
}

class _CopyWithImpl$Query$GetArtistById<TRes>
    implements CopyWith$Query$GetArtistById<TRes> {
  _CopyWithImpl$Query$GetArtistById(
    this._instance,
    this._then,
  );

  final Query$GetArtistById _instance;

  final TRes Function(Query$GetArtistById) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getArtistById = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetArtistById(
        getArtistById: getArtistById == _undefined || getArtistById == null
            ? _instance.getArtistById
            : (getArtistById as Query$GetArtistById$getArtistById),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetArtistById$getArtistById<TRes> get getArtistById {
    final local$getArtistById = _instance.getArtistById;
    return CopyWith$Query$GetArtistById$getArtistById(
        local$getArtistById, (e) => call(getArtistById: e));
  }
}

class _CopyWithStubImpl$Query$GetArtistById<TRes>
    implements CopyWith$Query$GetArtistById<TRes> {
  _CopyWithStubImpl$Query$GetArtistById(this._res);

  TRes _res;

  call({
    Query$GetArtistById$getArtistById? getArtistById,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetArtistById$getArtistById<TRes> get getArtistById =>
      CopyWith$Query$GetArtistById$getArtistById.stub(_res);
}

const documentNodeQueryGetArtistById = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetArtistById'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'artistId')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'getArtistById'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'artistId'),
            value: VariableNode(name: NameNode(value: 'artistId')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'name'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'imgUrl'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'fsp'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'status'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'since'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'universalId'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'appleKey'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'spotifyKey'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'lineKey'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'amazonKey'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'youtubeKey'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$GetArtistById _parserFn$Query$GetArtistById(Map<String, dynamic> data) =>
    Query$GetArtistById.fromJson(data);
typedef OnQueryComplete$Query$GetArtistById = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$GetArtistById?,
);

class Options$Query$GetArtistById
    extends graphql.QueryOptions<Query$GetArtistById> {
  Options$Query$GetArtistById({
    String? operationName,
    required Variables$Query$GetArtistById variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetArtistById? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetArtistById? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null ? null : _parserFn$Query$GetArtistById(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetArtistById,
          parserFn: _parserFn$Query$GetArtistById,
        );

  final OnQueryComplete$Query$GetArtistById? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetArtistById
    extends graphql.WatchQueryOptions<Query$GetArtistById> {
  WatchOptions$Query$GetArtistById({
    String? operationName,
    required Variables$Query$GetArtistById variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetArtistById? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryGetArtistById,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetArtistById,
        );
}

class FetchMoreOptions$Query$GetArtistById extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetArtistById({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$GetArtistById variables,
  }) : super(
          updateQuery: updateQuery,
          variables: variables.toJson(),
          document: documentNodeQueryGetArtistById,
        );
}

extension ClientExtension$Query$GetArtistById on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetArtistById>> query$GetArtistById(
          Options$Query$GetArtistById options) async =>
      await this.query(options);
  graphql.ObservableQuery<Query$GetArtistById> watchQuery$GetArtistById(
          WatchOptions$Query$GetArtistById options) =>
      this.watchQuery(options);
  void writeQuery$GetArtistById({
    required Query$GetArtistById data,
    required Variables$Query$GetArtistById variables,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
          operation:
              graphql.Operation(document: documentNodeQueryGetArtistById),
          variables: variables.toJson(),
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetArtistById? readQuery$GetArtistById({
    required Variables$Query$GetArtistById variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryGetArtistById),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetArtistById.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetArtistById> useQuery$GetArtistById(
        Options$Query$GetArtistById options) =>
    graphql_flutter.useQuery(options);
graphql.ObservableQuery<Query$GetArtistById> useWatchQuery$GetArtistById(
        WatchOptions$Query$GetArtistById options) =>
    graphql_flutter.useWatchQuery(options);

class Query$GetArtistById$Widget
    extends graphql_flutter.Query<Query$GetArtistById> {
  Query$GetArtistById$Widget({
    widgets.Key? key,
    required Options$Query$GetArtistById options,
    required graphql_flutter.QueryBuilder<Query$GetArtistById> builder,
  }) : super(
          key: key,
          options: options,
          builder: builder,
        );
}

class Query$GetArtistById$getArtistById {
  Query$GetArtistById$getArtistById({
    required this.id,
    required this.name,
    this.imgUrl,
    required this.fsp,
    this.status,
    this.since,
    this.universalId,
    this.appleKey,
    this.spotifyKey,
    this.lineKey,
    this.amazonKey,
    this.youtubeKey,
    this.$__typename = 'ArtistFullData',
  });

  factory Query$GetArtistById$getArtistById.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$imgUrl = json['imgUrl'];
    final l$fsp = json['fsp'];
    final l$status = json['status'];
    final l$since = json['since'];
    final l$universalId = json['universalId'];
    final l$appleKey = json['appleKey'];
    final l$spotifyKey = json['spotifyKey'];
    final l$lineKey = json['lineKey'];
    final l$amazonKey = json['amazonKey'];
    final l$youtubeKey = json['youtubeKey'];
    final l$$__typename = json['__typename'];
    return Query$GetArtistById$getArtistById(
      id: (l$id as String),
      name: (l$name as String),
      imgUrl: (l$imgUrl as String?),
      fsp: (l$fsp as int),
      status: (l$status as String?),
      since: (l$since as String?),
      universalId: (l$universalId as String?),
      appleKey: (l$appleKey as String?),
      spotifyKey: (l$spotifyKey as String?),
      lineKey: (l$lineKey as String?),
      amazonKey: (l$amazonKey as String?),
      youtubeKey: (l$youtubeKey as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String name;

  final String? imgUrl;

  final int fsp;

  final String? status;

  final String? since;

  final String? universalId;

  final String? appleKey;

  final String? spotifyKey;

  final String? lineKey;

  final String? amazonKey;

  final String? youtubeKey;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$imgUrl = imgUrl;
    _resultData['imgUrl'] = l$imgUrl;
    final l$fsp = fsp;
    _resultData['fsp'] = l$fsp;
    final l$status = status;
    _resultData['status'] = l$status;
    final l$since = since;
    _resultData['since'] = l$since;
    final l$universalId = universalId;
    _resultData['universalId'] = l$universalId;
    final l$appleKey = appleKey;
    _resultData['appleKey'] = l$appleKey;
    final l$spotifyKey = spotifyKey;
    _resultData['spotifyKey'] = l$spotifyKey;
    final l$lineKey = lineKey;
    _resultData['lineKey'] = l$lineKey;
    final l$amazonKey = amazonKey;
    _resultData['amazonKey'] = l$amazonKey;
    final l$youtubeKey = youtubeKey;
    _resultData['youtubeKey'] = l$youtubeKey;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$imgUrl = imgUrl;
    final l$fsp = fsp;
    final l$status = status;
    final l$since = since;
    final l$universalId = universalId;
    final l$appleKey = appleKey;
    final l$spotifyKey = spotifyKey;
    final l$lineKey = lineKey;
    final l$amazonKey = amazonKey;
    final l$youtubeKey = youtubeKey;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$name,
      l$imgUrl,
      l$fsp,
      l$status,
      l$since,
      l$universalId,
      l$appleKey,
      l$spotifyKey,
      l$lineKey,
      l$amazonKey,
      l$youtubeKey,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetArtistById$getArtistById) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$imgUrl = imgUrl;
    final lOther$imgUrl = other.imgUrl;
    if (l$imgUrl != lOther$imgUrl) {
      return false;
    }
    final l$fsp = fsp;
    final lOther$fsp = other.fsp;
    if (l$fsp != lOther$fsp) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    final l$since = since;
    final lOther$since = other.since;
    if (l$since != lOther$since) {
      return false;
    }
    final l$universalId = universalId;
    final lOther$universalId = other.universalId;
    if (l$universalId != lOther$universalId) {
      return false;
    }
    final l$appleKey = appleKey;
    final lOther$appleKey = other.appleKey;
    if (l$appleKey != lOther$appleKey) {
      return false;
    }
    final l$spotifyKey = spotifyKey;
    final lOther$spotifyKey = other.spotifyKey;
    if (l$spotifyKey != lOther$spotifyKey) {
      return false;
    }
    final l$lineKey = lineKey;
    final lOther$lineKey = other.lineKey;
    if (l$lineKey != lOther$lineKey) {
      return false;
    }
    final l$amazonKey = amazonKey;
    final lOther$amazonKey = other.amazonKey;
    if (l$amazonKey != lOther$amazonKey) {
      return false;
    }
    final l$youtubeKey = youtubeKey;
    final lOther$youtubeKey = other.youtubeKey;
    if (l$youtubeKey != lOther$youtubeKey) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetArtistById$getArtistById
    on Query$GetArtistById$getArtistById {
  CopyWith$Query$GetArtistById$getArtistById<Query$GetArtistById$getArtistById>
      get copyWith => CopyWith$Query$GetArtistById$getArtistById(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetArtistById$getArtistById<TRes> {
  factory CopyWith$Query$GetArtistById$getArtistById(
    Query$GetArtistById$getArtistById instance,
    TRes Function(Query$GetArtistById$getArtistById) then,
  ) = _CopyWithImpl$Query$GetArtistById$getArtistById;

  factory CopyWith$Query$GetArtistById$getArtistById.stub(TRes res) =
      _CopyWithStubImpl$Query$GetArtistById$getArtistById;

  TRes call({
    String? id,
    String? name,
    String? imgUrl,
    int? fsp,
    String? status,
    String? since,
    String? universalId,
    String? appleKey,
    String? spotifyKey,
    String? lineKey,
    String? amazonKey,
    String? youtubeKey,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetArtistById$getArtistById<TRes>
    implements CopyWith$Query$GetArtistById$getArtistById<TRes> {
  _CopyWithImpl$Query$GetArtistById$getArtistById(
    this._instance,
    this._then,
  );

  final Query$GetArtistById$getArtistById _instance;

  final TRes Function(Query$GetArtistById$getArtistById) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? imgUrl = _undefined,
    Object? fsp = _undefined,
    Object? status = _undefined,
    Object? since = _undefined,
    Object? universalId = _undefined,
    Object? appleKey = _undefined,
    Object? spotifyKey = _undefined,
    Object? lineKey = _undefined,
    Object? amazonKey = _undefined,
    Object? youtubeKey = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetArtistById$getArtistById(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        imgUrl: imgUrl == _undefined ? _instance.imgUrl : (imgUrl as String?),
        fsp: fsp == _undefined || fsp == null ? _instance.fsp : (fsp as int),
        status: status == _undefined ? _instance.status : (status as String?),
        since: since == _undefined ? _instance.since : (since as String?),
        universalId: universalId == _undefined
            ? _instance.universalId
            : (universalId as String?),
        appleKey:
            appleKey == _undefined ? _instance.appleKey : (appleKey as String?),
        spotifyKey: spotifyKey == _undefined
            ? _instance.spotifyKey
            : (spotifyKey as String?),
        lineKey:
            lineKey == _undefined ? _instance.lineKey : (lineKey as String?),
        amazonKey: amazonKey == _undefined
            ? _instance.amazonKey
            : (amazonKey as String?),
        youtubeKey: youtubeKey == _undefined
            ? _instance.youtubeKey
            : (youtubeKey as String?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetArtistById$getArtistById<TRes>
    implements CopyWith$Query$GetArtistById$getArtistById<TRes> {
  _CopyWithStubImpl$Query$GetArtistById$getArtistById(this._res);

  TRes _res;

  call({
    String? id,
    String? name,
    String? imgUrl,
    int? fsp,
    String? status,
    String? since,
    String? universalId,
    String? appleKey,
    String? spotifyKey,
    String? lineKey,
    String? amazonKey,
    String? youtubeKey,
    String? $__typename,
  }) =>
      _res;
}

class Query$GetPopularPrizes {
  Query$GetPopularPrizes({
    required this.getPopularPrizes,
    this.$__typename = 'QueryRoot',
  });

  factory Query$GetPopularPrizes.fromJson(Map<String, dynamic> json) {
    final l$getPopularPrizes = json['getPopularPrizes'];
    final l$$__typename = json['__typename'];
    return Query$GetPopularPrizes(
      getPopularPrizes: (l$getPopularPrizes as List<dynamic>)
          .map((e) => Query$GetPopularPrizes$getPopularPrizes.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$GetPopularPrizes$getPopularPrizes> getPopularPrizes;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getPopularPrizes = getPopularPrizes;
    _resultData['getPopularPrizes'] =
        l$getPopularPrizes.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getPopularPrizes = getPopularPrizes;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$getPopularPrizes.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetPopularPrizes) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$getPopularPrizes = getPopularPrizes;
    final lOther$getPopularPrizes = other.getPopularPrizes;
    if (l$getPopularPrizes.length != lOther$getPopularPrizes.length) {
      return false;
    }
    for (int i = 0; i < l$getPopularPrizes.length; i++) {
      final l$getPopularPrizes$entry = l$getPopularPrizes[i];
      final lOther$getPopularPrizes$entry = lOther$getPopularPrizes[i];
      if (l$getPopularPrizes$entry != lOther$getPopularPrizes$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetPopularPrizes on Query$GetPopularPrizes {
  CopyWith$Query$GetPopularPrizes<Query$GetPopularPrizes> get copyWith =>
      CopyWith$Query$GetPopularPrizes(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetPopularPrizes<TRes> {
  factory CopyWith$Query$GetPopularPrizes(
    Query$GetPopularPrizes instance,
    TRes Function(Query$GetPopularPrizes) then,
  ) = _CopyWithImpl$Query$GetPopularPrizes;

  factory CopyWith$Query$GetPopularPrizes.stub(TRes res) =
      _CopyWithStubImpl$Query$GetPopularPrizes;

  TRes call({
    List<Query$GetPopularPrizes$getPopularPrizes>? getPopularPrizes,
    String? $__typename,
  });
  TRes getPopularPrizes(
      Iterable<Query$GetPopularPrizes$getPopularPrizes> Function(
              Iterable<
                  CopyWith$Query$GetPopularPrizes$getPopularPrizes<
                      Query$GetPopularPrizes$getPopularPrizes>>)
          _fn);
}

class _CopyWithImpl$Query$GetPopularPrizes<TRes>
    implements CopyWith$Query$GetPopularPrizes<TRes> {
  _CopyWithImpl$Query$GetPopularPrizes(
    this._instance,
    this._then,
  );

  final Query$GetPopularPrizes _instance;

  final TRes Function(Query$GetPopularPrizes) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getPopularPrizes = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetPopularPrizes(
        getPopularPrizes:
            getPopularPrizes == _undefined || getPopularPrizes == null
                ? _instance.getPopularPrizes
                : (getPopularPrizes
                    as List<Query$GetPopularPrizes$getPopularPrizes>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes getPopularPrizes(
          Iterable<Query$GetPopularPrizes$getPopularPrizes> Function(
                  Iterable<
                      CopyWith$Query$GetPopularPrizes$getPopularPrizes<
                          Query$GetPopularPrizes$getPopularPrizes>>)
              _fn) =>
      call(
          getPopularPrizes: _fn(_instance.getPopularPrizes
              .map((e) => CopyWith$Query$GetPopularPrizes$getPopularPrizes(
                    e,
                    (i) => i,
                  ))).toList());
}

class _CopyWithStubImpl$Query$GetPopularPrizes<TRes>
    implements CopyWith$Query$GetPopularPrizes<TRes> {
  _CopyWithStubImpl$Query$GetPopularPrizes(this._res);

  TRes _res;

  call({
    List<Query$GetPopularPrizes$getPopularPrizes>? getPopularPrizes,
    String? $__typename,
  }) =>
      _res;

  getPopularPrizes(_fn) => _res;
}

const documentNodeQueryGetPopularPrizes = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetPopularPrizes'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'getPopularPrizes'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'imgUrl'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'name'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'point'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$GetPopularPrizes _parserFn$Query$GetPopularPrizes(
        Map<String, dynamic> data) =>
    Query$GetPopularPrizes.fromJson(data);
typedef OnQueryComplete$Query$GetPopularPrizes = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$GetPopularPrizes?,
);

class Options$Query$GetPopularPrizes
    extends graphql.QueryOptions<Query$GetPopularPrizes> {
  Options$Query$GetPopularPrizes({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetPopularPrizes? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetPopularPrizes? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null
                        ? null
                        : _parserFn$Query$GetPopularPrizes(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetPopularPrizes,
          parserFn: _parserFn$Query$GetPopularPrizes,
        );

  final OnQueryComplete$Query$GetPopularPrizes? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetPopularPrizes
    extends graphql.WatchQueryOptions<Query$GetPopularPrizes> {
  WatchOptions$Query$GetPopularPrizes({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetPopularPrizes? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryGetPopularPrizes,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetPopularPrizes,
        );
}

class FetchMoreOptions$Query$GetPopularPrizes extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetPopularPrizes(
      {required graphql.UpdateQuery updateQuery})
      : super(
          updateQuery: updateQuery,
          document: documentNodeQueryGetPopularPrizes,
        );
}

extension ClientExtension$Query$GetPopularPrizes on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetPopularPrizes>> query$GetPopularPrizes(
          [Options$Query$GetPopularPrizes? options]) async =>
      await this.query(options ?? Options$Query$GetPopularPrizes());
  graphql.ObservableQuery<Query$GetPopularPrizes> watchQuery$GetPopularPrizes(
          [WatchOptions$Query$GetPopularPrizes? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$GetPopularPrizes());
  void writeQuery$GetPopularPrizes({
    required Query$GetPopularPrizes data,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
            operation:
                graphql.Operation(document: documentNodeQueryGetPopularPrizes)),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetPopularPrizes? readQuery$GetPopularPrizes({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
          operation:
              graphql.Operation(document: documentNodeQueryGetPopularPrizes)),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetPopularPrizes.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetPopularPrizes>
    useQuery$GetPopularPrizes([Options$Query$GetPopularPrizes? options]) =>
        graphql_flutter.useQuery(options ?? Options$Query$GetPopularPrizes());
graphql.ObservableQuery<Query$GetPopularPrizes> useWatchQuery$GetPopularPrizes(
        [WatchOptions$Query$GetPopularPrizes? options]) =>
    graphql_flutter
        .useWatchQuery(options ?? WatchOptions$Query$GetPopularPrizes());

class Query$GetPopularPrizes$Widget
    extends graphql_flutter.Query<Query$GetPopularPrizes> {
  Query$GetPopularPrizes$Widget({
    widgets.Key? key,
    Options$Query$GetPopularPrizes? options,
    required graphql_flutter.QueryBuilder<Query$GetPopularPrizes> builder,
  }) : super(
          key: key,
          options: options ?? Options$Query$GetPopularPrizes(),
          builder: builder,
        );
}

class Query$GetPopularPrizes$getPopularPrizes {
  Query$GetPopularPrizes$getPopularPrizes({
    required this.id,
    this.imgUrl,
    required this.name,
    required this.point,
    this.$__typename = 'PrizeData',
  });

  factory Query$GetPopularPrizes$getPopularPrizes.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$imgUrl = json['imgUrl'];
    final l$name = json['name'];
    final l$point = json['point'];
    final l$$__typename = json['__typename'];
    return Query$GetPopularPrizes$getPopularPrizes(
      id: (l$id as int),
      imgUrl: (l$imgUrl as String?),
      name: (l$name as String),
      point: (l$point as int),
      $__typename: (l$$__typename as String),
    );
  }

  final int id;

  final String? imgUrl;

  final String name;

  final int point;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$imgUrl = imgUrl;
    _resultData['imgUrl'] = l$imgUrl;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$point = point;
    _resultData['point'] = l$point;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$imgUrl = imgUrl;
    final l$name = name;
    final l$point = point;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$imgUrl,
      l$name,
      l$point,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetPopularPrizes$getPopularPrizes) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$imgUrl = imgUrl;
    final lOther$imgUrl = other.imgUrl;
    if (l$imgUrl != lOther$imgUrl) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$point = point;
    final lOther$point = other.point;
    if (l$point != lOther$point) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetPopularPrizes$getPopularPrizes
    on Query$GetPopularPrizes$getPopularPrizes {
  CopyWith$Query$GetPopularPrizes$getPopularPrizes<
          Query$GetPopularPrizes$getPopularPrizes>
      get copyWith => CopyWith$Query$GetPopularPrizes$getPopularPrizes(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetPopularPrizes$getPopularPrizes<TRes> {
  factory CopyWith$Query$GetPopularPrizes$getPopularPrizes(
    Query$GetPopularPrizes$getPopularPrizes instance,
    TRes Function(Query$GetPopularPrizes$getPopularPrizes) then,
  ) = _CopyWithImpl$Query$GetPopularPrizes$getPopularPrizes;

  factory CopyWith$Query$GetPopularPrizes$getPopularPrizes.stub(TRes res) =
      _CopyWithStubImpl$Query$GetPopularPrizes$getPopularPrizes;

  TRes call({
    int? id,
    String? imgUrl,
    String? name,
    int? point,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetPopularPrizes$getPopularPrizes<TRes>
    implements CopyWith$Query$GetPopularPrizes$getPopularPrizes<TRes> {
  _CopyWithImpl$Query$GetPopularPrizes$getPopularPrizes(
    this._instance,
    this._then,
  );

  final Query$GetPopularPrizes$getPopularPrizes _instance;

  final TRes Function(Query$GetPopularPrizes$getPopularPrizes) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? imgUrl = _undefined,
    Object? name = _undefined,
    Object? point = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetPopularPrizes$getPopularPrizes(
        id: id == _undefined || id == null ? _instance.id : (id as int),
        imgUrl: imgUrl == _undefined ? _instance.imgUrl : (imgUrl as String?),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        point: point == _undefined || point == null
            ? _instance.point
            : (point as int),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetPopularPrizes$getPopularPrizes<TRes>
    implements CopyWith$Query$GetPopularPrizes$getPopularPrizes<TRes> {
  _CopyWithStubImpl$Query$GetPopularPrizes$getPopularPrizes(this._res);

  TRes _res;

  call({
    int? id,
    String? imgUrl,
    String? name,
    int? point,
    String? $__typename,
  }) =>
      _res;
}

class Query$GetAllPrizes {
  Query$GetAllPrizes({
    required this.getAllPrizes,
    this.$__typename = 'QueryRoot',
  });

  factory Query$GetAllPrizes.fromJson(Map<String, dynamic> json) {
    final l$getAllPrizes = json['getAllPrizes'];
    final l$$__typename = json['__typename'];
    return Query$GetAllPrizes(
      getAllPrizes: (l$getAllPrizes as List<dynamic>)
          .map((e) => Query$GetAllPrizes$getAllPrizes.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$GetAllPrizes$getAllPrizes> getAllPrizes;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getAllPrizes = getAllPrizes;
    _resultData['getAllPrizes'] =
        l$getAllPrizes.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getAllPrizes = getAllPrizes;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$getAllPrizes.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetAllPrizes) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$getAllPrizes = getAllPrizes;
    final lOther$getAllPrizes = other.getAllPrizes;
    if (l$getAllPrizes.length != lOther$getAllPrizes.length) {
      return false;
    }
    for (int i = 0; i < l$getAllPrizes.length; i++) {
      final l$getAllPrizes$entry = l$getAllPrizes[i];
      final lOther$getAllPrizes$entry = lOther$getAllPrizes[i];
      if (l$getAllPrizes$entry != lOther$getAllPrizes$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetAllPrizes on Query$GetAllPrizes {
  CopyWith$Query$GetAllPrizes<Query$GetAllPrizes> get copyWith =>
      CopyWith$Query$GetAllPrizes(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetAllPrizes<TRes> {
  factory CopyWith$Query$GetAllPrizes(
    Query$GetAllPrizes instance,
    TRes Function(Query$GetAllPrizes) then,
  ) = _CopyWithImpl$Query$GetAllPrizes;

  factory CopyWith$Query$GetAllPrizes.stub(TRes res) =
      _CopyWithStubImpl$Query$GetAllPrizes;

  TRes call({
    List<Query$GetAllPrizes$getAllPrizes>? getAllPrizes,
    String? $__typename,
  });
  TRes getAllPrizes(
      Iterable<Query$GetAllPrizes$getAllPrizes> Function(
              Iterable<
                  CopyWith$Query$GetAllPrizes$getAllPrizes<
                      Query$GetAllPrizes$getAllPrizes>>)
          _fn);
}

class _CopyWithImpl$Query$GetAllPrizes<TRes>
    implements CopyWith$Query$GetAllPrizes<TRes> {
  _CopyWithImpl$Query$GetAllPrizes(
    this._instance,
    this._then,
  );

  final Query$GetAllPrizes _instance;

  final TRes Function(Query$GetAllPrizes) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getAllPrizes = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetAllPrizes(
        getAllPrizes: getAllPrizes == _undefined || getAllPrizes == null
            ? _instance.getAllPrizes
            : (getAllPrizes as List<Query$GetAllPrizes$getAllPrizes>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes getAllPrizes(
          Iterable<Query$GetAllPrizes$getAllPrizes> Function(
                  Iterable<
                      CopyWith$Query$GetAllPrizes$getAllPrizes<
                          Query$GetAllPrizes$getAllPrizes>>)
              _fn) =>
      call(
          getAllPrizes: _fn(_instance.getAllPrizes
              .map((e) => CopyWith$Query$GetAllPrizes$getAllPrizes(
                    e,
                    (i) => i,
                  ))).toList());
}

class _CopyWithStubImpl$Query$GetAllPrizes<TRes>
    implements CopyWith$Query$GetAllPrizes<TRes> {
  _CopyWithStubImpl$Query$GetAllPrizes(this._res);

  TRes _res;

  call({
    List<Query$GetAllPrizes$getAllPrizes>? getAllPrizes,
    String? $__typename,
  }) =>
      _res;

  getAllPrizes(_fn) => _res;
}

const documentNodeQueryGetAllPrizes = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetAllPrizes'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'getAllPrizes'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'imgUrl'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'name'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'point'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$GetAllPrizes _parserFn$Query$GetAllPrizes(Map<String, dynamic> data) =>
    Query$GetAllPrizes.fromJson(data);
typedef OnQueryComplete$Query$GetAllPrizes = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$GetAllPrizes?,
);

class Options$Query$GetAllPrizes
    extends graphql.QueryOptions<Query$GetAllPrizes> {
  Options$Query$GetAllPrizes({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetAllPrizes? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetAllPrizes? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null ? null : _parserFn$Query$GetAllPrizes(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetAllPrizes,
          parserFn: _parserFn$Query$GetAllPrizes,
        );

  final OnQueryComplete$Query$GetAllPrizes? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetAllPrizes
    extends graphql.WatchQueryOptions<Query$GetAllPrizes> {
  WatchOptions$Query$GetAllPrizes({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetAllPrizes? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryGetAllPrizes,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetAllPrizes,
        );
}

class FetchMoreOptions$Query$GetAllPrizes extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetAllPrizes(
      {required graphql.UpdateQuery updateQuery})
      : super(
          updateQuery: updateQuery,
          document: documentNodeQueryGetAllPrizes,
        );
}

extension ClientExtension$Query$GetAllPrizes on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetAllPrizes>> query$GetAllPrizes(
          [Options$Query$GetAllPrizes? options]) async =>
      await this.query(options ?? Options$Query$GetAllPrizes());
  graphql.ObservableQuery<Query$GetAllPrizes> watchQuery$GetAllPrizes(
          [WatchOptions$Query$GetAllPrizes? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$GetAllPrizes());
  void writeQuery$GetAllPrizes({
    required Query$GetAllPrizes data,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
            operation:
                graphql.Operation(document: documentNodeQueryGetAllPrizes)),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetAllPrizes? readQuery$GetAllPrizes({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
          operation:
              graphql.Operation(document: documentNodeQueryGetAllPrizes)),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetAllPrizes.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetAllPrizes> useQuery$GetAllPrizes(
        [Options$Query$GetAllPrizes? options]) =>
    graphql_flutter.useQuery(options ?? Options$Query$GetAllPrizes());
graphql.ObservableQuery<Query$GetAllPrizes> useWatchQuery$GetAllPrizes(
        [WatchOptions$Query$GetAllPrizes? options]) =>
    graphql_flutter.useWatchQuery(options ?? WatchOptions$Query$GetAllPrizes());

class Query$GetAllPrizes$Widget
    extends graphql_flutter.Query<Query$GetAllPrizes> {
  Query$GetAllPrizes$Widget({
    widgets.Key? key,
    Options$Query$GetAllPrizes? options,
    required graphql_flutter.QueryBuilder<Query$GetAllPrizes> builder,
  }) : super(
          key: key,
          options: options ?? Options$Query$GetAllPrizes(),
          builder: builder,
        );
}

class Query$GetAllPrizes$getAllPrizes {
  Query$GetAllPrizes$getAllPrizes({
    required this.id,
    this.imgUrl,
    required this.name,
    required this.point,
    this.$__typename = 'PrizeData',
  });

  factory Query$GetAllPrizes$getAllPrizes.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$imgUrl = json['imgUrl'];
    final l$name = json['name'];
    final l$point = json['point'];
    final l$$__typename = json['__typename'];
    return Query$GetAllPrizes$getAllPrizes(
      id: (l$id as int),
      imgUrl: (l$imgUrl as String?),
      name: (l$name as String),
      point: (l$point as int),
      $__typename: (l$$__typename as String),
    );
  }

  final int id;

  final String? imgUrl;

  final String name;

  final int point;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$imgUrl = imgUrl;
    _resultData['imgUrl'] = l$imgUrl;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$point = point;
    _resultData['point'] = l$point;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$imgUrl = imgUrl;
    final l$name = name;
    final l$point = point;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$imgUrl,
      l$name,
      l$point,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetAllPrizes$getAllPrizes) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$imgUrl = imgUrl;
    final lOther$imgUrl = other.imgUrl;
    if (l$imgUrl != lOther$imgUrl) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$point = point;
    final lOther$point = other.point;
    if (l$point != lOther$point) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetAllPrizes$getAllPrizes
    on Query$GetAllPrizes$getAllPrizes {
  CopyWith$Query$GetAllPrizes$getAllPrizes<Query$GetAllPrizes$getAllPrizes>
      get copyWith => CopyWith$Query$GetAllPrizes$getAllPrizes(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetAllPrizes$getAllPrizes<TRes> {
  factory CopyWith$Query$GetAllPrizes$getAllPrizes(
    Query$GetAllPrizes$getAllPrizes instance,
    TRes Function(Query$GetAllPrizes$getAllPrizes) then,
  ) = _CopyWithImpl$Query$GetAllPrizes$getAllPrizes;

  factory CopyWith$Query$GetAllPrizes$getAllPrizes.stub(TRes res) =
      _CopyWithStubImpl$Query$GetAllPrizes$getAllPrizes;

  TRes call({
    int? id,
    String? imgUrl,
    String? name,
    int? point,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetAllPrizes$getAllPrizes<TRes>
    implements CopyWith$Query$GetAllPrizes$getAllPrizes<TRes> {
  _CopyWithImpl$Query$GetAllPrizes$getAllPrizes(
    this._instance,
    this._then,
  );

  final Query$GetAllPrizes$getAllPrizes _instance;

  final TRes Function(Query$GetAllPrizes$getAllPrizes) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? imgUrl = _undefined,
    Object? name = _undefined,
    Object? point = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetAllPrizes$getAllPrizes(
        id: id == _undefined || id == null ? _instance.id : (id as int),
        imgUrl: imgUrl == _undefined ? _instance.imgUrl : (imgUrl as String?),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        point: point == _undefined || point == null
            ? _instance.point
            : (point as int),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetAllPrizes$getAllPrizes<TRes>
    implements CopyWith$Query$GetAllPrizes$getAllPrizes<TRes> {
  _CopyWithStubImpl$Query$GetAllPrizes$getAllPrizes(this._res);

  TRes _res;

  call({
    int? id,
    String? imgUrl,
    String? name,
    int? point,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Query$GetPrizeDetail {
  factory Variables$Query$GetPrizeDetail({required int prizeId}) =>
      Variables$Query$GetPrizeDetail._({
        r'prizeId': prizeId,
      });

  Variables$Query$GetPrizeDetail._(this._$data);

  factory Variables$Query$GetPrizeDetail.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$prizeId = data['prizeId'];
    result$data['prizeId'] = (l$prizeId as int);
    return Variables$Query$GetPrizeDetail._(result$data);
  }

  Map<String, dynamic> _$data;

  int get prizeId => (_$data['prizeId'] as int);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$prizeId = prizeId;
    result$data['prizeId'] = l$prizeId;
    return result$data;
  }

  CopyWith$Variables$Query$GetPrizeDetail<Variables$Query$GetPrizeDetail>
      get copyWith => CopyWith$Variables$Query$GetPrizeDetail(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$GetPrizeDetail) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$prizeId = prizeId;
    final lOther$prizeId = other.prizeId;
    if (l$prizeId != lOther$prizeId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$prizeId = prizeId;
    return Object.hashAll([l$prizeId]);
  }
}

abstract class CopyWith$Variables$Query$GetPrizeDetail<TRes> {
  factory CopyWith$Variables$Query$GetPrizeDetail(
    Variables$Query$GetPrizeDetail instance,
    TRes Function(Variables$Query$GetPrizeDetail) then,
  ) = _CopyWithImpl$Variables$Query$GetPrizeDetail;

  factory CopyWith$Variables$Query$GetPrizeDetail.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$GetPrizeDetail;

  TRes call({int? prizeId});
}

class _CopyWithImpl$Variables$Query$GetPrizeDetail<TRes>
    implements CopyWith$Variables$Query$GetPrizeDetail<TRes> {
  _CopyWithImpl$Variables$Query$GetPrizeDetail(
    this._instance,
    this._then,
  );

  final Variables$Query$GetPrizeDetail _instance;

  final TRes Function(Variables$Query$GetPrizeDetail) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? prizeId = _undefined}) =>
      _then(Variables$Query$GetPrizeDetail._({
        ..._instance._$data,
        if (prizeId != _undefined && prizeId != null)
          'prizeId': (prizeId as int),
      }));
}

class _CopyWithStubImpl$Variables$Query$GetPrizeDetail<TRes>
    implements CopyWith$Variables$Query$GetPrizeDetail<TRes> {
  _CopyWithStubImpl$Variables$Query$GetPrizeDetail(this._res);

  TRes _res;

  call({int? prizeId}) => _res;
}

class Query$GetPrizeDetail {
  Query$GetPrizeDetail({
    required this.getPrizeDetail,
    this.$__typename = 'QueryRoot',
  });

  factory Query$GetPrizeDetail.fromJson(Map<String, dynamic> json) {
    final l$getPrizeDetail = json['getPrizeDetail'];
    final l$$__typename = json['__typename'];
    return Query$GetPrizeDetail(
      getPrizeDetail: Query$GetPrizeDetail$getPrizeDetail.fromJson(
          (l$getPrizeDetail as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetPrizeDetail$getPrizeDetail getPrizeDetail;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getPrizeDetail = getPrizeDetail;
    _resultData['getPrizeDetail'] = l$getPrizeDetail.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getPrizeDetail = getPrizeDetail;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$getPrizeDetail,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetPrizeDetail) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$getPrizeDetail = getPrizeDetail;
    final lOther$getPrizeDetail = other.getPrizeDetail;
    if (l$getPrizeDetail != lOther$getPrizeDetail) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetPrizeDetail on Query$GetPrizeDetail {
  CopyWith$Query$GetPrizeDetail<Query$GetPrizeDetail> get copyWith =>
      CopyWith$Query$GetPrizeDetail(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetPrizeDetail<TRes> {
  factory CopyWith$Query$GetPrizeDetail(
    Query$GetPrizeDetail instance,
    TRes Function(Query$GetPrizeDetail) then,
  ) = _CopyWithImpl$Query$GetPrizeDetail;

  factory CopyWith$Query$GetPrizeDetail.stub(TRes res) =
      _CopyWithStubImpl$Query$GetPrizeDetail;

  TRes call({
    Query$GetPrizeDetail$getPrizeDetail? getPrizeDetail,
    String? $__typename,
  });
  CopyWith$Query$GetPrizeDetail$getPrizeDetail<TRes> get getPrizeDetail;
}

class _CopyWithImpl$Query$GetPrizeDetail<TRes>
    implements CopyWith$Query$GetPrizeDetail<TRes> {
  _CopyWithImpl$Query$GetPrizeDetail(
    this._instance,
    this._then,
  );

  final Query$GetPrizeDetail _instance;

  final TRes Function(Query$GetPrizeDetail) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getPrizeDetail = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetPrizeDetail(
        getPrizeDetail: getPrizeDetail == _undefined || getPrizeDetail == null
            ? _instance.getPrizeDetail
            : (getPrizeDetail as Query$GetPrizeDetail$getPrizeDetail),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetPrizeDetail$getPrizeDetail<TRes> get getPrizeDetail {
    final local$getPrizeDetail = _instance.getPrizeDetail;
    return CopyWith$Query$GetPrizeDetail$getPrizeDetail(
        local$getPrizeDetail, (e) => call(getPrizeDetail: e));
  }
}

class _CopyWithStubImpl$Query$GetPrizeDetail<TRes>
    implements CopyWith$Query$GetPrizeDetail<TRes> {
  _CopyWithStubImpl$Query$GetPrizeDetail(this._res);

  TRes _res;

  call({
    Query$GetPrizeDetail$getPrizeDetail? getPrizeDetail,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetPrizeDetail$getPrizeDetail<TRes> get getPrizeDetail =>
      CopyWith$Query$GetPrizeDetail$getPrizeDetail.stub(_res);
}

const documentNodeQueryGetPrizeDetail = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetPrizeDetail'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'prizeId')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'getPrizeDetail'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'prizeId'),
            value: VariableNode(name: NameNode(value: 'prizeId')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'imgUrl'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'name'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'point'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'description'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'representation'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'condition'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$GetPrizeDetail _parserFn$Query$GetPrizeDetail(
        Map<String, dynamic> data) =>
    Query$GetPrizeDetail.fromJson(data);
typedef OnQueryComplete$Query$GetPrizeDetail = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$GetPrizeDetail?,
);

class Options$Query$GetPrizeDetail
    extends graphql.QueryOptions<Query$GetPrizeDetail> {
  Options$Query$GetPrizeDetail({
    String? operationName,
    required Variables$Query$GetPrizeDetail variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetPrizeDetail? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetPrizeDetail? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null ? null : _parserFn$Query$GetPrizeDetail(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetPrizeDetail,
          parserFn: _parserFn$Query$GetPrizeDetail,
        );

  final OnQueryComplete$Query$GetPrizeDetail? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetPrizeDetail
    extends graphql.WatchQueryOptions<Query$GetPrizeDetail> {
  WatchOptions$Query$GetPrizeDetail({
    String? operationName,
    required Variables$Query$GetPrizeDetail variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetPrizeDetail? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryGetPrizeDetail,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetPrizeDetail,
        );
}

class FetchMoreOptions$Query$GetPrizeDetail extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetPrizeDetail({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$GetPrizeDetail variables,
  }) : super(
          updateQuery: updateQuery,
          variables: variables.toJson(),
          document: documentNodeQueryGetPrizeDetail,
        );
}

extension ClientExtension$Query$GetPrizeDetail on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetPrizeDetail>> query$GetPrizeDetail(
          Options$Query$GetPrizeDetail options) async =>
      await this.query(options);
  graphql.ObservableQuery<Query$GetPrizeDetail> watchQuery$GetPrizeDetail(
          WatchOptions$Query$GetPrizeDetail options) =>
      this.watchQuery(options);
  void writeQuery$GetPrizeDetail({
    required Query$GetPrizeDetail data,
    required Variables$Query$GetPrizeDetail variables,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
          operation:
              graphql.Operation(document: documentNodeQueryGetPrizeDetail),
          variables: variables.toJson(),
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetPrizeDetail? readQuery$GetPrizeDetail({
    required Variables$Query$GetPrizeDetail variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryGetPrizeDetail),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetPrizeDetail.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetPrizeDetail> useQuery$GetPrizeDetail(
        Options$Query$GetPrizeDetail options) =>
    graphql_flutter.useQuery(options);
graphql.ObservableQuery<Query$GetPrizeDetail> useWatchQuery$GetPrizeDetail(
        WatchOptions$Query$GetPrizeDetail options) =>
    graphql_flutter.useWatchQuery(options);

class Query$GetPrizeDetail$Widget
    extends graphql_flutter.Query<Query$GetPrizeDetail> {
  Query$GetPrizeDetail$Widget({
    widgets.Key? key,
    required Options$Query$GetPrizeDetail options,
    required graphql_flutter.QueryBuilder<Query$GetPrizeDetail> builder,
  }) : super(
          key: key,
          options: options,
          builder: builder,
        );
}

class Query$GetPrizeDetail$getPrizeDetail {
  Query$GetPrizeDetail$getPrizeDetail({
    required this.id,
    this.imgUrl,
    required this.name,
    required this.point,
    required this.description,
    required this.representation,
    this.condition,
    this.$__typename = 'PrizeDetailData',
  });

  factory Query$GetPrizeDetail$getPrizeDetail.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$imgUrl = json['imgUrl'];
    final l$name = json['name'];
    final l$point = json['point'];
    final l$description = json['description'];
    final l$representation = json['representation'];
    final l$condition = json['condition'];
    final l$$__typename = json['__typename'];
    return Query$GetPrizeDetail$getPrizeDetail(
      id: (l$id as int),
      imgUrl: (l$imgUrl as String?),
      name: (l$name as String),
      point: (l$point as int),
      description: (l$description as String),
      representation: (l$representation as String),
      condition: (l$condition as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final int id;

  final String? imgUrl;

  final String name;

  final int point;

  final String description;

  final String representation;

  final String? condition;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$imgUrl = imgUrl;
    _resultData['imgUrl'] = l$imgUrl;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$point = point;
    _resultData['point'] = l$point;
    final l$description = description;
    _resultData['description'] = l$description;
    final l$representation = representation;
    _resultData['representation'] = l$representation;
    final l$condition = condition;
    _resultData['condition'] = l$condition;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$imgUrl = imgUrl;
    final l$name = name;
    final l$point = point;
    final l$description = description;
    final l$representation = representation;
    final l$condition = condition;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$imgUrl,
      l$name,
      l$point,
      l$description,
      l$representation,
      l$condition,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetPrizeDetail$getPrizeDetail) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$imgUrl = imgUrl;
    final lOther$imgUrl = other.imgUrl;
    if (l$imgUrl != lOther$imgUrl) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$point = point;
    final lOther$point = other.point;
    if (l$point != lOther$point) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    final l$representation = representation;
    final lOther$representation = other.representation;
    if (l$representation != lOther$representation) {
      return false;
    }
    final l$condition = condition;
    final lOther$condition = other.condition;
    if (l$condition != lOther$condition) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetPrizeDetail$getPrizeDetail
    on Query$GetPrizeDetail$getPrizeDetail {
  CopyWith$Query$GetPrizeDetail$getPrizeDetail<
          Query$GetPrizeDetail$getPrizeDetail>
      get copyWith => CopyWith$Query$GetPrizeDetail$getPrizeDetail(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetPrizeDetail$getPrizeDetail<TRes> {
  factory CopyWith$Query$GetPrizeDetail$getPrizeDetail(
    Query$GetPrizeDetail$getPrizeDetail instance,
    TRes Function(Query$GetPrizeDetail$getPrizeDetail) then,
  ) = _CopyWithImpl$Query$GetPrizeDetail$getPrizeDetail;

  factory CopyWith$Query$GetPrizeDetail$getPrizeDetail.stub(TRes res) =
      _CopyWithStubImpl$Query$GetPrizeDetail$getPrizeDetail;

  TRes call({
    int? id,
    String? imgUrl,
    String? name,
    int? point,
    String? description,
    String? representation,
    String? condition,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetPrizeDetail$getPrizeDetail<TRes>
    implements CopyWith$Query$GetPrizeDetail$getPrizeDetail<TRes> {
  _CopyWithImpl$Query$GetPrizeDetail$getPrizeDetail(
    this._instance,
    this._then,
  );

  final Query$GetPrizeDetail$getPrizeDetail _instance;

  final TRes Function(Query$GetPrizeDetail$getPrizeDetail) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? imgUrl = _undefined,
    Object? name = _undefined,
    Object? point = _undefined,
    Object? description = _undefined,
    Object? representation = _undefined,
    Object? condition = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetPrizeDetail$getPrizeDetail(
        id: id == _undefined || id == null ? _instance.id : (id as int),
        imgUrl: imgUrl == _undefined ? _instance.imgUrl : (imgUrl as String?),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        point: point == _undefined || point == null
            ? _instance.point
            : (point as int),
        description: description == _undefined || description == null
            ? _instance.description
            : (description as String),
        representation: representation == _undefined || representation == null
            ? _instance.representation
            : (representation as String),
        condition: condition == _undefined
            ? _instance.condition
            : (condition as String?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetPrizeDetail$getPrizeDetail<TRes>
    implements CopyWith$Query$GetPrizeDetail$getPrizeDetail<TRes> {
  _CopyWithStubImpl$Query$GetPrizeDetail$getPrizeDetail(this._res);

  TRes _res;

  call({
    int? id,
    String? imgUrl,
    String? name,
    int? point,
    String? description,
    String? representation,
    String? condition,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Query$GetFspHistory {
  factory Variables$Query$GetFspHistory({
    required String userId,
    required int count,
  }) =>
      Variables$Query$GetFspHistory._({
        r'userId': userId,
        r'count': count,
      });

  Variables$Query$GetFspHistory._(this._$data);

  factory Variables$Query$GetFspHistory.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    final l$count = data['count'];
    result$data['count'] = (l$count as int);
    return Variables$Query$GetFspHistory._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  int get count => (_$data['count'] as int);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$userId = userId;
    result$data['userId'] = l$userId;
    final l$count = count;
    result$data['count'] = l$count;
    return result$data;
  }

  CopyWith$Variables$Query$GetFspHistory<Variables$Query$GetFspHistory>
      get copyWith => CopyWith$Variables$Query$GetFspHistory(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$GetFspHistory) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$count = count;
    final lOther$count = other.count;
    if (l$count != lOther$count) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$count = count;
    return Object.hashAll([
      l$userId,
      l$count,
    ]);
  }
}

abstract class CopyWith$Variables$Query$GetFspHistory<TRes> {
  factory CopyWith$Variables$Query$GetFspHistory(
    Variables$Query$GetFspHistory instance,
    TRes Function(Variables$Query$GetFspHistory) then,
  ) = _CopyWithImpl$Variables$Query$GetFspHistory;

  factory CopyWith$Variables$Query$GetFspHistory.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$GetFspHistory;

  TRes call({
    String? userId,
    int? count,
  });
}

class _CopyWithImpl$Variables$Query$GetFspHistory<TRes>
    implements CopyWith$Variables$Query$GetFspHistory<TRes> {
  _CopyWithImpl$Variables$Query$GetFspHistory(
    this._instance,
    this._then,
  );

  final Variables$Query$GetFspHistory _instance;

  final TRes Function(Variables$Query$GetFspHistory) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? userId = _undefined,
    Object? count = _undefined,
  }) =>
      _then(Variables$Query$GetFspHistory._({
        ..._instance._$data,
        if (userId != _undefined && userId != null)
          'userId': (userId as String),
        if (count != _undefined && count != null) 'count': (count as int),
      }));
}

class _CopyWithStubImpl$Variables$Query$GetFspHistory<TRes>
    implements CopyWith$Variables$Query$GetFspHistory<TRes> {
  _CopyWithStubImpl$Variables$Query$GetFspHistory(this._res);

  TRes _res;

  call({
    String? userId,
    int? count,
  }) =>
      _res;
}

class Query$GetFspHistory {
  Query$GetFspHistory({
    required this.getFspHistory,
    this.$__typename = 'QueryRoot',
  });

  factory Query$GetFspHistory.fromJson(Map<String, dynamic> json) {
    final l$getFspHistory = json['getFspHistory'];
    final l$$__typename = json['__typename'];
    return Query$GetFspHistory(
      getFspHistory: Query$GetFspHistory$getFspHistory.fromJson(
          (l$getFspHistory as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetFspHistory$getFspHistory getFspHistory;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getFspHistory = getFspHistory;
    _resultData['getFspHistory'] = l$getFspHistory.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getFspHistory = getFspHistory;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$getFspHistory,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetFspHistory) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$getFspHistory = getFspHistory;
    final lOther$getFspHistory = other.getFspHistory;
    if (l$getFspHistory != lOther$getFspHistory) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetFspHistory on Query$GetFspHistory {
  CopyWith$Query$GetFspHistory<Query$GetFspHistory> get copyWith =>
      CopyWith$Query$GetFspHistory(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetFspHistory<TRes> {
  factory CopyWith$Query$GetFspHistory(
    Query$GetFspHistory instance,
    TRes Function(Query$GetFspHistory) then,
  ) = _CopyWithImpl$Query$GetFspHistory;

  factory CopyWith$Query$GetFspHistory.stub(TRes res) =
      _CopyWithStubImpl$Query$GetFspHistory;

  TRes call({
    Query$GetFspHistory$getFspHistory? getFspHistory,
    String? $__typename,
  });
  CopyWith$Query$GetFspHistory$getFspHistory<TRes> get getFspHistory;
}

class _CopyWithImpl$Query$GetFspHistory<TRes>
    implements CopyWith$Query$GetFspHistory<TRes> {
  _CopyWithImpl$Query$GetFspHistory(
    this._instance,
    this._then,
  );

  final Query$GetFspHistory _instance;

  final TRes Function(Query$GetFspHistory) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getFspHistory = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetFspHistory(
        getFspHistory: getFspHistory == _undefined || getFspHistory == null
            ? _instance.getFspHistory
            : (getFspHistory as Query$GetFspHistory$getFspHistory),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetFspHistory$getFspHistory<TRes> get getFspHistory {
    final local$getFspHistory = _instance.getFspHistory;
    return CopyWith$Query$GetFspHistory$getFspHistory(
        local$getFspHistory, (e) => call(getFspHistory: e));
  }
}

class _CopyWithStubImpl$Query$GetFspHistory<TRes>
    implements CopyWith$Query$GetFspHistory<TRes> {
  _CopyWithStubImpl$Query$GetFspHistory(this._res);

  TRes _res;

  call({
    Query$GetFspHistory$getFspHistory? getFspHistory,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetFspHistory$getFspHistory<TRes> get getFspHistory =>
      CopyWith$Query$GetFspHistory$getFspHistory.stub(_res);
}

const documentNodeQueryGetFspHistory = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetFspHistory'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'userId')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'count')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'getFspHistory'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'userId'),
            value: VariableNode(name: NameNode(value: 'userId')),
          ),
          ArgumentNode(
            name: NameNode(value: 'count'),
            value: VariableNode(name: NameNode(value: 'count')),
          ),
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'transactionList'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'from'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: SelectionSetNode(selections: [
                  FieldNode(
                    name: NameNode(value: 'id'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'name'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'imageUrl'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: '__typename'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                ]),
              ),
              FieldNode(
                name: NameNode(value: 'to'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: SelectionSetNode(selections: [
                  FieldNode(
                    name: NameNode(value: 'id'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'name'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'imageUrl'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: '__typename'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                ]),
              ),
              FieldNode(
                name: NameNode(value: 'amount'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'txAt'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$GetFspHistory _parserFn$Query$GetFspHistory(Map<String, dynamic> data) =>
    Query$GetFspHistory.fromJson(data);
typedef OnQueryComplete$Query$GetFspHistory = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$GetFspHistory?,
);

class Options$Query$GetFspHistory
    extends graphql.QueryOptions<Query$GetFspHistory> {
  Options$Query$GetFspHistory({
    String? operationName,
    required Variables$Query$GetFspHistory variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetFspHistory? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetFspHistory? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null ? null : _parserFn$Query$GetFspHistory(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetFspHistory,
          parserFn: _parserFn$Query$GetFspHistory,
        );

  final OnQueryComplete$Query$GetFspHistory? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetFspHistory
    extends graphql.WatchQueryOptions<Query$GetFspHistory> {
  WatchOptions$Query$GetFspHistory({
    String? operationName,
    required Variables$Query$GetFspHistory variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetFspHistory? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryGetFspHistory,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetFspHistory,
        );
}

class FetchMoreOptions$Query$GetFspHistory extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetFspHistory({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$GetFspHistory variables,
  }) : super(
          updateQuery: updateQuery,
          variables: variables.toJson(),
          document: documentNodeQueryGetFspHistory,
        );
}

extension ClientExtension$Query$GetFspHistory on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetFspHistory>> query$GetFspHistory(
          Options$Query$GetFspHistory options) async =>
      await this.query(options);
  graphql.ObservableQuery<Query$GetFspHistory> watchQuery$GetFspHistory(
          WatchOptions$Query$GetFspHistory options) =>
      this.watchQuery(options);
  void writeQuery$GetFspHistory({
    required Query$GetFspHistory data,
    required Variables$Query$GetFspHistory variables,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
          operation:
              graphql.Operation(document: documentNodeQueryGetFspHistory),
          variables: variables.toJson(),
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetFspHistory? readQuery$GetFspHistory({
    required Variables$Query$GetFspHistory variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryGetFspHistory),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetFspHistory.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetFspHistory> useQuery$GetFspHistory(
        Options$Query$GetFspHistory options) =>
    graphql_flutter.useQuery(options);
graphql.ObservableQuery<Query$GetFspHistory> useWatchQuery$GetFspHistory(
        WatchOptions$Query$GetFspHistory options) =>
    graphql_flutter.useWatchQuery(options);

class Query$GetFspHistory$Widget
    extends graphql_flutter.Query<Query$GetFspHistory> {
  Query$GetFspHistory$Widget({
    widgets.Key? key,
    required Options$Query$GetFspHistory options,
    required graphql_flutter.QueryBuilder<Query$GetFspHistory> builder,
  }) : super(
          key: key,
          options: options,
          builder: builder,
        );
}

class Query$GetFspHistory$getFspHistory {
  Query$GetFspHistory$getFspHistory({
    required this.transactionList,
    this.$__typename = 'TransactionsData',
  });

  factory Query$GetFspHistory$getFspHistory.fromJson(
      Map<String, dynamic> json) {
    final l$transactionList = json['transactionList'];
    final l$$__typename = json['__typename'];
    return Query$GetFspHistory$getFspHistory(
      transactionList: (l$transactionList as List<dynamic>)
          .map((e) =>
              Query$GetFspHistory$getFspHistory$transactionList.fromJson(
                  (e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$GetFspHistory$getFspHistory$transactionList> transactionList;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$transactionList = transactionList;
    _resultData['transactionList'] =
        l$transactionList.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$transactionList = transactionList;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$transactionList.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetFspHistory$getFspHistory) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$transactionList = transactionList;
    final lOther$transactionList = other.transactionList;
    if (l$transactionList.length != lOther$transactionList.length) {
      return false;
    }
    for (int i = 0; i < l$transactionList.length; i++) {
      final l$transactionList$entry = l$transactionList[i];
      final lOther$transactionList$entry = lOther$transactionList[i];
      if (l$transactionList$entry != lOther$transactionList$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetFspHistory$getFspHistory
    on Query$GetFspHistory$getFspHistory {
  CopyWith$Query$GetFspHistory$getFspHistory<Query$GetFspHistory$getFspHistory>
      get copyWith => CopyWith$Query$GetFspHistory$getFspHistory(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetFspHistory$getFspHistory<TRes> {
  factory CopyWith$Query$GetFspHistory$getFspHistory(
    Query$GetFspHistory$getFspHistory instance,
    TRes Function(Query$GetFspHistory$getFspHistory) then,
  ) = _CopyWithImpl$Query$GetFspHistory$getFspHistory;

  factory CopyWith$Query$GetFspHistory$getFspHistory.stub(TRes res) =
      _CopyWithStubImpl$Query$GetFspHistory$getFspHistory;

  TRes call({
    List<Query$GetFspHistory$getFspHistory$transactionList>? transactionList,
    String? $__typename,
  });
  TRes transactionList(
      Iterable<Query$GetFspHistory$getFspHistory$transactionList> Function(
              Iterable<
                  CopyWith$Query$GetFspHistory$getFspHistory$transactionList<
                      Query$GetFspHistory$getFspHistory$transactionList>>)
          _fn);
}

class _CopyWithImpl$Query$GetFspHistory$getFspHistory<TRes>
    implements CopyWith$Query$GetFspHistory$getFspHistory<TRes> {
  _CopyWithImpl$Query$GetFspHistory$getFspHistory(
    this._instance,
    this._then,
  );

  final Query$GetFspHistory$getFspHistory _instance;

  final TRes Function(Query$GetFspHistory$getFspHistory) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? transactionList = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetFspHistory$getFspHistory(
        transactionList:
            transactionList == _undefined || transactionList == null
                ? _instance.transactionList
                : (transactionList
                    as List<Query$GetFspHistory$getFspHistory$transactionList>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes transactionList(
          Iterable<Query$GetFspHistory$getFspHistory$transactionList> Function(
                  Iterable<
                      CopyWith$Query$GetFspHistory$getFspHistory$transactionList<
                          Query$GetFspHistory$getFspHistory$transactionList>>)
              _fn) =>
      call(
          transactionList: _fn(_instance.transactionList.map(
              (e) => CopyWith$Query$GetFspHistory$getFspHistory$transactionList(
                    e,
                    (i) => i,
                  ))).toList());
}

class _CopyWithStubImpl$Query$GetFspHistory$getFspHistory<TRes>
    implements CopyWith$Query$GetFspHistory$getFspHistory<TRes> {
  _CopyWithStubImpl$Query$GetFspHistory$getFspHistory(this._res);

  TRes _res;

  call({
    List<Query$GetFspHistory$getFspHistory$transactionList>? transactionList,
    String? $__typename,
  }) =>
      _res;

  transactionList(_fn) => _res;
}

class Query$GetFspHistory$getFspHistory$transactionList {
  Query$GetFspHistory$getFspHistory$transactionList({
    required this.id,
    this.from,
    this.to,
    required this.amount,
    required this.txAt,
    this.$__typename = 'TransactionData',
  });

  factory Query$GetFspHistory$getFspHistory$transactionList.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$from = json['from'];
    final l$to = json['to'];
    final l$amount = json['amount'];
    final l$txAt = json['txAt'];
    final l$$__typename = json['__typename'];
    return Query$GetFspHistory$getFspHistory$transactionList(
      id: (l$id as String),
      from: l$from == null
          ? null
          : Query$GetFspHistory$getFspHistory$transactionList$from.fromJson(
              (l$from as Map<String, dynamic>)),
      to: l$to == null
          ? null
          : Query$GetFspHistory$getFspHistory$transactionList$to.fromJson(
              (l$to as Map<String, dynamic>)),
      amount: (l$amount as int),
      txAt: (l$txAt as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final Query$GetFspHistory$getFspHistory$transactionList$from? from;

  final Query$GetFspHistory$getFspHistory$transactionList$to? to;

  final int amount;

  final String txAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$from = from;
    _resultData['from'] = l$from?.toJson();
    final l$to = to;
    _resultData['to'] = l$to?.toJson();
    final l$amount = amount;
    _resultData['amount'] = l$amount;
    final l$txAt = txAt;
    _resultData['txAt'] = l$txAt;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$from = from;
    final l$to = to;
    final l$amount = amount;
    final l$txAt = txAt;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$from,
      l$to,
      l$amount,
      l$txAt,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetFspHistory$getFspHistory$transactionList) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$from = from;
    final lOther$from = other.from;
    if (l$from != lOther$from) {
      return false;
    }
    final l$to = to;
    final lOther$to = other.to;
    if (l$to != lOther$to) {
      return false;
    }
    final l$amount = amount;
    final lOther$amount = other.amount;
    if (l$amount != lOther$amount) {
      return false;
    }
    final l$txAt = txAt;
    final lOther$txAt = other.txAt;
    if (l$txAt != lOther$txAt) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetFspHistory$getFspHistory$transactionList
    on Query$GetFspHistory$getFspHistory$transactionList {
  CopyWith$Query$GetFspHistory$getFspHistory$transactionList<
          Query$GetFspHistory$getFspHistory$transactionList>
      get copyWith =>
          CopyWith$Query$GetFspHistory$getFspHistory$transactionList(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetFspHistory$getFspHistory$transactionList<
    TRes> {
  factory CopyWith$Query$GetFspHistory$getFspHistory$transactionList(
    Query$GetFspHistory$getFspHistory$transactionList instance,
    TRes Function(Query$GetFspHistory$getFspHistory$transactionList) then,
  ) = _CopyWithImpl$Query$GetFspHistory$getFspHistory$transactionList;

  factory CopyWith$Query$GetFspHistory$getFspHistory$transactionList.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetFspHistory$getFspHistory$transactionList;

  TRes call({
    String? id,
    Query$GetFspHistory$getFspHistory$transactionList$from? from,
    Query$GetFspHistory$getFspHistory$transactionList$to? to,
    int? amount,
    String? txAt,
    String? $__typename,
  });
  CopyWith$Query$GetFspHistory$getFspHistory$transactionList$from<TRes>
      get from;
  CopyWith$Query$GetFspHistory$getFspHistory$transactionList$to<TRes> get to;
}

class _CopyWithImpl$Query$GetFspHistory$getFspHistory$transactionList<TRes>
    implements
        CopyWith$Query$GetFspHistory$getFspHistory$transactionList<TRes> {
  _CopyWithImpl$Query$GetFspHistory$getFspHistory$transactionList(
    this._instance,
    this._then,
  );

  final Query$GetFspHistory$getFspHistory$transactionList _instance;

  final TRes Function(Query$GetFspHistory$getFspHistory$transactionList) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? from = _undefined,
    Object? to = _undefined,
    Object? amount = _undefined,
    Object? txAt = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetFspHistory$getFspHistory$transactionList(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        from: from == _undefined
            ? _instance.from
            : (from as Query$GetFspHistory$getFspHistory$transactionList$from?),
        to: to == _undefined
            ? _instance.to
            : (to as Query$GetFspHistory$getFspHistory$transactionList$to?),
        amount: amount == _undefined || amount == null
            ? _instance.amount
            : (amount as int),
        txAt: txAt == _undefined || txAt == null
            ? _instance.txAt
            : (txAt as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetFspHistory$getFspHistory$transactionList$from<TRes>
      get from {
    final local$from = _instance.from;
    return local$from == null
        ? CopyWith$Query$GetFspHistory$getFspHistory$transactionList$from.stub(
            _then(_instance))
        : CopyWith$Query$GetFspHistory$getFspHistory$transactionList$from(
            local$from, (e) => call(from: e));
  }

  CopyWith$Query$GetFspHistory$getFspHistory$transactionList$to<TRes> get to {
    final local$to = _instance.to;
    return local$to == null
        ? CopyWith$Query$GetFspHistory$getFspHistory$transactionList$to.stub(
            _then(_instance))
        : CopyWith$Query$GetFspHistory$getFspHistory$transactionList$to(
            local$to, (e) => call(to: e));
  }
}

class _CopyWithStubImpl$Query$GetFspHistory$getFspHistory$transactionList<TRes>
    implements
        CopyWith$Query$GetFspHistory$getFspHistory$transactionList<TRes> {
  _CopyWithStubImpl$Query$GetFspHistory$getFspHistory$transactionList(
      this._res);

  TRes _res;

  call({
    String? id,
    Query$GetFspHistory$getFspHistory$transactionList$from? from,
    Query$GetFspHistory$getFspHistory$transactionList$to? to,
    int? amount,
    String? txAt,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetFspHistory$getFspHistory$transactionList$from<TRes>
      get from =>
          CopyWith$Query$GetFspHistory$getFspHistory$transactionList$from.stub(
              _res);

  CopyWith$Query$GetFspHistory$getFspHistory$transactionList$to<TRes> get to =>
      CopyWith$Query$GetFspHistory$getFspHistory$transactionList$to.stub(_res);
}

class Query$GetFspHistory$getFspHistory$transactionList$from {
  Query$GetFspHistory$getFspHistory$transactionList$from({
    required this.id,
    required this.name,
    this.imageUrl,
    this.$__typename = 'UserSimpleData',
  });

  factory Query$GetFspHistory$getFspHistory$transactionList$from.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$imageUrl = json['imageUrl'];
    final l$$__typename = json['__typename'];
    return Query$GetFspHistory$getFspHistory$transactionList$from(
      id: (l$id as String),
      name: (l$name as String),
      imageUrl: (l$imageUrl as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String name;

  final String? imageUrl;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$imageUrl = imageUrl;
    _resultData['imageUrl'] = l$imageUrl;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$imageUrl = imageUrl;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$name,
      l$imageUrl,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetFspHistory$getFspHistory$transactionList$from) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$imageUrl = imageUrl;
    final lOther$imageUrl = other.imageUrl;
    if (l$imageUrl != lOther$imageUrl) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetFspHistory$getFspHistory$transactionList$from
    on Query$GetFspHistory$getFspHistory$transactionList$from {
  CopyWith$Query$GetFspHistory$getFspHistory$transactionList$from<
          Query$GetFspHistory$getFspHistory$transactionList$from>
      get copyWith =>
          CopyWith$Query$GetFspHistory$getFspHistory$transactionList$from(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetFspHistory$getFspHistory$transactionList$from<
    TRes> {
  factory CopyWith$Query$GetFspHistory$getFspHistory$transactionList$from(
    Query$GetFspHistory$getFspHistory$transactionList$from instance,
    TRes Function(Query$GetFspHistory$getFspHistory$transactionList$from) then,
  ) = _CopyWithImpl$Query$GetFspHistory$getFspHistory$transactionList$from;

  factory CopyWith$Query$GetFspHistory$getFspHistory$transactionList$from.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetFspHistory$getFspHistory$transactionList$from;

  TRes call({
    String? id,
    String? name,
    String? imageUrl,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetFspHistory$getFspHistory$transactionList$from<TRes>
    implements
        CopyWith$Query$GetFspHistory$getFspHistory$transactionList$from<TRes> {
  _CopyWithImpl$Query$GetFspHistory$getFspHistory$transactionList$from(
    this._instance,
    this._then,
  );

  final Query$GetFspHistory$getFspHistory$transactionList$from _instance;

  final TRes Function(Query$GetFspHistory$getFspHistory$transactionList$from)
      _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? imageUrl = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetFspHistory$getFspHistory$transactionList$from(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        imageUrl:
            imageUrl == _undefined ? _instance.imageUrl : (imageUrl as String?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetFspHistory$getFspHistory$transactionList$from<
        TRes>
    implements
        CopyWith$Query$GetFspHistory$getFspHistory$transactionList$from<TRes> {
  _CopyWithStubImpl$Query$GetFspHistory$getFspHistory$transactionList$from(
      this._res);

  TRes _res;

  call({
    String? id,
    String? name,
    String? imageUrl,
    String? $__typename,
  }) =>
      _res;
}

class Query$GetFspHistory$getFspHistory$transactionList$to {
  Query$GetFspHistory$getFspHistory$transactionList$to({
    required this.id,
    required this.name,
    this.imageUrl,
    this.$__typename = 'UserSimpleData',
  });

  factory Query$GetFspHistory$getFspHistory$transactionList$to.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$imageUrl = json['imageUrl'];
    final l$$__typename = json['__typename'];
    return Query$GetFspHistory$getFspHistory$transactionList$to(
      id: (l$id as String),
      name: (l$name as String),
      imageUrl: (l$imageUrl as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String name;

  final String? imageUrl;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$imageUrl = imageUrl;
    _resultData['imageUrl'] = l$imageUrl;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$imageUrl = imageUrl;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$name,
      l$imageUrl,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetFspHistory$getFspHistory$transactionList$to) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$imageUrl = imageUrl;
    final lOther$imageUrl = other.imageUrl;
    if (l$imageUrl != lOther$imageUrl) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetFspHistory$getFspHistory$transactionList$to
    on Query$GetFspHistory$getFspHistory$transactionList$to {
  CopyWith$Query$GetFspHistory$getFspHistory$transactionList$to<
          Query$GetFspHistory$getFspHistory$transactionList$to>
      get copyWith =>
          CopyWith$Query$GetFspHistory$getFspHistory$transactionList$to(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetFspHistory$getFspHistory$transactionList$to<
    TRes> {
  factory CopyWith$Query$GetFspHistory$getFspHistory$transactionList$to(
    Query$GetFspHistory$getFspHistory$transactionList$to instance,
    TRes Function(Query$GetFspHistory$getFspHistory$transactionList$to) then,
  ) = _CopyWithImpl$Query$GetFspHistory$getFspHistory$transactionList$to;

  factory CopyWith$Query$GetFspHistory$getFspHistory$transactionList$to.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetFspHistory$getFspHistory$transactionList$to;

  TRes call({
    String? id,
    String? name,
    String? imageUrl,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetFspHistory$getFspHistory$transactionList$to<TRes>
    implements
        CopyWith$Query$GetFspHistory$getFspHistory$transactionList$to<TRes> {
  _CopyWithImpl$Query$GetFspHistory$getFspHistory$transactionList$to(
    this._instance,
    this._then,
  );

  final Query$GetFspHistory$getFspHistory$transactionList$to _instance;

  final TRes Function(Query$GetFspHistory$getFspHistory$transactionList$to)
      _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? imageUrl = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetFspHistory$getFspHistory$transactionList$to(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        imageUrl:
            imageUrl == _undefined ? _instance.imageUrl : (imageUrl as String?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetFspHistory$getFspHistory$transactionList$to<
        TRes>
    implements
        CopyWith$Query$GetFspHistory$getFspHistory$transactionList$to<TRes> {
  _CopyWithStubImpl$Query$GetFspHistory$getFspHistory$transactionList$to(
      this._res);

  TRes _res;

  call({
    String? id,
    String? name,
    String? imageUrl,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Query$GetFspHistoryByUser {
  factory Variables$Query$GetFspHistoryByUser({
    required String userId,
    required int count,
  }) =>
      Variables$Query$GetFspHistoryByUser._({
        r'userId': userId,
        r'count': count,
      });

  Variables$Query$GetFspHistoryByUser._(this._$data);

  factory Variables$Query$GetFspHistoryByUser.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    final l$count = data['count'];
    result$data['count'] = (l$count as int);
    return Variables$Query$GetFspHistoryByUser._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  int get count => (_$data['count'] as int);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$userId = userId;
    result$data['userId'] = l$userId;
    final l$count = count;
    result$data['count'] = l$count;
    return result$data;
  }

  CopyWith$Variables$Query$GetFspHistoryByUser<
          Variables$Query$GetFspHistoryByUser>
      get copyWith => CopyWith$Variables$Query$GetFspHistoryByUser(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$GetFspHistoryByUser) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$count = count;
    final lOther$count = other.count;
    if (l$count != lOther$count) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$count = count;
    return Object.hashAll([
      l$userId,
      l$count,
    ]);
  }
}

abstract class CopyWith$Variables$Query$GetFspHistoryByUser<TRes> {
  factory CopyWith$Variables$Query$GetFspHistoryByUser(
    Variables$Query$GetFspHistoryByUser instance,
    TRes Function(Variables$Query$GetFspHistoryByUser) then,
  ) = _CopyWithImpl$Variables$Query$GetFspHistoryByUser;

  factory CopyWith$Variables$Query$GetFspHistoryByUser.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$GetFspHistoryByUser;

  TRes call({
    String? userId,
    int? count,
  });
}

class _CopyWithImpl$Variables$Query$GetFspHistoryByUser<TRes>
    implements CopyWith$Variables$Query$GetFspHistoryByUser<TRes> {
  _CopyWithImpl$Variables$Query$GetFspHistoryByUser(
    this._instance,
    this._then,
  );

  final Variables$Query$GetFspHistoryByUser _instance;

  final TRes Function(Variables$Query$GetFspHistoryByUser) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? userId = _undefined,
    Object? count = _undefined,
  }) =>
      _then(Variables$Query$GetFspHistoryByUser._({
        ..._instance._$data,
        if (userId != _undefined && userId != null)
          'userId': (userId as String),
        if (count != _undefined && count != null) 'count': (count as int),
      }));
}

class _CopyWithStubImpl$Variables$Query$GetFspHistoryByUser<TRes>
    implements CopyWith$Variables$Query$GetFspHistoryByUser<TRes> {
  _CopyWithStubImpl$Variables$Query$GetFspHistoryByUser(this._res);

  TRes _res;

  call({
    String? userId,
    int? count,
  }) =>
      _res;
}

class Query$GetFspHistoryByUser {
  Query$GetFspHistoryByUser({
    required this.getFspHistoryByUser,
    this.$__typename = 'QueryRoot',
  });

  factory Query$GetFspHistoryByUser.fromJson(Map<String, dynamic> json) {
    final l$getFspHistoryByUser = json['getFspHistoryByUser'];
    final l$$__typename = json['__typename'];
    return Query$GetFspHistoryByUser(
      getFspHistoryByUser:
          Query$GetFspHistoryByUser$getFspHistoryByUser.fromJson(
              (l$getFspHistoryByUser as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetFspHistoryByUser$getFspHistoryByUser getFspHistoryByUser;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$getFspHistoryByUser = getFspHistoryByUser;
    _resultData['getFspHistoryByUser'] = l$getFspHistoryByUser.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$getFspHistoryByUser = getFspHistoryByUser;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$getFspHistoryByUser,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetFspHistoryByUser) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$getFspHistoryByUser = getFspHistoryByUser;
    final lOther$getFspHistoryByUser = other.getFspHistoryByUser;
    if (l$getFspHistoryByUser != lOther$getFspHistoryByUser) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetFspHistoryByUser
    on Query$GetFspHistoryByUser {
  CopyWith$Query$GetFspHistoryByUser<Query$GetFspHistoryByUser> get copyWith =>
      CopyWith$Query$GetFspHistoryByUser(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetFspHistoryByUser<TRes> {
  factory CopyWith$Query$GetFspHistoryByUser(
    Query$GetFspHistoryByUser instance,
    TRes Function(Query$GetFspHistoryByUser) then,
  ) = _CopyWithImpl$Query$GetFspHistoryByUser;

  factory CopyWith$Query$GetFspHistoryByUser.stub(TRes res) =
      _CopyWithStubImpl$Query$GetFspHistoryByUser;

  TRes call({
    Query$GetFspHistoryByUser$getFspHistoryByUser? getFspHistoryByUser,
    String? $__typename,
  });
  CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser<TRes>
      get getFspHistoryByUser;
}

class _CopyWithImpl$Query$GetFspHistoryByUser<TRes>
    implements CopyWith$Query$GetFspHistoryByUser<TRes> {
  _CopyWithImpl$Query$GetFspHistoryByUser(
    this._instance,
    this._then,
  );

  final Query$GetFspHistoryByUser _instance;

  final TRes Function(Query$GetFspHistoryByUser) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? getFspHistoryByUser = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetFspHistoryByUser(
        getFspHistoryByUser:
            getFspHistoryByUser == _undefined || getFspHistoryByUser == null
                ? _instance.getFspHistoryByUser
                : (getFspHistoryByUser
                    as Query$GetFspHistoryByUser$getFspHistoryByUser),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser<TRes>
      get getFspHistoryByUser {
    final local$getFspHistoryByUser = _instance.getFspHistoryByUser;
    return CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser(
        local$getFspHistoryByUser, (e) => call(getFspHistoryByUser: e));
  }
}

class _CopyWithStubImpl$Query$GetFspHistoryByUser<TRes>
    implements CopyWith$Query$GetFspHistoryByUser<TRes> {
  _CopyWithStubImpl$Query$GetFspHistoryByUser(this._res);

  TRes _res;

  call({
    Query$GetFspHistoryByUser$getFspHistoryByUser? getFspHistoryByUser,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser<TRes>
      get getFspHistoryByUser =>
          CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser.stub(_res);
}

const documentNodeQueryGetFspHistoryByUser = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetFspHistoryByUser'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'userId')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'count')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'getFspHistoryByUser'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'userId'),
            value: VariableNode(name: NameNode(value: 'userId')),
          ),
          ArgumentNode(
            name: NameNode(value: 'count'),
            value: VariableNode(name: NameNode(value: 'count')),
          ),
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'transactionList'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'amount'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'direction'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'counterParty'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: SelectionSetNode(selections: [
                  FieldNode(
                    name: NameNode(value: 'id'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'name'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'imageUrl'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: '__typename'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                ]),
              ),
              FieldNode(
                name: NameNode(value: 'txAt'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$GetFspHistoryByUser _parserFn$Query$GetFspHistoryByUser(
        Map<String, dynamic> data) =>
    Query$GetFspHistoryByUser.fromJson(data);
typedef OnQueryComplete$Query$GetFspHistoryByUser = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$GetFspHistoryByUser?,
);

class Options$Query$GetFspHistoryByUser
    extends graphql.QueryOptions<Query$GetFspHistoryByUser> {
  Options$Query$GetFspHistoryByUser({
    String? operationName,
    required Variables$Query$GetFspHistoryByUser variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetFspHistoryByUser? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$GetFspHistoryByUser? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null
                        ? null
                        : _parserFn$Query$GetFspHistoryByUser(data),
                  ),
          onError: onError,
          document: documentNodeQueryGetFspHistoryByUser,
          parserFn: _parserFn$Query$GetFspHistoryByUser,
        );

  final OnQueryComplete$Query$GetFspHistoryByUser? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$GetFspHistoryByUser
    extends graphql.WatchQueryOptions<Query$GetFspHistoryByUser> {
  WatchOptions$Query$GetFspHistoryByUser({
    String? operationName,
    required Variables$Query$GetFspHistoryByUser variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$GetFspHistoryByUser? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryGetFspHistoryByUser,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$GetFspHistoryByUser,
        );
}

class FetchMoreOptions$Query$GetFspHistoryByUser
    extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$GetFspHistoryByUser({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$GetFspHistoryByUser variables,
  }) : super(
          updateQuery: updateQuery,
          variables: variables.toJson(),
          document: documentNodeQueryGetFspHistoryByUser,
        );
}

extension ClientExtension$Query$GetFspHistoryByUser on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$GetFspHistoryByUser>>
      query$GetFspHistoryByUser(
              Options$Query$GetFspHistoryByUser options) async =>
          await this.query(options);
  graphql.ObservableQuery<Query$GetFspHistoryByUser>
      watchQuery$GetFspHistoryByUser(
              WatchOptions$Query$GetFspHistoryByUser options) =>
          this.watchQuery(options);
  void writeQuery$GetFspHistoryByUser({
    required Query$GetFspHistoryByUser data,
    required Variables$Query$GetFspHistoryByUser variables,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
          operation:
              graphql.Operation(document: documentNodeQueryGetFspHistoryByUser),
          variables: variables.toJson(),
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$GetFspHistoryByUser? readQuery$GetFspHistoryByUser({
    required Variables$Query$GetFspHistoryByUser variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation:
            graphql.Operation(document: documentNodeQueryGetFspHistoryByUser),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$GetFspHistoryByUser.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$GetFspHistoryByUser>
    useQuery$GetFspHistoryByUser(Options$Query$GetFspHistoryByUser options) =>
        graphql_flutter.useQuery(options);
graphql.ObservableQuery<Query$GetFspHistoryByUser>
    useWatchQuery$GetFspHistoryByUser(
            WatchOptions$Query$GetFspHistoryByUser options) =>
        graphql_flutter.useWatchQuery(options);

class Query$GetFspHistoryByUser$Widget
    extends graphql_flutter.Query<Query$GetFspHistoryByUser> {
  Query$GetFspHistoryByUser$Widget({
    widgets.Key? key,
    required Options$Query$GetFspHistoryByUser options,
    required graphql_flutter.QueryBuilder<Query$GetFspHistoryByUser> builder,
  }) : super(
          key: key,
          options: options,
          builder: builder,
        );
}

class Query$GetFspHistoryByUser$getFspHistoryByUser {
  Query$GetFspHistoryByUser$getFspHistoryByUser({
    required this.transactionList,
    this.$__typename = 'TransactionsByUserData',
  });

  factory Query$GetFspHistoryByUser$getFspHistoryByUser.fromJson(
      Map<String, dynamic> json) {
    final l$transactionList = json['transactionList'];
    final l$$__typename = json['__typename'];
    return Query$GetFspHistoryByUser$getFspHistoryByUser(
      transactionList: (l$transactionList as List<dynamic>)
          .map((e) =>
              Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList
                  .fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList>
      transactionList;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$transactionList = transactionList;
    _resultData['transactionList'] =
        l$transactionList.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$transactionList = transactionList;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$transactionList.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$GetFspHistoryByUser$getFspHistoryByUser) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$transactionList = transactionList;
    final lOther$transactionList = other.transactionList;
    if (l$transactionList.length != lOther$transactionList.length) {
      return false;
    }
    for (int i = 0; i < l$transactionList.length; i++) {
      final l$transactionList$entry = l$transactionList[i];
      final lOther$transactionList$entry = lOther$transactionList[i];
      if (l$transactionList$entry != lOther$transactionList$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetFspHistoryByUser$getFspHistoryByUser
    on Query$GetFspHistoryByUser$getFspHistoryByUser {
  CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser<
          Query$GetFspHistoryByUser$getFspHistoryByUser>
      get copyWith => CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser<TRes> {
  factory CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser(
    Query$GetFspHistoryByUser$getFspHistoryByUser instance,
    TRes Function(Query$GetFspHistoryByUser$getFspHistoryByUser) then,
  ) = _CopyWithImpl$Query$GetFspHistoryByUser$getFspHistoryByUser;

  factory CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetFspHistoryByUser$getFspHistoryByUser;

  TRes call({
    List<Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList>?
        transactionList,
    String? $__typename,
  });
  TRes transactionList(
      Iterable<Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList> Function(
              Iterable<
                  CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList<
                      Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList>>)
          _fn);
}

class _CopyWithImpl$Query$GetFspHistoryByUser$getFspHistoryByUser<TRes>
    implements CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser<TRes> {
  _CopyWithImpl$Query$GetFspHistoryByUser$getFspHistoryByUser(
    this._instance,
    this._then,
  );

  final Query$GetFspHistoryByUser$getFspHistoryByUser _instance;

  final TRes Function(Query$GetFspHistoryByUser$getFspHistoryByUser) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? transactionList = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetFspHistoryByUser$getFspHistoryByUser(
        transactionList: transactionList == _undefined ||
                transactionList == null
            ? _instance.transactionList
            : (transactionList as List<
                Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes transactionList(
          Iterable<Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList> Function(
                  Iterable<
                      CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList<
                          Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList>>)
              _fn) =>
      call(
          transactionList: _fn(_instance.transactionList.map((e) =>
              CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList(
                e,
                (i) => i,
              ))).toList());
}

class _CopyWithStubImpl$Query$GetFspHistoryByUser$getFspHistoryByUser<TRes>
    implements CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser<TRes> {
  _CopyWithStubImpl$Query$GetFspHistoryByUser$getFspHistoryByUser(this._res);

  TRes _res;

  call({
    List<Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList>?
        transactionList,
    String? $__typename,
  }) =>
      _res;

  transactionList(_fn) => _res;
}

class Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList {
  Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList({
    required this.id,
    required this.amount,
    required this.direction,
    required this.counterParty,
    required this.txAt,
    this.$__typename = 'TransactionByUserData',
  });

  factory Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$amount = json['amount'];
    final l$direction = json['direction'];
    final l$counterParty = json['counterParty'];
    final l$txAt = json['txAt'];
    final l$$__typename = json['__typename'];
    return Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList(
      id: (l$id as String),
      amount: (l$amount as int),
      direction: fromJson$Enum$TransactionDirection((l$direction as String)),
      counterParty:
          Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty
              .fromJson((l$counterParty as Map<String, dynamic>)),
      txAt: (l$txAt as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final int amount;

  final Enum$TransactionDirection direction;

  final Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty
      counterParty;

  final String txAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$amount = amount;
    _resultData['amount'] = l$amount;
    final l$direction = direction;
    _resultData['direction'] = toJson$Enum$TransactionDirection(l$direction);
    final l$counterParty = counterParty;
    _resultData['counterParty'] = l$counterParty.toJson();
    final l$txAt = txAt;
    _resultData['txAt'] = l$txAt;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$amount = amount;
    final l$direction = direction;
    final l$counterParty = counterParty;
    final l$txAt = txAt;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$amount,
      l$direction,
      l$counterParty,
      l$txAt,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other
            is Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$amount = amount;
    final lOther$amount = other.amount;
    if (l$amount != lOther$amount) {
      return false;
    }
    final l$direction = direction;
    final lOther$direction = other.direction;
    if (l$direction != lOther$direction) {
      return false;
    }
    final l$counterParty = counterParty;
    final lOther$counterParty = other.counterParty;
    if (l$counterParty != lOther$counterParty) {
      return false;
    }
    final l$txAt = txAt;
    final lOther$txAt = other.txAt;
    if (l$txAt != lOther$txAt) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList
    on Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList {
  CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList<
          Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList>
      get copyWith =>
          CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList<
    TRes> {
  factory CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList(
    Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList instance,
    TRes Function(Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList)
        then,
  ) = _CopyWithImpl$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList;

  factory CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList;

  TRes call({
    String? id,
    int? amount,
    Enum$TransactionDirection? direction,
    Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty?
        counterParty,
    String? txAt,
    String? $__typename,
  });
  CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty<
      TRes> get counterParty;
}

class _CopyWithImpl$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList<
        TRes>
    implements
        CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList<
            TRes> {
  _CopyWithImpl$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList(
    this._instance,
    this._then,
  );

  final Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList _instance;

  final TRes Function(
      Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? amount = _undefined,
    Object? direction = _undefined,
    Object? counterParty = _undefined,
    Object? txAt = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        amount: amount == _undefined || amount == null
            ? _instance.amount
            : (amount as int),
        direction: direction == _undefined || direction == null
            ? _instance.direction
            : (direction as Enum$TransactionDirection),
        counterParty: counterParty == _undefined || counterParty == null
            ? _instance.counterParty
            : (counterParty
                as Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty),
        txAt: txAt == _undefined || txAt == null
            ? _instance.txAt
            : (txAt as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty<
      TRes> get counterParty {
    final local$counterParty = _instance.counterParty;
    return CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty(
        local$counterParty, (e) => call(counterParty: e));
  }
}

class _CopyWithStubImpl$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList<
        TRes>
    implements
        CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList<
            TRes> {
  _CopyWithStubImpl$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList(
      this._res);

  TRes _res;

  call({
    String? id,
    int? amount,
    Enum$TransactionDirection? direction,
    Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty?
        counterParty,
    String? txAt,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty<
          TRes>
      get counterParty =>
          CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty
              .stub(_res);
}

class Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty {
  Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty({
    required this.id,
    required this.name,
    this.imageUrl,
    this.$__typename = 'UserSimpleData',
  });

  factory Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$imageUrl = json['imageUrl'];
    final l$$__typename = json['__typename'];
    return Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty(
      id: (l$id as String),
      name: (l$name as String),
      imageUrl: (l$imageUrl as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String name;

  final String? imageUrl;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$imageUrl = imageUrl;
    _resultData['imageUrl'] = l$imageUrl;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$imageUrl = imageUrl;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$name,
      l$imageUrl,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other
            is Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$imageUrl = imageUrl;
    final lOther$imageUrl = other.imageUrl;
    if (l$imageUrl != lOther$imageUrl) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty
    on Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty {
  CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty<
          Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty>
      get copyWith =>
          CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty<
    TRes> {
  factory CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty(
    Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty
        instance,
    TRes Function(
            Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty)
        then,
  ) = _CopyWithImpl$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty;

  factory CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty.stub(
          TRes res) =
      _CopyWithStubImpl$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty;

  TRes call({
    String? id,
    String? name,
    String? imageUrl,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty<
        TRes>
    implements
        CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty<
            TRes> {
  _CopyWithImpl$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty(
    this._instance,
    this._then,
  );

  final Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty
      _instance;

  final TRes Function(
          Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty)
      _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? imageUrl = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(
          Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        imageUrl:
            imageUrl == _undefined ? _instance.imageUrl : (imageUrl as String?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty<
        TRes>
    implements
        CopyWith$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty<
            TRes> {
  _CopyWithStubImpl$Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList$counterParty(
      this._res);

  TRes _res;

  call({
    String? id,
    String? name,
    String? imageUrl,
    String? $__typename,
  }) =>
      _res;
}
