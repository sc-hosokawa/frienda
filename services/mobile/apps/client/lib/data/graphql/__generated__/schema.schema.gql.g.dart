// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema.schema.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GTransactionDirection _$gTransactionDirectionIN =
    const GTransactionDirection._('IN');
const GTransactionDirection _$gTransactionDirectionOUT =
    const GTransactionDirection._('OUT');
const GTransactionDirection _$gTransactionDirectiongUnknownEnumValue =
    const GTransactionDirection._('gUnknownEnumValue');

GTransactionDirection _$gTransactionDirectionValueOf(String name) {
  switch (name) {
    case 'IN':
      return _$gTransactionDirectionIN;
    case 'OUT':
      return _$gTransactionDirectionOUT;
    case 'gUnknownEnumValue':
      return _$gTransactionDirectiongUnknownEnumValue;
    default:
      return _$gTransactionDirectiongUnknownEnumValue;
  }
}

final BuiltSet<GTransactionDirection> _$gTransactionDirectionValues =
    new BuiltSet<GTransactionDirection>(const <GTransactionDirection>[
  _$gTransactionDirectionIN,
  _$gTransactionDirectionOUT,
  _$gTransactionDirectiongUnknownEnumValue,
]);

Serializer<GAddNewConnectionByUserInput>
    _$gAddNewConnectionByUserInputSerializer =
    new _$GAddNewConnectionByUserInputSerializer();
Serializer<GContactToAdminInput> _$gContactToAdminInputSerializer =
    new _$GContactToAdminInputSerializer();
Serializer<GCreateNewArtistInput> _$gCreateNewArtistInputSerializer =
    new _$GCreateNewArtistInputSerializer();
Serializer<GCreateNewMessageRoomInput> _$gCreateNewMessageRoomInputSerializer =
    new _$GCreateNewMessageRoomInputSerializer();
Serializer<GCreateNewNotificationInput>
    _$gCreateNewNotificationInputSerializer =
    new _$GCreateNewNotificationInputSerializer();
Serializer<GCreateNewOfferInput> _$gCreateNewOfferInputSerializer =
    new _$GCreateNewOfferInputSerializer();
Serializer<GCreateNewTransactionInput> _$gCreateNewTransactionInputSerializer =
    new _$GCreateNewTransactionInputSerializer();
Serializer<GCreateNewUserDataInput> _$gCreateNewUserDataInputSerializer =
    new _$GCreateNewUserDataInputSerializer();
Serializer<GDeleteNotificationInput> _$gDeleteNotificationInputSerializer =
    new _$GDeleteNotificationInputSerializer();
Serializer<GDeleteOfferInput> _$gDeleteOfferInputSerializer =
    new _$GDeleteOfferInputSerializer();
Serializer<GSendMessageInput> _$gSendMessageInputSerializer =
    new _$GSendMessageInputSerializer();
Serializer<GTransactionDirection> _$gTransactionDirectionSerializer =
    new _$GTransactionDirectionSerializer();
Serializer<GUpdateBelongsToArtistStatusInput>
    _$gUpdateBelongsToArtistStatusInputSerializer =
    new _$GUpdateBelongsToArtistStatusInputSerializer();
Serializer<GUpdateNotificationInput> _$gUpdateNotificationInputSerializer =
    new _$GUpdateNotificationInputSerializer();
Serializer<GUpdateOfferInput> _$gUpdateOfferInputSerializer =
    new _$GUpdateOfferInputSerializer();
Serializer<GUpdateUserDataInput> _$gUpdateUserDataInputSerializer =
    new _$GUpdateUserDataInputSerializer();

