// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:admin/graphql/__generated__/serializers.gql.dart' as _i1;
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'query.data.gql.g.dart';

abstract class GHealthCheckData
    implements Built<GHealthCheckData, GHealthCheckDataBuilder> {
  GHealthCheckData._();

  factory GHealthCheckData([void Function(GHealthCheckDataBuilder b) updates]) =
      _$GHealthCheckData;

  static void _initializeBuilder(GHealthCheckDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GHealthCheckData_healthCheck get healthCheck;
  static Serializer<GHealthCheckData> get serializer =>
      _$gHealthCheckDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GHealthCheckData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GHealthCheckData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GHealthCheckData.serializer,
        json,
      );
}

abstract class GHealthCheckData_healthCheck
    implements
        Built<GHealthCheckData_healthCheck,
            GHealthCheckData_healthCheckBuilder> {
  GHealthCheckData_healthCheck._();

  factory GHealthCheckData_healthCheck(
          [void Function(GHealthCheckData_healthCheckBuilder b) updates]) =
      _$GHealthCheckData_healthCheck;

  static void _initializeBuilder(GHealthCheckData_healthCheckBuilder b) =>
      b..G__typename = 'HealthCheck';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get status;
  static Serializer<GHealthCheckData_healthCheck> get serializer =>
      _$gHealthCheckDataHealthCheckSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GHealthCheckData_healthCheck.serializer,
        this,
      ) as Map<String, dynamic>);

  static GHealthCheckData_healthCheck? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GHealthCheckData_healthCheck.serializer,
        json,
      );
}

abstract class GGetUserDataData
    implements Built<GGetUserDataData, GGetUserDataDataBuilder> {
  GGetUserDataData._();

  factory GGetUserDataData([void Function(GGetUserDataDataBuilder b) updates]) =
      _$GGetUserDataData;

  static void _initializeBuilder(GGetUserDataDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetUserDataData_getUserData get getUserData;
  static Serializer<GGetUserDataData> get serializer =>
      _$gGetUserDataDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetUserDataData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetUserDataData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetUserDataData.serializer,
        json,
      );
}

abstract class GGetUserDataData_getUserData
    implements
        Built<GGetUserDataData_getUserData,
            GGetUserDataData_getUserDataBuilder> {
  GGetUserDataData_getUserData._();

  factory GGetUserDataData_getUserData(
          [void Function(GGetUserDataData_getUserDataBuilder b) updates]) =
      _$GGetUserDataData_getUserData;

  static void _initializeBuilder(GGetUserDataData_getUserDataBuilder b) =>
      b..G__typename = 'UserDetailData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get name;
  String get email;
  String get realname;
  String? get imageUrl;
  bool get isSuperAdmin;
  int get fspBalance;
  int get credentialBalance;
  String? get evmAddr;
  String get role;
  String get primaryRole;
  String? get greeting;
  String? get skill;
  String? get xHandle;
  String? get instagramHandle;
  String? get fbHandle;
  String? get interestOffer;
  String get createdAt;
  static Serializer<GGetUserDataData_getUserData> get serializer =>
      _$gGetUserDataDataGetUserDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetUserDataData_getUserData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetUserDataData_getUserData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetUserDataData_getUserData.serializer,
        json,
      );
}

abstract class GGetOffersData
    implements Built<GGetOffersData, GGetOffersDataBuilder> {
  GGetOffersData._();

  factory GGetOffersData([void Function(GGetOffersDataBuilder b) updates]) =
      _$GGetOffersData;

  static void _initializeBuilder(GGetOffersDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetOffersData_getOffers get getOffers;
  static Serializer<GGetOffersData> get serializer =>
      _$gGetOffersDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetOffersData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOffersData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetOffersData.serializer,
        json,
      );
}

abstract class GGetOffersData_getOffers
    implements
        Built<GGetOffersData_getOffers, GGetOffersData_getOffersBuilder> {
  GGetOffersData_getOffers._();

  factory GGetOffersData_getOffers(
          [void Function(GGetOffersData_getOffersBuilder b) updates]) =
      _$GGetOffersData_getOffers;

  static void _initializeBuilder(GGetOffersData_getOffersBuilder b) =>
      b..G__typename = 'OffersData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GGetOffersData_getOffers_offerList> get offerList;
  static Serializer<GGetOffersData_getOffers> get serializer =>
      _$gGetOffersDataGetOffersSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetOffersData_getOffers.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOffersData_getOffers? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetOffersData_getOffers.serializer,
        json,
      );
}

