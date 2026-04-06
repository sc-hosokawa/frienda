// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:admin/graphql/__generated__/serializers.gql.dart' as _i1;
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mutation.data.gql.g.dart';

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
  String get message;
  String get sentAt;
  BuiltList<String>? get attachedFile;
  BuiltList<String>? get attachedImg;
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
  int get id;
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

abstract class GUpdateOfferInfoData
    implements Built<GUpdateOfferInfoData, GUpdateOfferInfoDataBuilder> {
  GUpdateOfferInfoData._();

  factory GUpdateOfferInfoData(
          [void Function(GUpdateOfferInfoDataBuilder b) updates]) =
      _$GUpdateOfferInfoData;

  static void _initializeBuilder(GUpdateOfferInfoDataBuilder b) =>
      b..G__typename = 'MutationRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GUpdateOfferInfoData_updateOfferInfo get updateOfferInfo;
  static Serializer<GUpdateOfferInfoData> get serializer =>
      _$gUpdateOfferInfoDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateOfferInfoData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateOfferInfoData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateOfferInfoData.serializer,
        json,
      );
}

abstract class GUpdateOfferInfoData_updateOfferInfo
    implements
        Built<GUpdateOfferInfoData_updateOfferInfo,
            GUpdateOfferInfoData_updateOfferInfoBuilder> {
  GUpdateOfferInfoData_updateOfferInfo._();

  factory GUpdateOfferInfoData_updateOfferInfo(
      [void Function(GUpdateOfferInfoData_updateOfferInfoBuilder b)
          updates]) = _$GUpdateOfferInfoData_updateOfferInfo;

  static void _initializeBuilder(
          GUpdateOfferInfoData_updateOfferInfoBuilder b) =>
      b..G__typename = 'UpdateOfferResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  static Serializer<GUpdateOfferInfoData_updateOfferInfo> get serializer =>
      _$gUpdateOfferInfoDataUpdateOfferInfoSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateOfferInfoData_updateOfferInfo.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateOfferInfoData_updateOfferInfo? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateOfferInfoData_updateOfferInfo.serializer,
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
  int get id;
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
