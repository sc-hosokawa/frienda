// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GHealthCheckData> _$gHealthCheckDataSerializer =
    new _$GHealthCheckDataSerializer();
Serializer<GHealthCheckData_healthCheck>
    _$gHealthCheckDataHealthCheckSerializer =
    new _$GHealthCheckData_healthCheckSerializer();
Serializer<GGetUserInfoData> _$gGetUserInfoDataSerializer =
    new _$GGetUserInfoDataSerializer();
Serializer<GGetUserInfoData_getUserInfo>
    _$gGetUserInfoDataGetUserInfoSerializer =
    new _$GGetUserInfoData_getUserInfoSerializer();
Serializer<GGetAllOffersData> _$gGetAllOffersDataSerializer =
    new _$GGetAllOffersDataSerializer();
Serializer<GGetAllOffersData_getAllOffers>
    _$gGetAllOffersDataGetAllOffersSerializer =
    new _$GGetAllOffersData_getAllOffersSerializer();
Serializer<GGetMessageRoomsData> _$gGetMessageRoomsDataSerializer =
    new _$GGetMessageRoomsDataSerializer();
Serializer<GGetMessageRoomsData_getMessageRooms>
    _$gGetMessageRoomsDataGetMessageRoomsSerializer =
    new _$GGetMessageRoomsData_getMessageRoomsSerializer();
Serializer<GGetMessagesByMessageRoomIdData>
    _$gGetMessagesByMessageRoomIdDataSerializer =
    new _$GGetMessagesByMessageRoomIdDataSerializer();
Serializer<GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId>
    _$gGetMessagesByMessageRoomIdDataGetMessagesByMessageRoomIdSerializer =
    new _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomIdSerializer();
Serializer<GGetNotificationsData> _$gGetNotificationsDataSerializer =
    new _$GGetNotificationsDataSerializer();
Serializer<GGetNotificationsData_getNotifications>
    _$gGetNotificationsDataGetNotificationsSerializer =
    new _$GGetNotificationsData_getNotificationsSerializer();
Serializer<GGetUserDataData> _$gGetUserDataDataSerializer =
    new _$GGetUserDataDataSerializer();
Serializer<GGetUserDataData_getUserData>
    _$gGetUserDataDataGetUserDataSerializer =
    new _$GGetUserDataData_getUserDataSerializer();

class _$GHealthCheckDataSerializer
    implements StructuredSerializer<GHealthCheckData> {
  @override
  final Iterable<Type> types = const [GHealthCheckData, _$GHealthCheckData];
  @override
  final String wireName = 'GHealthCheckData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GHealthCheckData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'healthCheck',
      serializers.serialize(object.healthCheck,
          specifiedType: const FullType(GHealthCheckData_healthCheck)),
    ];

    return result;
  }

  @override
  GHealthCheckData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GHealthCheckDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'healthCheck':
          result.healthCheck.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GHealthCheckData_healthCheck))!
              as GHealthCheckData_healthCheck);
          break;
      }
    }

    return result.build();
  }
}

class _$GHealthCheckData_healthCheckSerializer
    implements StructuredSerializer<GHealthCheckData_healthCheck> {
  @override
  final Iterable<Type> types = const [
    GHealthCheckData_healthCheck,
    _$GHealthCheckData_healthCheck
  ];
  @override
  final String wireName = 'GHealthCheckData_healthCheck';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GHealthCheckData_healthCheck object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'status',
      serializers.serialize(object.status,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GHealthCheckData_healthCheck deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GHealthCheckData_healthCheckBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetUserInfoDataSerializer
    implements StructuredSerializer<GGetUserInfoData> {
  @override
  final Iterable<Type> types = const [GGetUserInfoData, _$GGetUserInfoData];
  @override
  final String wireName = 'GGetUserInfoData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GGetUserInfoData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'getUserInfo',
      serializers.serialize(object.getUserInfo,
          specifiedType: const FullType(GGetUserInfoData_getUserInfo)),
    ];

    return result;
  }

  @override
  GGetUserInfoData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GGetUserInfoDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'getUserInfo':
          result.getUserInfo.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GGetUserInfoData_getUserInfo))!
              as GGetUserInfoData_getUserInfo);
          break;
      }
    }

    return result.build();
  }
}

class _$GGetUserInfoData_getUserInfoSerializer
    implements StructuredSerializer<GGetUserInfoData_getUserInfo> {
  @override
  final Iterable<Type> types = const [
    GGetUserInfoData_getUserInfo,
    _$GGetUserInfoData_getUserInfo
  ];
  @override
  final String wireName = 'GGetUserInfoData_getUserInfo';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GGetUserInfoData_getUserInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'firstName',
      serializers.serialize(object.firstName,
          specifiedType: const FullType(String)),
      'lastName',
      serializers.serialize(object.lastName,
          specifiedType: const FullType(String)),
      'imageUrl',
      serializers.serialize(object.imageUrl,
          specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(String)),
      'updatedAt',
      serializers.serialize(object.updatedAt,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GGetUserInfoData_getUserInfo deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GGetUserInfoData_getUserInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'firstName':
          result.firstName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'lastName':
          result.lastName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'imageUrl':
          result.imageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'updatedAt':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetAllOffersDataSerializer
    implements StructuredSerializer<GGetAllOffersData> {
  @override
  final Iterable<Type> types = const [GGetAllOffersData, _$GGetAllOffersData];
  @override
  final String wireName = 'GGetAllOffersData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GGetAllOffersData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'getAllOffers',
      serializers.serialize(object.getAllOffers,
          specifiedType: const FullType(GGetAllOffersData_getAllOffers)),
    ];

    return result;
  }

  @override
  GGetAllOffersData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GGetAllOffersDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'getAllOffers':
          result.getAllOffers.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GGetAllOffersData_getAllOffers))!
              as GGetAllOffersData_getAllOffers);
          break;
      }
    }

    return result.build();
  }
}

