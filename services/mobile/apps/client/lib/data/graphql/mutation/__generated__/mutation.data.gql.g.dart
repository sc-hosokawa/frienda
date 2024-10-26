// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mutation.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GAddNewConnectionData> _$gAddNewConnectionDataSerializer =
    new _$GAddNewConnectionDataSerializer();
Serializer<GAddNewConnectionData_addNewConnection>
    _$gAddNewConnectionDataAddNewConnectionSerializer =
    new _$GAddNewConnectionData_addNewConnectionSerializer();
Serializer<GCreateNewMessageRoomData> _$gCreateNewMessageRoomDataSerializer =
    new _$GCreateNewMessageRoomDataSerializer();
Serializer<GCreateNewMessageRoomData_createNewMessageRoom>
    _$gCreateNewMessageRoomDataCreateNewMessageRoomSerializer =
    new _$GCreateNewMessageRoomData_createNewMessageRoomSerializer();
Serializer<GSendMessageData> _$gSendMessageDataSerializer =
    new _$GSendMessageDataSerializer();
Serializer<GSendMessageData_sendMessage>
    _$gSendMessageDataSendMessageSerializer =
    new _$GSendMessageData_sendMessageSerializer();
Serializer<GCreateNewOfferData> _$gCreateNewOfferDataSerializer =
    new _$GCreateNewOfferDataSerializer();
Serializer<GCreateNewOfferData_createNewOffer>
    _$gCreateNewOfferDataCreateNewOfferSerializer =
    new _$GCreateNewOfferData_createNewOfferSerializer();
Serializer<GUpdateOfferData> _$gUpdateOfferDataSerializer =
    new _$GUpdateOfferDataSerializer();
Serializer<GUpdateOfferData_updateOffer>
    _$gUpdateOfferDataUpdateOfferSerializer =
    new _$GUpdateOfferData_updateOfferSerializer();
Serializer<GDeleteOfferData> _$gDeleteOfferDataSerializer =
    new _$GDeleteOfferDataSerializer();
Serializer<GDeleteOfferData_deleteOffer>
    _$gDeleteOfferDataDeleteOfferSerializer =
    new _$GDeleteOfferData_deleteOfferSerializer();
Serializer<GCreateNewUserDataData> _$gCreateNewUserDataDataSerializer =
    new _$GCreateNewUserDataDataSerializer();
Serializer<GCreateNewUserDataData_createNewUserData>
    _$gCreateNewUserDataDataCreateNewUserDataSerializer =
    new _$GCreateNewUserDataData_createNewUserDataSerializer();
Serializer<GUpdateUserDataData> _$gUpdateUserDataDataSerializer =
    new _$GUpdateUserDataDataSerializer();
Serializer<GUpdateUserDataData_updateUserData>
    _$gUpdateUserDataDataUpdateUserDataSerializer =
    new _$GUpdateUserDataData_updateUserDataSerializer();
Serializer<GUpdateUserDataData_updateUserData_userInfo>
    _$gUpdateUserDataDataUpdateUserDataUserInfoSerializer =
    new _$GUpdateUserDataData_updateUserData_userInfoSerializer();
Serializer<GUpdateUserDataData_updateUserData_userInfo_belongsToArtists>
    _$gUpdateUserDataDataUpdateUserDataUserInfoBelongsToArtistsSerializer =
    new _$GUpdateUserDataData_updateUserData_userInfo_belongsToArtistsSerializer();
Serializer<GUpdateUserDataData_updateUserData_userInfo_primaryArtist>
    _$gUpdateUserDataDataUpdateUserDataUserInfoPrimaryArtistSerializer =
    new _$GUpdateUserDataData_updateUserData_userInfo_primaryArtistSerializer();
Serializer<GUpdateBelongsToArtistStatusData>
    _$gUpdateBelongsToArtistStatusDataSerializer =
    new _$GUpdateBelongsToArtistStatusDataSerializer();
Serializer<GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus>
    _$gUpdateBelongsToArtistStatusDataUpdateBelongsToArtistStatusSerializer =
    new _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatusSerializer();
Serializer<
        GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList>
    _$gUpdateBelongsToArtistStatusDataUpdateBelongsToArtistStatusArtistListSerializer =
    new _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistListSerializer();
Serializer<
        GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList>
    _$gUpdateBelongsToArtistStatusDataUpdateBelongsToArtistStatusArtistListArtistListSerializer =
    new _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistListSerializer();
Serializer<GContactToAdminData> _$gContactToAdminDataSerializer =
    new _$GContactToAdminDataSerializer();
Serializer<GContactToAdminData_contactToAdmin>
    _$gContactToAdminDataContactToAdminSerializer =
    new _$GContactToAdminData_contactToAdminSerializer();
Serializer<GCreateNewNotificationData> _$gCreateNewNotificationDataSerializer =
    new _$GCreateNewNotificationDataSerializer();
Serializer<GCreateNewNotificationData_createNewNotification>
    _$gCreateNewNotificationDataCreateNewNotificationSerializer =
    new _$GCreateNewNotificationData_createNewNotificationSerializer();
Serializer<GUpdateNotificationData> _$gUpdateNotificationDataSerializer =
    new _$GUpdateNotificationDataSerializer();
Serializer<GUpdateNotificationData_updateNotification>
    _$gUpdateNotificationDataUpdateNotificationSerializer =
    new _$GUpdateNotificationData_updateNotificationSerializer();
Serializer<GDeleteNotificationData> _$gDeleteNotificationDataSerializer =
    new _$GDeleteNotificationDataSerializer();
Serializer<GDeleteNotificationData_deleteNotification>
    _$gDeleteNotificationDataDeleteNotificationSerializer =
    new _$GDeleteNotificationData_deleteNotificationSerializer();
Serializer<GCreateFspTxData> _$gCreateFspTxDataSerializer =
    new _$GCreateFspTxDataSerializer();
Serializer<GCreateFspTxData_createFspTx>
    _$gCreateFspTxDataCreateFspTxSerializer =
    new _$GCreateFspTxData_createFspTxSerializer();
Serializer<GCreateNewArtistData> _$gCreateNewArtistDataSerializer =
    new _$GCreateNewArtistDataSerializer();
Serializer<GCreateNewArtistData_createNewArtist>
    _$gCreateNewArtistDataCreateNewArtistSerializer =
    new _$GCreateNewArtistData_createNewArtistSerializer();

class _$GAddNewConnectionDataSerializer
    implements StructuredSerializer<GAddNewConnectionData> {
  @override
  final Iterable<Type> types = const [
    GAddNewConnectionData,
    _$GAddNewConnectionData
  ];
  @override
  final String wireName = 'GAddNewConnectionData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAddNewConnectionData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'addNewConnection',
      serializers.serialize(object.addNewConnection,
          specifiedType:
              const FullType(GAddNewConnectionData_addNewConnection)),
    ];

    return result;
  }

  @override
  GAddNewConnectionData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAddNewConnectionDataBuilder();

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
        case 'addNewConnection':
          result.addNewConnection.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GAddNewConnectionData_addNewConnection))!
              as GAddNewConnectionData_addNewConnection);
          break;
      }
    }

    return result.build();
  }
}

class _$GAddNewConnectionData_addNewConnectionSerializer
    implements StructuredSerializer<GAddNewConnectionData_addNewConnection> {
  @override
  final Iterable<Type> types = const [
    GAddNewConnectionData_addNewConnection,
    _$GAddNewConnectionData_addNewConnection
  ];
  @override
  final String wireName = 'GAddNewConnectionData_addNewConnection';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAddNewConnectionData_addNewConnection object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'mapId',
      serializers.serialize(object.mapId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GAddNewConnectionData_addNewConnection deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAddNewConnectionData_addNewConnectionBuilder();

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
        case 'mapId':
          result.mapId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateNewMessageRoomDataSerializer
    implements StructuredSerializer<GCreateNewMessageRoomData> {
  @override
  final Iterable<Type> types = const [
    GCreateNewMessageRoomData,
    _$GCreateNewMessageRoomData
  ];
  @override
  final String wireName = 'GCreateNewMessageRoomData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateNewMessageRoomData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'createNewMessageRoom',
      serializers.serialize(object.createNewMessageRoom,
          specifiedType:
              const FullType(GCreateNewMessageRoomData_createNewMessageRoom)),
    ];

    return result;
  }

  @override
  GCreateNewMessageRoomData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateNewMessageRoomDataBuilder();

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
        case 'createNewMessageRoom':
          result.createNewMessageRoom.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GCreateNewMessageRoomData_createNewMessageRoom))!
              as GCreateNewMessageRoomData_createNewMessageRoom);
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateNewMessageRoomData_createNewMessageRoomSerializer
    implements
        StructuredSerializer<GCreateNewMessageRoomData_createNewMessageRoom> {
  @override
  final Iterable<Type> types = const [
    GCreateNewMessageRoomData_createNewMessageRoom,
    _$GCreateNewMessageRoomData_createNewMessageRoom
  ];
  @override
  final String wireName = 'GCreateNewMessageRoomData_createNewMessageRoom';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GCreateNewMessageRoomData_createNewMessageRoom object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GCreateNewMessageRoomData_createNewMessageRoom deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateNewMessageRoomData_createNewMessageRoomBuilder();

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
      }
    }

    return result.build();
  }
}

class _$GSendMessageDataSerializer
    implements StructuredSerializer<GSendMessageData> {
  @override
  final Iterable<Type> types = const [GSendMessageData, _$GSendMessageData];
  @override
  final String wireName = 'GSendMessageData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GSendMessageData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'sendMessage',
      serializers.serialize(object.sendMessage,
          specifiedType: const FullType(GSendMessageData_sendMessage)),
    ];

    return result;
  }

  @override
  GSendMessageData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSendMessageDataBuilder();

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
        case 'sendMessage':
          result.sendMessage.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GSendMessageData_sendMessage))!
              as GSendMessageData_sendMessage);
          break;
      }
    }

    return result.build();
  }
}

class _$GSendMessageData_sendMessageSerializer
    implements StructuredSerializer<GSendMessageData_sendMessage> {
  @override
  final Iterable<Type> types = const [
    GSendMessageData_sendMessage,
    _$GSendMessageData_sendMessage
  ];
  @override
  final String wireName = 'GSendMessageData_sendMessage';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSendMessageData_sendMessage object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GSendMessageData_sendMessage deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSendMessageData_sendMessageBuilder();

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
      }
    }

    return result.build();
  }
}

class _$GCreateNewOfferDataSerializer
    implements StructuredSerializer<GCreateNewOfferData> {
  @override
  final Iterable<Type> types = const [
    GCreateNewOfferData,
    _$GCreateNewOfferData
  ];
  @override
  final String wireName = 'GCreateNewOfferData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateNewOfferData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'createNewOffer',
      serializers.serialize(object.createNewOffer,
          specifiedType: const FullType(GCreateNewOfferData_createNewOffer)),
    ];

    return result;
  }

  @override
  GCreateNewOfferData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateNewOfferDataBuilder();

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
        case 'createNewOffer':
          result.createNewOffer.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GCreateNewOfferData_createNewOffer))!
              as GCreateNewOfferData_createNewOffer);
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateNewOfferData_createNewOfferSerializer
    implements StructuredSerializer<GCreateNewOfferData_createNewOffer> {
  @override
  final Iterable<Type> types = const [
    GCreateNewOfferData_createNewOffer,
    _$GCreateNewOfferData_createNewOffer
  ];
  @override
  final String wireName = 'GCreateNewOfferData_createNewOffer';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateNewOfferData_createNewOffer object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GCreateNewOfferData_createNewOffer deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateNewOfferData_createNewOfferBuilder();

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
      }
    }

    return result.build();
  }
}

class _$GUpdateOfferDataSerializer
    implements StructuredSerializer<GUpdateOfferData> {
  @override
  final Iterable<Type> types = const [GUpdateOfferData, _$GUpdateOfferData];
  @override
  final String wireName = 'GUpdateOfferData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GUpdateOfferData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'updateOffer',
      serializers.serialize(object.updateOffer,
          specifiedType: const FullType(GUpdateOfferData_updateOffer)),
    ];

    return result;
  }

  @override
  GUpdateOfferData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateOfferDataBuilder();

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
        case 'updateOffer':
          result.updateOffer.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GUpdateOfferData_updateOffer))!
              as GUpdateOfferData_updateOffer);
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateOfferData_updateOfferSerializer
    implements StructuredSerializer<GUpdateOfferData_updateOffer> {
  @override
  final Iterable<Type> types = const [
    GUpdateOfferData_updateOffer,
    _$GUpdateOfferData_updateOffer
  ];
  @override
  final String wireName = 'GUpdateOfferData_updateOffer';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateOfferData_updateOffer object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GUpdateOfferData_updateOffer deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateOfferData_updateOfferBuilder();

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
      }
    }

    return result.build();
  }
}

class _$GDeleteOfferDataSerializer
    implements StructuredSerializer<GDeleteOfferData> {
  @override
  final Iterable<Type> types = const [GDeleteOfferData, _$GDeleteOfferData];
  @override
  final String wireName = 'GDeleteOfferData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GDeleteOfferData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'deleteOffer',
      serializers.serialize(object.deleteOffer,
          specifiedType: const FullType(GDeleteOfferData_deleteOffer)),
    ];

    return result;
  }

  @override
  GDeleteOfferData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GDeleteOfferDataBuilder();

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
        case 'deleteOffer':
          result.deleteOffer.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GDeleteOfferData_deleteOffer))!
              as GDeleteOfferData_deleteOffer);
          break;
      }
    }

    return result.build();
  }
}

class _$GDeleteOfferData_deleteOfferSerializer
    implements StructuredSerializer<GDeleteOfferData_deleteOffer> {
  @override
  final Iterable<Type> types = const [
    GDeleteOfferData_deleteOffer,
    _$GDeleteOfferData_deleteOffer
  ];
  @override
  final String wireName = 'GDeleteOfferData_deleteOffer';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GDeleteOfferData_deleteOffer object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GDeleteOfferData_deleteOffer deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GDeleteOfferData_deleteOfferBuilder();

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
      }
    }

    return result.build();
  }
}

