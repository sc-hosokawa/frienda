// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
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
  int get id;
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

abstract class GCreateNewUserDataData
    implements Built<GCreateNewUserDataData, GCreateNewUserDataDataBuilder> {
  GCreateNewUserDataData._();

  factory GCreateNewUserDataData(
          [void Function(GCreateNewUserDataDataBuilder b) updates]) =
      _$GCreateNewUserDataData;

  static void _initializeBuilder(GCreateNewUserDataDataBuilder b) =>
      b..G__typename = 'MutationRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GCreateNewUserDataData_createNewUserData get createNewUserData;
  static Serializer<GCreateNewUserDataData> get serializer =>
      _$gCreateNewUserDataDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateNewUserDataData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateNewUserDataData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateNewUserDataData.serializer,
        json,
      );
}

abstract class GCreateNewUserDataData_createNewUserData
    implements
        Built<GCreateNewUserDataData_createNewUserData,
            GCreateNewUserDataData_createNewUserDataBuilder> {
  GCreateNewUserDataData_createNewUserData._();

  factory GCreateNewUserDataData_createNewUserData(
      [void Function(GCreateNewUserDataData_createNewUserDataBuilder b)
          updates]) = _$GCreateNewUserDataData_createNewUserData;

  static void _initializeBuilder(
          GCreateNewUserDataData_createNewUserDataBuilder b) =>
      b..G__typename = 'CreateNewUserDataResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get userId;
  String get name;
  String? get imageUrl;
  static Serializer<GCreateNewUserDataData_createNewUserData> get serializer =>
      _$gCreateNewUserDataDataCreateNewUserDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateNewUserDataData_createNewUserData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateNewUserDataData_createNewUserData? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateNewUserDataData_createNewUserData.serializer,
        json,
      );
}

abstract class GUpdateUserDataData
    implements Built<GUpdateUserDataData, GUpdateUserDataDataBuilder> {
  GUpdateUserDataData._();

  factory GUpdateUserDataData(
          [void Function(GUpdateUserDataDataBuilder b) updates]) =
      _$GUpdateUserDataData;

  static void _initializeBuilder(GUpdateUserDataDataBuilder b) =>
      b..G__typename = 'MutationRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GUpdateUserDataData_updateUserData get updateUserData;
  static Serializer<GUpdateUserDataData> get serializer =>
      _$gUpdateUserDataDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateUserDataData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateUserDataData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateUserDataData.serializer,
        json,
      );
}

abstract class GUpdateUserDataData_updateUserData
    implements
        Built<GUpdateUserDataData_updateUserData,
            GUpdateUserDataData_updateUserDataBuilder> {
  GUpdateUserDataData_updateUserData._();

  factory GUpdateUserDataData_updateUserData(
      [void Function(GUpdateUserDataData_updateUserDataBuilder b)
          updates]) = _$GUpdateUserDataData_updateUserData;

  static void _initializeBuilder(GUpdateUserDataData_updateUserDataBuilder b) =>
      b..G__typename = 'UpdateUserDataResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GUpdateUserDataData_updateUserData_userInfo get userInfo;
  static Serializer<GUpdateUserDataData_updateUserData> get serializer =>
      _$gUpdateUserDataDataUpdateUserDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateUserDataData_updateUserData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateUserDataData_updateUserData? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateUserDataData_updateUserData.serializer,
        json,
      );
}

