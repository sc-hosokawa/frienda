// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:client/data/graphql/__generated__/serializers.gql.dart' as _i1;

part 'mutation.data.gql.g.dart';

abstract class GAddNewConnectionData
    implements Built<GAddNewConnectionData, GAddNewConnectionDataBuilder> {
  GAddNewConnectionData._();

  factory GAddNewConnectionData(
          [void Function(GAddNewConnectionDataBuilder b) updates]) =
      _$GAddNewConnectionData;

  static void _initializeBuilder(GAddNewConnectionDataBuilder b) =>
      b..G__typename = 'MutationRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GAddNewConnectionData_addNewConnection get addNewConnection;
  static Serializer<GAddNewConnectionData> get serializer =>
      _$gAddNewConnectionDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAddNewConnectionData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAddNewConnectionData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAddNewConnectionData.serializer,
        json,
      );
}

abstract class GAddNewConnectionData_addNewConnection
    implements
        Built<GAddNewConnectionData_addNewConnection,
            GAddNewConnectionData_addNewConnectionBuilder> {
  GAddNewConnectionData_addNewConnection._();

  factory GAddNewConnectionData_addNewConnection(
      [void Function(GAddNewConnectionData_addNewConnectionBuilder b)
          updates]) = _$GAddNewConnectionData_addNewConnection;

  static void _initializeBuilder(
          GAddNewConnectionData_addNewConnectionBuilder b) =>
      b..G__typename = 'AddNewConnectionResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get mapId;
  static Serializer<GAddNewConnectionData_addNewConnection> get serializer =>
      _$gAddNewConnectionDataAddNewConnectionSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAddNewConnectionData_addNewConnection.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAddNewConnectionData_addNewConnection? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAddNewConnectionData_addNewConnection.serializer,
        json,
      );
}

abstract class GCreateNewMessageRoomData
    implements
        Built<GCreateNewMessageRoomData, GCreateNewMessageRoomDataBuilder> {
  GCreateNewMessageRoomData._();

  factory GCreateNewMessageRoomData(
          [void Function(GCreateNewMessageRoomDataBuilder b) updates]) =
      _$GCreateNewMessageRoomData;

  static void _initializeBuilder(GCreateNewMessageRoomDataBuilder b) =>
      b..G__typename = 'MutationRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GCreateNewMessageRoomData_createNewMessageRoom get createNewMessageRoom;
  static Serializer<GCreateNewMessageRoomData> get serializer =>
      _$gCreateNewMessageRoomDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateNewMessageRoomData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateNewMessageRoomData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateNewMessageRoomData.serializer,
        json,
      );
}

abstract class GCreateNewMessageRoomData_createNewMessageRoom
    implements
        Built<GCreateNewMessageRoomData_createNewMessageRoom,
            GCreateNewMessageRoomData_createNewMessageRoomBuilder> {
  GCreateNewMessageRoomData_createNewMessageRoom._();

  factory GCreateNewMessageRoomData_createNewMessageRoom(
      [void Function(GCreateNewMessageRoomData_createNewMessageRoomBuilder b)
          updates]) = _$GCreateNewMessageRoomData_createNewMessageRoom;

  static void _initializeBuilder(
          GCreateNewMessageRoomData_createNewMessageRoomBuilder b) =>
      b..G__typename = 'CreateNewMessageRoomResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  static Serializer<GCreateNewMessageRoomData_createNewMessageRoom>
      get serializer =>
          _$gCreateNewMessageRoomDataCreateNewMessageRoomSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateNewMessageRoomData_createNewMessageRoom.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateNewMessageRoomData_createNewMessageRoom? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateNewMessageRoomData_createNewMessageRoom.serializer,
        json,
      );
}

abstract class GSendMessageData
    implements Built<GSendMessageData, GSendMessageDataBuilder> {
  GSendMessageData._();

  factory GSendMessageData([void Function(GSendMessageDataBuilder b) updates]) =
      _$GSendMessageData;

  static void _initializeBuilder(GSendMessageDataBuilder b) =>
      b..G__typename = 'MutationRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GSendMessageData_sendMessage get sendMessage;
  static Serializer<GSendMessageData> get serializer =>
      _$gSendMessageDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendMessageData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendMessageData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSendMessageData.serializer,
        json,
      );
}

abstract class GSendMessageData_sendMessage
    implements
        Built<GSendMessageData_sendMessage,
            GSendMessageData_sendMessageBuilder> {
  GSendMessageData_sendMessage._();

  factory GSendMessageData_sendMessage(
          [void Function(GSendMessageData_sendMessageBuilder b) updates]) =
      _$GSendMessageData_sendMessage;

  static void _initializeBuilder(GSendMessageData_sendMessageBuilder b) =>
      b..G__typename = 'SendMessageResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  static Serializer<GSendMessageData_sendMessage> get serializer =>
      _$gSendMessageDataSendMessageSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendMessageData_sendMessage.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendMessageData_sendMessage? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSendMessageData_sendMessage.serializer,
        json,
      );
}

