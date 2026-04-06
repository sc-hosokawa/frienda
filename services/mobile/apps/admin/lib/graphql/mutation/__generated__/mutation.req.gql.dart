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

abstract class GAddNewConnectionReq
    implements
        Built<GAddNewConnectionReq, GAddNewConnectionReqBuilder>,
        _i1.OperationRequest<_i2.GAddNewConnectionData,
            _i3.GAddNewConnectionVars> {
  GAddNewConnectionReq._();

  factory GAddNewConnectionReq(
          [Function(GAddNewConnectionReqBuilder b) updates]) =
      _$GAddNewConnectionReq;

  static void _initializeBuilder(GAddNewConnectionReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'AddNewConnection',
    )
    ..executeOnListen = true;

  @override
  _i3.GAddNewConnectionVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GAddNewConnectionData? Function(
    _i2.GAddNewConnectionData?,
    _i2.GAddNewConnectionData?,
  )? get updateResult;
  @override
  _i2.GAddNewConnectionData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  _i2.GAddNewConnectionData? parseData(Map<String, dynamic> json) =>
      _i2.GAddNewConnectionData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(dynamic data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GAddNewConnectionData, _i3.GAddNewConnectionVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GAddNewConnectionReq> get serializer =>
      _$gAddNewConnectionReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GAddNewConnectionReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAddNewConnectionReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GAddNewConnectionReq.serializer,
        json,
      );
}

abstract class GCreateNewMessageRoomReq
    implements
        Built<GCreateNewMessageRoomReq, GCreateNewMessageRoomReqBuilder>,
        _i1.OperationRequest<_i2.GCreateNewMessageRoomData,
            _i3.GCreateNewMessageRoomVars> {
  GCreateNewMessageRoomReq._();

  factory GCreateNewMessageRoomReq(
          [Function(GCreateNewMessageRoomReqBuilder b) updates]) =
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
  _i2.GCreateNewMessageRoomData? parseData(Map<String, dynamic> json) =>
      _i2.GCreateNewMessageRoomData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(dynamic data) => data.toJson();

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

  factory GSendMessageReq([Function(GSendMessageReqBuilder b) updates]) =
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
  _i2.GSendMessageData? parseData(Map<String, dynamic> json) =>
      _i2.GSendMessageData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(dynamic data) => data.toJson();

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

  factory GCreateNewOfferReq([Function(GCreateNewOfferReqBuilder b) updates]) =
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
  _i2.GCreateNewOfferData? parseData(Map<String, dynamic> json) =>
      _i2.GCreateNewOfferData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(dynamic data) => data.toJson();

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

abstract class GUpdateOfferReq
    implements
        Built<GUpdateOfferReq, GUpdateOfferReqBuilder>,
        _i1.OperationRequest<_i2.GUpdateOfferData, _i3.GUpdateOfferVars> {
  GUpdateOfferReq._();

  factory GUpdateOfferReq([Function(GUpdateOfferReqBuilder b) updates]) =
      _$GUpdateOfferReq;

  static void _initializeBuilder(GUpdateOfferReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'UpdateOffer',
    )
    ..executeOnListen = true;

  @override
  _i3.GUpdateOfferVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GUpdateOfferData? Function(
    _i2.GUpdateOfferData?,
    _i2.GUpdateOfferData?,
  )? get updateResult;
  @override
  _i2.GUpdateOfferData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  _i2.GUpdateOfferData? parseData(Map<String, dynamic> json) =>
      _i2.GUpdateOfferData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(dynamic data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GUpdateOfferData, _i3.GUpdateOfferVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GUpdateOfferReq> get serializer =>
      _$gUpdateOfferReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GUpdateOfferReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateOfferReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GUpdateOfferReq.serializer,
        json,
      );
}

abstract class GDeleteOfferReq
    implements
        Built<GDeleteOfferReq, GDeleteOfferReqBuilder>,
        _i1.OperationRequest<_i2.GDeleteOfferData, _i3.GDeleteOfferVars> {
  GDeleteOfferReq._();

  factory GDeleteOfferReq([Function(GDeleteOfferReqBuilder b) updates]) =
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
  _i2.GDeleteOfferData? parseData(Map<String, dynamic> json) =>
      _i2.GDeleteOfferData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(dynamic data) => data.toJson();

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
