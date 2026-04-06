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
Serializer<GGetUserDataData> _$gGetUserDataDataSerializer =
    new _$GGetUserDataDataSerializer();
Serializer<GGetUserDataData_getUserData>
    _$gGetUserDataDataGetUserDataSerializer =
    new _$GGetUserDataData_getUserDataSerializer();
Serializer<GGetOffersData> _$gGetOffersDataSerializer =
    new _$GGetOffersDataSerializer();
Serializer<GGetOffersData_getOffers> _$gGetOffersDataGetOffersSerializer =
    new _$GGetOffersData_getOffersSerializer();
Serializer<GGetOffersData_getOffers_offerList>
    _$gGetOffersDataGetOffersOfferListSerializer =
    new _$GGetOffersData_getOffers_offerListSerializer();
Serializer<GGetMessageRoomsData> _$gGetMessageRoomsDataSerializer =
    new _$GGetMessageRoomsDataSerializer();
Serializer<GGetMessageRoomsData_getMessageRooms>
    _$gGetMessageRoomsDataGetMessageRoomsSerializer =
    new _$GGetMessageRoomsData_getMessageRoomsSerializer();
Serializer<GGetMessageRoomsData_getMessageRooms_messageRoomList>
    _$gGetMessageRoomsDataGetMessageRoomsMessageRoomListSerializer =
    new _$GGetMessageRoomsData_getMessageRooms_messageRoomListSerializer();
Serializer<GGetMessagesByMessageRoomIdData>
    _$gGetMessagesByMessageRoomIdDataSerializer =
    new _$GGetMessagesByMessageRoomIdDataSerializer();
Serializer<GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId>
    _$gGetMessagesByMessageRoomIdDataGetMessagesByMessageRoomIdSerializer =
    new _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomIdSerializer();
Serializer<GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to>
    _$gGetMessagesByMessageRoomIdDataGetMessagesByMessageRoomIdToSerializer =
    new _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_toSerializer();
Serializer<
        GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList>
    _$gGetMessagesByMessageRoomIdDataGetMessagesByMessageRoomIdMessageListSerializer =
    new _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageListSerializer();
Serializer<GGetNotificationsData> _$gGetNotificationsDataSerializer =
    new _$GGetNotificationsDataSerializer();
