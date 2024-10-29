// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:client/data/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:client/data/graphql/query/__generated__/query.ast.gql.dart'
    as _i5;
import 'package:client/data/graphql/query/__generated__/query.data.gql.dart'
    as _i2;
import 'package:client/data/graphql/query/__generated__/query.var.gql.dart'
    as _i3;
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'query.req.gql.g.dart';

abstract class GHealthCheckReq
    implements
        Built<GHealthCheckReq, GHealthCheckReqBuilder>,
        _i1.OperationRequest<_i2.GHealthCheckData, _i3.GHealthCheckVars> {
  GHealthCheckReq._();

  factory GHealthCheckReq([void Function(GHealthCheckReqBuilder b) updates]) =
      _$GHealthCheckReq;

  static void _initializeBuilder(GHealthCheckReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'HealthCheck',
    )
    ..executeOnListen = true;

  @override
  _i3.GHealthCheckVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GHealthCheckData? Function(
    _i2.GHealthCheckData?,
    _i2.GHealthCheckData?,
  )? get updateResult;
  @override
  _i2.GHealthCheckData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GHealthCheckData? parseData(Map<String, dynamic> json) =>
      _i2.GHealthCheckData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GHealthCheckData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GHealthCheckData, _i3.GHealthCheckVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GHealthCheckReq> get serializer =>
      _$gHealthCheckReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GHealthCheckReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GHealthCheckReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GHealthCheckReq.serializer,
        json,
      );
}

abstract class GGetUserInfoReq
    implements
        Built<GGetUserInfoReq, GGetUserInfoReqBuilder>,
        _i1.OperationRequest<_i2.GGetUserInfoData, _i3.GGetUserInfoVars> {
  GGetUserInfoReq._();

  factory GGetUserInfoReq([void Function(GGetUserInfoReqBuilder b) updates]) =
      _$GGetUserInfoReq;

  static void _initializeBuilder(GGetUserInfoReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetUserInfo',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetUserInfoVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GGetUserInfoData? Function(
    _i2.GGetUserInfoData?,
    _i2.GGetUserInfoData?,
  )? get updateResult;
  @override
  _i2.GGetUserInfoData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GGetUserInfoData? parseData(Map<String, dynamic> json) =>
      _i2.GGetUserInfoData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetUserInfoData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetUserInfoData, _i3.GGetUserInfoVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetUserInfoReq> get serializer =>
      _$gGetUserInfoReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetUserInfoReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetUserInfoReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetUserInfoReq.serializer,
        json,
      );
}

abstract class GGetAllOffersReq
    implements
        Built<GGetAllOffersReq, GGetAllOffersReqBuilder>,
        _i1.OperationRequest<_i2.GGetAllOffersData, _i3.GGetAllOffersVars> {
  GGetAllOffersReq._();

  factory GGetAllOffersReq([void Function(GGetAllOffersReqBuilder b) updates]) =
      _$GGetAllOffersReq;

  static void _initializeBuilder(GGetAllOffersReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetAllOffers',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetAllOffersVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GGetAllOffersData? Function(
    _i2.GGetAllOffersData?,
    _i2.GGetAllOffersData?,
  )? get updateResult;
  @override
  _i2.GGetAllOffersData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GGetAllOffersData? parseData(Map<String, dynamic> json) =>
      _i2.GGetAllOffersData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetAllOffersData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetAllOffersData, _i3.GGetAllOffersVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetAllOffersReq> get serializer =>
      _$gGetAllOffersReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetAllOffersReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetAllOffersReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetAllOffersReq.serializer,
        json,
      );
}

abstract class GGetMessageRoomsReq
    implements
        Built<GGetMessageRoomsReq, GGetMessageRoomsReqBuilder>,
        _i1
        .OperationRequest<_i2.GGetMessageRoomsData, _i3.GGetMessageRoomsVars> {
  GGetMessageRoomsReq._();

  factory GGetMessageRoomsReq(
          [void Function(GGetMessageRoomsReqBuilder b) updates]) =
      _$GGetMessageRoomsReq;

  static void _initializeBuilder(GGetMessageRoomsReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetMessageRooms',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetMessageRoomsVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GGetMessageRoomsData? Function(
    _i2.GGetMessageRoomsData?,
    _i2.GGetMessageRoomsData?,
  )? get updateResult;
  @override
  _i2.GGetMessageRoomsData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GGetMessageRoomsData? parseData(Map<String, dynamic> json) =>
      _i2.GGetMessageRoomsData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetMessageRoomsData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetMessageRoomsData, _i3.GGetMessageRoomsVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetMessageRoomsReq> get serializer =>
      _$gGetMessageRoomsReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetMessageRoomsReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMessageRoomsReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetMessageRoomsReq.serializer,
        json,
      );
}

