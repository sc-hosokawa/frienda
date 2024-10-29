// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:client/data/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:client/data/graphql/mutation/__generated__/mutation.ast.gql.dart'
    as _i5;
import 'package:client/data/graphql/mutation/__generated__/mutation.data.gql.dart'
    as _i2;
import 'package:client/data/graphql/mutation/__generated__/mutation.var.gql.dart'
    as _i3;
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
          [void Function(GAddNewConnectionReqBuilder b) updates]) =
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
        context: context ?? const _i4.Context(),
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
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GAddNewConnectionData? parseData(Map<String, dynamic> json) =>
      _i2.GAddNewConnectionData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GAddNewConnectionData data) =>
      data.toJson();

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

abstract class GUpdateOfferReq
    implements
        Built<GUpdateOfferReq, GUpdateOfferReqBuilder>,
        _i1.OperationRequest<_i2.GUpdateOfferData, _i3.GUpdateOfferVars> {
  GUpdateOfferReq._();

  factory GUpdateOfferReq([void Function(GUpdateOfferReqBuilder b) updates]) =
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
        context: context ?? const _i4.Context(),
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
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GUpdateOfferData? parseData(Map<String, dynamic> json) =>
      _i2.GUpdateOfferData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GUpdateOfferData data) => data.toJson();

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

abstract class GCreateNewUserDataReq
    implements
        Built<GCreateNewUserDataReq, GCreateNewUserDataReqBuilder>,
        _i1.OperationRequest<_i2.GCreateNewUserDataData,
            _i3.GCreateNewUserDataVars> {
  GCreateNewUserDataReq._();

  factory GCreateNewUserDataReq(
          [void Function(GCreateNewUserDataReqBuilder b) updates]) =
      _$GCreateNewUserDataReq;

  static void _initializeBuilder(GCreateNewUserDataReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'CreateNewUserData',
    )
    ..executeOnListen = true;

  @override
  _i3.GCreateNewUserDataVars get vars;
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
  _i2.GCreateNewUserDataData? Function(
    _i2.GCreateNewUserDataData?,
    _i2.GCreateNewUserDataData?,
  )? get updateResult;
  @override
  _i2.GCreateNewUserDataData? get optimisticResponse;
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
  _i2.GCreateNewUserDataData? parseData(Map<String, dynamic> json) =>
      _i2.GCreateNewUserDataData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GCreateNewUserDataData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GCreateNewUserDataData, _i3.GCreateNewUserDataVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GCreateNewUserDataReq> get serializer =>
      _$gCreateNewUserDataReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GCreateNewUserDataReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateNewUserDataReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GCreateNewUserDataReq.serializer,
        json,
      );
}

abstract class GUpdateUserDataReq
    implements
        Built<GUpdateUserDataReq, GUpdateUserDataReqBuilder>,
        _i1.OperationRequest<_i2.GUpdateUserDataData, _i3.GUpdateUserDataVars> {
  GUpdateUserDataReq._();

  factory GUpdateUserDataReq(
          [void Function(GUpdateUserDataReqBuilder b) updates]) =
      _$GUpdateUserDataReq;

  static void _initializeBuilder(GUpdateUserDataReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'UpdateUserData',
    )
    ..executeOnListen = true;

  @override
  _i3.GUpdateUserDataVars get vars;
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
  _i2.GUpdateUserDataData? Function(
    _i2.GUpdateUserDataData?,
    _i2.GUpdateUserDataData?,
  )? get updateResult;
  @override
  _i2.GUpdateUserDataData? get optimisticResponse;
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
  _i2.GUpdateUserDataData? parseData(Map<String, dynamic> json) =>
      _i2.GUpdateUserDataData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GUpdateUserDataData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GUpdateUserDataData, _i3.GUpdateUserDataVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GUpdateUserDataReq> get serializer =>
      _$gUpdateUserDataReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GUpdateUserDataReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateUserDataReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GUpdateUserDataReq.serializer,
        json,
      );
}