class _$GCreateNewUserDataDataSerializer
    implements StructuredSerializer<GCreateNewUserDataData> {
  @override
  final Iterable<Type> types = const [
    GCreateNewUserDataData,
    _$GCreateNewUserDataData
  ];
  @override
  final String wireName = 'GCreateNewUserDataData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateNewUserDataData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'createNewUserData',
      serializers.serialize(object.createNewUserData,
          specifiedType:
              const FullType(GCreateNewUserDataData_createNewUserData)),
    ];

    return result;
  }

  @override
  GCreateNewUserDataData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateNewUserDataDataBuilder();

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
        case 'createNewUserData':
          result.createNewUserData.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GCreateNewUserDataData_createNewUserData))!
              as GCreateNewUserDataData_createNewUserData);
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateNewUserDataData_createNewUserDataSerializer
    implements StructuredSerializer<GCreateNewUserDataData_createNewUserData> {
  @override
  final Iterable<Type> types = const [
    GCreateNewUserDataData_createNewUserData,
    _$GCreateNewUserDataData_createNewUserData
  ];
  @override
  final String wireName = 'GCreateNewUserDataData_createNewUserData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateNewUserDataData_createNewUserData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
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
  GCreateNewUserDataData_createNewUserData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateNewUserDataData_createNewUserDataBuilder();

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
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
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

class _$GUpdateUserDataDataSerializer
    implements StructuredSerializer<GUpdateUserDataData> {
  @override
  final Iterable<Type> types = const [
    GUpdateUserDataData,
    _$GUpdateUserDataData
  ];
  @override
  final String wireName = 'GUpdateUserDataData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateUserDataData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'updateUserData',
      serializers.serialize(object.updateUserData,
          specifiedType: const FullType(GUpdateUserDataData_updateUserData)),
    ];

    return result;
  }

  @override
  GUpdateUserDataData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateUserDataDataBuilder();

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
        case 'updateUserData':
          result.updateUserData.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GUpdateUserDataData_updateUserData))!
              as GUpdateUserDataData_updateUserData);
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateUserDataData_updateUserDataSerializer
    implements StructuredSerializer<GUpdateUserDataData_updateUserData> {
  @override
  final Iterable<Type> types = const [
    GUpdateUserDataData_updateUserData,
    _$GUpdateUserDataData_updateUserData
  ];
  @override
  final String wireName = 'GUpdateUserDataData_updateUserData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateUserDataData_updateUserData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'userInfo',
      serializers.serialize(object.userInfo,
          specifiedType:
              const FullType(GUpdateUserDataData_updateUserData_userInfo)),
    ];

    return result;
  }

  @override
  GUpdateUserDataData_updateUserData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateUserDataData_updateUserDataBuilder();

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
        case 'userInfo':
          result.userInfo.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GUpdateUserDataData_updateUserData_userInfo))!
              as GUpdateUserDataData_updateUserData_userInfo);
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateUserDataData_updateUserData_userInfoSerializer
    implements
        StructuredSerializer<GUpdateUserDataData_updateUserData_userInfo> {
  @override
  final Iterable<Type> types = const [
    GUpdateUserDataData_updateUserData_userInfo,
    _$GUpdateUserDataData_updateUserData_userInfo
  ];
  @override
  final String wireName = 'GUpdateUserDataData_updateUserData_userInfo';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GUpdateUserDataData_updateUserData_userInfo object,
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
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'fspBalance',
      serializers.serialize(object.fspBalance,
          specifiedType: const FullType(int)),
      'fspBalanceTemp',
      serializers.serialize(object.fspBalanceTemp,
          specifiedType: const FullType(int)),
      'credentialBalance',
      serializers.serialize(object.credentialBalance,
          specifiedType: const FullType(int)),
      'roles',
      serializers.serialize(object.roles,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'primaryRole',
      serializers.serialize(object.primaryRole,
          specifiedType: const FullType(String)),
      'belongsToArtists',
      serializers.serialize(object.belongsToArtists,
          specifiedType: const FullType(BuiltList, const [
            const FullType(
                GUpdateUserDataData_updateUserData_userInfo_belongsToArtists)
          ])),
    ];
    Object? value;
    value = object.imageUrl;
    if (value != null) {
      result
        ..add('imageUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.primaryArtist;
    if (value != null) {
      result
        ..add('primaryArtist')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                GUpdateUserDataData_updateUserData_userInfo_primaryArtist)));
    }
    return result;
  }

  @override
  GUpdateUserDataData_updateUserData_userInfo deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateUserDataData_updateUserData_userInfoBuilder();

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
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'imageUrl':
          result.imageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'fspBalance':
          result.fspBalance = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'fspBalanceTemp':
          result.fspBalanceTemp = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'credentialBalance':
          result.credentialBalance = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'roles':
          result.roles.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'primaryRole':
          result.primaryRole = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'belongsToArtists':
          result.belongsToArtists.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    GUpdateUserDataData_updateUserData_userInfo_belongsToArtists)
              ]))! as BuiltList<Object?>);
          break;
        case 'primaryArtist':
          result.primaryArtist.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GUpdateUserDataData_updateUserData_userInfo_primaryArtist))!
              as GUpdateUserDataData_updateUserData_userInfo_primaryArtist);
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateUserDataData_updateUserData_userInfo_belongsToArtistsSerializer
    implements
        StructuredSerializer<
            GUpdateUserDataData_updateUserData_userInfo_belongsToArtists> {
  @override
  final Iterable<Type> types = const [
    GUpdateUserDataData_updateUserData_userInfo_belongsToArtists,
    _$GUpdateUserDataData_updateUserData_userInfo_belongsToArtists
  ];
  @override
  final String wireName =
      'GUpdateUserDataData_updateUserData_userInfo_belongsToArtists';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GUpdateUserDataData_updateUserData_userInfo_belongsToArtists object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'isAccepted',
      serializers.serialize(object.isAccepted,
          specifiedType: const FullType(bool)),
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
  GUpdateUserDataData_updateUserData_userInfo_belongsToArtists deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GUpdateUserDataData_updateUserData_userInfo_belongsToArtistsBuilder();

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
        case 'imageUrl':
          result.imageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'isAccepted':
          result.isAccepted = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateUserDataData_updateUserData_userInfo_primaryArtistSerializer
    implements
        StructuredSerializer<
            GUpdateUserDataData_updateUserData_userInfo_primaryArtist> {
  @override
  final Iterable<Type> types = const [
    GUpdateUserDataData_updateUserData_userInfo_primaryArtist,
    _$GUpdateUserDataData_updateUserData_userInfo_primaryArtist
  ];
  @override
  final String wireName =
      'GUpdateUserDataData_updateUserData_userInfo_primaryArtist';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GUpdateUserDataData_updateUserData_userInfo_primaryArtist object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'isAccepted',
      serializers.serialize(object.isAccepted,
          specifiedType: const FullType(bool)),
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
  GUpdateUserDataData_updateUserData_userInfo_primaryArtist deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GUpdateUserDataData_updateUserData_userInfo_primaryArtistBuilder();

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
        case 'imageUrl':
          result.imageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'isAccepted':
          result.isAccepted = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateBelongsToArtistStatusDataSerializer
    implements StructuredSerializer<GUpdateBelongsToArtistStatusData> {
  @override
  final Iterable<Type> types = const [
    GUpdateBelongsToArtistStatusData,
    _$GUpdateBelongsToArtistStatusData
  ];
  @override
  final String wireName = 'GUpdateBelongsToArtistStatusData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateBelongsToArtistStatusData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'updateBelongsToArtistStatus',
      serializers.serialize(object.updateBelongsToArtistStatus,
          specifiedType: const FullType(
              GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus)),
    ];

    return result;
  }

  @override
  GUpdateBelongsToArtistStatusData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateBelongsToArtistStatusDataBuilder();

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
        case 'updateBelongsToArtistStatus':
          result.updateBelongsToArtistStatus.replace(serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                      GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus))!
              as GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus);
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatusSerializer
    implements
        StructuredSerializer<
            GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus> {
  @override
  final Iterable<Type> types = const [
    GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus,
    _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus
  ];
  @override
  final String wireName =
      'GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'artistList',
      serializers.serialize(object.artistList,
          specifiedType: const FullType(
              GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList)),
    ];

    return result;
  }

  @override
  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatusBuilder();

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
        case 'artistList':
          result.artistList.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList))!
              as GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList);
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistListSerializer
    implements
        StructuredSerializer<
            GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList> {
  @override
  final Iterable<Type> types = const [
    GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList,
    _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList
  ];
  @override
  final String wireName =
      'GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList';

  @override
  Iterable<Object?> serialize(
      Serializers serializers,
      GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList
          object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'artistList',
      serializers.serialize(object.artistList,
          specifiedType: const FullType(BuiltList, const [
            const FullType(
                GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList)
          ])),
    ];

    return result;
  }

  @override
  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList
      deserialize(Serializers serializers, Iterable<Object?> serialized,
          {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistListBuilder();

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
        case 'artistList':
          result.artistList.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistListSerializer
    implements
        StructuredSerializer<
            GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList> {
  @override
  final Iterable<Type> types = const [
    GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList,
    _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList
  ];
  @override
  final String wireName =
      'GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList';

  @override
  Iterable<Object?> serialize(
      Serializers serializers,
      GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList
          object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'isAccepted',
      serializers.serialize(object.isAccepted,
          specifiedType: const FullType(bool)),
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
  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList
      deserialize(Serializers serializers, Iterable<Object?> serialized,
          {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistListBuilder();

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
        case 'imageUrl':
          result.imageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'isAccepted':
          result.isAccepted = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GContactToAdminDataSerializer
    implements StructuredSerializer<GContactToAdminData> {
  @override
  final Iterable<Type> types = const [
    GContactToAdminData,
    _$GContactToAdminData
  ];
  @override
  final String wireName = 'GContactToAdminData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GContactToAdminData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'contactToAdmin',
      serializers.serialize(object.contactToAdmin,
          specifiedType: const FullType(GContactToAdminData_contactToAdmin)),
    ];

    return result;
  }

  @override
  GContactToAdminData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GContactToAdminDataBuilder();

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
        case 'contactToAdmin':
          result.contactToAdmin.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GContactToAdminData_contactToAdmin))!
              as GContactToAdminData_contactToAdmin);
          break;
      }
    }

    return result.build();
  }
}

class _$GContactToAdminData_contactToAdminSerializer
    implements StructuredSerializer<GContactToAdminData_contactToAdmin> {
  @override
  final Iterable<Type> types = const [
    GContactToAdminData_contactToAdmin,
    _$GContactToAdminData_contactToAdmin
  ];
  @override
  final String wireName = 'GContactToAdminData_contactToAdmin';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GContactToAdminData_contactToAdmin object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GContactToAdminData_contactToAdmin deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GContactToAdminData_contactToAdminBuilder();

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
      }
    }

    return result.build();
  }
}

class _$GCreateNewNotificationDataSerializer
    implements StructuredSerializer<GCreateNewNotificationData> {
  @override
  final Iterable<Type> types = const [
    GCreateNewNotificationData,
    _$GCreateNewNotificationData
  ];
  @override
  final String wireName = 'GCreateNewNotificationData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateNewNotificationData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'createNewNotification',
      serializers.serialize(object.createNewNotification,
          specifiedType:
              const FullType(GCreateNewNotificationData_createNewNotification)),
    ];

    return result;
  }

  @override
  GCreateNewNotificationData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateNewNotificationDataBuilder();

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
        case 'createNewNotification':
          result.createNewNotification.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GCreateNewNotificationData_createNewNotification))!
              as GCreateNewNotificationData_createNewNotification);
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateNewNotificationData_createNewNotificationSerializer
    implements
        StructuredSerializer<GCreateNewNotificationData_createNewNotification> {
  @override
  final Iterable<Type> types = const [
    GCreateNewNotificationData_createNewNotification,
    _$GCreateNewNotificationData_createNewNotification
  ];
  @override
  final String wireName = 'GCreateNewNotificationData_createNewNotification';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GCreateNewNotificationData_createNewNotification object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GCreateNewNotificationData_createNewNotification deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GCreateNewNotificationData_createNewNotificationBuilder();

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
      }
    }

    return result.build();
  }
}

class _$GUpdateNotificationDataSerializer
    implements StructuredSerializer<GUpdateNotificationData> {
  @override
  final Iterable<Type> types = const [
    GUpdateNotificationData,
    _$GUpdateNotificationData
  ];
  @override
  final String wireName = 'GUpdateNotificationData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateNotificationData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'updateNotification',
      serializers.serialize(object.updateNotification,
          specifiedType:
              const FullType(GUpdateNotificationData_updateNotification)),
    ];

    return result;
  }

  @override
  GUpdateNotificationData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateNotificationDataBuilder();

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
        case 'updateNotification':
          result.updateNotification.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GUpdateNotificationData_updateNotification))!
              as GUpdateNotificationData_updateNotification);
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateNotificationData_updateNotificationSerializer
    implements
        StructuredSerializer<GUpdateNotificationData_updateNotification> {
  @override
  final Iterable<Type> types = const [
    GUpdateNotificationData_updateNotification,
    _$GUpdateNotificationData_updateNotification
  ];
  @override
  final String wireName = 'GUpdateNotificationData_updateNotification';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GUpdateNotificationData_updateNotification object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GUpdateNotificationData_updateNotification deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateNotificationData_updateNotificationBuilder();

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
      }
    }

    return result.build();
  }
}

class _$GDeleteNotificationDataSerializer
    implements StructuredSerializer<GDeleteNotificationData> {
  @override
  final Iterable<Type> types = const [
    GDeleteNotificationData,
    _$GDeleteNotificationData
  ];
  @override
  final String wireName = 'GDeleteNotificationData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GDeleteNotificationData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'deleteNotification',
      serializers.serialize(object.deleteNotification,
          specifiedType:
              const FullType(GDeleteNotificationData_deleteNotification)),
    ];

    return result;
  }

  @override
  GDeleteNotificationData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GDeleteNotificationDataBuilder();

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
        case 'deleteNotification':
          result.deleteNotification.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GDeleteNotificationData_deleteNotification))!
              as GDeleteNotificationData_deleteNotification);
          break;
      }
    }

    return result.build();
  }
}

class _$GDeleteNotificationData_deleteNotificationSerializer
    implements
        StructuredSerializer<GDeleteNotificationData_deleteNotification> {
  @override
  final Iterable<Type> types = const [
    GDeleteNotificationData_deleteNotification,
    _$GDeleteNotificationData_deleteNotification
  ];
  @override
  final String wireName = 'GDeleteNotificationData_deleteNotification';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GDeleteNotificationData_deleteNotification object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GDeleteNotificationData_deleteNotification deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GDeleteNotificationData_deleteNotificationBuilder();

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
      }
    }

    return result.build();
  }
}