abstract class GGetMessagesByMessageRoomIdReq
    implements
        Built<GGetMessagesByMessageRoomIdReq,
            GGetMessagesByMessageRoomIdReqBuilder>,
        _i1.OperationRequest<_i2.GGetMessagesByMessageRoomIdData,
            _i3.GGetMessagesByMessageRoomIdVars> {
  GGetMessagesByMessageRoomIdReq._();

  factory GGetMessagesByMessageRoomIdReq(
          [void Function(GGetMessagesByMessageRoomIdReqBuilder b) updates]) =
      _$GGetMessagesByMessageRoomIdReq;

  static void _initializeBuilder(GGetMessagesByMessageRoomIdReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetMessagesByMessageRoomId',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetMessagesByMessageRoomIdVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GGetMessagesByMessageRoomIdData? Function(
    _i2.GGetMessagesByMessageRoomIdData?,
    _i2.GGetMessagesByMessageRoomIdData?,
  )? get updateResult;
  @override
  _i2.GGetMessagesByMessageRoomIdData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GGetMessagesByMessageRoomIdData? parseData(Map<String, dynamic> json) =>
      _i2.GGetMessagesByMessageRoomIdData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetMessagesByMessageRoomIdData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetMessagesByMessageRoomIdData,
      _i3.GGetMessagesByMessageRoomIdVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetMessagesByMessageRoomIdReq> get serializer =>
      _$gGetMessagesByMessageRoomIdReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetMessagesByMessageRoomIdReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMessagesByMessageRoomIdReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetMessagesByMessageRoomIdReq.serializer,
        json,
      );
}

abstract class GGetNotificationsReq
    implements
        Built<GGetNotificationsReq, GGetNotificationsReqBuilder>,
        _i1.OperationRequest<_i2.GGetNotificationsData,
            _i3.GGetNotificationsVars> {
  GGetNotificationsReq._();

  factory GGetNotificationsReq(
          [void Function(GGetNotificationsReqBuilder b) updates]) =
      _$GGetNotificationsReq;

  static void _initializeBuilder(GGetNotificationsReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetNotifications',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetNotificationsVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GGetNotificationsData? Function(
    _i2.GGetNotificationsData?,
    _i2.GGetNotificationsData?,
  )? get updateResult;
  @override
  _i2.GGetNotificationsData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GGetNotificationsData? parseData(Map<String, dynamic> json) =>
      _i2.GGetNotificationsData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetNotificationsData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetNotificationsData, _i3.GGetNotificationsVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetNotificationsReq> get serializer =>
      _$gGetNotificationsReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetNotificationsReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetNotificationsReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetNotificationsReq.serializer,
        json,
      );
}

abstract class GGetUserDataReq
    implements
        Built<GGetUserDataReq, GGetUserDataReqBuilder>,
        _i1.OperationRequest<_i2.GGetUserDataData, _i3.GGetUserDataVars> {
  GGetUserDataReq._();

  factory GGetUserDataReq([void Function(GGetUserDataReqBuilder b) updates]) =
      _$GGetUserDataReq;

  static void _initializeBuilder(GGetUserDataReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetUserData',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetUserDataVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GGetUserDataData? Function(
    _i2.GGetUserDataData?,
    _i2.GGetUserDataData?,
  )? get updateResult;
  @override
  _i2.GGetUserDataData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GGetUserDataData? parseData(Map<String, dynamic> json) =>
      _i2.GGetUserDataData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetUserDataData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetUserDataData, _i3.GGetUserDataVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetUserDataReq> get serializer =>
      _$gGetUserDataReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetUserDataReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetUserDataReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetUserDataReq.serializer,
        json,
      );
}