abstract class GUpdateBelongsToArtistStatusReq
    implements
        Built<GUpdateBelongsToArtistStatusReq,
            GUpdateBelongsToArtistStatusReqBuilder>,
        _i1.OperationRequest<_i2.GUpdateBelongsToArtistStatusData,
            _i3.GUpdateBelongsToArtistStatusVars> {
  GUpdateBelongsToArtistStatusReq._();

  factory GUpdateBelongsToArtistStatusReq(
          [void Function(GUpdateBelongsToArtistStatusReqBuilder b) updates]) =
      _$GUpdateBelongsToArtistStatusReq;

  static void _initializeBuilder(GUpdateBelongsToArtistStatusReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'UpdateBelongsToArtistStatus',
    )
    ..executeOnListen = true;

  @override
  _i3.GUpdateBelongsToArtistStatusVars get vars;
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
  _i2.GUpdateBelongsToArtistStatusData? Function(
    _i2.GUpdateBelongsToArtistStatusData?,
    _i2.GUpdateBelongsToArtistStatusData?,
  )? get updateResult;
  @override
  _i2.GUpdateBelongsToArtistStatusData? get optimisticResponse;
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
  _i2.GUpdateBelongsToArtistStatusData? parseData(Map<String, dynamic> json) =>
      _i2.GUpdateBelongsToArtistStatusData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GUpdateBelongsToArtistStatusData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GUpdateBelongsToArtistStatusData,
      _i3.GUpdateBelongsToArtistStatusVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GUpdateBelongsToArtistStatusReq> get serializer =>
      _$gUpdateBelongsToArtistStatusReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GUpdateBelongsToArtistStatusReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateBelongsToArtistStatusReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GUpdateBelongsToArtistStatusReq.serializer,
        json,
      );
}

abstract class GContactToAdminReq
    implements
        Built<GContactToAdminReq, GContactToAdminReqBuilder>,
        _i1.OperationRequest<_i2.GContactToAdminData, _i3.GContactToAdminVars> {
  GContactToAdminReq._();

  factory GContactToAdminReq(
          [void Function(GContactToAdminReqBuilder b) updates]) =
      _$GContactToAdminReq;

  static void _initializeBuilder(GContactToAdminReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'ContactToAdmin',
    )
    ..executeOnListen = true;

  @override
  _i3.GContactToAdminVars get vars;
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
  _i2.GContactToAdminData? Function(
    _i2.GContactToAdminData?,
    _i2.GContactToAdminData?,
  )? get updateResult;
  @override
  _i2.GContactToAdminData? get optimisticResponse;
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
  _i2.GContactToAdminData? parseData(Map<String, dynamic> json) =>
      _i2.GContactToAdminData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GContactToAdminData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GContactToAdminData, _i3.GContactToAdminVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GContactToAdminReq> get serializer =>
      _$gContactToAdminReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GContactToAdminReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GContactToAdminReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GContactToAdminReq.serializer,
        json,
      );
}

abstract class GCreateNewNotificationReq
    implements
        Built<GCreateNewNotificationReq, GCreateNewNotificationReqBuilder>,
        _i1.OperationRequest<_i2.GCreateNewNotificationData,
            _i3.GCreateNewNotificationVars> {
  GCreateNewNotificationReq._();

  factory GCreateNewNotificationReq(
          [void Function(GCreateNewNotificationReqBuilder b) updates]) =
      _$GCreateNewNotificationReq;

  static void _initializeBuilder(GCreateNewNotificationReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'CreateNewNotification',
    )
    ..executeOnListen = true;

  @override
  _i3.GCreateNewNotificationVars get vars;
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
  _i2.GCreateNewNotificationData? Function(
    _i2.GCreateNewNotificationData?,
    _i2.GCreateNewNotificationData?,
  )? get updateResult;
  @override
  _i2.GCreateNewNotificationData? get optimisticResponse;
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
  _i2.GCreateNewNotificationData? parseData(Map<String, dynamic> json) =>
      _i2.GCreateNewNotificationData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GCreateNewNotificationData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GCreateNewNotificationData,
      _i3.GCreateNewNotificationVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GCreateNewNotificationReq> get serializer =>
      _$gCreateNewNotificationReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GCreateNewNotificationReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateNewNotificationReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GCreateNewNotificationReq.serializer,
        json,
      );
}

abstract class GUpdateNotificationReq
    implements
        Built<GUpdateNotificationReq, GUpdateNotificationReqBuilder>,
        _i1.OperationRequest<_i2.GUpdateNotificationData,
            _i3.GUpdateNotificationVars> {
  GUpdateNotificationReq._();

  factory GUpdateNotificationReq(
          [void Function(GUpdateNotificationReqBuilder b) updates]) =
      _$GUpdateNotificationReq;

  static void _initializeBuilder(GUpdateNotificationReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'UpdateNotification',
    )
    ..executeOnListen = true;

  @override
  _i3.GUpdateNotificationVars get vars;
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
  _i2.GUpdateNotificationData? Function(
    _i2.GUpdateNotificationData?,
    _i2.GUpdateNotificationData?,
  )? get updateResult;
  @override
  _i2.GUpdateNotificationData? get optimisticResponse;
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
  _i2.GUpdateNotificationData? parseData(Map<String, dynamic> json) =>
      _i2.GUpdateNotificationData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GUpdateNotificationData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GUpdateNotificationData, _i3.GUpdateNotificationVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GUpdateNotificationReq> get serializer =>
      _$gUpdateNotificationReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GUpdateNotificationReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateNotificationReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GUpdateNotificationReq.serializer,
        json,
      );
}