class _$GGetAllOffersData_getAllOffersSerializer
    implements StructuredSerializer<GGetAllOffersData_getAllOffers> {
  @override
  final Iterable<Type> types = const [
    GGetAllOffersData_getAllOffers,
    _$GGetAllOffersData_getAllOffers
  ];
  @override
  final String wireName = 'GGetAllOffersData_getAllOffers';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GGetAllOffersData_getAllOffers object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'content',
      serializers.serialize(object.content,
          specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(String)),
      'updatedAt',
      serializers.serialize(object.updatedAt,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GGetAllOffersData_getAllOffers deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GGetAllOffersData_getAllOffersBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'updatedAt':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetMessageRoomsDataSerializer
    implements StructuredSerializer<GGetMessageRoomsData> {
  @override
  final Iterable<Type> types = const [
    GGetMessageRoomsData,
    _$GGetMessageRoomsData
  ];
  @override
  final String wireName = 'GGetMessageRoomsData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GGetMessageRoomsData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'getMessageRooms',
      serializers.serialize(object.getMessageRooms,
          specifiedType: const FullType(GGetMessageRoomsData_getMessageRooms)),
    ];

    return result;
  }

  @override
  GGetMessageRoomsData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GGetMessageRoomsDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'getMessageRooms':
          result.getMessageRooms.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GGetMessageRoomsData_getMessageRooms))!
              as GGetMessageRoomsData_getMessageRooms);
          break;
      }
    }

    return result.build();
  }
}

class _$GGetMessageRoomsData_getMessageRoomsSerializer
    implements StructuredSerializer<GGetMessageRoomsData_getMessageRooms> {
  @override
  final Iterable<Type> types = const [
    GGetMessageRoomsData_getMessageRooms,
    _$GGetMessageRoomsData_getMessageRooms
  ];
  @override
  final String wireName = 'GGetMessageRoomsData_getMessageRooms';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GGetMessageRoomsData_getMessageRooms object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(String)),
      'updatedAt',
      serializers.serialize(object.updatedAt,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GGetMessageRoomsData_getMessageRooms deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GGetMessageRoomsData_getMessageRoomsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'updatedAt':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetMessagesByMessageRoomIdDataSerializer
    implements StructuredSerializer<GGetMessagesByMessageRoomIdData> {
  @override
  final Iterable<Type> types = const [
    GGetMessagesByMessageRoomIdData,
    _$GGetMessagesByMessageRoomIdData
  ];
  @override
  final String wireName = 'GGetMessagesByMessageRoomIdData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GGetMessagesByMessageRoomIdData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'getMessagesByMessageRoomId',
      serializers.serialize(object.getMessagesByMessageRoomId,
          specifiedType: const FullType(
              GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId)),
    ];

    return result;
  }

  @override
  GGetMessagesByMessageRoomIdData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GGetMessagesByMessageRoomIdDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'getMessagesByMessageRoomId':
          result.getMessagesByMessageRoomId.replace(serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                      GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId))!
              as GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId);
          break;
      }
    }

    return result.build();
  }
}

class _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomIdSerializer
    implements
        StructuredSerializer<
            GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId> {
  @override
  final Iterable<Type> types = const [
    GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId,
    _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId
  ];
  @override
  final String wireName =
      'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'content',
      serializers.serialize(object.content,
          specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(String)),
      'updatedAt',
      serializers.serialize(object.updatedAt,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomIdBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'updatedAt':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetNotificationsDataSerializer
    implements StructuredSerializer<GGetNotificationsData> {
  @override
  final Iterable<Type> types = const [
    GGetNotificationsData,
    _$GGetNotificationsData
  ];
  @override
  final String wireName = 'GGetNotificationsData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GGetNotificationsData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'getNotifications',
      serializers.serialize(object.getNotifications,
          specifiedType:
              const FullType(GGetNotificationsData_getNotifications)),
    ];

    return result;
  }

  @override
  GGetNotificationsData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GGetNotificationsDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'getNotifications':
          result.getNotifications.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GGetNotificationsData_getNotifications))!
              as GGetNotificationsData_getNotifications);
          break;
      }
    }

    return result.build();
  }
}

class _$GGetNotificationsData_getNotificationsSerializer
    implements StructuredSerializer<GGetNotificationsData_getNotifications> {
  @override
  final Iterable<Type> types = const [
    GGetNotificationsData_getNotifications,
    _$GGetNotificationsData_getNotifications
  ];
  @override
  final String wireName = 'GGetNotificationsData_getNotifications';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GGetNotificationsData_getNotifications object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'content',
      serializers.serialize(object.content,
          specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(String)),
      'updatedAt',
      serializers.serialize(object.updatedAt,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GGetNotificationsData_getNotifications deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GGetNotificationsData_getNotificationsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'updatedAt':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetUserDataDataSerializer
    implements StructuredSerializer<GGetUserDataData> {
  @override
  final Iterable<Type> types = const [GGetUserDataData, _$GGetUserDataData];
  @override
  final String wireName = 'GGetUserDataData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GGetUserDataData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'getUserData',
      serializers.serialize(object.getUserData,
          specifiedType: const FullType(GGetUserDataData_getUserData)),
    ];

    return result;
  }

  @override
  GGetUserDataData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GGetUserDataDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'getUserData':
          result.getUserData.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GGetUserDataData_getUserData))!
              as GGetUserDataData_getUserData);
          break;
      }
    }

    return result.build();
  }
}