abstract class GGetOverviewDataReq
    implements
        Built<GGetOverviewDataReq, GGetOverviewDataReqBuilder>,
        _i1
        .OperationRequest<_i2.GGetOverviewDataData, _i3.GGetOverviewDataVars> {
  GGetOverviewDataReq._();

  factory GGetOverviewDataReq(
          [void Function(GGetOverviewDataReqBuilder b) updates]) =
      _$GGetOverviewDataReq;

  static void _initializeBuilder(GGetOverviewDataReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetOverviewData',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetOverviewDataVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GGetOverviewDataData? Function(
    _i2.GGetOverviewDataData?,
    _i2.GGetOverviewDataData?,
  )? get updateResult;
  @override
  _i2.GGetOverviewDataData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GGetOverviewDataData? parseData(Map<String, dynamic> json) =>
      _i2.GGetOverviewDataData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetOverviewDataData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetOverviewDataData, _i3.GGetOverviewDataVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetOverviewDataReq> get serializer =>
      _$gGetOverviewDataReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetOverviewDataReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOverviewDataReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetOverviewDataReq.serializer,
        json,
      );
}

abstract class GGetTrendingDataReq
    implements
        Built<GGetTrendingDataReq, GGetTrendingDataReqBuilder>,
        _i1
        .OperationRequest<_i2.GGetTrendingDataData, _i3.GGetTrendingDataVars> {
  GGetTrendingDataReq._();

  factory GGetTrendingDataReq(
          [void Function(GGetTrendingDataReqBuilder b) updates]) =
      _$GGetTrendingDataReq;

  static void _initializeBuilder(GGetTrendingDataReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetTrendingData',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetTrendingDataVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GGetTrendingDataData? Function(
    _i2.GGetTrendingDataData?,
    _i2.GGetTrendingDataData?,
  )? get updateResult;
  @override
  _i2.GGetTrendingDataData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GGetTrendingDataData? parseData(Map<String, dynamic> json) =>
      _i2.GGetTrendingDataData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetTrendingDataData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetTrendingDataData, _i3.GGetTrendingDataVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetTrendingDataReq> get serializer =>
      _$gGetTrendingDataReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetTrendingDataReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetTrendingDataReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetTrendingDataReq.serializer,
        json,
      );
}

abstract class GGetLineChartDataReq
    implements
        Built<GGetLineChartDataReq, GGetLineChartDataReqBuilder>,
        _i1.OperationRequest<_i2.GGetLineChartDataData,
            _i3.GGetLineChartDataVars> {
  GGetLineChartDataReq._();

  factory GGetLineChartDataReq(
          [void Function(GGetLineChartDataReqBuilder b) updates]) =
      _$GGetLineChartDataReq;

  static void _initializeBuilder(GGetLineChartDataReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetLineChartData',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetLineChartDataVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GGetLineChartDataData? Function(
    _i2.GGetLineChartDataData?,
    _i2.GGetLineChartDataData?,
  )? get updateResult;
  @override
  _i2.GGetLineChartDataData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GGetLineChartDataData? parseData(Map<String, dynamic> json) =>
      _i2.GGetLineChartDataData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetLineChartDataData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetLineChartDataData, _i3.GGetLineChartDataVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetLineChartDataReq> get serializer =>
      _$gGetLineChartDataReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetLineChartDataReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetLineChartDataReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetLineChartDataReq.serializer,
        json,
      );
}

abstract class GGetPlaybacksByGenderDataReq
    implements
        Built<GGetPlaybacksByGenderDataReq,
            GGetPlaybacksByGenderDataReqBuilder>,
        _i1.OperationRequest<_i2.GGetPlaybacksByGenderDataData,
            _i3.GGetPlaybacksByGenderDataVars> {
  GGetPlaybacksByGenderDataReq._();

  factory GGetPlaybacksByGenderDataReq(
          [void Function(GGetPlaybacksByGenderDataReqBuilder b) updates]) =
      _$GGetPlaybacksByGenderDataReq;

  static void _initializeBuilder(GGetPlaybacksByGenderDataReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetPlaybacksByGenderData',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetPlaybacksByGenderDataVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GGetPlaybacksByGenderDataData? Function(
    _i2.GGetPlaybacksByGenderDataData?,
    _i2.GGetPlaybacksByGenderDataData?,
  )? get updateResult;
  @override
  _i2.GGetPlaybacksByGenderDataData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GGetPlaybacksByGenderDataData? parseData(Map<String, dynamic> json) =>
      _i2.GGetPlaybacksByGenderDataData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetPlaybacksByGenderDataData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetPlaybacksByGenderDataData,
      _i3.GGetPlaybacksByGenderDataVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetPlaybacksByGenderDataReq> get serializer =>
      _$gGetPlaybacksByGenderDataReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetPlaybacksByGenderDataReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetPlaybacksByGenderDataReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetPlaybacksByGenderDataReq.serializer,
        json,
      );
}