class _$GCreateFspTxDataSerializer
    implements StructuredSerializer<GCreateFspTxData> {
  @override
  final Iterable<Type> types = const [GCreateFspTxData, _$GCreateFspTxData];
  @override
  final String wireName = 'GCreateFspTxData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GCreateFspTxData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'createFspTx',
      serializers.serialize(object.createFspTx,
          specifiedType: const FullType(GCreateFspTxData_createFspTx)),
    ];

    return result;
  }

  @override
  GCreateFspTxData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateFspTxDataBuilder();

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
        case 'createFspTx':
          result.createFspTx.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GCreateFspTxData_createFspTx))!
              as GCreateFspTxData_createFspTx);
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateFspTxData_createFspTxSerializer
    implements StructuredSerializer<GCreateFspTxData_createFspTx> {
  @override
  final Iterable<Type> types = const [
    GCreateFspTxData_createFspTx,
    _$GCreateFspTxData_createFspTx
  ];
  @override
  final String wireName = 'GCreateFspTxData_createFspTx';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateFspTxData_createFspTx object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'newBalance',
      serializers.serialize(object.newBalance,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GCreateFspTxData_createFspTx deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateFspTxData_createFspTxBuilder();

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
        case 'newBalance':
          result.newBalance = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateNewArtistDataSerializer
    implements StructuredSerializer<GCreateNewArtistData> {
  @override
  final Iterable<Type> types = const [
    GCreateNewArtistData,
    _$GCreateNewArtistData
  ];
  @override
  final String wireName = 'GCreateNewArtistData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateNewArtistData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'createNewArtist',
      serializers.serialize(object.createNewArtist,
          specifiedType: const FullType(GCreateNewArtistData_createNewArtist)),
    ];

    return result;
  }

  @override
  GCreateNewArtistData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateNewArtistDataBuilder();

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
        case 'createNewArtist':
          result.createNewArtist.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GCreateNewArtistData_createNewArtist))!
              as GCreateNewArtistData_createNewArtist);
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateNewArtistData_createNewArtistSerializer
    implements StructuredSerializer<GCreateNewArtistData_createNewArtist> {
  @override
  final Iterable<Type> types = const [
    GCreateNewArtistData_createNewArtist,
    _$GCreateNewArtistData_createNewArtist
  ];
  @override
  final String wireName = 'GCreateNewArtistData_createNewArtist';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateNewArtistData_createNewArtist object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GCreateNewArtistData_createNewArtist deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateNewArtistData_createNewArtistBuilder();

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
      }
    }

    return result.build();
  }
}

class _$GAddNewConnectionData extends GAddNewConnectionData {
  @override
  final String G__typename;
  @override
  final GAddNewConnectionData_addNewConnection addNewConnection;

  factory _$GAddNewConnectionData(
          [void Function(GAddNewConnectionDataBuilder)? updates]) =>
      (new GAddNewConnectionDataBuilder()..update(updates))._build();

  _$GAddNewConnectionData._(
      {required this.G__typename, required this.addNewConnection})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GAddNewConnectionData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        addNewConnection, r'GAddNewConnectionData', 'addNewConnection');
  }

  @override
  GAddNewConnectionData rebuild(
          void Function(GAddNewConnectionDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAddNewConnectionDataBuilder toBuilder() =>
      new GAddNewConnectionDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAddNewConnectionData &&
        G__typename == other.G__typename &&
        addNewConnection == other.addNewConnection;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, addNewConnection.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAddNewConnectionData')
          ..add('G__typename', G__typename)
          ..add('addNewConnection', addNewConnection))
        .toString();
  }
}