class _$GGetUserDataData_getUserDataSerializer
    implements StructuredSerializer<GGetUserDataData_getUserData> {
  @override
  final Iterable<Type> types = const [
    GGetUserDataData_getUserData,
    _$GGetUserDataData_getUserData
  ];
  @override
  final String wireName = 'GGetUserDataData_getUserData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GGetUserDataData_getUserData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'firstName',
      serializers.serialize(object.firstName,
          specifiedType: const FullType(String)),
      'lastName',
      serializers.serialize(object.lastName,
          specifiedType: const FullType(String)),
      'imageUrl',
      serializers.serialize(object.imageUrl,
          specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(String)),
      'updatedAt',
      serializers.serialize(object.updatedAt,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GGetUserDataData_getUserData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GGetUserDataData_getUserDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'firstName':
          result.firstName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'lastName':
          result.lastName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'imageUrl':
          result.imageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'updatedAt':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GHealthCheckData extends GHealthCheckData {
  @override
  final String G__typename;
  @override
  final GHealthCheckData_healthCheck healthCheck;

  factory _$GHealthCheckData(
          [void Function(GHealthCheckDataBuilder)? updates]) =>
      (new GHealthCheckDataBuilder()..update(updates))._build();

  _$GHealthCheckData._({required this.G__typename, required this.healthCheck})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GHealthCheckData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        healthCheck, r'GHealthCheckData', 'healthCheck');
  }

  @override
  GHealthCheckData rebuild(void Function(GHealthCheckDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GHealthCheckDataBuilder toBuilder() =>
      new GHealthCheckDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GHealthCheckData &&
        G__typename == other.G__typename &&
        healthCheck == other.healthCheck;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, healthCheck.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GHealthCheckData')
          ..add('G__typename', G__typename)
          ..add('healthCheck', healthCheck))
        .toString();
  }
}