abstract class GGetPlaybacksByGenerationDataReq
    implements
        Built<GGetPlaybacksByGenerationDataReq,
            GGetPlaybacksByGenerationDataReqBuilder>,
        _i1.OperationRequest<_i2.GGetPlaybacksByGenerationDataData,
            _i3.GGetPlaybacksByGenerationDataVars> {
  GGetPlaybacksByGenerationDataReq._();

  factory GGetPlaybacksByGenerationDataReq(
          [void Function(GGetPlaybacksByGenerationDataReqBuilder b) updates]) =
      _$GGetPlaybacksByGenerationDataReq;

  static void _initializeBuilder(GGetPlaybacksByGenerationDataReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetPlaybacksByGenerationData',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetPlaybacksByGenerationDataVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GGetPlaybacksByGenerationDataData? Function(
    _i2.GGetPlaybacksByGenerationDataData?,
    _i2.GGetPlaybacksByGenerationDataData?,
  )? get updateResult;
  @override
  _i2.GGetPlaybacksByGenerationDataData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GGetPlaybacksByGenerationDataData? parseData(Map<String, dynamic> json) =>
      _i2.GGetPlaybacksByGenerationDataData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetPlaybacksByGenerationDataData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetPlaybacksByGenerationDataData,
      _i3.GGetPlaybacksByGenerationDataVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetPlaybacksByGenerationDataReq> get serializer =>
      _$gGetPlaybacksByGenerationDataReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetPlaybacksByGenerationDataReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetPlaybacksByGenerationDataReq? fromJson(
          Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetPlaybacksByGenerationDataReq.serializer,
        json,
      );
}

abstract class GGetCommunitiesReq
    implements
        Built<GGetCommunitiesReq, GGetCommunitiesReqBuilder>,
        _i1.OperationRequest<_i2.GGetCommunitiesData, _i3.GGetCommunitiesVars> {
  GGetCommunitiesReq._();

  factory GGetCommunitiesReq(
          [void Function(GGetCommunitiesReqBuilder b) updates]) =
      _$GGetCommunitiesReq;

  static void _initializeBuilder(GGetCommunitiesReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetCommunities',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetCommunitiesVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GGetCommunitiesData? Function(
    _i2.GGetCommunitiesData?,
    _i2.GGetCommunitiesData?,
  )? get updateResult;
  @override
  _i2.GGetCommunitiesData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GGetCommunitiesData? parseData(Map<String, dynamic> json) =>
      _i2.GGetCommunitiesData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetCommunitiesData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetCommunitiesData, _i3.GGetCommunitiesVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetCommunitiesReq> get serializer =>
      _$gGetCommunitiesReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetCommunitiesReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetCommunitiesReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetCommunitiesReq.serializer,
        json,
      );
}

abstract class GGetOfferStatsByUserReq
    implements
        Built<GGetOfferStatsByUserReq, GGetOfferStatsByUserReqBuilder>,
        _i1.OperationRequest<_i2.GGetOfferStatsByUserData,
            _i3.GGetOfferStatsByUserVars> {
  GGetOfferStatsByUserReq._();

  factory GGetOfferStatsByUserReq(
          [void Function(GGetOfferStatsByUserReqBuilder b) updates]) =
      _$GGetOfferStatsByUserReq;

  static void _initializeBuilder(GGetOfferStatsByUserReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetOfferStatsByUser',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetOfferStatsByUserVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GGetOfferStatsByUserData? Function(
    _i2.GGetOfferStatsByUserData?,
    _i2.GGetOfferStatsByUserData?,
  )? get updateResult;
  @override
  _i2.GGetOfferStatsByUserData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GGetOfferStatsByUserData? parseData(Map<String, dynamic> json) =>
      _i2.GGetOfferStatsByUserData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetOfferStatsByUserData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetOfferStatsByUserData,
      _i3.GGetOfferStatsByUserVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetOfferStatsByUserReq> get serializer =>
      _$gGetOfferStatsByUserReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetOfferStatsByUserReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOfferStatsByUserReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetOfferStatsByUserReq.serializer,
        json,
      );
}

