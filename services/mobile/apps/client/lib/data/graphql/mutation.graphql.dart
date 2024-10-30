import 'dart:async';
import 'package:flutter/widgets.dart' as widgets;
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:graphql_flutter/graphql_flutter.dart' as graphql_flutter;
import 'schema.graphql.dart';

class Variables$Mutation$AddNewConnection {
  factory Variables$Mutation$AddNewConnection(
          {required Input$AddNewConnectionByUserInput input}) =>
      Variables$Mutation$AddNewConnection._({
        r'input': input,
      });

  Variables$Mutation$AddNewConnection._(this._$data);

  factory Variables$Mutation$AddNewConnection.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] = Input$AddNewConnectionByUserInput.fromJson(
        (l$input as Map<String, dynamic>));
    return Variables$Mutation$AddNewConnection._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$AddNewConnectionByUserInput get input =>
      (_$data['input'] as Input$AddNewConnectionByUserInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$AddNewConnection<
          Variables$Mutation$AddNewConnection>
      get copyWith => CopyWith$Variables$Mutation$AddNewConnection(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$AddNewConnection) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }
}

abstract class CopyWith$Variables$Mutation$AddNewConnection<TRes> {
  factory CopyWith$Variables$Mutation$AddNewConnection(
    Variables$Mutation$AddNewConnection instance,
    TRes Function(Variables$Mutation$AddNewConnection) then,
  ) = _CopyWithImpl$Variables$Mutation$AddNewConnection;

  factory CopyWith$Variables$Mutation$AddNewConnection.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$AddNewConnection;

  TRes call({Input$AddNewConnectionByUserInput? input});
}