Serializer<GGetNotificationsData_getNotifications>
    _$gGetNotificationsDataGetNotificationsSerializer =
    new _$GGetNotificationsData_getNotificationsSerializer();

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
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'realname',
      serializers.serialize(object.realname,
          specifiedType: const FullType(String)),
      'isSuperAdmin',
      serializers.serialize(object.isSuperAdmin,
          specifiedType: const FullType(bool)),
      'fspBalance',
      serializers.serialize(object.fspBalance,
          specifiedType: const FullType(int)),
      'credentialBalance',
      serializers.serialize(object.credentialBalance,
          specifiedType: const FullType(int)),
      'role',
      serializers.serialize(object.role, specifiedType: const FullType(String)),
      'primaryRole',
      serializers.serialize(object.primaryRole,
          specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.imageUrl;
    if (value != null) {
      result
        ..add('imageUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.evmAddr;
    if (value != null) {
      result
        ..add('evmAddr')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.greeting;
    if (value != null) {
      result
        ..add('greeting')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.skill;
    if (value != null) {
      result
        ..add('skill')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.xHandle;
    if (value != null) {
      result
        ..add('xHandle')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.instagramHandle;
    if (value != null) {
      result
        ..add('instagramHandle')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.fbHandle;
    if (value != null) {
      result
        ..add('fbHandle')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.interestOffer;
    if (value != null) {
      result
        ..add('interestOffer')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
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
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'realname':
          result.realname = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'imageUrl':
          result.imageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'isSuperAdmin':
          result.isSuperAdmin = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'fspBalance':
          result.fspBalance = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'credentialBalance':
          result.credentialBalance = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'evmAddr':
          result.evmAddr = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'role':
          result.role = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'primaryRole':
          result.primaryRole = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'greeting':
          result.greeting = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'skill':
          result.skill = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'xHandle':
          result.xHandle = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'instagramHandle':
          result.instagramHandle = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'fbHandle':
          result.fbHandle = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'interestOffer':
          result.interestOffer = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetOffersDataSerializer
    implements StructuredSerializer<GGetOffersData> {
  @override
  final Iterable<Type> types = const [GGetOffersData, _$GGetOffersData];
  @override
  final String wireName = 'GGetOffersData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GGetOffersData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'getOffers',
      serializers.serialize(object.getOffers,
          specifiedType: const FullType(GGetOffersData_getOffers)),
    ];

    return result;
  }

  @override
  GGetOffersData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GGetOffersDataBuilder();

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
        case 'getOffers':
          result.getOffers.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GGetOffersData_getOffers))!
              as GGetOffersData_getOffers);
          break;
      }
    }

    return result.build();
  }
}

class _$GGetOffersData_getOffersSerializer
    implements StructuredSerializer<GGetOffersData_getOffers> {
  @override
  final Iterable<Type> types = const [
    GGetOffersData_getOffers,
    _$GGetOffersData_getOffers
  ];
  @override
  final String wireName = 'GGetOffersData_getOffers';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GGetOffersData_getOffers object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'offerList',
      serializers.serialize(object.offerList,
          specifiedType: const FullType(BuiltList,
              const [const FullType(GGetOffersData_getOffers_offerList)])),
    ];

    return result;
  }

  @override
  GGetOffersData_getOffers deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GGetOffersData_getOffersBuilder();

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
        case 'offerList':
          result.offerList.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GGetOffersData_getOffers_offerList)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GGetOffersData_getOffers_offerListSerializer
    implements StructuredSerializer<GGetOffersData_getOffers_offerList> {
  @override
  final Iterable<Type> types = const [
    GGetOffersData_getOffers_offerList,
    _$GGetOffersData_getOffers_offerList
  ];
  @override
  final String wireName = 'GGetOffersData_getOffers_offerList';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GGetOffersData_getOffers_offerList object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'fee',
      serializers.serialize(object.fee, specifiedType: const FullType(int)),
      'place',
      serializers.serialize(object.place,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.imageUrl;
    if (value != null) {
      result
        ..add('imageUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.category;
    if (value != null) {
      result
        ..add('category')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GGetOffersData_getOffers_offerList deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GGetOffersData_getOffers_offerListBuilder();

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
              specifiedType: const FullType(int))! as int;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'imageUrl':
          result.imageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'fee':
          result.fee = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'category':
          result.category = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'place':
          result.place = serializers.deserialize(value,
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
      'messageRoomList',
      serializers.serialize(object.messageRoomList,
          specifiedType: const FullType(BuiltList, const [
            const FullType(GGetMessageRoomsData_getMessageRooms_messageRoomList)
          ])),
      'countOfMessageRooms',
      serializers.serialize(object.countOfMessageRooms,
          specifiedType: const FullType(int)),
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
        case 'messageRoomList':
          result.messageRoomList.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    GGetMessageRoomsData_getMessageRooms_messageRoomList)
              ]))! as BuiltList<Object?>);
          break;
        case 'countOfMessageRooms':
          result.countOfMessageRooms = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetMessageRoomsData_getMessageRooms_messageRoomListSerializer
    implements
        StructuredSerializer<
            GGetMessageRoomsData_getMessageRooms_messageRoomList> {
  @override
  final Iterable<Type> types = const [
    GGetMessageRoomsData_getMessageRooms_messageRoomList,
    _$GGetMessageRoomsData_getMessageRooms_messageRoomList
  ];
  @override
  final String wireName =
      'GGetMessageRoomsData_getMessageRooms_messageRoomList';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GGetMessageRoomsData_getMessageRooms_messageRoomList object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'isRead',
      serializers.serialize(object.isRead, specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.category;
    if (value != null) {
      result
        ..add('category')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.latestMessage;
    if (value != null) {
      result
        ..add('latestMessage')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.latestMessageId;
    if (value != null) {
      result
        ..add('latestMessageId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.latestSentAt;
    if (value != null) {
      result
        ..add('latestSentAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GGetMessageRoomsData_getMessageRooms_messageRoomList deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GGetMessageRoomsData_getMessageRooms_messageRoomListBuilder();

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
        case 'category':
          result.category = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'latestMessage':
          result.latestMessage = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'latestMessageId':
          result.latestMessageId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'latestSentAt':
          result.latestSentAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'isRead':
          result.isRead = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
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
      'to',
      serializers.serialize(object.to,
          specifiedType: const FullType(
              GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to)),
      'messageList',
      serializers.serialize(object.messageList,
          specifiedType: const FullType(BuiltList, const [
            const FullType(
                GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList)
          ])),
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
        case 'to':
          result.to.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to))!
              as GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to);
          break;
        case 'messageList':
          result.messageList.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_toSerializer
    implements
        StructuredSerializer<
            GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to> {
  @override
  final Iterable<Type> types = const [
    GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to,
    _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to
  ];
  @override
  final String wireName =
      'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'realname',
      serializers.serialize(object.realname,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.imageUrl;
    if (value != null) {
      result
        ..add('imageUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_toBuilder();

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
        case 'realname':
          result.realname = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'imageUrl':
          result.imageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageListSerializer
    implements
        StructuredSerializer<
            GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList> {
  @override
  final Iterable<Type> types = const [
    GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList,
    _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList
  ];
  @override
  final String wireName =
      'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList';

  @override
  Iterable<Object?> serialize(
      Serializers serializers,
      GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList
          object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'content',
      serializers.serialize(object.content,
          specifiedType: const FullType(String)),
      'sentBy',
      serializers.serialize(object.sentBy,
          specifiedType: const FullType(String)),
      'sentAt',
      serializers.serialize(object.sentAt,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.attachedFile;
    if (value != null) {
      result
        ..add('attachedFile')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.attachedImg;
    if (value != null) {
      result
        ..add('attachedImg')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList
      deserialize(Serializers serializers, Iterable<Object?> serialized,
          {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageListBuilder();

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
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'sentBy':
          result.sentBy = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'sentAt':
          result.sentAt = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'attachedFile':
          result.attachedFile = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'attachedImg':
          result.attachedImg = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
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
          specifiedType: const FullType(BuiltList,
              const [const FullType(GGetNotificationsData_getNotifications)])),
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
              specifiedType: const FullType(BuiltList, const [
                const FullType(GGetNotificationsData_getNotifications)
              ]))! as BuiltList<Object?>);
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
      'isRead',
      serializers.serialize(object.isRead, specifiedType: const FullType(bool)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.category;
    if (value != null) {
      result
        ..add('category')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
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
        case 'category':
          result.category = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'isRead':
          result.isRead = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
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
  final String name;
  @override
  final String email;
  @override
  final String realname;
  @override
  final String? imageUrl;
  @override
  final bool isSuperAdmin;
  @override
  final int fspBalance;
  @override
  final int credentialBalance;
  @override
  final String? evmAddr;
  @override
  final String role;
  @override
  final String primaryRole;
  @override
  final String? greeting;
  @override
  final String? skill;
  @override
  final String? xHandle;
  @override
  final String? instagramHandle;
  @override
  final String? fbHandle;
  @override
  final String? interestOffer;
  @override
  final String createdAt;

  factory _$GGetUserDataData_getUserData(
          [void Function(GGetUserDataData_getUserDataBuilder)? updates]) =>
      (new GGetUserDataData_getUserDataBuilder()..update(updates))._build();

  _$GGetUserDataData_getUserData._(
      {required this.G__typename,
      required this.id,
      required this.name,
      required this.email,
      required this.realname,
      this.imageUrl,
      required this.isSuperAdmin,
      required this.fspBalance,
      required this.credentialBalance,
      this.evmAddr,
      required this.role,
      required this.primaryRole,
      this.greeting,
      this.skill,
      this.xHandle,
      this.instagramHandle,
      this.fbHandle,
      this.interestOffer,
      required this.createdAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GGetUserDataData_getUserData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GGetUserDataData_getUserData', 'id');
    BuiltValueNullFieldError.checkNotNull(
        name, r'GGetUserDataData_getUserData', 'name');
    BuiltValueNullFieldError.checkNotNull(
        email, r'GGetUserDataData_getUserData', 'email');
    BuiltValueNullFieldError.checkNotNull(
        realname, r'GGetUserDataData_getUserData', 'realname');
    BuiltValueNullFieldError.checkNotNull(
        isSuperAdmin, r'GGetUserDataData_getUserData', 'isSuperAdmin');
    BuiltValueNullFieldError.checkNotNull(
        fspBalance, r'GGetUserDataData_getUserData', 'fspBalance');
    BuiltValueNullFieldError.checkNotNull(credentialBalance,
        r'GGetUserDataData_getUserData', 'credentialBalance');
    BuiltValueNullFieldError.checkNotNull(
        role, r'GGetUserDataData_getUserData', 'role');
    BuiltValueNullFieldError.checkNotNull(
        primaryRole, r'GGetUserDataData_getUserData', 'primaryRole');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'GGetUserDataData_getUserData', 'createdAt');
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
        name == other.name &&
        email == other.email &&
        realname == other.realname &&
        imageUrl == other.imageUrl &&
        isSuperAdmin == other.isSuperAdmin &&
        fspBalance == other.fspBalance &&
        credentialBalance == other.credentialBalance &&
        evmAddr == other.evmAddr &&
        role == other.role &&
        primaryRole == other.primaryRole &&
        greeting == other.greeting &&
        skill == other.skill &&
        xHandle == other.xHandle &&
        instagramHandle == other.instagramHandle &&
        fbHandle == other.fbHandle &&
        interestOffer == other.interestOffer &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, realname.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jc(_$hash, isSuperAdmin.hashCode);
    _$hash = $jc(_$hash, fspBalance.hashCode);
    _$hash = $jc(_$hash, credentialBalance.hashCode);
    _$hash = $jc(_$hash, evmAddr.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, primaryRole.hashCode);
    _$hash = $jc(_$hash, greeting.hashCode);
    _$hash = $jc(_$hash, skill.hashCode);
    _$hash = $jc(_$hash, xHandle.hashCode);
    _$hash = $jc(_$hash, instagramHandle.hashCode);
    _$hash = $jc(_$hash, fbHandle.hashCode);
    _$hash = $jc(_$hash, interestOffer.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetUserDataData_getUserData')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name)
          ..add('email', email)
          ..add('realname', realname)
          ..add('imageUrl', imageUrl)
          ..add('isSuperAdmin', isSuperAdmin)
          ..add('fspBalance', fspBalance)
          ..add('credentialBalance', credentialBalance)
          ..add('evmAddr', evmAddr)
          ..add('role', role)
          ..add('primaryRole', primaryRole)
          ..add('greeting', greeting)
          ..add('skill', skill)
          ..add('xHandle', xHandle)
          ..add('instagramHandle', instagramHandle)
          ..add('fbHandle', fbHandle)
          ..add('interestOffer', interestOffer)
          ..add('createdAt', createdAt))
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

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _realname;
  String? get realname => _$this._realname;
  set realname(String? realname) => _$this._realname = realname;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  bool? _isSuperAdmin;
  bool? get isSuperAdmin => _$this._isSuperAdmin;
  set isSuperAdmin(bool? isSuperAdmin) => _$this._isSuperAdmin = isSuperAdmin;

  int? _fspBalance;
  int? get fspBalance => _$this._fspBalance;
  set fspBalance(int? fspBalance) => _$this._fspBalance = fspBalance;

  int? _credentialBalance;
  int? get credentialBalance => _$this._credentialBalance;
  set credentialBalance(int? credentialBalance) =>
      _$this._credentialBalance = credentialBalance;

  String? _evmAddr;
  String? get evmAddr => _$this._evmAddr;
  set evmAddr(String? evmAddr) => _$this._evmAddr = evmAddr;

  String? _role;
  String? get role => _$this._role;
  set role(String? role) => _$this._role = role;

  String? _primaryRole;
  String? get primaryRole => _$this._primaryRole;
  set primaryRole(String? primaryRole) => _$this._primaryRole = primaryRole;

  String? _greeting;
  String? get greeting => _$this._greeting;
  set greeting(String? greeting) => _$this._greeting = greeting;

  String? _skill;
  String? get skill => _$this._skill;
  set skill(String? skill) => _$this._skill = skill;

  String? _xHandle;
  String? get xHandle => _$this._xHandle;
  set xHandle(String? xHandle) => _$this._xHandle = xHandle;

  String? _instagramHandle;
  String? get instagramHandle => _$this._instagramHandle;
  set instagramHandle(String? instagramHandle) =>
      _$this._instagramHandle = instagramHandle;

  String? _fbHandle;
  String? get fbHandle => _$this._fbHandle;
  set fbHandle(String? fbHandle) => _$this._fbHandle = fbHandle;

  String? _interestOffer;
  String? get interestOffer => _$this._interestOffer;
  set interestOffer(String? interestOffer) =>
      _$this._interestOffer = interestOffer;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  GGetUserDataData_getUserDataBuilder() {
    GGetUserDataData_getUserData._initializeBuilder(this);
  }

  GGetUserDataData_getUserDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _name = $v.name;
      _email = $v.email;
      _realname = $v.realname;
      _imageUrl = $v.imageUrl;
      _isSuperAdmin = $v.isSuperAdmin;
      _fspBalance = $v.fspBalance;
      _credentialBalance = $v.credentialBalance;
      _evmAddr = $v.evmAddr;
      _role = $v.role;
      _primaryRole = $v.primaryRole;
      _greeting = $v.greeting;
      _skill = $v.skill;
      _xHandle = $v.xHandle;
      _instagramHandle = $v.instagramHandle;
      _fbHandle = $v.fbHandle;
      _interestOffer = $v.interestOffer;
      _createdAt = $v.createdAt;
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
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'GGetUserDataData_getUserData', 'name'),
            email: BuiltValueNullFieldError.checkNotNull(
                email, r'GGetUserDataData_getUserData', 'email'),
            realname: BuiltValueNullFieldError.checkNotNull(
                realname, r'GGetUserDataData_getUserData', 'realname'),
            imageUrl: imageUrl,
            isSuperAdmin: BuiltValueNullFieldError.checkNotNull(
                isSuperAdmin, r'GGetUserDataData_getUserData', 'isSuperAdmin'),
            fspBalance: BuiltValueNullFieldError.checkNotNull(
                fspBalance, r'GGetUserDataData_getUserData', 'fspBalance'),
            credentialBalance: BuiltValueNullFieldError.checkNotNull(
                credentialBalance, r'GGetUserDataData_getUserData', 'credentialBalance'),
            evmAddr: evmAddr,
            role: BuiltValueNullFieldError.checkNotNull(role, r'GGetUserDataData_getUserData', 'role'),
            primaryRole: BuiltValueNullFieldError.checkNotNull(primaryRole, r'GGetUserDataData_getUserData', 'primaryRole'),
            greeting: greeting,
            skill: skill,
            xHandle: xHandle,
            instagramHandle: instagramHandle,
            fbHandle: fbHandle,
            interestOffer: interestOffer,
            createdAt: BuiltValueNullFieldError.checkNotNull(createdAt, r'GGetUserDataData_getUserData', 'createdAt'));
    replace(_$result);
    return _$result;
  }
}

class _$GGetOffersData extends GGetOffersData {
  @override
  final String G__typename;
  @override
  final GGetOffersData_getOffers getOffers;

  factory _$GGetOffersData([void Function(GGetOffersDataBuilder)? updates]) =>
      (new GGetOffersDataBuilder()..update(updates))._build();

  _$GGetOffersData._({required this.G__typename, required this.getOffers})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GGetOffersData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        getOffers, r'GGetOffersData', 'getOffers');
  }

  @override
  GGetOffersData rebuild(void Function(GGetOffersDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetOffersDataBuilder toBuilder() =>
      new GGetOffersDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetOffersData &&
        G__typename == other.G__typename &&
        getOffers == other.getOffers;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, getOffers.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetOffersData')
          ..add('G__typename', G__typename)
          ..add('getOffers', getOffers))
        .toString();
  }
}

class GGetOffersDataBuilder
    implements Builder<GGetOffersData, GGetOffersDataBuilder> {
  _$GGetOffersData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GGetOffersData_getOffersBuilder? _getOffers;
  GGetOffersData_getOffersBuilder get getOffers =>
      _$this._getOffers ??= new GGetOffersData_getOffersBuilder();
  set getOffers(GGetOffersData_getOffersBuilder? getOffers) =>
      _$this._getOffers = getOffers;

  GGetOffersDataBuilder() {
    GGetOffersData._initializeBuilder(this);
  }

  GGetOffersDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _getOffers = $v.getOffers.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetOffersData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetOffersData;
  }

  @override
  void update(void Function(GGetOffersDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetOffersData build() => _build();

  _$GGetOffersData _build() {
    _$GGetOffersData _$result;
    try {
      _$result = _$v ??
          new _$GGetOffersData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GGetOffersData', 'G__typename'),
              getOffers: getOffers.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'getOffers';
        getOffers.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GGetOffersData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GGetOffersData_getOffers extends GGetOffersData_getOffers {
  @override
  final String G__typename;
  @override
  final BuiltList<GGetOffersData_getOffers_offerList> offerList;

  factory _$GGetOffersData_getOffers(
          [void Function(GGetOffersData_getOffersBuilder)? updates]) =>
      (new GGetOffersData_getOffersBuilder()..update(updates))._build();

  _$GGetOffersData_getOffers._(
      {required this.G__typename, required this.offerList})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GGetOffersData_getOffers', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        offerList, r'GGetOffersData_getOffers', 'offerList');
  }

  @override
  GGetOffersData_getOffers rebuild(
          void Function(GGetOffersData_getOffersBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetOffersData_getOffersBuilder toBuilder() =>
      new GGetOffersData_getOffersBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetOffersData_getOffers &&
        G__typename == other.G__typename &&
        offerList == other.offerList;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, offerList.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetOffersData_getOffers')
          ..add('G__typename', G__typename)
          ..add('offerList', offerList))
        .toString();
  }
}

class GGetOffersData_getOffersBuilder
    implements
        Builder<GGetOffersData_getOffers, GGetOffersData_getOffersBuilder> {
  _$GGetOffersData_getOffers? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GGetOffersData_getOffers_offerList>? _offerList;
  ListBuilder<GGetOffersData_getOffers_offerList> get offerList =>
      _$this._offerList ??=
          new ListBuilder<GGetOffersData_getOffers_offerList>();
  set offerList(ListBuilder<GGetOffersData_getOffers_offerList>? offerList) =>
      _$this._offerList = offerList;

  GGetOffersData_getOffersBuilder() {
    GGetOffersData_getOffers._initializeBuilder(this);
  }

  GGetOffersData_getOffersBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _offerList = $v.offerList.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetOffersData_getOffers other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetOffersData_getOffers;
  }

  @override
  void update(void Function(GGetOffersData_getOffersBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetOffersData_getOffers build() => _build();

  _$GGetOffersData_getOffers _build() {
    _$GGetOffersData_getOffers _$result;
    try {
      _$result = _$v ??
          new _$GGetOffersData_getOffers._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GGetOffersData_getOffers', 'G__typename'),
              offerList: offerList.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'offerList';
        offerList.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GGetOffersData_getOffers', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GGetOffersData_getOffers_offerList
    extends GGetOffersData_getOffers_offerList {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String? imageUrl;
  @override
  final int fee;
  @override
  final String? category;
  @override
  final String place;

  factory _$GGetOffersData_getOffers_offerList(
          [void Function(GGetOffersData_getOffers_offerListBuilder)?
              updates]) =>
      (new GGetOffersData_getOffers_offerListBuilder()..update(updates))
          ._build();

  _$GGetOffersData_getOffers_offerList._(
      {required this.G__typename,
      required this.id,
      required this.title,
      required this.description,
      this.imageUrl,
      required this.fee,
      this.category,
      required this.place})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GGetOffersData_getOffers_offerList', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GGetOffersData_getOffers_offerList', 'id');
    BuiltValueNullFieldError.checkNotNull(
        title, r'GGetOffersData_getOffers_offerList', 'title');
    BuiltValueNullFieldError.checkNotNull(
        description, r'GGetOffersData_getOffers_offerList', 'description');
    BuiltValueNullFieldError.checkNotNull(
        fee, r'GGetOffersData_getOffers_offerList', 'fee');
    BuiltValueNullFieldError.checkNotNull(
        place, r'GGetOffersData_getOffers_offerList', 'place');
  }

  @override
  GGetOffersData_getOffers_offerList rebuild(
          void Function(GGetOffersData_getOffers_offerListBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetOffersData_getOffers_offerListBuilder toBuilder() =>
      new GGetOffersData_getOffers_offerListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetOffersData_getOffers_offerList &&
        G__typename == other.G__typename &&
        id == other.id &&
        title == other.title &&
        description == other.description &&
        imageUrl == other.imageUrl &&
        fee == other.fee &&
        category == other.category &&
        place == other.place;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jc(_$hash, fee.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, place.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetOffersData_getOffers_offerList')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('title', title)
          ..add('description', description)
          ..add('imageUrl', imageUrl)
          ..add('fee', fee)
          ..add('category', category)
          ..add('place', place))
        .toString();
  }
}

class GGetOffersData_getOffers_offerListBuilder
    implements
        Builder<GGetOffersData_getOffers_offerList,
            GGetOffersData_getOffers_offerListBuilder> {
  _$GGetOffersData_getOffers_offerList? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  int? _fee;
  int? get fee => _$this._fee;
  set fee(int? fee) => _$this._fee = fee;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  String? _place;
  String? get place => _$this._place;
  set place(String? place) => _$this._place = place;

  GGetOffersData_getOffers_offerListBuilder() {
    GGetOffersData_getOffers_offerList._initializeBuilder(this);
  }

  GGetOffersData_getOffers_offerListBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _title = $v.title;
      _description = $v.description;
      _imageUrl = $v.imageUrl;
      _fee = $v.fee;
      _category = $v.category;
      _place = $v.place;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetOffersData_getOffers_offerList other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetOffersData_getOffers_offerList;
  }

  @override
  void update(
      void Function(GGetOffersData_getOffers_offerListBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetOffersData_getOffers_offerList build() => _build();

  _$GGetOffersData_getOffers_offerList _build() {
    final _$result = _$v ??
        new _$GGetOffersData_getOffers_offerList._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GGetOffersData_getOffers_offerList', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GGetOffersData_getOffers_offerList', 'id'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'GGetOffersData_getOffers_offerList', 'title'),
            description: BuiltValueNullFieldError.checkNotNull(description,
                r'GGetOffersData_getOffers_offerList', 'description'),
            imageUrl: imageUrl,
            fee: BuiltValueNullFieldError.checkNotNull(
                fee, r'GGetOffersData_getOffers_offerList', 'fee'),
            category: category,
            place: BuiltValueNullFieldError.checkNotNull(
                place, r'GGetOffersData_getOffers_offerList', 'place'));
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
  final BuiltList<GGetMessageRoomsData_getMessageRooms_messageRoomList>
      messageRoomList;
  @override
  final int countOfMessageRooms;

  factory _$GGetMessageRoomsData_getMessageRooms(
          [void Function(GGetMessageRoomsData_getMessageRoomsBuilder)?
              updates]) =>
      (new GGetMessageRoomsData_getMessageRoomsBuilder()..update(updates))
          ._build();

  _$GGetMessageRoomsData_getMessageRooms._(
      {required this.G__typename,
      required this.messageRoomList,
      required this.countOfMessageRooms})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GGetMessageRoomsData_getMessageRooms', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(messageRoomList,
        r'GGetMessageRoomsData_getMessageRooms', 'messageRoomList');
    BuiltValueNullFieldError.checkNotNull(countOfMessageRooms,
        r'GGetMessageRoomsData_getMessageRooms', 'countOfMessageRooms');
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
        messageRoomList == other.messageRoomList &&
        countOfMessageRooms == other.countOfMessageRooms;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, messageRoomList.hashCode);
    _$hash = $jc(_$hash, countOfMessageRooms.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetMessageRoomsData_getMessageRooms')
          ..add('G__typename', G__typename)
          ..add('messageRoomList', messageRoomList)
          ..add('countOfMessageRooms', countOfMessageRooms))
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

  ListBuilder<GGetMessageRoomsData_getMessageRooms_messageRoomList>?
      _messageRoomList;
  ListBuilder<GGetMessageRoomsData_getMessageRooms_messageRoomList>
      get messageRoomList => _$this._messageRoomList ??= new ListBuilder<
          GGetMessageRoomsData_getMessageRooms_messageRoomList>();
  set messageRoomList(
          ListBuilder<GGetMessageRoomsData_getMessageRooms_messageRoomList>?
              messageRoomList) =>
      _$this._messageRoomList = messageRoomList;

  int? _countOfMessageRooms;
  int? get countOfMessageRooms => _$this._countOfMessageRooms;
  set countOfMessageRooms(int? countOfMessageRooms) =>
      _$this._countOfMessageRooms = countOfMessageRooms;

  GGetMessageRoomsData_getMessageRoomsBuilder() {
    GGetMessageRoomsData_getMessageRooms._initializeBuilder(this);
  }

  GGetMessageRoomsData_getMessageRoomsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _messageRoomList = $v.messageRoomList.toBuilder();
      _countOfMessageRooms = $v.countOfMessageRooms;
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
    _$GGetMessageRoomsData_getMessageRooms _$result;
    try {
      _$result = _$v ??
          new _$GGetMessageRoomsData_getMessageRooms._(
              G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                  r'GGetMessageRoomsData_getMessageRooms', 'G__typename'),
              messageRoomList: messageRoomList.build(),
              countOfMessageRooms: BuiltValueNullFieldError.checkNotNull(
                  countOfMessageRooms,
                  r'GGetMessageRoomsData_getMessageRooms',
                  'countOfMessageRooms'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'messageRoomList';
        messageRoomList.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GGetMessageRoomsData_getMessageRooms',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GGetMessageRoomsData_getMessageRooms_messageRoomList
    extends GGetMessageRoomsData_getMessageRooms_messageRoomList {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String? category;
  @override
  final String? latestMessage;
  @override
  final String? latestMessageId;
  @override
  final String? latestSentAt;
  @override
  final bool isRead;

  factory _$GGetMessageRoomsData_getMessageRooms_messageRoomList(
          [void Function(
                  GGetMessageRoomsData_getMessageRooms_messageRoomListBuilder)?
              updates]) =>
      (new GGetMessageRoomsData_getMessageRooms_messageRoomListBuilder()
            ..update(updates))
          ._build();

  _$GGetMessageRoomsData_getMessageRooms_messageRoomList._(
      {required this.G__typename,
      required this.id,
      this.category,
      this.latestMessage,
      this.latestMessageId,
      this.latestSentAt,
      required this.isRead})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(G__typename,
        r'GGetMessageRoomsData_getMessageRooms_messageRoomList', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GGetMessageRoomsData_getMessageRooms_messageRoomList', 'id');
    BuiltValueNullFieldError.checkNotNull(isRead,
        r'GGetMessageRoomsData_getMessageRooms_messageRoomList', 'isRead');
  }

  @override
  GGetMessageRoomsData_getMessageRooms_messageRoomList rebuild(
          void Function(
                  GGetMessageRoomsData_getMessageRooms_messageRoomListBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetMessageRoomsData_getMessageRooms_messageRoomListBuilder toBuilder() =>
      new GGetMessageRoomsData_getMessageRooms_messageRoomListBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetMessageRoomsData_getMessageRooms_messageRoomList &&
        G__typename == other.G__typename &&
        id == other.id &&
        category == other.category &&
        latestMessage == other.latestMessage &&
        latestMessageId == other.latestMessageId &&
        latestSentAt == other.latestSentAt &&
        isRead == other.isRead;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, latestMessage.hashCode);
    _$hash = $jc(_$hash, latestMessageId.hashCode);
    _$hash = $jc(_$hash, latestSentAt.hashCode);
    _$hash = $jc(_$hash, isRead.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GGetMessageRoomsData_getMessageRooms_messageRoomList')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('category', category)
          ..add('latestMessage', latestMessage)
          ..add('latestMessageId', latestMessageId)
          ..add('latestSentAt', latestSentAt)
          ..add('isRead', isRead))
        .toString();
  }
}

class GGetMessageRoomsData_getMessageRooms_messageRoomListBuilder
    implements
        Builder<GGetMessageRoomsData_getMessageRooms_messageRoomList,
            GGetMessageRoomsData_getMessageRooms_messageRoomListBuilder> {
  _$GGetMessageRoomsData_getMessageRooms_messageRoomList? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  String? _latestMessage;
  String? get latestMessage => _$this._latestMessage;
  set latestMessage(String? latestMessage) =>
      _$this._latestMessage = latestMessage;

  String? _latestMessageId;
  String? get latestMessageId => _$this._latestMessageId;
  set latestMessageId(String? latestMessageId) =>
      _$this._latestMessageId = latestMessageId;

  String? _latestSentAt;
  String? get latestSentAt => _$this._latestSentAt;
  set latestSentAt(String? latestSentAt) => _$this._latestSentAt = latestSentAt;

  bool? _isRead;
  bool? get isRead => _$this._isRead;
  set isRead(bool? isRead) => _$this._isRead = isRead;

  GGetMessageRoomsData_getMessageRooms_messageRoomListBuilder() {
    GGetMessageRoomsData_getMessageRooms_messageRoomList._initializeBuilder(
        this);
  }

  GGetMessageRoomsData_getMessageRooms_messageRoomListBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _category = $v.category;
      _latestMessage = $v.latestMessage;
      _latestMessageId = $v.latestMessageId;
      _latestSentAt = $v.latestSentAt;
      _isRead = $v.isRead;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetMessageRoomsData_getMessageRooms_messageRoomList other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetMessageRoomsData_getMessageRooms_messageRoomList;
  }

  @override
  void update(
      void Function(
              GGetMessageRoomsData_getMessageRooms_messageRoomListBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetMessageRoomsData_getMessageRooms_messageRoomList build() => _build();

  _$GGetMessageRoomsData_getMessageRooms_messageRoomList _build() {
    final _$result = _$v ??
        new _$GGetMessageRoomsData_getMessageRooms_messageRoomList._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GGetMessageRoomsData_getMessageRooms_messageRoomList',
                'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(id,
                r'GGetMessageRoomsData_getMessageRooms_messageRoomList', 'id'),
            category: category,
            latestMessage: latestMessage,
            latestMessageId: latestMessageId,
            latestSentAt: latestSentAt,
            isRead: BuiltValueNullFieldError.checkNotNull(
                isRead,
                r'GGetMessageRoomsData_getMessageRooms_messageRoomList',
                'isRead'));
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
  final GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to to;
  @override
  final BuiltList<
          GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList>
      messageList;

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
      required this.to,
      required this.messageList})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename,
        r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId',
        'G__typename');
    BuiltValueNullFieldError.checkNotNull(id,
        r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId', 'id');
    BuiltValueNullFieldError.checkNotNull(to,
        r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId', 'to');
    BuiltValueNullFieldError.checkNotNull(
        messageList,
        r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId',
        'messageList');
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
        to == other.to &&
        messageList == other.messageList;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, to.hashCode);
    _$hash = $jc(_$hash, messageList.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('to', to)
          ..add('messageList', messageList))
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

  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_toBuilder? _to;
  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_toBuilder get to =>
      _$this._to ??=
          new GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_toBuilder();
  set to(
          GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_toBuilder?
              to) =>
      _$this._to = to;

  ListBuilder<
          GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList>?
      _messageList;
  ListBuilder<
          GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList>
      get messageList => _$this._messageList ??= new ListBuilder<
          GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList>();
  set messageList(
          ListBuilder<
                  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList>?
              messageList) =>
      _$this._messageList = messageList;

  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomIdBuilder() {
    GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId
        ._initializeBuilder(this);
  }

  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomIdBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _to = $v.to.toBuilder();
      _messageList = $v.messageList.toBuilder();
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
    _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId _$result;
    try {
      _$result = _$v ??
          new _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename,
                  r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId',
                  'G__typename'),
              id: BuiltValueNullFieldError.checkNotNull(
                  id,
                  r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId',
                  'id'),
              to: to.build(),
              messageList: messageList.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'to';
        to.build();
        _$failedField = 'messageList';
        messageList.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to
    extends GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String name;
  @override
  final String realname;
  @override
  final String? imageUrl;

  factory _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to(
          [void Function(
                  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_toBuilder)?
              updates]) =>
      (new GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_toBuilder()
            ..update(updates))
          ._build();

  _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to._(
      {required this.G__typename,
      required this.id,
      required this.name,
      required this.realname,
      this.imageUrl})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename,
        r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to',
        'G__typename');
    BuiltValueNullFieldError.checkNotNull(id,
        r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to', 'id');
    BuiltValueNullFieldError.checkNotNull(
        name,
        r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to',
        'name');
    BuiltValueNullFieldError.checkNotNull(
        realname,
        r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to',
        'realname');
  }

  @override
  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to rebuild(
          void Function(
                  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_toBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_toBuilder
      toBuilder() =>
          new GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_toBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to &&
        G__typename == other.G__typename &&
        id == other.id &&
        name == other.name &&
        realname == other.realname &&
        imageUrl == other.imageUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, realname.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name)
          ..add('realname', realname)
          ..add('imageUrl', imageUrl))
        .toString();
  }
}

class GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_toBuilder
    implements
        Builder<GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to,
            GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_toBuilder> {
  _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _realname;
  String? get realname => _$this._realname;
  set realname(String? realname) => _$this._realname = realname;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_toBuilder() {
    GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to
        ._initializeBuilder(this);
  }

  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_toBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _name = $v.name;
      _realname = $v.realname;
      _imageUrl = $v.imageUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other
        as _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to;
  }

  @override
  void update(
      void Function(
              GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_toBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to build() =>
      _build();

  _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to _build() {
    final _$result = _$v ??
        new _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id,
                r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to',
                'id'),
            name: BuiltValueNullFieldError.checkNotNull(
                name,
                r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to',
                'name'),
            realname: BuiltValueNullFieldError.checkNotNull(
                realname,
                r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to',
                'realname'),
            imageUrl: imageUrl);
    replace(_$result);
    return _$result;
  }
}

class _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList
    extends GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String content;
  @override
  final String sentBy;
  @override
  final String sentAt;
  @override
  final String? attachedFile;
  @override
  final String? attachedImg;

  factory _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList(
          [void Function(
                  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageListBuilder)?
              updates]) =>
      (new GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageListBuilder()
            ..update(updates))
          ._build();

  _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList._(
      {required this.G__typename,
      required this.id,
      required this.content,
      required this.sentBy,
      required this.sentAt,
      this.attachedFile,
      this.attachedImg})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename,
        r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList',
        'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id,
        r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList',
        'id');
    BuiltValueNullFieldError.checkNotNull(
        content,
        r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList',
        'content');
    BuiltValueNullFieldError.checkNotNull(
        sentBy,
        r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList',
        'sentBy');
    BuiltValueNullFieldError.checkNotNull(
        sentAt,
        r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList',
        'sentAt');
  }

  @override
  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList rebuild(
          void Function(
                  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageListBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageListBuilder
      toBuilder() =>
          new GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageListBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList &&
        G__typename == other.G__typename &&
        id == other.id &&
        content == other.content &&
        sentBy == other.sentBy &&
        sentAt == other.sentAt &&
        attachedFile == other.attachedFile &&
        attachedImg == other.attachedImg;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, sentBy.hashCode);
    _$hash = $jc(_$hash, sentAt.hashCode);
    _$hash = $jc(_$hash, attachedFile.hashCode);
    _$hash = $jc(_$hash, attachedImg.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('content', content)
          ..add('sentBy', sentBy)
          ..add('sentAt', sentAt)
          ..add('attachedFile', attachedFile)
          ..add('attachedImg', attachedImg))
        .toString();
  }
}

class GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageListBuilder
    implements
        Builder<
            GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList,
            GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageListBuilder> {
  _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  String? _sentBy;
  String? get sentBy => _$this._sentBy;
  set sentBy(String? sentBy) => _$this._sentBy = sentBy;

  String? _sentAt;
  String? get sentAt => _$this._sentAt;
  set sentAt(String? sentAt) => _$this._sentAt = sentAt;

  String? _attachedFile;
  String? get attachedFile => _$this._attachedFile;
  set attachedFile(String? attachedFile) => _$this._attachedFile = attachedFile;

  String? _attachedImg;
  String? get attachedImg => _$this._attachedImg;
  set attachedImg(String? attachedImg) => _$this._attachedImg = attachedImg;

  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageListBuilder() {
    GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList
        ._initializeBuilder(this);
  }

  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageListBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _content = $v.content;
      _sentBy = $v.sentBy;
      _sentAt = $v.sentAt;
      _attachedFile = $v.attachedFile;
      _attachedImg = $v.attachedImg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList
          other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other
        as _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList;
  }

  @override
  void update(
      void Function(
              GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageListBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList
      build() => _build();

  _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList
      _build() {
    final _$result = _$v ??
        new _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList',
                'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList', 'id'),
            content: BuiltValueNullFieldError.checkNotNull(
                content,
                r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList',
                'content'),
            sentBy: BuiltValueNullFieldError.checkNotNull(
                sentBy,
                r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList',
                'sentBy'),
            sentAt: BuiltValueNullFieldError.checkNotNull(
                sentAt,
                r'GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList',
                'sentAt'),
            attachedFile: attachedFile,
            attachedImg: attachedImg);
    replace(_$result);
    return _$result;
  }
}

class _$GGetNotificationsData extends GGetNotificationsData {
  @override
  final String G__typename;
  @override
  final BuiltList<GGetNotificationsData_getNotifications> getNotifications;

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

  ListBuilder<GGetNotificationsData_getNotifications>? _getNotifications;
  ListBuilder<GGetNotificationsData_getNotifications> get getNotifications =>
      _$this._getNotifications ??=
          new ListBuilder<GGetNotificationsData_getNotifications>();
  set getNotifications(
          ListBuilder<GGetNotificationsData_getNotifications>?
              getNotifications) =>
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
  final String? category;
  @override
  final String content;
  @override
  final bool isRead;
  @override
  final String createdAt;

  factory _$GGetNotificationsData_getNotifications(
          [void Function(GGetNotificationsData_getNotificationsBuilder)?
              updates]) =>
      (new GGetNotificationsData_getNotificationsBuilder()..update(updates))
          ._build();

  _$GGetNotificationsData_getNotifications._(
      {required this.G__typename,
      required this.id,
      required this.title,
      this.category,
      required this.content,
      required this.isRead,
      required this.createdAt})
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
        isRead, r'GGetNotificationsData_getNotifications', 'isRead');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'GGetNotificationsData_getNotifications', 'createdAt');
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
        category == other.category &&
        content == other.content &&
        isRead == other.isRead &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, isRead.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
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
          ..add('category', category)
          ..add('content', content)
          ..add('isRead', isRead)
          ..add('createdAt', createdAt))
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

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  bool? _isRead;
  bool? get isRead => _$this._isRead;
  set isRead(bool? isRead) => _$this._isRead = isRead;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  GGetNotificationsData_getNotificationsBuilder() {
    GGetNotificationsData_getNotifications._initializeBuilder(this);
  }

  GGetNotificationsData_getNotificationsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _title = $v.title;
      _category = $v.category;
      _content = $v.content;
      _isRead = $v.isRead;
      _createdAt = $v.createdAt;
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
            category: category,
            content: BuiltValueNullFieldError.checkNotNull(
                content, r'GGetNotificationsData_getNotifications', 'content'),
            isRead: BuiltValueNullFieldError.checkNotNull(
                isRead, r'GGetNotificationsData_getNotifications', 'isRead'),
            createdAt: BuiltValueNullFieldError.checkNotNull(createdAt,
                r'GGetNotificationsData_getNotifications', 'createdAt'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