abstract class GGetOffersByOwnerReq
    implements
        Built<GGetOffersByOwnerReq, GGetOffersByOwnerReqBuilder>,
        _i1.OperationRequest<_i2.GGetOffersByOwnerData,
            _i3.GGetOffersByOwnerVars> {
  GGetOffersByOwnerReq._();

  factory GGetOffersByOwnerReq(
          [void Function(GGetOffersByOwnerReqBuilder b) updates]) =
      _$GGetOffersByOwnerReq;

  static void _initializeBuilder(GGetOffersByOwnerReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetOffersByOwner',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetOffersByOwnerVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GGetOffersByOwnerData? Function(
    _i2.GGetOffersByOwnerData?,
    _i2.GGetOffersByOwnerData?,
  )? get updateResult;
  @override
  _i2.GGetOffersByOwnerData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GGetOffersByOwnerData? parseData(Map<String, dynamic> json) =>
      _i2.GGetOffersByOwnerData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetOffersByOwnerData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetOffersByOwnerData, _i3.GGetOffersByOwnerVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetOffersByOwnerReq> get serializer =>
      _$gGetOffersByOwnerReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetOffersByOwnerReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOffersByOwnerReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetOffersByOwnerReq.serializer,
        json,
      );
}

abstract class GGetOffersByStatusReq
    implements
        Built<GGetOffersByStatusReq, GGetOffersByStatusReqBuilder>,
        _i1.OperationRequest<_i2.GGetOffersByStatusData,
            _i3.GGetOffersByStatusVars> {
  GGetOffersByStatusReq._();

  factory GGetOffersByStatusReq(
          [void Function(GGetOffersByStatusReqBuilder b) updates]) =
      _$GGetOffersByStatusReq;

  static void _initializeBuilder(GGetOffersByStatusReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetOffersByStatus',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetOffersByStatusVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GGetOffersByStatusData? Function(
    _i2.GGetOffersByStatusData?,
    _i2.GGetOffersByStatusData?,
  )? get updateResult;
  @override
  _i2.GGetOffersByStatusData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GGetOffersByStatusData? parseData(Map<String, dynamic> json) =>
      _i2.GGetOffersByStatusData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetOffersByStatusData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetOffersByStatusData, _i3.GGetOffersByStatusVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetOffersByStatusReq> get serializer =>
      _$gGetOffersByStatusReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetOffersByStatusReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOffersByStatusReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetOffersByStatusReq.serializer,
        json,
      );
}

abstract class GGetOffersReq
    implements
        Built<GGetOffersReq, GGetOffersReqBuilder>,
        _i1.OperationRequest<_i2.GGetOffersData, _i3.GGetOffersVars> {
  GGetOffersReq._();

  factory GGetOffersReq([void Function(GGetOffersReqBuilder b) updates]) =
      _$GGetOffersReq;

  static void _initializeBuilder(GGetOffersReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetOffers',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetOffersVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GGetOffersData? Function(
    _i2.GGetOffersData?,
    _i2.GGetOffersData?,
  )? get updateResult;
  @override
  _i2.GGetOffersData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GGetOffersData? parseData(Map<String, dynamic> json) =>
      _i2.GGetOffersData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetOffersData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetOffersData, _i3.GGetOffersVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetOffersReq> get serializer => _$gGetOffersReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetOffersReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOffersReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetOffersReq.serializer,
        json,
      );
}