abstract class GDeleteNotificationReq
    implements
        Built<GDeleteNotificationReq, GDeleteNotificationReqBuilder>,
        _i1.OperationRequest<_i2.GDeleteNotificationData,
            _i3.GDeleteNotificationVars> {
  GDeleteNotificationReq._();

  factory GDeleteNotificationReq(
          [void Function(GDeleteNotificationReqBuilder b) updates]) =
      _$GDeleteNotificationReq;

  static void _initializeBuilder(GDeleteNotificationReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'DeleteNotification',
    )
    ..executeOnListen = true;

  @override
  _i3.GDeleteNotificationVars get vars;
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
  _i2.GDeleteNotificationData? Function(
    _i2.GDeleteNotificationData?,
    _i2.GDeleteNotificationData?,
  )? get updateResult;
  @override
  _i2.GDeleteNotificationData? get optimisticResponse;
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
  _i2.GDeleteNotificationData? parseData(Map<String, dynamic> json) =>
      _i2.GDeleteNotificationData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GDeleteNotificationData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GDeleteNotificationData, _i3.GDeleteNotificationVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GDeleteNotificationReq> get serializer =>
      _$gDeleteNotificationReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GDeleteNotificationReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GDeleteNotificationReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GDeleteNotificationReq.serializer,
        json,
      );
}

abstract class GCreateFspTxReq
    implements
        Built<GCreateFspTxReq, GCreateFspTxReqBuilder>,
        _i1.OperationRequest<_i2.GCreateFspTxData, _i3.GCreateFspTxVars> {
  GCreateFspTxReq._();

  factory GCreateFspTxReq([void Function(GCreateFspTxReqBuilder b) updates]) =
      _$GCreateFspTxReq;

  static void _initializeBuilder(GCreateFspTxReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'CreateFspTx',
    )
    ..executeOnListen = true;

  @override
  _i3.GCreateFspTxVars get vars;
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
  _i2.GCreateFspTxData? Function(
    _i2.GCreateFspTxData?,
    _i2.GCreateFspTxData?,
  )? get updateResult;
  @override
  _i2.GCreateFspTxData? get optimisticResponse;
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
  _i2.GCreateFspTxData? parseData(Map<String, dynamic> json) =>
      _i2.GCreateFspTxData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GCreateFspTxData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GCreateFspTxData, _i3.GCreateFspTxVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GCreateFspTxReq> get serializer =>
      _$gCreateFspTxReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GCreateFspTxReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateFspTxReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GCreateFspTxReq.serializer,
        json,
      );
}

abstract class GCreateNewArtistReq
    implements
        Built<GCreateNewArtistReq, GCreateNewArtistReqBuilder>,
        _i1
        .OperationRequest<_i2.GCreateNewArtistData, _i3.GCreateNewArtistVars> {
  GCreateNewArtistReq._();

  factory GCreateNewArtistReq(
          [void Function(GCreateNewArtistReqBuilder b) updates]) =
      _$GCreateNewArtistReq;

  static void _initializeBuilder(GCreateNewArtistReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'CreateNewArtist',
    )
    ..executeOnListen = true;

  @override
  _i3.GCreateNewArtistVars get vars;
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
  _i2.GCreateNewArtistData? Function(
    _i2.GCreateNewArtistData?,
    _i2.GCreateNewArtistData?,
  )? get updateResult;
  @override
  _i2.GCreateNewArtistData? get optimisticResponse;
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
  _i2.GCreateNewArtistData? parseData(Map<String, dynamic> json) =>
      _i2.GCreateNewArtistData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GCreateNewArtistData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GCreateNewArtistData, _i3.GCreateNewArtistVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GCreateNewArtistReq> get serializer =>
      _$gCreateNewArtistReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GCreateNewArtistReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateNewArtistReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GCreateNewArtistReq.serializer,
        json,
      );
}