abstract class GUpdateUserDataData_updateUserData_userInfo
    implements
        Built<GUpdateUserDataData_updateUserData_userInfo,
            GUpdateUserDataData_updateUserData_userInfoBuilder> {
  GUpdateUserDataData_updateUserData_userInfo._();

  factory GUpdateUserDataData_updateUserData_userInfo(
      [void Function(GUpdateUserDataData_updateUserData_userInfoBuilder b)
          updates]) = _$GUpdateUserDataData_updateUserData_userInfo;

  static void _initializeBuilder(
          GUpdateUserDataData_updateUserData_userInfoBuilder b) =>
      b..G__typename = 'UserDetailData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get email;
  String get name;
  String? get imageUrl;
  int get fspBalance;
  int get fspBalanceTemp;
  int get credentialBalance;
  BuiltList<String> get roles;
  String get primaryRole;
  BuiltList<GUpdateUserDataData_updateUserData_userInfo_belongsToArtists>
      get belongsToArtists;
  GUpdateUserDataData_updateUserData_userInfo_primaryArtist? get primaryArtist;
  static Serializer<GUpdateUserDataData_updateUserData_userInfo>
      get serializer => _$gUpdateUserDataDataUpdateUserDataUserInfoSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateUserDataData_updateUserData_userInfo.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateUserDataData_updateUserData_userInfo? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateUserDataData_updateUserData_userInfo.serializer,
        json,
      );
}

abstract class GUpdateUserDataData_updateUserData_userInfo_belongsToArtists
    implements
        Built<GUpdateUserDataData_updateUserData_userInfo_belongsToArtists,
            GUpdateUserDataData_updateUserData_userInfo_belongsToArtistsBuilder> {
  GUpdateUserDataData_updateUserData_userInfo_belongsToArtists._();

  factory GUpdateUserDataData_updateUserData_userInfo_belongsToArtists(
          [void Function(
                  GUpdateUserDataData_updateUserData_userInfo_belongsToArtistsBuilder
                      b)
              updates]) =
      _$GUpdateUserDataData_updateUserData_userInfo_belongsToArtists;

  static void _initializeBuilder(
          GUpdateUserDataData_updateUserData_userInfo_belongsToArtistsBuilder
              b) =>
      b..G__typename = 'ArtistByUserData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get name;
  String? get imageUrl;
  bool get isAccepted;
  static Serializer<
          GUpdateUserDataData_updateUserData_userInfo_belongsToArtists>
      get serializer =>
          _$gUpdateUserDataDataUpdateUserDataUserInfoBelongsToArtistsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateUserDataData_updateUserData_userInfo_belongsToArtists.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateUserDataData_updateUserData_userInfo_belongsToArtists? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateUserDataData_updateUserData_userInfo_belongsToArtists.serializer,
        json,
      );
}

abstract class GUpdateUserDataData_updateUserData_userInfo_primaryArtist
    implements
        Built<GUpdateUserDataData_updateUserData_userInfo_primaryArtist,
            GUpdateUserDataData_updateUserData_userInfo_primaryArtistBuilder> {
  GUpdateUserDataData_updateUserData_userInfo_primaryArtist._();

  factory GUpdateUserDataData_updateUserData_userInfo_primaryArtist(
      [void Function(
              GUpdateUserDataData_updateUserData_userInfo_primaryArtistBuilder
                  b)
          updates]) = _$GUpdateUserDataData_updateUserData_userInfo_primaryArtist;

  static void _initializeBuilder(
          GUpdateUserDataData_updateUserData_userInfo_primaryArtistBuilder b) =>
      b..G__typename = 'ArtistByUserData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get name;
  String? get imageUrl;
  bool get isAccepted;
  static Serializer<GUpdateUserDataData_updateUserData_userInfo_primaryArtist>
      get serializer =>
          _$gUpdateUserDataDataUpdateUserDataUserInfoPrimaryArtistSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateUserDataData_updateUserData_userInfo_primaryArtist.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateUserDataData_updateUserData_userInfo_primaryArtist? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateUserDataData_updateUserData_userInfo_primaryArtist.serializer,
        json,
      );
}