abstract class GGetOffersByCategoryReq
    implements
        Built<GGetOffersByCategoryReq, GGetOffersByCategoryReqBuilder>,
        _i1.OperationRequest<_i2.GGetOffersByCategoryData,
            _i3.GGetOffersByCategoryVars> {
  GGetOffersByCategoryReq._();

  factory GGetOffersByCategoryReq(
          [void Function(GGetOffersByCategoryReqBuilder b) updates]) =
      _$GGetOffersByCategoryReq;

  static void _initializeBuilder(GGetOffersByCategoryReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetOffersByCategory',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetOffersByCategoryVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GGetOffersByCategoryData? Function(
    _i2.GGetOffersByCategoryData?,
    _i2.GGetOffersByCategoryData?,
  )? get updateResult;
  @override
  _i2.GGetOffersByCategoryData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GGetOffersByCategoryData? parseData(Map<String, dynamic> json) =>
      _i2.GGetOffersByCategoryData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetOffersByCategoryData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetOffersByCategoryData,
      _i3.GGetOffersByCategoryVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetOffersByCategoryReq> get serializer =>
      _$gGetOffersByCategoryReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetOffersByCategoryReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOffersByCategoryReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetOffersByCategoryReq.serializer,
        json,
      );
}

abstract class GGetMessagesInProgressReq
    implements
        Built<GGetMessagesInProgressReq, GGetMessagesInProgressReqBuilder>,
        _i1.OperationRequest<_i2.GGetMessagesInProgressData,
            _i3.GGetMessagesInProgressVars> {
  GGetMessagesInProgressReq._();

  factory GGetMessagesInProgressReq(
          [void Function(GGetMessagesInProgressReqBuilder b) updates]) =
      _$GGetMessagesInProgressReq;

  static void _initializeBuilder(GGetMessagesInProgressReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetMessagesInProgress',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetMessagesInProgressVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GGetMessagesInProgressData? Function(
    _i2.GGetMessagesInProgressData?,
    _i2.GGetMessagesInProgressData?,
  )? get updateResult;
  @override
  _i2.GGetMessagesInProgressData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GGetMessagesInProgressData? parseData(Map<String, dynamic> json) =>
      _i2.GGetMessagesInProgressData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetMessagesInProgressData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetMessagesInProgressData,
      _i3.GGetMessagesInProgressVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetMessagesInProgressReq> get serializer =>
      _$gGetMessagesInProgressReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetMessagesInProgressReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMessagesInProgressReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetMessagesInProgressReq.serializer,
        json,
      );
}

abstract class GGetAllNotificationsReq
    implements
        Built<GGetAllNotificationsReq, GGetAllNotificationsReqBuilder>,
        _i1.OperationRequest<_i2.GGetAllNotificationsData,
            _i3.GGetAllNotificationsVars> {
  GGetAllNotificationsReq._();

  factory GGetAllNotificationsReq(
          [void Function(GGetAllNotificationsReqBuilder b) updates]) =
      _$GGetAllNotificationsReq;

  static void _initializeBuilder(GGetAllNotificationsReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetAllNotifications',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetAllNotificationsVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GGetAllNotificationsData? Function(
    _i2.GGetAllNotificationsData?,
    _i2.GGetAllNotificationsData?,
  )? get updateResult;
  @override
  _i2.GGetAllNotificationsData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GGetAllNotificationsData? parseData(Map<String, dynamic> json) =>
      _i2.GGetAllNotificationsData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetAllNotificationsData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetAllNotificationsData,
      _i3.GGetAllNotificationsVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetAllNotificationsReq> get serializer =>
      _$gGetAllNotificationsReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetAllNotificationsReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetAllNotificationsReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetAllNotificationsReq.serializer,
        json,
      );
}

abstract class GGetBelongedArtistsReq
    implements
        Built<GGetBelongedArtistsReq, GGetBelongedArtistsReqBuilder>,
        _i1.OperationRequest<_i2.GGetBelongedArtistsData,
            _i3.GGetBelongedArtistsVars> {
  GGetBelongedArtistsReq._();

  factory GGetBelongedArtistsReq(
          [void Function(GGetBelongedArtistsReqBuilder b) updates]) =
      _$GGetBelongedArtistsReq;

  static void _initializeBuilder(GGetBelongedArtistsReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetBelongedArtists',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetBelongedArtistsVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GGetBelongedArtistsData? Function(
    _i2.GGetBelongedArtistsData?,
    _i2.GGetBelongedArtistsData?,
  )? get updateResult;
  @override
  _i2.GGetBelongedArtistsData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GGetBelongedArtistsData? parseData(Map<String, dynamic> json) =>
      _i2.GGetBelongedArtistsData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetBelongedArtistsData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetBelongedArtistsData, _i3.GGetBelongedArtistsVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetBelongedArtistsReq> get serializer =>
      _$gGetBelongedArtistsReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetBelongedArtistsReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetBelongedArtistsReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetBelongedArtistsReq.serializer,
        json,
      );
}

