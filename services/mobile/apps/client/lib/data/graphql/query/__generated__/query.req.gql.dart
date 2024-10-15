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