abstract class GCreateNewOfferData
    implements Built<GCreateNewOfferData, GCreateNewOfferDataBuilder> {
  GCreateNewOfferData._();

  factory GCreateNewOfferData(
          [void Function(GCreateNewOfferDataBuilder b) updates]) =
      _$GCreateNewOfferData;

  static void _initializeBuilder(GCreateNewOfferDataBuilder b) =>
      b..G__typename = 'MutationRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GCreateNewOfferData_createNewOffer get createNewOffer;
  static Serializer<GCreateNewOfferData> get serializer =>
      _$gCreateNewOfferDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateNewOfferData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateNewOfferData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateNewOfferData.serializer,
        json,
      );
}

abstract class GCreateNewOfferData_createNewOffer
    implements
        Built<GCreateNewOfferData_createNewOffer,
            GCreateNewOfferData_createNewOfferBuilder> {
  GCreateNewOfferData_createNewOffer._();

  factory GCreateNewOfferData_createNewOffer(
      [void Function(GCreateNewOfferData_createNewOfferBuilder b)
          updates]) = _$GCreateNewOfferData_createNewOffer;

  static void _initializeBuilder(GCreateNewOfferData_createNewOfferBuilder b) =>
      b..G__typename = 'CreateNewOfferResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  static Serializer<GCreateNewOfferData_createNewOffer> get serializer =>
      _$gCreateNewOfferDataCreateNewOfferSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateNewOfferData_createNewOffer.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateNewOfferData_createNewOffer? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateNewOfferData_createNewOffer.serializer,
        json,
      );
}

abstract class GUpdateOfferData
    implements Built<GUpdateOfferData, GUpdateOfferDataBuilder> {
  GUpdateOfferData._();

  factory GUpdateOfferData([void Function(GUpdateOfferDataBuilder b) updates]) =
      _$GUpdateOfferData;

  static void _initializeBuilder(GUpdateOfferDataBuilder b) =>
      b..G__typename = 'MutationRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GUpdateOfferData_updateOffer get updateOffer;
  static Serializer<GUpdateOfferData> get serializer =>
      _$gUpdateOfferDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateOfferData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateOfferData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateOfferData.serializer,
        json,
      );
}

abstract class GUpdateOfferData_updateOffer
    implements
        Built<GUpdateOfferData_updateOffer,
            GUpdateOfferData_updateOfferBuilder> {
  GUpdateOfferData_updateOffer._();

  factory GUpdateOfferData_updateOffer(
          [void Function(GUpdateOfferData_updateOfferBuilder b) updates]) =
      _$GUpdateOfferData_updateOffer;

  static void _initializeBuilder(GUpdateOfferData_updateOfferBuilder b) =>
      b..G__typename = 'UpdateOfferResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  static Serializer<GUpdateOfferData_updateOffer> get serializer =>
      _$gUpdateOfferDataUpdateOfferSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateOfferData_updateOffer.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateOfferData_updateOffer? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateOfferData_updateOffer.serializer,
        json,
      );
}

abstract class GDeleteOfferData
    implements Built<GDeleteOfferData, GDeleteOfferDataBuilder> {
  GDeleteOfferData._();

  factory GDeleteOfferData([void Function(GDeleteOfferDataBuilder b) updates]) =
      _$GDeleteOfferData;

  static void _initializeBuilder(GDeleteOfferDataBuilder b) =>
      b..G__typename = 'MutationRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GDeleteOfferData_deleteOffer get deleteOffer;
  static Serializer<GDeleteOfferData> get serializer =>
      _$gDeleteOfferDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GDeleteOfferData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GDeleteOfferData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GDeleteOfferData.serializer,
        json,
      );
}

abstract class GDeleteOfferData_deleteOffer
    implements
        Built<GDeleteOfferData_deleteOffer,
            GDeleteOfferData_deleteOfferBuilder> {
  GDeleteOfferData_deleteOffer._();

  factory GDeleteOfferData_deleteOffer(
          [void Function(GDeleteOfferData_deleteOfferBuilder b) updates]) =
      _$GDeleteOfferData_deleteOffer;

  static void _initializeBuilder(GDeleteOfferData_deleteOfferBuilder b) =>
      b..G__typename = 'DeleteOfferResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  static Serializer<GDeleteOfferData_deleteOffer> get serializer =>
      _$gDeleteOfferDataDeleteOfferSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GDeleteOfferData_deleteOffer.serializer,
        this,
      ) as Map<String, dynamic>);

  static GDeleteOfferData_deleteOffer? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GDeleteOfferData_deleteOffer.serializer,
        json,
      );
}