abstract class GGetAllArtistsReq
    implements
        Built<GGetAllArtistsReq, GGetAllArtistsReqBuilder>,
        _i1.OperationRequest<_i2.GGetAllArtistsData, _i3.GGetAllArtistsVars> {
  GGetAllArtistsReq._();

  factory GGetAllArtistsReq(
          [void Function(GGetAllArtistsReqBuilder b) updates]) =
      _$GGetAllArtistsReq;

  static void _initializeBuilder(GGetAllArtistsReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetAllArtists',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetAllArtistsVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GGetAllArtistsData? Function(
    _i2.GGetAllArtistsData?,
    _i2.GGetAllArtistsData?,
  )? get updateResult;
  @override
  _i2.GGetAllArtistsData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GGetAllArtistsData? parseData(Map<String, dynamic> json) =>
      _i2.GGetAllArtistsData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetAllArtistsData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetAllArtistsData, _i3.GGetAllArtistsVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetAllArtistsReq> get serializer =>
      _$gGetAllArtistsReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetAllArtistsReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetAllArtistsReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetAllArtistsReq.serializer,
        json,
      );
}

abstract class GGetArtistByIdReq
    implements
        Built<GGetArtistByIdReq, GGetArtistByIdReqBuilder>,
        _i1.OperationRequest<_i2.GGetArtistByIdData, _i3.GGetArtistByIdVars> {
  GGetArtistByIdReq._();

  factory GGetArtistByIdReq(
          [void Function(GGetArtistByIdReqBuilder b) updates]) =
      _$GGetArtistByIdReq;

  static void _initializeBuilder(GGetArtistByIdReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetArtistById',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetArtistByIdVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GGetArtistByIdData? Function(
    _i2.GGetArtistByIdData?,
    _i2.GGetArtistByIdData?,
  )? get updateResult;
  @override
  _i2.GGetArtistByIdData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GGetArtistByIdData? parseData(Map<String, dynamic> json) =>
      _i2.GGetArtistByIdData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetArtistByIdData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetArtistByIdData, _i3.GGetArtistByIdVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetArtistByIdReq> get serializer =>
      _$gGetArtistByIdReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetArtistByIdReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetArtistByIdReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetArtistByIdReq.serializer,
        json,
      );
}

abstract class GGetPopularPrizesReq
    implements
        Built<GGetPopularPrizesReq, GGetPopularPrizesReqBuilder>,
        _i1.OperationRequest<_i2.GGetPopularPrizesData,
            _i3.GGetPopularPrizesVars> {
  GGetPopularPrizesReq._();

  factory GGetPopularPrizesReq(
          [void Function(GGetPopularPrizesReqBuilder b) updates]) =
      _$GGetPopularPrizesReq;

  static void _initializeBuilder(GGetPopularPrizesReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetPopularPrizes',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetPopularPrizesVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GGetPopularPrizesData? Function(
    _i2.GGetPopularPrizesData?,
    _i2.GGetPopularPrizesData?,
  )? get updateResult;
  @override
  _i2.GGetPopularPrizesData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GGetPopularPrizesData? parseData(Map<String, dynamic> json) =>
      _i2.GGetPopularPrizesData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetPopularPrizesData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetPopularPrizesData, _i3.GGetPopularPrizesVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetPopularPrizesReq> get serializer =>
      _$gGetPopularPrizesReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetPopularPrizesReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetPopularPrizesReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetPopularPrizesReq.serializer,
        json,
      );
}