class GHealthCheckDataBuilder
    implements Builder<GHealthCheckData, GHealthCheckDataBuilder> {
  _$GHealthCheckData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GHealthCheckData_healthCheckBuilder? _healthCheck;
  GHealthCheckData_healthCheckBuilder get healthCheck =>
      _$this._healthCheck ??= new GHealthCheckData_healthCheckBuilder();
  set healthCheck(GHealthCheckData_healthCheckBuilder? healthCheck) =>
      _$this._healthCheck = healthCheck;

  GHealthCheckDataBuilder() {
    GHealthCheckData._initializeBuilder(this);
  }

  GHealthCheckDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _healthCheck = $v.healthCheck.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GHealthCheckData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GHealthCheckData;
  }

  @override
  void update(void Function(GHealthCheckDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GHealthCheckData build() => _build();

  _$GHealthCheckData _build() {
    _$GHealthCheckData _$result;
    try {
      _$result = _$v ??
          new _$GHealthCheckData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GHealthCheckData', 'G__typename'),
              healthCheck: healthCheck.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'healthCheck';
        healthCheck.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GHealthCheckData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GHealthCheckData_healthCheck extends GHealthCheckData_healthCheck {
  @override
  final String G__typename;
  @override
  final String status;

  factory _$GHealthCheckData_healthCheck(
          [void Function(GHealthCheckData_healthCheckBuilder)? updates]) =>
      (new GHealthCheckData_healthCheckBuilder()..update(updates))._build();

  _$GHealthCheckData_healthCheck._(
      {required this.G__typename, required this.status})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GHealthCheckData_healthCheck', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        status, r'GHealthCheckData_healthCheck', 'status');
  }

  @override
  GHealthCheckData_healthCheck rebuild(
          void Function(GHealthCheckData_healthCheckBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GHealthCheckData_healthCheckBuilder toBuilder() =>
      new GHealthCheckData_healthCheckBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GHealthCheckData_healthCheck &&
        G__typename == other.G__typename &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GHealthCheckData_healthCheck')
          ..add('G__typename', G__typename)
          ..add('status', status))
        .toString();
  }
}

class GHealthCheckData_healthCheckBuilder
    implements
        Builder<GHealthCheckData_healthCheck,
            GHealthCheckData_healthCheckBuilder> {
  _$GHealthCheckData_healthCheck? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  GHealthCheckData_healthCheckBuilder() {
    GHealthCheckData_healthCheck._initializeBuilder(this);
  }

  GHealthCheckData_healthCheckBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GHealthCheckData_healthCheck other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GHealthCheckData_healthCheck;
  }

  @override
  void update(void Function(GHealthCheckData_healthCheckBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GHealthCheckData_healthCheck build() => _build();

  _$GHealthCheckData_healthCheck _build() {
    final _$result = _$v ??
        new _$GHealthCheckData_healthCheck._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GHealthCheckData_healthCheck', 'G__typename'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'GHealthCheckData_healthCheck', 'status'));
    replace(_$result);
    return _$result;
  }
}

class _$GGetUserInfoData extends GGetUserInfoData {
  @override
  final String G__typename;
  @override
  final GGetUserInfoData_getUserInfo getUserInfo;

  factory _$GGetUserInfoData(
          [void Function(GGetUserInfoDataBuilder)? updates]) =>
      (new GGetUserInfoDataBuilder()..update(updates))._build();

  _$GGetUserInfoData._({required this.G__typename, required this.getUserInfo})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GGetUserInfoData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        getUserInfo, r'GGetUserInfoData', 'getUserInfo');
  }

  @override
  GGetUserInfoData rebuild(void Function(GGetUserInfoDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetUserInfoDataBuilder toBuilder() =>
      new GGetUserInfoDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetUserInfoData &&
        G__typename == other.G__typename &&
        getUserInfo == other.getUserInfo;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, getUserInfo.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetUserInfoData')
          ..add('G__typename', G__typename)
          ..add('getUserInfo', getUserInfo))
        .toString();
  }
}

class GGetUserInfoDataBuilder
    implements Builder<GGetUserInfoData, GGetUserInfoDataBuilder> {
  _$GGetUserInfoData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GGetUserInfoData_getUserInfoBuilder? _getUserInfo;
  GGetUserInfoData_getUserInfoBuilder get getUserInfo =>
      _$this._getUserInfo ??= new GGetUserInfoData_getUserInfoBuilder();
  set getUserInfo(GGetUserInfoData_getUserInfoBuilder? getUserInfo) =>
      _$this._getUserInfo = getUserInfo;

  GGetUserInfoDataBuilder() {
    GGetUserInfoData._initializeBuilder(this);
  }

  GGetUserInfoDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _getUserInfo = $v.getUserInfo.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetUserInfoData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetUserInfoData;
  }

  @override
  void update(void Function(GGetUserInfoDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetUserInfoData build() => _build();

  _$GGetUserInfoData _build() {
    _$GGetUserInfoData _$result;
    try {
      _$result = _$v ??
          new _$GGetUserInfoData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GGetUserInfoData', 'G__typename'),
              getUserInfo: getUserInfo.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'getUserInfo';
        getUserInfo.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GGetUserInfoData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GGetUserInfoData_getUserInfo extends GGetUserInfoData_getUserInfo {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String imageUrl;
  @override
  final String createdAt;
  @override
  final String updatedAt;

  factory _$GGetUserInfoData_getUserInfo(
          [void Function(GGetUserInfoData_getUserInfoBuilder)? updates]) =>
      (new GGetUserInfoData_getUserInfoBuilder()..update(updates))._build();

  _$GGetUserInfoData_getUserInfo._(
      {required this.G__typename,
      required this.id,
      required this.firstName,
      required this.lastName,
      required this.imageUrl,
      required this.createdAt,
      required this.updatedAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GGetUserInfoData_getUserInfo', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GGetUserInfoData_getUserInfo', 'id');
    BuiltValueNullFieldError.checkNotNull(
        firstName, r'GGetUserInfoData_getUserInfo', 'firstName');
    BuiltValueNullFieldError.checkNotNull(
        lastName, r'GGetUserInfoData_getUserInfo', 'lastName');
    BuiltValueNullFieldError.checkNotNull(
        imageUrl, r'GGetUserInfoData_getUserInfo', 'imageUrl');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'GGetUserInfoData_getUserInfo', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, r'GGetUserInfoData_getUserInfo', 'updatedAt');
  }

  @override
  GGetUserInfoData_getUserInfo rebuild(
          void Function(GGetUserInfoData_getUserInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetUserInfoData_getUserInfoBuilder toBuilder() =>
      new GGetUserInfoData_getUserInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetUserInfoData_getUserInfo &&
        G__typename == other.G__typename &&
        id == other.id &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        imageUrl == other.imageUrl &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetUserInfoData_getUserInfo')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('imageUrl', imageUrl)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class GGetUserInfoData_getUserInfoBuilder
    implements
        Builder<GGetUserInfoData_getUserInfo,
            GGetUserInfoData_getUserInfoBuilder> {
  _$GGetUserInfoData_getUserInfo? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  GGetUserInfoData_getUserInfoBuilder() {
    GGetUserInfoData_getUserInfo._initializeBuilder(this);
  }

  GGetUserInfoData_getUserInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _imageUrl = $v.imageUrl;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetUserInfoData_getUserInfo other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetUserInfoData_getUserInfo;
  }

  @override
  void update(void Function(GGetUserInfoData_getUserInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetUserInfoData_getUserInfo build() => _build();

  _$GGetUserInfoData_getUserInfo _build() {
    final _$result = _$v ??
        new _$GGetUserInfoData_getUserInfo._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GGetUserInfoData_getUserInfo', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GGetUserInfoData_getUserInfo', 'id'),
            firstName: BuiltValueNullFieldError.checkNotNull(
                firstName, r'GGetUserInfoData_getUserInfo', 'firstName'),
            lastName: BuiltValueNullFieldError.checkNotNull(
                lastName, r'GGetUserInfoData_getUserInfo', 'lastName'),
            imageUrl: BuiltValueNullFieldError.checkNotNull(
                imageUrl, r'GGetUserInfoData_getUserInfo', 'imageUrl'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'GGetUserInfoData_getUserInfo', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, r'GGetUserInfoData_getUserInfo', 'updatedAt'));
    replace(_$result);
    return _$result;
  }
}

class _$GGetAllOffersData extends GGetAllOffersData {
  @override
  final String G__typename;
  @override
  final GGetAllOffersData_getAllOffers getAllOffers;

  factory _$GGetAllOffersData(
          [void Function(GGetAllOffersDataBuilder)? updates]) =>
      (new GGetAllOffersDataBuilder()..update(updates))._build();

  _$GGetAllOffersData._({required this.G__typename, required this.getAllOffers})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GGetAllOffersData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        getAllOffers, r'GGetAllOffersData', 'getAllOffers');
  }

  @override
  GGetAllOffersData rebuild(void Function(GGetAllOffersDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetAllOffersDataBuilder toBuilder() =>
      new GGetAllOffersDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetAllOffersData &&
        G__typename == other.G__typename &&
        getAllOffers == other.getAllOffers;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, getAllOffers.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetAllOffersData')
          ..add('G__typename', G__typename)
          ..add('getAllOffers', getAllOffers))
        .toString();
  }
}

class GGetAllOffersDataBuilder
    implements Builder<GGetAllOffersData, GGetAllOffersDataBuilder> {
  _$GGetAllOffersData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GGetAllOffersData_getAllOffersBuilder? _getAllOffers;
  GGetAllOffersData_getAllOffersBuilder get getAllOffers =>
      _$this._getAllOffers ??= new GGetAllOffersData_getAllOffersBuilder();
  set getAllOffers(GGetAllOffersData_getAllOffersBuilder? getAllOffers) =>
      _$this._getAllOffers = getAllOffers;

  GGetAllOffersDataBuilder() {
    GGetAllOffersData._initializeBuilder(this);
  }

  GGetAllOffersDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _getAllOffers = $v.getAllOffers.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetAllOffersData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetAllOffersData;
  }

  @override
  void update(void Function(GGetAllOffersDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetAllOffersData build() => _build();

  _$GGetAllOffersData _build() {
    _$GGetAllOffersData _$result;
    try {
      _$result = _$v ??
          new _$GGetAllOffersData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GGetAllOffersData', 'G__typename'),
              getAllOffers: getAllOffers.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'getAllOffers';
        getAllOffers.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GGetAllOffersData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GGetAllOffersData_getAllOffers extends GGetAllOffersData_getAllOffers {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String title;
  @override
  final String content;
  @override
  final String createdAt;
  @override
  final String updatedAt;

  factory _$GGetAllOffersData_getAllOffers(
          [void Function(GGetAllOffersData_getAllOffersBuilder)? updates]) =>
      (new GGetAllOffersData_getAllOffersBuilder()..update(updates))._build();

  _$GGetAllOffersData_getAllOffers._(
      {required this.G__typename,
      required this.id,
      required this.title,
      required this.content,
      required this.createdAt,
      required this.updatedAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GGetAllOffersData_getAllOffers', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GGetAllOffersData_getAllOffers', 'id');
    BuiltValueNullFieldError.checkNotNull(
        title, r'GGetAllOffersData_getAllOffers', 'title');
    BuiltValueNullFieldError.checkNotNull(
        content, r'GGetAllOffersData_getAllOffers', 'content');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'GGetAllOffersData_getAllOffers', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, r'GGetAllOffersData_getAllOffers', 'updatedAt');
  }

  @override
  GGetAllOffersData_getAllOffers rebuild(
          void Function(GGetAllOffersData_getAllOffersBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetAllOffersData_getAllOffersBuilder toBuilder() =>
      new GGetAllOffersData_getAllOffersBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetAllOffersData_getAllOffers &&
        G__typename == other.G__typename &&
        id == other.id &&
        title == other.title &&
        content == other.content &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetAllOffersData_getAllOffers')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('title', title)
          ..add('content', content)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class GGetAllOffersData_getAllOffersBuilder
    implements
        Builder<GGetAllOffersData_getAllOffers,
            GGetAllOffersData_getAllOffersBuilder> {
  _$GGetAllOffersData_getAllOffers? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  GGetAllOffersData_getAllOffersBuilder() {
    GGetAllOffersData_getAllOffers._initializeBuilder(this);
  }

  GGetAllOffersData_getAllOffersBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _title = $v.title;
      _content = $v.content;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetAllOffersData_getAllOffers other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetAllOffersData_getAllOffers;
  }

  @override
  void update(void Function(GGetAllOffersData_getAllOffersBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetAllOffersData_getAllOffers build() => _build();

  _$GGetAllOffersData_getAllOffers _build() {
    final _$result = _$v ??
        new _$GGetAllOffersData_getAllOffers._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GGetAllOffersData_getAllOffers', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GGetAllOffersData_getAllOffers', 'id'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'GGetAllOffersData_getAllOffers', 'title'),
            content: BuiltValueNullFieldError.checkNotNull(
                content, r'GGetAllOffersData_getAllOffers', 'content'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'GGetAllOffersData_getAllOffers', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, r'GGetAllOffersData_getAllOffers', 'updatedAt'));
    replace(_$result);
    return _$result;
  }
}

class _$GGetMessageRoomsData extends GGetMessageRoomsData {
  @override
  final String G__typename;
  @override
  final GGetMessageRoomsData_getMessageRooms getMessageRooms;

  factory _$GGetMessageRoomsData(
          [void Function(GGetMessageRoomsDataBuilder)? updates]) =>
      (new GGetMessageRoomsDataBuilder()..update(updates))._build();

  _$GGetMessageRoomsData._(
      {required this.G__typename, required this.getMessageRooms})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GGetMessageRoomsData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        getMessageRooms, r'GGetMessageRoomsData', 'getMessageRooms');
  }

  @override
  GGetMessageRoomsData rebuild(
          void Function(GGetMessageRoomsDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetMessageRoomsDataBuilder toBuilder() =>
      new GGetMessageRoomsDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetMessageRoomsData &&
        G__typename == other.G__typename &&
        getMessageRooms == other.getMessageRooms;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, getMessageRooms.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetMessageRoomsData')
          ..add('G__typename', G__typename)
          ..add('getMessageRooms', getMessageRooms))
        .toString();
  }
}

class GGetMessageRoomsDataBuilder
    implements Builder<GGetMessageRoomsData, GGetMessageRoomsDataBuilder> {
  _$GGetMessageRoomsData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GGetMessageRoomsData_getMessageRoomsBuilder? _getMessageRooms;
  GGetMessageRoomsData_getMessageRoomsBuilder get getMessageRooms =>
      _$this._getMessageRooms ??=
          new GGetMessageRoomsData_getMessageRoomsBuilder();
  set getMessageRooms(
          GGetMessageRoomsData_getMessageRoomsBuilder? getMessageRooms) =>
      _$this._getMessageRooms = getMessageRooms;

  GGetMessageRoomsDataBuilder() {
    GGetMessageRoomsData._initializeBuilder(this);
  }

  GGetMessageRoomsDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _getMessageRooms = $v.getMessageRooms.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetMessageRoomsData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetMessageRoomsData;
  }

  @override
  void update(void Function(GGetMessageRoomsDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetMessageRoomsData build() => _build();

  _$GGetMessageRoomsData _build() {
    _$GGetMessageRoomsData _$result;
    try {
      _$result = _$v ??
          new _$GGetMessageRoomsData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GGetMessageRoomsData', 'G__typename'),
              getMessageRooms: getMessageRooms.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'getMessageRooms';
        getMessageRooms.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GGetMessageRoomsData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GGetMessageRoomsData_getMessageRooms
    extends GGetMessageRoomsData_getMessageRooms {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String name;
  @override
  final String createdAt;
  @override
  final String updatedAt;

  factory _$GGetMessageRoomsData_getMessageRooms(
          [void Function(GGetMessageRoomsData_getMessageRoomsBuilder)?
              updates]) =>
      (new GGetMessageRoomsData_getMessageRoomsBuilder()..update(updates))
          ._build();

  _$GGetMessageRoomsData_getMessageRooms._(
      {required this.G__typename,
      required this.id,
      required this.name,
      required this.createdAt,
      required this.updatedAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GGetMessageRoomsData_getMessageRooms', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GGetMessageRoomsData_getMessageRooms', 'id');
    BuiltValueNullFieldError.checkNotNull(
        name, r'GGetMessageRoomsData_getMessageRooms', 'name');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'GGetMessageRoomsData_getMessageRooms', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, r'GGetMessageRoomsData_getMessageRooms', 'updatedAt');
  }

  @override
  GGetMessageRoomsData_getMessageRooms rebuild(
          void Function(GGetMessageRoomsData_getMessageRoomsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetMessageRoomsData_getMessageRoomsBuilder toBuilder() =>
      new GGetMessageRoomsData_getMessageRoomsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetMessageRoomsData_getMessageRooms &&
        G__typename == other.G__typename &&
        id == other.id &&
        name == other.name &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetMessageRoomsData_getMessageRooms')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class GGetMessageRoomsData_getMessageRoomsBuilder
    implements
        Builder<GGetMessageRoomsData_getMessageRooms,
            GGetMessageRoomsData_getMessageRoomsBuilder> {
  _$GGetMessageRoomsData_getMessageRooms? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  GGetMessageRoomsData_getMessageRoomsBuilder() {
    GGetMessageRoomsData_getMessageRooms._initializeBuilder(this);
  }

  GGetMessageRoomsData_getMessageRoomsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _name = $v.name;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetMessageRoomsData_getMessageRooms other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetMessageRoomsData_getMessageRooms;
  }

  @override
  void update(
      void Function(GGetMessageRoomsData_getMessageRoomsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetMessageRoomsData_getMessageRooms build() => _build();

  _$GGetMessageRoomsData_getMessageRooms _build() {
    final _$result = _$v ??
        new _$GGetMessageRoomsData_getMessageRooms._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GGetMessageRoomsData_getMessageRooms', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GGetMessageRoomsData_getMessageRooms', 'id'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'GGetMessageRoomsData_getMessageRooms', 'name'),
            createdAt: BuiltValueNullFieldError.checkNotNull(createdAt,
                r'GGetMessageRoomsData_getMessageRooms', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(updatedAt,
                r'GGetMessageRoomsData_getMessageRooms', 'updatedAt'));
    replace(_$result);
    return _$result;
  }
}

class _$GGetMessagesByMessageRoomIdData
    extends GGetMessagesByMessageRoomIdData {
  @override
  final String G__typename;
  @override
  final GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId
      getMessagesByMessageRoomId;

  factory _$GGetMessagesByMessageRoomIdData(
          [void Function(GGetMessagesByMessageRoomIdDataBuilder)? updates]) =>
      (new GGetMessagesByMessageRoomIdDataBuilder()..update(updates))._build();

  _$GGetMessagesByMessageRoomIdData._(
      {required this.G__typename, required this.getMessagesByMessageRoomId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GGetMessagesByMessageRoomIdData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(getMessagesByMessageRoomId,
        r'GGetMessagesByMessageRoomIdData', 'getMessagesByMessageRoomId');
  }

  @override
  GGetMessagesByMessageRoomIdData rebuild(
          void Function(GGetMessagesByMessageRoomIdDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetMessagesByMessageRoomIdDataBuilder toBuilder() =>
      new GGetMessagesByMessageRoomIdDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetMessagesByMessageRoomIdData &&
        G__typename == other.G__typename &&
        getMessagesByMessageRoomId == other.getMessagesByMessageRoomId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, getMessagesByMessageRoomId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetMessagesByMessageRoomIdData')
          ..add('G__typename', G__typename)
          ..add('getMessagesByMessageRoomId', getMessagesByMessageRoomId))
        .toString();
  }
}

class GGetMessagesByMessageRoomIdDataBuilder
    implements
        Builder<GGetMessagesByMessageRoomIdData,
            GGetMessagesByMessageRoomIdDataBuilder> {
  _$GGetMessagesByMessageRoomIdData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomIdBuilder?
      _getMessagesByMessageRoomId;
  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomIdBuilder
      get getMessagesByMessageRoomId => _$this._getMessagesByMessageRoomId ??=
          new GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomIdBuilder();
  set getMessagesByMessageRoomId(
          GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomIdBuilder?
              getMessagesByMessageRoomId) =>
      _$this._getMessagesByMessageRoomId = getMessagesByMessageRoomId;

  GGetMessagesByMessageRoomIdDataBuilder() {
    GGetMessagesByMessageRoomIdData._initializeBuilder(this);
  }

  GGetMessagesByMessageRoomIdDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _getMessagesByMessageRoomId = $v.getMessagesByMessageRoomId.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetMessagesByMessageRoomIdData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetMessagesByMessageRoomIdData;
  }

  @override
  void update(void Function(GGetMessagesByMessageRoomIdDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetMessagesByMessageRoomIdData build() => _build();

  _$GGetMessagesByMessageRoomIdData _build() {
    _$GGetMessagesByMessageRoomIdData _$result;
    try {
      _$result = _$v ??
          new _$GGetMessagesByMessageRoomIdData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                  r'GGetMessagesByMessageRoomIdData', 'G__typename'),
              getMessagesByMessageRoomId: getMessagesByMessageRoomId.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'getMessagesByMessageRoomId';
        getMessagesByMessageRoomId.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GGetMessagesByMessageRoomIdData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId
    extends GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String title;
  @override
  final String content;
  @override
  final String createdAt;
  @override
  final String updatedAt;

  factory _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId(
          [void Function(
                  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomIdBuilder)?
              updates]) =>
      (new GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomIdBuilder()
            ..update(updates))
          ._build();

  _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId._(
      {required this.G__typename,
      required this.id,
      required this.title,
      required this.content,
      required this.createdAt,
      required this.updatedAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename,
        r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId',
        'G__typename');
    BuiltValueNullFieldError.checkNotNull(id,
        r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId', 'id');
    BuiltValueNullFieldError.checkNotNull(title,
        r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId', 'title');
    BuiltValueNullFieldError.checkNotNull(
        content,
        r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId',
        'content');
    BuiltValueNullFieldError.checkNotNull(
        createdAt,
        r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId',
        'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt,
        r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId',
        'updatedAt');
  }

  @override
  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId rebuild(
          void Function(
                  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomIdBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomIdBuilder
      toBuilder() =>
          new GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomIdBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId &&
        G__typename == other.G__typename &&
        id == other.id &&
        title == other.title &&
        content == other.content &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('title', title)
          ..add('content', content)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomIdBuilder
    implements
        Builder<GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId,
            GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomIdBuilder> {
  _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomIdBuilder() {
    GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId
        ._initializeBuilder(this);
  }

  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomIdBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _title = $v.title;
      _content = $v.content;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId;
  }

  @override
  void update(
      void Function(
              GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomIdBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId build() =>
      _build();

  _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId _build() {
    final _$result = _$v ??
        new _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId',
                'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId', 'id'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId', 'title'),
            content: BuiltValueNullFieldError.checkNotNull(
                content, r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId', 'content'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt,
                r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId',
                'updatedAt'));
    replace(_$result);
    return _$result;
  }
}

class _$GGetNotificationsData extends GGetNotificationsData {
  @override
  final String G__typename;
  @override
  final GGetNotificationsData_getNotifications getNotifications;

  factory _$GGetNotificationsData(
          [void Function(GGetNotificationsDataBuilder)? updates]) =>
      (new GGetNotificationsDataBuilder()..update(updates))._build();

  _$GGetNotificationsData._(
      {required this.G__typename, required this.getNotifications})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GGetNotificationsData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        getNotifications, r'GGetNotificationsData', 'getNotifications');
  }

  @override
  GGetNotificationsData rebuild(
          void Function(GGetNotificationsDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetNotificationsDataBuilder toBuilder() =>
      new GGetNotificationsDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetNotificationsData &&
        G__typename == other.G__typename &&
        getNotifications == other.getNotifications;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, getNotifications.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetNotificationsData')
          ..add('G__typename', G__typename)
          ..add('getNotifications', getNotifications))
        .toString();
  }
}

class GGetNotificationsDataBuilder
    implements Builder<GGetNotificationsData, GGetNotificationsDataBuilder> {
  _$GGetNotificationsData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GGetNotificationsData_getNotificationsBuilder? _getNotifications;
  GGetNotificationsData_getNotificationsBuilder get getNotifications =>
      _$this._getNotifications ??=
          new GGetNotificationsData_getNotificationsBuilder();
  set getNotifications(
          GGetNotificationsData_getNotificationsBuilder? getNotifications) =>
      _$this._getNotifications = getNotifications;

  GGetNotificationsDataBuilder() {
    GGetNotificationsData._initializeBuilder(this);
  }

  GGetNotificationsDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _getNotifications = $v.getNotifications.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetNotificationsData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetNotificationsData;
  }

  @override
  void update(void Function(GGetNotificationsDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetNotificationsData build() => _build();

  _$GGetNotificationsData _build() {
    _$GGetNotificationsData _$result;
    try {
      _$result = _$v ??
          new _$GGetNotificationsData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GGetNotificationsData', 'G__typename'),
              getNotifications: getNotifications.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'getNotifications';
        getNotifications.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GGetNotificationsData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GGetNotificationsData_getNotifications
    extends GGetNotificationsData_getNotifications {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String title;
  @override
  final String content;
  @override
  final String createdAt;
  @override
  final String updatedAt;

  factory _$GGetNotificationsData_getNotifications(
          [void Function(GGetNotificationsData_getNotificationsBuilder)?
              updates]) =>
      (new GGetNotificationsData_getNotificationsBuilder()..update(updates))
          ._build();

  _$GGetNotificationsData_getNotifications._(
      {required this.G__typename,
      required this.id,
      required this.title,
      required this.content,
      required this.createdAt,
      required this.updatedAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GGetNotificationsData_getNotifications', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GGetNotificationsData_getNotifications', 'id');
    BuiltValueNullFieldError.checkNotNull(
        title, r'GGetNotificationsData_getNotifications', 'title');
    BuiltValueNullFieldError.checkNotNull(
        content, r'GGetNotificationsData_getNotifications', 'content');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'GGetNotificationsData_getNotifications', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, r'GGetNotificationsData_getNotifications', 'updatedAt');
  }

  @override
  GGetNotificationsData_getNotifications rebuild(
          void Function(GGetNotificationsData_getNotificationsBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetNotificationsData_getNotificationsBuilder toBuilder() =>
      new GGetNotificationsData_getNotificationsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetNotificationsData_getNotifications &&
        G__typename == other.G__typename &&
        id == other.id &&
        title == other.title &&
        content == other.content &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GGetNotificationsData_getNotifications')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('title', title)
          ..add('content', content)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class GGetNotificationsData_getNotificationsBuilder
    implements
        Builder<GGetNotificationsData_getNotifications,
            GGetNotificationsData_getNotificationsBuilder> {
  _$GGetNotificationsData_getNotifications? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  GGetNotificationsData_getNotificationsBuilder() {
    GGetNotificationsData_getNotifications._initializeBuilder(this);
  }

  GGetNotificationsData_getNotificationsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _title = $v.title;
      _content = $v.content;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetNotificationsData_getNotifications other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetNotificationsData_getNotifications;
  }

  @override
  void update(
      void Function(GGetNotificationsData_getNotificationsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetNotificationsData_getNotifications build() => _build();

  _$GGetNotificationsData_getNotifications _build() {
    final _$result = _$v ??
        new _$GGetNotificationsData_getNotifications._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GGetNotificationsData_getNotifications', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GGetNotificationsData_getNotifications', 'id'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'GGetNotificationsData_getNotifications', 'title'),
            content: BuiltValueNullFieldError.checkNotNull(
                content, r'GGetNotificationsData_getNotifications', 'content'),
            createdAt: BuiltValueNullFieldError.checkNotNull(createdAt,
                r'GGetNotificationsData_getNotifications', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(updatedAt,
                r'GGetNotificationsData_getNotifications', 'updatedAt'));
    replace(_$result);
    return _$result;
  }
}

class _$GGetUserDataData extends GGetUserDataData {
  @override
  final String G__typename;
  @override
  final GGetUserDataData_getUserData getUserData;

  factory _$GGetUserDataData(
          [void Function(GGetUserDataDataBuilder)? updates]) =>
      (new GGetUserDataDataBuilder()..update(updates))._build();

  _$GGetUserDataData._({required this.G__typename, required this.getUserData})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GGetUserDataData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        getUserData, r'GGetUserDataData', 'getUserData');
  }

  @override
  GGetUserDataData rebuild(void Function(GGetUserDataDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetUserDataDataBuilder toBuilder() =>
      new GGetUserDataDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetUserDataData &&
        G__typename == other.G__typename &&
        getUserData == other.getUserData;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, getUserData.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetUserDataData')
          ..add('G__typename', G__typename)
          ..add('getUserData', getUserData))
        .toString();
  }
}

class GGetUserDataDataBuilder
    implements Builder<GGetUserDataData, GGetUserDataDataBuilder> {
  _$GGetUserDataData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GGetUserDataData_getUserDataBuilder? _getUserData;
  GGetUserDataData_getUserDataBuilder get getUserData =>
      _$this._getUserData ??= new GGetUserDataData_getUserDataBuilder();
  set getUserData(GGetUserDataData_getUserDataBuilder? getUserData) =>
      _$this._getUserData = getUserData;

  GGetUserDataDataBuilder() {
    GGetUserDataData._initializeBuilder(this);
  }

  GGetUserDataDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _getUserData = $v.getUserData.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetUserDataData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetUserDataData;
  }

  @override
  void update(void Function(GGetUserDataDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetUserDataData build() => _build();

  _$GGetUserDataData _build() {
    _$GGetUserDataData _$result;
    try {
      _$result = _$v ??
          new _$GGetUserDataData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GGetUserDataData', 'G__typename'),
              getUserData: getUserData.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'getUserData';
        getUserData.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GGetUserDataData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GGetUserDataData_getUserData extends GGetUserDataData_getUserData {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String email;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String imageUrl;
  @override
  final String createdAt;
  @override
  final String updatedAt;

  factory _$GGetUserDataData_getUserData(
          [void Function(GGetUserDataData_getUserDataBuilder)? updates]) =>
      (new GGetUserDataData_getUserDataBuilder()..update(updates))._build();

  _$GGetUserDataData_getUserData._(
      {required this.G__typename,
      required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.imageUrl,
      required this.createdAt,
      required this.updatedAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GGetUserDataData_getUserData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GGetUserDataData_getUserData', 'id');
    BuiltValueNullFieldError.checkNotNull(
        email, r'GGetUserDataData_getUserData', 'email');
    BuiltValueNullFieldError.checkNotNull(
        firstName, r'GGetUserDataData_getUserData', 'firstName');
    BuiltValueNullFieldError.checkNotNull(
        lastName, r'GGetUserDataData_getUserData', 'lastName');
    BuiltValueNullFieldError.checkNotNull(
        imageUrl, r'GGetUserDataData_getUserData', 'imageUrl');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'GGetUserDataData_getUserData', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, r'GGetUserDataData_getUserData', 'updatedAt');
  }

  @override
  GGetUserDataData_getUserData rebuild(
          void Function(GGetUserDataData_getUserDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetUserDataData_getUserDataBuilder toBuilder() =>
      new GGetUserDataData_getUserDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetUserDataData_getUserData &&
        G__typename == other.G__typename &&
        id == other.id &&
        email == other.email &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        imageUrl == other.imageUrl &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetUserDataData_getUserData')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('email', email)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('imageUrl', imageUrl)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class GGetUserDataData_getUserDataBuilder
    implements
        Builder<GGetUserDataData_getUserData,
            GGetUserDataData_getUserDataBuilder> {
  _$GGetUserDataData_getUserData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  GGetUserDataData_getUserDataBuilder() {
    GGetUserDataData_getUserData._initializeBuilder(this);
  }

  GGetUserDataData_getUserDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _email = $v.email;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _imageUrl = $v.imageUrl;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetUserDataData_getUserData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetUserDataData_getUserData;
  }

  @override
  void update(void Function(GGetUserDataData_getUserDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetUserDataData_getUserData build() => _build();

  _$GGetUserDataData_getUserData _build() {
    final _$result = _$v ??
        new _$GGetUserDataData_getUserData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GGetUserDataData_getUserData', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GGetUserDataData_getUserData', 'id'),
            email: BuiltValueNullFieldError.checkNotNull(
                email, r'GGetUserDataData_getUserData', 'email'),
            firstName: BuiltValueNullFieldError.checkNotNull(
                firstName, r'GGetUserDataData_getUserData', 'firstName'),
            lastName: BuiltValueNullFieldError.checkNotNull(
                lastName, r'GGetUserDataData_getUserData', 'lastName'),
            imageUrl: BuiltValueNullFieldError.checkNotNull(
                imageUrl, r'GGetUserDataData_getUserData', 'imageUrl'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'GGetUserDataData_getUserData', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, r'GGetUserDataData_getUserData', 'updatedAt'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