abstract class GUpdateBelongsToArtistStatusData
    implements
        Built<GUpdateBelongsToArtistStatusData,
            GUpdateBelongsToArtistStatusDataBuilder> {
  GUpdateBelongsToArtistStatusData._();

  factory GUpdateBelongsToArtistStatusData(
          [void Function(GUpdateBelongsToArtistStatusDataBuilder b) updates]) =
      _$GUpdateBelongsToArtistStatusData;

  static void _initializeBuilder(GUpdateBelongsToArtistStatusDataBuilder b) =>
      b..G__typename = 'MutationRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus
      get updateBelongsToArtistStatus;
  static Serializer<GUpdateBelongsToArtistStatusData> get serializer =>
      _$gUpdateBelongsToArtistStatusDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateBelongsToArtistStatusData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateBelongsToArtistStatusData? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateBelongsToArtistStatusData.serializer,
        json,
      );
}

abstract class GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus
    implements
        Built<GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus,
            GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatusBuilder> {
  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus._();

  factory GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus(
          [void Function(
                  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatusBuilder
                      b)
              updates]) =
      _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus;

  static void _initializeBuilder(
          GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatusBuilder
              b) =>
      b..G__typename = 'UpdateBelongsToArtistStatusResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList
      get artistList;
  static Serializer<
          GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus>
      get serializer =>
          _$gUpdateBelongsToArtistStatusDataUpdateBelongsToArtistStatusSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus.serializer,
        json,
      );
}

abstract class GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList
    implements
        Built<
            GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList,
            GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistListBuilder> {
  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList._();

  factory GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList(
          [void Function(
                  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistListBuilder
                      b)
              updates]) =
      _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList;

  static void _initializeBuilder(
          GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistListBuilder
              b) =>
      b..G__typename = 'ArtistByUserDataList';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<
          GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList>
      get artistList;
  static Serializer<
          GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList>
      get serializer =>
          _$gUpdateBelongsToArtistStatusDataUpdateBelongsToArtistStatusArtistListSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList
                .serializer,
            json,
          );
}

abstract class GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList
    implements
        Built<
            GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList,
            GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistListBuilder> {
  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList._();

  factory GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList(
          [void Function(
                  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistListBuilder
                      b)
              updates]) =
      _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList;

  static void _initializeBuilder(
          GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistListBuilder
              b) =>
      b..G__typename = 'ArtistByUserData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get name;
  String? get imageUrl;
  bool get isAccepted;
  static Serializer<
          GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList>
      get serializer =>
          _$gUpdateBelongsToArtistStatusDataUpdateBelongsToArtistStatusArtistListArtistListSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList
                .serializer,
            json,
          );
}

abstract class GContactToAdminData
    implements Built<GContactToAdminData, GContactToAdminDataBuilder> {
  GContactToAdminData._();

  factory GContactToAdminData(
          [void Function(GContactToAdminDataBuilder b) updates]) =
      _$GContactToAdminData;

  static void _initializeBuilder(GContactToAdminDataBuilder b) =>
      b..G__typename = 'MutationRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GContactToAdminData_contactToAdmin get contactToAdmin;
  static Serializer<GContactToAdminData> get serializer =>
      _$gContactToAdminDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GContactToAdminData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GContactToAdminData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GContactToAdminData.serializer,
        json,
      );
}

abstract class GContactToAdminData_contactToAdmin
    implements
        Built<GContactToAdminData_contactToAdmin,
            GContactToAdminData_contactToAdminBuilder> {
  GContactToAdminData_contactToAdmin._();

  factory GContactToAdminData_contactToAdmin(
      [void Function(GContactToAdminData_contactToAdminBuilder b)
          updates]) = _$GContactToAdminData_contactToAdmin;

  static void _initializeBuilder(GContactToAdminData_contactToAdminBuilder b) =>
      b..G__typename = 'ContactToAdminResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  static Serializer<GContactToAdminData_contactToAdmin> get serializer =>
      _$gContactToAdminDataContactToAdminSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GContactToAdminData_contactToAdmin.serializer,
        this,
      ) as Map<String, dynamic>);

  static GContactToAdminData_contactToAdmin? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GContactToAdminData_contactToAdmin.serializer,
        json,
      );
}