abstract class GGetAllPrizesReq
    implements
        Built<GGetAllPrizesReq, GGetAllPrizesReqBuilder>,
        _i1.OperationRequest<_i2.GGetAllPrizesData, _i3.GGetAllPrizesVars> {
  GGetAllPrizesReq._();

  factory GGetAllPrizesReq([void Function(GGetAllPrizesReqBuilder b) updates]) =
      _$GGetAllPrizesReq;

  static void _initializeBuilder(GGetAllPrizesReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetAllPrizes',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetAllPrizesVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GGetAllPrizesData? Function(
    _i2.GGetAllPrizesData?,
    _i2.GGetAllPrizesData?,
  )? get updateResult;
  @override
  _i2.GGetAllPrizesData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GGetAllPrizesData? parseData(Map<String, dynamic> json) =>
      _i2.GGetAllPrizesData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetAllPrizesData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetAllPrizesData, _i3.GGetAllPrizesVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetAllPrizesReq> get serializer =>
      _$gGetAllPrizesReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetAllPrizesReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetAllPrizesReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetAllPrizesReq.serializer,
        json,
      );
}

abstract class GGetPrizeDetailReq
    implements
        Built<GGetPrizeDetailReq, GGetPrizeDetailReqBuilder>,
        _i1.OperationRequest<_i2.GGetPrizeDetailData, _i3.GGetPrizeDetailVars> {
  GGetPrizeDetailReq._();

  factory GGetPrizeDetailReq(
          [void Function(GGetPrizeDetailReqBuilder b) updates]) =
      _$GGetPrizeDetailReq;

  static void _initializeBuilder(GGetPrizeDetailReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetPrizeDetail',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetPrizeDetailVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GGetPrizeDetailData? Function(
    _i2.GGetPrizeDetailData?,
    _i2.GGetPrizeDetailData?,
  )? get updateResult;
  @override
  _i2.GGetPrizeDetailData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GGetPrizeDetailData? parseData(Map<String, dynamic> json) =>
      _i2.GGetPrizeDetailData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetPrizeDetailData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetPrizeDetailData, _i3.GGetPrizeDetailVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetPrizeDetailReq> get serializer =>
      _$gGetPrizeDetailReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetPrizeDetailReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetPrizeDetailReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetPrizeDetailReq.serializer,
        json,
      );
}

abstract class GGetFspHistoryReq
    implements
        Built<GGetFspHistoryReq, GGetFspHistoryReqBuilder>,
        _i1.OperationRequest<_i2.GGetFspHistoryData, _i3.GGetFspHistoryVars> {
  GGetFspHistoryReq._();

  factory GGetFspHistoryReq(
          [void Function(GGetFspHistoryReqBuilder b) updates]) =
      _$GGetFspHistoryReq;

  static void _initializeBuilder(GGetFspHistoryReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetFspHistory',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetFspHistoryVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GGetFspHistoryData? Function(
    _i2.GGetFspHistoryData?,
    _i2.GGetFspHistoryData?,
  )? get updateResult;
  @override
  _i2.GGetFspHistoryData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GGetFspHistoryData? parseData(Map<String, dynamic> json) =>
      _i2.GGetFspHistoryData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetFspHistoryData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetFspHistoryData, _i3.GGetFspHistoryVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetFspHistoryReq> get serializer =>
      _$gGetFspHistoryReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetFspHistoryReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetFspHistoryReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetFspHistoryReq.serializer,
        json,
      );
}

abstract class GGetFspHistoryByUserReq
    implements
        Built<GGetFspHistoryByUserReq, GGetFspHistoryByUserReqBuilder>,
        _i1.OperationRequest<_i2.GGetFspHistoryByUserData,
            _i3.GGetFspHistoryByUserVars> {
  GGetFspHistoryByUserReq._();

  factory GGetFspHistoryByUserReq(
          [void Function(GGetFspHistoryByUserReqBuilder b) updates]) =
      _$GGetFspHistoryByUserReq;

  static void _initializeBuilder(GGetFspHistoryByUserReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetFspHistoryByUser',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetFspHistoryByUserVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GGetFspHistoryByUserData? Function(
    _i2.GGetFspHistoryByUserData?,
    _i2.GGetFspHistoryByUserData?,
  )? get updateResult;
  @override
  _i2.GGetFspHistoryByUserData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GGetFspHistoryByUserData? parseData(Map<String, dynamic> json) =>
      _i2.GGetFspHistoryByUserData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetFspHistoryByUserData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetFspHistoryByUserData,
      _i3.GGetFspHistoryByUserVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetFspHistoryByUserReq> get serializer =>
      _$gGetFspHistoryByUserReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetFspHistoryByUserReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetFspHistoryByUserReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetFspHistoryByUserReq.serializer,
        json,
      );
}
