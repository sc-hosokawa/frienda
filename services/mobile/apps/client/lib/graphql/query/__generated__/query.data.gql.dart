// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:client/graphql/__generated__/serializers.gql.dart' as _i1;

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

abstract class GGetUserInfoData
    implements Built<GGetUserInfoData, GGetUserInfoDataBuilder> {
  GGetUserInfoData._();

  factory GGetUserInfoData([void Function(GGetUserInfoDataBuilder b) updates]) =
      _$GGetUserInfoData;

  static void _initializeBuilder(GGetUserInfoDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetUserInfoData_getUserInfo get getUserInfo;
  static Serializer<GGetUserInfoData> get serializer =>
      _$gGetUserInfoDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetUserInfoData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetUserInfoData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetUserInfoData.serializer,
        json,
      );
}

abstract class GGetUserInfoData_getUserInfo
    implements
        Built<GGetUserInfoData_getUserInfo,
            GGetUserInfoData_getUserInfoBuilder> {
  GGetUserInfoData_getUserInfo._();

  factory GGetUserInfoData_getUserInfo(
          [void Function(GGetUserInfoData_getUserInfoBuilder b) updates]) =
      _$GGetUserInfoData_getUserInfo;

  static void _initializeBuilder(GGetUserInfoData_getUserInfoBuilder b) =>
      b..G__typename = 'UserInfoData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get firstName;
  String get lastName;
  String get imageUrl;
  String get createdAt;
  String get updatedAt;
  static Serializer<GGetUserInfoData_getUserInfo> get serializer =>
      _$gGetUserInfoDataGetUserInfoSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetUserInfoData_getUserInfo.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetUserInfoData_getUserInfo? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetUserInfoData_getUserInfo.serializer,
        json,
      );
}

abstract class GGetAllOffersData
    implements Built<GGetAllOffersData, GGetAllOffersDataBuilder> {
  GGetAllOffersData._();

  factory GGetAllOffersData(
          [void Function(GGetAllOffersDataBuilder b) updates]) =
      _$GGetAllOffersData;

  static void _initializeBuilder(GGetAllOffersDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetAllOffersData_getAllOffers get getAllOffers;
  static Serializer<GGetAllOffersData> get serializer =>
      _$gGetAllOffersDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetAllOffersData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetAllOffersData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetAllOffersData.serializer,
        json,
      );
}

abstract class GGetAllOffersData_getAllOffers
    implements
        Built<GGetAllOffersData_getAllOffers,
            GGetAllOffersData_getAllOffersBuilder> {
  GGetAllOffersData_getAllOffers._();

  factory GGetAllOffersData_getAllOffers(
          [void Function(GGetAllOffersData_getAllOffersBuilder b) updates]) =
      _$GGetAllOffersData_getAllOffers;

  static void _initializeBuilder(GGetAllOffersData_getAllOffersBuilder b) =>
      b..G__typename = 'OffersData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get title;
  String get content;
  String get createdAt;
  String get updatedAt;
  static Serializer<GGetAllOffersData_getAllOffers> get serializer =>
      _$gGetAllOffersDataGetAllOffersSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetAllOffersData_getAllOffers.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetAllOffersData_getAllOffers? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetAllOffersData_getAllOffers.serializer,
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
  String get id;
  String get name;
  String get createdAt;
  String get updatedAt;
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
      b..G__typename = 'MessagesByMessageRoomIdData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get title;
  String get content;
  String get createdAt;
  String get updatedAt;
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
  GGetNotificationsData_getNotifications get getNotifications;
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
      b..G__typename = 'NotificationsByUserData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get title;
  String get content;
  String get createdAt;
  String get updatedAt;
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
      b..G__typename = 'UserData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get email;
  String get firstName;
  String get lastName;
  String get imageUrl;
  String get createdAt;
  String get updatedAt;
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