abstract class GCreateNewNotificationData
    implements
        Built<GCreateNewNotificationData, GCreateNewNotificationDataBuilder> {
  GCreateNewNotificationData._();

  factory GCreateNewNotificationData(
          [void Function(GCreateNewNotificationDataBuilder b) updates]) =
      _$GCreateNewNotificationData;

  static void _initializeBuilder(GCreateNewNotificationDataBuilder b) =>
      b..G__typename = 'MutationRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GCreateNewNotificationData_createNewNotification get createNewNotification;
  static Serializer<GCreateNewNotificationData> get serializer =>
      _$gCreateNewNotificationDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateNewNotificationData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateNewNotificationData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateNewNotificationData.serializer,
        json,
      );
}

abstract class GCreateNewNotificationData_createNewNotification
    implements
        Built<GCreateNewNotificationData_createNewNotification,
            GCreateNewNotificationData_createNewNotificationBuilder> {
  GCreateNewNotificationData_createNewNotification._();

  factory GCreateNewNotificationData_createNewNotification(
      [void Function(GCreateNewNotificationData_createNewNotificationBuilder b)
          updates]) = _$GCreateNewNotificationData_createNewNotification;

  static void _initializeBuilder(
          GCreateNewNotificationData_createNewNotificationBuilder b) =>
      b..G__typename = 'CreateNewNotificationResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  static Serializer<GCreateNewNotificationData_createNewNotification>
      get serializer =>
          _$gCreateNewNotificationDataCreateNewNotificationSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateNewNotificationData_createNewNotification.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateNewNotificationData_createNewNotification? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateNewNotificationData_createNewNotification.serializer,
        json,
      );
}

abstract class GUpdateNotificationData
    implements Built<GUpdateNotificationData, GUpdateNotificationDataBuilder> {
  GUpdateNotificationData._();

  factory GUpdateNotificationData(
          [void Function(GUpdateNotificationDataBuilder b) updates]) =
      _$GUpdateNotificationData;

  static void _initializeBuilder(GUpdateNotificationDataBuilder b) =>
      b..G__typename = 'MutationRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GUpdateNotificationData_updateNotification get updateNotification;
  static Serializer<GUpdateNotificationData> get serializer =>
      _$gUpdateNotificationDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateNotificationData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateNotificationData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateNotificationData.serializer,
        json,
      );
}

abstract class GUpdateNotificationData_updateNotification
    implements
        Built<GUpdateNotificationData_updateNotification,
            GUpdateNotificationData_updateNotificationBuilder> {
  GUpdateNotificationData_updateNotification._();

  factory GUpdateNotificationData_updateNotification(
      [void Function(GUpdateNotificationData_updateNotificationBuilder b)
          updates]) = _$GUpdateNotificationData_updateNotification;

  static void _initializeBuilder(
          GUpdateNotificationData_updateNotificationBuilder b) =>
      b..G__typename = 'UpdateNotificationResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  static Serializer<GUpdateNotificationData_updateNotification>
      get serializer => _$gUpdateNotificationDataUpdateNotificationSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateNotificationData_updateNotification.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateNotificationData_updateNotification? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateNotificationData_updateNotification.serializer,
        json,
      );
}

abstract class GDeleteNotificationData
    implements Built<GDeleteNotificationData, GDeleteNotificationDataBuilder> {
  GDeleteNotificationData._();

  factory GDeleteNotificationData(
          [void Function(GDeleteNotificationDataBuilder b) updates]) =
      _$GDeleteNotificationData;

  static void _initializeBuilder(GDeleteNotificationDataBuilder b) =>
      b..G__typename = 'MutationRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GDeleteNotificationData_deleteNotification get deleteNotification;
  static Serializer<GDeleteNotificationData> get serializer =>
      _$gDeleteNotificationDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GDeleteNotificationData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GDeleteNotificationData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GDeleteNotificationData.serializer,
        json,
      );
}