class GAddNewConnectionDataBuilder
    implements Builder<GAddNewConnectionData, GAddNewConnectionDataBuilder> {
  _$GAddNewConnectionData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GAddNewConnectionData_addNewConnectionBuilder? _addNewConnection;
  GAddNewConnectionData_addNewConnectionBuilder get addNewConnection =>
      _$this._addNewConnection ??=
          new GAddNewConnectionData_addNewConnectionBuilder();
  set addNewConnection(
          GAddNewConnectionData_addNewConnectionBuilder? addNewConnection) =>
      _$this._addNewConnection = addNewConnection;

  GAddNewConnectionDataBuilder() {
    GAddNewConnectionData._initializeBuilder(this);
  }

  GAddNewConnectionDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _addNewConnection = $v.addNewConnection.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAddNewConnectionData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAddNewConnectionData;
  }

  @override
  void update(void Function(GAddNewConnectionDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAddNewConnectionData build() => _build();

  _$GAddNewConnectionData _build() {
    _$GAddNewConnectionData _$result;
    try {
      _$result = _$v ??
          new _$GAddNewConnectionData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GAddNewConnectionData', 'G__typename'),
              addNewConnection: addNewConnection.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'addNewConnection';
        addNewConnection.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GAddNewConnectionData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GAddNewConnectionData_addNewConnection
    extends GAddNewConnectionData_addNewConnection {
  @override
  final String G__typename;
  @override
  final String mapId;

  factory _$GAddNewConnectionData_addNewConnection(
          [void Function(GAddNewConnectionData_addNewConnectionBuilder)?
              updates]) =>
      (new GAddNewConnectionData_addNewConnectionBuilder()..update(updates))
          ._build();

  _$GAddNewConnectionData_addNewConnection._(
      {required this.G__typename, required this.mapId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GAddNewConnectionData_addNewConnection', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        mapId, r'GAddNewConnectionData_addNewConnection', 'mapId');
  }

  @override
  GAddNewConnectionData_addNewConnection rebuild(
          void Function(GAddNewConnectionData_addNewConnectionBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAddNewConnectionData_addNewConnectionBuilder toBuilder() =>
      new GAddNewConnectionData_addNewConnectionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAddNewConnectionData_addNewConnection &&
        G__typename == other.G__typename &&
        mapId == other.mapId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, mapId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GAddNewConnectionData_addNewConnection')
          ..add('G__typename', G__typename)
          ..add('mapId', mapId))
        .toString();
  }
}

class GAddNewConnectionData_addNewConnectionBuilder
    implements
        Builder<GAddNewConnectionData_addNewConnection,
            GAddNewConnectionData_addNewConnectionBuilder> {
  _$GAddNewConnectionData_addNewConnection? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _mapId;
  String? get mapId => _$this._mapId;
  set mapId(String? mapId) => _$this._mapId = mapId;

  GAddNewConnectionData_addNewConnectionBuilder() {
    GAddNewConnectionData_addNewConnection._initializeBuilder(this);
  }

  GAddNewConnectionData_addNewConnectionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _mapId = $v.mapId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAddNewConnectionData_addNewConnection other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAddNewConnectionData_addNewConnection;
  }

  @override
  void update(
      void Function(GAddNewConnectionData_addNewConnectionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAddNewConnectionData_addNewConnection build() => _build();

  _$GAddNewConnectionData_addNewConnection _build() {
    final _$result = _$v ??
        new _$GAddNewConnectionData_addNewConnection._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GAddNewConnectionData_addNewConnection', 'G__typename'),
            mapId: BuiltValueNullFieldError.checkNotNull(
                mapId, r'GAddNewConnectionData_addNewConnection', 'mapId'));
    replace(_$result);
    return _$result;
  }
}

class _$GCreateNewMessageRoomData extends GCreateNewMessageRoomData {
  @override
  final String G__typename;
  @override
  final GCreateNewMessageRoomData_createNewMessageRoom createNewMessageRoom;

  factory _$GCreateNewMessageRoomData(
          [void Function(GCreateNewMessageRoomDataBuilder)? updates]) =>
      (new GCreateNewMessageRoomDataBuilder()..update(updates))._build();

  _$GCreateNewMessageRoomData._(
      {required this.G__typename, required this.createNewMessageRoom})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GCreateNewMessageRoomData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(createNewMessageRoom,
        r'GCreateNewMessageRoomData', 'createNewMessageRoom');
  }

  @override
  GCreateNewMessageRoomData rebuild(
          void Function(GCreateNewMessageRoomDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateNewMessageRoomDataBuilder toBuilder() =>
      new GCreateNewMessageRoomDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateNewMessageRoomData &&
        G__typename == other.G__typename &&
        createNewMessageRoom == other.createNewMessageRoom;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, createNewMessageRoom.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateNewMessageRoomData')
          ..add('G__typename', G__typename)
          ..add('createNewMessageRoom', createNewMessageRoom))
        .toString();
  }
}

class GCreateNewMessageRoomDataBuilder
    implements
        Builder<GCreateNewMessageRoomData, GCreateNewMessageRoomDataBuilder> {
  _$GCreateNewMessageRoomData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GCreateNewMessageRoomData_createNewMessageRoomBuilder? _createNewMessageRoom;
  GCreateNewMessageRoomData_createNewMessageRoomBuilder
      get createNewMessageRoom => _$this._createNewMessageRoom ??=
          new GCreateNewMessageRoomData_createNewMessageRoomBuilder();
  set createNewMessageRoom(
          GCreateNewMessageRoomData_createNewMessageRoomBuilder?
              createNewMessageRoom) =>
      _$this._createNewMessageRoom = createNewMessageRoom;

  GCreateNewMessageRoomDataBuilder() {
    GCreateNewMessageRoomData._initializeBuilder(this);
  }

  GCreateNewMessageRoomDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _createNewMessageRoom = $v.createNewMessageRoom.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateNewMessageRoomData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateNewMessageRoomData;
  }

  @override
  void update(void Function(GCreateNewMessageRoomDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateNewMessageRoomData build() => _build();

  _$GCreateNewMessageRoomData _build() {
    _$GCreateNewMessageRoomData _$result;
    try {
      _$result = _$v ??
          new _$GCreateNewMessageRoomData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GCreateNewMessageRoomData', 'G__typename'),
              createNewMessageRoom: createNewMessageRoom.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createNewMessageRoom';
        createNewMessageRoom.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GCreateNewMessageRoomData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GCreateNewMessageRoomData_createNewMessageRoom
    extends GCreateNewMessageRoomData_createNewMessageRoom {
  @override
  final String G__typename;
  @override
  final String id;

  factory _$GCreateNewMessageRoomData_createNewMessageRoom(
          [void Function(GCreateNewMessageRoomData_createNewMessageRoomBuilder)?
              updates]) =>
      (new GCreateNewMessageRoomData_createNewMessageRoomBuilder()
            ..update(updates))
          ._build();

  _$GCreateNewMessageRoomData_createNewMessageRoom._(
      {required this.G__typename, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(G__typename,
        r'GCreateNewMessageRoomData_createNewMessageRoom', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GCreateNewMessageRoomData_createNewMessageRoom', 'id');
  }

  @override
  GCreateNewMessageRoomData_createNewMessageRoom rebuild(
          void Function(GCreateNewMessageRoomData_createNewMessageRoomBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateNewMessageRoomData_createNewMessageRoomBuilder toBuilder() =>
      new GCreateNewMessageRoomData_createNewMessageRoomBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateNewMessageRoomData_createNewMessageRoom &&
        G__typename == other.G__typename &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GCreateNewMessageRoomData_createNewMessageRoom')
          ..add('G__typename', G__typename)
          ..add('id', id))
        .toString();
  }
}

class GCreateNewMessageRoomData_createNewMessageRoomBuilder
    implements
        Builder<GCreateNewMessageRoomData_createNewMessageRoom,
            GCreateNewMessageRoomData_createNewMessageRoomBuilder> {
  _$GCreateNewMessageRoomData_createNewMessageRoom? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  GCreateNewMessageRoomData_createNewMessageRoomBuilder() {
    GCreateNewMessageRoomData_createNewMessageRoom._initializeBuilder(this);
  }

  GCreateNewMessageRoomData_createNewMessageRoomBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateNewMessageRoomData_createNewMessageRoom other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateNewMessageRoomData_createNewMessageRoom;
  }

  @override
  void update(
      void Function(GCreateNewMessageRoomData_createNewMessageRoomBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateNewMessageRoomData_createNewMessageRoom build() => _build();

  _$GCreateNewMessageRoomData_createNewMessageRoom _build() {
    final _$result = _$v ??
        new _$GCreateNewMessageRoomData_createNewMessageRoom._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GCreateNewMessageRoomData_createNewMessageRoom',
                'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GCreateNewMessageRoomData_createNewMessageRoom', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$GSendMessageData extends GSendMessageData {
  @override
  final String G__typename;
  @override
  final GSendMessageData_sendMessage sendMessage;

  factory _$GSendMessageData(
          [void Function(GSendMessageDataBuilder)? updates]) =>
      (new GSendMessageDataBuilder()..update(updates))._build();

  _$GSendMessageData._({required this.G__typename, required this.sendMessage})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GSendMessageData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        sendMessage, r'GSendMessageData', 'sendMessage');
  }

  @override
  GSendMessageData rebuild(void Function(GSendMessageDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSendMessageDataBuilder toBuilder() =>
      new GSendMessageDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSendMessageData &&
        G__typename == other.G__typename &&
        sendMessage == other.sendMessage;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, sendMessage.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSendMessageData')
          ..add('G__typename', G__typename)
          ..add('sendMessage', sendMessage))
        .toString();
  }
}

class GSendMessageDataBuilder
    implements Builder<GSendMessageData, GSendMessageDataBuilder> {
  _$GSendMessageData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GSendMessageData_sendMessageBuilder? _sendMessage;
  GSendMessageData_sendMessageBuilder get sendMessage =>
      _$this._sendMessage ??= new GSendMessageData_sendMessageBuilder();
  set sendMessage(GSendMessageData_sendMessageBuilder? sendMessage) =>
      _$this._sendMessage = sendMessage;

  GSendMessageDataBuilder() {
    GSendMessageData._initializeBuilder(this);
  }

  GSendMessageDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _sendMessage = $v.sendMessage.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSendMessageData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSendMessageData;
  }

  @override
  void update(void Function(GSendMessageDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSendMessageData build() => _build();

  _$GSendMessageData _build() {
    _$GSendMessageData _$result;
    try {
      _$result = _$v ??
          new _$GSendMessageData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GSendMessageData', 'G__typename'),
              sendMessage: sendMessage.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'sendMessage';
        sendMessage.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GSendMessageData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GSendMessageData_sendMessage extends GSendMessageData_sendMessage {
  @override
  final String G__typename;
  @override
  final String id;

  factory _$GSendMessageData_sendMessage(
          [void Function(GSendMessageData_sendMessageBuilder)? updates]) =>
      (new GSendMessageData_sendMessageBuilder()..update(updates))._build();

  _$GSendMessageData_sendMessage._(
      {required this.G__typename, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GSendMessageData_sendMessage', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GSendMessageData_sendMessage', 'id');
  }

  @override
  GSendMessageData_sendMessage rebuild(
          void Function(GSendMessageData_sendMessageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSendMessageData_sendMessageBuilder toBuilder() =>
      new GSendMessageData_sendMessageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSendMessageData_sendMessage &&
        G__typename == other.G__typename &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSendMessageData_sendMessage')
          ..add('G__typename', G__typename)
          ..add('id', id))
        .toString();
  }
}

class GSendMessageData_sendMessageBuilder
    implements
        Builder<GSendMessageData_sendMessage,
            GSendMessageData_sendMessageBuilder> {
  _$GSendMessageData_sendMessage? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  GSendMessageData_sendMessageBuilder() {
    GSendMessageData_sendMessage._initializeBuilder(this);
  }

  GSendMessageData_sendMessageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSendMessageData_sendMessage other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSendMessageData_sendMessage;
  }

  @override
  void update(void Function(GSendMessageData_sendMessageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSendMessageData_sendMessage build() => _build();

  _$GSendMessageData_sendMessage _build() {
    final _$result = _$v ??
        new _$GSendMessageData_sendMessage._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GSendMessageData_sendMessage', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GSendMessageData_sendMessage', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$GCreateNewOfferData extends GCreateNewOfferData {
  @override
  final String G__typename;
  @override
  final GCreateNewOfferData_createNewOffer createNewOffer;

  factory _$GCreateNewOfferData(
          [void Function(GCreateNewOfferDataBuilder)? updates]) =>
      (new GCreateNewOfferDataBuilder()..update(updates))._build();

  _$GCreateNewOfferData._(
      {required this.G__typename, required this.createNewOffer})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GCreateNewOfferData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        createNewOffer, r'GCreateNewOfferData', 'createNewOffer');
  }

  @override
  GCreateNewOfferData rebuild(
          void Function(GCreateNewOfferDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateNewOfferDataBuilder toBuilder() =>
      new GCreateNewOfferDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateNewOfferData &&
        G__typename == other.G__typename &&
        createNewOffer == other.createNewOffer;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, createNewOffer.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateNewOfferData')
          ..add('G__typename', G__typename)
          ..add('createNewOffer', createNewOffer))
        .toString();
  }
}

class GCreateNewOfferDataBuilder
    implements Builder<GCreateNewOfferData, GCreateNewOfferDataBuilder> {
  _$GCreateNewOfferData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GCreateNewOfferData_createNewOfferBuilder? _createNewOffer;
  GCreateNewOfferData_createNewOfferBuilder get createNewOffer =>
      _$this._createNewOffer ??=
          new GCreateNewOfferData_createNewOfferBuilder();
  set createNewOffer(
          GCreateNewOfferData_createNewOfferBuilder? createNewOffer) =>
      _$this._createNewOffer = createNewOffer;

  GCreateNewOfferDataBuilder() {
    GCreateNewOfferData._initializeBuilder(this);
  }

  GCreateNewOfferDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _createNewOffer = $v.createNewOffer.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateNewOfferData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateNewOfferData;
  }

  @override
  void update(void Function(GCreateNewOfferDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateNewOfferData build() => _build();

  _$GCreateNewOfferData _build() {
    _$GCreateNewOfferData _$result;
    try {
      _$result = _$v ??
          new _$GCreateNewOfferData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GCreateNewOfferData', 'G__typename'),
              createNewOffer: createNewOffer.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createNewOffer';
        createNewOffer.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GCreateNewOfferData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GCreateNewOfferData_createNewOffer
    extends GCreateNewOfferData_createNewOffer {
  @override
  final String G__typename;
  @override
  final int id;

  factory _$GCreateNewOfferData_createNewOffer(
          [void Function(GCreateNewOfferData_createNewOfferBuilder)?
              updates]) =>
      (new GCreateNewOfferData_createNewOfferBuilder()..update(updates))
          ._build();

  _$GCreateNewOfferData_createNewOffer._(
      {required this.G__typename, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GCreateNewOfferData_createNewOffer', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GCreateNewOfferData_createNewOffer', 'id');
  }

  @override
  GCreateNewOfferData_createNewOffer rebuild(
          void Function(GCreateNewOfferData_createNewOfferBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateNewOfferData_createNewOfferBuilder toBuilder() =>
      new GCreateNewOfferData_createNewOfferBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateNewOfferData_createNewOffer &&
        G__typename == other.G__typename &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateNewOfferData_createNewOffer')
          ..add('G__typename', G__typename)
          ..add('id', id))
        .toString();
  }
}

class GCreateNewOfferData_createNewOfferBuilder
    implements
        Builder<GCreateNewOfferData_createNewOffer,
            GCreateNewOfferData_createNewOfferBuilder> {
  _$GCreateNewOfferData_createNewOffer? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  GCreateNewOfferData_createNewOfferBuilder() {
    GCreateNewOfferData_createNewOffer._initializeBuilder(this);
  }

  GCreateNewOfferData_createNewOfferBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateNewOfferData_createNewOffer other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateNewOfferData_createNewOffer;
  }

  @override
  void update(
      void Function(GCreateNewOfferData_createNewOfferBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateNewOfferData_createNewOffer build() => _build();

  _$GCreateNewOfferData_createNewOffer _build() {
    final _$result = _$v ??
        new _$GCreateNewOfferData_createNewOffer._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GCreateNewOfferData_createNewOffer', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GCreateNewOfferData_createNewOffer', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateOfferData extends GUpdateOfferData {
  @override
  final String G__typename;
  @override
  final GUpdateOfferData_updateOffer updateOffer;

  factory _$GUpdateOfferData(
          [void Function(GUpdateOfferDataBuilder)? updates]) =>
      (new GUpdateOfferDataBuilder()..update(updates))._build();

  _$GUpdateOfferData._({required this.G__typename, required this.updateOffer})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GUpdateOfferData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        updateOffer, r'GUpdateOfferData', 'updateOffer');
  }

  @override
  GUpdateOfferData rebuild(void Function(GUpdateOfferDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateOfferDataBuilder toBuilder() =>
      new GUpdateOfferDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateOfferData &&
        G__typename == other.G__typename &&
        updateOffer == other.updateOffer;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, updateOffer.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateOfferData')
          ..add('G__typename', G__typename)
          ..add('updateOffer', updateOffer))
        .toString();
  }
}

class GUpdateOfferDataBuilder
    implements Builder<GUpdateOfferData, GUpdateOfferDataBuilder> {
  _$GUpdateOfferData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GUpdateOfferData_updateOfferBuilder? _updateOffer;
  GUpdateOfferData_updateOfferBuilder get updateOffer =>
      _$this._updateOffer ??= new GUpdateOfferData_updateOfferBuilder();
  set updateOffer(GUpdateOfferData_updateOfferBuilder? updateOffer) =>
      _$this._updateOffer = updateOffer;

  GUpdateOfferDataBuilder() {
    GUpdateOfferData._initializeBuilder(this);
  }

  GUpdateOfferDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _updateOffer = $v.updateOffer.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateOfferData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateOfferData;
  }

  @override
  void update(void Function(GUpdateOfferDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateOfferData build() => _build();

  _$GUpdateOfferData _build() {
    _$GUpdateOfferData _$result;
    try {
      _$result = _$v ??
          new _$GUpdateOfferData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GUpdateOfferData', 'G__typename'),
              updateOffer: updateOffer.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'updateOffer';
        updateOffer.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GUpdateOfferData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateOfferData_updateOffer extends GUpdateOfferData_updateOffer {
  @override
  final String G__typename;
  @override
  final int id;

  factory _$GUpdateOfferData_updateOffer(
          [void Function(GUpdateOfferData_updateOfferBuilder)? updates]) =>
      (new GUpdateOfferData_updateOfferBuilder()..update(updates))._build();

  _$GUpdateOfferData_updateOffer._(
      {required this.G__typename, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GUpdateOfferData_updateOffer', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GUpdateOfferData_updateOffer', 'id');
  }

  @override
  GUpdateOfferData_updateOffer rebuild(
          void Function(GUpdateOfferData_updateOfferBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateOfferData_updateOfferBuilder toBuilder() =>
      new GUpdateOfferData_updateOfferBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateOfferData_updateOffer &&
        G__typename == other.G__typename &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateOfferData_updateOffer')
          ..add('G__typename', G__typename)
          ..add('id', id))
        .toString();
  }
}

class GUpdateOfferData_updateOfferBuilder
    implements
        Builder<GUpdateOfferData_updateOffer,
            GUpdateOfferData_updateOfferBuilder> {
  _$GUpdateOfferData_updateOffer? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  GUpdateOfferData_updateOfferBuilder() {
    GUpdateOfferData_updateOffer._initializeBuilder(this);
  }

  GUpdateOfferData_updateOfferBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateOfferData_updateOffer other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateOfferData_updateOffer;
  }

  @override
  void update(void Function(GUpdateOfferData_updateOfferBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateOfferData_updateOffer build() => _build();

  _$GUpdateOfferData_updateOffer _build() {
    final _$result = _$v ??
        new _$GUpdateOfferData_updateOffer._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GUpdateOfferData_updateOffer', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GUpdateOfferData_updateOffer', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$GDeleteOfferData extends GDeleteOfferData {
  @override
  final String G__typename;
  @override
  final GDeleteOfferData_deleteOffer deleteOffer;

  factory _$GDeleteOfferData(
          [void Function(GDeleteOfferDataBuilder)? updates]) =>
      (new GDeleteOfferDataBuilder()..update(updates))._build();

  _$GDeleteOfferData._({required this.G__typename, required this.deleteOffer})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GDeleteOfferData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        deleteOffer, r'GDeleteOfferData', 'deleteOffer');
  }

  @override
  GDeleteOfferData rebuild(void Function(GDeleteOfferDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GDeleteOfferDataBuilder toBuilder() =>
      new GDeleteOfferDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GDeleteOfferData &&
        G__typename == other.G__typename &&
        deleteOffer == other.deleteOffer;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, deleteOffer.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GDeleteOfferData')
          ..add('G__typename', G__typename)
          ..add('deleteOffer', deleteOffer))
        .toString();
  }
}

class GDeleteOfferDataBuilder
    implements Builder<GDeleteOfferData, GDeleteOfferDataBuilder> {
  _$GDeleteOfferData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GDeleteOfferData_deleteOfferBuilder? _deleteOffer;
  GDeleteOfferData_deleteOfferBuilder get deleteOffer =>
      _$this._deleteOffer ??= new GDeleteOfferData_deleteOfferBuilder();
  set deleteOffer(GDeleteOfferData_deleteOfferBuilder? deleteOffer) =>
      _$this._deleteOffer = deleteOffer;

  GDeleteOfferDataBuilder() {
    GDeleteOfferData._initializeBuilder(this);
  }

  GDeleteOfferDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _deleteOffer = $v.deleteOffer.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GDeleteOfferData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GDeleteOfferData;
  }

  @override
  void update(void Function(GDeleteOfferDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GDeleteOfferData build() => _build();

  _$GDeleteOfferData _build() {
    _$GDeleteOfferData _$result;
    try {
      _$result = _$v ??
          new _$GDeleteOfferData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GDeleteOfferData', 'G__typename'),
              deleteOffer: deleteOffer.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'deleteOffer';
        deleteOffer.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GDeleteOfferData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GDeleteOfferData_deleteOffer extends GDeleteOfferData_deleteOffer {
  @override
  final String G__typename;
  @override
  final int id;

  factory _$GDeleteOfferData_deleteOffer(
          [void Function(GDeleteOfferData_deleteOfferBuilder)? updates]) =>
      (new GDeleteOfferData_deleteOfferBuilder()..update(updates))._build();

  _$GDeleteOfferData_deleteOffer._(
      {required this.G__typename, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GDeleteOfferData_deleteOffer', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GDeleteOfferData_deleteOffer', 'id');
  }

  @override
  GDeleteOfferData_deleteOffer rebuild(
          void Function(GDeleteOfferData_deleteOfferBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GDeleteOfferData_deleteOfferBuilder toBuilder() =>
      new GDeleteOfferData_deleteOfferBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GDeleteOfferData_deleteOffer &&
        G__typename == other.G__typename &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GDeleteOfferData_deleteOffer')
          ..add('G__typename', G__typename)
          ..add('id', id))
        .toString();
  }
}

class GDeleteOfferData_deleteOfferBuilder
    implements
        Builder<GDeleteOfferData_deleteOffer,
            GDeleteOfferData_deleteOfferBuilder> {
  _$GDeleteOfferData_deleteOffer? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  GDeleteOfferData_deleteOfferBuilder() {
    GDeleteOfferData_deleteOffer._initializeBuilder(this);
  }

  GDeleteOfferData_deleteOfferBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GDeleteOfferData_deleteOffer other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GDeleteOfferData_deleteOffer;
  }

  @override
  void update(void Function(GDeleteOfferData_deleteOfferBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GDeleteOfferData_deleteOffer build() => _build();

  _$GDeleteOfferData_deleteOffer _build() {
    final _$result = _$v ??
        new _$GDeleteOfferData_deleteOffer._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GDeleteOfferData_deleteOffer', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GDeleteOfferData_deleteOffer', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$GCreateNewUserDataData extends GCreateNewUserDataData {
  @override
  final String G__typename;
  @override
  final GCreateNewUserDataData_createNewUserData createNewUserData;

  factory _$GCreateNewUserDataData(
          [void Function(GCreateNewUserDataDataBuilder)? updates]) =>
      (new GCreateNewUserDataDataBuilder()..update(updates))._build();

  _$GCreateNewUserDataData._(
      {required this.G__typename, required this.createNewUserData})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GCreateNewUserDataData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        createNewUserData, r'GCreateNewUserDataData', 'createNewUserData');
  }

  @override
  GCreateNewUserDataData rebuild(
          void Function(GCreateNewUserDataDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateNewUserDataDataBuilder toBuilder() =>
      new GCreateNewUserDataDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateNewUserDataData &&
        G__typename == other.G__typename &&
        createNewUserData == other.createNewUserData;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, createNewUserData.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateNewUserDataData')
          ..add('G__typename', G__typename)
          ..add('createNewUserData', createNewUserData))
        .toString();
  }
}

class GCreateNewUserDataDataBuilder
    implements Builder<GCreateNewUserDataData, GCreateNewUserDataDataBuilder> {
  _$GCreateNewUserDataData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GCreateNewUserDataData_createNewUserDataBuilder? _createNewUserData;
  GCreateNewUserDataData_createNewUserDataBuilder get createNewUserData =>
      _$this._createNewUserData ??=
          new GCreateNewUserDataData_createNewUserDataBuilder();
  set createNewUserData(
          GCreateNewUserDataData_createNewUserDataBuilder? createNewUserData) =>
      _$this._createNewUserData = createNewUserData;

  GCreateNewUserDataDataBuilder() {
    GCreateNewUserDataData._initializeBuilder(this);
  }

  GCreateNewUserDataDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _createNewUserData = $v.createNewUserData.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateNewUserDataData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateNewUserDataData;
  }

  @override
  void update(void Function(GCreateNewUserDataDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateNewUserDataData build() => _build();

  _$GCreateNewUserDataData _build() {
    _$GCreateNewUserDataData _$result;
    try {
      _$result = _$v ??
          new _$GCreateNewUserDataData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GCreateNewUserDataData', 'G__typename'),
              createNewUserData: createNewUserData.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createNewUserData';
        createNewUserData.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GCreateNewUserDataData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GCreateNewUserDataData_createNewUserData
    extends GCreateNewUserDataData_createNewUserData {
  @override
  final String G__typename;
  @override
  final String userId;
  @override
  final String name;
  @override
  final String? imageUrl;

  factory _$GCreateNewUserDataData_createNewUserData(
          [void Function(GCreateNewUserDataData_createNewUserDataBuilder)?
              updates]) =>
      (new GCreateNewUserDataData_createNewUserDataBuilder()..update(updates))
          ._build();

  _$GCreateNewUserDataData_createNewUserData._(
      {required this.G__typename,
      required this.userId,
      required this.name,
      this.imageUrl})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(G__typename,
        r'GCreateNewUserDataData_createNewUserData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        userId, r'GCreateNewUserDataData_createNewUserData', 'userId');
    BuiltValueNullFieldError.checkNotNull(
        name, r'GCreateNewUserDataData_createNewUserData', 'name');
  }

  @override
  GCreateNewUserDataData_createNewUserData rebuild(
          void Function(GCreateNewUserDataData_createNewUserDataBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateNewUserDataData_createNewUserDataBuilder toBuilder() =>
      new GCreateNewUserDataData_createNewUserDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateNewUserDataData_createNewUserData &&
        G__typename == other.G__typename &&
        userId == other.userId &&
        name == other.name &&
        imageUrl == other.imageUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GCreateNewUserDataData_createNewUserData')
          ..add('G__typename', G__typename)
          ..add('userId', userId)
          ..add('name', name)
          ..add('imageUrl', imageUrl))
        .toString();
  }
}

class GCreateNewUserDataData_createNewUserDataBuilder
    implements
        Builder<GCreateNewUserDataData_createNewUserData,
            GCreateNewUserDataData_createNewUserDataBuilder> {
  _$GCreateNewUserDataData_createNewUserData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  GCreateNewUserDataData_createNewUserDataBuilder() {
    GCreateNewUserDataData_createNewUserData._initializeBuilder(this);
  }

  GCreateNewUserDataData_createNewUserDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _userId = $v.userId;
      _name = $v.name;
      _imageUrl = $v.imageUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateNewUserDataData_createNewUserData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateNewUserDataData_createNewUserData;
  }

  @override
  void update(
      void Function(GCreateNewUserDataData_createNewUserDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateNewUserDataData_createNewUserData build() => _build();

  _$GCreateNewUserDataData_createNewUserData _build() {
    final _$result = _$v ??
        new _$GCreateNewUserDataData_createNewUserData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GCreateNewUserDataData_createNewUserData', 'G__typename'),
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'GCreateNewUserDataData_createNewUserData', 'userId'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'GCreateNewUserDataData_createNewUserData', 'name'),
            imageUrl: imageUrl);
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateUserDataData extends GUpdateUserDataData {
  @override
  final String G__typename;
  @override
  final GUpdateUserDataData_updateUserData updateUserData;

  factory _$GUpdateUserDataData(
          [void Function(GUpdateUserDataDataBuilder)? updates]) =>
      (new GUpdateUserDataDataBuilder()..update(updates))._build();

  _$GUpdateUserDataData._(
      {required this.G__typename, required this.updateUserData})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GUpdateUserDataData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        updateUserData, r'GUpdateUserDataData', 'updateUserData');
  }

  @override
  GUpdateUserDataData rebuild(
          void Function(GUpdateUserDataDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateUserDataDataBuilder toBuilder() =>
      new GUpdateUserDataDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateUserDataData &&
        G__typename == other.G__typename &&
        updateUserData == other.updateUserData;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, updateUserData.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateUserDataData')
          ..add('G__typename', G__typename)
          ..add('updateUserData', updateUserData))
        .toString();
  }
}

class GUpdateUserDataDataBuilder
    implements Builder<GUpdateUserDataData, GUpdateUserDataDataBuilder> {
  _$GUpdateUserDataData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GUpdateUserDataData_updateUserDataBuilder? _updateUserData;
  GUpdateUserDataData_updateUserDataBuilder get updateUserData =>
      _$this._updateUserData ??=
          new GUpdateUserDataData_updateUserDataBuilder();
  set updateUserData(
          GUpdateUserDataData_updateUserDataBuilder? updateUserData) =>
      _$this._updateUserData = updateUserData;

  GUpdateUserDataDataBuilder() {
    GUpdateUserDataData._initializeBuilder(this);
  }

  GUpdateUserDataDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _updateUserData = $v.updateUserData.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateUserDataData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateUserDataData;
  }

  @override
  void update(void Function(GUpdateUserDataDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateUserDataData build() => _build();

  _$GUpdateUserDataData _build() {
    _$GUpdateUserDataData _$result;
    try {
      _$result = _$v ??
          new _$GUpdateUserDataData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GUpdateUserDataData', 'G__typename'),
              updateUserData: updateUserData.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'updateUserData';
        updateUserData.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GUpdateUserDataData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateUserDataData_updateUserData
    extends GUpdateUserDataData_updateUserData {
  @override
  final String G__typename;
  @override
  final GUpdateUserDataData_updateUserData_userInfo userInfo;

  factory _$GUpdateUserDataData_updateUserData(
          [void Function(GUpdateUserDataData_updateUserDataBuilder)?
              updates]) =>
      (new GUpdateUserDataData_updateUserDataBuilder()..update(updates))
          ._build();

  _$GUpdateUserDataData_updateUserData._(
      {required this.G__typename, required this.userInfo})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GUpdateUserDataData_updateUserData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        userInfo, r'GUpdateUserDataData_updateUserData', 'userInfo');
  }

  @override
  GUpdateUserDataData_updateUserData rebuild(
          void Function(GUpdateUserDataData_updateUserDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateUserDataData_updateUserDataBuilder toBuilder() =>
      new GUpdateUserDataData_updateUserDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateUserDataData_updateUserData &&
        G__typename == other.G__typename &&
        userInfo == other.userInfo;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, userInfo.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateUserDataData_updateUserData')
          ..add('G__typename', G__typename)
          ..add('userInfo', userInfo))
        .toString();
  }
}

class GUpdateUserDataData_updateUserDataBuilder
    implements
        Builder<GUpdateUserDataData_updateUserData,
            GUpdateUserDataData_updateUserDataBuilder> {
  _$GUpdateUserDataData_updateUserData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GUpdateUserDataData_updateUserData_userInfoBuilder? _userInfo;
  GUpdateUserDataData_updateUserData_userInfoBuilder get userInfo =>
      _$this._userInfo ??=
          new GUpdateUserDataData_updateUserData_userInfoBuilder();
  set userInfo(GUpdateUserDataData_updateUserData_userInfoBuilder? userInfo) =>
      _$this._userInfo = userInfo;

  GUpdateUserDataData_updateUserDataBuilder() {
    GUpdateUserDataData_updateUserData._initializeBuilder(this);
  }

  GUpdateUserDataData_updateUserDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _userInfo = $v.userInfo.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateUserDataData_updateUserData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateUserDataData_updateUserData;
  }

  @override
  void update(
      void Function(GUpdateUserDataData_updateUserDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateUserDataData_updateUserData build() => _build();

  _$GUpdateUserDataData_updateUserData _build() {
    _$GUpdateUserDataData_updateUserData _$result;
    try {
      _$result = _$v ??
          new _$GUpdateUserDataData_updateUserData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                  r'GUpdateUserDataData_updateUserData', 'G__typename'),
              userInfo: userInfo.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'userInfo';
        userInfo.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GUpdateUserDataData_updateUserData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateUserDataData_updateUserData_userInfo
    extends GUpdateUserDataData_updateUserData_userInfo {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String email;
  @override
  final String name;
  @override
  final String? imageUrl;
  @override
  final int fspBalance;
  @override
  final int fspBalanceTemp;
  @override
  final int credentialBalance;
  @override
  final BuiltList<String> roles;
  @override
  final String primaryRole;
  @override
  final BuiltList<GUpdateUserDataData_updateUserData_userInfo_belongsToArtists>
      belongsToArtists;
  @override
  final GUpdateUserDataData_updateUserData_userInfo_primaryArtist?
      primaryArtist;

  factory _$GUpdateUserDataData_updateUserData_userInfo(
          [void Function(GUpdateUserDataData_updateUserData_userInfoBuilder)?
              updates]) =>
      (new GUpdateUserDataData_updateUserData_userInfoBuilder()
            ..update(updates))
          ._build();

  _$GUpdateUserDataData_updateUserData_userInfo._(
      {required this.G__typename,
      required this.id,
      required this.email,
      required this.name,
      this.imageUrl,
      required this.fspBalance,
      required this.fspBalanceTemp,
      required this.credentialBalance,
      required this.roles,
      required this.primaryRole,
      required this.belongsToArtists,
      this.primaryArtist})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(G__typename,
        r'GUpdateUserDataData_updateUserData_userInfo', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GUpdateUserDataData_updateUserData_userInfo', 'id');
    BuiltValueNullFieldError.checkNotNull(
        email, r'GUpdateUserDataData_updateUserData_userInfo', 'email');
    BuiltValueNullFieldError.checkNotNull(
        name, r'GUpdateUserDataData_updateUserData_userInfo', 'name');
    BuiltValueNullFieldError.checkNotNull(fspBalance,
        r'GUpdateUserDataData_updateUserData_userInfo', 'fspBalance');
    BuiltValueNullFieldError.checkNotNull(fspBalanceTemp,
        r'GUpdateUserDataData_updateUserData_userInfo', 'fspBalanceTemp');
    BuiltValueNullFieldError.checkNotNull(credentialBalance,
        r'GUpdateUserDataData_updateUserData_userInfo', 'credentialBalance');
    BuiltValueNullFieldError.checkNotNull(
        roles, r'GUpdateUserDataData_updateUserData_userInfo', 'roles');
    BuiltValueNullFieldError.checkNotNull(primaryRole,
        r'GUpdateUserDataData_updateUserData_userInfo', 'primaryRole');
    BuiltValueNullFieldError.checkNotNull(belongsToArtists,
        r'GUpdateUserDataData_updateUserData_userInfo', 'belongsToArtists');
  }

  @override
  GUpdateUserDataData_updateUserData_userInfo rebuild(
          void Function(GUpdateUserDataData_updateUserData_userInfoBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateUserDataData_updateUserData_userInfoBuilder toBuilder() =>
      new GUpdateUserDataData_updateUserData_userInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateUserDataData_updateUserData_userInfo &&
        G__typename == other.G__typename &&
        id == other.id &&
        email == other.email &&
        name == other.name &&
        imageUrl == other.imageUrl &&
        fspBalance == other.fspBalance &&
        fspBalanceTemp == other.fspBalanceTemp &&
        credentialBalance == other.credentialBalance &&
        roles == other.roles &&
        primaryRole == other.primaryRole &&
        belongsToArtists == other.belongsToArtists &&
        primaryArtist == other.primaryArtist;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jc(_$hash, fspBalance.hashCode);
    _$hash = $jc(_$hash, fspBalanceTemp.hashCode);
    _$hash = $jc(_$hash, credentialBalance.hashCode);
    _$hash = $jc(_$hash, roles.hashCode);
    _$hash = $jc(_$hash, primaryRole.hashCode);
    _$hash = $jc(_$hash, belongsToArtists.hashCode);
    _$hash = $jc(_$hash, primaryArtist.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GUpdateUserDataData_updateUserData_userInfo')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('email', email)
          ..add('name', name)
          ..add('imageUrl', imageUrl)
          ..add('fspBalance', fspBalance)
          ..add('fspBalanceTemp', fspBalanceTemp)
          ..add('credentialBalance', credentialBalance)
          ..add('roles', roles)
          ..add('primaryRole', primaryRole)
          ..add('belongsToArtists', belongsToArtists)
          ..add('primaryArtist', primaryArtist))
        .toString();
  }
}

class GUpdateUserDataData_updateUserData_userInfoBuilder
    implements
        Builder<GUpdateUserDataData_updateUserData_userInfo,
            GUpdateUserDataData_updateUserData_userInfoBuilder> {
  _$GUpdateUserDataData_updateUserData_userInfo? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  int? _fspBalance;
  int? get fspBalance => _$this._fspBalance;
  set fspBalance(int? fspBalance) => _$this._fspBalance = fspBalance;

  int? _fspBalanceTemp;
  int? get fspBalanceTemp => _$this._fspBalanceTemp;
  set fspBalanceTemp(int? fspBalanceTemp) =>
      _$this._fspBalanceTemp = fspBalanceTemp;

  int? _credentialBalance;
  int? get credentialBalance => _$this._credentialBalance;
  set credentialBalance(int? credentialBalance) =>
      _$this._credentialBalance = credentialBalance;

  ListBuilder<String>? _roles;
  ListBuilder<String> get roles => _$this._roles ??= new ListBuilder<String>();
  set roles(ListBuilder<String>? roles) => _$this._roles = roles;

  String? _primaryRole;
  String? get primaryRole => _$this._primaryRole;
  set primaryRole(String? primaryRole) => _$this._primaryRole = primaryRole;

  ListBuilder<GUpdateUserDataData_updateUserData_userInfo_belongsToArtists>?
      _belongsToArtists;
  ListBuilder<GUpdateUserDataData_updateUserData_userInfo_belongsToArtists>
      get belongsToArtists => _$this._belongsToArtists ??= new ListBuilder<
          GUpdateUserDataData_updateUserData_userInfo_belongsToArtists>();
  set belongsToArtists(
          ListBuilder<
                  GUpdateUserDataData_updateUserData_userInfo_belongsToArtists>?
              belongsToArtists) =>
      _$this._belongsToArtists = belongsToArtists;

  GUpdateUserDataData_updateUserData_userInfo_primaryArtistBuilder?
      _primaryArtist;
  GUpdateUserDataData_updateUserData_userInfo_primaryArtistBuilder
      get primaryArtist => _$this._primaryArtist ??=
          new GUpdateUserDataData_updateUserData_userInfo_primaryArtistBuilder();
  set primaryArtist(
          GUpdateUserDataData_updateUserData_userInfo_primaryArtistBuilder?
              primaryArtist) =>
      _$this._primaryArtist = primaryArtist;

  GUpdateUserDataData_updateUserData_userInfoBuilder() {
    GUpdateUserDataData_updateUserData_userInfo._initializeBuilder(this);
  }

  GUpdateUserDataData_updateUserData_userInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _email = $v.email;
      _name = $v.name;
      _imageUrl = $v.imageUrl;
      _fspBalance = $v.fspBalance;
      _fspBalanceTemp = $v.fspBalanceTemp;
      _credentialBalance = $v.credentialBalance;
      _roles = $v.roles.toBuilder();
      _primaryRole = $v.primaryRole;
      _belongsToArtists = $v.belongsToArtists.toBuilder();
      _primaryArtist = $v.primaryArtist?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateUserDataData_updateUserData_userInfo other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateUserDataData_updateUserData_userInfo;
  }

  @override
  void update(
      void Function(GUpdateUserDataData_updateUserData_userInfoBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateUserDataData_updateUserData_userInfo build() => _build();

  _$GUpdateUserDataData_updateUserData_userInfo _build() {
    _$GUpdateUserDataData_updateUserData_userInfo _$result;
    try {
      _$result = _$v ??
          new _$GUpdateUserDataData_updateUserData_userInfo._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GUpdateUserDataData_updateUserData_userInfo', 'G__typename'),
              id: BuiltValueNullFieldError.checkNotNull(
                  id, r'GUpdateUserDataData_updateUserData_userInfo', 'id'),
              email: BuiltValueNullFieldError.checkNotNull(
                  email, r'GUpdateUserDataData_updateUserData_userInfo', 'email'),
              name: BuiltValueNullFieldError.checkNotNull(
                  name, r'GUpdateUserDataData_updateUserData_userInfo', 'name'),
              imageUrl: imageUrl,
              fspBalance: BuiltValueNullFieldError.checkNotNull(
                  fspBalance, r'GUpdateUserDataData_updateUserData_userInfo', 'fspBalance'),
              fspBalanceTemp: BuiltValueNullFieldError.checkNotNull(
                  fspBalanceTemp, r'GUpdateUserDataData_updateUserData_userInfo', 'fspBalanceTemp'),
              credentialBalance: BuiltValueNullFieldError.checkNotNull(
                  credentialBalance, r'GUpdateUserDataData_updateUserData_userInfo', 'credentialBalance'),
              roles: roles.build(),
              primaryRole: BuiltValueNullFieldError.checkNotNull(primaryRole, r'GUpdateUserDataData_updateUserData_userInfo', 'primaryRole'),
              belongsToArtists: belongsToArtists.build(),
              primaryArtist: _primaryArtist?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'roles';
        roles.build();

        _$failedField = 'belongsToArtists';
        belongsToArtists.build();
        _$failedField = 'primaryArtist';
        _primaryArtist?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GUpdateUserDataData_updateUserData_userInfo',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateUserDataData_updateUserData_userInfo_belongsToArtists
    extends GUpdateUserDataData_updateUserData_userInfo_belongsToArtists {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String name;
  @override
  final String? imageUrl;
  @override
  final bool isAccepted;

  factory _$GUpdateUserDataData_updateUserData_userInfo_belongsToArtists(
          [void Function(
                  GUpdateUserDataData_updateUserData_userInfo_belongsToArtistsBuilder)?
              updates]) =>
      (new GUpdateUserDataData_updateUserData_userInfo_belongsToArtistsBuilder()
            ..update(updates))
          ._build();

  _$GUpdateUserDataData_updateUserData_userInfo_belongsToArtists._(
      {required this.G__typename,
      required this.id,
      required this.name,
      this.imageUrl,
      required this.isAccepted})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename,
        r'GUpdateUserDataData_updateUserData_userInfo_belongsToArtists',
        'G__typename');
    BuiltValueNullFieldError.checkNotNull(id,
        r'GUpdateUserDataData_updateUserData_userInfo_belongsToArtists', 'id');
    BuiltValueNullFieldError.checkNotNull(
        name,
        r'GUpdateUserDataData_updateUserData_userInfo_belongsToArtists',
        'name');
    BuiltValueNullFieldError.checkNotNull(
        isAccepted,
        r'GUpdateUserDataData_updateUserData_userInfo_belongsToArtists',
        'isAccepted');
  }

  @override
  GUpdateUserDataData_updateUserData_userInfo_belongsToArtists rebuild(
          void Function(
                  GUpdateUserDataData_updateUserData_userInfo_belongsToArtistsBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateUserDataData_updateUserData_userInfo_belongsToArtistsBuilder
      toBuilder() =>
          new GUpdateUserDataData_updateUserData_userInfo_belongsToArtistsBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GUpdateUserDataData_updateUserData_userInfo_belongsToArtists &&
        G__typename == other.G__typename &&
        id == other.id &&
        name == other.name &&
        imageUrl == other.imageUrl &&
        isAccepted == other.isAccepted;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jc(_$hash, isAccepted.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GUpdateUserDataData_updateUserData_userInfo_belongsToArtists')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name)
          ..add('imageUrl', imageUrl)
          ..add('isAccepted', isAccepted))
        .toString();
  }
}

class GUpdateUserDataData_updateUserData_userInfo_belongsToArtistsBuilder
    implements
        Builder<GUpdateUserDataData_updateUserData_userInfo_belongsToArtists,
            GUpdateUserDataData_updateUserData_userInfo_belongsToArtistsBuilder> {
  _$GUpdateUserDataData_updateUserData_userInfo_belongsToArtists? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  bool? _isAccepted;
  bool? get isAccepted => _$this._isAccepted;
  set isAccepted(bool? isAccepted) => _$this._isAccepted = isAccepted;

  GUpdateUserDataData_updateUserData_userInfo_belongsToArtistsBuilder() {
    GUpdateUserDataData_updateUserData_userInfo_belongsToArtists
        ._initializeBuilder(this);
  }

  GUpdateUserDataData_updateUserData_userInfo_belongsToArtistsBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _name = $v.name;
      _imageUrl = $v.imageUrl;
      _isAccepted = $v.isAccepted;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GUpdateUserDataData_updateUserData_userInfo_belongsToArtists other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v =
        other as _$GUpdateUserDataData_updateUserData_userInfo_belongsToArtists;
  }

  @override
  void update(
      void Function(
              GUpdateUserDataData_updateUserData_userInfo_belongsToArtistsBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateUserDataData_updateUserData_userInfo_belongsToArtists build() =>
      _build();

  _$GUpdateUserDataData_updateUserData_userInfo_belongsToArtists _build() {
    final _$result = _$v ??
        new _$GUpdateUserDataData_updateUserData_userInfo_belongsToArtists._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GUpdateUserDataData_updateUserData_userInfo_belongsToArtists',
                'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(id,
                r'GUpdateUserDataData_updateUserData_userInfo_belongsToArtists', 'id'),
            name: BuiltValueNullFieldError.checkNotNull(
                name,
                r'GUpdateUserDataData_updateUserData_userInfo_belongsToArtists',
                'name'),
            imageUrl: imageUrl,
            isAccepted: BuiltValueNullFieldError.checkNotNull(
                isAccepted,
                r'GUpdateUserDataData_updateUserData_userInfo_belongsToArtists',
                'isAccepted'));
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateUserDataData_updateUserData_userInfo_primaryArtist
    extends GUpdateUserDataData_updateUserData_userInfo_primaryArtist {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String name;
  @override
  final String? imageUrl;
  @override
  final bool isAccepted;

  factory _$GUpdateUserDataData_updateUserData_userInfo_primaryArtist(
          [void Function(
                  GUpdateUserDataData_updateUserData_userInfo_primaryArtistBuilder)?
              updates]) =>
      (new GUpdateUserDataData_updateUserData_userInfo_primaryArtistBuilder()
            ..update(updates))
          ._build();

  _$GUpdateUserDataData_updateUserData_userInfo_primaryArtist._(
      {required this.G__typename,
      required this.id,
      required this.name,
      this.imageUrl,
      required this.isAccepted})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename,
        r'GUpdateUserDataData_updateUserData_userInfo_primaryArtist',
        'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GUpdateUserDataData_updateUserData_userInfo_primaryArtist', 'id');
    BuiltValueNullFieldError.checkNotNull(name,
        r'GUpdateUserDataData_updateUserData_userInfo_primaryArtist', 'name');
    BuiltValueNullFieldError.checkNotNull(
        isAccepted,
        r'GUpdateUserDataData_updateUserData_userInfo_primaryArtist',
        'isAccepted');
  }

  @override
  GUpdateUserDataData_updateUserData_userInfo_primaryArtist rebuild(
          void Function(
                  GUpdateUserDataData_updateUserData_userInfo_primaryArtistBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateUserDataData_updateUserData_userInfo_primaryArtistBuilder
      toBuilder() =>
          new GUpdateUserDataData_updateUserData_userInfo_primaryArtistBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateUserDataData_updateUserData_userInfo_primaryArtist &&
        G__typename == other.G__typename &&
        id == other.id &&
        name == other.name &&
        imageUrl == other.imageUrl &&
        isAccepted == other.isAccepted;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jc(_$hash, isAccepted.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GUpdateUserDataData_updateUserData_userInfo_primaryArtist')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name)
          ..add('imageUrl', imageUrl)
          ..add('isAccepted', isAccepted))
        .toString();
  }
}

class GUpdateUserDataData_updateUserData_userInfo_primaryArtistBuilder
    implements
        Builder<GUpdateUserDataData_updateUserData_userInfo_primaryArtist,
            GUpdateUserDataData_updateUserData_userInfo_primaryArtistBuilder> {
  _$GUpdateUserDataData_updateUserData_userInfo_primaryArtist? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  bool? _isAccepted;
  bool? get isAccepted => _$this._isAccepted;
  set isAccepted(bool? isAccepted) => _$this._isAccepted = isAccepted;

  GUpdateUserDataData_updateUserData_userInfo_primaryArtistBuilder() {
    GUpdateUserDataData_updateUserData_userInfo_primaryArtist
        ._initializeBuilder(this);
  }

  GUpdateUserDataData_updateUserData_userInfo_primaryArtistBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _name = $v.name;
      _imageUrl = $v.imageUrl;
      _isAccepted = $v.isAccepted;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GUpdateUserDataData_updateUserData_userInfo_primaryArtist other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateUserDataData_updateUserData_userInfo_primaryArtist;
  }

  @override
  void update(
      void Function(
              GUpdateUserDataData_updateUserData_userInfo_primaryArtistBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateUserDataData_updateUserData_userInfo_primaryArtist build() => _build();

  _$GUpdateUserDataData_updateUserData_userInfo_primaryArtist _build() {
    final _$result = _$v ??
        new _$GUpdateUserDataData_updateUserData_userInfo_primaryArtist._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GUpdateUserDataData_updateUserData_userInfo_primaryArtist',
                'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id,
                r'GUpdateUserDataData_updateUserData_userInfo_primaryArtist',
                'id'),
            name: BuiltValueNullFieldError.checkNotNull(
                name,
                r'GUpdateUserDataData_updateUserData_userInfo_primaryArtist',
                'name'),
            imageUrl: imageUrl,
            isAccepted: BuiltValueNullFieldError.checkNotNull(
                isAccepted,
                r'GUpdateUserDataData_updateUserData_userInfo_primaryArtist',
                'isAccepted'));
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateBelongsToArtistStatusData
    extends GUpdateBelongsToArtistStatusData {
  @override
  final String G__typename;
  @override
  final GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus
      updateBelongsToArtistStatus;

  factory _$GUpdateBelongsToArtistStatusData(
          [void Function(GUpdateBelongsToArtistStatusDataBuilder)? updates]) =>
      (new GUpdateBelongsToArtistStatusDataBuilder()..update(updates))._build();

  _$GUpdateBelongsToArtistStatusData._(
      {required this.G__typename, required this.updateBelongsToArtistStatus})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GUpdateBelongsToArtistStatusData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(updateBelongsToArtistStatus,
        r'GUpdateBelongsToArtistStatusData', 'updateBelongsToArtistStatus');
  }

  @override
  GUpdateBelongsToArtistStatusData rebuild(
          void Function(GUpdateBelongsToArtistStatusDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateBelongsToArtistStatusDataBuilder toBuilder() =>
      new GUpdateBelongsToArtistStatusDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateBelongsToArtistStatusData &&
        G__typename == other.G__typename &&
        updateBelongsToArtistStatus == other.updateBelongsToArtistStatus;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, updateBelongsToArtistStatus.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateBelongsToArtistStatusData')
          ..add('G__typename', G__typename)
          ..add('updateBelongsToArtistStatus', updateBelongsToArtistStatus))
        .toString();
  }
}

class GUpdateBelongsToArtistStatusDataBuilder
    implements
        Builder<GUpdateBelongsToArtistStatusData,
            GUpdateBelongsToArtistStatusDataBuilder> {
  _$GUpdateBelongsToArtistStatusData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatusBuilder?
      _updateBelongsToArtistStatus;
  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatusBuilder
      get updateBelongsToArtistStatus => _$this._updateBelongsToArtistStatus ??=
          new GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatusBuilder();
  set updateBelongsToArtistStatus(
          GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatusBuilder?
              updateBelongsToArtistStatus) =>
      _$this._updateBelongsToArtistStatus = updateBelongsToArtistStatus;

  GUpdateBelongsToArtistStatusDataBuilder() {
    GUpdateBelongsToArtistStatusData._initializeBuilder(this);
  }

  GUpdateBelongsToArtistStatusDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _updateBelongsToArtistStatus = $v.updateBelongsToArtistStatus.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateBelongsToArtistStatusData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateBelongsToArtistStatusData;
  }

  @override
  void update(void Function(GUpdateBelongsToArtistStatusDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateBelongsToArtistStatusData build() => _build();

  _$GUpdateBelongsToArtistStatusData _build() {
    _$GUpdateBelongsToArtistStatusData _$result;
    try {
      _$result = _$v ??
          new _$GUpdateBelongsToArtistStatusData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                  r'GUpdateBelongsToArtistStatusData', 'G__typename'),
              updateBelongsToArtistStatus: updateBelongsToArtistStatus.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'updateBelongsToArtistStatus';
        updateBelongsToArtistStatus.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GUpdateBelongsToArtistStatusData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus
    extends GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus {
  @override
  final String G__typename;
  @override
  final GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList
      artistList;

  factory _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus(
          [void Function(
                  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatusBuilder)?
              updates]) =>
      (new GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatusBuilder()
            ..update(updates))
          ._build();

  _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus._(
      {required this.G__typename, required this.artistList})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename,
        r'GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus',
        'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        artistList,
        r'GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus',
        'artistList');
  }

  @override
  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus rebuild(
          void Function(
                  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatusBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatusBuilder
      toBuilder() =>
          new GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatusBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus &&
        G__typename == other.G__typename &&
        artistList == other.artistList;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, artistList.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus')
          ..add('G__typename', G__typename)
          ..add('artistList', artistList))
        .toString();
  }
}

class GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatusBuilder
    implements
        Builder<GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus,
            GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatusBuilder> {
  _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistListBuilder?
      _artistList;
  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistListBuilder
      get artistList => _$this._artistList ??=
          new GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistListBuilder();
  set artistList(
          GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistListBuilder?
              artistList) =>
      _$this._artistList = artistList;

  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatusBuilder() {
    GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus
        ._initializeBuilder(this);
  }

  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatusBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _artistList = $v.artistList.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v =
        other as _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus;
  }

  @override
  void update(
      void Function(
              GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatusBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus build() =>
      _build();

  _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus _build() {
    _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus _$result;
    try {
      _$result = _$v ??
          new _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename,
                  r'GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus',
                  'G__typename'),
              artistList: artistList.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'artistList';
        artistList.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList
    extends GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList {
  @override
  final String G__typename;
  @override
  final BuiltList<
          GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList>
      artistList;

  factory _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList(
          [void Function(
                  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistListBuilder)?
              updates]) =>
      (new GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistListBuilder()
            ..update(updates))
          ._build();

  _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList._(
      {required this.G__typename, required this.artistList})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename,
        r'GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList',
        'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        artistList,
        r'GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList',
        'artistList');
  }

  @override
  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList rebuild(
          void Function(
                  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistListBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistListBuilder
      toBuilder() =>
          new GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistListBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList &&
        G__typename == other.G__typename &&
        artistList == other.artistList;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, artistList.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList')
          ..add('G__typename', G__typename)
          ..add('artistList', artistList))
        .toString();
  }
}

class GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistListBuilder
    implements
        Builder<
            GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList,
            GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistListBuilder> {
  _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList?
      _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<
          GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList>?
      _artistList;
  ListBuilder<
          GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList>
      get artistList => _$this._artistList ??= new ListBuilder<
          GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList>();
  set artistList(
          ListBuilder<
                  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList>?
              artistList) =>
      _$this._artistList = artistList;

  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistListBuilder() {
    GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList
        ._initializeBuilder(this);
  }

  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistListBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _artistList = $v.artistList.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList
          other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other
        as _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList;
  }

  @override
  void update(
      void Function(
              GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistListBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList
      build() => _build();

  _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList
      _build() {
    _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList
        _$result;
    try {
      _$result = _$v ??
          new _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList
              ._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename,
                  r'GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList',
                  'G__typename'),
              artistList: artistList.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'artistList';
        artistList.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList
    extends GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String name;
  @override
  final String? imageUrl;
  @override
  final bool isAccepted;

  factory _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList(
          [void Function(
                  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistListBuilder)?
              updates]) =>
      (new GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistListBuilder()
            ..update(updates))
          ._build();

  _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList._(
      {required this.G__typename,
      required this.id,
      required this.name,
      this.imageUrl,
      required this.isAccepted})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename,
        r'GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList',
        'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id,
        r'GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList',
        'id');
    BuiltValueNullFieldError.checkNotNull(
        name,
        r'GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList',
        'name');
    BuiltValueNullFieldError.checkNotNull(
        isAccepted,
        r'GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList',
        'isAccepted');
  }

  @override
  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList
      rebuild(
              void Function(
                      GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistListBuilder)
                  updates) =>
          (toBuilder()..update(updates)).build();

  @override
  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistListBuilder
      toBuilder() =>
          new GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistListBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList &&
        G__typename == other.G__typename &&
        id == other.id &&
        name == other.name &&
        imageUrl == other.imageUrl &&
        isAccepted == other.isAccepted;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jc(_$hash, isAccepted.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name)
          ..add('imageUrl', imageUrl)
          ..add('isAccepted', isAccepted))
        .toString();
  }
}

class GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistListBuilder
    implements
        Builder<
            GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList,
            GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistListBuilder> {
  _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList?
      _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  bool? _isAccepted;
  bool? get isAccepted => _$this._isAccepted;
  set isAccepted(bool? isAccepted) => _$this._isAccepted = isAccepted;

  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistListBuilder() {
    GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList
        ._initializeBuilder(this);
  }

  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistListBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _name = $v.name;
      _imageUrl = $v.imageUrl;
      _isAccepted = $v.isAccepted;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList
          other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other
        as _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList;
  }

  @override
  void update(
      void Function(
              GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistListBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList
      build() => _build();

  _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList
      _build() {
    final _$result = _$v ??
        new _$GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList',
                'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(id,
                r'GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList', 'id'),
            name: BuiltValueNullFieldError.checkNotNull(
                name,
                r'GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList',
                'name'),
            imageUrl: imageUrl,
            isAccepted: BuiltValueNullFieldError.checkNotNull(
                isAccepted,
                r'GUpdateBelongsToArtistStatusData_updateBelongsToArtistStatus_artistList_artistList',
                'isAccepted'));
    replace(_$result);
    return _$result;
  }
}

class _$GContactToAdminData extends GContactToAdminData {
  @override
  final String G__typename;
  @override
  final GContactToAdminData_contactToAdmin contactToAdmin;

  factory _$GContactToAdminData(
          [void Function(GContactToAdminDataBuilder)? updates]) =>
      (new GContactToAdminDataBuilder()..update(updates))._build();

  _$GContactToAdminData._(
      {required this.G__typename, required this.contactToAdmin})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GContactToAdminData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        contactToAdmin, r'GContactToAdminData', 'contactToAdmin');
  }

  @override
  GContactToAdminData rebuild(
          void Function(GContactToAdminDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GContactToAdminDataBuilder toBuilder() =>
      new GContactToAdminDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GContactToAdminData &&
        G__typename == other.G__typename &&
        contactToAdmin == other.contactToAdmin;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, contactToAdmin.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GContactToAdminData')
          ..add('G__typename', G__typename)
          ..add('contactToAdmin', contactToAdmin))
        .toString();
  }
}

class GContactToAdminDataBuilder
    implements Builder<GContactToAdminData, GContactToAdminDataBuilder> {
  _$GContactToAdminData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GContactToAdminData_contactToAdminBuilder? _contactToAdmin;
  GContactToAdminData_contactToAdminBuilder get contactToAdmin =>
      _$this._contactToAdmin ??=
          new GContactToAdminData_contactToAdminBuilder();
  set contactToAdmin(
          GContactToAdminData_contactToAdminBuilder? contactToAdmin) =>
      _$this._contactToAdmin = contactToAdmin;

  GContactToAdminDataBuilder() {
    GContactToAdminData._initializeBuilder(this);
  }

  GContactToAdminDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _contactToAdmin = $v.contactToAdmin.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GContactToAdminData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GContactToAdminData;
  }

  @override
  void update(void Function(GContactToAdminDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GContactToAdminData build() => _build();

  _$GContactToAdminData _build() {
    _$GContactToAdminData _$result;
    try {
      _$result = _$v ??
          new _$GContactToAdminData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GContactToAdminData', 'G__typename'),
              contactToAdmin: contactToAdmin.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'contactToAdmin';
        contactToAdmin.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GContactToAdminData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GContactToAdminData_contactToAdmin
    extends GContactToAdminData_contactToAdmin {
  @override
  final String G__typename;
  @override
  final String id;

  factory _$GContactToAdminData_contactToAdmin(
          [void Function(GContactToAdminData_contactToAdminBuilder)?
              updates]) =>
      (new GContactToAdminData_contactToAdminBuilder()..update(updates))
          ._build();

  _$GContactToAdminData_contactToAdmin._(
      {required this.G__typename, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GContactToAdminData_contactToAdmin', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GContactToAdminData_contactToAdmin', 'id');
  }

  @override
  GContactToAdminData_contactToAdmin rebuild(
          void Function(GContactToAdminData_contactToAdminBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GContactToAdminData_contactToAdminBuilder toBuilder() =>
      new GContactToAdminData_contactToAdminBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GContactToAdminData_contactToAdmin &&
        G__typename == other.G__typename &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GContactToAdminData_contactToAdmin')
          ..add('G__typename', G__typename)
          ..add('id', id))
        .toString();
  }
}

class GContactToAdminData_contactToAdminBuilder
    implements
        Builder<GContactToAdminData_contactToAdmin,
            GContactToAdminData_contactToAdminBuilder> {
  _$GContactToAdminData_contactToAdmin? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  GContactToAdminData_contactToAdminBuilder() {
    GContactToAdminData_contactToAdmin._initializeBuilder(this);
  }

  GContactToAdminData_contactToAdminBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GContactToAdminData_contactToAdmin other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GContactToAdminData_contactToAdmin;
  }

  @override
  void update(
      void Function(GContactToAdminData_contactToAdminBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GContactToAdminData_contactToAdmin build() => _build();

  _$GContactToAdminData_contactToAdmin _build() {
    final _$result = _$v ??
        new _$GContactToAdminData_contactToAdmin._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GContactToAdminData_contactToAdmin', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GContactToAdminData_contactToAdmin', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$GCreateNewNotificationData extends GCreateNewNotificationData {
  @override
  final String G__typename;
  @override
  final GCreateNewNotificationData_createNewNotification createNewNotification;

  factory _$GCreateNewNotificationData(
          [void Function(GCreateNewNotificationDataBuilder)? updates]) =>
      (new GCreateNewNotificationDataBuilder()..update(updates))._build();

  _$GCreateNewNotificationData._(
      {required this.G__typename, required this.createNewNotification})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GCreateNewNotificationData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(createNewNotification,
        r'GCreateNewNotificationData', 'createNewNotification');
  }

  @override
  GCreateNewNotificationData rebuild(
          void Function(GCreateNewNotificationDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateNewNotificationDataBuilder toBuilder() =>
      new GCreateNewNotificationDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateNewNotificationData &&
        G__typename == other.G__typename &&
        createNewNotification == other.createNewNotification;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, createNewNotification.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateNewNotificationData')
          ..add('G__typename', G__typename)
          ..add('createNewNotification', createNewNotification))
        .toString();
  }
}

class GCreateNewNotificationDataBuilder
    implements
        Builder<GCreateNewNotificationData, GCreateNewNotificationDataBuilder> {
  _$GCreateNewNotificationData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GCreateNewNotificationData_createNewNotificationBuilder?
      _createNewNotification;
  GCreateNewNotificationData_createNewNotificationBuilder
      get createNewNotification => _$this._createNewNotification ??=
          new GCreateNewNotificationData_createNewNotificationBuilder();
  set createNewNotification(
          GCreateNewNotificationData_createNewNotificationBuilder?
              createNewNotification) =>
      _$this._createNewNotification = createNewNotification;

  GCreateNewNotificationDataBuilder() {
    GCreateNewNotificationData._initializeBuilder(this);
  }

  GCreateNewNotificationDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _createNewNotification = $v.createNewNotification.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateNewNotificationData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateNewNotificationData;
  }

  @override
  void update(void Function(GCreateNewNotificationDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateNewNotificationData build() => _build();

  _$GCreateNewNotificationData _build() {
    _$GCreateNewNotificationData _$result;
    try {
      _$result = _$v ??
          new _$GCreateNewNotificationData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GCreateNewNotificationData', 'G__typename'),
              createNewNotification: createNewNotification.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createNewNotification';
        createNewNotification.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GCreateNewNotificationData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GCreateNewNotificationData_createNewNotification
    extends GCreateNewNotificationData_createNewNotification {
  @override
  final String G__typename;
  @override
  final String id;

  factory _$GCreateNewNotificationData_createNewNotification(
          [void Function(
                  GCreateNewNotificationData_createNewNotificationBuilder)?
              updates]) =>
      (new GCreateNewNotificationData_createNewNotificationBuilder()
            ..update(updates))
          ._build();

  _$GCreateNewNotificationData_createNewNotification._(
      {required this.G__typename, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(G__typename,
        r'GCreateNewNotificationData_createNewNotification', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GCreateNewNotificationData_createNewNotification', 'id');
  }

  @override
  GCreateNewNotificationData_createNewNotification rebuild(
          void Function(GCreateNewNotificationData_createNewNotificationBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateNewNotificationData_createNewNotificationBuilder toBuilder() =>
      new GCreateNewNotificationData_createNewNotificationBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateNewNotificationData_createNewNotification &&
        G__typename == other.G__typename &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GCreateNewNotificationData_createNewNotification')
          ..add('G__typename', G__typename)
          ..add('id', id))
        .toString();
  }
}

class GCreateNewNotificationData_createNewNotificationBuilder
    implements
        Builder<GCreateNewNotificationData_createNewNotification,
            GCreateNewNotificationData_createNewNotificationBuilder> {
  _$GCreateNewNotificationData_createNewNotification? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  GCreateNewNotificationData_createNewNotificationBuilder() {
    GCreateNewNotificationData_createNewNotification._initializeBuilder(this);
  }

  GCreateNewNotificationData_createNewNotificationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateNewNotificationData_createNewNotification other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateNewNotificationData_createNewNotification;
  }

  @override
  void update(
      void Function(GCreateNewNotificationData_createNewNotificationBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateNewNotificationData_createNewNotification build() => _build();

  _$GCreateNewNotificationData_createNewNotification _build() {
    final _$result = _$v ??
        new _$GCreateNewNotificationData_createNewNotification._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GCreateNewNotificationData_createNewNotification',
                'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GCreateNewNotificationData_createNewNotification', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateNotificationData extends GUpdateNotificationData {
  @override
  final String G__typename;
  @override
  final GUpdateNotificationData_updateNotification updateNotification;

  factory _$GUpdateNotificationData(
          [void Function(GUpdateNotificationDataBuilder)? updates]) =>
      (new GUpdateNotificationDataBuilder()..update(updates))._build();

  _$GUpdateNotificationData._(
      {required this.G__typename, required this.updateNotification})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GUpdateNotificationData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        updateNotification, r'GUpdateNotificationData', 'updateNotification');
  }

  @override
  GUpdateNotificationData rebuild(
          void Function(GUpdateNotificationDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateNotificationDataBuilder toBuilder() =>
      new GUpdateNotificationDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateNotificationData &&
        G__typename == other.G__typename &&
        updateNotification == other.updateNotification;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, updateNotification.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateNotificationData')
          ..add('G__typename', G__typename)
          ..add('updateNotification', updateNotification))
        .toString();
  }
}

class GUpdateNotificationDataBuilder
    implements
        Builder<GUpdateNotificationData, GUpdateNotificationDataBuilder> {
  _$GUpdateNotificationData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GUpdateNotificationData_updateNotificationBuilder? _updateNotification;
  GUpdateNotificationData_updateNotificationBuilder get updateNotification =>
      _$this._updateNotification ??=
          new GUpdateNotificationData_updateNotificationBuilder();
  set updateNotification(
          GUpdateNotificationData_updateNotificationBuilder?
              updateNotification) =>
      _$this._updateNotification = updateNotification;

  GUpdateNotificationDataBuilder() {
    GUpdateNotificationData._initializeBuilder(this);
  }

  GUpdateNotificationDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _updateNotification = $v.updateNotification.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateNotificationData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateNotificationData;
  }

  @override
  void update(void Function(GUpdateNotificationDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateNotificationData build() => _build();

  _$GUpdateNotificationData _build() {
    _$GUpdateNotificationData _$result;
    try {
      _$result = _$v ??
          new _$GUpdateNotificationData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GUpdateNotificationData', 'G__typename'),
              updateNotification: updateNotification.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'updateNotification';
        updateNotification.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GUpdateNotificationData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateNotificationData_updateNotification
    extends GUpdateNotificationData_updateNotification {
  @override
  final String G__typename;
  @override
  final String id;

  factory _$GUpdateNotificationData_updateNotification(
          [void Function(GUpdateNotificationData_updateNotificationBuilder)?
              updates]) =>
      (new GUpdateNotificationData_updateNotificationBuilder()..update(updates))
          ._build();

  _$GUpdateNotificationData_updateNotification._(
      {required this.G__typename, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(G__typename,
        r'GUpdateNotificationData_updateNotification', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GUpdateNotificationData_updateNotification', 'id');
  }

  @override
  GUpdateNotificationData_updateNotification rebuild(
          void Function(GUpdateNotificationData_updateNotificationBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateNotificationData_updateNotificationBuilder toBuilder() =>
      new GUpdateNotificationData_updateNotificationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateNotificationData_updateNotification &&
        G__typename == other.G__typename &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GUpdateNotificationData_updateNotification')
          ..add('G__typename', G__typename)
          ..add('id', id))
        .toString();
  }
}

class GUpdateNotificationData_updateNotificationBuilder
    implements
        Builder<GUpdateNotificationData_updateNotification,
            GUpdateNotificationData_updateNotificationBuilder> {
  _$GUpdateNotificationData_updateNotification? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  GUpdateNotificationData_updateNotificationBuilder() {
    GUpdateNotificationData_updateNotification._initializeBuilder(this);
  }

  GUpdateNotificationData_updateNotificationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateNotificationData_updateNotification other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateNotificationData_updateNotification;
  }

  @override
  void update(
      void Function(GUpdateNotificationData_updateNotificationBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateNotificationData_updateNotification build() => _build();

  _$GUpdateNotificationData_updateNotification _build() {
    final _$result = _$v ??
        new _$GUpdateNotificationData_updateNotification._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GUpdateNotificationData_updateNotification', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GUpdateNotificationData_updateNotification', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$GDeleteNotificationData extends GDeleteNotificationData {
  @override
  final String G__typename;
  @override
  final GDeleteNotificationData_deleteNotification deleteNotification;

  factory _$GDeleteNotificationData(
          [void Function(GDeleteNotificationDataBuilder)? updates]) =>
      (new GDeleteNotificationDataBuilder()..update(updates))._build();

  _$GDeleteNotificationData._(
      {required this.G__typename, required this.deleteNotification})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GDeleteNotificationData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        deleteNotification, r'GDeleteNotificationData', 'deleteNotification');
  }

  @override
  GDeleteNotificationData rebuild(
          void Function(GDeleteNotificationDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GDeleteNotificationDataBuilder toBuilder() =>
      new GDeleteNotificationDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GDeleteNotificationData &&
        G__typename == other.G__typename &&
        deleteNotification == other.deleteNotification;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, deleteNotification.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GDeleteNotificationData')
          ..add('G__typename', G__typename)
          ..add('deleteNotification', deleteNotification))
        .toString();
  }
}

class GDeleteNotificationDataBuilder
    implements
        Builder<GDeleteNotificationData, GDeleteNotificationDataBuilder> {
  _$GDeleteNotificationData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GDeleteNotificationData_deleteNotificationBuilder? _deleteNotification;
  GDeleteNotificationData_deleteNotificationBuilder get deleteNotification =>
      _$this._deleteNotification ??=
          new GDeleteNotificationData_deleteNotificationBuilder();
  set deleteNotification(
          GDeleteNotificationData_deleteNotificationBuilder?
              deleteNotification) =>
      _$this._deleteNotification = deleteNotification;

  GDeleteNotificationDataBuilder() {
    GDeleteNotificationData._initializeBuilder(this);
  }

  GDeleteNotificationDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _deleteNotification = $v.deleteNotification.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GDeleteNotificationData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GDeleteNotificationData;
  }

  @override
  void update(void Function(GDeleteNotificationDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GDeleteNotificationData build() => _build();

  _$GDeleteNotificationData _build() {
    _$GDeleteNotificationData _$result;
    try {
      _$result = _$v ??
          new _$GDeleteNotificationData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GDeleteNotificationData', 'G__typename'),
              deleteNotification: deleteNotification.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'deleteNotification';
        deleteNotification.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GDeleteNotificationData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GDeleteNotificationData_deleteNotification
    extends GDeleteNotificationData_deleteNotification {
  @override
  final String G__typename;
  @override
  final String id;

  factory _$GDeleteNotificationData_deleteNotification(
          [void Function(GDeleteNotificationData_deleteNotificationBuilder)?
              updates]) =>
      (new GDeleteNotificationData_deleteNotificationBuilder()..update(updates))
          ._build();

  _$GDeleteNotificationData_deleteNotification._(
      {required this.G__typename, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(G__typename,
        r'GDeleteNotificationData_deleteNotification', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GDeleteNotificationData_deleteNotification', 'id');
  }

  @override
  GDeleteNotificationData_deleteNotification rebuild(
          void Function(GDeleteNotificationData_deleteNotificationBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GDeleteNotificationData_deleteNotificationBuilder toBuilder() =>
      new GDeleteNotificationData_deleteNotificationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GDeleteNotificationData_deleteNotification &&
        G__typename == other.G__typename &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GDeleteNotificationData_deleteNotification')
          ..add('G__typename', G__typename)
          ..add('id', id))
        .toString();
  }
}

class GDeleteNotificationData_deleteNotificationBuilder
    implements
        Builder<GDeleteNotificationData_deleteNotification,
            GDeleteNotificationData_deleteNotificationBuilder> {
  _$GDeleteNotificationData_deleteNotification? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  GDeleteNotificationData_deleteNotificationBuilder() {
    GDeleteNotificationData_deleteNotification._initializeBuilder(this);
  }

  GDeleteNotificationData_deleteNotificationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GDeleteNotificationData_deleteNotification other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GDeleteNotificationData_deleteNotification;
  }

  @override
  void update(
      void Function(GDeleteNotificationData_deleteNotificationBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GDeleteNotificationData_deleteNotification build() => _build();

  _$GDeleteNotificationData_deleteNotification _build() {
    final _$result = _$v ??
        new _$GDeleteNotificationData_deleteNotification._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GDeleteNotificationData_deleteNotification', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GDeleteNotificationData_deleteNotification', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$GCreateFspTxData extends GCreateFspTxData {
  @override
  final String G__typename;
  @override
  final GCreateFspTxData_createFspTx createFspTx;

  factory _$GCreateFspTxData(
          [void Function(GCreateFspTxDataBuilder)? updates]) =>
      (new GCreateFspTxDataBuilder()..update(updates))._build();

  _$GCreateFspTxData._({required this.G__typename, required this.createFspTx})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GCreateFspTxData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        createFspTx, r'GCreateFspTxData', 'createFspTx');
  }

  @override
  GCreateFspTxData rebuild(void Function(GCreateFspTxDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateFspTxDataBuilder toBuilder() =>
      new GCreateFspTxDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateFspTxData &&
        G__typename == other.G__typename &&
        createFspTx == other.createFspTx;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, createFspTx.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateFspTxData')
          ..add('G__typename', G__typename)
          ..add('createFspTx', createFspTx))
        .toString();
  }
}

class GCreateFspTxDataBuilder
    implements Builder<GCreateFspTxData, GCreateFspTxDataBuilder> {
  _$GCreateFspTxData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GCreateFspTxData_createFspTxBuilder? _createFspTx;
  GCreateFspTxData_createFspTxBuilder get createFspTx =>
      _$this._createFspTx ??= new GCreateFspTxData_createFspTxBuilder();
  set createFspTx(GCreateFspTxData_createFspTxBuilder? createFspTx) =>
      _$this._createFspTx = createFspTx;

  GCreateFspTxDataBuilder() {
    GCreateFspTxData._initializeBuilder(this);
  }

  GCreateFspTxDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _createFspTx = $v.createFspTx.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateFspTxData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateFspTxData;
  }

  @override
  void update(void Function(GCreateFspTxDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateFspTxData build() => _build();

  _$GCreateFspTxData _build() {
    _$GCreateFspTxData _$result;
    try {
      _$result = _$v ??
          new _$GCreateFspTxData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GCreateFspTxData', 'G__typename'),
              createFspTx: createFspTx.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createFspTx';
        createFspTx.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GCreateFspTxData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GCreateFspTxData_createFspTx extends GCreateFspTxData_createFspTx {
  @override
  final String G__typename;
  @override
  final int newBalance;

  factory _$GCreateFspTxData_createFspTx(
          [void Function(GCreateFspTxData_createFspTxBuilder)? updates]) =>
      (new GCreateFspTxData_createFspTxBuilder()..update(updates))._build();

  _$GCreateFspTxData_createFspTx._(
      {required this.G__typename, required this.newBalance})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GCreateFspTxData_createFspTx', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        newBalance, r'GCreateFspTxData_createFspTx', 'newBalance');
  }

  @override
  GCreateFspTxData_createFspTx rebuild(
          void Function(GCreateFspTxData_createFspTxBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateFspTxData_createFspTxBuilder toBuilder() =>
      new GCreateFspTxData_createFspTxBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateFspTxData_createFspTx &&
        G__typename == other.G__typename &&
        newBalance == other.newBalance;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, newBalance.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateFspTxData_createFspTx')
          ..add('G__typename', G__typename)
          ..add('newBalance', newBalance))
        .toString();
  }
}

class GCreateFspTxData_createFspTxBuilder
    implements
        Builder<GCreateFspTxData_createFspTx,
            GCreateFspTxData_createFspTxBuilder> {
  _$GCreateFspTxData_createFspTx? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _newBalance;
  int? get newBalance => _$this._newBalance;
  set newBalance(int? newBalance) => _$this._newBalance = newBalance;

  GCreateFspTxData_createFspTxBuilder() {
    GCreateFspTxData_createFspTx._initializeBuilder(this);
  }

  GCreateFspTxData_createFspTxBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _newBalance = $v.newBalance;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateFspTxData_createFspTx other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateFspTxData_createFspTx;
  }

  @override
  void update(void Function(GCreateFspTxData_createFspTxBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateFspTxData_createFspTx build() => _build();

  _$GCreateFspTxData_createFspTx _build() {
    final _$result = _$v ??
        new _$GCreateFspTxData_createFspTx._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GCreateFspTxData_createFspTx', 'G__typename'),
            newBalance: BuiltValueNullFieldError.checkNotNull(
                newBalance, r'GCreateFspTxData_createFspTx', 'newBalance'));
    replace(_$result);
    return _$result;
  }
}

class _$GCreateNewArtistData extends GCreateNewArtistData {
  @override
  final String G__typename;
  @override
  final GCreateNewArtistData_createNewArtist createNewArtist;

  factory _$GCreateNewArtistData(
          [void Function(GCreateNewArtistDataBuilder)? updates]) =>
      (new GCreateNewArtistDataBuilder()..update(updates))._build();

  _$GCreateNewArtistData._(
      {required this.G__typename, required this.createNewArtist})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GCreateNewArtistData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        createNewArtist, r'GCreateNewArtistData', 'createNewArtist');
  }

  @override
  GCreateNewArtistData rebuild(
          void Function(GCreateNewArtistDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateNewArtistDataBuilder toBuilder() =>
      new GCreateNewArtistDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateNewArtistData &&
        G__typename == other.G__typename &&
        createNewArtist == other.createNewArtist;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, createNewArtist.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateNewArtistData')
          ..add('G__typename', G__typename)
          ..add('createNewArtist', createNewArtist))
        .toString();
  }
}

class GCreateNewArtistDataBuilder
    implements Builder<GCreateNewArtistData, GCreateNewArtistDataBuilder> {
  _$GCreateNewArtistData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GCreateNewArtistData_createNewArtistBuilder? _createNewArtist;
  GCreateNewArtistData_createNewArtistBuilder get createNewArtist =>
      _$this._createNewArtist ??=
          new GCreateNewArtistData_createNewArtistBuilder();
  set createNewArtist(
          GCreateNewArtistData_createNewArtistBuilder? createNewArtist) =>
      _$this._createNewArtist = createNewArtist;

  GCreateNewArtistDataBuilder() {
    GCreateNewArtistData._initializeBuilder(this);
  }

  GCreateNewArtistDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _createNewArtist = $v.createNewArtist.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateNewArtistData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateNewArtistData;
  }

  @override
  void update(void Function(GCreateNewArtistDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateNewArtistData build() => _build();

  _$GCreateNewArtistData _build() {
    _$GCreateNewArtistData _$result;
    try {
      _$result = _$v ??
          new _$GCreateNewArtistData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GCreateNewArtistData', 'G__typename'),
              createNewArtist: createNewArtist.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createNewArtist';
        createNewArtist.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GCreateNewArtistData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GCreateNewArtistData_createNewArtist
    extends GCreateNewArtistData_createNewArtist {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String name;

  factory _$GCreateNewArtistData_createNewArtist(
          [void Function(GCreateNewArtistData_createNewArtistBuilder)?
              updates]) =>
      (new GCreateNewArtistData_createNewArtistBuilder()..update(updates))
          ._build();

  _$GCreateNewArtistData_createNewArtist._(
      {required this.G__typename, required this.id, required this.name})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GCreateNewArtistData_createNewArtist', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GCreateNewArtistData_createNewArtist', 'id');
    BuiltValueNullFieldError.checkNotNull(
        name, r'GCreateNewArtistData_createNewArtist', 'name');
  }

  @override
  GCreateNewArtistData_createNewArtist rebuild(
          void Function(GCreateNewArtistData_createNewArtistBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateNewArtistData_createNewArtistBuilder toBuilder() =>
      new GCreateNewArtistData_createNewArtistBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateNewArtistData_createNewArtist &&
        G__typename == other.G__typename &&
        id == other.id &&
        name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateNewArtistData_createNewArtist')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class GCreateNewArtistData_createNewArtistBuilder
    implements
        Builder<GCreateNewArtistData_createNewArtist,
            GCreateNewArtistData_createNewArtistBuilder> {
  _$GCreateNewArtistData_createNewArtist? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  GCreateNewArtistData_createNewArtistBuilder() {
    GCreateNewArtistData_createNewArtist._initializeBuilder(this);
  }

  GCreateNewArtistData_createNewArtistBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateNewArtistData_createNewArtist other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateNewArtistData_createNewArtist;
  }

  @override
  void update(
      void Function(GCreateNewArtistData_createNewArtistBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateNewArtistData_createNewArtist build() => _build();

  _$GCreateNewArtistData_createNewArtist _build() {
    final _$result = _$v ??
        new _$GCreateNewArtistData_createNewArtist._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GCreateNewArtistData_createNewArtist', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GCreateNewArtistData_createNewArtist', 'id'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'GCreateNewArtistData_createNewArtist', 'name'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