class _$GAddNewConnectionByUserInputSerializer
    implements StructuredSerializer<GAddNewConnectionByUserInput> {
  @override
  final Iterable<Type> types = const [
    GAddNewConnectionByUserInput,
    _$GAddNewConnectionByUserInput
  ];
  @override
  final String wireName = 'GAddNewConnectionByUserInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAddNewConnectionByUserInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GAddNewConnectionByUserInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAddNewConnectionByUserInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GContactToAdminInputSerializer
    implements StructuredSerializer<GContactToAdminInput> {
  @override
  final Iterable<Type> types = const [
    GContactToAdminInput,
    _$GContactToAdminInput
  ];
  @override
  final String wireName = 'GContactToAdminInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GContactToAdminInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'username',
      serializers.serialize(object.username,
          specifiedType: const FullType(String)),
      'category',
      serializers.serialize(object.category,
          specifiedType: const FullType(String)),
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'content',
      serializers.serialize(object.content,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GContactToAdminInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GContactToAdminInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'category':
          result.category = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateNewArtistInputSerializer
    implements StructuredSerializer<GCreateNewArtistInput> {
  @override
  final Iterable<Type> types = const [
    GCreateNewArtistInput,
    _$GCreateNewArtistInput
  ];
  @override
  final String wireName = 'GCreateNewArtistInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateNewArtistInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'fsp',
      serializers.serialize(object.fsp, specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.imgUrl;
    if (value != null) {
      result
        ..add('imgUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.status;
    if (value != null) {
      result
        ..add('status')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.since;
    if (value != null) {
      result
        ..add('since')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.universalId;
    if (value != null) {
      result
        ..add('universalId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.appleKey;
    if (value != null) {
      result
        ..add('appleKey')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.spotifyKey;
    if (value != null) {
      result
        ..add('spotifyKey')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.lineKey;
    if (value != null) {
      result
        ..add('lineKey')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.amazonKey;
    if (value != null) {
      result
        ..add('amazonKey')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.youtubeKey;
    if (value != null) {
      result
        ..add('youtubeKey')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GCreateNewArtistInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateNewArtistInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'imgUrl':
          result.imgUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'fsp':
          result.fsp = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'since':
          result.since = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'universalId':
          result.universalId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'appleKey':
          result.appleKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'spotifyKey':
          result.spotifyKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'lineKey':
          result.lineKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'amazonKey':
          result.amazonKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'youtubeKey':
          result.youtubeKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateNewMessageRoomInputSerializer
    implements StructuredSerializer<GCreateNewMessageRoomInput> {
  @override
  final Iterable<Type> types = const [
    GCreateNewMessageRoomInput,
    _$GCreateNewMessageRoomInput
  ];
  @override
  final String wireName = 'GCreateNewMessageRoomInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateNewMessageRoomInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'category',
      serializers.serialize(object.category,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GCreateNewMessageRoomInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateNewMessageRoomInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'category':
          result.category = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateNewNotificationInputSerializer
    implements StructuredSerializer<GCreateNewNotificationInput> {
  @override
  final Iterable<Type> types = const [
    GCreateNewNotificationInput,
    _$GCreateNewNotificationInput
  ];
  @override
  final String wireName = 'GCreateNewNotificationInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateNewNotificationInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'content',
      serializers.serialize(object.content,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.target;
    if (value != null) {
      result
        ..add('target')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.userId;
    if (value != null) {
      result
        ..add('userId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GCreateNewNotificationInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateNewNotificationInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'target':
          result.target = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateNewOfferInputSerializer
    implements StructuredSerializer<GCreateNewOfferInput> {
  @override
  final Iterable<Type> types = const [
    GCreateNewOfferInput,
    _$GCreateNewOfferInput
  ];
  @override
  final String wireName = 'GCreateNewOfferInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateNewOfferInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'owner',
      serializers.serialize(object.owner,
          specifiedType: const FullType(String)),
      'releaseDt',
      serializers.serialize(object.releaseDt,
          specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'fee',
      serializers.serialize(object.fee, specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.imageUrl;
    if (value != null) {
      result
        ..add('imageUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.raidId;
    if (value != null) {
      result
        ..add('raidId')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
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
  GCreateNewOfferInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateNewOfferInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'owner':
          result.owner = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'releaseDt':
          result.releaseDt = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'fee':
          result.fee = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'imageUrl':
          result.imageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'raidId':
          result.raidId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'category':
          result.category = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateNewTransactionInputSerializer
    implements StructuredSerializer<GCreateNewTransactionInput> {
  @override
  final Iterable<Type> types = const [
    GCreateNewTransactionInput,
    _$GCreateNewTransactionInput
  ];
  @override
  final String wireName = 'GCreateNewTransactionInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateNewTransactionInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'to',
      serializers.serialize(object.to, specifiedType: const FullType(String)),
      'amount',
      serializers.serialize(object.amount, specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.from;
    if (value != null) {
      result
        ..add('from')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.note;
    if (value != null) {
      result
        ..add('note')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GCreateNewTransactionInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateNewTransactionInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'from':
          result.from = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'to':
          result.to = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'amount':
          result.amount = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'note':
          result.note = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateNewUserDataInputSerializer
    implements StructuredSerializer<GCreateNewUserDataInput> {
  @override
  final Iterable<Type> types = const [
    GCreateNewUserDataInput,
    _$GCreateNewUserDataInput
  ];
  @override
  final String wireName = 'GCreateNewUserDataInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateNewUserDataInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'category',
      serializers.serialize(object.category,
          specifiedType: const FullType(String)),
      'primaryCategory',
      serializers.serialize(object.primaryCategory,
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
    value = object.invitedBy;
    if (value != null) {
      result
        ..add('invitedBy')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GCreateNewUserDataInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateNewUserDataInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
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
        case 'invitedBy':
          result.invitedBy = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'category':
          result.category = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'primaryCategory':
          result.primaryCategory = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GDeleteNotificationInputSerializer
    implements StructuredSerializer<GDeleteNotificationInput> {
  @override
  final Iterable<Type> types = const [
    GDeleteNotificationInput,
    _$GDeleteNotificationInput
  ];
  @override
  final String wireName = 'GDeleteNotificationInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GDeleteNotificationInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GDeleteNotificationInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GDeleteNotificationInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GDeleteOfferInputSerializer
    implements StructuredSerializer<GDeleteOfferInput> {
  @override
  final Iterable<Type> types = const [GDeleteOfferInput, _$GDeleteOfferInput];
  @override
  final String wireName = 'GDeleteOfferInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, GDeleteOfferInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GDeleteOfferInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GDeleteOfferInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GSendMessageInputSerializer
    implements StructuredSerializer<GSendMessageInput> {
  @override
  final Iterable<Type> types = const [GSendMessageInput, _$GSendMessageInput];
  @override
  final String wireName = 'GSendMessageInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, GSendMessageInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'roomId',
      serializers.serialize(object.roomId,
          specifiedType: const FullType(String)),
      'sentBy',
      serializers.serialize(object.sentBy,
          specifiedType: const FullType(String)),
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.attachedFile;
    if (value != null) {
      result
        ..add('attachedFile')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.attachedImg;
    if (value != null) {
      result
        ..add('attachedImg')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    return result;
  }

  @override
  GSendMessageInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSendMessageInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'roomId':
          result.roomId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'sentBy':
          result.sentBy = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'attachedFile':
          result.attachedFile.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'attachedImg':
          result.attachedImg.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GTransactionDirectionSerializer
    implements PrimitiveSerializer<GTransactionDirection> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'gUnknownEnumValue': 'gUnknownEnumValue',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'gUnknownEnumValue': 'gUnknownEnumValue',
  };

  @override
  final Iterable<Type> types = const <Type>[GTransactionDirection];
  @override
  final String wireName = 'GTransactionDirection';

  @override
  Object serialize(Serializers serializers, GTransactionDirection object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  GTransactionDirection deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GTransactionDirection.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$GUpdateBelongsToArtistStatusInputSerializer
    implements StructuredSerializer<GUpdateBelongsToArtistStatusInput> {
  @override
  final Iterable<Type> types = const [
    GUpdateBelongsToArtistStatusInput,
    _$GUpdateBelongsToArtistStatusInput
  ];
  @override
  final String wireName = 'GUpdateBelongsToArtistStatusInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateBelongsToArtistStatusInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.artistId;
    if (value != null) {
      result
        ..add('artistId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.status;
    if (value != null) {
      result
        ..add('status')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GUpdateBelongsToArtistStatusInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateBelongsToArtistStatusInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'artistId':
          result.artistId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateNotificationInputSerializer
    implements StructuredSerializer<GUpdateNotificationInput> {
  @override
  final Iterable<Type> types = const [
    GUpdateNotificationInput,
    _$GUpdateNotificationInput
  ];
  @override
  final String wireName = 'GUpdateNotificationInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateNotificationInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.title;
    if (value != null) {
      result
        ..add('title')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.content;
    if (value != null) {
      result
        ..add('content')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GUpdateNotificationInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateNotificationInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateOfferInputSerializer
    implements StructuredSerializer<GUpdateOfferInput> {
  @override
  final Iterable<Type> types = const [GUpdateOfferInput, _$GUpdateOfferInput];
  @override
  final String wireName = 'GUpdateOfferInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, GUpdateOfferInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.title;
    if (value != null) {
      result
        ..add('title')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.fee;
    if (value != null) {
      result
        ..add('fee')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.imageUrl;
    if (value != null) {
      result
        ..add('imageUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.raidId;
    if (value != null) {
      result
        ..add('raidId')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
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
  GUpdateOfferInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateOfferInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'fee':
          result.fee = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'imageUrl':
          result.imageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'raidId':
          result.raidId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'category':
          result.category = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateUserDataInputSerializer
    implements StructuredSerializer<GUpdateUserDataInput> {
  @override
  final Iterable<Type> types = const [
    GUpdateUserDataInput,
    _$GUpdateUserDataInput
  ];
  @override
  final String wireName = 'GUpdateUserDataInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateUserDataInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.email;
    if (value != null) {
      result
        ..add('email')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.imageUrl;
    if (value != null) {
      result
        ..add('imageUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.primaryCategory;
    if (value != null) {
      result
        ..add('primaryCategory')
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
    value = object.status;
    if (value != null) {
      result
        ..add('status')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GUpdateUserDataInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateUserDataInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'imageUrl':
          result.imageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'primaryCategory':
          result.primaryCategory = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'evmAddr':
          result.evmAddr = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GAddNewConnectionByUserInput extends GAddNewConnectionByUserInput {
  @override
  final String userId;

  factory _$GAddNewConnectionByUserInput(
          [void Function(GAddNewConnectionByUserInputBuilder)? updates]) =>
      (new GAddNewConnectionByUserInputBuilder()..update(updates))._build();

  _$GAddNewConnectionByUserInput._({required this.userId}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        userId, r'GAddNewConnectionByUserInput', 'userId');
  }

  @override
  GAddNewConnectionByUserInput rebuild(
          void Function(GAddNewConnectionByUserInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAddNewConnectionByUserInputBuilder toBuilder() =>
      new GAddNewConnectionByUserInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAddNewConnectionByUserInput && userId == other.userId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAddNewConnectionByUserInput')
          ..add('userId', userId))
        .toString();
  }
}

class GAddNewConnectionByUserInputBuilder
    implements
        Builder<GAddNewConnectionByUserInput,
            GAddNewConnectionByUserInputBuilder> {
  _$GAddNewConnectionByUserInput? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  GAddNewConnectionByUserInputBuilder();

  GAddNewConnectionByUserInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAddNewConnectionByUserInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAddNewConnectionByUserInput;
  }

  @override
  void update(void Function(GAddNewConnectionByUserInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAddNewConnectionByUserInput build() => _build();

  _$GAddNewConnectionByUserInput _build() {
    final _$result = _$v ??
        new _$GAddNewConnectionByUserInput._(
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'GAddNewConnectionByUserInput', 'userId'));
    replace(_$result);
    return _$result;
  }
}

class _$GContactToAdminInput extends GContactToAdminInput {
  @override
  final String username;
  @override
  final String category;
  @override
  final String email;
  @override
  final String content;

  factory _$GContactToAdminInput(
          [void Function(GContactToAdminInputBuilder)? updates]) =>
      (new GContactToAdminInputBuilder()..update(updates))._build();

  _$GContactToAdminInput._(
      {required this.username,
      required this.category,
      required this.email,
      required this.content})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        username, r'GContactToAdminInput', 'username');
    BuiltValueNullFieldError.checkNotNull(
        category, r'GContactToAdminInput', 'category');
    BuiltValueNullFieldError.checkNotNull(
        email, r'GContactToAdminInput', 'email');
    BuiltValueNullFieldError.checkNotNull(
        content, r'GContactToAdminInput', 'content');
  }

  @override
  GContactToAdminInput rebuild(
          void Function(GContactToAdminInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GContactToAdminInputBuilder toBuilder() =>
      new GContactToAdminInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GContactToAdminInput &&
        username == other.username &&
        category == other.category &&
        email == other.email &&
        content == other.content;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GContactToAdminInput')
          ..add('username', username)
          ..add('category', category)
          ..add('email', email)
          ..add('content', content))
        .toString();
  }
}

class GContactToAdminInputBuilder
    implements Builder<GContactToAdminInput, GContactToAdminInputBuilder> {
  _$GContactToAdminInput? _$v;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  GContactToAdminInputBuilder();

  GContactToAdminInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _username = $v.username;
      _category = $v.category;
      _email = $v.email;
      _content = $v.content;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GContactToAdminInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GContactToAdminInput;
  }

  @override
  void update(void Function(GContactToAdminInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GContactToAdminInput build() => _build();

  _$GContactToAdminInput _build() {
    final _$result = _$v ??
        new _$GContactToAdminInput._(
            username: BuiltValueNullFieldError.checkNotNull(
                username, r'GContactToAdminInput', 'username'),
            category: BuiltValueNullFieldError.checkNotNull(
                category, r'GContactToAdminInput', 'category'),
            email: BuiltValueNullFieldError.checkNotNull(
                email, r'GContactToAdminInput', 'email'),
            content: BuiltValueNullFieldError.checkNotNull(
                content, r'GContactToAdminInput', 'content'));
    replace(_$result);
    return _$result;
  }
}

class _$GCreateNewArtistInput extends GCreateNewArtistInput {
  @override
  final String name;
  @override
  final String? imgUrl;
  @override
  final int fsp;
  @override
  final String? status;
  @override
  final String? since;
  @override
  final String? universalId;
  @override
  final String? appleKey;
  @override
  final String? spotifyKey;
  @override
  final String? lineKey;
  @override
  final String? amazonKey;
  @override
  final String? youtubeKey;

  factory _$GCreateNewArtistInput(
          [void Function(GCreateNewArtistInputBuilder)? updates]) =>
      (new GCreateNewArtistInputBuilder()..update(updates))._build();

  _$GCreateNewArtistInput._(
      {required this.name,
      this.imgUrl,
      required this.fsp,
      this.status,
      this.since,
      this.universalId,
      this.appleKey,
      this.spotifyKey,
      this.lineKey,
      this.amazonKey,
      this.youtubeKey})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        name, r'GCreateNewArtistInput', 'name');
    BuiltValueNullFieldError.checkNotNull(fsp, r'GCreateNewArtistInput', 'fsp');
  }

  @override
  GCreateNewArtistInput rebuild(
          void Function(GCreateNewArtistInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateNewArtistInputBuilder toBuilder() =>
      new GCreateNewArtistInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateNewArtistInput &&
        name == other.name &&
        imgUrl == other.imgUrl &&
        fsp == other.fsp &&
        status == other.status &&
        since == other.since &&
        universalId == other.universalId &&
        appleKey == other.appleKey &&
        spotifyKey == other.spotifyKey &&
        lineKey == other.lineKey &&
        amazonKey == other.amazonKey &&
        youtubeKey == other.youtubeKey;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, imgUrl.hashCode);
    _$hash = $jc(_$hash, fsp.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, since.hashCode);
    _$hash = $jc(_$hash, universalId.hashCode);
    _$hash = $jc(_$hash, appleKey.hashCode);
    _$hash = $jc(_$hash, spotifyKey.hashCode);
    _$hash = $jc(_$hash, lineKey.hashCode);
    _$hash = $jc(_$hash, amazonKey.hashCode);
    _$hash = $jc(_$hash, youtubeKey.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateNewArtistInput')
          ..add('name', name)
          ..add('imgUrl', imgUrl)
          ..add('fsp', fsp)
          ..add('status', status)
          ..add('since', since)
          ..add('universalId', universalId)
          ..add('appleKey', appleKey)
          ..add('spotifyKey', spotifyKey)
          ..add('lineKey', lineKey)
          ..add('amazonKey', amazonKey)
          ..add('youtubeKey', youtubeKey))
        .toString();
  }
}

class GCreateNewArtistInputBuilder
    implements Builder<GCreateNewArtistInput, GCreateNewArtistInputBuilder> {
  _$GCreateNewArtistInput? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _imgUrl;
  String? get imgUrl => _$this._imgUrl;
  set imgUrl(String? imgUrl) => _$this._imgUrl = imgUrl;

  int? _fsp;
  int? get fsp => _$this._fsp;
  set fsp(int? fsp) => _$this._fsp = fsp;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _since;
  String? get since => _$this._since;
  set since(String? since) => _$this._since = since;

  String? _universalId;
  String? get universalId => _$this._universalId;
  set universalId(String? universalId) => _$this._universalId = universalId;

  String? _appleKey;
  String? get appleKey => _$this._appleKey;
  set appleKey(String? appleKey) => _$this._appleKey = appleKey;

  String? _spotifyKey;
  String? get spotifyKey => _$this._spotifyKey;
  set spotifyKey(String? spotifyKey) => _$this._spotifyKey = spotifyKey;

  String? _lineKey;
  String? get lineKey => _$this._lineKey;
  set lineKey(String? lineKey) => _$this._lineKey = lineKey;

  String? _amazonKey;
  String? get amazonKey => _$this._amazonKey;
  set amazonKey(String? amazonKey) => _$this._amazonKey = amazonKey;

  String? _youtubeKey;
  String? get youtubeKey => _$this._youtubeKey;
  set youtubeKey(String? youtubeKey) => _$this._youtubeKey = youtubeKey;

  GCreateNewArtistInputBuilder();

  GCreateNewArtistInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _imgUrl = $v.imgUrl;
      _fsp = $v.fsp;
      _status = $v.status;
      _since = $v.since;
      _universalId = $v.universalId;
      _appleKey = $v.appleKey;
      _spotifyKey = $v.spotifyKey;
      _lineKey = $v.lineKey;
      _amazonKey = $v.amazonKey;
      _youtubeKey = $v.youtubeKey;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateNewArtistInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateNewArtistInput;
  }

  @override
  void update(void Function(GCreateNewArtistInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateNewArtistInput build() => _build();

  _$GCreateNewArtistInput _build() {
    final _$result = _$v ??
        new _$GCreateNewArtistInput._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'GCreateNewArtistInput', 'name'),
            imgUrl: imgUrl,
            fsp: BuiltValueNullFieldError.checkNotNull(
                fsp, r'GCreateNewArtistInput', 'fsp'),
            status: status,
            since: since,
            universalId: universalId,
            appleKey: appleKey,
            spotifyKey: spotifyKey,
            lineKey: lineKey,
            amazonKey: amazonKey,
            youtubeKey: youtubeKey);
    replace(_$result);
    return _$result;
  }
}

class _$GCreateNewMessageRoomInput extends GCreateNewMessageRoomInput {
  @override
  final String category;

  factory _$GCreateNewMessageRoomInput(
          [void Function(GCreateNewMessageRoomInputBuilder)? updates]) =>
      (new GCreateNewMessageRoomInputBuilder()..update(updates))._build();

  _$GCreateNewMessageRoomInput._({required this.category}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        category, r'GCreateNewMessageRoomInput', 'category');
  }

  @override
  GCreateNewMessageRoomInput rebuild(
          void Function(GCreateNewMessageRoomInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateNewMessageRoomInputBuilder toBuilder() =>
      new GCreateNewMessageRoomInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateNewMessageRoomInput && category == other.category;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateNewMessageRoomInput')
          ..add('category', category))
        .toString();
  }
}

class GCreateNewMessageRoomInputBuilder
    implements
        Builder<GCreateNewMessageRoomInput, GCreateNewMessageRoomInputBuilder> {
  _$GCreateNewMessageRoomInput? _$v;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  GCreateNewMessageRoomInputBuilder();

  GCreateNewMessageRoomInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _category = $v.category;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateNewMessageRoomInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateNewMessageRoomInput;
  }

  @override
  void update(void Function(GCreateNewMessageRoomInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateNewMessageRoomInput build() => _build();

  _$GCreateNewMessageRoomInput _build() {
    final _$result = _$v ??
        new _$GCreateNewMessageRoomInput._(
            category: BuiltValueNullFieldError.checkNotNull(
                category, r'GCreateNewMessageRoomInput', 'category'));
    replace(_$result);
    return _$result;
  }
}

class _$GCreateNewNotificationInput extends GCreateNewNotificationInput {
  @override
  final String title;
  @override
  final String content;
  @override
  final String? target;
  @override
  final String? userId;

  factory _$GCreateNewNotificationInput(
          [void Function(GCreateNewNotificationInputBuilder)? updates]) =>
      (new GCreateNewNotificationInputBuilder()..update(updates))._build();

  _$GCreateNewNotificationInput._(
      {required this.title, required this.content, this.target, this.userId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        title, r'GCreateNewNotificationInput', 'title');
    BuiltValueNullFieldError.checkNotNull(
        content, r'GCreateNewNotificationInput', 'content');
  }

  @override
  GCreateNewNotificationInput rebuild(
          void Function(GCreateNewNotificationInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateNewNotificationInputBuilder toBuilder() =>
      new GCreateNewNotificationInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateNewNotificationInput &&
        title == other.title &&
        content == other.content &&
        target == other.target &&
        userId == other.userId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, target.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateNewNotificationInput')
          ..add('title', title)
          ..add('content', content)
          ..add('target', target)
          ..add('userId', userId))
        .toString();
  }
}

class GCreateNewNotificationInputBuilder
    implements
        Builder<GCreateNewNotificationInput,
            GCreateNewNotificationInputBuilder> {
  _$GCreateNewNotificationInput? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  String? _target;
  String? get target => _$this._target;
  set target(String? target) => _$this._target = target;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  GCreateNewNotificationInputBuilder();

  GCreateNewNotificationInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _content = $v.content;
      _target = $v.target;
      _userId = $v.userId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateNewNotificationInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateNewNotificationInput;
  }

  @override
  void update(void Function(GCreateNewNotificationInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateNewNotificationInput build() => _build();

  _$GCreateNewNotificationInput _build() {
    final _$result = _$v ??
        new _$GCreateNewNotificationInput._(
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'GCreateNewNotificationInput', 'title'),
            content: BuiltValueNullFieldError.checkNotNull(
                content, r'GCreateNewNotificationInput', 'content'),
            target: target,
            userId: userId);
    replace(_$result);
    return _$result;
  }
}

class _$GCreateNewOfferInput extends GCreateNewOfferInput {
  @override
  final String owner;
  @override
  final String releaseDt;
  @override
  final String title;
  @override
  final String description;
  @override
  final int fee;
  @override
  final String? imageUrl;
  @override
  final int? raidId;
  @override
  final String? category;

  factory _$GCreateNewOfferInput(
          [void Function(GCreateNewOfferInputBuilder)? updates]) =>
      (new GCreateNewOfferInputBuilder()..update(updates))._build();

  _$GCreateNewOfferInput._(
      {required this.owner,
      required this.releaseDt,
      required this.title,
      required this.description,
      required this.fee,
      this.imageUrl,
      this.raidId,
      this.category})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        owner, r'GCreateNewOfferInput', 'owner');
    BuiltValueNullFieldError.checkNotNull(
        releaseDt, r'GCreateNewOfferInput', 'releaseDt');
    BuiltValueNullFieldError.checkNotNull(
        title, r'GCreateNewOfferInput', 'title');
    BuiltValueNullFieldError.checkNotNull(
        description, r'GCreateNewOfferInput', 'description');
    BuiltValueNullFieldError.checkNotNull(fee, r'GCreateNewOfferInput', 'fee');
  }

  @override
  GCreateNewOfferInput rebuild(
          void Function(GCreateNewOfferInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateNewOfferInputBuilder toBuilder() =>
      new GCreateNewOfferInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateNewOfferInput &&
        owner == other.owner &&
        releaseDt == other.releaseDt &&
        title == other.title &&
        description == other.description &&
        fee == other.fee &&
        imageUrl == other.imageUrl &&
        raidId == other.raidId &&
        category == other.category;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, owner.hashCode);
    _$hash = $jc(_$hash, releaseDt.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, fee.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jc(_$hash, raidId.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateNewOfferInput')
          ..add('owner', owner)
          ..add('releaseDt', releaseDt)
          ..add('title', title)
          ..add('description', description)
          ..add('fee', fee)
          ..add('imageUrl', imageUrl)
          ..add('raidId', raidId)
          ..add('category', category))
        .toString();
  }
}

class GCreateNewOfferInputBuilder
    implements Builder<GCreateNewOfferInput, GCreateNewOfferInputBuilder> {
  _$GCreateNewOfferInput? _$v;

  String? _owner;
  String? get owner => _$this._owner;
  set owner(String? owner) => _$this._owner = owner;

  String? _releaseDt;
  String? get releaseDt => _$this._releaseDt;
  set releaseDt(String? releaseDt) => _$this._releaseDt = releaseDt;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  int? _fee;
  int? get fee => _$this._fee;
  set fee(int? fee) => _$this._fee = fee;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  int? _raidId;
  int? get raidId => _$this._raidId;
  set raidId(int? raidId) => _$this._raidId = raidId;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  GCreateNewOfferInputBuilder();

  GCreateNewOfferInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _owner = $v.owner;
      _releaseDt = $v.releaseDt;
      _title = $v.title;
      _description = $v.description;
      _fee = $v.fee;
      _imageUrl = $v.imageUrl;
      _raidId = $v.raidId;
      _category = $v.category;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateNewOfferInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateNewOfferInput;
  }

  @override
  void update(void Function(GCreateNewOfferInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateNewOfferInput build() => _build();

  _$GCreateNewOfferInput _build() {
    final _$result = _$v ??
        new _$GCreateNewOfferInput._(
            owner: BuiltValueNullFieldError.checkNotNull(
                owner, r'GCreateNewOfferInput', 'owner'),
            releaseDt: BuiltValueNullFieldError.checkNotNull(
                releaseDt, r'GCreateNewOfferInput', 'releaseDt'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'GCreateNewOfferInput', 'title'),
            description: BuiltValueNullFieldError.checkNotNull(
                description, r'GCreateNewOfferInput', 'description'),
            fee: BuiltValueNullFieldError.checkNotNull(
                fee, r'GCreateNewOfferInput', 'fee'),
            imageUrl: imageUrl,
            raidId: raidId,
            category: category);
    replace(_$result);
    return _$result;
  }
}

class _$GCreateNewTransactionInput extends GCreateNewTransactionInput {
  @override
  final String? from;
  @override
  final String to;
  @override
  final int amount;
  @override
  final String? note;

  factory _$GCreateNewTransactionInput(
          [void Function(GCreateNewTransactionInputBuilder)? updates]) =>
      (new GCreateNewTransactionInputBuilder()..update(updates))._build();

  _$GCreateNewTransactionInput._(
      {this.from, required this.to, required this.amount, this.note})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        to, r'GCreateNewTransactionInput', 'to');
    BuiltValueNullFieldError.checkNotNull(
        amount, r'GCreateNewTransactionInput', 'amount');
  }

  @override
  GCreateNewTransactionInput rebuild(
          void Function(GCreateNewTransactionInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateNewTransactionInputBuilder toBuilder() =>
      new GCreateNewTransactionInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateNewTransactionInput &&
        from == other.from &&
        to == other.to &&
        amount == other.amount &&
        note == other.note;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, from.hashCode);
    _$hash = $jc(_$hash, to.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateNewTransactionInput')
          ..add('from', from)
          ..add('to', to)
          ..add('amount', amount)
          ..add('note', note))
        .toString();
  }
}

class GCreateNewTransactionInputBuilder
    implements
        Builder<GCreateNewTransactionInput, GCreateNewTransactionInputBuilder> {
  _$GCreateNewTransactionInput? _$v;

  String? _from;
  String? get from => _$this._from;
  set from(String? from) => _$this._from = from;

  String? _to;
  String? get to => _$this._to;
  set to(String? to) => _$this._to = to;

  int? _amount;
  int? get amount => _$this._amount;
  set amount(int? amount) => _$this._amount = amount;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  GCreateNewTransactionInputBuilder();

  GCreateNewTransactionInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _from = $v.from;
      _to = $v.to;
      _amount = $v.amount;
      _note = $v.note;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateNewTransactionInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateNewTransactionInput;
  }

  @override
  void update(void Function(GCreateNewTransactionInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateNewTransactionInput build() => _build();

  _$GCreateNewTransactionInput _build() {
    final _$result = _$v ??
        new _$GCreateNewTransactionInput._(
            from: from,
            to: BuiltValueNullFieldError.checkNotNull(
                to, r'GCreateNewTransactionInput', 'to'),
            amount: BuiltValueNullFieldError.checkNotNull(
                amount, r'GCreateNewTransactionInput', 'amount'),
            note: note);
    replace(_$result);
    return _$result;
  }
}

class _$GCreateNewUserDataInput extends GCreateNewUserDataInput {
  @override
  final String email;
  @override
  final String name;
  @override
  final String? imageUrl;
  @override
  final String? invitedBy;
  @override
  final String category;
  @override
  final String primaryCategory;

  factory _$GCreateNewUserDataInput(
          [void Function(GCreateNewUserDataInputBuilder)? updates]) =>
      (new GCreateNewUserDataInputBuilder()..update(updates))._build();

  _$GCreateNewUserDataInput._(
      {required this.email,
      required this.name,
      this.imageUrl,
      this.invitedBy,
      required this.category,
      required this.primaryCategory})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        email, r'GCreateNewUserDataInput', 'email');
    BuiltValueNullFieldError.checkNotNull(
        name, r'GCreateNewUserDataInput', 'name');
    BuiltValueNullFieldError.checkNotNull(
        category, r'GCreateNewUserDataInput', 'category');
    BuiltValueNullFieldError.checkNotNull(
        primaryCategory, r'GCreateNewUserDataInput', 'primaryCategory');
  }

  @override
  GCreateNewUserDataInput rebuild(
          void Function(GCreateNewUserDataInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateNewUserDataInputBuilder toBuilder() =>
      new GCreateNewUserDataInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateNewUserDataInput &&
        email == other.email &&
        name == other.name &&
        imageUrl == other.imageUrl &&
        invitedBy == other.invitedBy &&
        category == other.category &&
        primaryCategory == other.primaryCategory;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jc(_$hash, invitedBy.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, primaryCategory.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateNewUserDataInput')
          ..add('email', email)
          ..add('name', name)
          ..add('imageUrl', imageUrl)
          ..add('invitedBy', invitedBy)
          ..add('category', category)
          ..add('primaryCategory', primaryCategory))
        .toString();
  }
}

class GCreateNewUserDataInputBuilder
    implements
        Builder<GCreateNewUserDataInput, GCreateNewUserDataInputBuilder> {
  _$GCreateNewUserDataInput? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  String? _invitedBy;
  String? get invitedBy => _$this._invitedBy;
  set invitedBy(String? invitedBy) => _$this._invitedBy = invitedBy;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  String? _primaryCategory;
  String? get primaryCategory => _$this._primaryCategory;
  set primaryCategory(String? primaryCategory) =>
      _$this._primaryCategory = primaryCategory;

  GCreateNewUserDataInputBuilder();

  GCreateNewUserDataInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _name = $v.name;
      _imageUrl = $v.imageUrl;
      _invitedBy = $v.invitedBy;
      _category = $v.category;
      _primaryCategory = $v.primaryCategory;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateNewUserDataInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateNewUserDataInput;
  }

  @override
  void update(void Function(GCreateNewUserDataInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateNewUserDataInput build() => _build();

  _$GCreateNewUserDataInput _build() {
    final _$result = _$v ??
        new _$GCreateNewUserDataInput._(
            email: BuiltValueNullFieldError.checkNotNull(
                email, r'GCreateNewUserDataInput', 'email'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'GCreateNewUserDataInput', 'name'),
            imageUrl: imageUrl,
            invitedBy: invitedBy,
            category: BuiltValueNullFieldError.checkNotNull(
                category, r'GCreateNewUserDataInput', 'category'),
            primaryCategory: BuiltValueNullFieldError.checkNotNull(
                primaryCategory,
                r'GCreateNewUserDataInput',
                'primaryCategory'));
    replace(_$result);
    return _$result;
  }
}

class _$GDeleteNotificationInput extends GDeleteNotificationInput {
  @override
  final String id;

  factory _$GDeleteNotificationInput(
          [void Function(GDeleteNotificationInputBuilder)? updates]) =>
      (new GDeleteNotificationInputBuilder()..update(updates))._build();

  _$GDeleteNotificationInput._({required this.id}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        id, r'GDeleteNotificationInput', 'id');
  }

  @override
  GDeleteNotificationInput rebuild(
          void Function(GDeleteNotificationInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GDeleteNotificationInputBuilder toBuilder() =>
      new GDeleteNotificationInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GDeleteNotificationInput && id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GDeleteNotificationInput')
          ..add('id', id))
        .toString();
  }
}

class GDeleteNotificationInputBuilder
    implements
        Builder<GDeleteNotificationInput, GDeleteNotificationInputBuilder> {
  _$GDeleteNotificationInput? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  GDeleteNotificationInputBuilder();

  GDeleteNotificationInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GDeleteNotificationInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GDeleteNotificationInput;
  }

  @override
  void update(void Function(GDeleteNotificationInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GDeleteNotificationInput build() => _build();

  _$GDeleteNotificationInput _build() {
    final _$result = _$v ??
        new _$GDeleteNotificationInput._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GDeleteNotificationInput', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$GDeleteOfferInput extends GDeleteOfferInput {
  @override
  final int id;

  factory _$GDeleteOfferInput(
          [void Function(GDeleteOfferInputBuilder)? updates]) =>
      (new GDeleteOfferInputBuilder()..update(updates))._build();

  _$GDeleteOfferInput._({required this.id}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'GDeleteOfferInput', 'id');
  }

  @override
  GDeleteOfferInput rebuild(void Function(GDeleteOfferInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GDeleteOfferInputBuilder toBuilder() =>
      new GDeleteOfferInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GDeleteOfferInput && id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GDeleteOfferInput')..add('id', id))
        .toString();
  }
}

class GDeleteOfferInputBuilder
    implements Builder<GDeleteOfferInput, GDeleteOfferInputBuilder> {
  _$GDeleteOfferInput? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  GDeleteOfferInputBuilder();

  GDeleteOfferInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GDeleteOfferInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GDeleteOfferInput;
  }

  @override
  void update(void Function(GDeleteOfferInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GDeleteOfferInput build() => _build();

  _$GDeleteOfferInput _build() {
    final _$result = _$v ??
        new _$GDeleteOfferInput._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GDeleteOfferInput', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$GSendMessageInput extends GSendMessageInput {
  @override
  final String roomId;
  @override
  final String sentBy;
  @override
  final String message;
  @override
  final BuiltList<String>? attachedFile;
  @override
  final BuiltList<String>? attachedImg;

  factory _$GSendMessageInput(
          [void Function(GSendMessageInputBuilder)? updates]) =>
      (new GSendMessageInputBuilder()..update(updates))._build();

  _$GSendMessageInput._(
      {required this.roomId,
      required this.sentBy,
      required this.message,
      this.attachedFile,
      this.attachedImg})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        roomId, r'GSendMessageInput', 'roomId');
    BuiltValueNullFieldError.checkNotNull(
        sentBy, r'GSendMessageInput', 'sentBy');
    BuiltValueNullFieldError.checkNotNull(
        message, r'GSendMessageInput', 'message');
  }

  @override
  GSendMessageInput rebuild(void Function(GSendMessageInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSendMessageInputBuilder toBuilder() =>
      new GSendMessageInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSendMessageInput &&
        roomId == other.roomId &&
        sentBy == other.sentBy &&
        message == other.message &&
        attachedFile == other.attachedFile &&
        attachedImg == other.attachedImg;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, roomId.hashCode);
    _$hash = $jc(_$hash, sentBy.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, attachedFile.hashCode);
    _$hash = $jc(_$hash, attachedImg.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSendMessageInput')
          ..add('roomId', roomId)
          ..add('sentBy', sentBy)
          ..add('message', message)
          ..add('attachedFile', attachedFile)
          ..add('attachedImg', attachedImg))
        .toString();
  }
}

class GSendMessageInputBuilder
    implements Builder<GSendMessageInput, GSendMessageInputBuilder> {
  _$GSendMessageInput? _$v;

  String? _roomId;
  String? get roomId => _$this._roomId;
  set roomId(String? roomId) => _$this._roomId = roomId;

  String? _sentBy;
  String? get sentBy => _$this._sentBy;
  set sentBy(String? sentBy) => _$this._sentBy = sentBy;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<String>? _attachedFile;
  ListBuilder<String> get attachedFile =>
      _$this._attachedFile ??= new ListBuilder<String>();
  set attachedFile(ListBuilder<String>? attachedFile) =>
      _$this._attachedFile = attachedFile;

  ListBuilder<String>? _attachedImg;
  ListBuilder<String> get attachedImg =>
      _$this._attachedImg ??= new ListBuilder<String>();
  set attachedImg(ListBuilder<String>? attachedImg) =>
      _$this._attachedImg = attachedImg;

  GSendMessageInputBuilder();

  GSendMessageInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _roomId = $v.roomId;
      _sentBy = $v.sentBy;
      _message = $v.message;
      _attachedFile = $v.attachedFile?.toBuilder();
      _attachedImg = $v.attachedImg?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSendMessageInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSendMessageInput;
  }

  @override
  void update(void Function(GSendMessageInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSendMessageInput build() => _build();

  _$GSendMessageInput _build() {
    _$GSendMessageInput _$result;
    try {
      _$result = _$v ??
          new _$GSendMessageInput._(
              roomId: BuiltValueNullFieldError.checkNotNull(
                  roomId, r'GSendMessageInput', 'roomId'),
              sentBy: BuiltValueNullFieldError.checkNotNull(
                  sentBy, r'GSendMessageInput', 'sentBy'),
              message: BuiltValueNullFieldError.checkNotNull(
                  message, r'GSendMessageInput', 'message'),
              attachedFile: _attachedFile?.build(),
              attachedImg: _attachedImg?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'attachedFile';
        _attachedFile?.build();
        _$failedField = 'attachedImg';
        _attachedImg?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GSendMessageInput', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateBelongsToArtistStatusInput
    extends GUpdateBelongsToArtistStatusInput {
  @override
  final String id;
  @override
  final String? artistId;
  @override
  final String? status;

  factory _$GUpdateBelongsToArtistStatusInput(
          [void Function(GUpdateBelongsToArtistStatusInputBuilder)? updates]) =>
      (new GUpdateBelongsToArtistStatusInputBuilder()..update(updates))
          ._build();

  _$GUpdateBelongsToArtistStatusInput._(
      {required this.id, this.artistId, this.status})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        id, r'GUpdateBelongsToArtistStatusInput', 'id');
  }

  @override
  GUpdateBelongsToArtistStatusInput rebuild(
          void Function(GUpdateBelongsToArtistStatusInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateBelongsToArtistStatusInputBuilder toBuilder() =>
      new GUpdateBelongsToArtistStatusInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateBelongsToArtistStatusInput &&
        id == other.id &&
        artistId == other.artistId &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, artistId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateBelongsToArtistStatusInput')
          ..add('id', id)
          ..add('artistId', artistId)
          ..add('status', status))
        .toString();
  }
}

class GUpdateBelongsToArtistStatusInputBuilder
    implements
        Builder<GUpdateBelongsToArtistStatusInput,
            GUpdateBelongsToArtistStatusInputBuilder> {
  _$GUpdateBelongsToArtistStatusInput? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _artistId;
  String? get artistId => _$this._artistId;
  set artistId(String? artistId) => _$this._artistId = artistId;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  GUpdateBelongsToArtistStatusInputBuilder();

  GUpdateBelongsToArtistStatusInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _artistId = $v.artistId;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateBelongsToArtistStatusInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateBelongsToArtistStatusInput;
  }

  @override
  void update(
      void Function(GUpdateBelongsToArtistStatusInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateBelongsToArtistStatusInput build() => _build();

  _$GUpdateBelongsToArtistStatusInput _build() {
    final _$result = _$v ??
        new _$GUpdateBelongsToArtistStatusInput._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GUpdateBelongsToArtistStatusInput', 'id'),
            artistId: artistId,
            status: status);
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateNotificationInput extends GUpdateNotificationInput {
  @override
  final String id;
  @override
  final String? title;
  @override
  final String? content;

  factory _$GUpdateNotificationInput(
          [void Function(GUpdateNotificationInputBuilder)? updates]) =>
      (new GUpdateNotificationInputBuilder()..update(updates))._build();

  _$GUpdateNotificationInput._({required this.id, this.title, this.content})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        id, r'GUpdateNotificationInput', 'id');
  }

  @override
  GUpdateNotificationInput rebuild(
          void Function(GUpdateNotificationInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateNotificationInputBuilder toBuilder() =>
      new GUpdateNotificationInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateNotificationInput &&
        id == other.id &&
        title == other.title &&
        content == other.content;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateNotificationInput')
          ..add('id', id)
          ..add('title', title)
          ..add('content', content))
        .toString();
  }
}

class GUpdateNotificationInputBuilder
    implements
        Builder<GUpdateNotificationInput, GUpdateNotificationInputBuilder> {
  _$GUpdateNotificationInput? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  GUpdateNotificationInputBuilder();

  GUpdateNotificationInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _content = $v.content;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateNotificationInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateNotificationInput;
  }

  @override
  void update(void Function(GUpdateNotificationInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateNotificationInput build() => _build();

  _$GUpdateNotificationInput _build() {
    final _$result = _$v ??
        new _$GUpdateNotificationInput._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GUpdateNotificationInput', 'id'),
            title: title,
            content: content);
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateOfferInput extends GUpdateOfferInput {
  @override
  final String id;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final int? fee;
  @override
  final String? imageUrl;
  @override
  final int? raidId;
  @override
  final String? category;

  factory _$GUpdateOfferInput(
          [void Function(GUpdateOfferInputBuilder)? updates]) =>
      (new GUpdateOfferInputBuilder()..update(updates))._build();

  _$GUpdateOfferInput._(
      {required this.id,
      this.title,
      this.description,
      this.fee,
      this.imageUrl,
      this.raidId,
      this.category})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'GUpdateOfferInput', 'id');
  }

  @override
  GUpdateOfferInput rebuild(void Function(GUpdateOfferInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateOfferInputBuilder toBuilder() =>
      new GUpdateOfferInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateOfferInput &&
        id == other.id &&
        title == other.title &&
        description == other.description &&
        fee == other.fee &&
        imageUrl == other.imageUrl &&
        raidId == other.raidId &&
        category == other.category;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, fee.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jc(_$hash, raidId.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateOfferInput')
          ..add('id', id)
          ..add('title', title)
          ..add('description', description)
          ..add('fee', fee)
          ..add('imageUrl', imageUrl)
          ..add('raidId', raidId)
          ..add('category', category))
        .toString();
  }
}

class GUpdateOfferInputBuilder
    implements Builder<GUpdateOfferInput, GUpdateOfferInputBuilder> {
  _$GUpdateOfferInput? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  int? _fee;
  int? get fee => _$this._fee;
  set fee(int? fee) => _$this._fee = fee;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  int? _raidId;
  int? get raidId => _$this._raidId;
  set raidId(int? raidId) => _$this._raidId = raidId;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  GUpdateOfferInputBuilder();

  GUpdateOfferInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _description = $v.description;
      _fee = $v.fee;
      _imageUrl = $v.imageUrl;
      _raidId = $v.raidId;
      _category = $v.category;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateOfferInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateOfferInput;
  }

  @override
  void update(void Function(GUpdateOfferInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateOfferInput build() => _build();

  _$GUpdateOfferInput _build() {
    final _$result = _$v ??
        new _$GUpdateOfferInput._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GUpdateOfferInput', 'id'),
            title: title,
            description: description,
            fee: fee,
            imageUrl: imageUrl,
            raidId: raidId,
            category: category);
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateUserDataInput extends GUpdateUserDataInput {
  @override
  final String id;
  @override
  final String? email;
  @override
  final String? name;
  @override
  final String? imageUrl;
  @override
  final String? primaryCategory;
  @override
  final String? evmAddr;
  @override
  final String? status;

  factory _$GUpdateUserDataInput(
          [void Function(GUpdateUserDataInputBuilder)? updates]) =>
      (new GUpdateUserDataInputBuilder()..update(updates))._build();

  _$GUpdateUserDataInput._(
      {required this.id,
      this.email,
      this.name,
      this.imageUrl,
      this.primaryCategory,
      this.evmAddr,
      this.status})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'GUpdateUserDataInput', 'id');
  }

  @override
  GUpdateUserDataInput rebuild(
          void Function(GUpdateUserDataInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateUserDataInputBuilder toBuilder() =>
      new GUpdateUserDataInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateUserDataInput &&
        id == other.id &&
        email == other.email &&
        name == other.name &&
        imageUrl == other.imageUrl &&
        primaryCategory == other.primaryCategory &&
        evmAddr == other.evmAddr &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jc(_$hash, primaryCategory.hashCode);
    _$hash = $jc(_$hash, evmAddr.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateUserDataInput')
          ..add('id', id)
          ..add('email', email)
          ..add('name', name)
          ..add('imageUrl', imageUrl)
          ..add('primaryCategory', primaryCategory)
          ..add('evmAddr', evmAddr)
          ..add('status', status))
        .toString();
  }
}

class GUpdateUserDataInputBuilder
    implements Builder<GUpdateUserDataInput, GUpdateUserDataInputBuilder> {
  _$GUpdateUserDataInput? _$v;

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

  String? _primaryCategory;
  String? get primaryCategory => _$this._primaryCategory;
  set primaryCategory(String? primaryCategory) =>
      _$this._primaryCategory = primaryCategory;

  String? _evmAddr;
  String? get evmAddr => _$this._evmAddr;
  set evmAddr(String? evmAddr) => _$this._evmAddr = evmAddr;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  GUpdateUserDataInputBuilder();

  GUpdateUserDataInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _email = $v.email;
      _name = $v.name;
      _imageUrl = $v.imageUrl;
      _primaryCategory = $v.primaryCategory;
      _evmAddr = $v.evmAddr;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateUserDataInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateUserDataInput;
  }

  @override
  void update(void Function(GUpdateUserDataInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateUserDataInput build() => _build();

  _$GUpdateUserDataInput _build() {
    final _$result = _$v ??
        new _$GUpdateUserDataInput._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GUpdateUserDataInput', 'id'),
            email: email,
            name: name,
            imageUrl: imageUrl,
            primaryCategory: primaryCategory,
            evmAddr: evmAddr,
            status: status);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