abstract class GGetOffersData_getOffers_offerList
    implements
        Built<GGetOffersData_getOffers_offerList,
            GGetOffersData_getOffers_offerListBuilder> {
  GGetOffersData_getOffers_offerList._();

  factory GGetOffersData_getOffers_offerList(
      [void Function(GGetOffersData_getOffers_offerListBuilder b)
          updates]) = _$GGetOffersData_getOffers_offerList;

  static void _initializeBuilder(GGetOffersData_getOffers_offerListBuilder b) =>
      b..G__typename = 'OfferData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String get title;
  String get description;
  String? get imageUrl;
  int get fee;
  String? get category;
  String get place;
  static Serializer<GGetOffersData_getOffers_offerList> get serializer =>
      _$gGetOffersDataGetOffersOfferListSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetOffersData_getOffers_offerList.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOffersData_getOffers_offerList? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetOffersData_getOffers_offerList.serializer,
        json,
      );
}

abstract class GGetMessageRoomsData
    implements Built<GGetMessageRoomsData, GGetMessageRoomsDataBuilder> {
  GGetMessageRoomsData._();

  factory GGetMessageRoomsData(
          [void Function(GGetMessageRoomsDataBuilder b) updates]) =
      _$GGetMessageRoomsData;

  static void _initializeBuilder(GGetMessageRoomsDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetMessageRoomsData_getMessageRooms get getMessageRooms;
  static Serializer<GGetMessageRoomsData> get serializer =>
      _$gGetMessageRoomsDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMessageRoomsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMessageRoomsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetMessageRoomsData.serializer,
        json,
      );
}

abstract class GGetMessageRoomsData_getMessageRooms
    implements
        Built<GGetMessageRoomsData_getMessageRooms,
            GGetMessageRoomsData_getMessageRoomsBuilder> {
  GGetMessageRoomsData_getMessageRooms._();

  factory GGetMessageRoomsData_getMessageRooms(
      [void Function(GGetMessageRoomsData_getMessageRoomsBuilder b)
          updates]) = _$GGetMessageRoomsData_getMessageRooms;

  static void _initializeBuilder(
          GGetMessageRoomsData_getMessageRoomsBuilder b) =>
      b..G__typename = 'MessageRoomsByUserData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GGetMessageRoomsData_getMessageRooms_messageRoomList>
      get messageRoomList;
  int get countOfMessageRooms;
  static Serializer<GGetMessageRoomsData_getMessageRooms> get serializer =>
      _$gGetMessageRoomsDataGetMessageRoomsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMessageRoomsData_getMessageRooms.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMessageRoomsData_getMessageRooms? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetMessageRoomsData_getMessageRooms.serializer,
        json,
      );
}

abstract class GGetMessageRoomsData_getMessageRooms_messageRoomList
    implements
        Built<GGetMessageRoomsData_getMessageRooms_messageRoomList,
            GGetMessageRoomsData_getMessageRooms_messageRoomListBuilder> {
  GGetMessageRoomsData_getMessageRooms_messageRoomList._();

  factory GGetMessageRoomsData_getMessageRooms_messageRoomList(
      [void Function(
              GGetMessageRoomsData_getMessageRooms_messageRoomListBuilder b)
          updates]) = _$GGetMessageRoomsData_getMessageRooms_messageRoomList;

  static void _initializeBuilder(
          GGetMessageRoomsData_getMessageRooms_messageRoomListBuilder b) =>
      b..G__typename = 'MessageRoomData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String? get category;
  String? get latestMessage;
  String? get latestMessageId;
  String? get latestSentAt;
  bool get isRead;
  static Serializer<GGetMessageRoomsData_getMessageRooms_messageRoomList>
      get serializer =>
          _$gGetMessageRoomsDataGetMessageRoomsMessageRoomListSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMessageRoomsData_getMessageRooms_messageRoomList.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMessageRoomsData_getMessageRooms_messageRoomList? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetMessageRoomsData_getMessageRooms_messageRoomList.serializer,
        json,
      );
}