abstract class GDeleteNotificationData_deleteNotification
    implements
        Built<GDeleteNotificationData_deleteNotification,
            GDeleteNotificationData_deleteNotificationBuilder> {
  GDeleteNotificationData_deleteNotification._();

  factory GDeleteNotificationData_deleteNotification(
      [void Function(GDeleteNotificationData_deleteNotificationBuilder b)
          updates]) = _$GDeleteNotificationData_deleteNotification;

  static void _initializeBuilder(
          GDeleteNotificationData_deleteNotificationBuilder b) =>
      b..G__typename = 'DeleteNotificationResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  static Serializer<GDeleteNotificationData_deleteNotification>
      get serializer => _$gDeleteNotificationDataDeleteNotificationSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GDeleteNotificationData_deleteNotification.serializer,
        this,
      ) as Map<String, dynamic>);

  static GDeleteNotificationData_deleteNotification? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GDeleteNotificationData_deleteNotification.serializer,
        json,
      );
}

abstract class GCreateFspTxData
    implements Built<GCreateFspTxData, GCreateFspTxDataBuilder> {
  GCreateFspTxData._();

  factory GCreateFspTxData([void Function(GCreateFspTxDataBuilder b) updates]) =
      _$GCreateFspTxData;

  static void _initializeBuilder(GCreateFspTxDataBuilder b) =>
      b..G__typename = 'MutationRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GCreateFspTxData_createFspTx get createFspTx;
  static Serializer<GCreateFspTxData> get serializer =>
      _$gCreateFspTxDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateFspTxData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateFspTxData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateFspTxData.serializer,
        json,
      );
}

abstract class GCreateFspTxData_createFspTx
    implements
        Built<GCreateFspTxData_createFspTx,
            GCreateFspTxData_createFspTxBuilder> {
  GCreateFspTxData_createFspTx._();

  factory GCreateFspTxData_createFspTx(
          [void Function(GCreateFspTxData_createFspTxBuilder b) updates]) =
      _$GCreateFspTxData_createFspTx;

  static void _initializeBuilder(GCreateFspTxData_createFspTxBuilder b) =>
      b..G__typename = 'CreateNewTransactionResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get newBalance;
  static Serializer<GCreateFspTxData_createFspTx> get serializer =>
      _$gCreateFspTxDataCreateFspTxSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateFspTxData_createFspTx.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateFspTxData_createFspTx? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateFspTxData_createFspTx.serializer,
        json,
      );
}

abstract class GCreateNewArtistData
    implements Built<GCreateNewArtistData, GCreateNewArtistDataBuilder> {
  GCreateNewArtistData._();

  factory GCreateNewArtistData(
          [void Function(GCreateNewArtistDataBuilder b) updates]) =
      _$GCreateNewArtistData;

  static void _initializeBuilder(GCreateNewArtistDataBuilder b) =>
      b..G__typename = 'MutationRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GCreateNewArtistData_createNewArtist get createNewArtist;
  static Serializer<GCreateNewArtistData> get serializer =>
      _$gCreateNewArtistDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateNewArtistData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateNewArtistData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateNewArtistData.serializer,
        json,
      );
}

abstract class GCreateNewArtistData_createNewArtist
    implements
        Built<GCreateNewArtistData_createNewArtist,
            GCreateNewArtistData_createNewArtistBuilder> {
  GCreateNewArtistData_createNewArtist._();

  factory GCreateNewArtistData_createNewArtist(
      [void Function(GCreateNewArtistData_createNewArtistBuilder b)
          updates]) = _$GCreateNewArtistData_createNewArtist;

  static void _initializeBuilder(
          GCreateNewArtistData_createNewArtistBuilder b) =>
      b..G__typename = 'CreateNewArtistResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get name;
  static Serializer<GCreateNewArtistData_createNewArtist> get serializer =>
      _$gCreateNewArtistDataCreateNewArtistSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateNewArtistData_createNewArtist.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateNewArtistData_createNewArtist? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateNewArtistData_createNewArtist.serializer,
        json,
      );
}