class _CopyWithImpl$Variables$Mutation$AddNewConnection<TRes>
    implements CopyWith$Variables$Mutation$AddNewConnection<TRes> {
  _CopyWithImpl$Variables$Mutation$AddNewConnection(
    this._instance,
    this._then,
  );

  final Variables$Mutation$AddNewConnection _instance;

  final TRes Function(Variables$Mutation$AddNewConnection) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? input = _undefined}) =>
      _then(Variables$Mutation$AddNewConnection._({
        ..._instance._$data,
        if (input != _undefined && input != null)
          'input': (input as Input$AddNewConnectionByUserInput),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$AddNewConnection<TRes>
    implements CopyWith$Variables$Mutation$AddNewConnection<TRes> {
  _CopyWithStubImpl$Variables$Mutation$AddNewConnection(this._res);

  TRes _res;

  call({Input$AddNewConnectionByUserInput? input}) => _res;
}

class Mutation$AddNewConnection {
  Mutation$AddNewConnection({
    required this.addNewConnection,
    this.$__typename = 'MutationRoot',
  });

  factory Mutation$AddNewConnection.fromJson(Map<String, dynamic> json) {
    final l$addNewConnection = json['addNewConnection'];
    final l$$__typename = json['__typename'];
    return Mutation$AddNewConnection(
      addNewConnection: Mutation$AddNewConnection$addNewConnection.fromJson(
          (l$addNewConnection as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$AddNewConnection$addNewConnection addNewConnection;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$addNewConnection = addNewConnection;
    _resultData['addNewConnection'] = l$addNewConnection.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$addNewConnection = addNewConnection;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$addNewConnection,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$AddNewConnection) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$addNewConnection = addNewConnection;
    final lOther$addNewConnection = other.addNewConnection;
    if (l$addNewConnection != lOther$addNewConnection) {
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

extension UtilityExtension$Mutation$AddNewConnection
    on Mutation$AddNewConnection {
  CopyWith$Mutation$AddNewConnection<Mutation$AddNewConnection> get copyWith =>
      CopyWith$Mutation$AddNewConnection(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$AddNewConnection<TRes> {
  factory CopyWith$Mutation$AddNewConnection(
    Mutation$AddNewConnection instance,
    TRes Function(Mutation$AddNewConnection) then,
  ) = _CopyWithImpl$Mutation$AddNewConnection;

  factory CopyWith$Mutation$AddNewConnection.stub(TRes res) =
      _CopyWithStubImpl$Mutation$AddNewConnection;

  TRes call({
    Mutation$AddNewConnection$addNewConnection? addNewConnection,
    String? $__typename,
  });
  CopyWith$Mutation$AddNewConnection$addNewConnection<TRes>
      get addNewConnection;
}

class _CopyWithImpl$Mutation$AddNewConnection<TRes>
    implements CopyWith$Mutation$AddNewConnection<TRes> {
  _CopyWithImpl$Mutation$AddNewConnection(
    this._instance,
    this._then,
  );

  final Mutation$AddNewConnection _instance;

  final TRes Function(Mutation$AddNewConnection) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? addNewConnection = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$AddNewConnection(
        addNewConnection: addNewConnection == _undefined ||
                addNewConnection == null
            ? _instance.addNewConnection
            : (addNewConnection as Mutation$AddNewConnection$addNewConnection),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$AddNewConnection$addNewConnection<TRes>
      get addNewConnection {
    final local$addNewConnection = _instance.addNewConnection;
    return CopyWith$Mutation$AddNewConnection$addNewConnection(
        local$addNewConnection, (e) => call(addNewConnection: e));
  }
}

class _CopyWithStubImpl$Mutation$AddNewConnection<TRes>
    implements CopyWith$Mutation$AddNewConnection<TRes> {
  _CopyWithStubImpl$Mutation$AddNewConnection(this._res);

  TRes _res;

  call({
    Mutation$AddNewConnection$addNewConnection? addNewConnection,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$AddNewConnection$addNewConnection<TRes>
      get addNewConnection =>
          CopyWith$Mutation$AddNewConnection$addNewConnection.stub(_res);
}

const documentNodeMutationAddNewConnection = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'AddNewConnection'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'input')),
        type: NamedTypeNode(
          name: NameNode(value: 'AddNewConnectionByUserInput'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'addNewConnection'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'input'),
            value: VariableNode(name: NameNode(value: 'input')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'mapId'),
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
Mutation$AddNewConnection _parserFn$Mutation$AddNewConnection(
        Map<String, dynamic> data) =>
    Mutation$AddNewConnection.fromJson(data);
typedef OnMutationCompleted$Mutation$AddNewConnection = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$AddNewConnection?,
);

class Options$Mutation$AddNewConnection
    extends graphql.MutationOptions<Mutation$AddNewConnection> {
  Options$Mutation$AddNewConnection({
    String? operationName,
    required Variables$Mutation$AddNewConnection variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$AddNewConnection? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$AddNewConnection? onCompleted,
    graphql.OnMutationUpdate<Mutation$AddNewConnection>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$AddNewConnection(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationAddNewConnection,
          parserFn: _parserFn$Mutation$AddNewConnection,
        );

  final OnMutationCompleted$Mutation$AddNewConnection? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$AddNewConnection
    extends graphql.WatchQueryOptions<Mutation$AddNewConnection> {
  WatchOptions$Mutation$AddNewConnection({
    String? operationName,
    required Variables$Mutation$AddNewConnection variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$AddNewConnection? typedOptimisticResult,
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
          document: documentNodeMutationAddNewConnection,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$AddNewConnection,
        );
}

extension ClientExtension$Mutation$AddNewConnection on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$AddNewConnection>>
      mutate$AddNewConnection(
              Options$Mutation$AddNewConnection options) async =>
          await this.mutate(options);
  graphql.ObservableQuery<Mutation$AddNewConnection>
      watchMutation$AddNewConnection(
              WatchOptions$Mutation$AddNewConnection options) =>
          this.watchMutation(options);
}

class Mutation$AddNewConnection$HookResult {
  Mutation$AddNewConnection$HookResult(
    this.runMutation,
    this.result,
  );

  final RunMutation$Mutation$AddNewConnection runMutation;

  final graphql.QueryResult<Mutation$AddNewConnection> result;
}

Mutation$AddNewConnection$HookResult useMutation$AddNewConnection(
    [WidgetOptions$Mutation$AddNewConnection? options]) {
  final result = graphql_flutter
      .useMutation(options ?? WidgetOptions$Mutation$AddNewConnection());
  return Mutation$AddNewConnection$HookResult(
    (variables, {optimisticResult, typedOptimisticResult}) =>
        result.runMutation(
      variables.toJson(),
      optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
    ),
    result.result,
  );
}

graphql.ObservableQuery<Mutation$AddNewConnection>
    useWatchMutation$AddNewConnection(
            WatchOptions$Mutation$AddNewConnection options) =>
        graphql_flutter.useWatchMutation(options);

class WidgetOptions$Mutation$AddNewConnection
    extends graphql.MutationOptions<Mutation$AddNewConnection> {
  WidgetOptions$Mutation$AddNewConnection({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$AddNewConnection? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$AddNewConnection? onCompleted,
    graphql.OnMutationUpdate<Mutation$AddNewConnection>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$AddNewConnection(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationAddNewConnection,
          parserFn: _parserFn$Mutation$AddNewConnection,
        );

  final OnMutationCompleted$Mutation$AddNewConnection? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

typedef RunMutation$Mutation$AddNewConnection
    = graphql.MultiSourceResult<Mutation$AddNewConnection> Function(
  Variables$Mutation$AddNewConnection, {
  Object? optimisticResult,
  Mutation$AddNewConnection? typedOptimisticResult,
});
typedef Builder$Mutation$AddNewConnection = widgets.Widget Function(
  RunMutation$Mutation$AddNewConnection,
  graphql.QueryResult<Mutation$AddNewConnection>?,
);

class Mutation$AddNewConnection$Widget
    extends graphql_flutter.Mutation<Mutation$AddNewConnection> {
  Mutation$AddNewConnection$Widget({
    widgets.Key? key,
    WidgetOptions$Mutation$AddNewConnection? options,
    required Builder$Mutation$AddNewConnection builder,
  }) : super(
          key: key,
          options: options ?? WidgetOptions$Mutation$AddNewConnection(),
          builder: (
            run,
            result,
          ) =>
              builder(
            (
              variables, {
              optimisticResult,
              typedOptimisticResult,
            }) =>
                run(
              variables.toJson(),
              optimisticResult:
                  optimisticResult ?? typedOptimisticResult?.toJson(),
            ),
            result,
          ),
        );
}

class Mutation$AddNewConnection$addNewConnection {
  Mutation$AddNewConnection$addNewConnection({
    required this.mapId,
    this.$__typename = 'AddNewConnectionResponse',
  });

  factory Mutation$AddNewConnection$addNewConnection.fromJson(
      Map<String, dynamic> json) {
    final l$mapId = json['mapId'];
    final l$$__typename = json['__typename'];
    return Mutation$AddNewConnection$addNewConnection(
      mapId: (l$mapId as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String mapId;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$mapId = mapId;
    _resultData['mapId'] = l$mapId;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$mapId = mapId;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$mapId,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$AddNewConnection$addNewConnection) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$mapId = mapId;
    final lOther$mapId = other.mapId;
    if (l$mapId != lOther$mapId) {
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

extension UtilityExtension$Mutation$AddNewConnection$addNewConnection
    on Mutation$AddNewConnection$addNewConnection {
  CopyWith$Mutation$AddNewConnection$addNewConnection<
          Mutation$AddNewConnection$addNewConnection>
      get copyWith => CopyWith$Mutation$AddNewConnection$addNewConnection(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$AddNewConnection$addNewConnection<TRes> {
  factory CopyWith$Mutation$AddNewConnection$addNewConnection(
    Mutation$AddNewConnection$addNewConnection instance,
    TRes Function(Mutation$AddNewConnection$addNewConnection) then,
  ) = _CopyWithImpl$Mutation$AddNewConnection$addNewConnection;

  factory CopyWith$Mutation$AddNewConnection$addNewConnection.stub(TRes res) =
      _CopyWithStubImpl$Mutation$AddNewConnection$addNewConnection;

  TRes call({
    String? mapId,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$AddNewConnection$addNewConnection<TRes>
    implements CopyWith$Mutation$AddNewConnection$addNewConnection<TRes> {
  _CopyWithImpl$Mutation$AddNewConnection$addNewConnection(
    this._instance,
    this._then,
  );

  final Mutation$AddNewConnection$addNewConnection _instance;

  final TRes Function(Mutation$AddNewConnection$addNewConnection) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? mapId = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$AddNewConnection$addNewConnection(
        mapId: mapId == _undefined || mapId == null
            ? _instance.mapId
            : (mapId as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$AddNewConnection$addNewConnection<TRes>
    implements CopyWith$Mutation$AddNewConnection$addNewConnection<TRes> {
  _CopyWithStubImpl$Mutation$AddNewConnection$addNewConnection(this._res);

  TRes _res;

  call({
    String? mapId,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$CreateNewUserData {
  factory Variables$Mutation$CreateNewUserData(
          {required Input$CreateNewUserDataInput input}) =>
      Variables$Mutation$CreateNewUserData._({
        r'input': input,
      });

  Variables$Mutation$CreateNewUserData._(this._$data);

  factory Variables$Mutation$CreateNewUserData.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] = Input$CreateNewUserDataInput.fromJson(
        (l$input as Map<String, dynamic>));
    return Variables$Mutation$CreateNewUserData._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$CreateNewUserDataInput get input =>
      (_$data['input'] as Input$CreateNewUserDataInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$CreateNewUserData<
          Variables$Mutation$CreateNewUserData>
      get copyWith => CopyWith$Variables$Mutation$CreateNewUserData(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$CreateNewUserData) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }
}

abstract class CopyWith$Variables$Mutation$CreateNewUserData<TRes> {
  factory CopyWith$Variables$Mutation$CreateNewUserData(
    Variables$Mutation$CreateNewUserData instance,
    TRes Function(Variables$Mutation$CreateNewUserData) then,
  ) = _CopyWithImpl$Variables$Mutation$CreateNewUserData;

  factory CopyWith$Variables$Mutation$CreateNewUserData.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$CreateNewUserData;

  TRes call({Input$CreateNewUserDataInput? input});
}

class _CopyWithImpl$Variables$Mutation$CreateNewUserData<TRes>
    implements CopyWith$Variables$Mutation$CreateNewUserData<TRes> {
  _CopyWithImpl$Variables$Mutation$CreateNewUserData(
    this._instance,
    this._then,
  );

  final Variables$Mutation$CreateNewUserData _instance;

  final TRes Function(Variables$Mutation$CreateNewUserData) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? input = _undefined}) =>
      _then(Variables$Mutation$CreateNewUserData._({
        ..._instance._$data,
        if (input != _undefined && input != null)
          'input': (input as Input$CreateNewUserDataInput),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$CreateNewUserData<TRes>
    implements CopyWith$Variables$Mutation$CreateNewUserData<TRes> {
  _CopyWithStubImpl$Variables$Mutation$CreateNewUserData(this._res);

  TRes _res;

  call({Input$CreateNewUserDataInput? input}) => _res;
}

class Mutation$CreateNewUserData {
  Mutation$CreateNewUserData({
    required this.createNewUserData,
    this.$__typename = 'MutationRoot',
  });

  factory Mutation$CreateNewUserData.fromJson(Map<String, dynamic> json) {
    final l$createNewUserData = json['createNewUserData'];
    final l$$__typename = json['__typename'];
    return Mutation$CreateNewUserData(
      createNewUserData: Mutation$CreateNewUserData$createNewUserData.fromJson(
          (l$createNewUserData as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$CreateNewUserData$createNewUserData createNewUserData;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$createNewUserData = createNewUserData;
    _resultData['createNewUserData'] = l$createNewUserData.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$createNewUserData = createNewUserData;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$createNewUserData,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$CreateNewUserData) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$createNewUserData = createNewUserData;
    final lOther$createNewUserData = other.createNewUserData;
    if (l$createNewUserData != lOther$createNewUserData) {
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

extension UtilityExtension$Mutation$CreateNewUserData
    on Mutation$CreateNewUserData {
  CopyWith$Mutation$CreateNewUserData<Mutation$CreateNewUserData>
      get copyWith => CopyWith$Mutation$CreateNewUserData(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$CreateNewUserData<TRes> {
  factory CopyWith$Mutation$CreateNewUserData(
    Mutation$CreateNewUserData instance,
    TRes Function(Mutation$CreateNewUserData) then,
  ) = _CopyWithImpl$Mutation$CreateNewUserData;

  factory CopyWith$Mutation$CreateNewUserData.stub(TRes res) =
      _CopyWithStubImpl$Mutation$CreateNewUserData;

  TRes call({
    Mutation$CreateNewUserData$createNewUserData? createNewUserData,
    String? $__typename,
  });
  CopyWith$Mutation$CreateNewUserData$createNewUserData<TRes>
      get createNewUserData;
}

class _CopyWithImpl$Mutation$CreateNewUserData<TRes>
    implements CopyWith$Mutation$CreateNewUserData<TRes> {
  _CopyWithImpl$Mutation$CreateNewUserData(
    this._instance,
    this._then,
  );

  final Mutation$CreateNewUserData _instance;

  final TRes Function(Mutation$CreateNewUserData) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? createNewUserData = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$CreateNewUserData(
        createNewUserData:
            createNewUserData == _undefined || createNewUserData == null
                ? _instance.createNewUserData
                : (createNewUserData
                    as Mutation$CreateNewUserData$createNewUserData),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$CreateNewUserData$createNewUserData<TRes>
      get createNewUserData {
    final local$createNewUserData = _instance.createNewUserData;
    return CopyWith$Mutation$CreateNewUserData$createNewUserData(
        local$createNewUserData, (e) => call(createNewUserData: e));
  }
}

class _CopyWithStubImpl$Mutation$CreateNewUserData<TRes>
    implements CopyWith$Mutation$CreateNewUserData<TRes> {
  _CopyWithStubImpl$Mutation$CreateNewUserData(this._res);

  TRes _res;

  call({
    Mutation$CreateNewUserData$createNewUserData? createNewUserData,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$CreateNewUserData$createNewUserData<TRes>
      get createNewUserData =>
          CopyWith$Mutation$CreateNewUserData$createNewUserData.stub(_res);
}

const documentNodeMutationCreateNewUserData = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'CreateNewUserData'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'input')),
        type: NamedTypeNode(
          name: NameNode(value: 'CreateNewUserDataInput'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'createNewUserData'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'input'),
            value: VariableNode(name: NameNode(value: 'input')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'userId'),
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
]);
Mutation$CreateNewUserData _parserFn$Mutation$CreateNewUserData(
        Map<String, dynamic> data) =>
    Mutation$CreateNewUserData.fromJson(data);
typedef OnMutationCompleted$Mutation$CreateNewUserData = FutureOr<void>
    Function(
  Map<String, dynamic>?,
  Mutation$CreateNewUserData?,
);

class Options$Mutation$CreateNewUserData
    extends graphql.MutationOptions<Mutation$CreateNewUserData> {
  Options$Mutation$CreateNewUserData({
    String? operationName,
    required Variables$Mutation$CreateNewUserData variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreateNewUserData? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$CreateNewUserData? onCompleted,
    graphql.OnMutationUpdate<Mutation$CreateNewUserData>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$CreateNewUserData(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationCreateNewUserData,
          parserFn: _parserFn$Mutation$CreateNewUserData,
        );

  final OnMutationCompleted$Mutation$CreateNewUserData? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$CreateNewUserData
    extends graphql.WatchQueryOptions<Mutation$CreateNewUserData> {
  WatchOptions$Mutation$CreateNewUserData({
    String? operationName,
    required Variables$Mutation$CreateNewUserData variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreateNewUserData? typedOptimisticResult,
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
          document: documentNodeMutationCreateNewUserData,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$CreateNewUserData,
        );
}

extension ClientExtension$Mutation$CreateNewUserData on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$CreateNewUserData>>
      mutate$CreateNewUserData(
              Options$Mutation$CreateNewUserData options) async =>
          await this.mutate(options);
  graphql.ObservableQuery<Mutation$CreateNewUserData>
      watchMutation$CreateNewUserData(
              WatchOptions$Mutation$CreateNewUserData options) =>
          this.watchMutation(options);
}

class Mutation$CreateNewUserData$HookResult {
  Mutation$CreateNewUserData$HookResult(
    this.runMutation,
    this.result,
  );

  final RunMutation$Mutation$CreateNewUserData runMutation;

  final graphql.QueryResult<Mutation$CreateNewUserData> result;
}

Mutation$CreateNewUserData$HookResult useMutation$CreateNewUserData(
    [WidgetOptions$Mutation$CreateNewUserData? options]) {
  final result = graphql_flutter
      .useMutation(options ?? WidgetOptions$Mutation$CreateNewUserData());
  return Mutation$CreateNewUserData$HookResult(
    (variables, {optimisticResult, typedOptimisticResult}) =>
        result.runMutation(
      variables.toJson(),
      optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
    ),
    result.result,
  );
}

graphql.ObservableQuery<Mutation$CreateNewUserData>
    useWatchMutation$CreateNewUserData(
            WatchOptions$Mutation$CreateNewUserData options) =>
        graphql_flutter.useWatchMutation(options);

class WidgetOptions$Mutation$CreateNewUserData
    extends graphql.MutationOptions<Mutation$CreateNewUserData> {
  WidgetOptions$Mutation$CreateNewUserData({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreateNewUserData? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$CreateNewUserData? onCompleted,
    graphql.OnMutationUpdate<Mutation$CreateNewUserData>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$CreateNewUserData(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationCreateNewUserData,
          parserFn: _parserFn$Mutation$CreateNewUserData,
        );

  final OnMutationCompleted$Mutation$CreateNewUserData? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

typedef RunMutation$Mutation$CreateNewUserData
    = graphql.MultiSourceResult<Mutation$CreateNewUserData> Function(
  Variables$Mutation$CreateNewUserData, {
  Object? optimisticResult,
  Mutation$CreateNewUserData? typedOptimisticResult,
});
typedef Builder$Mutation$CreateNewUserData = widgets.Widget Function(
  RunMutation$Mutation$CreateNewUserData,
  graphql.QueryResult<Mutation$CreateNewUserData>?,
);

class Mutation$CreateNewUserData$Widget
    extends graphql_flutter.Mutation<Mutation$CreateNewUserData> {
  Mutation$CreateNewUserData$Widget({
    widgets.Key? key,
    WidgetOptions$Mutation$CreateNewUserData? options,
    required Builder$Mutation$CreateNewUserData builder,
  }) : super(
          key: key,
          options: options ?? WidgetOptions$Mutation$CreateNewUserData(),
          builder: (
            run,
            result,
          ) =>
              builder(
            (
              variables, {
              optimisticResult,
              typedOptimisticResult,
            }) =>
                run(
              variables.toJson(),
              optimisticResult:
                  optimisticResult ?? typedOptimisticResult?.toJson(),
            ),
            result,
          ),
        );
}

class Mutation$CreateNewUserData$createNewUserData {
  Mutation$CreateNewUserData$createNewUserData({
    required this.userId,
    required this.name,
    this.imageUrl,
    this.$__typename = 'CreateNewUserDataResponse',
  });

  factory Mutation$CreateNewUserData$createNewUserData.fromJson(
      Map<String, dynamic> json) {
    final l$userId = json['userId'];
    final l$name = json['name'];
    final l$imageUrl = json['imageUrl'];
    final l$$__typename = json['__typename'];
    return Mutation$CreateNewUserData$createNewUserData(
      userId: (l$userId as String),
      name: (l$name as String),
      imageUrl: (l$imageUrl as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String userId;

  final String name;

  final String? imageUrl;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$userId = userId;
    _resultData['userId'] = l$userId;
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
    final l$userId = userId;
    final l$name = name;
    final l$imageUrl = imageUrl;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$userId,
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
    if (!(other is Mutation$CreateNewUserData$createNewUserData) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
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

extension UtilityExtension$Mutation$CreateNewUserData$createNewUserData
    on Mutation$CreateNewUserData$createNewUserData {
  CopyWith$Mutation$CreateNewUserData$createNewUserData<
          Mutation$CreateNewUserData$createNewUserData>
      get copyWith => CopyWith$Mutation$CreateNewUserData$createNewUserData(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$CreateNewUserData$createNewUserData<TRes> {
  factory CopyWith$Mutation$CreateNewUserData$createNewUserData(
    Mutation$CreateNewUserData$createNewUserData instance,
    TRes Function(Mutation$CreateNewUserData$createNewUserData) then,
  ) = _CopyWithImpl$Mutation$CreateNewUserData$createNewUserData;

  factory CopyWith$Mutation$CreateNewUserData$createNewUserData.stub(TRes res) =
      _CopyWithStubImpl$Mutation$CreateNewUserData$createNewUserData;

  TRes call({
    String? userId,
    String? name,
    String? imageUrl,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$CreateNewUserData$createNewUserData<TRes>
    implements CopyWith$Mutation$CreateNewUserData$createNewUserData<TRes> {
  _CopyWithImpl$Mutation$CreateNewUserData$createNewUserData(
    this._instance,
    this._then,
  );

  final Mutation$CreateNewUserData$createNewUserData _instance;

  final TRes Function(Mutation$CreateNewUserData$createNewUserData) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? userId = _undefined,
    Object? name = _undefined,
    Object? imageUrl = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$CreateNewUserData$createNewUserData(
        userId: userId == _undefined || userId == null
            ? _instance.userId
            : (userId as String),
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

class _CopyWithStubImpl$Mutation$CreateNewUserData$createNewUserData<TRes>
    implements CopyWith$Mutation$CreateNewUserData$createNewUserData<TRes> {
  _CopyWithStubImpl$Mutation$CreateNewUserData$createNewUserData(this._res);

  TRes _res;

  call({
    String? userId,
    String? name,
    String? imageUrl,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$UpdateUserData {
  factory Variables$Mutation$UpdateUserData(
          {required Input$UpdateUserDataInput input}) =>
      Variables$Mutation$UpdateUserData._({
        r'input': input,
      });

  Variables$Mutation$UpdateUserData._(this._$data);

  factory Variables$Mutation$UpdateUserData.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] =
        Input$UpdateUserDataInput.fromJson((l$input as Map<String, dynamic>));
    return Variables$Mutation$UpdateUserData._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$UpdateUserDataInput get input =>
      (_$data['input'] as Input$UpdateUserDataInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$UpdateUserData<Variables$Mutation$UpdateUserData>
      get copyWith => CopyWith$Variables$Mutation$UpdateUserData(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$UpdateUserData) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }
}

abstract class CopyWith$Variables$Mutation$UpdateUserData<TRes> {
  factory CopyWith$Variables$Mutation$UpdateUserData(
    Variables$Mutation$UpdateUserData instance,
    TRes Function(Variables$Mutation$UpdateUserData) then,
  ) = _CopyWithImpl$Variables$Mutation$UpdateUserData;

  factory CopyWith$Variables$Mutation$UpdateUserData.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$UpdateUserData;

  TRes call({Input$UpdateUserDataInput? input});
}

class _CopyWithImpl$Variables$Mutation$UpdateUserData<TRes>
    implements CopyWith$Variables$Mutation$UpdateUserData<TRes> {
  _CopyWithImpl$Variables$Mutation$UpdateUserData(
    this._instance,
    this._then,
  );

  final Variables$Mutation$UpdateUserData _instance;

  final TRes Function(Variables$Mutation$UpdateUserData) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? input = _undefined}) =>
      _then(Variables$Mutation$UpdateUserData._({
        ..._instance._$data,
        if (input != _undefined && input != null)
          'input': (input as Input$UpdateUserDataInput),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$UpdateUserData<TRes>
    implements CopyWith$Variables$Mutation$UpdateUserData<TRes> {
  _CopyWithStubImpl$Variables$Mutation$UpdateUserData(this._res);

  TRes _res;

  call({Input$UpdateUserDataInput? input}) => _res;
}

class Mutation$UpdateUserData {
  Mutation$UpdateUserData({
    required this.updateUserData,
    this.$__typename = 'MutationRoot',
  });

  factory Mutation$UpdateUserData.fromJson(Map<String, dynamic> json) {
    final l$updateUserData = json['updateUserData'];
    final l$$__typename = json['__typename'];
    return Mutation$UpdateUserData(
      updateUserData: Mutation$UpdateUserData$updateUserData.fromJson(
          (l$updateUserData as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$UpdateUserData$updateUserData updateUserData;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateUserData = updateUserData;
    _resultData['updateUserData'] = l$updateUserData.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateUserData = updateUserData;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$updateUserData,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$UpdateUserData) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateUserData = updateUserData;
    final lOther$updateUserData = other.updateUserData;
    if (l$updateUserData != lOther$updateUserData) {
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

extension UtilityExtension$Mutation$UpdateUserData on Mutation$UpdateUserData {
  CopyWith$Mutation$UpdateUserData<Mutation$UpdateUserData> get copyWith =>
      CopyWith$Mutation$UpdateUserData(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$UpdateUserData<TRes> {
  factory CopyWith$Mutation$UpdateUserData(
    Mutation$UpdateUserData instance,
    TRes Function(Mutation$UpdateUserData) then,
  ) = _CopyWithImpl$Mutation$UpdateUserData;

  factory CopyWith$Mutation$UpdateUserData.stub(TRes res) =
      _CopyWithStubImpl$Mutation$UpdateUserData;

  TRes call({
    Mutation$UpdateUserData$updateUserData? updateUserData,
    String? $__typename,
  });
  CopyWith$Mutation$UpdateUserData$updateUserData<TRes> get updateUserData;
}

class _CopyWithImpl$Mutation$UpdateUserData<TRes>
    implements CopyWith$Mutation$UpdateUserData<TRes> {
  _CopyWithImpl$Mutation$UpdateUserData(
    this._instance,
    this._then,
  );

  final Mutation$UpdateUserData _instance;

  final TRes Function(Mutation$UpdateUserData) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? updateUserData = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$UpdateUserData(
        updateUserData: updateUserData == _undefined || updateUserData == null
            ? _instance.updateUserData
            : (updateUserData as Mutation$UpdateUserData$updateUserData),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$UpdateUserData$updateUserData<TRes> get updateUserData {
    final local$updateUserData = _instance.updateUserData;
    return CopyWith$Mutation$UpdateUserData$updateUserData(
        local$updateUserData, (e) => call(updateUserData: e));
  }
}

class _CopyWithStubImpl$Mutation$UpdateUserData<TRes>
    implements CopyWith$Mutation$UpdateUserData<TRes> {
  _CopyWithStubImpl$Mutation$UpdateUserData(this._res);

  TRes _res;

  call({
    Mutation$UpdateUserData$updateUserData? updateUserData,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$UpdateUserData$updateUserData<TRes> get updateUserData =>
      CopyWith$Mutation$UpdateUserData$updateUserData.stub(_res);
}

const documentNodeMutationUpdateUserData = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'UpdateUserData'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'input')),
        type: NamedTypeNode(
          name: NameNode(value: 'UpdateUserDataInput'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'updateUserData'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'input'),
            value: VariableNode(name: NameNode(value: 'input')),
          )
        ],
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
Mutation$UpdateUserData _parserFn$Mutation$UpdateUserData(
        Map<String, dynamic> data) =>
    Mutation$UpdateUserData.fromJson(data);
typedef OnMutationCompleted$Mutation$UpdateUserData = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$UpdateUserData?,
);

class Options$Mutation$UpdateUserData
    extends graphql.MutationOptions<Mutation$UpdateUserData> {
  Options$Mutation$UpdateUserData({
    String? operationName,
    required Variables$Mutation$UpdateUserData variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$UpdateUserData? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$UpdateUserData? onCompleted,
    graphql.OnMutationUpdate<Mutation$UpdateUserData>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$UpdateUserData(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationUpdateUserData,
          parserFn: _parserFn$Mutation$UpdateUserData,
        );

  final OnMutationCompleted$Mutation$UpdateUserData? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$UpdateUserData
    extends graphql.WatchQueryOptions<Mutation$UpdateUserData> {
  WatchOptions$Mutation$UpdateUserData({
    String? operationName,
    required Variables$Mutation$UpdateUserData variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$UpdateUserData? typedOptimisticResult,
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
          document: documentNodeMutationUpdateUserData,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$UpdateUserData,
        );
}

extension ClientExtension$Mutation$UpdateUserData on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$UpdateUserData>> mutate$UpdateUserData(
          Options$Mutation$UpdateUserData options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$UpdateUserData> watchMutation$UpdateUserData(
          WatchOptions$Mutation$UpdateUserData options) =>
      this.watchMutation(options);
}

class Mutation$UpdateUserData$HookResult {
  Mutation$UpdateUserData$HookResult(
    this.runMutation,
    this.result,
  );

  final RunMutation$Mutation$UpdateUserData runMutation;

  final graphql.QueryResult<Mutation$UpdateUserData> result;
}

Mutation$UpdateUserData$HookResult useMutation$UpdateUserData(
    [WidgetOptions$Mutation$UpdateUserData? options]) {
  final result = graphql_flutter
      .useMutation(options ?? WidgetOptions$Mutation$UpdateUserData());
  return Mutation$UpdateUserData$HookResult(
    (variables, {optimisticResult, typedOptimisticResult}) =>
        result.runMutation(
      variables.toJson(),
      optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
    ),
    result.result,
  );
}

graphql.ObservableQuery<Mutation$UpdateUserData>
    useWatchMutation$UpdateUserData(
            WatchOptions$Mutation$UpdateUserData options) =>
        graphql_flutter.useWatchMutation(options);

class WidgetOptions$Mutation$UpdateUserData
    extends graphql.MutationOptions<Mutation$UpdateUserData> {
  WidgetOptions$Mutation$UpdateUserData({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$UpdateUserData? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$UpdateUserData? onCompleted,
    graphql.OnMutationUpdate<Mutation$UpdateUserData>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$UpdateUserData(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationUpdateUserData,
          parserFn: _parserFn$Mutation$UpdateUserData,
        );

  final OnMutationCompleted$Mutation$UpdateUserData? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

typedef RunMutation$Mutation$UpdateUserData
    = graphql.MultiSourceResult<Mutation$UpdateUserData> Function(
  Variables$Mutation$UpdateUserData, {
  Object? optimisticResult,
  Mutation$UpdateUserData? typedOptimisticResult,
});
typedef Builder$Mutation$UpdateUserData = widgets.Widget Function(
  RunMutation$Mutation$UpdateUserData,
  graphql.QueryResult<Mutation$UpdateUserData>?,
);

class Mutation$UpdateUserData$Widget
    extends graphql_flutter.Mutation<Mutation$UpdateUserData> {
  Mutation$UpdateUserData$Widget({
    widgets.Key? key,
    WidgetOptions$Mutation$UpdateUserData? options,
    required Builder$Mutation$UpdateUserData builder,
  }) : super(
          key: key,
          options: options ?? WidgetOptions$Mutation$UpdateUserData(),
          builder: (
            run,
            result,
          ) =>
              builder(
            (
              variables, {
              optimisticResult,
              typedOptimisticResult,
            }) =>
                run(
              variables.toJson(),
              optimisticResult:
                  optimisticResult ?? typedOptimisticResult?.toJson(),
            ),
            result,
          ),
        );
}

class Mutation$UpdateUserData$updateUserData {
  Mutation$UpdateUserData$updateUserData({
    required this.userInfo,
    this.$__typename = 'UpdateUserDataResponse',
  });

  factory Mutation$UpdateUserData$updateUserData.fromJson(
      Map<String, dynamic> json) {
    final l$userInfo = json['userInfo'];
    final l$$__typename = json['__typename'];
    return Mutation$UpdateUserData$updateUserData(
      userInfo: Mutation$UpdateUserData$updateUserData$userInfo.fromJson(
          (l$userInfo as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$UpdateUserData$updateUserData$userInfo userInfo;

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
    if (!(other is Mutation$UpdateUserData$updateUserData) ||
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

extension UtilityExtension$Mutation$UpdateUserData$updateUserData
    on Mutation$UpdateUserData$updateUserData {
  CopyWith$Mutation$UpdateUserData$updateUserData<
          Mutation$UpdateUserData$updateUserData>
      get copyWith => CopyWith$Mutation$UpdateUserData$updateUserData(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$UpdateUserData$updateUserData<TRes> {
  factory CopyWith$Mutation$UpdateUserData$updateUserData(
    Mutation$UpdateUserData$updateUserData instance,
    TRes Function(Mutation$UpdateUserData$updateUserData) then,
  ) = _CopyWithImpl$Mutation$UpdateUserData$updateUserData;

  factory CopyWith$Mutation$UpdateUserData$updateUserData.stub(TRes res) =
      _CopyWithStubImpl$Mutation$UpdateUserData$updateUserData;

  TRes call({
    Mutation$UpdateUserData$updateUserData$userInfo? userInfo,
    String? $__typename,
  });
  CopyWith$Mutation$UpdateUserData$updateUserData$userInfo<TRes> get userInfo;
}

class _CopyWithImpl$Mutation$UpdateUserData$updateUserData<TRes>
    implements CopyWith$Mutation$UpdateUserData$updateUserData<TRes> {
  _CopyWithImpl$Mutation$UpdateUserData$updateUserData(
    this._instance,
    this._then,
  );

  final Mutation$UpdateUserData$updateUserData _instance;

  final TRes Function(Mutation$UpdateUserData$updateUserData) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? userInfo = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$UpdateUserData$updateUserData(
        userInfo: userInfo == _undefined || userInfo == null
            ? _instance.userInfo
            : (userInfo as Mutation$UpdateUserData$updateUserData$userInfo),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$UpdateUserData$updateUserData$userInfo<TRes> get userInfo {
    final local$userInfo = _instance.userInfo;
    return CopyWith$Mutation$UpdateUserData$updateUserData$userInfo(
        local$userInfo, (e) => call(userInfo: e));
  }
}

class _CopyWithStubImpl$Mutation$UpdateUserData$updateUserData<TRes>
    implements CopyWith$Mutation$UpdateUserData$updateUserData<TRes> {
  _CopyWithStubImpl$Mutation$UpdateUserData$updateUserData(this._res);

  TRes _res;

  call({
    Mutation$UpdateUserData$updateUserData$userInfo? userInfo,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$UpdateUserData$updateUserData$userInfo<TRes> get userInfo =>
      CopyWith$Mutation$UpdateUserData$updateUserData$userInfo.stub(_res);
}

class Mutation$UpdateUserData$updateUserData$userInfo {
  Mutation$UpdateUserData$updateUserData$userInfo({
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

  factory Mutation$UpdateUserData$updateUserData$userInfo.fromJson(
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
    return Mutation$UpdateUserData$updateUserData$userInfo(
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
              Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists
                  .fromJson((e as Map<String, dynamic>)))
          .toList(),
      primaryArtist: l$primaryArtist == null
          ? null
          : Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist
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

  final List<Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists>
      belongsToArtists;

  final Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist?
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
    if (!(other is Mutation$UpdateUserData$updateUserData$userInfo) ||
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

extension UtilityExtension$Mutation$UpdateUserData$updateUserData$userInfo
    on Mutation$UpdateUserData$updateUserData$userInfo {
  CopyWith$Mutation$UpdateUserData$updateUserData$userInfo<
          Mutation$UpdateUserData$updateUserData$userInfo>
      get copyWith => CopyWith$Mutation$UpdateUserData$updateUserData$userInfo(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$UpdateUserData$updateUserData$userInfo<TRes> {
  factory CopyWith$Mutation$UpdateUserData$updateUserData$userInfo(
    Mutation$UpdateUserData$updateUserData$userInfo instance,
    TRes Function(Mutation$UpdateUserData$updateUserData$userInfo) then,
  ) = _CopyWithImpl$Mutation$UpdateUserData$updateUserData$userInfo;

  factory CopyWith$Mutation$UpdateUserData$updateUserData$userInfo.stub(
          TRes res) =
      _CopyWithStubImpl$Mutation$UpdateUserData$updateUserData$userInfo;

  TRes call({
    String? id,
    String? email,
    String? name,
    String? imageUrl,
    int? fspBalance,
    int? credentialBalance,
    String? role,
    String? primaryRole,
    List<Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists>?
        belongsToArtists,
    Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist?
        primaryArtist,
    String? $__typename,
  });
  TRes belongsToArtists(
      Iterable<Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists> Function(
              Iterable<
                  CopyWith$Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists<
                      Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists>>)
          _fn);
  CopyWith$Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist<TRes>
      get primaryArtist;
}

class _CopyWithImpl$Mutation$UpdateUserData$updateUserData$userInfo<TRes>
    implements CopyWith$Mutation$UpdateUserData$updateUserData$userInfo<TRes> {
  _CopyWithImpl$Mutation$UpdateUserData$updateUserData$userInfo(
    this._instance,
    this._then,
  );

  final Mutation$UpdateUserData$updateUserData$userInfo _instance;

  final TRes Function(Mutation$UpdateUserData$updateUserData$userInfo) _then;

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
      _then(Mutation$UpdateUserData$updateUserData$userInfo(
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
                Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists>),
        primaryArtist: primaryArtist == _undefined
            ? _instance.primaryArtist
            : (primaryArtist
                as Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes belongsToArtists(
          Iterable<Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists> Function(
                  Iterable<
                      CopyWith$Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists<
                          Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists>>)
              _fn) =>
      call(
          belongsToArtists: _fn(_instance.belongsToArtists.map((e) =>
              CopyWith$Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists(
                e,
                (i) => i,
              ))).toList());

  CopyWith$Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist<TRes>
      get primaryArtist {
    final local$primaryArtist = _instance.primaryArtist;
    return local$primaryArtist == null
        ? CopyWith$Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist
            .stub(_then(_instance))
        : CopyWith$Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist(
            local$primaryArtist, (e) => call(primaryArtist: e));
  }
}

class _CopyWithStubImpl$Mutation$UpdateUserData$updateUserData$userInfo<TRes>
    implements CopyWith$Mutation$UpdateUserData$updateUserData$userInfo<TRes> {
  _CopyWithStubImpl$Mutation$UpdateUserData$updateUserData$userInfo(this._res);

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
    List<Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists>?
        belongsToArtists,
    Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist?
        primaryArtist,
    String? $__typename,
  }) =>
      _res;

  belongsToArtists(_fn) => _res;

  CopyWith$Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist<TRes>
      get primaryArtist =>
          CopyWith$Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist
              .stub(_res);
}

class Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists {
  Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.fsp,
    required this.status,
    required this.isAdmin,
    this.$__typename = 'ArtistByUserData',
  });

  factory Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$imageUrl = json['imageUrl'];
    final l$fsp = json['fsp'];
    final l$status = json['status'];
    final l$isAdmin = json['isAdmin'];
    final l$$__typename = json['__typename'];
    return Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists(
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
            is Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists) ||
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

extension UtilityExtension$Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists
    on Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists {
  CopyWith$Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists<
          Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists>
      get copyWith =>
          CopyWith$Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists<
    TRes> {
  factory CopyWith$Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists(
    Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists instance,
    TRes Function(
            Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists)
        then,
  ) = _CopyWithImpl$Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists;

  factory CopyWith$Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists.stub(
          TRes res) =
      _CopyWithStubImpl$Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists;

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

class _CopyWithImpl$Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists<
        TRes>
    implements
        CopyWith$Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists<
            TRes> {
  _CopyWithImpl$Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists(
    this._instance,
    this._then,
  );

  final Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists
      _instance;

  final TRes Function(
      Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists) _then;

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
      _then(Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists(
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

class _CopyWithStubImpl$Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists<
        TRes>
    implements
        CopyWith$Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists<
            TRes> {
  _CopyWithStubImpl$Mutation$UpdateUserData$updateUserData$userInfo$belongsToArtists(
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

class Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist {
  Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.fsp,
    required this.status,
    required this.isAdmin,
    this.$__typename = 'ArtistByUserData',
  });

  factory Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$imageUrl = json['imageUrl'];
    final l$fsp = json['fsp'];
    final l$status = json['status'];
    final l$isAdmin = json['isAdmin'];
    final l$$__typename = json['__typename'];
    return Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist(
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
            is Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist) ||
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

extension UtilityExtension$Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist
    on Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist {
  CopyWith$Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist<
          Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist>
      get copyWith =>
          CopyWith$Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist<
    TRes> {
  factory CopyWith$Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist(
    Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist instance,
    TRes Function(Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist)
        then,
  ) = _CopyWithImpl$Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist;

  factory CopyWith$Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist.stub(
          TRes res) =
      _CopyWithStubImpl$Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist;

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

class _CopyWithImpl$Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist<
        TRes>
    implements
        CopyWith$Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist<
            TRes> {
  _CopyWithImpl$Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist(
    this._instance,
    this._then,
  );

  final Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist _instance;

  final TRes Function(
      Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist) _then;

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
      _then(Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist(
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

class _CopyWithStubImpl$Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist<
        TRes>
    implements
        CopyWith$Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist<
            TRes> {
  _CopyWithStubImpl$Mutation$UpdateUserData$updateUserData$userInfo$primaryArtist(
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

class Variables$Mutation$UpdateBelongsToArtistStatus {
  factory Variables$Mutation$UpdateBelongsToArtistStatus(
          {required Input$UpdateBelongsToArtistStatusInput input}) =>
      Variables$Mutation$UpdateBelongsToArtistStatus._({
        r'input': input,
      });

  Variables$Mutation$UpdateBelongsToArtistStatus._(this._$data);

  factory Variables$Mutation$UpdateBelongsToArtistStatus.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] = Input$UpdateBelongsToArtistStatusInput.fromJson(
        (l$input as Map<String, dynamic>));
    return Variables$Mutation$UpdateBelongsToArtistStatus._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$UpdateBelongsToArtistStatusInput get input =>
      (_$data['input'] as Input$UpdateBelongsToArtistStatusInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$UpdateBelongsToArtistStatus<
          Variables$Mutation$UpdateBelongsToArtistStatus>
      get copyWith => CopyWith$Variables$Mutation$UpdateBelongsToArtistStatus(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$UpdateBelongsToArtistStatus) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }
}

abstract class CopyWith$Variables$Mutation$UpdateBelongsToArtistStatus<TRes> {
  factory CopyWith$Variables$Mutation$UpdateBelongsToArtistStatus(
    Variables$Mutation$UpdateBelongsToArtistStatus instance,
    TRes Function(Variables$Mutation$UpdateBelongsToArtistStatus) then,
  ) = _CopyWithImpl$Variables$Mutation$UpdateBelongsToArtistStatus;

  factory CopyWith$Variables$Mutation$UpdateBelongsToArtistStatus.stub(
          TRes res) =
      _CopyWithStubImpl$Variables$Mutation$UpdateBelongsToArtistStatus;

  TRes call({Input$UpdateBelongsToArtistStatusInput? input});
}

class _CopyWithImpl$Variables$Mutation$UpdateBelongsToArtistStatus<TRes>
    implements CopyWith$Variables$Mutation$UpdateBelongsToArtistStatus<TRes> {
  _CopyWithImpl$Variables$Mutation$UpdateBelongsToArtistStatus(
    this._instance,
    this._then,
  );

  final Variables$Mutation$UpdateBelongsToArtistStatus _instance;

  final TRes Function(Variables$Mutation$UpdateBelongsToArtistStatus) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? input = _undefined}) =>
      _then(Variables$Mutation$UpdateBelongsToArtistStatus._({
        ..._instance._$data,
        if (input != _undefined && input != null)
          'input': (input as Input$UpdateBelongsToArtistStatusInput),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$UpdateBelongsToArtistStatus<TRes>
    implements CopyWith$Variables$Mutation$UpdateBelongsToArtistStatus<TRes> {
  _CopyWithStubImpl$Variables$Mutation$UpdateBelongsToArtistStatus(this._res);

  TRes _res;

  call({Input$UpdateBelongsToArtistStatusInput? input}) => _res;
}

class Mutation$UpdateBelongsToArtistStatus {
  Mutation$UpdateBelongsToArtistStatus({
    required this.updateBelongsToArtistStatus,
    this.$__typename = 'MutationRoot',
  });

  factory Mutation$UpdateBelongsToArtistStatus.fromJson(
      Map<String, dynamic> json) {
    final l$updateBelongsToArtistStatus = json['updateBelongsToArtistStatus'];
    final l$$__typename = json['__typename'];
    return Mutation$UpdateBelongsToArtistStatus(
      updateBelongsToArtistStatus:
          Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus
              .fromJson(
                  (l$updateBelongsToArtistStatus as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus
      updateBelongsToArtistStatus;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateBelongsToArtistStatus = updateBelongsToArtistStatus;
    _resultData['updateBelongsToArtistStatus'] =
        l$updateBelongsToArtistStatus.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateBelongsToArtistStatus = updateBelongsToArtistStatus;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$updateBelongsToArtistStatus,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$UpdateBelongsToArtistStatus) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateBelongsToArtistStatus = updateBelongsToArtistStatus;
    final lOther$updateBelongsToArtistStatus =
        other.updateBelongsToArtistStatus;
    if (l$updateBelongsToArtistStatus != lOther$updateBelongsToArtistStatus) {
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

extension UtilityExtension$Mutation$UpdateBelongsToArtistStatus
    on Mutation$UpdateBelongsToArtistStatus {
  CopyWith$Mutation$UpdateBelongsToArtistStatus<
          Mutation$UpdateBelongsToArtistStatus>
      get copyWith => CopyWith$Mutation$UpdateBelongsToArtistStatus(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$UpdateBelongsToArtistStatus<TRes> {
  factory CopyWith$Mutation$UpdateBelongsToArtistStatus(
    Mutation$UpdateBelongsToArtistStatus instance,
    TRes Function(Mutation$UpdateBelongsToArtistStatus) then,
  ) = _CopyWithImpl$Mutation$UpdateBelongsToArtistStatus;

  factory CopyWith$Mutation$UpdateBelongsToArtistStatus.stub(TRes res) =
      _CopyWithStubImpl$Mutation$UpdateBelongsToArtistStatus;

  TRes call({
    Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus?
        updateBelongsToArtistStatus,
    String? $__typename,
  });
  CopyWith$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus<
      TRes> get updateBelongsToArtistStatus;
}

class _CopyWithImpl$Mutation$UpdateBelongsToArtistStatus<TRes>
    implements CopyWith$Mutation$UpdateBelongsToArtistStatus<TRes> {
  _CopyWithImpl$Mutation$UpdateBelongsToArtistStatus(
    this._instance,
    this._then,
  );

  final Mutation$UpdateBelongsToArtistStatus _instance;

  final TRes Function(Mutation$UpdateBelongsToArtistStatus) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? updateBelongsToArtistStatus = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$UpdateBelongsToArtistStatus(
        updateBelongsToArtistStatus: updateBelongsToArtistStatus ==
                    _undefined ||
                updateBelongsToArtistStatus == null
            ? _instance.updateBelongsToArtistStatus
            : (updateBelongsToArtistStatus
                as Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus<
      TRes> get updateBelongsToArtistStatus {
    final local$updateBelongsToArtistStatus =
        _instance.updateBelongsToArtistStatus;
    return CopyWith$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus(
        local$updateBelongsToArtistStatus,
        (e) => call(updateBelongsToArtistStatus: e));
  }
}

class _CopyWithStubImpl$Mutation$UpdateBelongsToArtistStatus<TRes>
    implements CopyWith$Mutation$UpdateBelongsToArtistStatus<TRes> {
  _CopyWithStubImpl$Mutation$UpdateBelongsToArtistStatus(this._res);

  TRes _res;

  call({
    Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus?
        updateBelongsToArtistStatus,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus<
          TRes>
      get updateBelongsToArtistStatus =>
          CopyWith$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus
              .stub(_res);
}

const documentNodeMutationUpdateBelongsToArtistStatus =
    DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'UpdateBelongsToArtistStatus'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'input')),
        type: NamedTypeNode(
          name: NameNode(value: 'UpdateBelongsToArtistStatusInput'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'updateBelongsToArtistStatus'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'input'),
            value: VariableNode(name: NameNode(value: 'input')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'updatedUserArtist'),
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
Mutation$UpdateBelongsToArtistStatus
    _parserFn$Mutation$UpdateBelongsToArtistStatus(Map<String, dynamic> data) =>
        Mutation$UpdateBelongsToArtistStatus.fromJson(data);
typedef OnMutationCompleted$Mutation$UpdateBelongsToArtistStatus
    = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$UpdateBelongsToArtistStatus?,
);

class Options$Mutation$UpdateBelongsToArtistStatus
    extends graphql.MutationOptions<Mutation$UpdateBelongsToArtistStatus> {
  Options$Mutation$UpdateBelongsToArtistStatus({
    String? operationName,
    required Variables$Mutation$UpdateBelongsToArtistStatus variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$UpdateBelongsToArtistStatus? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$UpdateBelongsToArtistStatus? onCompleted,
    graphql.OnMutationUpdate<Mutation$UpdateBelongsToArtistStatus>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$UpdateBelongsToArtistStatus(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationUpdateBelongsToArtistStatus,
          parserFn: _parserFn$Mutation$UpdateBelongsToArtistStatus,
        );

  final OnMutationCompleted$Mutation$UpdateBelongsToArtistStatus?
      onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$UpdateBelongsToArtistStatus
    extends graphql.WatchQueryOptions<Mutation$UpdateBelongsToArtistStatus> {
  WatchOptions$Mutation$UpdateBelongsToArtistStatus({
    String? operationName,
    required Variables$Mutation$UpdateBelongsToArtistStatus variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$UpdateBelongsToArtistStatus? typedOptimisticResult,
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
          document: documentNodeMutationUpdateBelongsToArtistStatus,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$UpdateBelongsToArtistStatus,
        );
}

extension ClientExtension$Mutation$UpdateBelongsToArtistStatus
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$UpdateBelongsToArtistStatus>>
      mutate$UpdateBelongsToArtistStatus(
              Options$Mutation$UpdateBelongsToArtistStatus options) async =>
          await this.mutate(options);
  graphql.ObservableQuery<Mutation$UpdateBelongsToArtistStatus>
      watchMutation$UpdateBelongsToArtistStatus(
              WatchOptions$Mutation$UpdateBelongsToArtistStatus options) =>
          this.watchMutation(options);
}

class Mutation$UpdateBelongsToArtistStatus$HookResult {
  Mutation$UpdateBelongsToArtistStatus$HookResult(
    this.runMutation,
    this.result,
  );

  final RunMutation$Mutation$UpdateBelongsToArtistStatus runMutation;

  final graphql.QueryResult<Mutation$UpdateBelongsToArtistStatus> result;
}

Mutation$UpdateBelongsToArtistStatus$HookResult
    useMutation$UpdateBelongsToArtistStatus(
        [WidgetOptions$Mutation$UpdateBelongsToArtistStatus? options]) {
  final result = graphql_flutter.useMutation(
      options ?? WidgetOptions$Mutation$UpdateBelongsToArtistStatus());
  return Mutation$UpdateBelongsToArtistStatus$HookResult(
    (variables, {optimisticResult, typedOptimisticResult}) =>
        result.runMutation(
      variables.toJson(),
      optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
    ),
    result.result,
  );
}

graphql.ObservableQuery<Mutation$UpdateBelongsToArtistStatus>
    useWatchMutation$UpdateBelongsToArtistStatus(
            WatchOptions$Mutation$UpdateBelongsToArtistStatus options) =>
        graphql_flutter.useWatchMutation(options);

class WidgetOptions$Mutation$UpdateBelongsToArtistStatus
    extends graphql.MutationOptions<Mutation$UpdateBelongsToArtistStatus> {
  WidgetOptions$Mutation$UpdateBelongsToArtistStatus({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$UpdateBelongsToArtistStatus? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$UpdateBelongsToArtistStatus? onCompleted,
    graphql.OnMutationUpdate<Mutation$UpdateBelongsToArtistStatus>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$UpdateBelongsToArtistStatus(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationUpdateBelongsToArtistStatus,
          parserFn: _parserFn$Mutation$UpdateBelongsToArtistStatus,
        );

  final OnMutationCompleted$Mutation$UpdateBelongsToArtistStatus?
      onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

typedef RunMutation$Mutation$UpdateBelongsToArtistStatus
    = graphql.MultiSourceResult<Mutation$UpdateBelongsToArtistStatus> Function(
  Variables$Mutation$UpdateBelongsToArtistStatus, {
  Object? optimisticResult,
  Mutation$UpdateBelongsToArtistStatus? typedOptimisticResult,
});
typedef Builder$Mutation$UpdateBelongsToArtistStatus = widgets.Widget Function(
  RunMutation$Mutation$UpdateBelongsToArtistStatus,
  graphql.QueryResult<Mutation$UpdateBelongsToArtistStatus>?,
);

class Mutation$UpdateBelongsToArtistStatus$Widget
    extends graphql_flutter.Mutation<Mutation$UpdateBelongsToArtistStatus> {
  Mutation$UpdateBelongsToArtistStatus$Widget({
    widgets.Key? key,
    WidgetOptions$Mutation$UpdateBelongsToArtistStatus? options,
    required Builder$Mutation$UpdateBelongsToArtistStatus builder,
  }) : super(
          key: key,
          options:
              options ?? WidgetOptions$Mutation$UpdateBelongsToArtistStatus(),
          builder: (
            run,
            result,
          ) =>
              builder(
            (
              variables, {
              optimisticResult,
              typedOptimisticResult,
            }) =>
                run(
              variables.toJson(),
              optimisticResult:
                  optimisticResult ?? typedOptimisticResult?.toJson(),
            ),
            result,
          ),
        );
}

class Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus {
  Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus({
    required this.updatedUserArtist,
    this.$__typename = 'UpdateBelongsToArtistStatusResponse',
  });

  factory Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus.fromJson(
      Map<String, dynamic> json) {
    final l$updatedUserArtist = json['updatedUserArtist'];
    final l$$__typename = json['__typename'];
    return Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus(
      updatedUserArtist:
          Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist
              .fromJson((l$updatedUserArtist as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist
      updatedUserArtist;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updatedUserArtist = updatedUserArtist;
    _resultData['updatedUserArtist'] = l$updatedUserArtist.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updatedUserArtist = updatedUserArtist;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$updatedUserArtist,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other
            is Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$updatedUserArtist = updatedUserArtist;
    final lOther$updatedUserArtist = other.updatedUserArtist;
    if (l$updatedUserArtist != lOther$updatedUserArtist) {
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

extension UtilityExtension$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus
    on Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus {
  CopyWith$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus<
          Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus>
      get copyWith =>
          CopyWith$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus<
    TRes> {
  factory CopyWith$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus(
    Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus instance,
    TRes Function(
            Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus)
        then,
  ) = _CopyWithImpl$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus;

  factory CopyWith$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus.stub(
          TRes res) =
      _CopyWithStubImpl$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus;

  TRes call({
    Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist?
        updatedUserArtist,
    String? $__typename,
  });
  CopyWith$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist<
      TRes> get updatedUserArtist;
}

class _CopyWithImpl$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus<
        TRes>
    implements
        CopyWith$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus<
            TRes> {
  _CopyWithImpl$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus(
    this._instance,
    this._then,
  );

  final Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus
      _instance;

  final TRes Function(
      Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? updatedUserArtist = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus(
        updatedUserArtist: updatedUserArtist == _undefined ||
                updatedUserArtist == null
            ? _instance.updatedUserArtist
            : (updatedUserArtist
                as Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist<
      TRes> get updatedUserArtist {
    final local$updatedUserArtist = _instance.updatedUserArtist;
    return CopyWith$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist(
        local$updatedUserArtist, (e) => call(updatedUserArtist: e));
  }
}

class _CopyWithStubImpl$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus<
        TRes>
    implements
        CopyWith$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus<
            TRes> {
  _CopyWithStubImpl$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus(
      this._res);

  TRes _res;

  call({
    Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist?
        updatedUserArtist,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist<
          TRes>
      get updatedUserArtist =>
          CopyWith$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist
              .stub(_res);
}

class Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist {
  Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.fsp,
    required this.status,
    required this.isAdmin,
    this.$__typename = 'ArtistByUserData',
  });

  factory Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$imageUrl = json['imageUrl'];
    final l$fsp = json['fsp'];
    final l$status = json['status'];
    final l$isAdmin = json['isAdmin'];
    final l$$__typename = json['__typename'];
    return Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist(
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
            is Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist) ||
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

extension UtilityExtension$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist
    on Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist {
  CopyWith$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist<
          Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist>
      get copyWith =>
          CopyWith$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist<
    TRes> {
  factory CopyWith$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist(
    Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist
        instance,
    TRes Function(
            Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist)
        then,
  ) = _CopyWithImpl$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist;

  factory CopyWith$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist.stub(
          TRes res) =
      _CopyWithStubImpl$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist;

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

class _CopyWithImpl$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist<
        TRes>
    implements
        CopyWith$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist<
            TRes> {
  _CopyWithImpl$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist(
    this._instance,
    this._then,
  );

  final Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist
      _instance;

  final TRes Function(
          Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist)
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
          Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist(
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

class _CopyWithStubImpl$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist<
        TRes>
    implements
        CopyWith$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist<
            TRes> {
  _CopyWithStubImpl$Mutation$UpdateBelongsToArtistStatus$updateBelongsToArtistStatus$updatedUserArtist(
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

class Variables$Mutation$ContactToAdmin {
  factory Variables$Mutation$ContactToAdmin(
          {required Input$ContactToAdminInput input}) =>
      Variables$Mutation$ContactToAdmin._({
        r'input': input,
      });

  Variables$Mutation$ContactToAdmin._(this._$data);

  factory Variables$Mutation$ContactToAdmin.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] =
        Input$ContactToAdminInput.fromJson((l$input as Map<String, dynamic>));
    return Variables$Mutation$ContactToAdmin._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$ContactToAdminInput get input =>
      (_$data['input'] as Input$ContactToAdminInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$ContactToAdmin<Variables$Mutation$ContactToAdmin>
      get copyWith => CopyWith$Variables$Mutation$ContactToAdmin(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$ContactToAdmin) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }
}

abstract class CopyWith$Variables$Mutation$ContactToAdmin<TRes> {
  factory CopyWith$Variables$Mutation$ContactToAdmin(
    Variables$Mutation$ContactToAdmin instance,
    TRes Function(Variables$Mutation$ContactToAdmin) then,
  ) = _CopyWithImpl$Variables$Mutation$ContactToAdmin;

  factory CopyWith$Variables$Mutation$ContactToAdmin.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$ContactToAdmin;

  TRes call({Input$ContactToAdminInput? input});
}

class _CopyWithImpl$Variables$Mutation$ContactToAdmin<TRes>
    implements CopyWith$Variables$Mutation$ContactToAdmin<TRes> {
  _CopyWithImpl$Variables$Mutation$ContactToAdmin(
    this._instance,
    this._then,
  );

  final Variables$Mutation$ContactToAdmin _instance;

  final TRes Function(Variables$Mutation$ContactToAdmin) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? input = _undefined}) =>
      _then(Variables$Mutation$ContactToAdmin._({
        ..._instance._$data,
        if (input != _undefined && input != null)
          'input': (input as Input$ContactToAdminInput),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$ContactToAdmin<TRes>
    implements CopyWith$Variables$Mutation$ContactToAdmin<TRes> {
  _CopyWithStubImpl$Variables$Mutation$ContactToAdmin(this._res);

  TRes _res;

  call({Input$ContactToAdminInput? input}) => _res;
}

class Mutation$ContactToAdmin {
  Mutation$ContactToAdmin({
    required this.contactToAdmin,
    this.$__typename = 'MutationRoot',
  });

  factory Mutation$ContactToAdmin.fromJson(Map<String, dynamic> json) {
    final l$contactToAdmin = json['contactToAdmin'];
    final l$$__typename = json['__typename'];
    return Mutation$ContactToAdmin(
      contactToAdmin: Mutation$ContactToAdmin$contactToAdmin.fromJson(
          (l$contactToAdmin as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$ContactToAdmin$contactToAdmin contactToAdmin;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$contactToAdmin = contactToAdmin;
    _resultData['contactToAdmin'] = l$contactToAdmin.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$contactToAdmin = contactToAdmin;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$contactToAdmin,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$ContactToAdmin) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$contactToAdmin = contactToAdmin;
    final lOther$contactToAdmin = other.contactToAdmin;
    if (l$contactToAdmin != lOther$contactToAdmin) {
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

extension UtilityExtension$Mutation$ContactToAdmin on Mutation$ContactToAdmin {
  CopyWith$Mutation$ContactToAdmin<Mutation$ContactToAdmin> get copyWith =>
      CopyWith$Mutation$ContactToAdmin(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$ContactToAdmin<TRes> {
  factory CopyWith$Mutation$ContactToAdmin(
    Mutation$ContactToAdmin instance,
    TRes Function(Mutation$ContactToAdmin) then,
  ) = _CopyWithImpl$Mutation$ContactToAdmin;

  factory CopyWith$Mutation$ContactToAdmin.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ContactToAdmin;

  TRes call({
    Mutation$ContactToAdmin$contactToAdmin? contactToAdmin,
    String? $__typename,
  });
  CopyWith$Mutation$ContactToAdmin$contactToAdmin<TRes> get contactToAdmin;
}

class _CopyWithImpl$Mutation$ContactToAdmin<TRes>
    implements CopyWith$Mutation$ContactToAdmin<TRes> {
  _CopyWithImpl$Mutation$ContactToAdmin(
    this._instance,
    this._then,
  );

  final Mutation$ContactToAdmin _instance;

  final TRes Function(Mutation$ContactToAdmin) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? contactToAdmin = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$ContactToAdmin(
        contactToAdmin: contactToAdmin == _undefined || contactToAdmin == null
            ? _instance.contactToAdmin
            : (contactToAdmin as Mutation$ContactToAdmin$contactToAdmin),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$ContactToAdmin$contactToAdmin<TRes> get contactToAdmin {
    final local$contactToAdmin = _instance.contactToAdmin;
    return CopyWith$Mutation$ContactToAdmin$contactToAdmin(
        local$contactToAdmin, (e) => call(contactToAdmin: e));
  }
}

class _CopyWithStubImpl$Mutation$ContactToAdmin<TRes>
    implements CopyWith$Mutation$ContactToAdmin<TRes> {
  _CopyWithStubImpl$Mutation$ContactToAdmin(this._res);

  TRes _res;

  call({
    Mutation$ContactToAdmin$contactToAdmin? contactToAdmin,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$ContactToAdmin$contactToAdmin<TRes> get contactToAdmin =>
      CopyWith$Mutation$ContactToAdmin$contactToAdmin.stub(_res);
}

const documentNodeMutationContactToAdmin = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'ContactToAdmin'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'input')),
        type: NamedTypeNode(
          name: NameNode(value: 'ContactToAdminInput'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'contactToAdmin'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'input'),
            value: VariableNode(name: NameNode(value: 'input')),
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
Mutation$ContactToAdmin _parserFn$Mutation$ContactToAdmin(
        Map<String, dynamic> data) =>
    Mutation$ContactToAdmin.fromJson(data);
typedef OnMutationCompleted$Mutation$ContactToAdmin = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$ContactToAdmin?,
);

class Options$Mutation$ContactToAdmin
    extends graphql.MutationOptions<Mutation$ContactToAdmin> {
  Options$Mutation$ContactToAdmin({
    String? operationName,
    required Variables$Mutation$ContactToAdmin variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$ContactToAdmin? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$ContactToAdmin? onCompleted,
    graphql.OnMutationUpdate<Mutation$ContactToAdmin>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$ContactToAdmin(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationContactToAdmin,
          parserFn: _parserFn$Mutation$ContactToAdmin,
        );

  final OnMutationCompleted$Mutation$ContactToAdmin? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$ContactToAdmin
    extends graphql.WatchQueryOptions<Mutation$ContactToAdmin> {
  WatchOptions$Mutation$ContactToAdmin({
    String? operationName,
    required Variables$Mutation$ContactToAdmin variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$ContactToAdmin? typedOptimisticResult,
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
          document: documentNodeMutationContactToAdmin,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$ContactToAdmin,
        );
}

extension ClientExtension$Mutation$ContactToAdmin on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$ContactToAdmin>> mutate$ContactToAdmin(
          Options$Mutation$ContactToAdmin options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$ContactToAdmin> watchMutation$ContactToAdmin(
          WatchOptions$Mutation$ContactToAdmin options) =>
      this.watchMutation(options);
}

class Mutation$ContactToAdmin$HookResult {
  Mutation$ContactToAdmin$HookResult(
    this.runMutation,
    this.result,
  );

  final RunMutation$Mutation$ContactToAdmin runMutation;

  final graphql.QueryResult<Mutation$ContactToAdmin> result;
}

Mutation$ContactToAdmin$HookResult useMutation$ContactToAdmin(
    [WidgetOptions$Mutation$ContactToAdmin? options]) {
  final result = graphql_flutter
      .useMutation(options ?? WidgetOptions$Mutation$ContactToAdmin());
  return Mutation$ContactToAdmin$HookResult(
    (variables, {optimisticResult, typedOptimisticResult}) =>
        result.runMutation(
      variables.toJson(),
      optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
    ),
    result.result,
  );
}

graphql.ObservableQuery<Mutation$ContactToAdmin>
    useWatchMutation$ContactToAdmin(
            WatchOptions$Mutation$ContactToAdmin options) =>
        graphql_flutter.useWatchMutation(options);

class WidgetOptions$Mutation$ContactToAdmin
    extends graphql.MutationOptions<Mutation$ContactToAdmin> {
  WidgetOptions$Mutation$ContactToAdmin({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$ContactToAdmin? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$ContactToAdmin? onCompleted,
    graphql.OnMutationUpdate<Mutation$ContactToAdmin>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$ContactToAdmin(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationContactToAdmin,
          parserFn: _parserFn$Mutation$ContactToAdmin,
        );

  final OnMutationCompleted$Mutation$ContactToAdmin? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

typedef RunMutation$Mutation$ContactToAdmin
    = graphql.MultiSourceResult<Mutation$ContactToAdmin> Function(
  Variables$Mutation$ContactToAdmin, {
  Object? optimisticResult,
  Mutation$ContactToAdmin? typedOptimisticResult,
});
typedef Builder$Mutation$ContactToAdmin = widgets.Widget Function(
  RunMutation$Mutation$ContactToAdmin,
  graphql.QueryResult<Mutation$ContactToAdmin>?,
);

class Mutation$ContactToAdmin$Widget
    extends graphql_flutter.Mutation<Mutation$ContactToAdmin> {
  Mutation$ContactToAdmin$Widget({
    widgets.Key? key,
    WidgetOptions$Mutation$ContactToAdmin? options,
    required Builder$Mutation$ContactToAdmin builder,
  }) : super(
          key: key,
          options: options ?? WidgetOptions$Mutation$ContactToAdmin(),
          builder: (
            run,
            result,
          ) =>
              builder(
            (
              variables, {
              optimisticResult,
              typedOptimisticResult,
            }) =>
                run(
              variables.toJson(),
              optimisticResult:
                  optimisticResult ?? typedOptimisticResult?.toJson(),
            ),
            result,
          ),
        );
}

class Mutation$ContactToAdmin$contactToAdmin {
  Mutation$ContactToAdmin$contactToAdmin({
    required this.id,
    this.$__typename = 'ContactToAdminResponse',
  });

  factory Mutation$ContactToAdmin$contactToAdmin.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$$__typename = json['__typename'];
    return Mutation$ContactToAdmin$contactToAdmin(
      id: (l$id as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$ContactToAdmin$contactToAdmin) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
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

extension UtilityExtension$Mutation$ContactToAdmin$contactToAdmin
    on Mutation$ContactToAdmin$contactToAdmin {
  CopyWith$Mutation$ContactToAdmin$contactToAdmin<
          Mutation$ContactToAdmin$contactToAdmin>
      get copyWith => CopyWith$Mutation$ContactToAdmin$contactToAdmin(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$ContactToAdmin$contactToAdmin<TRes> {
  factory CopyWith$Mutation$ContactToAdmin$contactToAdmin(
    Mutation$ContactToAdmin$contactToAdmin instance,
    TRes Function(Mutation$ContactToAdmin$contactToAdmin) then,
  ) = _CopyWithImpl$Mutation$ContactToAdmin$contactToAdmin;

  factory CopyWith$Mutation$ContactToAdmin$contactToAdmin.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ContactToAdmin$contactToAdmin;

  TRes call({
    String? id,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$ContactToAdmin$contactToAdmin<TRes>
    implements CopyWith$Mutation$ContactToAdmin$contactToAdmin<TRes> {
  _CopyWithImpl$Mutation$ContactToAdmin$contactToAdmin(
    this._instance,
    this._then,
  );

  final Mutation$ContactToAdmin$contactToAdmin _instance;

  final TRes Function(Mutation$ContactToAdmin$contactToAdmin) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$ContactToAdmin$contactToAdmin(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$ContactToAdmin$contactToAdmin<TRes>
    implements CopyWith$Mutation$ContactToAdmin$contactToAdmin<TRes> {
  _CopyWithStubImpl$Mutation$ContactToAdmin$contactToAdmin(this._res);

  TRes _res;

  call({
    String? id,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$CreateNewMessageRoom {
  factory Variables$Mutation$CreateNewMessageRoom(
          {required Input$CreateNewMessageRoomInput input}) =>
      Variables$Mutation$CreateNewMessageRoom._({
        r'input': input,
      });

  Variables$Mutation$CreateNewMessageRoom._(this._$data);

  factory Variables$Mutation$CreateNewMessageRoom.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] = Input$CreateNewMessageRoomInput.fromJson(
        (l$input as Map<String, dynamic>));
    return Variables$Mutation$CreateNewMessageRoom._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$CreateNewMessageRoomInput get input =>
      (_$data['input'] as Input$CreateNewMessageRoomInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$CreateNewMessageRoom<
          Variables$Mutation$CreateNewMessageRoom>
      get copyWith => CopyWith$Variables$Mutation$CreateNewMessageRoom(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$CreateNewMessageRoom) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }
}

abstract class CopyWith$Variables$Mutation$CreateNewMessageRoom<TRes> {
  factory CopyWith$Variables$Mutation$CreateNewMessageRoom(
    Variables$Mutation$CreateNewMessageRoom instance,
    TRes Function(Variables$Mutation$CreateNewMessageRoom) then,
  ) = _CopyWithImpl$Variables$Mutation$CreateNewMessageRoom;

  factory CopyWith$Variables$Mutation$CreateNewMessageRoom.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$CreateNewMessageRoom;

  TRes call({Input$CreateNewMessageRoomInput? input});
}

class _CopyWithImpl$Variables$Mutation$CreateNewMessageRoom<TRes>
    implements CopyWith$Variables$Mutation$CreateNewMessageRoom<TRes> {
  _CopyWithImpl$Variables$Mutation$CreateNewMessageRoom(
    this._instance,
    this._then,
  );

  final Variables$Mutation$CreateNewMessageRoom _instance;

  final TRes Function(Variables$Mutation$CreateNewMessageRoom) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? input = _undefined}) =>
      _then(Variables$Mutation$CreateNewMessageRoom._({
        ..._instance._$data,
        if (input != _undefined && input != null)
          'input': (input as Input$CreateNewMessageRoomInput),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$CreateNewMessageRoom<TRes>
    implements CopyWith$Variables$Mutation$CreateNewMessageRoom<TRes> {
  _CopyWithStubImpl$Variables$Mutation$CreateNewMessageRoom(this._res);

  TRes _res;

  call({Input$CreateNewMessageRoomInput? input}) => _res;
}

class Mutation$CreateNewMessageRoom {
  Mutation$CreateNewMessageRoom({
    required this.createNewMessageRoom,
    this.$__typename = 'MutationRoot',
  });

  factory Mutation$CreateNewMessageRoom.fromJson(Map<String, dynamic> json) {
    final l$createNewMessageRoom = json['createNewMessageRoom'];
    final l$$__typename = json['__typename'];
    return Mutation$CreateNewMessageRoom(
      createNewMessageRoom:
          Mutation$CreateNewMessageRoom$createNewMessageRoom.fromJson(
              (l$createNewMessageRoom as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$CreateNewMessageRoom$createNewMessageRoom createNewMessageRoom;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$createNewMessageRoom = createNewMessageRoom;
    _resultData['createNewMessageRoom'] = l$createNewMessageRoom.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$createNewMessageRoom = createNewMessageRoom;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$createNewMessageRoom,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$CreateNewMessageRoom) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$createNewMessageRoom = createNewMessageRoom;
    final lOther$createNewMessageRoom = other.createNewMessageRoom;
    if (l$createNewMessageRoom != lOther$createNewMessageRoom) {
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

extension UtilityExtension$Mutation$CreateNewMessageRoom
    on Mutation$CreateNewMessageRoom {
  CopyWith$Mutation$CreateNewMessageRoom<Mutation$CreateNewMessageRoom>
      get copyWith => CopyWith$Mutation$CreateNewMessageRoom(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$CreateNewMessageRoom<TRes> {
  factory CopyWith$Mutation$CreateNewMessageRoom(
    Mutation$CreateNewMessageRoom instance,
    TRes Function(Mutation$CreateNewMessageRoom) then,
  ) = _CopyWithImpl$Mutation$CreateNewMessageRoom;

  factory CopyWith$Mutation$CreateNewMessageRoom.stub(TRes res) =
      _CopyWithStubImpl$Mutation$CreateNewMessageRoom;

  TRes call({
    Mutation$CreateNewMessageRoom$createNewMessageRoom? createNewMessageRoom,
    String? $__typename,
  });
  CopyWith$Mutation$CreateNewMessageRoom$createNewMessageRoom<TRes>
      get createNewMessageRoom;
}

class _CopyWithImpl$Mutation$CreateNewMessageRoom<TRes>
    implements CopyWith$Mutation$CreateNewMessageRoom<TRes> {
  _CopyWithImpl$Mutation$CreateNewMessageRoom(
    this._instance,
    this._then,
  );

  final Mutation$CreateNewMessageRoom _instance;

  final TRes Function(Mutation$CreateNewMessageRoom) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? createNewMessageRoom = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$CreateNewMessageRoom(
        createNewMessageRoom:
            createNewMessageRoom == _undefined || createNewMessageRoom == null
                ? _instance.createNewMessageRoom
                : (createNewMessageRoom
                    as Mutation$CreateNewMessageRoom$createNewMessageRoom),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$CreateNewMessageRoom$createNewMessageRoom<TRes>
      get createNewMessageRoom {
    final local$createNewMessageRoom = _instance.createNewMessageRoom;
    return CopyWith$Mutation$CreateNewMessageRoom$createNewMessageRoom(
        local$createNewMessageRoom, (e) => call(createNewMessageRoom: e));
  }
}

class _CopyWithStubImpl$Mutation$CreateNewMessageRoom<TRes>
    implements CopyWith$Mutation$CreateNewMessageRoom<TRes> {
  _CopyWithStubImpl$Mutation$CreateNewMessageRoom(this._res);

  TRes _res;

  call({
    Mutation$CreateNewMessageRoom$createNewMessageRoom? createNewMessageRoom,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$CreateNewMessageRoom$createNewMessageRoom<TRes>
      get createNewMessageRoom =>
          CopyWith$Mutation$CreateNewMessageRoom$createNewMessageRoom.stub(
              _res);
}

const documentNodeMutationCreateNewMessageRoom = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'CreateNewMessageRoom'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'input')),
        type: NamedTypeNode(
          name: NameNode(value: 'CreateNewMessageRoomInput'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'createNewMessageRoom'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'input'),
            value: VariableNode(name: NameNode(value: 'input')),
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
Mutation$CreateNewMessageRoom _parserFn$Mutation$CreateNewMessageRoom(
        Map<String, dynamic> data) =>
    Mutation$CreateNewMessageRoom.fromJson(data);
typedef OnMutationCompleted$Mutation$CreateNewMessageRoom = FutureOr<void>
    Function(
  Map<String, dynamic>?,
  Mutation$CreateNewMessageRoom?,
);

class Options$Mutation$CreateNewMessageRoom
    extends graphql.MutationOptions<Mutation$CreateNewMessageRoom> {
  Options$Mutation$CreateNewMessageRoom({
    String? operationName,
    required Variables$Mutation$CreateNewMessageRoom variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreateNewMessageRoom? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$CreateNewMessageRoom? onCompleted,
    graphql.OnMutationUpdate<Mutation$CreateNewMessageRoom>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$CreateNewMessageRoom(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationCreateNewMessageRoom,
          parserFn: _parserFn$Mutation$CreateNewMessageRoom,
        );

  final OnMutationCompleted$Mutation$CreateNewMessageRoom?
      onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$CreateNewMessageRoom
    extends graphql.WatchQueryOptions<Mutation$CreateNewMessageRoom> {
  WatchOptions$Mutation$CreateNewMessageRoom({
    String? operationName,
    required Variables$Mutation$CreateNewMessageRoom variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreateNewMessageRoom? typedOptimisticResult,
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
          document: documentNodeMutationCreateNewMessageRoom,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$CreateNewMessageRoom,
        );
}

extension ClientExtension$Mutation$CreateNewMessageRoom
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$CreateNewMessageRoom>>
      mutate$CreateNewMessageRoom(
              Options$Mutation$CreateNewMessageRoom options) async =>
          await this.mutate(options);
  graphql.ObservableQuery<Mutation$CreateNewMessageRoom>
      watchMutation$CreateNewMessageRoom(
              WatchOptions$Mutation$CreateNewMessageRoom options) =>
          this.watchMutation(options);
}

class Mutation$CreateNewMessageRoom$HookResult {
  Mutation$CreateNewMessageRoom$HookResult(
    this.runMutation,
    this.result,
  );

  final RunMutation$Mutation$CreateNewMessageRoom runMutation;

  final graphql.QueryResult<Mutation$CreateNewMessageRoom> result;
}

Mutation$CreateNewMessageRoom$HookResult useMutation$CreateNewMessageRoom(
    [WidgetOptions$Mutation$CreateNewMessageRoom? options]) {
  final result = graphql_flutter
      .useMutation(options ?? WidgetOptions$Mutation$CreateNewMessageRoom());
  return Mutation$CreateNewMessageRoom$HookResult(
    (variables, {optimisticResult, typedOptimisticResult}) =>
        result.runMutation(
      variables.toJson(),
      optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
    ),
    result.result,
  );
}

graphql.ObservableQuery<Mutation$CreateNewMessageRoom>
    useWatchMutation$CreateNewMessageRoom(
            WatchOptions$Mutation$CreateNewMessageRoom options) =>
        graphql_flutter.useWatchMutation(options);

class WidgetOptions$Mutation$CreateNewMessageRoom
    extends graphql.MutationOptions<Mutation$CreateNewMessageRoom> {
  WidgetOptions$Mutation$CreateNewMessageRoom({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreateNewMessageRoom? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$CreateNewMessageRoom? onCompleted,
    graphql.OnMutationUpdate<Mutation$CreateNewMessageRoom>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$CreateNewMessageRoom(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationCreateNewMessageRoom,
          parserFn: _parserFn$Mutation$CreateNewMessageRoom,
        );

  final OnMutationCompleted$Mutation$CreateNewMessageRoom?
      onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

typedef RunMutation$Mutation$CreateNewMessageRoom
    = graphql.MultiSourceResult<Mutation$CreateNewMessageRoom> Function(
  Variables$Mutation$CreateNewMessageRoom, {
  Object? optimisticResult,
  Mutation$CreateNewMessageRoom? typedOptimisticResult,
});
typedef Builder$Mutation$CreateNewMessageRoom = widgets.Widget Function(
  RunMutation$Mutation$CreateNewMessageRoom,
  graphql.QueryResult<Mutation$CreateNewMessageRoom>?,
);

class Mutation$CreateNewMessageRoom$Widget
    extends graphql_flutter.Mutation<Mutation$CreateNewMessageRoom> {
  Mutation$CreateNewMessageRoom$Widget({
    widgets.Key? key,
    WidgetOptions$Mutation$CreateNewMessageRoom? options,
    required Builder$Mutation$CreateNewMessageRoom builder,
  }) : super(
          key: key,
          options: options ?? WidgetOptions$Mutation$CreateNewMessageRoom(),
          builder: (
            run,
            result,
          ) =>
              builder(
            (
              variables, {
              optimisticResult,
              typedOptimisticResult,
            }) =>
                run(
              variables.toJson(),
              optimisticResult:
                  optimisticResult ?? typedOptimisticResult?.toJson(),
            ),
            result,
          ),
        );
}

class Mutation$CreateNewMessageRoom$createNewMessageRoom {
  Mutation$CreateNewMessageRoom$createNewMessageRoom({
    required this.id,
    this.$__typename = 'CreateNewMessageRoomResponse',
  });

  factory Mutation$CreateNewMessageRoom$createNewMessageRoom.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$$__typename = json['__typename'];
    return Mutation$CreateNewMessageRoom$createNewMessageRoom(
      id: (l$id as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$CreateNewMessageRoom$createNewMessageRoom) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
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

extension UtilityExtension$Mutation$CreateNewMessageRoom$createNewMessageRoom
    on Mutation$CreateNewMessageRoom$createNewMessageRoom {
  CopyWith$Mutation$CreateNewMessageRoom$createNewMessageRoom<
          Mutation$CreateNewMessageRoom$createNewMessageRoom>
      get copyWith =>
          CopyWith$Mutation$CreateNewMessageRoom$createNewMessageRoom(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$CreateNewMessageRoom$createNewMessageRoom<
    TRes> {
  factory CopyWith$Mutation$CreateNewMessageRoom$createNewMessageRoom(
    Mutation$CreateNewMessageRoom$createNewMessageRoom instance,
    TRes Function(Mutation$CreateNewMessageRoom$createNewMessageRoom) then,
  ) = _CopyWithImpl$Mutation$CreateNewMessageRoom$createNewMessageRoom;

  factory CopyWith$Mutation$CreateNewMessageRoom$createNewMessageRoom.stub(
          TRes res) =
      _CopyWithStubImpl$Mutation$CreateNewMessageRoom$createNewMessageRoom;

  TRes call({
    String? id,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$CreateNewMessageRoom$createNewMessageRoom<TRes>
    implements
        CopyWith$Mutation$CreateNewMessageRoom$createNewMessageRoom<TRes> {
  _CopyWithImpl$Mutation$CreateNewMessageRoom$createNewMessageRoom(
    this._instance,
    this._then,
  );

  final Mutation$CreateNewMessageRoom$createNewMessageRoom _instance;

  final TRes Function(Mutation$CreateNewMessageRoom$createNewMessageRoom) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$CreateNewMessageRoom$createNewMessageRoom(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$CreateNewMessageRoom$createNewMessageRoom<TRes>
    implements
        CopyWith$Mutation$CreateNewMessageRoom$createNewMessageRoom<TRes> {
  _CopyWithStubImpl$Mutation$CreateNewMessageRoom$createNewMessageRoom(
      this._res);

  TRes _res;

  call({
    String? id,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$SendMessage {
  factory Variables$Mutation$SendMessage(
          {required Input$SendMessageInput input}) =>
      Variables$Mutation$SendMessage._({
        r'input': input,
      });

  Variables$Mutation$SendMessage._(this._$data);

  factory Variables$Mutation$SendMessage.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] =
        Input$SendMessageInput.fromJson((l$input as Map<String, dynamic>));
    return Variables$Mutation$SendMessage._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$SendMessageInput get input =>
      (_$data['input'] as Input$SendMessageInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$SendMessage<Variables$Mutation$SendMessage>
      get copyWith => CopyWith$Variables$Mutation$SendMessage(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$SendMessage) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }
}

abstract class CopyWith$Variables$Mutation$SendMessage<TRes> {
  factory CopyWith$Variables$Mutation$SendMessage(
    Variables$Mutation$SendMessage instance,
    TRes Function(Variables$Mutation$SendMessage) then,
  ) = _CopyWithImpl$Variables$Mutation$SendMessage;

  factory CopyWith$Variables$Mutation$SendMessage.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$SendMessage;

  TRes call({Input$SendMessageInput? input});
}

class _CopyWithImpl$Variables$Mutation$SendMessage<TRes>
    implements CopyWith$Variables$Mutation$SendMessage<TRes> {
  _CopyWithImpl$Variables$Mutation$SendMessage(
    this._instance,
    this._then,
  );

  final Variables$Mutation$SendMessage _instance;

  final TRes Function(Variables$Mutation$SendMessage) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? input = _undefined}) =>
      _then(Variables$Mutation$SendMessage._({
        ..._instance._$data,
        if (input != _undefined && input != null)
          'input': (input as Input$SendMessageInput),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$SendMessage<TRes>
    implements CopyWith$Variables$Mutation$SendMessage<TRes> {
  _CopyWithStubImpl$Variables$Mutation$SendMessage(this._res);

  TRes _res;

  call({Input$SendMessageInput? input}) => _res;
}

class Mutation$SendMessage {
  Mutation$SendMessage({
    required this.sendMessage,
    this.$__typename = 'MutationRoot',
  });

  factory Mutation$SendMessage.fromJson(Map<String, dynamic> json) {
    final l$sendMessage = json['sendMessage'];
    final l$$__typename = json['__typename'];
    return Mutation$SendMessage(
      sendMessage: Mutation$SendMessage$sendMessage.fromJson(
          (l$sendMessage as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$SendMessage$sendMessage sendMessage;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$sendMessage = sendMessage;
    _resultData['sendMessage'] = l$sendMessage.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$sendMessage = sendMessage;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$sendMessage,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$SendMessage) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$sendMessage = sendMessage;
    final lOther$sendMessage = other.sendMessage;
    if (l$sendMessage != lOther$sendMessage) {
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

extension UtilityExtension$Mutation$SendMessage on Mutation$SendMessage {
  CopyWith$Mutation$SendMessage<Mutation$SendMessage> get copyWith =>
      CopyWith$Mutation$SendMessage(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$SendMessage<TRes> {
  factory CopyWith$Mutation$SendMessage(
    Mutation$SendMessage instance,
    TRes Function(Mutation$SendMessage) then,
  ) = _CopyWithImpl$Mutation$SendMessage;

  factory CopyWith$Mutation$SendMessage.stub(TRes res) =
      _CopyWithStubImpl$Mutation$SendMessage;

  TRes call({
    Mutation$SendMessage$sendMessage? sendMessage,
    String? $__typename,
  });
  CopyWith$Mutation$SendMessage$sendMessage<TRes> get sendMessage;
}

class _CopyWithImpl$Mutation$SendMessage<TRes>
    implements CopyWith$Mutation$SendMessage<TRes> {
  _CopyWithImpl$Mutation$SendMessage(
    this._instance,
    this._then,
  );

  final Mutation$SendMessage _instance;

  final TRes Function(Mutation$SendMessage) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? sendMessage = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$SendMessage(
        sendMessage: sendMessage == _undefined || sendMessage == null
            ? _instance.sendMessage
            : (sendMessage as Mutation$SendMessage$sendMessage),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$SendMessage$sendMessage<TRes> get sendMessage {
    final local$sendMessage = _instance.sendMessage;
    return CopyWith$Mutation$SendMessage$sendMessage(
        local$sendMessage, (e) => call(sendMessage: e));
  }
}

class _CopyWithStubImpl$Mutation$SendMessage<TRes>
    implements CopyWith$Mutation$SendMessage<TRes> {
  _CopyWithStubImpl$Mutation$SendMessage(this._res);

  TRes _res;

  call({
    Mutation$SendMessage$sendMessage? sendMessage,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$SendMessage$sendMessage<TRes> get sendMessage =>
      CopyWith$Mutation$SendMessage$sendMessage.stub(_res);
}

const documentNodeMutationSendMessage = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'SendMessage'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'input')),
        type: NamedTypeNode(
          name: NameNode(value: 'SendMessageInput'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'sendMessage'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'input'),
            value: VariableNode(name: NameNode(value: 'input')),
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
            name: NameNode(value: 'message'),
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
            name: NameNode(value: 'attachedFile'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'attachedImg'),
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
Mutation$SendMessage _parserFn$Mutation$SendMessage(
        Map<String, dynamic> data) =>
    Mutation$SendMessage.fromJson(data);
typedef OnMutationCompleted$Mutation$SendMessage = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$SendMessage?,
);

class Options$Mutation$SendMessage
    extends graphql.MutationOptions<Mutation$SendMessage> {
  Options$Mutation$SendMessage({
    String? operationName,
    required Variables$Mutation$SendMessage variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$SendMessage? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$SendMessage? onCompleted,
    graphql.OnMutationUpdate<Mutation$SendMessage>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null ? null : _parserFn$Mutation$SendMessage(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationSendMessage,
          parserFn: _parserFn$Mutation$SendMessage,
        );

  final OnMutationCompleted$Mutation$SendMessage? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$SendMessage
    extends graphql.WatchQueryOptions<Mutation$SendMessage> {
  WatchOptions$Mutation$SendMessage({
    String? operationName,
    required Variables$Mutation$SendMessage variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$SendMessage? typedOptimisticResult,
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
          document: documentNodeMutationSendMessage,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$SendMessage,
        );
}

extension ClientExtension$Mutation$SendMessage on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$SendMessage>> mutate$SendMessage(
          Options$Mutation$SendMessage options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$SendMessage> watchMutation$SendMessage(
          WatchOptions$Mutation$SendMessage options) =>
      this.watchMutation(options);
}

class Mutation$SendMessage$HookResult {
  Mutation$SendMessage$HookResult(
    this.runMutation,
    this.result,
  );

  final RunMutation$Mutation$SendMessage runMutation;

  final graphql.QueryResult<Mutation$SendMessage> result;
}

Mutation$SendMessage$HookResult useMutation$SendMessage(
    [WidgetOptions$Mutation$SendMessage? options]) {
  final result = graphql_flutter
      .useMutation(options ?? WidgetOptions$Mutation$SendMessage());
  return Mutation$SendMessage$HookResult(
    (variables, {optimisticResult, typedOptimisticResult}) =>
        result.runMutation(
      variables.toJson(),
      optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
    ),
    result.result,
  );
}

graphql.ObservableQuery<Mutation$SendMessage> useWatchMutation$SendMessage(
        WatchOptions$Mutation$SendMessage options) =>
    graphql_flutter.useWatchMutation(options);

class WidgetOptions$Mutation$SendMessage
    extends graphql.MutationOptions<Mutation$SendMessage> {
  WidgetOptions$Mutation$SendMessage({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$SendMessage? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$SendMessage? onCompleted,
    graphql.OnMutationUpdate<Mutation$SendMessage>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null ? null : _parserFn$Mutation$SendMessage(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationSendMessage,
          parserFn: _parserFn$Mutation$SendMessage,
        );

  final OnMutationCompleted$Mutation$SendMessage? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

typedef RunMutation$Mutation$SendMessage
    = graphql.MultiSourceResult<Mutation$SendMessage> Function(
  Variables$Mutation$SendMessage, {
  Object? optimisticResult,
  Mutation$SendMessage? typedOptimisticResult,
});
typedef Builder$Mutation$SendMessage = widgets.Widget Function(
  RunMutation$Mutation$SendMessage,
  graphql.QueryResult<Mutation$SendMessage>?,
);

class Mutation$SendMessage$Widget
    extends graphql_flutter.Mutation<Mutation$SendMessage> {
  Mutation$SendMessage$Widget({
    widgets.Key? key,
    WidgetOptions$Mutation$SendMessage? options,
    required Builder$Mutation$SendMessage builder,
  }) : super(
          key: key,
          options: options ?? WidgetOptions$Mutation$SendMessage(),
          builder: (
            run,
            result,
          ) =>
              builder(
            (
              variables, {
              optimisticResult,
              typedOptimisticResult,
            }) =>
                run(
              variables.toJson(),
              optimisticResult:
                  optimisticResult ?? typedOptimisticResult?.toJson(),
            ),
            result,
          ),
        );
}

class Mutation$SendMessage$sendMessage {
  Mutation$SendMessage$sendMessage({
    required this.id,
    required this.message,
    required this.sentAt,
    this.attachedFile,
    this.attachedImg,
    this.$__typename = 'SendMessageResponse',
  });

  factory Mutation$SendMessage$sendMessage.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$message = json['message'];
    final l$sentAt = json['sentAt'];
    final l$attachedFile = json['attachedFile'];
    final l$attachedImg = json['attachedImg'];
    final l$$__typename = json['__typename'];
    return Mutation$SendMessage$sendMessage(
      id: (l$id as String),
      message: (l$message as String),
      sentAt: (l$sentAt as String),
      attachedFile: (l$attachedFile as List<dynamic>?)
          ?.map((e) => (e as String))
          .toList(),
      attachedImg:
          (l$attachedImg as List<dynamic>?)?.map((e) => (e as String)).toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String message;

  final String sentAt;

  final List<String>? attachedFile;

  final List<String>? attachedImg;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$message = message;
    _resultData['message'] = l$message;
    final l$sentAt = sentAt;
    _resultData['sentAt'] = l$sentAt;
    final l$attachedFile = attachedFile;
    _resultData['attachedFile'] = l$attachedFile?.map((e) => e).toList();
    final l$attachedImg = attachedImg;
    _resultData['attachedImg'] = l$attachedImg?.map((e) => e).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$message = message;
    final l$sentAt = sentAt;
    final l$attachedFile = attachedFile;
    final l$attachedImg = attachedImg;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$message,
      l$sentAt,
      l$attachedFile == null
          ? null
          : Object.hashAll(l$attachedFile.map((v) => v)),
      l$attachedImg == null
          ? null
          : Object.hashAll(l$attachedImg.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$SendMessage$sendMessage) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) {
      return false;
    }
    final l$sentAt = sentAt;
    final lOther$sentAt = other.sentAt;
    if (l$sentAt != lOther$sentAt) {
      return false;
    }
    final l$attachedFile = attachedFile;
    final lOther$attachedFile = other.attachedFile;
    if (l$attachedFile != null && lOther$attachedFile != null) {
      if (l$attachedFile.length != lOther$attachedFile.length) {
        return false;
      }
      for (int i = 0; i < l$attachedFile.length; i++) {
        final l$attachedFile$entry = l$attachedFile[i];
        final lOther$attachedFile$entry = lOther$attachedFile[i];
        if (l$attachedFile$entry != lOther$attachedFile$entry) {
          return false;
        }
      }
    } else if (l$attachedFile != lOther$attachedFile) {
      return false;
    }
    final l$attachedImg = attachedImg;
    final lOther$attachedImg = other.attachedImg;
    if (l$attachedImg != null && lOther$attachedImg != null) {
      if (l$attachedImg.length != lOther$attachedImg.length) {
        return false;
      }
      for (int i = 0; i < l$attachedImg.length; i++) {
        final l$attachedImg$entry = l$attachedImg[i];
        final lOther$attachedImg$entry = lOther$attachedImg[i];
        if (l$attachedImg$entry != lOther$attachedImg$entry) {
          return false;
        }
      }
    } else if (l$attachedImg != lOther$attachedImg) {
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

extension UtilityExtension$Mutation$SendMessage$sendMessage
    on Mutation$SendMessage$sendMessage {
  CopyWith$Mutation$SendMessage$sendMessage<Mutation$SendMessage$sendMessage>
      get copyWith => CopyWith$Mutation$SendMessage$sendMessage(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$SendMessage$sendMessage<TRes> {
  factory CopyWith$Mutation$SendMessage$sendMessage(
    Mutation$SendMessage$sendMessage instance,
    TRes Function(Mutation$SendMessage$sendMessage) then,
  ) = _CopyWithImpl$Mutation$SendMessage$sendMessage;

  factory CopyWith$Mutation$SendMessage$sendMessage.stub(TRes res) =
      _CopyWithStubImpl$Mutation$SendMessage$sendMessage;

  TRes call({
    String? id,
    String? message,
    String? sentAt,
    List<String>? attachedFile,
    List<String>? attachedImg,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$SendMessage$sendMessage<TRes>
    implements CopyWith$Mutation$SendMessage$sendMessage<TRes> {
  _CopyWithImpl$Mutation$SendMessage$sendMessage(
    this._instance,
    this._then,
  );

  final Mutation$SendMessage$sendMessage _instance;

  final TRes Function(Mutation$SendMessage$sendMessage) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? message = _undefined,
    Object? sentAt = _undefined,
    Object? attachedFile = _undefined,
    Object? attachedImg = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$SendMessage$sendMessage(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        message: message == _undefined || message == null
            ? _instance.message
            : (message as String),
        sentAt: sentAt == _undefined || sentAt == null
            ? _instance.sentAt
            : (sentAt as String),
        attachedFile: attachedFile == _undefined
            ? _instance.attachedFile
            : (attachedFile as List<String>?),
        attachedImg: attachedImg == _undefined
            ? _instance.attachedImg
            : (attachedImg as List<String>?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$SendMessage$sendMessage<TRes>
    implements CopyWith$Mutation$SendMessage$sendMessage<TRes> {
  _CopyWithStubImpl$Mutation$SendMessage$sendMessage(this._res);

  TRes _res;

  call({
    String? id,
    String? message,
    String? sentAt,
    List<String>? attachedFile,
    List<String>? attachedImg,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$CreateNewNotification {
  factory Variables$Mutation$CreateNewNotification(
          {required Input$CreateNewNotificationInput input}) =>
      Variables$Mutation$CreateNewNotification._({
        r'input': input,
      });

  Variables$Mutation$CreateNewNotification._(this._$data);

  factory Variables$Mutation$CreateNewNotification.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] = Input$CreateNewNotificationInput.fromJson(
        (l$input as Map<String, dynamic>));
    return Variables$Mutation$CreateNewNotification._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$CreateNewNotificationInput get input =>
      (_$data['input'] as Input$CreateNewNotificationInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$CreateNewNotification<
          Variables$Mutation$CreateNewNotification>
      get copyWith => CopyWith$Variables$Mutation$CreateNewNotification(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$CreateNewNotification) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }
}

abstract class CopyWith$Variables$Mutation$CreateNewNotification<TRes> {
  factory CopyWith$Variables$Mutation$CreateNewNotification(
    Variables$Mutation$CreateNewNotification instance,
    TRes Function(Variables$Mutation$CreateNewNotification) then,
  ) = _CopyWithImpl$Variables$Mutation$CreateNewNotification;

  factory CopyWith$Variables$Mutation$CreateNewNotification.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$CreateNewNotification;

  TRes call({Input$CreateNewNotificationInput? input});
}

class _CopyWithImpl$Variables$Mutation$CreateNewNotification<TRes>
    implements CopyWith$Variables$Mutation$CreateNewNotification<TRes> {
  _CopyWithImpl$Variables$Mutation$CreateNewNotification(
    this._instance,
    this._then,
  );

  final Variables$Mutation$CreateNewNotification _instance;

  final TRes Function(Variables$Mutation$CreateNewNotification) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? input = _undefined}) =>
      _then(Variables$Mutation$CreateNewNotification._({
        ..._instance._$data,
        if (input != _undefined && input != null)
          'input': (input as Input$CreateNewNotificationInput),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$CreateNewNotification<TRes>
    implements CopyWith$Variables$Mutation$CreateNewNotification<TRes> {
  _CopyWithStubImpl$Variables$Mutation$CreateNewNotification(this._res);

  TRes _res;

  call({Input$CreateNewNotificationInput? input}) => _res;
}

class Mutation$CreateNewNotification {
  Mutation$CreateNewNotification({
    required this.createNewNotification,
    this.$__typename = 'MutationRoot',
  });

  factory Mutation$CreateNewNotification.fromJson(Map<String, dynamic> json) {
    final l$createNewNotification = json['createNewNotification'];
    final l$$__typename = json['__typename'];
    return Mutation$CreateNewNotification(
      createNewNotification:
          Mutation$CreateNewNotification$createNewNotification.fromJson(
              (l$createNewNotification as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$CreateNewNotification$createNewNotification
      createNewNotification;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$createNewNotification = createNewNotification;
    _resultData['createNewNotification'] = l$createNewNotification.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$createNewNotification = createNewNotification;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$createNewNotification,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$CreateNewNotification) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$createNewNotification = createNewNotification;
    final lOther$createNewNotification = other.createNewNotification;
    if (l$createNewNotification != lOther$createNewNotification) {
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

extension UtilityExtension$Mutation$CreateNewNotification
    on Mutation$CreateNewNotification {
  CopyWith$Mutation$CreateNewNotification<Mutation$CreateNewNotification>
      get copyWith => CopyWith$Mutation$CreateNewNotification(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$CreateNewNotification<TRes> {
  factory CopyWith$Mutation$CreateNewNotification(
    Mutation$CreateNewNotification instance,
    TRes Function(Mutation$CreateNewNotification) then,
  ) = _CopyWithImpl$Mutation$CreateNewNotification;

  factory CopyWith$Mutation$CreateNewNotification.stub(TRes res) =
      _CopyWithStubImpl$Mutation$CreateNewNotification;

  TRes call({
    Mutation$CreateNewNotification$createNewNotification? createNewNotification,
    String? $__typename,
  });
  CopyWith$Mutation$CreateNewNotification$createNewNotification<TRes>
      get createNewNotification;
}

class _CopyWithImpl$Mutation$CreateNewNotification<TRes>
    implements CopyWith$Mutation$CreateNewNotification<TRes> {
  _CopyWithImpl$Mutation$CreateNewNotification(
    this._instance,
    this._then,
  );

  final Mutation$CreateNewNotification _instance;

  final TRes Function(Mutation$CreateNewNotification) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? createNewNotification = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$CreateNewNotification(
        createNewNotification:
            createNewNotification == _undefined || createNewNotification == null
                ? _instance.createNewNotification
                : (createNewNotification
                    as Mutation$CreateNewNotification$createNewNotification),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$CreateNewNotification$createNewNotification<TRes>
      get createNewNotification {
    final local$createNewNotification = _instance.createNewNotification;
    return CopyWith$Mutation$CreateNewNotification$createNewNotification(
        local$createNewNotification, (e) => call(createNewNotification: e));
  }
}

class _CopyWithStubImpl$Mutation$CreateNewNotification<TRes>
    implements CopyWith$Mutation$CreateNewNotification<TRes> {
  _CopyWithStubImpl$Mutation$CreateNewNotification(this._res);

  TRes _res;

  call({
    Mutation$CreateNewNotification$createNewNotification? createNewNotification,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$CreateNewNotification$createNewNotification<TRes>
      get createNewNotification =>
          CopyWith$Mutation$CreateNewNotification$createNewNotification.stub(
              _res);
}

const documentNodeMutationCreateNewNotification = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'CreateNewNotification'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'input')),
        type: NamedTypeNode(
          name: NameNode(value: 'CreateNewNotificationInput'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'createNewNotification'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'input'),
            value: VariableNode(name: NameNode(value: 'input')),
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
Mutation$CreateNewNotification _parserFn$Mutation$CreateNewNotification(
        Map<String, dynamic> data) =>
    Mutation$CreateNewNotification.fromJson(data);
typedef OnMutationCompleted$Mutation$CreateNewNotification = FutureOr<void>
    Function(
  Map<String, dynamic>?,
  Mutation$CreateNewNotification?,
);

class Options$Mutation$CreateNewNotification
    extends graphql.MutationOptions<Mutation$CreateNewNotification> {
  Options$Mutation$CreateNewNotification({
    String? operationName,
    required Variables$Mutation$CreateNewNotification variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreateNewNotification? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$CreateNewNotification? onCompleted,
    graphql.OnMutationUpdate<Mutation$CreateNewNotification>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$CreateNewNotification(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationCreateNewNotification,
          parserFn: _parserFn$Mutation$CreateNewNotification,
        );

  final OnMutationCompleted$Mutation$CreateNewNotification?
      onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$CreateNewNotification
    extends graphql.WatchQueryOptions<Mutation$CreateNewNotification> {
  WatchOptions$Mutation$CreateNewNotification({
    String? operationName,
    required Variables$Mutation$CreateNewNotification variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreateNewNotification? typedOptimisticResult,
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
          document: documentNodeMutationCreateNewNotification,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$CreateNewNotification,
        );
}

extension ClientExtension$Mutation$CreateNewNotification
    on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$CreateNewNotification>>
      mutate$CreateNewNotification(
              Options$Mutation$CreateNewNotification options) async =>
          await this.mutate(options);
  graphql.ObservableQuery<Mutation$CreateNewNotification>
      watchMutation$CreateNewNotification(
              WatchOptions$Mutation$CreateNewNotification options) =>
          this.watchMutation(options);
}

class Mutation$CreateNewNotification$HookResult {
  Mutation$CreateNewNotification$HookResult(
    this.runMutation,
    this.result,
  );

  final RunMutation$Mutation$CreateNewNotification runMutation;

  final graphql.QueryResult<Mutation$CreateNewNotification> result;
}

Mutation$CreateNewNotification$HookResult useMutation$CreateNewNotification(
    [WidgetOptions$Mutation$CreateNewNotification? options]) {
  final result = graphql_flutter
      .useMutation(options ?? WidgetOptions$Mutation$CreateNewNotification());
  return Mutation$CreateNewNotification$HookResult(
    (variables, {optimisticResult, typedOptimisticResult}) =>
        result.runMutation(
      variables.toJson(),
      optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
    ),
    result.result,
  );
}

graphql.ObservableQuery<Mutation$CreateNewNotification>
    useWatchMutation$CreateNewNotification(
            WatchOptions$Mutation$CreateNewNotification options) =>
        graphql_flutter.useWatchMutation(options);

class WidgetOptions$Mutation$CreateNewNotification
    extends graphql.MutationOptions<Mutation$CreateNewNotification> {
  WidgetOptions$Mutation$CreateNewNotification({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreateNewNotification? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$CreateNewNotification? onCompleted,
    graphql.OnMutationUpdate<Mutation$CreateNewNotification>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$CreateNewNotification(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationCreateNewNotification,
          parserFn: _parserFn$Mutation$CreateNewNotification,
        );

  final OnMutationCompleted$Mutation$CreateNewNotification?
      onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

typedef RunMutation$Mutation$CreateNewNotification
    = graphql.MultiSourceResult<Mutation$CreateNewNotification> Function(
  Variables$Mutation$CreateNewNotification, {
  Object? optimisticResult,
  Mutation$CreateNewNotification? typedOptimisticResult,
});
typedef Builder$Mutation$CreateNewNotification = widgets.Widget Function(
  RunMutation$Mutation$CreateNewNotification,
  graphql.QueryResult<Mutation$CreateNewNotification>?,
);

class Mutation$CreateNewNotification$Widget
    extends graphql_flutter.Mutation<Mutation$CreateNewNotification> {
  Mutation$CreateNewNotification$Widget({
    widgets.Key? key,
    WidgetOptions$Mutation$CreateNewNotification? options,
    required Builder$Mutation$CreateNewNotification builder,
  }) : super(
          key: key,
          options: options ?? WidgetOptions$Mutation$CreateNewNotification(),
          builder: (
            run,
            result,
          ) =>
              builder(
            (
              variables, {
              optimisticResult,
              typedOptimisticResult,
            }) =>
                run(
              variables.toJson(),
              optimisticResult:
                  optimisticResult ?? typedOptimisticResult?.toJson(),
            ),
            result,
          ),
        );
}

class Mutation$CreateNewNotification$createNewNotification {
  Mutation$CreateNewNotification$createNewNotification({
    required this.id,
    this.$__typename = 'CreateNewNotificationResponse',
  });

  factory Mutation$CreateNewNotification$createNewNotification.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$$__typename = json['__typename'];
    return Mutation$CreateNewNotification$createNewNotification(
      id: (l$id as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$CreateNewNotification$createNewNotification) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
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

extension UtilityExtension$Mutation$CreateNewNotification$createNewNotification
    on Mutation$CreateNewNotification$createNewNotification {
  CopyWith$Mutation$CreateNewNotification$createNewNotification<
          Mutation$CreateNewNotification$createNewNotification>
      get copyWith =>
          CopyWith$Mutation$CreateNewNotification$createNewNotification(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$CreateNewNotification$createNewNotification<
    TRes> {
  factory CopyWith$Mutation$CreateNewNotification$createNewNotification(
    Mutation$CreateNewNotification$createNewNotification instance,
    TRes Function(Mutation$CreateNewNotification$createNewNotification) then,
  ) = _CopyWithImpl$Mutation$CreateNewNotification$createNewNotification;

  factory CopyWith$Mutation$CreateNewNotification$createNewNotification.stub(
          TRes res) =
      _CopyWithStubImpl$Mutation$CreateNewNotification$createNewNotification;

  TRes call({
    String? id,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$CreateNewNotification$createNewNotification<TRes>
    implements
        CopyWith$Mutation$CreateNewNotification$createNewNotification<TRes> {
  _CopyWithImpl$Mutation$CreateNewNotification$createNewNotification(
    this._instance,
    this._then,
  );

  final Mutation$CreateNewNotification$createNewNotification _instance;

  final TRes Function(Mutation$CreateNewNotification$createNewNotification)
      _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$CreateNewNotification$createNewNotification(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$CreateNewNotification$createNewNotification<
        TRes>
    implements
        CopyWith$Mutation$CreateNewNotification$createNewNotification<TRes> {
  _CopyWithStubImpl$Mutation$CreateNewNotification$createNewNotification(
      this._res);

  TRes _res;

  call({
    String? id,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$UpdateNotification {
  factory Variables$Mutation$UpdateNotification(
          {required Input$UpdateNotificationInput input}) =>
      Variables$Mutation$UpdateNotification._({
        r'input': input,
      });

  Variables$Mutation$UpdateNotification._(this._$data);

  factory Variables$Mutation$UpdateNotification.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] = Input$UpdateNotificationInput.fromJson(
        (l$input as Map<String, dynamic>));
    return Variables$Mutation$UpdateNotification._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$UpdateNotificationInput get input =>
      (_$data['input'] as Input$UpdateNotificationInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$UpdateNotification<
          Variables$Mutation$UpdateNotification>
      get copyWith => CopyWith$Variables$Mutation$UpdateNotification(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$UpdateNotification) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }
}

abstract class CopyWith$Variables$Mutation$UpdateNotification<TRes> {
  factory CopyWith$Variables$Mutation$UpdateNotification(
    Variables$Mutation$UpdateNotification instance,
    TRes Function(Variables$Mutation$UpdateNotification) then,
  ) = _CopyWithImpl$Variables$Mutation$UpdateNotification;

  factory CopyWith$Variables$Mutation$UpdateNotification.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$UpdateNotification;

  TRes call({Input$UpdateNotificationInput? input});
}

class _CopyWithImpl$Variables$Mutation$UpdateNotification<TRes>
    implements CopyWith$Variables$Mutation$UpdateNotification<TRes> {
  _CopyWithImpl$Variables$Mutation$UpdateNotification(
    this._instance,
    this._then,
  );

  final Variables$Mutation$UpdateNotification _instance;

  final TRes Function(Variables$Mutation$UpdateNotification) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? input = _undefined}) =>
      _then(Variables$Mutation$UpdateNotification._({
        ..._instance._$data,
        if (input != _undefined && input != null)
          'input': (input as Input$UpdateNotificationInput),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$UpdateNotification<TRes>
    implements CopyWith$Variables$Mutation$UpdateNotification<TRes> {
  _CopyWithStubImpl$Variables$Mutation$UpdateNotification(this._res);

  TRes _res;

  call({Input$UpdateNotificationInput? input}) => _res;
}

class Mutation$UpdateNotification {
  Mutation$UpdateNotification({
    required this.updateNotification,
    this.$__typename = 'MutationRoot',
  });

  factory Mutation$UpdateNotification.fromJson(Map<String, dynamic> json) {
    final l$updateNotification = json['updateNotification'];
    final l$$__typename = json['__typename'];
    return Mutation$UpdateNotification(
      updateNotification:
          Mutation$UpdateNotification$updateNotification.fromJson(
              (l$updateNotification as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$UpdateNotification$updateNotification updateNotification;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateNotification = updateNotification;
    _resultData['updateNotification'] = l$updateNotification.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateNotification = updateNotification;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$updateNotification,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$UpdateNotification) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateNotification = updateNotification;
    final lOther$updateNotification = other.updateNotification;
    if (l$updateNotification != lOther$updateNotification) {
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

extension UtilityExtension$Mutation$UpdateNotification
    on Mutation$UpdateNotification {
  CopyWith$Mutation$UpdateNotification<Mutation$UpdateNotification>
      get copyWith => CopyWith$Mutation$UpdateNotification(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$UpdateNotification<TRes> {
  factory CopyWith$Mutation$UpdateNotification(
    Mutation$UpdateNotification instance,
    TRes Function(Mutation$UpdateNotification) then,
  ) = _CopyWithImpl$Mutation$UpdateNotification;

  factory CopyWith$Mutation$UpdateNotification.stub(TRes res) =
      _CopyWithStubImpl$Mutation$UpdateNotification;

  TRes call({
    Mutation$UpdateNotification$updateNotification? updateNotification,
    String? $__typename,
  });
  CopyWith$Mutation$UpdateNotification$updateNotification<TRes>
      get updateNotification;
}

class _CopyWithImpl$Mutation$UpdateNotification<TRes>
    implements CopyWith$Mutation$UpdateNotification<TRes> {
  _CopyWithImpl$Mutation$UpdateNotification(
    this._instance,
    this._then,
  );

  final Mutation$UpdateNotification _instance;

  final TRes Function(Mutation$UpdateNotification) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? updateNotification = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$UpdateNotification(
        updateNotification:
            updateNotification == _undefined || updateNotification == null
                ? _instance.updateNotification
                : (updateNotification
                    as Mutation$UpdateNotification$updateNotification),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$UpdateNotification$updateNotification<TRes>
      get updateNotification {
    final local$updateNotification = _instance.updateNotification;
    return CopyWith$Mutation$UpdateNotification$updateNotification(
        local$updateNotification, (e) => call(updateNotification: e));
  }
}

class _CopyWithStubImpl$Mutation$UpdateNotification<TRes>
    implements CopyWith$Mutation$UpdateNotification<TRes> {
  _CopyWithStubImpl$Mutation$UpdateNotification(this._res);

  TRes _res;

  call({
    Mutation$UpdateNotification$updateNotification? updateNotification,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$UpdateNotification$updateNotification<TRes>
      get updateNotification =>
          CopyWith$Mutation$UpdateNotification$updateNotification.stub(_res);
}

const documentNodeMutationUpdateNotification = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'UpdateNotification'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'input')),
        type: NamedTypeNode(
          name: NameNode(value: 'UpdateNotificationInput'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'updateNotification'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'input'),
            value: VariableNode(name: NameNode(value: 'input')),
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
Mutation$UpdateNotification _parserFn$Mutation$UpdateNotification(
        Map<String, dynamic> data) =>
    Mutation$UpdateNotification.fromJson(data);
typedef OnMutationCompleted$Mutation$UpdateNotification = FutureOr<void>
    Function(
  Map<String, dynamic>?,
  Mutation$UpdateNotification?,
);

class Options$Mutation$UpdateNotification
    extends graphql.MutationOptions<Mutation$UpdateNotification> {
  Options$Mutation$UpdateNotification({
    String? operationName,
    required Variables$Mutation$UpdateNotification variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$UpdateNotification? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$UpdateNotification? onCompleted,
    graphql.OnMutationUpdate<Mutation$UpdateNotification>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$UpdateNotification(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationUpdateNotification,
          parserFn: _parserFn$Mutation$UpdateNotification,
        );

  final OnMutationCompleted$Mutation$UpdateNotification? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$UpdateNotification
    extends graphql.WatchQueryOptions<Mutation$UpdateNotification> {
  WatchOptions$Mutation$UpdateNotification({
    String? operationName,
    required Variables$Mutation$UpdateNotification variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$UpdateNotification? typedOptimisticResult,
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
          document: documentNodeMutationUpdateNotification,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$UpdateNotification,
        );
}

extension ClientExtension$Mutation$UpdateNotification on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$UpdateNotification>>
      mutate$UpdateNotification(
              Options$Mutation$UpdateNotification options) async =>
          await this.mutate(options);
  graphql.ObservableQuery<Mutation$UpdateNotification>
      watchMutation$UpdateNotification(
              WatchOptions$Mutation$UpdateNotification options) =>
          this.watchMutation(options);
}

class Mutation$UpdateNotification$HookResult {
  Mutation$UpdateNotification$HookResult(
    this.runMutation,
    this.result,
  );

  final RunMutation$Mutation$UpdateNotification runMutation;

  final graphql.QueryResult<Mutation$UpdateNotification> result;
}

Mutation$UpdateNotification$HookResult useMutation$UpdateNotification(
    [WidgetOptions$Mutation$UpdateNotification? options]) {
  final result = graphql_flutter
      .useMutation(options ?? WidgetOptions$Mutation$UpdateNotification());
  return Mutation$UpdateNotification$HookResult(
    (variables, {optimisticResult, typedOptimisticResult}) =>
        result.runMutation(
      variables.toJson(),
      optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
    ),
    result.result,
  );
}

graphql.ObservableQuery<Mutation$UpdateNotification>
    useWatchMutation$UpdateNotification(
            WatchOptions$Mutation$UpdateNotification options) =>
        graphql_flutter.useWatchMutation(options);

class WidgetOptions$Mutation$UpdateNotification
    extends graphql.MutationOptions<Mutation$UpdateNotification> {
  WidgetOptions$Mutation$UpdateNotification({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$UpdateNotification? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$UpdateNotification? onCompleted,
    graphql.OnMutationUpdate<Mutation$UpdateNotification>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$UpdateNotification(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationUpdateNotification,
          parserFn: _parserFn$Mutation$UpdateNotification,
        );

  final OnMutationCompleted$Mutation$UpdateNotification? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

typedef RunMutation$Mutation$UpdateNotification
    = graphql.MultiSourceResult<Mutation$UpdateNotification> Function(
  Variables$Mutation$UpdateNotification, {
  Object? optimisticResult,
  Mutation$UpdateNotification? typedOptimisticResult,
});
typedef Builder$Mutation$UpdateNotification = widgets.Widget Function(
  RunMutation$Mutation$UpdateNotification,
  graphql.QueryResult<Mutation$UpdateNotification>?,
);

class Mutation$UpdateNotification$Widget
    extends graphql_flutter.Mutation<Mutation$UpdateNotification> {
  Mutation$UpdateNotification$Widget({
    widgets.Key? key,
    WidgetOptions$Mutation$UpdateNotification? options,
    required Builder$Mutation$UpdateNotification builder,
  }) : super(
          key: key,
          options: options ?? WidgetOptions$Mutation$UpdateNotification(),
          builder: (
            run,
            result,
          ) =>
              builder(
            (
              variables, {
              optimisticResult,
              typedOptimisticResult,
            }) =>
                run(
              variables.toJson(),
              optimisticResult:
                  optimisticResult ?? typedOptimisticResult?.toJson(),
            ),
            result,
          ),
        );
}

class Mutation$UpdateNotification$updateNotification {
  Mutation$UpdateNotification$updateNotification({
    required this.id,
    this.$__typename = 'UpdateNotificationResponse',
  });

  factory Mutation$UpdateNotification$updateNotification.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$$__typename = json['__typename'];
    return Mutation$UpdateNotification$updateNotification(
      id: (l$id as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$UpdateNotification$updateNotification) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
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

extension UtilityExtension$Mutation$UpdateNotification$updateNotification
    on Mutation$UpdateNotification$updateNotification {
  CopyWith$Mutation$UpdateNotification$updateNotification<
          Mutation$UpdateNotification$updateNotification>
      get copyWith => CopyWith$Mutation$UpdateNotification$updateNotification(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$UpdateNotification$updateNotification<TRes> {
  factory CopyWith$Mutation$UpdateNotification$updateNotification(
    Mutation$UpdateNotification$updateNotification instance,
    TRes Function(Mutation$UpdateNotification$updateNotification) then,
  ) = _CopyWithImpl$Mutation$UpdateNotification$updateNotification;

  factory CopyWith$Mutation$UpdateNotification$updateNotification.stub(
          TRes res) =
      _CopyWithStubImpl$Mutation$UpdateNotification$updateNotification;

  TRes call({
    String? id,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$UpdateNotification$updateNotification<TRes>
    implements CopyWith$Mutation$UpdateNotification$updateNotification<TRes> {
  _CopyWithImpl$Mutation$UpdateNotification$updateNotification(
    this._instance,
    this._then,
  );

  final Mutation$UpdateNotification$updateNotification _instance;

  final TRes Function(Mutation$UpdateNotification$updateNotification) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$UpdateNotification$updateNotification(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$UpdateNotification$updateNotification<TRes>
    implements CopyWith$Mutation$UpdateNotification$updateNotification<TRes> {
  _CopyWithStubImpl$Mutation$UpdateNotification$updateNotification(this._res);

  TRes _res;

  call({
    String? id,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$DeleteNotification {
  factory Variables$Mutation$DeleteNotification(
          {required Input$DeleteNotificationInput input}) =>
      Variables$Mutation$DeleteNotification._({
        r'input': input,
      });

  Variables$Mutation$DeleteNotification._(this._$data);

  factory Variables$Mutation$DeleteNotification.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] = Input$DeleteNotificationInput.fromJson(
        (l$input as Map<String, dynamic>));
    return Variables$Mutation$DeleteNotification._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$DeleteNotificationInput get input =>
      (_$data['input'] as Input$DeleteNotificationInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$DeleteNotification<
          Variables$Mutation$DeleteNotification>
      get copyWith => CopyWith$Variables$Mutation$DeleteNotification(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$DeleteNotification) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }
}

abstract class CopyWith$Variables$Mutation$DeleteNotification<TRes> {
  factory CopyWith$Variables$Mutation$DeleteNotification(
    Variables$Mutation$DeleteNotification instance,
    TRes Function(Variables$Mutation$DeleteNotification) then,
  ) = _CopyWithImpl$Variables$Mutation$DeleteNotification;

  factory CopyWith$Variables$Mutation$DeleteNotification.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$DeleteNotification;

  TRes call({Input$DeleteNotificationInput? input});
}

class _CopyWithImpl$Variables$Mutation$DeleteNotification<TRes>
    implements CopyWith$Variables$Mutation$DeleteNotification<TRes> {
  _CopyWithImpl$Variables$Mutation$DeleteNotification(
    this._instance,
    this._then,
  );

  final Variables$Mutation$DeleteNotification _instance;

  final TRes Function(Variables$Mutation$DeleteNotification) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? input = _undefined}) =>
      _then(Variables$Mutation$DeleteNotification._({
        ..._instance._$data,
        if (input != _undefined && input != null)
          'input': (input as Input$DeleteNotificationInput),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$DeleteNotification<TRes>
    implements CopyWith$Variables$Mutation$DeleteNotification<TRes> {
  _CopyWithStubImpl$Variables$Mutation$DeleteNotification(this._res);

  TRes _res;

  call({Input$DeleteNotificationInput? input}) => _res;
}

class Mutation$DeleteNotification {
  Mutation$DeleteNotification({
    required this.deleteNotification,
    this.$__typename = 'MutationRoot',
  });

  factory Mutation$DeleteNotification.fromJson(Map<String, dynamic> json) {
    final l$deleteNotification = json['deleteNotification'];
    final l$$__typename = json['__typename'];
    return Mutation$DeleteNotification(
      deleteNotification:
          Mutation$DeleteNotification$deleteNotification.fromJson(
              (l$deleteNotification as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$DeleteNotification$deleteNotification deleteNotification;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$deleteNotification = deleteNotification;
    _resultData['deleteNotification'] = l$deleteNotification.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$deleteNotification = deleteNotification;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$deleteNotification,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$DeleteNotification) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$deleteNotification = deleteNotification;
    final lOther$deleteNotification = other.deleteNotification;
    if (l$deleteNotification != lOther$deleteNotification) {
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

extension UtilityExtension$Mutation$DeleteNotification
    on Mutation$DeleteNotification {
  CopyWith$Mutation$DeleteNotification<Mutation$DeleteNotification>
      get copyWith => CopyWith$Mutation$DeleteNotification(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$DeleteNotification<TRes> {
  factory CopyWith$Mutation$DeleteNotification(
    Mutation$DeleteNotification instance,
    TRes Function(Mutation$DeleteNotification) then,
  ) = _CopyWithImpl$Mutation$DeleteNotification;

  factory CopyWith$Mutation$DeleteNotification.stub(TRes res) =
      _CopyWithStubImpl$Mutation$DeleteNotification;

  TRes call({
    Mutation$DeleteNotification$deleteNotification? deleteNotification,
    String? $__typename,
  });
  CopyWith$Mutation$DeleteNotification$deleteNotification<TRes>
      get deleteNotification;
}

class _CopyWithImpl$Mutation$DeleteNotification<TRes>
    implements CopyWith$Mutation$DeleteNotification<TRes> {
  _CopyWithImpl$Mutation$DeleteNotification(
    this._instance,
    this._then,
  );

  final Mutation$DeleteNotification _instance;

  final TRes Function(Mutation$DeleteNotification) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? deleteNotification = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$DeleteNotification(
        deleteNotification:
            deleteNotification == _undefined || deleteNotification == null
                ? _instance.deleteNotification
                : (deleteNotification
                    as Mutation$DeleteNotification$deleteNotification),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$DeleteNotification$deleteNotification<TRes>
      get deleteNotification {
    final local$deleteNotification = _instance.deleteNotification;
    return CopyWith$Mutation$DeleteNotification$deleteNotification(
        local$deleteNotification, (e) => call(deleteNotification: e));
  }
}

class _CopyWithStubImpl$Mutation$DeleteNotification<TRes>
    implements CopyWith$Mutation$DeleteNotification<TRes> {
  _CopyWithStubImpl$Mutation$DeleteNotification(this._res);

  TRes _res;

  call({
    Mutation$DeleteNotification$deleteNotification? deleteNotification,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$DeleteNotification$deleteNotification<TRes>
      get deleteNotification =>
          CopyWith$Mutation$DeleteNotification$deleteNotification.stub(_res);
}

const documentNodeMutationDeleteNotification = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'DeleteNotification'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'input')),
        type: NamedTypeNode(
          name: NameNode(value: 'DeleteNotificationInput'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'deleteNotification'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'input'),
            value: VariableNode(name: NameNode(value: 'input')),
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
Mutation$DeleteNotification _parserFn$Mutation$DeleteNotification(
        Map<String, dynamic> data) =>
    Mutation$DeleteNotification.fromJson(data);
typedef OnMutationCompleted$Mutation$DeleteNotification = FutureOr<void>
    Function(
  Map<String, dynamic>?,
  Mutation$DeleteNotification?,
);

class Options$Mutation$DeleteNotification
    extends graphql.MutationOptions<Mutation$DeleteNotification> {
  Options$Mutation$DeleteNotification({
    String? operationName,
    required Variables$Mutation$DeleteNotification variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$DeleteNotification? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$DeleteNotification? onCompleted,
    graphql.OnMutationUpdate<Mutation$DeleteNotification>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$DeleteNotification(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationDeleteNotification,
          parserFn: _parserFn$Mutation$DeleteNotification,
        );

  final OnMutationCompleted$Mutation$DeleteNotification? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$DeleteNotification
    extends graphql.WatchQueryOptions<Mutation$DeleteNotification> {
  WatchOptions$Mutation$DeleteNotification({
    String? operationName,
    required Variables$Mutation$DeleteNotification variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$DeleteNotification? typedOptimisticResult,
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
          document: documentNodeMutationDeleteNotification,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$DeleteNotification,
        );
}

extension ClientExtension$Mutation$DeleteNotification on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$DeleteNotification>>
      mutate$DeleteNotification(
              Options$Mutation$DeleteNotification options) async =>
          await this.mutate(options);
  graphql.ObservableQuery<Mutation$DeleteNotification>
      watchMutation$DeleteNotification(
              WatchOptions$Mutation$DeleteNotification options) =>
          this.watchMutation(options);
}

class Mutation$DeleteNotification$HookResult {
  Mutation$DeleteNotification$HookResult(
    this.runMutation,
    this.result,
  );

  final RunMutation$Mutation$DeleteNotification runMutation;

  final graphql.QueryResult<Mutation$DeleteNotification> result;
}

Mutation$DeleteNotification$HookResult useMutation$DeleteNotification(
    [WidgetOptions$Mutation$DeleteNotification? options]) {
  final result = graphql_flutter
      .useMutation(options ?? WidgetOptions$Mutation$DeleteNotification());
  return Mutation$DeleteNotification$HookResult(
    (variables, {optimisticResult, typedOptimisticResult}) =>
        result.runMutation(
      variables.toJson(),
      optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
    ),
    result.result,
  );
}

graphql.ObservableQuery<Mutation$DeleteNotification>
    useWatchMutation$DeleteNotification(
            WatchOptions$Mutation$DeleteNotification options) =>
        graphql_flutter.useWatchMutation(options);

class WidgetOptions$Mutation$DeleteNotification
    extends graphql.MutationOptions<Mutation$DeleteNotification> {
  WidgetOptions$Mutation$DeleteNotification({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$DeleteNotification? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$DeleteNotification? onCompleted,
    graphql.OnMutationUpdate<Mutation$DeleteNotification>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$DeleteNotification(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationDeleteNotification,
          parserFn: _parserFn$Mutation$DeleteNotification,
        );

  final OnMutationCompleted$Mutation$DeleteNotification? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

typedef RunMutation$Mutation$DeleteNotification
    = graphql.MultiSourceResult<Mutation$DeleteNotification> Function(
  Variables$Mutation$DeleteNotification, {
  Object? optimisticResult,
  Mutation$DeleteNotification? typedOptimisticResult,
});
typedef Builder$Mutation$DeleteNotification = widgets.Widget Function(
  RunMutation$Mutation$DeleteNotification,
  graphql.QueryResult<Mutation$DeleteNotification>?,
);

class Mutation$DeleteNotification$Widget
    extends graphql_flutter.Mutation<Mutation$DeleteNotification> {
  Mutation$DeleteNotification$Widget({
    widgets.Key? key,
    WidgetOptions$Mutation$DeleteNotification? options,
    required Builder$Mutation$DeleteNotification builder,
  }) : super(
          key: key,
          options: options ?? WidgetOptions$Mutation$DeleteNotification(),
          builder: (
            run,
            result,
          ) =>
              builder(
            (
              variables, {
              optimisticResult,
              typedOptimisticResult,
            }) =>
                run(
              variables.toJson(),
              optimisticResult:
                  optimisticResult ?? typedOptimisticResult?.toJson(),
            ),
            result,
          ),
        );
}

class Mutation$DeleteNotification$deleteNotification {
  Mutation$DeleteNotification$deleteNotification({
    required this.id,
    this.$__typename = 'DeleteNotificationResponse',
  });

  factory Mutation$DeleteNotification$deleteNotification.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$$__typename = json['__typename'];
    return Mutation$DeleteNotification$deleteNotification(
      id: (l$id as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$DeleteNotification$deleteNotification) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
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

extension UtilityExtension$Mutation$DeleteNotification$deleteNotification
    on Mutation$DeleteNotification$deleteNotification {
  CopyWith$Mutation$DeleteNotification$deleteNotification<
          Mutation$DeleteNotification$deleteNotification>
      get copyWith => CopyWith$Mutation$DeleteNotification$deleteNotification(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$DeleteNotification$deleteNotification<TRes> {
  factory CopyWith$Mutation$DeleteNotification$deleteNotification(
    Mutation$DeleteNotification$deleteNotification instance,
    TRes Function(Mutation$DeleteNotification$deleteNotification) then,
  ) = _CopyWithImpl$Mutation$DeleteNotification$deleteNotification;

  factory CopyWith$Mutation$DeleteNotification$deleteNotification.stub(
          TRes res) =
      _CopyWithStubImpl$Mutation$DeleteNotification$deleteNotification;

  TRes call({
    String? id,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$DeleteNotification$deleteNotification<TRes>
    implements CopyWith$Mutation$DeleteNotification$deleteNotification<TRes> {
  _CopyWithImpl$Mutation$DeleteNotification$deleteNotification(
    this._instance,
    this._then,
  );

  final Mutation$DeleteNotification$deleteNotification _instance;

  final TRes Function(Mutation$DeleteNotification$deleteNotification) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$DeleteNotification$deleteNotification(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$DeleteNotification$deleteNotification<TRes>
    implements CopyWith$Mutation$DeleteNotification$deleteNotification<TRes> {
  _CopyWithStubImpl$Mutation$DeleteNotification$deleteNotification(this._res);

  TRes _res;

  call({
    String? id,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$CreateNewOffer {
  factory Variables$Mutation$CreateNewOffer(
          {required Input$CreateNewOfferInput input}) =>
      Variables$Mutation$CreateNewOffer._({
        r'input': input,
      });

  Variables$Mutation$CreateNewOffer._(this._$data);

  factory Variables$Mutation$CreateNewOffer.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] =
        Input$CreateNewOfferInput.fromJson((l$input as Map<String, dynamic>));
    return Variables$Mutation$CreateNewOffer._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$CreateNewOfferInput get input =>
      (_$data['input'] as Input$CreateNewOfferInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$CreateNewOffer<Variables$Mutation$CreateNewOffer>
      get copyWith => CopyWith$Variables$Mutation$CreateNewOffer(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$CreateNewOffer) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }
}

abstract class CopyWith$Variables$Mutation$CreateNewOffer<TRes> {
  factory CopyWith$Variables$Mutation$CreateNewOffer(
    Variables$Mutation$CreateNewOffer instance,
    TRes Function(Variables$Mutation$CreateNewOffer) then,
  ) = _CopyWithImpl$Variables$Mutation$CreateNewOffer;

  factory CopyWith$Variables$Mutation$CreateNewOffer.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$CreateNewOffer;

  TRes call({Input$CreateNewOfferInput? input});
}

class _CopyWithImpl$Variables$Mutation$CreateNewOffer<TRes>
    implements CopyWith$Variables$Mutation$CreateNewOffer<TRes> {
  _CopyWithImpl$Variables$Mutation$CreateNewOffer(
    this._instance,
    this._then,
  );

  final Variables$Mutation$CreateNewOffer _instance;

  final TRes Function(Variables$Mutation$CreateNewOffer) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? input = _undefined}) =>
      _then(Variables$Mutation$CreateNewOffer._({
        ..._instance._$data,
        if (input != _undefined && input != null)
          'input': (input as Input$CreateNewOfferInput),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$CreateNewOffer<TRes>
    implements CopyWith$Variables$Mutation$CreateNewOffer<TRes> {
  _CopyWithStubImpl$Variables$Mutation$CreateNewOffer(this._res);

  TRes _res;

  call({Input$CreateNewOfferInput? input}) => _res;
}

class Mutation$CreateNewOffer {
  Mutation$CreateNewOffer({
    required this.createNewOffer,
    this.$__typename = 'MutationRoot',
  });

  factory Mutation$CreateNewOffer.fromJson(Map<String, dynamic> json) {
    final l$createNewOffer = json['createNewOffer'];
    final l$$__typename = json['__typename'];
    return Mutation$CreateNewOffer(
      createNewOffer: Mutation$CreateNewOffer$createNewOffer.fromJson(
          (l$createNewOffer as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$CreateNewOffer$createNewOffer createNewOffer;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$createNewOffer = createNewOffer;
    _resultData['createNewOffer'] = l$createNewOffer.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$createNewOffer = createNewOffer;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$createNewOffer,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$CreateNewOffer) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$createNewOffer = createNewOffer;
    final lOther$createNewOffer = other.createNewOffer;
    if (l$createNewOffer != lOther$createNewOffer) {
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

extension UtilityExtension$Mutation$CreateNewOffer on Mutation$CreateNewOffer {
  CopyWith$Mutation$CreateNewOffer<Mutation$CreateNewOffer> get copyWith =>
      CopyWith$Mutation$CreateNewOffer(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$CreateNewOffer<TRes> {
  factory CopyWith$Mutation$CreateNewOffer(
    Mutation$CreateNewOffer instance,
    TRes Function(Mutation$CreateNewOffer) then,
  ) = _CopyWithImpl$Mutation$CreateNewOffer;

  factory CopyWith$Mutation$CreateNewOffer.stub(TRes res) =
      _CopyWithStubImpl$Mutation$CreateNewOffer;

  TRes call({
    Mutation$CreateNewOffer$createNewOffer? createNewOffer,
    String? $__typename,
  });
  CopyWith$Mutation$CreateNewOffer$createNewOffer<TRes> get createNewOffer;
}

class _CopyWithImpl$Mutation$CreateNewOffer<TRes>
    implements CopyWith$Mutation$CreateNewOffer<TRes> {
  _CopyWithImpl$Mutation$CreateNewOffer(
    this._instance,
    this._then,
  );

  final Mutation$CreateNewOffer _instance;

  final TRes Function(Mutation$CreateNewOffer) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? createNewOffer = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$CreateNewOffer(
        createNewOffer: createNewOffer == _undefined || createNewOffer == null
            ? _instance.createNewOffer
            : (createNewOffer as Mutation$CreateNewOffer$createNewOffer),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$CreateNewOffer$createNewOffer<TRes> get createNewOffer {
    final local$createNewOffer = _instance.createNewOffer;
    return CopyWith$Mutation$CreateNewOffer$createNewOffer(
        local$createNewOffer, (e) => call(createNewOffer: e));
  }
}

class _CopyWithStubImpl$Mutation$CreateNewOffer<TRes>
    implements CopyWith$Mutation$CreateNewOffer<TRes> {
  _CopyWithStubImpl$Mutation$CreateNewOffer(this._res);

  TRes _res;

  call({
    Mutation$CreateNewOffer$createNewOffer? createNewOffer,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$CreateNewOffer$createNewOffer<TRes> get createNewOffer =>
      CopyWith$Mutation$CreateNewOffer$createNewOffer.stub(_res);
}

const documentNodeMutationCreateNewOffer = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'CreateNewOffer'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'input')),
        type: NamedTypeNode(
          name: NameNode(value: 'CreateNewOfferInput'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'createNewOffer'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'input'),
            value: VariableNode(name: NameNode(value: 'input')),
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
Mutation$CreateNewOffer _parserFn$Mutation$CreateNewOffer(
        Map<String, dynamic> data) =>
    Mutation$CreateNewOffer.fromJson(data);
typedef OnMutationCompleted$Mutation$CreateNewOffer = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$CreateNewOffer?,
);

class Options$Mutation$CreateNewOffer
    extends graphql.MutationOptions<Mutation$CreateNewOffer> {
  Options$Mutation$CreateNewOffer({
    String? operationName,
    required Variables$Mutation$CreateNewOffer variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreateNewOffer? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$CreateNewOffer? onCompleted,
    graphql.OnMutationUpdate<Mutation$CreateNewOffer>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$CreateNewOffer(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationCreateNewOffer,
          parserFn: _parserFn$Mutation$CreateNewOffer,
        );

  final OnMutationCompleted$Mutation$CreateNewOffer? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$CreateNewOffer
    extends graphql.WatchQueryOptions<Mutation$CreateNewOffer> {
  WatchOptions$Mutation$CreateNewOffer({
    String? operationName,
    required Variables$Mutation$CreateNewOffer variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreateNewOffer? typedOptimisticResult,
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
          document: documentNodeMutationCreateNewOffer,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$CreateNewOffer,
        );
}

extension ClientExtension$Mutation$CreateNewOffer on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$CreateNewOffer>> mutate$CreateNewOffer(
          Options$Mutation$CreateNewOffer options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$CreateNewOffer> watchMutation$CreateNewOffer(
          WatchOptions$Mutation$CreateNewOffer options) =>
      this.watchMutation(options);
}

class Mutation$CreateNewOffer$HookResult {
  Mutation$CreateNewOffer$HookResult(
    this.runMutation,
    this.result,
  );

  final RunMutation$Mutation$CreateNewOffer runMutation;

  final graphql.QueryResult<Mutation$CreateNewOffer> result;
}

Mutation$CreateNewOffer$HookResult useMutation$CreateNewOffer(
    [WidgetOptions$Mutation$CreateNewOffer? options]) {
  final result = graphql_flutter
      .useMutation(options ?? WidgetOptions$Mutation$CreateNewOffer());
  return Mutation$CreateNewOffer$HookResult(
    (variables, {optimisticResult, typedOptimisticResult}) =>
        result.runMutation(
      variables.toJson(),
      optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
    ),
    result.result,
  );
}

graphql.ObservableQuery<Mutation$CreateNewOffer>
    useWatchMutation$CreateNewOffer(
            WatchOptions$Mutation$CreateNewOffer options) =>
        graphql_flutter.useWatchMutation(options);

class WidgetOptions$Mutation$CreateNewOffer
    extends graphql.MutationOptions<Mutation$CreateNewOffer> {
  WidgetOptions$Mutation$CreateNewOffer({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreateNewOffer? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$CreateNewOffer? onCompleted,
    graphql.OnMutationUpdate<Mutation$CreateNewOffer>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$CreateNewOffer(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationCreateNewOffer,
          parserFn: _parserFn$Mutation$CreateNewOffer,
        );

  final OnMutationCompleted$Mutation$CreateNewOffer? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

typedef RunMutation$Mutation$CreateNewOffer
    = graphql.MultiSourceResult<Mutation$CreateNewOffer> Function(
  Variables$Mutation$CreateNewOffer, {
  Object? optimisticResult,
  Mutation$CreateNewOffer? typedOptimisticResult,
});
typedef Builder$Mutation$CreateNewOffer = widgets.Widget Function(
  RunMutation$Mutation$CreateNewOffer,
  graphql.QueryResult<Mutation$CreateNewOffer>?,
);

class Mutation$CreateNewOffer$Widget
    extends graphql_flutter.Mutation<Mutation$CreateNewOffer> {
  Mutation$CreateNewOffer$Widget({
    widgets.Key? key,
    WidgetOptions$Mutation$CreateNewOffer? options,
    required Builder$Mutation$CreateNewOffer builder,
  }) : super(
          key: key,
          options: options ?? WidgetOptions$Mutation$CreateNewOffer(),
          builder: (
            run,
            result,
          ) =>
              builder(
            (
              variables, {
              optimisticResult,
              typedOptimisticResult,
            }) =>
                run(
              variables.toJson(),
              optimisticResult:
                  optimisticResult ?? typedOptimisticResult?.toJson(),
            ),
            result,
          ),
        );
}

class Mutation$CreateNewOffer$createNewOffer {
  Mutation$CreateNewOffer$createNewOffer({
    required this.id,
    this.$__typename = 'CreateNewOfferResponse',
  });

  factory Mutation$CreateNewOffer$createNewOffer.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$$__typename = json['__typename'];
    return Mutation$CreateNewOffer$createNewOffer(
      id: (l$id as int),
      $__typename: (l$$__typename as String),
    );
  }

  final int id;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$CreateNewOffer$createNewOffer) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
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

extension UtilityExtension$Mutation$CreateNewOffer$createNewOffer
    on Mutation$CreateNewOffer$createNewOffer {
  CopyWith$Mutation$CreateNewOffer$createNewOffer<
          Mutation$CreateNewOffer$createNewOffer>
      get copyWith => CopyWith$Mutation$CreateNewOffer$createNewOffer(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$CreateNewOffer$createNewOffer<TRes> {
  factory CopyWith$Mutation$CreateNewOffer$createNewOffer(
    Mutation$CreateNewOffer$createNewOffer instance,
    TRes Function(Mutation$CreateNewOffer$createNewOffer) then,
  ) = _CopyWithImpl$Mutation$CreateNewOffer$createNewOffer;

  factory CopyWith$Mutation$CreateNewOffer$createNewOffer.stub(TRes res) =
      _CopyWithStubImpl$Mutation$CreateNewOffer$createNewOffer;

  TRes call({
    int? id,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$CreateNewOffer$createNewOffer<TRes>
    implements CopyWith$Mutation$CreateNewOffer$createNewOffer<TRes> {
  _CopyWithImpl$Mutation$CreateNewOffer$createNewOffer(
    this._instance,
    this._then,
  );

  final Mutation$CreateNewOffer$createNewOffer _instance;

  final TRes Function(Mutation$CreateNewOffer$createNewOffer) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$CreateNewOffer$createNewOffer(
        id: id == _undefined || id == null ? _instance.id : (id as int),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$CreateNewOffer$createNewOffer<TRes>
    implements CopyWith$Mutation$CreateNewOffer$createNewOffer<TRes> {
  _CopyWithStubImpl$Mutation$CreateNewOffer$createNewOffer(this._res);

  TRes _res;

  call({
    int? id,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$UpdateOfferInfo {
  factory Variables$Mutation$UpdateOfferInfo(
          {required Input$UpdateOfferInput input}) =>
      Variables$Mutation$UpdateOfferInfo._({
        r'input': input,
      });

  Variables$Mutation$UpdateOfferInfo._(this._$data);

  factory Variables$Mutation$UpdateOfferInfo.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] =
        Input$UpdateOfferInput.fromJson((l$input as Map<String, dynamic>));
    return Variables$Mutation$UpdateOfferInfo._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$UpdateOfferInput get input =>
      (_$data['input'] as Input$UpdateOfferInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$UpdateOfferInfo<
          Variables$Mutation$UpdateOfferInfo>
      get copyWith => CopyWith$Variables$Mutation$UpdateOfferInfo(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$UpdateOfferInfo) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }
}

abstract class CopyWith$Variables$Mutation$UpdateOfferInfo<TRes> {
  factory CopyWith$Variables$Mutation$UpdateOfferInfo(
    Variables$Mutation$UpdateOfferInfo instance,
    TRes Function(Variables$Mutation$UpdateOfferInfo) then,
  ) = _CopyWithImpl$Variables$Mutation$UpdateOfferInfo;

  factory CopyWith$Variables$Mutation$UpdateOfferInfo.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$UpdateOfferInfo;

  TRes call({Input$UpdateOfferInput? input});
}

class _CopyWithImpl$Variables$Mutation$UpdateOfferInfo<TRes>
    implements CopyWith$Variables$Mutation$UpdateOfferInfo<TRes> {
  _CopyWithImpl$Variables$Mutation$UpdateOfferInfo(
    this._instance,
    this._then,
  );

  final Variables$Mutation$UpdateOfferInfo _instance;

  final TRes Function(Variables$Mutation$UpdateOfferInfo) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? input = _undefined}) =>
      _then(Variables$Mutation$UpdateOfferInfo._({
        ..._instance._$data,
        if (input != _undefined && input != null)
          'input': (input as Input$UpdateOfferInput),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$UpdateOfferInfo<TRes>
    implements CopyWith$Variables$Mutation$UpdateOfferInfo<TRes> {
  _CopyWithStubImpl$Variables$Mutation$UpdateOfferInfo(this._res);

  TRes _res;

  call({Input$UpdateOfferInput? input}) => _res;
}

class Mutation$UpdateOfferInfo {
  Mutation$UpdateOfferInfo({
    required this.updateOfferInfo,
    this.$__typename = 'MutationRoot',
  });

  factory Mutation$UpdateOfferInfo.fromJson(Map<String, dynamic> json) {
    final l$updateOfferInfo = json['updateOfferInfo'];
    final l$$__typename = json['__typename'];
    return Mutation$UpdateOfferInfo(
      updateOfferInfo: Mutation$UpdateOfferInfo$updateOfferInfo.fromJson(
          (l$updateOfferInfo as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$UpdateOfferInfo$updateOfferInfo updateOfferInfo;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateOfferInfo = updateOfferInfo;
    _resultData['updateOfferInfo'] = l$updateOfferInfo.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateOfferInfo = updateOfferInfo;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$updateOfferInfo,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$UpdateOfferInfo) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateOfferInfo = updateOfferInfo;
    final lOther$updateOfferInfo = other.updateOfferInfo;
    if (l$updateOfferInfo != lOther$updateOfferInfo) {
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

extension UtilityExtension$Mutation$UpdateOfferInfo
    on Mutation$UpdateOfferInfo {
  CopyWith$Mutation$UpdateOfferInfo<Mutation$UpdateOfferInfo> get copyWith =>
      CopyWith$Mutation$UpdateOfferInfo(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$UpdateOfferInfo<TRes> {
  factory CopyWith$Mutation$UpdateOfferInfo(
    Mutation$UpdateOfferInfo instance,
    TRes Function(Mutation$UpdateOfferInfo) then,
  ) = _CopyWithImpl$Mutation$UpdateOfferInfo;

  factory CopyWith$Mutation$UpdateOfferInfo.stub(TRes res) =
      _CopyWithStubImpl$Mutation$UpdateOfferInfo;

  TRes call({
    Mutation$UpdateOfferInfo$updateOfferInfo? updateOfferInfo,
    String? $__typename,
  });
  CopyWith$Mutation$UpdateOfferInfo$updateOfferInfo<TRes> get updateOfferInfo;
}

class _CopyWithImpl$Mutation$UpdateOfferInfo<TRes>
    implements CopyWith$Mutation$UpdateOfferInfo<TRes> {
  _CopyWithImpl$Mutation$UpdateOfferInfo(
    this._instance,
    this._then,
  );

  final Mutation$UpdateOfferInfo _instance;

  final TRes Function(Mutation$UpdateOfferInfo) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? updateOfferInfo = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$UpdateOfferInfo(
        updateOfferInfo:
            updateOfferInfo == _undefined || updateOfferInfo == null
                ? _instance.updateOfferInfo
                : (updateOfferInfo as Mutation$UpdateOfferInfo$updateOfferInfo),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$UpdateOfferInfo$updateOfferInfo<TRes> get updateOfferInfo {
    final local$updateOfferInfo = _instance.updateOfferInfo;
    return CopyWith$Mutation$UpdateOfferInfo$updateOfferInfo(
        local$updateOfferInfo, (e) => call(updateOfferInfo: e));
  }
}

class _CopyWithStubImpl$Mutation$UpdateOfferInfo<TRes>
    implements CopyWith$Mutation$UpdateOfferInfo<TRes> {
  _CopyWithStubImpl$Mutation$UpdateOfferInfo(this._res);

  TRes _res;

  call({
    Mutation$UpdateOfferInfo$updateOfferInfo? updateOfferInfo,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$UpdateOfferInfo$updateOfferInfo<TRes> get updateOfferInfo =>
      CopyWith$Mutation$UpdateOfferInfo$updateOfferInfo.stub(_res);
}

const documentNodeMutationUpdateOfferInfo = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'UpdateOfferInfo'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'input')),
        type: NamedTypeNode(
          name: NameNode(value: 'UpdateOfferInput'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'updateOfferInfo'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'input'),
            value: VariableNode(name: NameNode(value: 'input')),
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
Mutation$UpdateOfferInfo _parserFn$Mutation$UpdateOfferInfo(
        Map<String, dynamic> data) =>
    Mutation$UpdateOfferInfo.fromJson(data);
typedef OnMutationCompleted$Mutation$UpdateOfferInfo = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$UpdateOfferInfo?,
);

class Options$Mutation$UpdateOfferInfo
    extends graphql.MutationOptions<Mutation$UpdateOfferInfo> {
  Options$Mutation$UpdateOfferInfo({
    String? operationName,
    required Variables$Mutation$UpdateOfferInfo variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$UpdateOfferInfo? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$UpdateOfferInfo? onCompleted,
    graphql.OnMutationUpdate<Mutation$UpdateOfferInfo>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$UpdateOfferInfo(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationUpdateOfferInfo,
          parserFn: _parserFn$Mutation$UpdateOfferInfo,
        );

  final OnMutationCompleted$Mutation$UpdateOfferInfo? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$UpdateOfferInfo
    extends graphql.WatchQueryOptions<Mutation$UpdateOfferInfo> {
  WatchOptions$Mutation$UpdateOfferInfo({
    String? operationName,
    required Variables$Mutation$UpdateOfferInfo variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$UpdateOfferInfo? typedOptimisticResult,
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
          document: documentNodeMutationUpdateOfferInfo,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$UpdateOfferInfo,
        );
}

extension ClientExtension$Mutation$UpdateOfferInfo on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$UpdateOfferInfo>> mutate$UpdateOfferInfo(
          Options$Mutation$UpdateOfferInfo options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$UpdateOfferInfo>
      watchMutation$UpdateOfferInfo(
              WatchOptions$Mutation$UpdateOfferInfo options) =>
          this.watchMutation(options);
}

class Mutation$UpdateOfferInfo$HookResult {
  Mutation$UpdateOfferInfo$HookResult(
    this.runMutation,
    this.result,
  );

  final RunMutation$Mutation$UpdateOfferInfo runMutation;

  final graphql.QueryResult<Mutation$UpdateOfferInfo> result;
}

Mutation$UpdateOfferInfo$HookResult useMutation$UpdateOfferInfo(
    [WidgetOptions$Mutation$UpdateOfferInfo? options]) {
  final result = graphql_flutter
      .useMutation(options ?? WidgetOptions$Mutation$UpdateOfferInfo());
  return Mutation$UpdateOfferInfo$HookResult(
    (variables, {optimisticResult, typedOptimisticResult}) =>
        result.runMutation(
      variables.toJson(),
      optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
    ),
    result.result,
  );
}

graphql.ObservableQuery<Mutation$UpdateOfferInfo>
    useWatchMutation$UpdateOfferInfo(
            WatchOptions$Mutation$UpdateOfferInfo options) =>
        graphql_flutter.useWatchMutation(options);

class WidgetOptions$Mutation$UpdateOfferInfo
    extends graphql.MutationOptions<Mutation$UpdateOfferInfo> {
  WidgetOptions$Mutation$UpdateOfferInfo({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$UpdateOfferInfo? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$UpdateOfferInfo? onCompleted,
    graphql.OnMutationUpdate<Mutation$UpdateOfferInfo>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$UpdateOfferInfo(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationUpdateOfferInfo,
          parserFn: _parserFn$Mutation$UpdateOfferInfo,
        );

  final OnMutationCompleted$Mutation$UpdateOfferInfo? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

typedef RunMutation$Mutation$UpdateOfferInfo
    = graphql.MultiSourceResult<Mutation$UpdateOfferInfo> Function(
  Variables$Mutation$UpdateOfferInfo, {
  Object? optimisticResult,
  Mutation$UpdateOfferInfo? typedOptimisticResult,
});
typedef Builder$Mutation$UpdateOfferInfo = widgets.Widget Function(
  RunMutation$Mutation$UpdateOfferInfo,
  graphql.QueryResult<Mutation$UpdateOfferInfo>?,
);

class Mutation$UpdateOfferInfo$Widget
    extends graphql_flutter.Mutation<Mutation$UpdateOfferInfo> {
  Mutation$UpdateOfferInfo$Widget({
    widgets.Key? key,
    WidgetOptions$Mutation$UpdateOfferInfo? options,
    required Builder$Mutation$UpdateOfferInfo builder,
  }) : super(
          key: key,
          options: options ?? WidgetOptions$Mutation$UpdateOfferInfo(),
          builder: (
            run,
            result,
          ) =>
              builder(
            (
              variables, {
              optimisticResult,
              typedOptimisticResult,
            }) =>
                run(
              variables.toJson(),
              optimisticResult:
                  optimisticResult ?? typedOptimisticResult?.toJson(),
            ),
            result,
          ),
        );
}

class Mutation$UpdateOfferInfo$updateOfferInfo {
  Mutation$UpdateOfferInfo$updateOfferInfo({
    required this.id,
    this.$__typename = 'UpdateOfferResponse',
  });

  factory Mutation$UpdateOfferInfo$updateOfferInfo.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$$__typename = json['__typename'];
    return Mutation$UpdateOfferInfo$updateOfferInfo(
      id: (l$id as int),
      $__typename: (l$$__typename as String),
    );
  }

  final int id;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$UpdateOfferInfo$updateOfferInfo) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
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

extension UtilityExtension$Mutation$UpdateOfferInfo$updateOfferInfo
    on Mutation$UpdateOfferInfo$updateOfferInfo {
  CopyWith$Mutation$UpdateOfferInfo$updateOfferInfo<
          Mutation$UpdateOfferInfo$updateOfferInfo>
      get copyWith => CopyWith$Mutation$UpdateOfferInfo$updateOfferInfo(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$UpdateOfferInfo$updateOfferInfo<TRes> {
  factory CopyWith$Mutation$UpdateOfferInfo$updateOfferInfo(
    Mutation$UpdateOfferInfo$updateOfferInfo instance,
    TRes Function(Mutation$UpdateOfferInfo$updateOfferInfo) then,
  ) = _CopyWithImpl$Mutation$UpdateOfferInfo$updateOfferInfo;

  factory CopyWith$Mutation$UpdateOfferInfo$updateOfferInfo.stub(TRes res) =
      _CopyWithStubImpl$Mutation$UpdateOfferInfo$updateOfferInfo;

  TRes call({
    int? id,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$UpdateOfferInfo$updateOfferInfo<TRes>
    implements CopyWith$Mutation$UpdateOfferInfo$updateOfferInfo<TRes> {
  _CopyWithImpl$Mutation$UpdateOfferInfo$updateOfferInfo(
    this._instance,
    this._then,
  );

  final Mutation$UpdateOfferInfo$updateOfferInfo _instance;

  final TRes Function(Mutation$UpdateOfferInfo$updateOfferInfo) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$UpdateOfferInfo$updateOfferInfo(
        id: id == _undefined || id == null ? _instance.id : (id as int),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$UpdateOfferInfo$updateOfferInfo<TRes>
    implements CopyWith$Mutation$UpdateOfferInfo$updateOfferInfo<TRes> {
  _CopyWithStubImpl$Mutation$UpdateOfferInfo$updateOfferInfo(this._res);

  TRes _res;

  call({
    int? id,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$UpdateOfferStatus {
  factory Variables$Mutation$UpdateOfferStatus(
          {required Input$UpdateOfferStatusInput input}) =>
      Variables$Mutation$UpdateOfferStatus._({
        r'input': input,
      });

  Variables$Mutation$UpdateOfferStatus._(this._$data);

  factory Variables$Mutation$UpdateOfferStatus.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] = Input$UpdateOfferStatusInput.fromJson(
        (l$input as Map<String, dynamic>));
    return Variables$Mutation$UpdateOfferStatus._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$UpdateOfferStatusInput get input =>
      (_$data['input'] as Input$UpdateOfferStatusInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$UpdateOfferStatus<
          Variables$Mutation$UpdateOfferStatus>
      get copyWith => CopyWith$Variables$Mutation$UpdateOfferStatus(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$UpdateOfferStatus) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }
}

abstract class CopyWith$Variables$Mutation$UpdateOfferStatus<TRes> {
  factory CopyWith$Variables$Mutation$UpdateOfferStatus(
    Variables$Mutation$UpdateOfferStatus instance,
    TRes Function(Variables$Mutation$UpdateOfferStatus) then,
  ) = _CopyWithImpl$Variables$Mutation$UpdateOfferStatus;

  factory CopyWith$Variables$Mutation$UpdateOfferStatus.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$UpdateOfferStatus;

  TRes call({Input$UpdateOfferStatusInput? input});
}

class _CopyWithImpl$Variables$Mutation$UpdateOfferStatus<TRes>
    implements CopyWith$Variables$Mutation$UpdateOfferStatus<TRes> {
  _CopyWithImpl$Variables$Mutation$UpdateOfferStatus(
    this._instance,
    this._then,
  );

  final Variables$Mutation$UpdateOfferStatus _instance;

  final TRes Function(Variables$Mutation$UpdateOfferStatus) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? input = _undefined}) =>
      _then(Variables$Mutation$UpdateOfferStatus._({
        ..._instance._$data,
        if (input != _undefined && input != null)
          'input': (input as Input$UpdateOfferStatusInput),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$UpdateOfferStatus<TRes>
    implements CopyWith$Variables$Mutation$UpdateOfferStatus<TRes> {
  _CopyWithStubImpl$Variables$Mutation$UpdateOfferStatus(this._res);

  TRes _res;

  call({Input$UpdateOfferStatusInput? input}) => _res;
}

class Mutation$UpdateOfferStatus {
  Mutation$UpdateOfferStatus({
    required this.updateOfferStatus,
    this.$__typename = 'MutationRoot',
  });

  factory Mutation$UpdateOfferStatus.fromJson(Map<String, dynamic> json) {
    final l$updateOfferStatus = json['updateOfferStatus'];
    final l$$__typename = json['__typename'];
    return Mutation$UpdateOfferStatus(
      updateOfferStatus: Mutation$UpdateOfferStatus$updateOfferStatus.fromJson(
          (l$updateOfferStatus as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$UpdateOfferStatus$updateOfferStatus updateOfferStatus;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateOfferStatus = updateOfferStatus;
    _resultData['updateOfferStatus'] = l$updateOfferStatus.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateOfferStatus = updateOfferStatus;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$updateOfferStatus,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$UpdateOfferStatus) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateOfferStatus = updateOfferStatus;
    final lOther$updateOfferStatus = other.updateOfferStatus;
    if (l$updateOfferStatus != lOther$updateOfferStatus) {
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

extension UtilityExtension$Mutation$UpdateOfferStatus
    on Mutation$UpdateOfferStatus {
  CopyWith$Mutation$UpdateOfferStatus<Mutation$UpdateOfferStatus>
      get copyWith => CopyWith$Mutation$UpdateOfferStatus(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$UpdateOfferStatus<TRes> {
  factory CopyWith$Mutation$UpdateOfferStatus(
    Mutation$UpdateOfferStatus instance,
    TRes Function(Mutation$UpdateOfferStatus) then,
  ) = _CopyWithImpl$Mutation$UpdateOfferStatus;

  factory CopyWith$Mutation$UpdateOfferStatus.stub(TRes res) =
      _CopyWithStubImpl$Mutation$UpdateOfferStatus;

  TRes call({
    Mutation$UpdateOfferStatus$updateOfferStatus? updateOfferStatus,
    String? $__typename,
  });
  CopyWith$Mutation$UpdateOfferStatus$updateOfferStatus<TRes>
      get updateOfferStatus;
}

class _CopyWithImpl$Mutation$UpdateOfferStatus<TRes>
    implements CopyWith$Mutation$UpdateOfferStatus<TRes> {
  _CopyWithImpl$Mutation$UpdateOfferStatus(
    this._instance,
    this._then,
  );

  final Mutation$UpdateOfferStatus _instance;

  final TRes Function(Mutation$UpdateOfferStatus) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? updateOfferStatus = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$UpdateOfferStatus(
        updateOfferStatus:
            updateOfferStatus == _undefined || updateOfferStatus == null
                ? _instance.updateOfferStatus
                : (updateOfferStatus
                    as Mutation$UpdateOfferStatus$updateOfferStatus),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$UpdateOfferStatus$updateOfferStatus<TRes>
      get updateOfferStatus {
    final local$updateOfferStatus = _instance.updateOfferStatus;
    return CopyWith$Mutation$UpdateOfferStatus$updateOfferStatus(
        local$updateOfferStatus, (e) => call(updateOfferStatus: e));
  }
}

class _CopyWithStubImpl$Mutation$UpdateOfferStatus<TRes>
    implements CopyWith$Mutation$UpdateOfferStatus<TRes> {
  _CopyWithStubImpl$Mutation$UpdateOfferStatus(this._res);

  TRes _res;

  call({
    Mutation$UpdateOfferStatus$updateOfferStatus? updateOfferStatus,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$UpdateOfferStatus$updateOfferStatus<TRes>
      get updateOfferStatus =>
          CopyWith$Mutation$UpdateOfferStatus$updateOfferStatus.stub(_res);
}

const documentNodeMutationUpdateOfferStatus = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'UpdateOfferStatus'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'input')),
        type: NamedTypeNode(
          name: NameNode(value: 'UpdateOfferStatusInput'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'updateOfferStatus'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'input'),
            value: VariableNode(name: NameNode(value: 'input')),
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
            name: NameNode(value: 'offerId'),
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
Mutation$UpdateOfferStatus _parserFn$Mutation$UpdateOfferStatus(
        Map<String, dynamic> data) =>
    Mutation$UpdateOfferStatus.fromJson(data);
typedef OnMutationCompleted$Mutation$UpdateOfferStatus = FutureOr<void>
    Function(
  Map<String, dynamic>?,
  Mutation$UpdateOfferStatus?,
);

class Options$Mutation$UpdateOfferStatus
    extends graphql.MutationOptions<Mutation$UpdateOfferStatus> {
  Options$Mutation$UpdateOfferStatus({
    String? operationName,
    required Variables$Mutation$UpdateOfferStatus variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$UpdateOfferStatus? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$UpdateOfferStatus? onCompleted,
    graphql.OnMutationUpdate<Mutation$UpdateOfferStatus>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$UpdateOfferStatus(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationUpdateOfferStatus,
          parserFn: _parserFn$Mutation$UpdateOfferStatus,
        );

  final OnMutationCompleted$Mutation$UpdateOfferStatus? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$UpdateOfferStatus
    extends graphql.WatchQueryOptions<Mutation$UpdateOfferStatus> {
  WatchOptions$Mutation$UpdateOfferStatus({
    String? operationName,
    required Variables$Mutation$UpdateOfferStatus variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$UpdateOfferStatus? typedOptimisticResult,
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
          document: documentNodeMutationUpdateOfferStatus,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$UpdateOfferStatus,
        );
}

extension ClientExtension$Mutation$UpdateOfferStatus on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$UpdateOfferStatus>>
      mutate$UpdateOfferStatus(
              Options$Mutation$UpdateOfferStatus options) async =>
          await this.mutate(options);
  graphql.ObservableQuery<Mutation$UpdateOfferStatus>
      watchMutation$UpdateOfferStatus(
              WatchOptions$Mutation$UpdateOfferStatus options) =>
          this.watchMutation(options);
}

class Mutation$UpdateOfferStatus$HookResult {
  Mutation$UpdateOfferStatus$HookResult(
    this.runMutation,
    this.result,
  );

  final RunMutation$Mutation$UpdateOfferStatus runMutation;

  final graphql.QueryResult<Mutation$UpdateOfferStatus> result;
}

Mutation$UpdateOfferStatus$HookResult useMutation$UpdateOfferStatus(
    [WidgetOptions$Mutation$UpdateOfferStatus? options]) {
  final result = graphql_flutter
      .useMutation(options ?? WidgetOptions$Mutation$UpdateOfferStatus());
  return Mutation$UpdateOfferStatus$HookResult(
    (variables, {optimisticResult, typedOptimisticResult}) =>
        result.runMutation(
      variables.toJson(),
      optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
    ),
    result.result,
  );
}

graphql.ObservableQuery<Mutation$UpdateOfferStatus>
    useWatchMutation$UpdateOfferStatus(
            WatchOptions$Mutation$UpdateOfferStatus options) =>
        graphql_flutter.useWatchMutation(options);

class WidgetOptions$Mutation$UpdateOfferStatus
    extends graphql.MutationOptions<Mutation$UpdateOfferStatus> {
  WidgetOptions$Mutation$UpdateOfferStatus({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$UpdateOfferStatus? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$UpdateOfferStatus? onCompleted,
    graphql.OnMutationUpdate<Mutation$UpdateOfferStatus>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$UpdateOfferStatus(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationUpdateOfferStatus,
          parserFn: _parserFn$Mutation$UpdateOfferStatus,
        );

  final OnMutationCompleted$Mutation$UpdateOfferStatus? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

typedef RunMutation$Mutation$UpdateOfferStatus
    = graphql.MultiSourceResult<Mutation$UpdateOfferStatus> Function(
  Variables$Mutation$UpdateOfferStatus, {
  Object? optimisticResult,
  Mutation$UpdateOfferStatus? typedOptimisticResult,
});
typedef Builder$Mutation$UpdateOfferStatus = widgets.Widget Function(
  RunMutation$Mutation$UpdateOfferStatus,
  graphql.QueryResult<Mutation$UpdateOfferStatus>?,
);

class Mutation$UpdateOfferStatus$Widget
    extends graphql_flutter.Mutation<Mutation$UpdateOfferStatus> {
  Mutation$UpdateOfferStatus$Widget({
    widgets.Key? key,
    WidgetOptions$Mutation$UpdateOfferStatus? options,
    required Builder$Mutation$UpdateOfferStatus builder,
  }) : super(
          key: key,
          options: options ?? WidgetOptions$Mutation$UpdateOfferStatus(),
          builder: (
            run,
            result,
          ) =>
              builder(
            (
              variables, {
              optimisticResult,
              typedOptimisticResult,
            }) =>
                run(
              variables.toJson(),
              optimisticResult:
                  optimisticResult ?? typedOptimisticResult?.toJson(),
            ),
            result,
          ),
        );
}

class Mutation$UpdateOfferStatus$updateOfferStatus {
  Mutation$UpdateOfferStatus$updateOfferStatus({
    required this.id,
    required this.offerId,
    this.$__typename = 'UpdateOfferStatusResponse',
  });

  factory Mutation$UpdateOfferStatus$updateOfferStatus.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$offerId = json['offerId'];
    final l$$__typename = json['__typename'];
    return Mutation$UpdateOfferStatus$updateOfferStatus(
      id: (l$id as int),
      offerId: (l$offerId as int),
      $__typename: (l$$__typename as String),
    );
  }

  final int id;

  final int offerId;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$offerId = offerId;
    _resultData['offerId'] = l$offerId;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$offerId = offerId;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$offerId,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$UpdateOfferStatus$updateOfferStatus) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$offerId = offerId;
    final lOther$offerId = other.offerId;
    if (l$offerId != lOther$offerId) {
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

extension UtilityExtension$Mutation$UpdateOfferStatus$updateOfferStatus
    on Mutation$UpdateOfferStatus$updateOfferStatus {
  CopyWith$Mutation$UpdateOfferStatus$updateOfferStatus<
          Mutation$UpdateOfferStatus$updateOfferStatus>
      get copyWith => CopyWith$Mutation$UpdateOfferStatus$updateOfferStatus(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$UpdateOfferStatus$updateOfferStatus<TRes> {
  factory CopyWith$Mutation$UpdateOfferStatus$updateOfferStatus(
    Mutation$UpdateOfferStatus$updateOfferStatus instance,
    TRes Function(Mutation$UpdateOfferStatus$updateOfferStatus) then,
  ) = _CopyWithImpl$Mutation$UpdateOfferStatus$updateOfferStatus;

  factory CopyWith$Mutation$UpdateOfferStatus$updateOfferStatus.stub(TRes res) =
      _CopyWithStubImpl$Mutation$UpdateOfferStatus$updateOfferStatus;

  TRes call({
    int? id,
    int? offerId,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$UpdateOfferStatus$updateOfferStatus<TRes>
    implements CopyWith$Mutation$UpdateOfferStatus$updateOfferStatus<TRes> {
  _CopyWithImpl$Mutation$UpdateOfferStatus$updateOfferStatus(
    this._instance,
    this._then,
  );

  final Mutation$UpdateOfferStatus$updateOfferStatus _instance;

  final TRes Function(Mutation$UpdateOfferStatus$updateOfferStatus) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? offerId = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$UpdateOfferStatus$updateOfferStatus(
        id: id == _undefined || id == null ? _instance.id : (id as int),
        offerId: offerId == _undefined || offerId == null
            ? _instance.offerId
            : (offerId as int),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$UpdateOfferStatus$updateOfferStatus<TRes>
    implements CopyWith$Mutation$UpdateOfferStatus$updateOfferStatus<TRes> {
  _CopyWithStubImpl$Mutation$UpdateOfferStatus$updateOfferStatus(this._res);

  TRes _res;

  call({
    int? id,
    int? offerId,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$DeleteOffer {
  factory Variables$Mutation$DeleteOffer(
          {required Input$DeleteOfferInput input}) =>
      Variables$Mutation$DeleteOffer._({
        r'input': input,
      });

  Variables$Mutation$DeleteOffer._(this._$data);

  factory Variables$Mutation$DeleteOffer.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] =
        Input$DeleteOfferInput.fromJson((l$input as Map<String, dynamic>));
    return Variables$Mutation$DeleteOffer._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$DeleteOfferInput get input =>
      (_$data['input'] as Input$DeleteOfferInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$DeleteOffer<Variables$Mutation$DeleteOffer>
      get copyWith => CopyWith$Variables$Mutation$DeleteOffer(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$DeleteOffer) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }
}

abstract class CopyWith$Variables$Mutation$DeleteOffer<TRes> {
  factory CopyWith$Variables$Mutation$DeleteOffer(
    Variables$Mutation$DeleteOffer instance,
    TRes Function(Variables$Mutation$DeleteOffer) then,
  ) = _CopyWithImpl$Variables$Mutation$DeleteOffer;

  factory CopyWith$Variables$Mutation$DeleteOffer.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$DeleteOffer;

  TRes call({Input$DeleteOfferInput? input});
}

class _CopyWithImpl$Variables$Mutation$DeleteOffer<TRes>
    implements CopyWith$Variables$Mutation$DeleteOffer<TRes> {
  _CopyWithImpl$Variables$Mutation$DeleteOffer(
    this._instance,
    this._then,
  );

  final Variables$Mutation$DeleteOffer _instance;

  final TRes Function(Variables$Mutation$DeleteOffer) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? input = _undefined}) =>
      _then(Variables$Mutation$DeleteOffer._({
        ..._instance._$data,
        if (input != _undefined && input != null)
          'input': (input as Input$DeleteOfferInput),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$DeleteOffer<TRes>
    implements CopyWith$Variables$Mutation$DeleteOffer<TRes> {
  _CopyWithStubImpl$Variables$Mutation$DeleteOffer(this._res);

  TRes _res;

  call({Input$DeleteOfferInput? input}) => _res;
}

class Mutation$DeleteOffer {
  Mutation$DeleteOffer({
    required this.deleteOffer,
    this.$__typename = 'MutationRoot',
  });

  factory Mutation$DeleteOffer.fromJson(Map<String, dynamic> json) {
    final l$deleteOffer = json['deleteOffer'];
    final l$$__typename = json['__typename'];
    return Mutation$DeleteOffer(
      deleteOffer: Mutation$DeleteOffer$deleteOffer.fromJson(
          (l$deleteOffer as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$DeleteOffer$deleteOffer deleteOffer;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$deleteOffer = deleteOffer;
    _resultData['deleteOffer'] = l$deleteOffer.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$deleteOffer = deleteOffer;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$deleteOffer,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$DeleteOffer) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$deleteOffer = deleteOffer;
    final lOther$deleteOffer = other.deleteOffer;
    if (l$deleteOffer != lOther$deleteOffer) {
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

extension UtilityExtension$Mutation$DeleteOffer on Mutation$DeleteOffer {
  CopyWith$Mutation$DeleteOffer<Mutation$DeleteOffer> get copyWith =>
      CopyWith$Mutation$DeleteOffer(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$DeleteOffer<TRes> {
  factory CopyWith$Mutation$DeleteOffer(
    Mutation$DeleteOffer instance,
    TRes Function(Mutation$DeleteOffer) then,
  ) = _CopyWithImpl$Mutation$DeleteOffer;

  factory CopyWith$Mutation$DeleteOffer.stub(TRes res) =
      _CopyWithStubImpl$Mutation$DeleteOffer;

  TRes call({
    Mutation$DeleteOffer$deleteOffer? deleteOffer,
    String? $__typename,
  });
  CopyWith$Mutation$DeleteOffer$deleteOffer<TRes> get deleteOffer;
}

class _CopyWithImpl$Mutation$DeleteOffer<TRes>
    implements CopyWith$Mutation$DeleteOffer<TRes> {
  _CopyWithImpl$Mutation$DeleteOffer(
    this._instance,
    this._then,
  );

  final Mutation$DeleteOffer _instance;

  final TRes Function(Mutation$DeleteOffer) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? deleteOffer = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$DeleteOffer(
        deleteOffer: deleteOffer == _undefined || deleteOffer == null
            ? _instance.deleteOffer
            : (deleteOffer as Mutation$DeleteOffer$deleteOffer),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$DeleteOffer$deleteOffer<TRes> get deleteOffer {
    final local$deleteOffer = _instance.deleteOffer;
    return CopyWith$Mutation$DeleteOffer$deleteOffer(
        local$deleteOffer, (e) => call(deleteOffer: e));
  }
}

class _CopyWithStubImpl$Mutation$DeleteOffer<TRes>
    implements CopyWith$Mutation$DeleteOffer<TRes> {
  _CopyWithStubImpl$Mutation$DeleteOffer(this._res);

  TRes _res;

  call({
    Mutation$DeleteOffer$deleteOffer? deleteOffer,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$DeleteOffer$deleteOffer<TRes> get deleteOffer =>
      CopyWith$Mutation$DeleteOffer$deleteOffer.stub(_res);
}

const documentNodeMutationDeleteOffer = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'DeleteOffer'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'input')),
        type: NamedTypeNode(
          name: NameNode(value: 'DeleteOfferInput'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'deleteOffer'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'input'),
            value: VariableNode(name: NameNode(value: 'input')),
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
Mutation$DeleteOffer _parserFn$Mutation$DeleteOffer(
        Map<String, dynamic> data) =>
    Mutation$DeleteOffer.fromJson(data);
typedef OnMutationCompleted$Mutation$DeleteOffer = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$DeleteOffer?,
);

class Options$Mutation$DeleteOffer
    extends graphql.MutationOptions<Mutation$DeleteOffer> {
  Options$Mutation$DeleteOffer({
    String? operationName,
    required Variables$Mutation$DeleteOffer variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$DeleteOffer? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$DeleteOffer? onCompleted,
    graphql.OnMutationUpdate<Mutation$DeleteOffer>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null ? null : _parserFn$Mutation$DeleteOffer(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationDeleteOffer,
          parserFn: _parserFn$Mutation$DeleteOffer,
        );

  final OnMutationCompleted$Mutation$DeleteOffer? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$DeleteOffer
    extends graphql.WatchQueryOptions<Mutation$DeleteOffer> {
  WatchOptions$Mutation$DeleteOffer({
    String? operationName,
    required Variables$Mutation$DeleteOffer variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$DeleteOffer? typedOptimisticResult,
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
          document: documentNodeMutationDeleteOffer,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$DeleteOffer,
        );
}

extension ClientExtension$Mutation$DeleteOffer on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$DeleteOffer>> mutate$DeleteOffer(
          Options$Mutation$DeleteOffer options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$DeleteOffer> watchMutation$DeleteOffer(
          WatchOptions$Mutation$DeleteOffer options) =>
      this.watchMutation(options);
}

class Mutation$DeleteOffer$HookResult {
  Mutation$DeleteOffer$HookResult(
    this.runMutation,
    this.result,
  );

  final RunMutation$Mutation$DeleteOffer runMutation;

  final graphql.QueryResult<Mutation$DeleteOffer> result;
}

Mutation$DeleteOffer$HookResult useMutation$DeleteOffer(
    [WidgetOptions$Mutation$DeleteOffer? options]) {
  final result = graphql_flutter
      .useMutation(options ?? WidgetOptions$Mutation$DeleteOffer());
  return Mutation$DeleteOffer$HookResult(
    (variables, {optimisticResult, typedOptimisticResult}) =>
        result.runMutation(
      variables.toJson(),
      optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
    ),
    result.result,
  );
}

graphql.ObservableQuery<Mutation$DeleteOffer> useWatchMutation$DeleteOffer(
        WatchOptions$Mutation$DeleteOffer options) =>
    graphql_flutter.useWatchMutation(options);

class WidgetOptions$Mutation$DeleteOffer
    extends graphql.MutationOptions<Mutation$DeleteOffer> {
  WidgetOptions$Mutation$DeleteOffer({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$DeleteOffer? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$DeleteOffer? onCompleted,
    graphql.OnMutationUpdate<Mutation$DeleteOffer>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null ? null : _parserFn$Mutation$DeleteOffer(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationDeleteOffer,
          parserFn: _parserFn$Mutation$DeleteOffer,
        );

  final OnMutationCompleted$Mutation$DeleteOffer? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

typedef RunMutation$Mutation$DeleteOffer
    = graphql.MultiSourceResult<Mutation$DeleteOffer> Function(
  Variables$Mutation$DeleteOffer, {
  Object? optimisticResult,
  Mutation$DeleteOffer? typedOptimisticResult,
});
typedef Builder$Mutation$DeleteOffer = widgets.Widget Function(
  RunMutation$Mutation$DeleteOffer,
  graphql.QueryResult<Mutation$DeleteOffer>?,
);

class Mutation$DeleteOffer$Widget
    extends graphql_flutter.Mutation<Mutation$DeleteOffer> {
  Mutation$DeleteOffer$Widget({
    widgets.Key? key,
    WidgetOptions$Mutation$DeleteOffer? options,
    required Builder$Mutation$DeleteOffer builder,
  }) : super(
          key: key,
          options: options ?? WidgetOptions$Mutation$DeleteOffer(),
          builder: (
            run,
            result,
          ) =>
              builder(
            (
              variables, {
              optimisticResult,
              typedOptimisticResult,
            }) =>
                run(
              variables.toJson(),
              optimisticResult:
                  optimisticResult ?? typedOptimisticResult?.toJson(),
            ),
            result,
          ),
        );
}

class Mutation$DeleteOffer$deleteOffer {
  Mutation$DeleteOffer$deleteOffer({
    required this.id,
    this.$__typename = 'DeleteOfferResponse',
  });

  factory Mutation$DeleteOffer$deleteOffer.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$$__typename = json['__typename'];
    return Mutation$DeleteOffer$deleteOffer(
      id: (l$id as int),
      $__typename: (l$$__typename as String),
    );
  }

  final int id;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$DeleteOffer$deleteOffer) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
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

extension UtilityExtension$Mutation$DeleteOffer$deleteOffer
    on Mutation$DeleteOffer$deleteOffer {
  CopyWith$Mutation$DeleteOffer$deleteOffer<Mutation$DeleteOffer$deleteOffer>
      get copyWith => CopyWith$Mutation$DeleteOffer$deleteOffer(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$DeleteOffer$deleteOffer<TRes> {
  factory CopyWith$Mutation$DeleteOffer$deleteOffer(
    Mutation$DeleteOffer$deleteOffer instance,
    TRes Function(Mutation$DeleteOffer$deleteOffer) then,
  ) = _CopyWithImpl$Mutation$DeleteOffer$deleteOffer;

  factory CopyWith$Mutation$DeleteOffer$deleteOffer.stub(TRes res) =
      _CopyWithStubImpl$Mutation$DeleteOffer$deleteOffer;

  TRes call({
    int? id,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$DeleteOffer$deleteOffer<TRes>
    implements CopyWith$Mutation$DeleteOffer$deleteOffer<TRes> {
  _CopyWithImpl$Mutation$DeleteOffer$deleteOffer(
    this._instance,
    this._then,
  );

  final Mutation$DeleteOffer$deleteOffer _instance;

  final TRes Function(Mutation$DeleteOffer$deleteOffer) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$DeleteOffer$deleteOffer(
        id: id == _undefined || id == null ? _instance.id : (id as int),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$DeleteOffer$deleteOffer<TRes>
    implements CopyWith$Mutation$DeleteOffer$deleteOffer<TRes> {
  _CopyWithStubImpl$Mutation$DeleteOffer$deleteOffer(this._res);

  TRes _res;

  call({
    int? id,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$CreateFspTx {
  factory Variables$Mutation$CreateFspTx(
          {required Input$CreateNewTransactionInput input}) =>
      Variables$Mutation$CreateFspTx._({
        r'input': input,
      });

  Variables$Mutation$CreateFspTx._(this._$data);

  factory Variables$Mutation$CreateFspTx.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] = Input$CreateNewTransactionInput.fromJson(
        (l$input as Map<String, dynamic>));
    return Variables$Mutation$CreateFspTx._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$CreateNewTransactionInput get input =>
      (_$data['input'] as Input$CreateNewTransactionInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$CreateFspTx<Variables$Mutation$CreateFspTx>
      get copyWith => CopyWith$Variables$Mutation$CreateFspTx(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$CreateFspTx) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }
}

abstract class CopyWith$Variables$Mutation$CreateFspTx<TRes> {
  factory CopyWith$Variables$Mutation$CreateFspTx(
    Variables$Mutation$CreateFspTx instance,
    TRes Function(Variables$Mutation$CreateFspTx) then,
  ) = _CopyWithImpl$Variables$Mutation$CreateFspTx;

  factory CopyWith$Variables$Mutation$CreateFspTx.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$CreateFspTx;

  TRes call({Input$CreateNewTransactionInput? input});
}

class _CopyWithImpl$Variables$Mutation$CreateFspTx<TRes>
    implements CopyWith$Variables$Mutation$CreateFspTx<TRes> {
  _CopyWithImpl$Variables$Mutation$CreateFspTx(
    this._instance,
    this._then,
  );

  final Variables$Mutation$CreateFspTx _instance;

  final TRes Function(Variables$Mutation$CreateFspTx) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? input = _undefined}) =>
      _then(Variables$Mutation$CreateFspTx._({
        ..._instance._$data,
        if (input != _undefined && input != null)
          'input': (input as Input$CreateNewTransactionInput),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$CreateFspTx<TRes>
    implements CopyWith$Variables$Mutation$CreateFspTx<TRes> {
  _CopyWithStubImpl$Variables$Mutation$CreateFspTx(this._res);

  TRes _res;

  call({Input$CreateNewTransactionInput? input}) => _res;
}

class Mutation$CreateFspTx {
  Mutation$CreateFspTx({
    required this.createFspTx,
    this.$__typename = 'MutationRoot',
  });

  factory Mutation$CreateFspTx.fromJson(Map<String, dynamic> json) {
    final l$createFspTx = json['createFspTx'];
    final l$$__typename = json['__typename'];
    return Mutation$CreateFspTx(
      createFspTx: Mutation$CreateFspTx$createFspTx.fromJson(
          (l$createFspTx as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$CreateFspTx$createFspTx createFspTx;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$createFspTx = createFspTx;
    _resultData['createFspTx'] = l$createFspTx.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$createFspTx = createFspTx;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$createFspTx,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$CreateFspTx) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$createFspTx = createFspTx;
    final lOther$createFspTx = other.createFspTx;
    if (l$createFspTx != lOther$createFspTx) {
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

extension UtilityExtension$Mutation$CreateFspTx on Mutation$CreateFspTx {
  CopyWith$Mutation$CreateFspTx<Mutation$CreateFspTx> get copyWith =>
      CopyWith$Mutation$CreateFspTx(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$CreateFspTx<TRes> {
  factory CopyWith$Mutation$CreateFspTx(
    Mutation$CreateFspTx instance,
    TRes Function(Mutation$CreateFspTx) then,
  ) = _CopyWithImpl$Mutation$CreateFspTx;

  factory CopyWith$Mutation$CreateFspTx.stub(TRes res) =
      _CopyWithStubImpl$Mutation$CreateFspTx;

  TRes call({
    Mutation$CreateFspTx$createFspTx? createFspTx,
    String? $__typename,
  });
  CopyWith$Mutation$CreateFspTx$createFspTx<TRes> get createFspTx;
}

class _CopyWithImpl$Mutation$CreateFspTx<TRes>
    implements CopyWith$Mutation$CreateFspTx<TRes> {
  _CopyWithImpl$Mutation$CreateFspTx(
    this._instance,
    this._then,
  );

  final Mutation$CreateFspTx _instance;

  final TRes Function(Mutation$CreateFspTx) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? createFspTx = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$CreateFspTx(
        createFspTx: createFspTx == _undefined || createFspTx == null
            ? _instance.createFspTx
            : (createFspTx as Mutation$CreateFspTx$createFspTx),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$CreateFspTx$createFspTx<TRes> get createFspTx {
    final local$createFspTx = _instance.createFspTx;
    return CopyWith$Mutation$CreateFspTx$createFspTx(
        local$createFspTx, (e) => call(createFspTx: e));
  }
}

class _CopyWithStubImpl$Mutation$CreateFspTx<TRes>
    implements CopyWith$Mutation$CreateFspTx<TRes> {
  _CopyWithStubImpl$Mutation$CreateFspTx(this._res);

  TRes _res;

  call({
    Mutation$CreateFspTx$createFspTx? createFspTx,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$CreateFspTx$createFspTx<TRes> get createFspTx =>
      CopyWith$Mutation$CreateFspTx$createFspTx.stub(_res);
}

const documentNodeMutationCreateFspTx = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'CreateFspTx'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'input')),
        type: NamedTypeNode(
          name: NameNode(value: 'CreateNewTransactionInput'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'createFspTx'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'input'),
            value: VariableNode(name: NameNode(value: 'input')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'txId'),
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
Mutation$CreateFspTx _parserFn$Mutation$CreateFspTx(
        Map<String, dynamic> data) =>
    Mutation$CreateFspTx.fromJson(data);
typedef OnMutationCompleted$Mutation$CreateFspTx = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$CreateFspTx?,
);

class Options$Mutation$CreateFspTx
    extends graphql.MutationOptions<Mutation$CreateFspTx> {
  Options$Mutation$CreateFspTx({
    String? operationName,
    required Variables$Mutation$CreateFspTx variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreateFspTx? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$CreateFspTx? onCompleted,
    graphql.OnMutationUpdate<Mutation$CreateFspTx>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null ? null : _parserFn$Mutation$CreateFspTx(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationCreateFspTx,
          parserFn: _parserFn$Mutation$CreateFspTx,
        );

  final OnMutationCompleted$Mutation$CreateFspTx? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$CreateFspTx
    extends graphql.WatchQueryOptions<Mutation$CreateFspTx> {
  WatchOptions$Mutation$CreateFspTx({
    String? operationName,
    required Variables$Mutation$CreateFspTx variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreateFspTx? typedOptimisticResult,
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
          document: documentNodeMutationCreateFspTx,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$CreateFspTx,
        );
}

extension ClientExtension$Mutation$CreateFspTx on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$CreateFspTx>> mutate$CreateFspTx(
          Options$Mutation$CreateFspTx options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$CreateFspTx> watchMutation$CreateFspTx(
          WatchOptions$Mutation$CreateFspTx options) =>
      this.watchMutation(options);
}

class Mutation$CreateFspTx$HookResult {
  Mutation$CreateFspTx$HookResult(
    this.runMutation,
    this.result,
  );

  final RunMutation$Mutation$CreateFspTx runMutation;

  final graphql.QueryResult<Mutation$CreateFspTx> result;
}

Mutation$CreateFspTx$HookResult useMutation$CreateFspTx(
    [WidgetOptions$Mutation$CreateFspTx? options]) {
  final result = graphql_flutter
      .useMutation(options ?? WidgetOptions$Mutation$CreateFspTx());
  return Mutation$CreateFspTx$HookResult(
    (variables, {optimisticResult, typedOptimisticResult}) =>
        result.runMutation(
      variables.toJson(),
      optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
    ),
    result.result,
  );
}

graphql.ObservableQuery<Mutation$CreateFspTx> useWatchMutation$CreateFspTx(
        WatchOptions$Mutation$CreateFspTx options) =>
    graphql_flutter.useWatchMutation(options);

class WidgetOptions$Mutation$CreateFspTx
    extends graphql.MutationOptions<Mutation$CreateFspTx> {
  WidgetOptions$Mutation$CreateFspTx({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreateFspTx? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$CreateFspTx? onCompleted,
    graphql.OnMutationUpdate<Mutation$CreateFspTx>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null ? null : _parserFn$Mutation$CreateFspTx(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationCreateFspTx,
          parserFn: _parserFn$Mutation$CreateFspTx,
        );

  final OnMutationCompleted$Mutation$CreateFspTx? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

typedef RunMutation$Mutation$CreateFspTx
    = graphql.MultiSourceResult<Mutation$CreateFspTx> Function(
  Variables$Mutation$CreateFspTx, {
  Object? optimisticResult,
  Mutation$CreateFspTx? typedOptimisticResult,
});
typedef Builder$Mutation$CreateFspTx = widgets.Widget Function(
  RunMutation$Mutation$CreateFspTx,
  graphql.QueryResult<Mutation$CreateFspTx>?,
);

class Mutation$CreateFspTx$Widget
    extends graphql_flutter.Mutation<Mutation$CreateFspTx> {
  Mutation$CreateFspTx$Widget({
    widgets.Key? key,
    WidgetOptions$Mutation$CreateFspTx? options,
    required Builder$Mutation$CreateFspTx builder,
  }) : super(
          key: key,
          options: options ?? WidgetOptions$Mutation$CreateFspTx(),
          builder: (
            run,
            result,
          ) =>
              builder(
            (
              variables, {
              optimisticResult,
              typedOptimisticResult,
            }) =>
                run(
              variables.toJson(),
              optimisticResult:
                  optimisticResult ?? typedOptimisticResult?.toJson(),
            ),
            result,
          ),
        );
}

class Mutation$CreateFspTx$createFspTx {
  Mutation$CreateFspTx$createFspTx({
    required this.txId,
    this.$__typename = 'CreateNewTransactionResponse',
  });

  factory Mutation$CreateFspTx$createFspTx.fromJson(Map<String, dynamic> json) {
    final l$txId = json['txId'];
    final l$$__typename = json['__typename'];
    return Mutation$CreateFspTx$createFspTx(
      txId: (l$txId as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String txId;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$txId = txId;
    _resultData['txId'] = l$txId;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$txId = txId;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$txId,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$CreateFspTx$createFspTx) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$txId = txId;
    final lOther$txId = other.txId;
    if (l$txId != lOther$txId) {
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

extension UtilityExtension$Mutation$CreateFspTx$createFspTx
    on Mutation$CreateFspTx$createFspTx {
  CopyWith$Mutation$CreateFspTx$createFspTx<Mutation$CreateFspTx$createFspTx>
      get copyWith => CopyWith$Mutation$CreateFspTx$createFspTx(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$CreateFspTx$createFspTx<TRes> {
  factory CopyWith$Mutation$CreateFspTx$createFspTx(
    Mutation$CreateFspTx$createFspTx instance,
    TRes Function(Mutation$CreateFspTx$createFspTx) then,
  ) = _CopyWithImpl$Mutation$CreateFspTx$createFspTx;

  factory CopyWith$Mutation$CreateFspTx$createFspTx.stub(TRes res) =
      _CopyWithStubImpl$Mutation$CreateFspTx$createFspTx;

  TRes call({
    String? txId,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$CreateFspTx$createFspTx<TRes>
    implements CopyWith$Mutation$CreateFspTx$createFspTx<TRes> {
  _CopyWithImpl$Mutation$CreateFspTx$createFspTx(
    this._instance,
    this._then,
  );

  final Mutation$CreateFspTx$createFspTx _instance;

  final TRes Function(Mutation$CreateFspTx$createFspTx) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? txId = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$CreateFspTx$createFspTx(
        txId: txId == _undefined || txId == null
            ? _instance.txId
            : (txId as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$CreateFspTx$createFspTx<TRes>
    implements CopyWith$Mutation$CreateFspTx$createFspTx<TRes> {
  _CopyWithStubImpl$Mutation$CreateFspTx$createFspTx(this._res);

  TRes _res;

  call({
    String? txId,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$CreateBulkFspTx {
  factory Variables$Mutation$CreateBulkFspTx(
          {required List<Input$CreateNewTransactionInput> input}) =>
      Variables$Mutation$CreateBulkFspTx._({
        r'input': input,
      });

  Variables$Mutation$CreateBulkFspTx._(this._$data);

  factory Variables$Mutation$CreateBulkFspTx.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] = (l$input as List<dynamic>)
        .map((e) => Input$CreateNewTransactionInput.fromJson(
            (e as Map<String, dynamic>)))
        .toList();
    return Variables$Mutation$CreateBulkFspTx._(result$data);
  }

  Map<String, dynamic> _$data;

  List<Input$CreateNewTransactionInput> get input =>
      (_$data['input'] as List<Input$CreateNewTransactionInput>);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.map((e) => e.toJson()).toList();
    return result$data;
  }

  CopyWith$Variables$Mutation$CreateBulkFspTx<
          Variables$Mutation$CreateBulkFspTx>
      get copyWith => CopyWith$Variables$Mutation$CreateBulkFspTx(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$CreateBulkFspTx) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input.length != lOther$input.length) {
      return false;
    }
    for (int i = 0; i < l$input.length; i++) {
      final l$input$entry = l$input[i];
      final lOther$input$entry = lOther$input[i];
      if (l$input$entry != lOther$input$entry) {
        return false;
      }
    }
    return true;
  }

  @override
  int get hashCode {
    final l$input = input;
    return Object.hashAll([Object.hashAll(l$input.map((v) => v))]);
  }
}

abstract class CopyWith$Variables$Mutation$CreateBulkFspTx<TRes> {
  factory CopyWith$Variables$Mutation$CreateBulkFspTx(
    Variables$Mutation$CreateBulkFspTx instance,
    TRes Function(Variables$Mutation$CreateBulkFspTx) then,
  ) = _CopyWithImpl$Variables$Mutation$CreateBulkFspTx;

  factory CopyWith$Variables$Mutation$CreateBulkFspTx.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$CreateBulkFspTx;

  TRes call({List<Input$CreateNewTransactionInput>? input});
}

class _CopyWithImpl$Variables$Mutation$CreateBulkFspTx<TRes>
    implements CopyWith$Variables$Mutation$CreateBulkFspTx<TRes> {
  _CopyWithImpl$Variables$Mutation$CreateBulkFspTx(
    this._instance,
    this._then,
  );

  final Variables$Mutation$CreateBulkFspTx _instance;

  final TRes Function(Variables$Mutation$CreateBulkFspTx) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? input = _undefined}) =>
      _then(Variables$Mutation$CreateBulkFspTx._({
        ..._instance._$data,
        if (input != _undefined && input != null)
          'input': (input as List<Input$CreateNewTransactionInput>),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$CreateBulkFspTx<TRes>
    implements CopyWith$Variables$Mutation$CreateBulkFspTx<TRes> {
  _CopyWithStubImpl$Variables$Mutation$CreateBulkFspTx(this._res);

  TRes _res;

  call({List<Input$CreateNewTransactionInput>? input}) => _res;
}

class Mutation$CreateBulkFspTx {
  Mutation$CreateBulkFspTx({
    required this.createBulkFspTx,
    this.$__typename = 'MutationRoot',
  });

  factory Mutation$CreateBulkFspTx.fromJson(Map<String, dynamic> json) {
    final l$createBulkFspTx = json['createBulkFspTx'];
    final l$$__typename = json['__typename'];
    return Mutation$CreateBulkFspTx(
      createBulkFspTx: Mutation$CreateBulkFspTx$createBulkFspTx.fromJson(
          (l$createBulkFspTx as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$CreateBulkFspTx$createBulkFspTx createBulkFspTx;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$createBulkFspTx = createBulkFspTx;
    _resultData['createBulkFspTx'] = l$createBulkFspTx.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$createBulkFspTx = createBulkFspTx;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$createBulkFspTx,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$CreateBulkFspTx) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$createBulkFspTx = createBulkFspTx;
    final lOther$createBulkFspTx = other.createBulkFspTx;
    if (l$createBulkFspTx != lOther$createBulkFspTx) {
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

extension UtilityExtension$Mutation$CreateBulkFspTx
    on Mutation$CreateBulkFspTx {
  CopyWith$Mutation$CreateBulkFspTx<Mutation$CreateBulkFspTx> get copyWith =>
      CopyWith$Mutation$CreateBulkFspTx(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$CreateBulkFspTx<TRes> {
  factory CopyWith$Mutation$CreateBulkFspTx(
    Mutation$CreateBulkFspTx instance,
    TRes Function(Mutation$CreateBulkFspTx) then,
  ) = _CopyWithImpl$Mutation$CreateBulkFspTx;

  factory CopyWith$Mutation$CreateBulkFspTx.stub(TRes res) =
      _CopyWithStubImpl$Mutation$CreateBulkFspTx;

  TRes call({
    Mutation$CreateBulkFspTx$createBulkFspTx? createBulkFspTx,
    String? $__typename,
  });
  CopyWith$Mutation$CreateBulkFspTx$createBulkFspTx<TRes> get createBulkFspTx;
}

class _CopyWithImpl$Mutation$CreateBulkFspTx<TRes>
    implements CopyWith$Mutation$CreateBulkFspTx<TRes> {
  _CopyWithImpl$Mutation$CreateBulkFspTx(
    this._instance,
    this._then,
  );

  final Mutation$CreateBulkFspTx _instance;

  final TRes Function(Mutation$CreateBulkFspTx) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? createBulkFspTx = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$CreateBulkFspTx(
        createBulkFspTx:
            createBulkFspTx == _undefined || createBulkFspTx == null
                ? _instance.createBulkFspTx
                : (createBulkFspTx as Mutation$CreateBulkFspTx$createBulkFspTx),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$CreateBulkFspTx$createBulkFspTx<TRes> get createBulkFspTx {
    final local$createBulkFspTx = _instance.createBulkFspTx;
    return CopyWith$Mutation$CreateBulkFspTx$createBulkFspTx(
        local$createBulkFspTx, (e) => call(createBulkFspTx: e));
  }
}

class _CopyWithStubImpl$Mutation$CreateBulkFspTx<TRes>
    implements CopyWith$Mutation$CreateBulkFspTx<TRes> {
  _CopyWithStubImpl$Mutation$CreateBulkFspTx(this._res);

  TRes _res;

  call({
    Mutation$CreateBulkFspTx$createBulkFspTx? createBulkFspTx,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$CreateBulkFspTx$createBulkFspTx<TRes> get createBulkFspTx =>
      CopyWith$Mutation$CreateBulkFspTx$createBulkFspTx.stub(_res);
}

const documentNodeMutationCreateBulkFspTx = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'CreateBulkFspTx'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'input')),
        type: ListTypeNode(
          type: NamedTypeNode(
            name: NameNode(value: 'CreateNewTransactionInput'),
            isNonNull: true,
          ),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'createBulkFspTx'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'input'),
            value: VariableNode(name: NameNode(value: 'input')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'txId'),
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
Mutation$CreateBulkFspTx _parserFn$Mutation$CreateBulkFspTx(
        Map<String, dynamic> data) =>
    Mutation$CreateBulkFspTx.fromJson(data);
typedef OnMutationCompleted$Mutation$CreateBulkFspTx = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$CreateBulkFspTx?,
);

class Options$Mutation$CreateBulkFspTx
    extends graphql.MutationOptions<Mutation$CreateBulkFspTx> {
  Options$Mutation$CreateBulkFspTx({
    String? operationName,
    required Variables$Mutation$CreateBulkFspTx variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreateBulkFspTx? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$CreateBulkFspTx? onCompleted,
    graphql.OnMutationUpdate<Mutation$CreateBulkFspTx>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$CreateBulkFspTx(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationCreateBulkFspTx,
          parserFn: _parserFn$Mutation$CreateBulkFspTx,
        );

  final OnMutationCompleted$Mutation$CreateBulkFspTx? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$CreateBulkFspTx
    extends graphql.WatchQueryOptions<Mutation$CreateBulkFspTx> {
  WatchOptions$Mutation$CreateBulkFspTx({
    String? operationName,
    required Variables$Mutation$CreateBulkFspTx variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreateBulkFspTx? typedOptimisticResult,
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
          document: documentNodeMutationCreateBulkFspTx,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$CreateBulkFspTx,
        );
}

extension ClientExtension$Mutation$CreateBulkFspTx on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$CreateBulkFspTx>> mutate$CreateBulkFspTx(
          Options$Mutation$CreateBulkFspTx options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$CreateBulkFspTx>
      watchMutation$CreateBulkFspTx(
              WatchOptions$Mutation$CreateBulkFspTx options) =>
          this.watchMutation(options);
}

class Mutation$CreateBulkFspTx$HookResult {
  Mutation$CreateBulkFspTx$HookResult(
    this.runMutation,
    this.result,
  );

  final RunMutation$Mutation$CreateBulkFspTx runMutation;

  final graphql.QueryResult<Mutation$CreateBulkFspTx> result;
}

Mutation$CreateBulkFspTx$HookResult useMutation$CreateBulkFspTx(
    [WidgetOptions$Mutation$CreateBulkFspTx? options]) {
  final result = graphql_flutter
      .useMutation(options ?? WidgetOptions$Mutation$CreateBulkFspTx());
  return Mutation$CreateBulkFspTx$HookResult(
    (variables, {optimisticResult, typedOptimisticResult}) =>
        result.runMutation(
      variables.toJson(),
      optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
    ),
    result.result,
  );
}

graphql.ObservableQuery<Mutation$CreateBulkFspTx>
    useWatchMutation$CreateBulkFspTx(
            WatchOptions$Mutation$CreateBulkFspTx options) =>
        graphql_flutter.useWatchMutation(options);

class WidgetOptions$Mutation$CreateBulkFspTx
    extends graphql.MutationOptions<Mutation$CreateBulkFspTx> {
  WidgetOptions$Mutation$CreateBulkFspTx({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreateBulkFspTx? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$CreateBulkFspTx? onCompleted,
    graphql.OnMutationUpdate<Mutation$CreateBulkFspTx>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$CreateBulkFspTx(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationCreateBulkFspTx,
          parserFn: _parserFn$Mutation$CreateBulkFspTx,
        );

  final OnMutationCompleted$Mutation$CreateBulkFspTx? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

typedef RunMutation$Mutation$CreateBulkFspTx
    = graphql.MultiSourceResult<Mutation$CreateBulkFspTx> Function(
  Variables$Mutation$CreateBulkFspTx, {
  Object? optimisticResult,
  Mutation$CreateBulkFspTx? typedOptimisticResult,
});
typedef Builder$Mutation$CreateBulkFspTx = widgets.Widget Function(
  RunMutation$Mutation$CreateBulkFspTx,
  graphql.QueryResult<Mutation$CreateBulkFspTx>?,
);

class Mutation$CreateBulkFspTx$Widget
    extends graphql_flutter.Mutation<Mutation$CreateBulkFspTx> {
  Mutation$CreateBulkFspTx$Widget({
    widgets.Key? key,
    WidgetOptions$Mutation$CreateBulkFspTx? options,
    required Builder$Mutation$CreateBulkFspTx builder,
  }) : super(
          key: key,
          options: options ?? WidgetOptions$Mutation$CreateBulkFspTx(),
          builder: (
            run,
            result,
          ) =>
              builder(
            (
              variables, {
              optimisticResult,
              typedOptimisticResult,
            }) =>
                run(
              variables.toJson(),
              optimisticResult:
                  optimisticResult ?? typedOptimisticResult?.toJson(),
            ),
            result,
          ),
        );
}

class Mutation$CreateBulkFspTx$createBulkFspTx {
  Mutation$CreateBulkFspTx$createBulkFspTx({
    required this.txId,
    this.$__typename = 'CreateNewTransactionResponse',
  });

  factory Mutation$CreateBulkFspTx$createBulkFspTx.fromJson(
      Map<String, dynamic> json) {
    final l$txId = json['txId'];
    final l$$__typename = json['__typename'];
    return Mutation$CreateBulkFspTx$createBulkFspTx(
      txId: (l$txId as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String txId;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$txId = txId;
    _resultData['txId'] = l$txId;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$txId = txId;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$txId,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$CreateBulkFspTx$createBulkFspTx) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$txId = txId;
    final lOther$txId = other.txId;
    if (l$txId != lOther$txId) {
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

extension UtilityExtension$Mutation$CreateBulkFspTx$createBulkFspTx
    on Mutation$CreateBulkFspTx$createBulkFspTx {
  CopyWith$Mutation$CreateBulkFspTx$createBulkFspTx<
          Mutation$CreateBulkFspTx$createBulkFspTx>
      get copyWith => CopyWith$Mutation$CreateBulkFspTx$createBulkFspTx(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$CreateBulkFspTx$createBulkFspTx<TRes> {
  factory CopyWith$Mutation$CreateBulkFspTx$createBulkFspTx(
    Mutation$CreateBulkFspTx$createBulkFspTx instance,
    TRes Function(Mutation$CreateBulkFspTx$createBulkFspTx) then,
  ) = _CopyWithImpl$Mutation$CreateBulkFspTx$createBulkFspTx;

  factory CopyWith$Mutation$CreateBulkFspTx$createBulkFspTx.stub(TRes res) =
      _CopyWithStubImpl$Mutation$CreateBulkFspTx$createBulkFspTx;

  TRes call({
    String? txId,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$CreateBulkFspTx$createBulkFspTx<TRes>
    implements CopyWith$Mutation$CreateBulkFspTx$createBulkFspTx<TRes> {
  _CopyWithImpl$Mutation$CreateBulkFspTx$createBulkFspTx(
    this._instance,
    this._then,
  );

  final Mutation$CreateBulkFspTx$createBulkFspTx _instance;

  final TRes Function(Mutation$CreateBulkFspTx$createBulkFspTx) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? txId = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$CreateBulkFspTx$createBulkFspTx(
        txId: txId == _undefined || txId == null
            ? _instance.txId
            : (txId as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$CreateBulkFspTx$createBulkFspTx<TRes>
    implements CopyWith$Mutation$CreateBulkFspTx$createBulkFspTx<TRes> {
  _CopyWithStubImpl$Mutation$CreateBulkFspTx$createBulkFspTx(this._res);

  TRes _res;

  call({
    String? txId,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$CreatePrize {
  factory Variables$Mutation$CreatePrize(
          {required Input$CreateNewPrizeInput input}) =>
      Variables$Mutation$CreatePrize._({
        r'input': input,
      });

  Variables$Mutation$CreatePrize._(this._$data);

  factory Variables$Mutation$CreatePrize.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] =
        Input$CreateNewPrizeInput.fromJson((l$input as Map<String, dynamic>));
    return Variables$Mutation$CreatePrize._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$CreateNewPrizeInput get input =>
      (_$data['input'] as Input$CreateNewPrizeInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$CreatePrize<Variables$Mutation$CreatePrize>
      get copyWith => CopyWith$Variables$Mutation$CreatePrize(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$CreatePrize) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }
}

abstract class CopyWith$Variables$Mutation$CreatePrize<TRes> {
  factory CopyWith$Variables$Mutation$CreatePrize(
    Variables$Mutation$CreatePrize instance,
    TRes Function(Variables$Mutation$CreatePrize) then,
  ) = _CopyWithImpl$Variables$Mutation$CreatePrize;

  factory CopyWith$Variables$Mutation$CreatePrize.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$CreatePrize;

  TRes call({Input$CreateNewPrizeInput? input});
}

class _CopyWithImpl$Variables$Mutation$CreatePrize<TRes>
    implements CopyWith$Variables$Mutation$CreatePrize<TRes> {
  _CopyWithImpl$Variables$Mutation$CreatePrize(
    this._instance,
    this._then,
  );

  final Variables$Mutation$CreatePrize _instance;

  final TRes Function(Variables$Mutation$CreatePrize) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? input = _undefined}) =>
      _then(Variables$Mutation$CreatePrize._({
        ..._instance._$data,
        if (input != _undefined && input != null)
          'input': (input as Input$CreateNewPrizeInput),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$CreatePrize<TRes>
    implements CopyWith$Variables$Mutation$CreatePrize<TRes> {
  _CopyWithStubImpl$Variables$Mutation$CreatePrize(this._res);

  TRes _res;

  call({Input$CreateNewPrizeInput? input}) => _res;
}

class Mutation$CreatePrize {
  Mutation$CreatePrize({
    required this.createPrize,
    this.$__typename = 'MutationRoot',
  });

  factory Mutation$CreatePrize.fromJson(Map<String, dynamic> json) {
    final l$createPrize = json['createPrize'];
    final l$$__typename = json['__typename'];
    return Mutation$CreatePrize(
      createPrize: Mutation$CreatePrize$createPrize.fromJson(
          (l$createPrize as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$CreatePrize$createPrize createPrize;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$createPrize = createPrize;
    _resultData['createPrize'] = l$createPrize.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$createPrize = createPrize;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$createPrize,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$CreatePrize) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$createPrize = createPrize;
    final lOther$createPrize = other.createPrize;
    if (l$createPrize != lOther$createPrize) {
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

extension UtilityExtension$Mutation$CreatePrize on Mutation$CreatePrize {
  CopyWith$Mutation$CreatePrize<Mutation$CreatePrize> get copyWith =>
      CopyWith$Mutation$CreatePrize(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$CreatePrize<TRes> {
  factory CopyWith$Mutation$CreatePrize(
    Mutation$CreatePrize instance,
    TRes Function(Mutation$CreatePrize) then,
  ) = _CopyWithImpl$Mutation$CreatePrize;

  factory CopyWith$Mutation$CreatePrize.stub(TRes res) =
      _CopyWithStubImpl$Mutation$CreatePrize;

  TRes call({
    Mutation$CreatePrize$createPrize? createPrize,
    String? $__typename,
  });
  CopyWith$Mutation$CreatePrize$createPrize<TRes> get createPrize;
}

class _CopyWithImpl$Mutation$CreatePrize<TRes>
    implements CopyWith$Mutation$CreatePrize<TRes> {
  _CopyWithImpl$Mutation$CreatePrize(
    this._instance,
    this._then,
  );

  final Mutation$CreatePrize _instance;

  final TRes Function(Mutation$CreatePrize) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? createPrize = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$CreatePrize(
        createPrize: createPrize == _undefined || createPrize == null
            ? _instance.createPrize
            : (createPrize as Mutation$CreatePrize$createPrize),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$CreatePrize$createPrize<TRes> get createPrize {
    final local$createPrize = _instance.createPrize;
    return CopyWith$Mutation$CreatePrize$createPrize(
        local$createPrize, (e) => call(createPrize: e));
  }
}

class _CopyWithStubImpl$Mutation$CreatePrize<TRes>
    implements CopyWith$Mutation$CreatePrize<TRes> {
  _CopyWithStubImpl$Mutation$CreatePrize(this._res);

  TRes _res;

  call({
    Mutation$CreatePrize$createPrize? createPrize,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$CreatePrize$createPrize<TRes> get createPrize =>
      CopyWith$Mutation$CreatePrize$createPrize.stub(_res);
}

const documentNodeMutationCreatePrize = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'CreatePrize'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'input')),
        type: NamedTypeNode(
          name: NameNode(value: 'CreateNewPrizeInput'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'createPrize'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'input'),
            value: VariableNode(name: NameNode(value: 'input')),
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
Mutation$CreatePrize _parserFn$Mutation$CreatePrize(
        Map<String, dynamic> data) =>
    Mutation$CreatePrize.fromJson(data);
typedef OnMutationCompleted$Mutation$CreatePrize = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$CreatePrize?,
);

class Options$Mutation$CreatePrize
    extends graphql.MutationOptions<Mutation$CreatePrize> {
  Options$Mutation$CreatePrize({
    String? operationName,
    required Variables$Mutation$CreatePrize variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreatePrize? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$CreatePrize? onCompleted,
    graphql.OnMutationUpdate<Mutation$CreatePrize>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null ? null : _parserFn$Mutation$CreatePrize(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationCreatePrize,
          parserFn: _parserFn$Mutation$CreatePrize,
        );

  final OnMutationCompleted$Mutation$CreatePrize? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$CreatePrize
    extends graphql.WatchQueryOptions<Mutation$CreatePrize> {
  WatchOptions$Mutation$CreatePrize({
    String? operationName,
    required Variables$Mutation$CreatePrize variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreatePrize? typedOptimisticResult,
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
          document: documentNodeMutationCreatePrize,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$CreatePrize,
        );
}

extension ClientExtension$Mutation$CreatePrize on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$CreatePrize>> mutate$CreatePrize(
          Options$Mutation$CreatePrize options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$CreatePrize> watchMutation$CreatePrize(
          WatchOptions$Mutation$CreatePrize options) =>
      this.watchMutation(options);
}

class Mutation$CreatePrize$HookResult {
  Mutation$CreatePrize$HookResult(
    this.runMutation,
    this.result,
  );

  final RunMutation$Mutation$CreatePrize runMutation;

  final graphql.QueryResult<Mutation$CreatePrize> result;
}

Mutation$CreatePrize$HookResult useMutation$CreatePrize(
    [WidgetOptions$Mutation$CreatePrize? options]) {
  final result = graphql_flutter
      .useMutation(options ?? WidgetOptions$Mutation$CreatePrize());
  return Mutation$CreatePrize$HookResult(
    (variables, {optimisticResult, typedOptimisticResult}) =>
        result.runMutation(
      variables.toJson(),
      optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
    ),
    result.result,
  );
}

graphql.ObservableQuery<Mutation$CreatePrize> useWatchMutation$CreatePrize(
        WatchOptions$Mutation$CreatePrize options) =>
    graphql_flutter.useWatchMutation(options);

class WidgetOptions$Mutation$CreatePrize
    extends graphql.MutationOptions<Mutation$CreatePrize> {
  WidgetOptions$Mutation$CreatePrize({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreatePrize? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$CreatePrize? onCompleted,
    graphql.OnMutationUpdate<Mutation$CreatePrize>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null ? null : _parserFn$Mutation$CreatePrize(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationCreatePrize,
          parserFn: _parserFn$Mutation$CreatePrize,
        );

  final OnMutationCompleted$Mutation$CreatePrize? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

typedef RunMutation$Mutation$CreatePrize
    = graphql.MultiSourceResult<Mutation$CreatePrize> Function(
  Variables$Mutation$CreatePrize, {
  Object? optimisticResult,
  Mutation$CreatePrize? typedOptimisticResult,
});
typedef Builder$Mutation$CreatePrize = widgets.Widget Function(
  RunMutation$Mutation$CreatePrize,
  graphql.QueryResult<Mutation$CreatePrize>?,
);

class Mutation$CreatePrize$Widget
    extends graphql_flutter.Mutation<Mutation$CreatePrize> {
  Mutation$CreatePrize$Widget({
    widgets.Key? key,
    WidgetOptions$Mutation$CreatePrize? options,
    required Builder$Mutation$CreatePrize builder,
  }) : super(
          key: key,
          options: options ?? WidgetOptions$Mutation$CreatePrize(),
          builder: (
            run,
            result,
          ) =>
              builder(
            (
              variables, {
              optimisticResult,
              typedOptimisticResult,
            }) =>
                run(
              variables.toJson(),
              optimisticResult:
                  optimisticResult ?? typedOptimisticResult?.toJson(),
            ),
            result,
          ),
        );
}

class Mutation$CreatePrize$createPrize {
  Mutation$CreatePrize$createPrize({
    required this.id,
    this.$__typename = 'CreateNewPrizeResponse',
  });

  factory Mutation$CreatePrize$createPrize.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$$__typename = json['__typename'];
    return Mutation$CreatePrize$createPrize(
      id: (l$id as int),
      $__typename: (l$$__typename as String),
    );
  }

  final int id;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$CreatePrize$createPrize) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
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

extension UtilityExtension$Mutation$CreatePrize$createPrize
    on Mutation$CreatePrize$createPrize {
  CopyWith$Mutation$CreatePrize$createPrize<Mutation$CreatePrize$createPrize>
      get copyWith => CopyWith$Mutation$CreatePrize$createPrize(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$CreatePrize$createPrize<TRes> {
  factory CopyWith$Mutation$CreatePrize$createPrize(
    Mutation$CreatePrize$createPrize instance,
    TRes Function(Mutation$CreatePrize$createPrize) then,
  ) = _CopyWithImpl$Mutation$CreatePrize$createPrize;

  factory CopyWith$Mutation$CreatePrize$createPrize.stub(TRes res) =
      _CopyWithStubImpl$Mutation$CreatePrize$createPrize;

  TRes call({
    int? id,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$CreatePrize$createPrize<TRes>
    implements CopyWith$Mutation$CreatePrize$createPrize<TRes> {
  _CopyWithImpl$Mutation$CreatePrize$createPrize(
    this._instance,
    this._then,
  );

  final Mutation$CreatePrize$createPrize _instance;

  final TRes Function(Mutation$CreatePrize$createPrize) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$CreatePrize$createPrize(
        id: id == _undefined || id == null ? _instance.id : (id as int),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$CreatePrize$createPrize<TRes>
    implements CopyWith$Mutation$CreatePrize$createPrize<TRes> {
  _CopyWithStubImpl$Mutation$CreatePrize$createPrize(this._res);

  TRes _res;

  call({
    int? id,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$ExchangePrize {
  factory Variables$Mutation$ExchangePrize(
          {required Input$ExchangePrizeInput input}) =>
      Variables$Mutation$ExchangePrize._({
        r'input': input,
      });

  Variables$Mutation$ExchangePrize._(this._$data);

  factory Variables$Mutation$ExchangePrize.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] =
        Input$ExchangePrizeInput.fromJson((l$input as Map<String, dynamic>));
    return Variables$Mutation$ExchangePrize._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$ExchangePrizeInput get input =>
      (_$data['input'] as Input$ExchangePrizeInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$ExchangePrize<Variables$Mutation$ExchangePrize>
      get copyWith => CopyWith$Variables$Mutation$ExchangePrize(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$ExchangePrize) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }
}

abstract class CopyWith$Variables$Mutation$ExchangePrize<TRes> {
  factory CopyWith$Variables$Mutation$ExchangePrize(
    Variables$Mutation$ExchangePrize instance,
    TRes Function(Variables$Mutation$ExchangePrize) then,
  ) = _CopyWithImpl$Variables$Mutation$ExchangePrize;

  factory CopyWith$Variables$Mutation$ExchangePrize.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$ExchangePrize;

  TRes call({Input$ExchangePrizeInput? input});
}

class _CopyWithImpl$Variables$Mutation$ExchangePrize<TRes>
    implements CopyWith$Variables$Mutation$ExchangePrize<TRes> {
  _CopyWithImpl$Variables$Mutation$ExchangePrize(
    this._instance,
    this._then,
  );

  final Variables$Mutation$ExchangePrize _instance;

  final TRes Function(Variables$Mutation$ExchangePrize) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? input = _undefined}) =>
      _then(Variables$Mutation$ExchangePrize._({
        ..._instance._$data,
        if (input != _undefined && input != null)
          'input': (input as Input$ExchangePrizeInput),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$ExchangePrize<TRes>
    implements CopyWith$Variables$Mutation$ExchangePrize<TRes> {
  _CopyWithStubImpl$Variables$Mutation$ExchangePrize(this._res);

  TRes _res;

  call({Input$ExchangePrizeInput? input}) => _res;
}

class Mutation$ExchangePrize {
  Mutation$ExchangePrize({
    required this.exchangePrize,
    this.$__typename = 'MutationRoot',
  });

  factory Mutation$ExchangePrize.fromJson(Map<String, dynamic> json) {
    final l$exchangePrize = json['exchangePrize'];
    final l$$__typename = json['__typename'];
    return Mutation$ExchangePrize(
      exchangePrize: Mutation$ExchangePrize$exchangePrize.fromJson(
          (l$exchangePrize as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$ExchangePrize$exchangePrize exchangePrize;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$exchangePrize = exchangePrize;
    _resultData['exchangePrize'] = l$exchangePrize.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$exchangePrize = exchangePrize;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$exchangePrize,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$ExchangePrize) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$exchangePrize = exchangePrize;
    final lOther$exchangePrize = other.exchangePrize;
    if (l$exchangePrize != lOther$exchangePrize) {
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

extension UtilityExtension$Mutation$ExchangePrize on Mutation$ExchangePrize {
  CopyWith$Mutation$ExchangePrize<Mutation$ExchangePrize> get copyWith =>
      CopyWith$Mutation$ExchangePrize(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$ExchangePrize<TRes> {
  factory CopyWith$Mutation$ExchangePrize(
    Mutation$ExchangePrize instance,
    TRes Function(Mutation$ExchangePrize) then,
  ) = _CopyWithImpl$Mutation$ExchangePrize;

  factory CopyWith$Mutation$ExchangePrize.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ExchangePrize;

  TRes call({
    Mutation$ExchangePrize$exchangePrize? exchangePrize,
    String? $__typename,
  });
  CopyWith$Mutation$ExchangePrize$exchangePrize<TRes> get exchangePrize;
}

class _CopyWithImpl$Mutation$ExchangePrize<TRes>
    implements CopyWith$Mutation$ExchangePrize<TRes> {
  _CopyWithImpl$Mutation$ExchangePrize(
    this._instance,
    this._then,
  );

  final Mutation$ExchangePrize _instance;

  final TRes Function(Mutation$ExchangePrize) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? exchangePrize = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$ExchangePrize(
        exchangePrize: exchangePrize == _undefined || exchangePrize == null
            ? _instance.exchangePrize
            : (exchangePrize as Mutation$ExchangePrize$exchangePrize),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$ExchangePrize$exchangePrize<TRes> get exchangePrize {
    final local$exchangePrize = _instance.exchangePrize;
    return CopyWith$Mutation$ExchangePrize$exchangePrize(
        local$exchangePrize, (e) => call(exchangePrize: e));
  }
}

class _CopyWithStubImpl$Mutation$ExchangePrize<TRes>
    implements CopyWith$Mutation$ExchangePrize<TRes> {
  _CopyWithStubImpl$Mutation$ExchangePrize(this._res);

  TRes _res;

  call({
    Mutation$ExchangePrize$exchangePrize? exchangePrize,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$ExchangePrize$exchangePrize<TRes> get exchangePrize =>
      CopyWith$Mutation$ExchangePrize$exchangePrize.stub(_res);
}

const documentNodeMutationExchangePrize = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'ExchangePrize'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'input')),
        type: NamedTypeNode(
          name: NameNode(value: 'ExchangePrizeInput'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'exchangePrize'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'input'),
            value: VariableNode(name: NameNode(value: 'input')),
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
            name: NameNode(value: 'txId'),
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
Mutation$ExchangePrize _parserFn$Mutation$ExchangePrize(
        Map<String, dynamic> data) =>
    Mutation$ExchangePrize.fromJson(data);
typedef OnMutationCompleted$Mutation$ExchangePrize = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$ExchangePrize?,
);

class Options$Mutation$ExchangePrize
    extends graphql.MutationOptions<Mutation$ExchangePrize> {
  Options$Mutation$ExchangePrize({
    String? operationName,
    required Variables$Mutation$ExchangePrize variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$ExchangePrize? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$ExchangePrize? onCompleted,
    graphql.OnMutationUpdate<Mutation$ExchangePrize>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$ExchangePrize(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationExchangePrize,
          parserFn: _parserFn$Mutation$ExchangePrize,
        );

  final OnMutationCompleted$Mutation$ExchangePrize? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$ExchangePrize
    extends graphql.WatchQueryOptions<Mutation$ExchangePrize> {
  WatchOptions$Mutation$ExchangePrize({
    String? operationName,
    required Variables$Mutation$ExchangePrize variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$ExchangePrize? typedOptimisticResult,
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
          document: documentNodeMutationExchangePrize,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$ExchangePrize,
        );
}

extension ClientExtension$Mutation$ExchangePrize on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$ExchangePrize>> mutate$ExchangePrize(
          Options$Mutation$ExchangePrize options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$ExchangePrize> watchMutation$ExchangePrize(
          WatchOptions$Mutation$ExchangePrize options) =>
      this.watchMutation(options);
}

class Mutation$ExchangePrize$HookResult {
  Mutation$ExchangePrize$HookResult(
    this.runMutation,
    this.result,
  );

  final RunMutation$Mutation$ExchangePrize runMutation;

  final graphql.QueryResult<Mutation$ExchangePrize> result;
}

Mutation$ExchangePrize$HookResult useMutation$ExchangePrize(
    [WidgetOptions$Mutation$ExchangePrize? options]) {
  final result = graphql_flutter
      .useMutation(options ?? WidgetOptions$Mutation$ExchangePrize());
  return Mutation$ExchangePrize$HookResult(
    (variables, {optimisticResult, typedOptimisticResult}) =>
        result.runMutation(
      variables.toJson(),
      optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
    ),
    result.result,
  );
}

graphql.ObservableQuery<Mutation$ExchangePrize> useWatchMutation$ExchangePrize(
        WatchOptions$Mutation$ExchangePrize options) =>
    graphql_flutter.useWatchMutation(options);

class WidgetOptions$Mutation$ExchangePrize
    extends graphql.MutationOptions<Mutation$ExchangePrize> {
  WidgetOptions$Mutation$ExchangePrize({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$ExchangePrize? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$ExchangePrize? onCompleted,
    graphql.OnMutationUpdate<Mutation$ExchangePrize>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$ExchangePrize(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationExchangePrize,
          parserFn: _parserFn$Mutation$ExchangePrize,
        );

  final OnMutationCompleted$Mutation$ExchangePrize? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

typedef RunMutation$Mutation$ExchangePrize
    = graphql.MultiSourceResult<Mutation$ExchangePrize> Function(
  Variables$Mutation$ExchangePrize, {
  Object? optimisticResult,
  Mutation$ExchangePrize? typedOptimisticResult,
});
typedef Builder$Mutation$ExchangePrize = widgets.Widget Function(
  RunMutation$Mutation$ExchangePrize,
  graphql.QueryResult<Mutation$ExchangePrize>?,
);

class Mutation$ExchangePrize$Widget
    extends graphql_flutter.Mutation<Mutation$ExchangePrize> {
  Mutation$ExchangePrize$Widget({
    widgets.Key? key,
    WidgetOptions$Mutation$ExchangePrize? options,
    required Builder$Mutation$ExchangePrize builder,
  }) : super(
          key: key,
          options: options ?? WidgetOptions$Mutation$ExchangePrize(),
          builder: (
            run,
            result,
          ) =>
              builder(
            (
              variables, {
              optimisticResult,
              typedOptimisticResult,
            }) =>
                run(
              variables.toJson(),
              optimisticResult:
                  optimisticResult ?? typedOptimisticResult?.toJson(),
            ),
            result,
          ),
        );
}

class Mutation$ExchangePrize$exchangePrize {
  Mutation$ExchangePrize$exchangePrize({
    required this.id,
    required this.txId,
    this.$__typename = 'ExchangePrizeResponse',
  });

  factory Mutation$ExchangePrize$exchangePrize.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$txId = json['txId'];
    final l$$__typename = json['__typename'];
    return Mutation$ExchangePrize$exchangePrize(
      id: (l$id as int),
      txId: (l$txId as String),
      $__typename: (l$$__typename as String),
    );
  }

  final int id;

  final String txId;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$txId = txId;
    _resultData['txId'] = l$txId;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$txId = txId;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$txId,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$ExchangePrize$exchangePrize) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$txId = txId;
    final lOther$txId = other.txId;
    if (l$txId != lOther$txId) {
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

extension UtilityExtension$Mutation$ExchangePrize$exchangePrize
    on Mutation$ExchangePrize$exchangePrize {
  CopyWith$Mutation$ExchangePrize$exchangePrize<
          Mutation$ExchangePrize$exchangePrize>
      get copyWith => CopyWith$Mutation$ExchangePrize$exchangePrize(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$ExchangePrize$exchangePrize<TRes> {
  factory CopyWith$Mutation$ExchangePrize$exchangePrize(
    Mutation$ExchangePrize$exchangePrize instance,
    TRes Function(Mutation$ExchangePrize$exchangePrize) then,
  ) = _CopyWithImpl$Mutation$ExchangePrize$exchangePrize;

  factory CopyWith$Mutation$ExchangePrize$exchangePrize.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ExchangePrize$exchangePrize;

  TRes call({
    int? id,
    String? txId,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$ExchangePrize$exchangePrize<TRes>
    implements CopyWith$Mutation$ExchangePrize$exchangePrize<TRes> {
  _CopyWithImpl$Mutation$ExchangePrize$exchangePrize(
    this._instance,
    this._then,
  );

  final Mutation$ExchangePrize$exchangePrize _instance;

  final TRes Function(Mutation$ExchangePrize$exchangePrize) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? txId = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$ExchangePrize$exchangePrize(
        id: id == _undefined || id == null ? _instance.id : (id as int),
        txId: txId == _undefined || txId == null
            ? _instance.txId
            : (txId as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$ExchangePrize$exchangePrize<TRes>
    implements CopyWith$Mutation$ExchangePrize$exchangePrize<TRes> {
  _CopyWithStubImpl$Mutation$ExchangePrize$exchangePrize(this._res);

  TRes _res;

  call({
    int? id,
    String? txId,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$CreateNewArtist {
  factory Variables$Mutation$CreateNewArtist(
          {required Input$CreateNewArtistInput input}) =>
      Variables$Mutation$CreateNewArtist._({
        r'input': input,
      });

  Variables$Mutation$CreateNewArtist._(this._$data);

  factory Variables$Mutation$CreateNewArtist.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] =
        Input$CreateNewArtistInput.fromJson((l$input as Map<String, dynamic>));
    return Variables$Mutation$CreateNewArtist._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$CreateNewArtistInput get input =>
      (_$data['input'] as Input$CreateNewArtistInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$CreateNewArtist<
          Variables$Mutation$CreateNewArtist>
      get copyWith => CopyWith$Variables$Mutation$CreateNewArtist(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$CreateNewArtist) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }
}

abstract class CopyWith$Variables$Mutation$CreateNewArtist<TRes> {
  factory CopyWith$Variables$Mutation$CreateNewArtist(
    Variables$Mutation$CreateNewArtist instance,
    TRes Function(Variables$Mutation$CreateNewArtist) then,
  ) = _CopyWithImpl$Variables$Mutation$CreateNewArtist;

  factory CopyWith$Variables$Mutation$CreateNewArtist.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$CreateNewArtist;

  TRes call({Input$CreateNewArtistInput? input});
}

class _CopyWithImpl$Variables$Mutation$CreateNewArtist<TRes>
    implements CopyWith$Variables$Mutation$CreateNewArtist<TRes> {
  _CopyWithImpl$Variables$Mutation$CreateNewArtist(
    this._instance,
    this._then,
  );

  final Variables$Mutation$CreateNewArtist _instance;

  final TRes Function(Variables$Mutation$CreateNewArtist) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? input = _undefined}) =>
      _then(Variables$Mutation$CreateNewArtist._({
        ..._instance._$data,
        if (input != _undefined && input != null)
          'input': (input as Input$CreateNewArtistInput),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$CreateNewArtist<TRes>
    implements CopyWith$Variables$Mutation$CreateNewArtist<TRes> {
  _CopyWithStubImpl$Variables$Mutation$CreateNewArtist(this._res);

  TRes _res;

  call({Input$CreateNewArtistInput? input}) => _res;
}

class Mutation$CreateNewArtist {
  Mutation$CreateNewArtist({
    required this.createNewArtist,
    this.$__typename = 'MutationRoot',
  });

  factory Mutation$CreateNewArtist.fromJson(Map<String, dynamic> json) {
    final l$createNewArtist = json['createNewArtist'];
    final l$$__typename = json['__typename'];
    return Mutation$CreateNewArtist(
      createNewArtist: Mutation$CreateNewArtist$createNewArtist.fromJson(
          (l$createNewArtist as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$CreateNewArtist$createNewArtist createNewArtist;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$createNewArtist = createNewArtist;
    _resultData['createNewArtist'] = l$createNewArtist.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$createNewArtist = createNewArtist;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$createNewArtist,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$CreateNewArtist) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$createNewArtist = createNewArtist;
    final lOther$createNewArtist = other.createNewArtist;
    if (l$createNewArtist != lOther$createNewArtist) {
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

extension UtilityExtension$Mutation$CreateNewArtist
    on Mutation$CreateNewArtist {
  CopyWith$Mutation$CreateNewArtist<Mutation$CreateNewArtist> get copyWith =>
      CopyWith$Mutation$CreateNewArtist(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$CreateNewArtist<TRes> {
  factory CopyWith$Mutation$CreateNewArtist(
    Mutation$CreateNewArtist instance,
    TRes Function(Mutation$CreateNewArtist) then,
  ) = _CopyWithImpl$Mutation$CreateNewArtist;

  factory CopyWith$Mutation$CreateNewArtist.stub(TRes res) =
      _CopyWithStubImpl$Mutation$CreateNewArtist;

  TRes call({
    Mutation$CreateNewArtist$createNewArtist? createNewArtist,
    String? $__typename,
  });
  CopyWith$Mutation$CreateNewArtist$createNewArtist<TRes> get createNewArtist;
}

class _CopyWithImpl$Mutation$CreateNewArtist<TRes>
    implements CopyWith$Mutation$CreateNewArtist<TRes> {
  _CopyWithImpl$Mutation$CreateNewArtist(
    this._instance,
    this._then,
  );

  final Mutation$CreateNewArtist _instance;

  final TRes Function(Mutation$CreateNewArtist) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? createNewArtist = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$CreateNewArtist(
        createNewArtist:
            createNewArtist == _undefined || createNewArtist == null
                ? _instance.createNewArtist
                : (createNewArtist as Mutation$CreateNewArtist$createNewArtist),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$CreateNewArtist$createNewArtist<TRes> get createNewArtist {
    final local$createNewArtist = _instance.createNewArtist;
    return CopyWith$Mutation$CreateNewArtist$createNewArtist(
        local$createNewArtist, (e) => call(createNewArtist: e));
  }
}

class _CopyWithStubImpl$Mutation$CreateNewArtist<TRes>
    implements CopyWith$Mutation$CreateNewArtist<TRes> {
  _CopyWithStubImpl$Mutation$CreateNewArtist(this._res);

  TRes _res;

  call({
    Mutation$CreateNewArtist$createNewArtist? createNewArtist,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$CreateNewArtist$createNewArtist<TRes> get createNewArtist =>
      CopyWith$Mutation$CreateNewArtist$createNewArtist.stub(_res);
}

const documentNodeMutationCreateNewArtist = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'CreateNewArtist'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'input')),
        type: NamedTypeNode(
          name: NameNode(value: 'CreateNewArtistInput'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'createNewArtist'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'input'),
            value: VariableNode(name: NameNode(value: 'input')),
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
Mutation$CreateNewArtist _parserFn$Mutation$CreateNewArtist(
        Map<String, dynamic> data) =>
    Mutation$CreateNewArtist.fromJson(data);
typedef OnMutationCompleted$Mutation$CreateNewArtist = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$CreateNewArtist?,
);

class Options$Mutation$CreateNewArtist
    extends graphql.MutationOptions<Mutation$CreateNewArtist> {
  Options$Mutation$CreateNewArtist({
    String? operationName,
    required Variables$Mutation$CreateNewArtist variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreateNewArtist? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$CreateNewArtist? onCompleted,
    graphql.OnMutationUpdate<Mutation$CreateNewArtist>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$CreateNewArtist(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationCreateNewArtist,
          parserFn: _parserFn$Mutation$CreateNewArtist,
        );

  final OnMutationCompleted$Mutation$CreateNewArtist? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$CreateNewArtist
    extends graphql.WatchQueryOptions<Mutation$CreateNewArtist> {
  WatchOptions$Mutation$CreateNewArtist({
    String? operationName,
    required Variables$Mutation$CreateNewArtist variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreateNewArtist? typedOptimisticResult,
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
          document: documentNodeMutationCreateNewArtist,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$CreateNewArtist,
        );
}

extension ClientExtension$Mutation$CreateNewArtist on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$CreateNewArtist>> mutate$CreateNewArtist(
          Options$Mutation$CreateNewArtist options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$CreateNewArtist>
      watchMutation$CreateNewArtist(
              WatchOptions$Mutation$CreateNewArtist options) =>
          this.watchMutation(options);
}

class Mutation$CreateNewArtist$HookResult {
  Mutation$CreateNewArtist$HookResult(
    this.runMutation,
    this.result,
  );

  final RunMutation$Mutation$CreateNewArtist runMutation;

  final graphql.QueryResult<Mutation$CreateNewArtist> result;
}

Mutation$CreateNewArtist$HookResult useMutation$CreateNewArtist(
    [WidgetOptions$Mutation$CreateNewArtist? options]) {
  final result = graphql_flutter
      .useMutation(options ?? WidgetOptions$Mutation$CreateNewArtist());
  return Mutation$CreateNewArtist$HookResult(
    (variables, {optimisticResult, typedOptimisticResult}) =>
        result.runMutation(
      variables.toJson(),
      optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
    ),
    result.result,
  );
}

graphql.ObservableQuery<Mutation$CreateNewArtist>
    useWatchMutation$CreateNewArtist(
            WatchOptions$Mutation$CreateNewArtist options) =>
        graphql_flutter.useWatchMutation(options);

class WidgetOptions$Mutation$CreateNewArtist
    extends graphql.MutationOptions<Mutation$CreateNewArtist> {
  WidgetOptions$Mutation$CreateNewArtist({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreateNewArtist? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$CreateNewArtist? onCompleted,
    graphql.OnMutationUpdate<Mutation$CreateNewArtist>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null
                        ? null
                        : _parserFn$Mutation$CreateNewArtist(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationCreateNewArtist,
          parserFn: _parserFn$Mutation$CreateNewArtist,
        );

  final OnMutationCompleted$Mutation$CreateNewArtist? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

typedef RunMutation$Mutation$CreateNewArtist
    = graphql.MultiSourceResult<Mutation$CreateNewArtist> Function(
  Variables$Mutation$CreateNewArtist, {
  Object? optimisticResult,
  Mutation$CreateNewArtist? typedOptimisticResult,
});
typedef Builder$Mutation$CreateNewArtist = widgets.Widget Function(
  RunMutation$Mutation$CreateNewArtist,
  graphql.QueryResult<Mutation$CreateNewArtist>?,
);

class Mutation$CreateNewArtist$Widget
    extends graphql_flutter.Mutation<Mutation$CreateNewArtist> {
  Mutation$CreateNewArtist$Widget({
    widgets.Key? key,
    WidgetOptions$Mutation$CreateNewArtist? options,
    required Builder$Mutation$CreateNewArtist builder,
  }) : super(
          key: key,
          options: options ?? WidgetOptions$Mutation$CreateNewArtist(),
          builder: (
            run,
            result,
          ) =>
              builder(
            (
              variables, {
              optimisticResult,
              typedOptimisticResult,
            }) =>
                run(
              variables.toJson(),
              optimisticResult:
                  optimisticResult ?? typedOptimisticResult?.toJson(),
            ),
            result,
          ),
        );
}

class Mutation$CreateNewArtist$createNewArtist {
  Mutation$CreateNewArtist$createNewArtist({
    required this.id,
    required this.name,
    this.$__typename = 'CreateNewArtistResponse',
  });

  factory Mutation$CreateNewArtist$createNewArtist.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$$__typename = json['__typename'];
    return Mutation$CreateNewArtist$createNewArtist(
      id: (l$id as String),
      name: (l$name as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String name;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$name,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$CreateNewArtist$createNewArtist) ||
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
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$CreateNewArtist$createNewArtist
    on Mutation$CreateNewArtist$createNewArtist {
  CopyWith$Mutation$CreateNewArtist$createNewArtist<
          Mutation$CreateNewArtist$createNewArtist>
      get copyWith => CopyWith$Mutation$CreateNewArtist$createNewArtist(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$CreateNewArtist$createNewArtist<TRes> {
  factory CopyWith$Mutation$CreateNewArtist$createNewArtist(
    Mutation$CreateNewArtist$createNewArtist instance,
    TRes Function(Mutation$CreateNewArtist$createNewArtist) then,
  ) = _CopyWithImpl$Mutation$CreateNewArtist$createNewArtist;

  factory CopyWith$Mutation$CreateNewArtist$createNewArtist.stub(TRes res) =
      _CopyWithStubImpl$Mutation$CreateNewArtist$createNewArtist;

  TRes call({
    String? id,
    String? name,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$CreateNewArtist$createNewArtist<TRes>
    implements CopyWith$Mutation$CreateNewArtist$createNewArtist<TRes> {
  _CopyWithImpl$Mutation$CreateNewArtist$createNewArtist(
    this._instance,
    this._then,
  );

  final Mutation$CreateNewArtist$createNewArtist _instance;

  final TRes Function(Mutation$CreateNewArtist$createNewArtist) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$CreateNewArtist$createNewArtist(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$CreateNewArtist$createNewArtist<TRes>
    implements CopyWith$Mutation$CreateNewArtist$createNewArtist<TRes> {
  _CopyWithStubImpl$Mutation$CreateNewArtist$createNewArtist(this._res);

  TRes _res;

  call({
    String? id,
    String? name,
    String? $__typename,
  }) =>
      _res;
}