abstract class GGetMessagesByMessageRoomIdData
    implements
        Built<GGetMessagesByMessageRoomIdData,
            GGetMessagesByMessageRoomIdDataBuilder> {
  GGetMessagesByMessageRoomIdData._();

  factory GGetMessagesByMessageRoomIdData(
          [void Function(GGetMessagesByMessageRoomIdDataBuilder b) updates]) =
      _$GGetMessagesByMessageRoomIdData;

  static void _initializeBuilder(GGetMessagesByMessageRoomIdDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId
      get getMessagesByMessageRoomId;
  static Serializer<GGetMessagesByMessageRoomIdData> get serializer =>
      _$gGetMessagesByMessageRoomIdDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMessagesByMessageRoomIdData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMessagesByMessageRoomIdData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetMessagesByMessageRoomIdData.serializer,
        json,
      );
}

abstract class GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId
    implements
        Built<GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId,
            GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomIdBuilder> {
  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId._();

  factory GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId(
      [void Function(
              GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomIdBuilder
                  b)
          updates]) = _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId;

  static void _initializeBuilder(
          GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomIdBuilder
              b) =>
      b..G__typename = 'MessagesByRoomIdByUserData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to get to;
  BuiltList<
          GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList>
      get messageList;
  static Serializer<GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId>
      get serializer =>
          _$gGetMessagesByMessageRoomIdDataGetMessagesByMessageRoomIdSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId.serializer,
        json,
      );
}

abstract class GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to
    implements
        Built<GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to,
            GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_toBuilder> {
  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to._();

  factory GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to(
          [void Function(
                  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_toBuilder
                      b)
              updates]) =
      _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to;

  static void _initializeBuilder(
          GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_toBuilder
              b) =>
      b..G__typename = 'UserSimpleData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get name;
  String get realname;
  String? get imageUrl;
  static Serializer<
          GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to>
      get serializer =>
          _$gGetMessagesByMessageRoomIdDataGetMessagesByMessageRoomIdToSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to
                .serializer,
            json,
          );
}

abstract class GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList
    implements
        Built<
            GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList,
            GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageListBuilder> {
  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList._();

  factory GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList(
          [void Function(
                  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageListBuilder
                      b)
              updates]) =
      _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList;

  static void _initializeBuilder(
          GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageListBuilder
              b) =>
      b..G__typename = 'MessageTempData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get content;
  String get sentBy;
  String get sentAt;
  String? get attachedFile;
  String? get attachedImg;
  static Serializer<
          GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList>
      get serializer =>
          _$gGetMessagesByMessageRoomIdDataGetMessagesByMessageRoomIdMessageListSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList
                .serializer,
            json,
          );
}

abstract class GGetNotificationsData
    implements Built<GGetNotificationsData, GGetNotificationsDataBuilder> {
  GGetNotificationsData._();

  factory GGetNotificationsData(
          [void Function(GGetNotificationsDataBuilder b) updates]) =
      _$GGetNotificationsData;

  static void _initializeBuilder(GGetNotificationsDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GGetNotificationsData_getNotifications> get getNotifications;
  static Serializer<GGetNotificationsData> get serializer =>
      _$gGetNotificationsDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetNotificationsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetNotificationsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetNotificationsData.serializer,
        json,
      );
}

abstract class GGetNotificationsData_getNotifications
    implements
        Built<GGetNotificationsData_getNotifications,
            GGetNotificationsData_getNotificationsBuilder> {
  GGetNotificationsData_getNotifications._();

  factory GGetNotificationsData_getNotifications(
      [void Function(GGetNotificationsData_getNotificationsBuilder b)
          updates]) = _$GGetNotificationsData_getNotifications;

  static void _initializeBuilder(
          GGetNotificationsData_getNotificationsBuilder b) =>
      b..G__typename = 'NotificationData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get title;
  String? get category;
  String get content;
  bool get isRead;
  String get createdAt;
  static Serializer<GGetNotificationsData_getNotifications> get serializer =>
      _$gGetNotificationsDataGetNotificationsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetNotificationsData_getNotifications.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetNotificationsData_getNotifications? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetNotificationsData_getNotifications.serializer,
        json,
      );
}
