// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:admin/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:admin/graphql/mutation/__generated__/mutation.ast.gql.dart'
    as _i5;
import 'package:admin/graphql/mutation/__generated__/mutation.data.gql.dart'
    as _i2;
import 'package:admin/graphql/mutation/__generated__/mutation.var.gql.dart'
    as _i3;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'mutation.req.gql.g.dart';

abstract class GCreateNewMessageRoomReq
    implements
        Built<GCreateNewMessageRoomReq, GCreateNewMessageRoomReqBuilder>,
        _i1.OperationRequest<_i2.GCreateNewMessageRoomData,
            _i3.GCreateNewMessageRoomVars> {
  GCreateNewMessageRoomReq._();

  factory GCreateNewMessageRoomReq(
          [void Function(GCreateNewMessageRoomReqBuilder b) updates]) =
      _$GCreateNewMessageRoomReq;

  static void _initializeBuilder(GCreateNewMessageRoomReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'CreateNewMessageRoom',
    )
    ..executeOnListen = true;

  @override
  _i3.GCreateNewMessageRoomVars get vars;
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
  _i2.GCreateNewMessageRoomData? Function(
    _i2.GCreateNewMessageRoomData?,
    _i2.GCreateNewMessageRoomData?,
  )? get updateResult;
  @override
  _i2.GCreateNewMessageRoomData? get optimisticResponse;
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
  _i2.GCreateNewMessageRoomData? parseData(Map<String, dynamic> json) =>
      _i2.GCreateNewMessageRoomData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GCreateNewMessageRoomData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GCreateNewMessageRoomData,
      _i3.GCreateNewMessageRoomVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GCreateNewMessageRoomReq> get serializer =>
      _$gCreateNewMessageRoomReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GCreateNewMessageRoomReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateNewMessageRoomReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GCreateNewMessageRoomReq.serializer,
        json,
      );
}

abstract class GSendMessageReq
    implements
        Built<GSendMessageReq, GSendMessageReqBuilder>,
        _i1.OperationRequest<_i2.GSendMessageData, _i3.GSendMessageVars> {
  GSendMessageReq._();

  factory GSendMessageReq([void Function(GSendMessageReqBuilder b) updates]) =
      _$GSendMessageReq;

  static void _initializeBuilder(GSendMessageReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'SendMessage',
    )
    ..executeOnListen = true;

  @override
  _i3.GSendMessageVars get vars;
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
  _i2.GSendMessageData? Function(
    _i2.GSendMessageData?,
    _i2.GSendMessageData?,
  )? get updateResult;
  @override
  _i2.GSendMessageData? get optimisticResponse;
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
  _i2.GSendMessageData? parseData(Map<String, dynamic> json) =>
      _i2.GSendMessageData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GSendMessageData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GSendMessageData, _i3.GSendMessageVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GSendMessageReq> get serializer =>
      _$gSendMessageReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GSendMessageReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendMessageReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GSendMessageReq.serializer,
        json,
      );
}

abstract class GCreateNewOfferReq
    implements
        Built<GCreateNewOfferReq, GCreateNewOfferReqBuilder>,
        _i1.OperationRequest<_i2.GCreateNewOfferData, _i3.GCreateNewOfferVars> {
  GCreateNewOfferReq._();

  factory GCreateNewOfferReq(
          [void Function(GCreateNewOfferReqBuilder b) updates]) =
      _$GCreateNewOfferReq;

  static void _initializeBuilder(GCreateNewOfferReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'CreateNewOffer',
    )
    ..executeOnListen = true;

  @override
  _i3.GCreateNewOfferVars get vars;
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
  _i2.GCreateNewOfferData? Function(
    _i2.GCreateNewOfferData?,
    _i2.GCreateNewOfferData?,
  )? get updateResult;
  @override
  _i2.GCreateNewOfferData? get optimisticResponse;
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
  _i2.GCreateNewOfferData? parseData(Map<String, dynamic> json) =>
      _i2.GCreateNewOfferData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GCreateNewOfferData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GCreateNewOfferData, _i3.GCreateNewOfferVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GCreateNewOfferReq> get serializer =>
      _$gCreateNewOfferReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GCreateNewOfferReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateNewOfferReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GCreateNewOfferReq.serializer,
        json,
      );
}

abstract class GUpdateOfferInfoReq
    implements
        Built<GUpdateOfferInfoReq, GUpdateOfferInfoReqBuilder>,
        _i1
        .OperationRequest<_i2.GUpdateOfferInfoData, _i3.GUpdateOfferInfoVars> {
  GUpdateOfferInfoReq._();

  factory GUpdateOfferInfoReq(
          [void Function(GUpdateOfferInfoReqBuilder b) updates]) =
      _$GUpdateOfferInfoReq;

  static void _initializeBuilder(GUpdateOfferInfoReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'UpdateOfferInfo',
    )
    ..executeOnListen = true;

  @override
  _i3.GUpdateOfferInfoVars get vars;
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
  _i2.GUpdateOfferInfoData? Function(
    _i2.GUpdateOfferInfoData?,
    _i2.GUpdateOfferInfoData?,
  )? get updateResult;
  @override
  _i2.GUpdateOfferInfoData? get optimisticResponse;
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
  _i2.GUpdateOfferInfoData? parseData(Map<String, dynamic> json) =>
      _i2.GUpdateOfferInfoData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GUpdateOfferInfoData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GUpdateOfferInfoData, _i3.GUpdateOfferInfoVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GUpdateOfferInfoReq> get serializer =>
      _$gUpdateOfferInfoReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GUpdateOfferInfoReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateOfferInfoReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GUpdateOfferInfoReq.serializer,
        json,
      );
}

abstract class GDeleteOfferReq
    implements
        Built<GDeleteOfferReq, GDeleteOfferReqBuilder>,
        _i1.OperationRequest<_i2.GDeleteOfferData, _i3.GDeleteOfferVars> {
  GDeleteOfferReq._();

  factory GDeleteOfferReq([void Function(GDeleteOfferReqBuilder b) updates]) =
      _$GDeleteOfferReq;

  static void _initializeBuilder(GDeleteOfferReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'DeleteOffer',
    )
    ..executeOnListen = true;

  @override
  _i3.GDeleteOfferVars get vars;
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
  _i2.GDeleteOfferData? Function(
    _i2.GDeleteOfferData?,
    _i2.GDeleteOfferData?,
  )? get updateResult;
  @override
  _i2.GDeleteOfferData? get optimisticResponse;
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
  _i2.GDeleteOfferData? parseData(Map<String, dynamic> json) =>
      _i2.GDeleteOfferData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GDeleteOfferData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GDeleteOfferData, _i3.GDeleteOfferVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GDeleteOfferReq> get serializer =>
      _$gDeleteOfferReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GDeleteOfferReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GDeleteOfferReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GDeleteOfferReq.serializer,
        json,
      );
}
