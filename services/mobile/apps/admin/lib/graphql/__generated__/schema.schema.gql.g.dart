// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema.schema.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GTransactionDirection _$gTransactionDirectionIN =
    const GTransactionDirection._('IN');
const GTransactionDirection _$gTransactionDirectionOUT =
    const GTransactionDirection._('OUT');

GTransactionDirection _$gTransactionDirectionValueOf(String name) {
  switch (name) {
    case 'IN':
      return _$gTransactionDirectionIN;
    case 'OUT':
      return _$gTransactionDirectionOUT;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<GTransactionDirection> _$gTransactionDirectionValues =
    new BuiltSet<GTransactionDirection>(const <GTransactionDirection>[
  _$gTransactionDirectionIN,
  _$gTransactionDirectionOUT,
]);

Serializer<GBlockUserInput> _$gBlockUserInputSerializer =
    new _$GBlockUserInputSerializer();
Serializer<GContactToAdminInput> _$gContactToAdminInputSerializer =
    new _$GContactToAdminInputSerializer();
Serializer<GCreateNewArtistInput> _$gCreateNewArtistInputSerializer =
    new _$GCreateNewArtistInputSerializer();
Serializer<GCreateNewMessageRoomInput> _$gCreateNewMessageRoomInputSerializer =
    new _$GCreateNewMessageRoomInputSerializer();
Serializer<GCreateNewOfferInput> _$gCreateNewOfferInputSerializer =
    new _$GCreateNewOfferInputSerializer();
Serializer<GCreateNewPrizeInput> _$gCreateNewPrizeInputSerializer =
    new _$GCreateNewPrizeInputSerializer();
Serializer<GCreateNewTransactionInput> _$gCreateNewTransactionInputSerializer =
    new _$GCreateNewTransactionInputSerializer();
Serializer<GCreateNewUserDataInput> _$gCreateNewUserDataInputSerializer =
    new _$GCreateNewUserDataInputSerializer();
Serializer<GCreateQuestInput> _$gCreateQuestInputSerializer =
    new _$GCreateQuestInputSerializer();
Serializer<GDeleteCreditInput> _$gDeleteCreditInputSerializer =
    new _$GDeleteCreditInputSerializer();
Serializer<GDeleteOfferInput> _$gDeleteOfferInputSerializer =
    new _$GDeleteOfferInputSerializer();
Serializer<GDeletePortfolioInput> _$gDeletePortfolioInputSerializer =
    new _$GDeletePortfolioInputSerializer();
Serializer<GExchangePrizeInput> _$gExchangePrizeInputSerializer =
    new _$GExchangePrizeInputSerializer();
Serializer<GMarkAsAdminInput> _$gMarkAsAdminInputSerializer =
    new _$GMarkAsAdminInputSerializer();
Serializer<GMarkAsMemberInput> _$gMarkAsMemberInputSerializer =
    new _$GMarkAsMemberInputSerializer();
Serializer<GMarkAsReadInput> _$gMarkAsReadInputSerializer =
    new _$GMarkAsReadInputSerializer();
Serializer<GRegisterCreditInput> _$gRegisterCreditInputSerializer =
    new _$GRegisterCreditInputSerializer();
Serializer<GRegisterInfo> _$gRegisterInfoSerializer =
    new _$GRegisterInfoSerializer();
Serializer<GRegisterPortfolioInput> _$gRegisterPortfolioInputSerializer =
    new _$GRegisterPortfolioInputSerializer();
Serializer<GRegisterReleases> _$gRegisterReleasesSerializer =
    new _$GRegisterReleasesSerializer();
Serializer<GReleaseData> _$gReleaseDataSerializer =
    new _$GReleaseDataSerializer();
Serializer<GReportOfferInput> _$gReportOfferInputSerializer =
    new _$GReportOfferInputSerializer();
Serializer<GReportUserInput> _$gReportUserInputSerializer =
    new _$GReportUserInputSerializer();
Serializer<GRequestPrizeInput> _$gRequestPrizeInputSerializer =
    new _$GRequestPrizeInputSerializer();
Serializer<GRequestToAccessArtistInput>
    _$gRequestToAccessArtistInputSerializer =
    new _$GRequestToAccessArtistInputSerializer();
Serializer<GSearchOptionsOffersInput> _$gSearchOptionsOffersInputSerializer =
    new _$GSearchOptionsOffersInputSerializer();
Serializer<GSearchProductsQuery> _$gSearchProductsQuerySerializer =
    new _$GSearchProductsQuerySerializer();
Serializer<GSearchTracksQuery> _$gSearchTracksQuerySerializer =
    new _$GSearchTracksQuerySerializer();
Serializer<GSendMessageInput> _$gSendMessageInputSerializer =
    new _$GSendMessageInputSerializer();
Serializer<GStatusUser> _$gStatusUserSerializer = new _$GStatusUserSerializer();
Serializer<GTransactionDirection> _$gTransactionDirectionSerializer =
    new _$GTransactionDirectionSerializer();
Serializer<GUpdateArtistInput> _$gUpdateArtistInputSerializer =
    new _$GUpdateArtistInputSerializer();
Serializer<GUpdateBelongsToArtistStatusInput>
    _$gUpdateBelongsToArtistStatusInputSerializer =
    new _$GUpdateBelongsToArtistStatusInputSerializer();
Serializer<GUpdateCreditInput> _$gUpdateCreditInputSerializer =
    new _$GUpdateCreditInputSerializer();
Serializer<GUpdateOfferInput> _$gUpdateOfferInputSerializer =
    new _$GUpdateOfferInputSerializer();
Serializer<GUpdateOfferStatusInput> _$gUpdateOfferStatusInputSerializer =
    new _$GUpdateOfferStatusInputSerializer();
Serializer<GUpdatePortfolioInput> _$gUpdatePortfolioInputSerializer =
    new _$GUpdatePortfolioInputSerializer();
Serializer<GUpdateProductInput> _$gUpdateProductInputSerializer =
    new _$GUpdateProductInputSerializer();
Serializer<GUpdateTrackInput> _$gUpdateTrackInputSerializer =
    new _$GUpdateTrackInputSerializer();
Serializer<GUpdateUserDataInput> _$gUpdateUserDataInputSerializer =
    new _$GUpdateUserDataInputSerializer();
Serializer<GUsePrizeInput> _$gUsePrizeInputSerializer =
    new _$GUsePrizeInputSerializer();

class _$GBlockUserInputSerializer
    implements StructuredSerializer<GBlockUserInput> {
  @override
  final Iterable<Type> types = const [GBlockUserInput, _$GBlockUserInput];
  @override
  final String wireName = 'GBlockUserInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, GBlockUserInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'blockedUserId',
      serializers.serialize(object.blockedUserId,
          specifiedType: const FullType(String)),
      'blockerUserId',
      serializers.serialize(object.blockerUserId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GBlockUserInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GBlockUserInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'blockedUserId':
          result.blockedUserId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'blockerUserId':
          result.blockerUserId = serializers.deserialize(value,
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
      'displayNameJp',
      serializers.serialize(object.displayNameJp,
          specifiedType: const FullType(String)),
      'displayNameEn',
      serializers.serialize(object.displayNameEn,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.displayNameKana;
    if (value != null) {
      result
        ..add('displayNameKana')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.imgUrl;
    if (value != null) {
      result
        ..add('imgUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.fsp;
    if (value != null) {
      result
        ..add('fsp')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
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
        case 'displayNameJp':
          result.displayNameJp = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'displayNameEn':
          result.displayNameEn = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'displayNameKana':
          result.displayNameKana = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'imgUrl':
          result.imgUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'fsp':
          result.fsp = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
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
      'createdBy',
      serializers.serialize(object.createdBy,
          specifiedType: const FullType(String)),
      'userList',
      serializers.serialize(object.userList,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
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
        case 'createdBy':
          result.createdBy = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'userList':
          result.userList.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
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
    value = object.deadline;
    if (value != null) {
      result
        ..add('deadline')
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
    value = object.attention;
    if (value != null) {
      result
        ..add('attention')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.requiredSkill;
    if (value != null) {
      result
        ..add('requiredSkill')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.targetRole;
    if (value != null) {
      result
        ..add('targetRole')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.publicity;
    if (value != null) {
      result
        ..add('publicity')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.attachedImgs;
    if (value != null) {
      result
        ..add('attachedImgs')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.attachedFiles;
    if (value != null) {
      result
        ..add('attachedFiles')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
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
        case 'deadline':
          result.deadline = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
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
        case 'place':
          result.place = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'attention':
          result.attention = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'requiredSkill':
          result.requiredSkill = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'targetRole':
          result.targetRole = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'publicity':
          result.publicity = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'attachedImgs':
          result.attachedImgs.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'attachedFiles':
          result.attachedFiles.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateNewPrizeInputSerializer
    implements StructuredSerializer<GCreateNewPrizeInput> {
  @override
  final Iterable<Type> types = const [
    GCreateNewPrizeInput,
    _$GCreateNewPrizeInput
  ];
  @override
  final String wireName = 'GCreateNewPrizeInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateNewPrizeInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'point',
      serializers.serialize(object.point, specifiedType: const FullType(int)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'representation',
      serializers.serialize(object.representation,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.condition;
    if (value != null) {
      result
        ..add('condition')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.imgUrl;
    if (value != null) {
      result
        ..add('imgUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.publicity;
    if (value != null) {
      result
        ..add('publicity')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  GCreateNewPrizeInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateNewPrizeInputBuilder();

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
        case 'point':
          result.point = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'representation':
          result.representation = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'condition':
          result.condition = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'imgUrl':
          result.imgUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'publicity':
          result.publicity = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
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
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'realname',
      serializers.serialize(object.realname,
          specifiedType: const FullType(String)),
      'category',
      serializers.serialize(object.category,
          specifiedType: const FullType(String)),
      'primaryCategory',
      serializers.serialize(object.primaryCategory,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.fcmToken;
    if (value != null) {
      result
        ..add('fcmToken')
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
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'fcmToken':
          result.fcmToken = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
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

class _$GCreateQuestInputSerializer
    implements StructuredSerializer<GCreateQuestInput> {
  @override
  final Iterable<Type> types = const [GCreateQuestInput, _$GCreateQuestInput];
  @override
  final String wireName = 'GCreateQuestInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, GCreateQuestInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GCreateQuestInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateQuestInputBuilder();

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
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GDeleteCreditInputSerializer
    implements StructuredSerializer<GDeleteCreditInput> {
  @override
  final Iterable<Type> types = const [GDeleteCreditInput, _$GDeleteCreditInput];
  @override
  final String wireName = 'GDeleteCreditInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GDeleteCreditInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'creditId',
      serializers.serialize(object.creditId,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GDeleteCreditInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GDeleteCreditInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'creditId':
          result.creditId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
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

class _$GDeletePortfolioInputSerializer
    implements StructuredSerializer<GDeletePortfolioInput> {
  @override
  final Iterable<Type> types = const [
    GDeletePortfolioInput,
    _$GDeletePortfolioInput
  ];
  @override
  final String wireName = 'GDeletePortfolioInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GDeletePortfolioInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GDeletePortfolioInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GDeletePortfolioInputBuilder();

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

class _$GExchangePrizeInputSerializer
    implements StructuredSerializer<GExchangePrizeInput> {
  @override
  final Iterable<Type> types = const [
    GExchangePrizeInput,
    _$GExchangePrizeInput
  ];
  @override
  final String wireName = 'GExchangePrizeInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GExchangePrizeInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
      'prizeId',
      serializers.serialize(object.prizeId, specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.amount;
    if (value != null) {
      result
        ..add('amount')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  GExchangePrizeInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GExchangePrizeInputBuilder();

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
        case 'prizeId':
          result.prizeId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'amount':
          result.amount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$GMarkAsAdminInputSerializer
    implements StructuredSerializer<GMarkAsAdminInput> {
  @override
  final Iterable<Type> types = const [GMarkAsAdminInput, _$GMarkAsAdminInput];
  @override
  final String wireName = 'GMarkAsAdminInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, GMarkAsAdminInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'adminMember',
      serializers.serialize(object.adminMember,
          specifiedType: const FullType(String)),
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
      'artistId',
      serializers.serialize(object.artistId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GMarkAsAdminInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GMarkAsAdminInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'adminMember':
          result.adminMember = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'artistId':
          result.artistId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GMarkAsMemberInputSerializer
    implements StructuredSerializer<GMarkAsMemberInput> {
  @override
  final Iterable<Type> types = const [GMarkAsMemberInput, _$GMarkAsMemberInput];
  @override
  final String wireName = 'GMarkAsMemberInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMarkAsMemberInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'member',
      serializers.serialize(object.member,
          specifiedType: const FullType(String)),
      'artistId',
      serializers.serialize(object.artistId,
          specifiedType: const FullType(String)),
      'mapping',
      serializers.serialize(object.mapping,
          specifiedType:
              const FullType(BuiltList, const [const FullType(GStatusUser)])),
    ];

    return result;
  }

  @override
  GMarkAsMemberInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GMarkAsMemberInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'member':
          result.member = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'artistId':
          result.artistId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'mapping':
          result.mapping.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(GStatusUser)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GMarkAsReadInputSerializer
    implements StructuredSerializer<GMarkAsReadInput> {
  @override
  final Iterable<Type> types = const [GMarkAsReadInput, _$GMarkAsReadInput];
  @override
  final String wireName = 'GMarkAsReadInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, GMarkAsReadInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'roomId',
      serializers.serialize(object.roomId,
          specifiedType: const FullType(String)),
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
      'messageId',
      serializers.serialize(object.messageId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GMarkAsReadInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GMarkAsReadInputBuilder();

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
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'messageId':
          result.messageId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GRegisterCreditInputSerializer
    implements StructuredSerializer<GRegisterCreditInput> {
  @override
  final Iterable<Type> types = const [
    GRegisterCreditInput,
    _$GRegisterCreditInput
  ];
  @override
  final String wireName = 'GRegisterCreditInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GRegisterCreditInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'registerInfo',
      serializers.serialize(object.registerInfo,
          specifiedType:
              const FullType(BuiltList, const [const FullType(GRegisterInfo)])),
    ];

    return result;
  }

  @override
  GRegisterCreditInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GRegisterCreditInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'registerInfo':
          result.registerInfo.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(GRegisterInfo)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GRegisterInfoSerializer implements StructuredSerializer<GRegisterInfo> {
  @override
  final Iterable<Type> types = const [GRegisterInfo, _$GRegisterInfo];
  @override
  final String wireName = 'GRegisterInfo';

  @override
  Iterable<Object?> serialize(Serializers serializers, GRegisterInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'isrc',
      serializers.serialize(object.isrc, specifiedType: const FullType(String)),
      'commitUser',
      serializers.serialize(object.commitUser,
          specifiedType: const FullType(String)),
      'creditRole',
      serializers.serialize(object.creditRole,
          specifiedType: const FullType(String)),
      'creditName',
      serializers.serialize(object.creditName,
          specifiedType: const FullType(String)),
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'isInvite',
      serializers.serialize(object.isInvite,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.memo;
    if (value != null) {
      result
        ..add('memo')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GRegisterInfo deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GRegisterInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'isrc':
          result.isrc = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'commitUser':
          result.commitUser = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'creditRole':
          result.creditRole = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'creditName':
          result.creditName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'isInvite':
          result.isInvite = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'memo':
          result.memo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GRegisterPortfolioInputSerializer
    implements StructuredSerializer<GRegisterPortfolioInput> {
  @override
  final Iterable<Type> types = const [
    GRegisterPortfolioInput,
    _$GRegisterPortfolioInput
  ];
  @override
  final String wireName = 'GRegisterPortfolioInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GRegisterPortfolioInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'imgUrl',
      serializers.serialize(object.imgUrl,
          specifiedType: const FullType(String)),
      'category',
      serializers.serialize(object.category,
          specifiedType: const FullType(String)),
      'releaseDate',
      serializers.serialize(object.releaseDate,
          specifiedType: const FullType(String)),
      'externalUrl',
      serializers.serialize(object.externalUrl,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GRegisterPortfolioInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GRegisterPortfolioInputBuilder();

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
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'imgUrl':
          result.imgUrl = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'category':
          result.category = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'releaseDate':
          result.releaseDate = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'externalUrl':
          result.externalUrl = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GRegisterReleasesSerializer
    implements StructuredSerializer<GRegisterReleases> {
  @override
  final Iterable<Type> types = const [GRegisterReleases, _$GRegisterReleases];
  @override
  final String wireName = 'GRegisterReleases';

  @override
  Iterable<Object?> serialize(Serializers serializers, GRegisterReleases object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'releases',
      serializers.serialize(object.releases,
          specifiedType:
              const FullType(BuiltList, const [const FullType(GReleaseData)])),
    ];

    return result;
  }

  @override
  GRegisterReleases deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GRegisterReleasesBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'releases':
          result.releases.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(GReleaseData)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GReleaseDataSerializer implements StructuredSerializer<GReleaseData> {
  @override
  final Iterable<Type> types = const [GReleaseData, _$GReleaseData];
  @override
  final String wireName = 'GReleaseData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GReleaseData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'upc',
      serializers.serialize(object.upc, specifiedType: const FullType(String)),
      'format',
      serializers.serialize(object.format,
          specifiedType: const FullType(String)),
      'trackCount',
      serializers.serialize(object.trackCount,
          specifiedType: const FullType(int)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'releaseDate',
      serializers.serialize(object.releaseDate,
          specifiedType: const FullType(String)),
      'isrc',
      serializers.serialize(object.isrc, specifiedType: const FullType(String)),
      'trackNo',
      serializers.serialize(object.trackNo, specifiedType: const FullType(int)),
      'trackTitle',
      serializers.serialize(object.trackTitle,
          specifiedType: const FullType(String)),
      'trackTitleVersion',
      serializers.serialize(object.trackTitleVersion,
          specifiedType: const FullType(String)),
      'artistId',
      serializers.serialize(object.artistId,
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
  GReleaseData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GReleaseDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'upc':
          result.upc = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'format':
          result.format = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'trackCount':
          result.trackCount = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'releaseDate':
          result.releaseDate = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'isrc':
          result.isrc = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'trackNo':
          result.trackNo = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'trackTitle':
          result.trackTitle = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'trackTitleVersion':
          result.trackTitleVersion = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'artistId':
          result.artistId = serializers.deserialize(value,
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

class _$GReportOfferInputSerializer
    implements StructuredSerializer<GReportOfferInput> {
  @override
  final Iterable<Type> types = const [GReportOfferInput, _$GReportOfferInput];
  @override
  final String wireName = 'GReportOfferInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, GReportOfferInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'offerId',
      serializers.serialize(object.offerId, specifiedType: const FullType(int)),
      'reporterUserId',
      serializers.serialize(object.reporterUserId,
          specifiedType: const FullType(String)),
      'reportContent',
      serializers.serialize(object.reportContent,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GReportOfferInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GReportOfferInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'offerId':
          result.offerId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'reporterUserId':
          result.reporterUserId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'reportContent':
          result.reportContent = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GReportUserInputSerializer
    implements StructuredSerializer<GReportUserInput> {
  @override
  final Iterable<Type> types = const [GReportUserInput, _$GReportUserInput];
  @override
  final String wireName = 'GReportUserInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, GReportUserInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'reportedUserId',
      serializers.serialize(object.reportedUserId,
          specifiedType: const FullType(String)),
      'reporterUserId',
      serializers.serialize(object.reporterUserId,
          specifiedType: const FullType(String)),
      'reportContent',
      serializers.serialize(object.reportContent,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GReportUserInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GReportUserInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'reportedUserId':
          result.reportedUserId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'reporterUserId':
          result.reporterUserId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'reportContent':
          result.reportContent = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GRequestPrizeInputSerializer
    implements StructuredSerializer<GRequestPrizeInput> {
  @override
  final Iterable<Type> types = const [GRequestPrizeInput, _$GRequestPrizeInput];
  @override
  final String wireName = 'GRequestPrizeInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GRequestPrizeInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
      'prizeId',
      serializers.serialize(object.prizeId, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GRequestPrizeInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GRequestPrizeInputBuilder();

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
        case 'prizeId':
          result.prizeId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GRequestToAccessArtistInputSerializer
    implements StructuredSerializer<GRequestToAccessArtistInput> {
  @override
  final Iterable<Type> types = const [
    GRequestToAccessArtistInput,
    _$GRequestToAccessArtistInput
  ];
  @override
  final String wireName = 'GRequestToAccessArtistInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GRequestToAccessArtistInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
      'artistIds',
      serializers.serialize(object.artistIds,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  GRequestToAccessArtistInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GRequestToAccessArtistInputBuilder();

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
        case 'artistIds':
          result.artistIds.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GSearchOptionsOffersInputSerializer
    implements StructuredSerializer<GSearchOptionsOffersInput> {
  @override
  final Iterable<Type> types = const [
    GSearchOptionsOffersInput,
    _$GSearchOptionsOffersInput
  ];
  @override
  final String wireName = 'GSearchOptionsOffersInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSearchOptionsOffersInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.owner;
    if (value != null) {
      result
        ..add('owner')
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
    value = object.targetRole;
    if (value != null) {
      result
        ..add('targetRole')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.place;
    if (value != null) {
      result
        ..add('place')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.minPrice;
    if (value != null) {
      result
        ..add('minPrice')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.maxPrice;
    if (value != null) {
      result
        ..add('maxPrice')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.sortBy;
    if (value != null) {
      result
        ..add('sortBy')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GSearchOptionsOffersInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSearchOptionsOffersInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'owner':
          result.owner = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'category':
          result.category = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'targetRole':
          result.targetRole = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'place':
          result.place = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'minPrice':
          result.minPrice = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'maxPrice':
          result.maxPrice = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'sortBy':
          result.sortBy = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GSearchProductsQuerySerializer
    implements StructuredSerializer<GSearchProductsQuery> {
  @override
  final Iterable<Type> types = const [
    GSearchProductsQuery,
    _$GSearchProductsQuery
  ];
  @override
  final String wireName = 'GSearchProductsQuery';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSearchProductsQuery object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.upc;
    if (value != null) {
      result
        ..add('upc')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.productTitle;
    if (value != null) {
      result
        ..add('productTitle')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.artistId;
    if (value != null) {
      result
        ..add('artistId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.productType;
    if (value != null) {
      result
        ..add('productType')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GSearchProductsQuery deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSearchProductsQueryBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'upc':
          result.upc = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'productTitle':
          result.productTitle = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'artistId':
          result.artistId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'productType':
          result.productType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GSearchTracksQuerySerializer
    implements StructuredSerializer<GSearchTracksQuery> {
  @override
  final Iterable<Type> types = const [GSearchTracksQuery, _$GSearchTracksQuery];
  @override
  final String wireName = 'GSearchTracksQuery';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSearchTracksQuery object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.isrc;
    if (value != null) {
      result
        ..add('isrc')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.trackTitle;
    if (value != null) {
      result
        ..add('trackTitle')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.artistId;
    if (value != null) {
      result
        ..add('artistId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GSearchTracksQuery deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSearchTracksQueryBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'isrc':
          result.isrc = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'trackTitle':
          result.trackTitle = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'artistId':
          result.artistId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
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

class _$GStatusUserSerializer implements StructuredSerializer<GStatusUser> {
  @override
  final Iterable<Type> types = const [GStatusUser, _$GStatusUser];
  @override
  final String wireName = 'GStatusUser';

  @override
  Iterable<Object?> serialize(Serializers serializers, GStatusUser object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
      'status',
      serializers.serialize(object.status,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GStatusUser deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GStatusUserBuilder();

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
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GTransactionDirectionSerializer
    implements PrimitiveSerializer<GTransactionDirection> {
  @override
  final Iterable<Type> types = const <Type>[GTransactionDirection];
  @override
  final String wireName = 'GTransactionDirection';

  @override
  Object serialize(Serializers serializers, GTransactionDirection object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GTransactionDirection deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GTransactionDirection.valueOf(serialized as String);
}

class _$GUpdateArtistInputSerializer
    implements StructuredSerializer<GUpdateArtistInput> {
  @override
  final Iterable<Type> types = const [GUpdateArtistInput, _$GUpdateArtistInput];
  @override
  final String wireName = 'GUpdateArtistInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateArtistInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'artistId',
      serializers.serialize(object.artistId,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.displayNameJp;
    if (value != null) {
      result
        ..add('displayNameJp')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.displayNameEn;
    if (value != null) {
      result
        ..add('displayNameEn')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.displayNameKana;
    if (value != null) {
      result
        ..add('displayNameKana')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.imgUrl;
    if (value != null) {
      result
        ..add('imgUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.fsp;
    if (value != null) {
      result
        ..add('fsp')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
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
  GUpdateArtistInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateArtistInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'artistId':
          result.artistId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'displayNameJp':
          result.displayNameJp = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'displayNameEn':
          result.displayNameEn = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'displayNameKana':
          result.displayNameKana = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'imgUrl':
          result.imgUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'fsp':
          result.fsp = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
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
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
      'artistId',
      serializers.serialize(object.artistId,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.nextStatus;
    if (value != null) {
      result
        ..add('nextStatus')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.nextStatusIsAdmin;
    if (value != null) {
      result
        ..add('nextStatusIsAdmin')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
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
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'artistId':
          result.artistId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'nextStatus':
          result.nextStatus = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'nextStatusIsAdmin':
          result.nextStatusIsAdmin = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateCreditInputSerializer
    implements StructuredSerializer<GUpdateCreditInput> {
  @override
  final Iterable<Type> types = const [GUpdateCreditInput, _$GUpdateCreditInput];
  @override
  final String wireName = 'GUpdateCreditInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateCreditInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'creditId',
      serializers.serialize(object.creditId,
          specifiedType: const FullType(int)),
      'commitUser',
      serializers.serialize(object.commitUser,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.creditRole;
    if (value != null) {
      result
        ..add('creditRole')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.creditName;
    if (value != null) {
      result
        ..add('creditName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.email;
    if (value != null) {
      result
        ..add('email')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.isInvite;
    if (value != null) {
      result
        ..add('isInvite')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.memo;
    if (value != null) {
      result
        ..add('memo')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GUpdateCreditInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateCreditInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'creditId':
          result.creditId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'commitUser':
          result.commitUser = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'creditRole':
          result.creditRole = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'creditName':
          result.creditName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'isInvite':
          result.isInvite = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'memo':
          result.memo = serializers.deserialize(value,
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
      serializers.serialize(object.id, specifiedType: const FullType(int)),
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
    value = object.category;
    if (value != null) {
      result
        ..add('category')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.place;
    if (value != null) {
      result
        ..add('place')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.attention;
    if (value != null) {
      result
        ..add('attention')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.requiredSkill;
    if (value != null) {
      result
        ..add('requiredSkill')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.targetRole;
    if (value != null) {
      result
        ..add('targetRole')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.attachedImgs;
    if (value != null) {
      result
        ..add('attachedImgs')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.attachedFiles;
    if (value != null) {
      result
        ..add('attachedFiles')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.publicity;
    if (value != null) {
      result
        ..add('publicity')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.deadline;
    if (value != null) {
      result
        ..add('deadline')
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
              specifiedType: const FullType(int))! as int;
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
        case 'category':
          result.category = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'place':
          result.place = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'attention':
          result.attention = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'requiredSkill':
          result.requiredSkill = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'targetRole':
          result.targetRole = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'attachedImgs':
          result.attachedImgs.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'attachedFiles':
          result.attachedFiles.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'publicity':
          result.publicity = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'deadline':
          result.deadline = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateOfferStatusInputSerializer
    implements StructuredSerializer<GUpdateOfferStatusInput> {
  @override
  final Iterable<Type> types = const [
    GUpdateOfferStatusInput,
    _$GUpdateOfferStatusInput
  ];
  @override
  final String wireName = 'GUpdateOfferStatusInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateOfferStatusInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
      'status',
      serializers.serialize(object.status,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GUpdateOfferStatusInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateOfferStatusInputBuilder();

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
        case 'userId':
          result.userId = serializers.deserialize(value,
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

class _$GUpdatePortfolioInputSerializer
    implements StructuredSerializer<GUpdatePortfolioInput> {
  @override
  final Iterable<Type> types = const [
    GUpdatePortfolioInput,
    _$GUpdatePortfolioInput
  ];
  @override
  final String wireName = 'GUpdatePortfolioInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdatePortfolioInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
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
    value = object.imgUrl;
    if (value != null) {
      result
        ..add('imgUrl')
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
    value = object.releaseDate;
    if (value != null) {
      result
        ..add('releaseDate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.externalUrl;
    if (value != null) {
      result
        ..add('externalUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GUpdatePortfolioInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdatePortfolioInputBuilder();

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
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'imgUrl':
          result.imgUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'category':
          result.category = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'releaseDate':
          result.releaseDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'externalUrl':
          result.externalUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateProductInputSerializer
    implements StructuredSerializer<GUpdateProductInput> {
  @override
  final Iterable<Type> types = const [
    GUpdateProductInput,
    _$GUpdateProductInput
  ];
  @override
  final String wireName = 'GUpdateProductInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateProductInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'upc',
      serializers.serialize(object.upc, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.title;
    if (value != null) {
      result
        ..add('title')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.imgUrl;
    if (value != null) {
      result
        ..add('imgUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.type;
    if (value != null) {
      result
        ..add('type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.distributedAt;
    if (value != null) {
      result
        ..add('distributedAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.artistId;
    if (value != null) {
      result
        ..add('artistId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GUpdateProductInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateProductInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'upc':
          result.upc = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'imgUrl':
          result.imgUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'distributedAt':
          result.distributedAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'artistId':
          result.artistId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateTrackInputSerializer
    implements StructuredSerializer<GUpdateTrackInput> {
  @override
  final Iterable<Type> types = const [GUpdateTrackInput, _$GUpdateTrackInput];
  @override
  final String wireName = 'GUpdateTrackInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, GUpdateTrackInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'isrc',
      serializers.serialize(object.isrc, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.title;
    if (value != null) {
      result
        ..add('title')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GUpdateTrackInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateTrackInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'isrc':
          result.isrc = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
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
    value = object.fcmToken;
    if (value != null) {
      result
        ..add('fcmToken')
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
        case 'fcmToken':
          result.fcmToken = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'interestOffer':
          result.interestOffer = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GUsePrizeInputSerializer
    implements StructuredSerializer<GUsePrizeInput> {
  @override
  final Iterable<Type> types = const [GUsePrizeInput, _$GUsePrizeInput];
  @override
  final String wireName = 'GUsePrizeInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, GUsePrizeInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'representationUserId',
      serializers.serialize(object.representationUserId,
          specifiedType: const FullType(String)),
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
      'prizeId',
      serializers.serialize(object.prizeId, specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.code;
    if (value != null) {
      result
        ..add('code')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GUsePrizeInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUsePrizeInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'representationUserId':
          result.representationUserId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'prizeId':
          result.prizeId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'code':
          result.code = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GBlockUserInput extends GBlockUserInput {
  @override
  final String blockedUserId;
  @override
  final String blockerUserId;

  factory _$GBlockUserInput([void Function(GBlockUserInputBuilder)? updates]) =>
      (new GBlockUserInputBuilder()..update(updates))._build();

  _$GBlockUserInput._(
      {required this.blockedUserId, required this.blockerUserId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        blockedUserId, r'GBlockUserInput', 'blockedUserId');
    BuiltValueNullFieldError.checkNotNull(
        blockerUserId, r'GBlockUserInput', 'blockerUserId');
  }

  @override
  GBlockUserInput rebuild(void Function(GBlockUserInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GBlockUserInputBuilder toBuilder() =>
      new GBlockUserInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GBlockUserInput &&
        blockedUserId == other.blockedUserId &&
        blockerUserId == other.blockerUserId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, blockedUserId.hashCode);
    _$hash = $jc(_$hash, blockerUserId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GBlockUserInput')
          ..add('blockedUserId', blockedUserId)
          ..add('blockerUserId', blockerUserId))
        .toString();
  }
}

class GBlockUserInputBuilder
    implements Builder<GBlockUserInput, GBlockUserInputBuilder> {
  _$GBlockUserInput? _$v;

  String? _blockedUserId;
  String? get blockedUserId => _$this._blockedUserId;
  set blockedUserId(String? blockedUserId) =>
      _$this._blockedUserId = blockedUserId;

  String? _blockerUserId;
  String? get blockerUserId => _$this._blockerUserId;
  set blockerUserId(String? blockerUserId) =>
      _$this._blockerUserId = blockerUserId;

  GBlockUserInputBuilder();

  GBlockUserInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _blockedUserId = $v.blockedUserId;
      _blockerUserId = $v.blockerUserId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GBlockUserInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GBlockUserInput;
  }

  @override
  void update(void Function(GBlockUserInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GBlockUserInput build() => _build();

  _$GBlockUserInput _build() {
    final _$result = _$v ??
        new _$GBlockUserInput._(
            blockedUserId: BuiltValueNullFieldError.checkNotNull(
                blockedUserId, r'GBlockUserInput', 'blockedUserId'),
            blockerUserId: BuiltValueNullFieldError.checkNotNull(
                blockerUserId, r'GBlockUserInput', 'blockerUserId'));
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
  final String displayNameJp;
  @override
  final String displayNameEn;
  @override
  final String? displayNameKana;
  @override
  final String? imgUrl;
  @override
  final int? fsp;
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
      {required this.displayNameJp,
      required this.displayNameEn,
      this.displayNameKana,
      this.imgUrl,
      this.fsp,
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
        displayNameJp, r'GCreateNewArtistInput', 'displayNameJp');
    BuiltValueNullFieldError.checkNotNull(
        displayNameEn, r'GCreateNewArtistInput', 'displayNameEn');
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
        displayNameJp == other.displayNameJp &&
        displayNameEn == other.displayNameEn &&
        displayNameKana == other.displayNameKana &&
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
    _$hash = $jc(_$hash, displayNameJp.hashCode);
    _$hash = $jc(_$hash, displayNameEn.hashCode);
    _$hash = $jc(_$hash, displayNameKana.hashCode);
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
          ..add('displayNameJp', displayNameJp)
          ..add('displayNameEn', displayNameEn)
          ..add('displayNameKana', displayNameKana)
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

  String? _displayNameJp;
  String? get displayNameJp => _$this._displayNameJp;
  set displayNameJp(String? displayNameJp) =>
      _$this._displayNameJp = displayNameJp;

  String? _displayNameEn;
  String? get displayNameEn => _$this._displayNameEn;
  set displayNameEn(String? displayNameEn) =>
      _$this._displayNameEn = displayNameEn;

  String? _displayNameKana;
  String? get displayNameKana => _$this._displayNameKana;
  set displayNameKana(String? displayNameKana) =>
      _$this._displayNameKana = displayNameKana;

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
      _displayNameJp = $v.displayNameJp;
      _displayNameEn = $v.displayNameEn;
      _displayNameKana = $v.displayNameKana;
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
            displayNameJp: BuiltValueNullFieldError.checkNotNull(
                displayNameJp, r'GCreateNewArtistInput', 'displayNameJp'),
            displayNameEn: BuiltValueNullFieldError.checkNotNull(
                displayNameEn, r'GCreateNewArtistInput', 'displayNameEn'),
            displayNameKana: displayNameKana,
            imgUrl: imgUrl,
            fsp: fsp,
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
  @override
  final String createdBy;
  @override
  final BuiltList<String> userList;

  factory _$GCreateNewMessageRoomInput(
          [void Function(GCreateNewMessageRoomInputBuilder)? updates]) =>
      (new GCreateNewMessageRoomInputBuilder()..update(updates))._build();

  _$GCreateNewMessageRoomInput._(
      {required this.category, required this.createdBy, required this.userList})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        category, r'GCreateNewMessageRoomInput', 'category');
    BuiltValueNullFieldError.checkNotNull(
        createdBy, r'GCreateNewMessageRoomInput', 'createdBy');
    BuiltValueNullFieldError.checkNotNull(
        userList, r'GCreateNewMessageRoomInput', 'userList');
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
    return other is GCreateNewMessageRoomInput &&
        category == other.category &&
        createdBy == other.createdBy &&
        userList == other.userList;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, createdBy.hashCode);
    _$hash = $jc(_$hash, userList.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateNewMessageRoomInput')
          ..add('category', category)
          ..add('createdBy', createdBy)
          ..add('userList', userList))
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

  String? _createdBy;
  String? get createdBy => _$this._createdBy;
  set createdBy(String? createdBy) => _$this._createdBy = createdBy;

  ListBuilder<String>? _userList;
  ListBuilder<String> get userList =>
      _$this._userList ??= new ListBuilder<String>();
  set userList(ListBuilder<String>? userList) => _$this._userList = userList;

  GCreateNewMessageRoomInputBuilder();

  GCreateNewMessageRoomInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _category = $v.category;
      _createdBy = $v.createdBy;
      _userList = $v.userList.toBuilder();
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
    _$GCreateNewMessageRoomInput _$result;
    try {
      _$result = _$v ??
          new _$GCreateNewMessageRoomInput._(
              category: BuiltValueNullFieldError.checkNotNull(
                  category, r'GCreateNewMessageRoomInput', 'category'),
              createdBy: BuiltValueNullFieldError.checkNotNull(
                  createdBy, r'GCreateNewMessageRoomInput', 'createdBy'),
              userList: userList.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'userList';
        userList.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GCreateNewMessageRoomInput', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GCreateNewOfferInput extends GCreateNewOfferInput {
  @override
  final String owner;
  @override
  final String? deadline;
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
  @override
  final String place;
  @override
  final String? attention;
  @override
  final String? requiredSkill;
  @override
  final String? targetRole;
  @override
  final bool? publicity;
  @override
  final BuiltList<String>? attachedImgs;
  @override
  final BuiltList<String>? attachedFiles;

  factory _$GCreateNewOfferInput(
          [void Function(GCreateNewOfferInputBuilder)? updates]) =>
      (new GCreateNewOfferInputBuilder()..update(updates))._build();

  _$GCreateNewOfferInput._(
      {required this.owner,
      this.deadline,
      required this.title,
      required this.description,
      required this.fee,
      this.imageUrl,
      this.raidId,
      this.category,
      required this.place,
      this.attention,
      this.requiredSkill,
      this.targetRole,
      this.publicity,
      this.attachedImgs,
      this.attachedFiles})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        owner, r'GCreateNewOfferInput', 'owner');
    BuiltValueNullFieldError.checkNotNull(
        title, r'GCreateNewOfferInput', 'title');
    BuiltValueNullFieldError.checkNotNull(
        description, r'GCreateNewOfferInput', 'description');
    BuiltValueNullFieldError.checkNotNull(fee, r'GCreateNewOfferInput', 'fee');
    BuiltValueNullFieldError.checkNotNull(
        place, r'GCreateNewOfferInput', 'place');
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
        deadline == other.deadline &&
        title == other.title &&
        description == other.description &&
        fee == other.fee &&
        imageUrl == other.imageUrl &&
        raidId == other.raidId &&
        category == other.category &&
        place == other.place &&
        attention == other.attention &&
        requiredSkill == other.requiredSkill &&
        targetRole == other.targetRole &&
        publicity == other.publicity &&
        attachedImgs == other.attachedImgs &&
        attachedFiles == other.attachedFiles;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, owner.hashCode);
    _$hash = $jc(_$hash, deadline.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, fee.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jc(_$hash, raidId.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, place.hashCode);
    _$hash = $jc(_$hash, attention.hashCode);
    _$hash = $jc(_$hash, requiredSkill.hashCode);
    _$hash = $jc(_$hash, targetRole.hashCode);
    _$hash = $jc(_$hash, publicity.hashCode);
    _$hash = $jc(_$hash, attachedImgs.hashCode);
    _$hash = $jc(_$hash, attachedFiles.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateNewOfferInput')
          ..add('owner', owner)
          ..add('deadline', deadline)
          ..add('title', title)
          ..add('description', description)
          ..add('fee', fee)
          ..add('imageUrl', imageUrl)
          ..add('raidId', raidId)
          ..add('category', category)
          ..add('place', place)
          ..add('attention', attention)
          ..add('requiredSkill', requiredSkill)
          ..add('targetRole', targetRole)
          ..add('publicity', publicity)
          ..add('attachedImgs', attachedImgs)
          ..add('attachedFiles', attachedFiles))
        .toString();
  }
}

class GCreateNewOfferInputBuilder
    implements Builder<GCreateNewOfferInput, GCreateNewOfferInputBuilder> {
  _$GCreateNewOfferInput? _$v;

  String? _owner;
  String? get owner => _$this._owner;
  set owner(String? owner) => _$this._owner = owner;

  String? _deadline;
  String? get deadline => _$this._deadline;
  set deadline(String? deadline) => _$this._deadline = deadline;

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

  String? _place;
  String? get place => _$this._place;
  set place(String? place) => _$this._place = place;

  String? _attention;
  String? get attention => _$this._attention;
  set attention(String? attention) => _$this._attention = attention;

  String? _requiredSkill;
  String? get requiredSkill => _$this._requiredSkill;
  set requiredSkill(String? requiredSkill) =>
      _$this._requiredSkill = requiredSkill;

  String? _targetRole;
  String? get targetRole => _$this._targetRole;
  set targetRole(String? targetRole) => _$this._targetRole = targetRole;

  bool? _publicity;
  bool? get publicity => _$this._publicity;
  set publicity(bool? publicity) => _$this._publicity = publicity;

  ListBuilder<String>? _attachedImgs;
  ListBuilder<String> get attachedImgs =>
      _$this._attachedImgs ??= new ListBuilder<String>();
  set attachedImgs(ListBuilder<String>? attachedImgs) =>
      _$this._attachedImgs = attachedImgs;

  ListBuilder<String>? _attachedFiles;
  ListBuilder<String> get attachedFiles =>
      _$this._attachedFiles ??= new ListBuilder<String>();
  set attachedFiles(ListBuilder<String>? attachedFiles) =>
      _$this._attachedFiles = attachedFiles;

  GCreateNewOfferInputBuilder();

  GCreateNewOfferInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _owner = $v.owner;
      _deadline = $v.deadline;
      _title = $v.title;
      _description = $v.description;
      _fee = $v.fee;
      _imageUrl = $v.imageUrl;
      _raidId = $v.raidId;
      _category = $v.category;
      _place = $v.place;
      _attention = $v.attention;
      _requiredSkill = $v.requiredSkill;
      _targetRole = $v.targetRole;
      _publicity = $v.publicity;
      _attachedImgs = $v.attachedImgs?.toBuilder();
      _attachedFiles = $v.attachedFiles?.toBuilder();
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
    _$GCreateNewOfferInput _$result;
    try {
      _$result = _$v ??
          new _$GCreateNewOfferInput._(
              owner: BuiltValueNullFieldError.checkNotNull(
                  owner, r'GCreateNewOfferInput', 'owner'),
              deadline: deadline,
              title: BuiltValueNullFieldError.checkNotNull(
                  title, r'GCreateNewOfferInput', 'title'),
              description: BuiltValueNullFieldError.checkNotNull(
                  description, r'GCreateNewOfferInput', 'description'),
              fee: BuiltValueNullFieldError.checkNotNull(
                  fee, r'GCreateNewOfferInput', 'fee'),
              imageUrl: imageUrl,
              raidId: raidId,
              category: category,
              place: BuiltValueNullFieldError.checkNotNull(
                  place, r'GCreateNewOfferInput', 'place'),
              attention: attention,
              requiredSkill: requiredSkill,
              targetRole: targetRole,
              publicity: publicity,
              attachedImgs: _attachedImgs?.build(),
              attachedFiles: _attachedFiles?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'attachedImgs';
        _attachedImgs?.build();
        _$failedField = 'attachedFiles';
        _attachedFiles?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GCreateNewOfferInput', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GCreateNewPrizeInput extends GCreateNewPrizeInput {
  @override
  final String name;
  @override
  final int point;
  @override
  final String description;
  @override
  final String representation;
  @override
  final String? condition;
  @override
  final String? imgUrl;
  @override
  final bool? publicity;

  factory _$GCreateNewPrizeInput(
          [void Function(GCreateNewPrizeInputBuilder)? updates]) =>
      (new GCreateNewPrizeInputBuilder()..update(updates))._build();

  _$GCreateNewPrizeInput._(
      {required this.name,
      required this.point,
      required this.description,
      required this.representation,
      this.condition,
      this.imgUrl,
      this.publicity})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        name, r'GCreateNewPrizeInput', 'name');
    BuiltValueNullFieldError.checkNotNull(
        point, r'GCreateNewPrizeInput', 'point');
    BuiltValueNullFieldError.checkNotNull(
        description, r'GCreateNewPrizeInput', 'description');
    BuiltValueNullFieldError.checkNotNull(
        representation, r'GCreateNewPrizeInput', 'representation');
  }

  @override
  GCreateNewPrizeInput rebuild(
          void Function(GCreateNewPrizeInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateNewPrizeInputBuilder toBuilder() =>
      new GCreateNewPrizeInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateNewPrizeInput &&
        name == other.name &&
        point == other.point &&
        description == other.description &&
        representation == other.representation &&
        condition == other.condition &&
        imgUrl == other.imgUrl &&
        publicity == other.publicity;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, point.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, representation.hashCode);
    _$hash = $jc(_$hash, condition.hashCode);
    _$hash = $jc(_$hash, imgUrl.hashCode);
    _$hash = $jc(_$hash, publicity.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateNewPrizeInput')
          ..add('name', name)
          ..add('point', point)
          ..add('description', description)
          ..add('representation', representation)
          ..add('condition', condition)
          ..add('imgUrl', imgUrl)
          ..add('publicity', publicity))
        .toString();
  }
}

class GCreateNewPrizeInputBuilder
    implements Builder<GCreateNewPrizeInput, GCreateNewPrizeInputBuilder> {
  _$GCreateNewPrizeInput? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _point;
  int? get point => _$this._point;
  set point(int? point) => _$this._point = point;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _representation;
  String? get representation => _$this._representation;
  set representation(String? representation) =>
      _$this._representation = representation;

  String? _condition;
  String? get condition => _$this._condition;
  set condition(String? condition) => _$this._condition = condition;

  String? _imgUrl;
  String? get imgUrl => _$this._imgUrl;
  set imgUrl(String? imgUrl) => _$this._imgUrl = imgUrl;

  bool? _publicity;
  bool? get publicity => _$this._publicity;
  set publicity(bool? publicity) => _$this._publicity = publicity;

  GCreateNewPrizeInputBuilder();

  GCreateNewPrizeInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _point = $v.point;
      _description = $v.description;
      _representation = $v.representation;
      _condition = $v.condition;
      _imgUrl = $v.imgUrl;
      _publicity = $v.publicity;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateNewPrizeInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateNewPrizeInput;
  }

  @override
  void update(void Function(GCreateNewPrizeInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateNewPrizeInput build() => _build();

  _$GCreateNewPrizeInput _build() {
    final _$result = _$v ??
        new _$GCreateNewPrizeInput._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'GCreateNewPrizeInput', 'name'),
            point: BuiltValueNullFieldError.checkNotNull(
                point, r'GCreateNewPrizeInput', 'point'),
            description: BuiltValueNullFieldError.checkNotNull(
                description, r'GCreateNewPrizeInput', 'description'),
            representation: BuiltValueNullFieldError.checkNotNull(
                representation, r'GCreateNewPrizeInput', 'representation'),
            condition: condition,
            imgUrl: imgUrl,
            publicity: publicity);
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
  final String id;
  @override
  final String? fcmToken;
  @override
  final String email;
  @override
  final String name;
  @override
  final String realname;
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
      {required this.id,
      this.fcmToken,
      required this.email,
      required this.name,
      required this.realname,
      this.imageUrl,
      this.invitedBy,
      required this.category,
      required this.primaryCategory})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'GCreateNewUserDataInput', 'id');
    BuiltValueNullFieldError.checkNotNull(
        email, r'GCreateNewUserDataInput', 'email');
    BuiltValueNullFieldError.checkNotNull(
        name, r'GCreateNewUserDataInput', 'name');
    BuiltValueNullFieldError.checkNotNull(
        realname, r'GCreateNewUserDataInput', 'realname');
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
        id == other.id &&
        fcmToken == other.fcmToken &&
        email == other.email &&
        name == other.name &&
        realname == other.realname &&
        imageUrl == other.imageUrl &&
        invitedBy == other.invitedBy &&
        category == other.category &&
        primaryCategory == other.primaryCategory;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, fcmToken.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, realname.hashCode);
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
          ..add('id', id)
          ..add('fcmToken', fcmToken)
          ..add('email', email)
          ..add('name', name)
          ..add('realname', realname)
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

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _fcmToken;
  String? get fcmToken => _$this._fcmToken;
  set fcmToken(String? fcmToken) => _$this._fcmToken = fcmToken;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _realname;
  String? get realname => _$this._realname;
  set realname(String? realname) => _$this._realname = realname;

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
      _id = $v.id;
      _fcmToken = $v.fcmToken;
      _email = $v.email;
      _name = $v.name;
      _realname = $v.realname;
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
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GCreateNewUserDataInput', 'id'),
            fcmToken: fcmToken,
            email: BuiltValueNullFieldError.checkNotNull(
                email, r'GCreateNewUserDataInput', 'email'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'GCreateNewUserDataInput', 'name'),
            realname: BuiltValueNullFieldError.checkNotNull(
                realname, r'GCreateNewUserDataInput', 'realname'),
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

class _$GCreateQuestInput extends GCreateQuestInput {
  @override
  final String name;
  @override
  final String description;

  factory _$GCreateQuestInput(
          [void Function(GCreateQuestInputBuilder)? updates]) =>
      (new GCreateQuestInputBuilder()..update(updates))._build();

  _$GCreateQuestInput._({required this.name, required this.description})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'GCreateQuestInput', 'name');
    BuiltValueNullFieldError.checkNotNull(
        description, r'GCreateQuestInput', 'description');
  }

  @override
  GCreateQuestInput rebuild(void Function(GCreateQuestInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateQuestInputBuilder toBuilder() =>
      new GCreateQuestInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateQuestInput &&
        name == other.name &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateQuestInput')
          ..add('name', name)
          ..add('description', description))
        .toString();
  }
}

class GCreateQuestInputBuilder
    implements Builder<GCreateQuestInput, GCreateQuestInputBuilder> {
  _$GCreateQuestInput? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  GCreateQuestInputBuilder();

  GCreateQuestInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateQuestInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateQuestInput;
  }

  @override
  void update(void Function(GCreateQuestInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateQuestInput build() => _build();

  _$GCreateQuestInput _build() {
    final _$result = _$v ??
        new _$GCreateQuestInput._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'GCreateQuestInput', 'name'),
            description: BuiltValueNullFieldError.checkNotNull(
                description, r'GCreateQuestInput', 'description'));
    replace(_$result);
    return _$result;
  }
}

class _$GDeleteCreditInput extends GDeleteCreditInput {
  @override
  final int creditId;

  factory _$GDeleteCreditInput(
          [void Function(GDeleteCreditInputBuilder)? updates]) =>
      (new GDeleteCreditInputBuilder()..update(updates))._build();

  _$GDeleteCreditInput._({required this.creditId}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        creditId, r'GDeleteCreditInput', 'creditId');
  }

  @override
  GDeleteCreditInput rebuild(
          void Function(GDeleteCreditInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GDeleteCreditInputBuilder toBuilder() =>
      new GDeleteCreditInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GDeleteCreditInput && creditId == other.creditId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, creditId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GDeleteCreditInput')
          ..add('creditId', creditId))
        .toString();
  }
}

class GDeleteCreditInputBuilder
    implements Builder<GDeleteCreditInput, GDeleteCreditInputBuilder> {
  _$GDeleteCreditInput? _$v;

  int? _creditId;
  int? get creditId => _$this._creditId;
  set creditId(int? creditId) => _$this._creditId = creditId;

  GDeleteCreditInputBuilder();

  GDeleteCreditInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _creditId = $v.creditId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GDeleteCreditInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GDeleteCreditInput;
  }

  @override
  void update(void Function(GDeleteCreditInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GDeleteCreditInput build() => _build();

  _$GDeleteCreditInput _build() {
    final _$result = _$v ??
        new _$GDeleteCreditInput._(
            creditId: BuiltValueNullFieldError.checkNotNull(
                creditId, r'GDeleteCreditInput', 'creditId'));
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

class _$GDeletePortfolioInput extends GDeletePortfolioInput {
  @override
  final int id;

  factory _$GDeletePortfolioInput(
          [void Function(GDeletePortfolioInputBuilder)? updates]) =>
      (new GDeletePortfolioInputBuilder()..update(updates))._build();

  _$GDeletePortfolioInput._({required this.id}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'GDeletePortfolioInput', 'id');
  }

  @override
  GDeletePortfolioInput rebuild(
          void Function(GDeletePortfolioInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GDeletePortfolioInputBuilder toBuilder() =>
      new GDeletePortfolioInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GDeletePortfolioInput && id == other.id;
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
    return (newBuiltValueToStringHelper(r'GDeletePortfolioInput')
          ..add('id', id))
        .toString();
  }
}

class GDeletePortfolioInputBuilder
    implements Builder<GDeletePortfolioInput, GDeletePortfolioInputBuilder> {
  _$GDeletePortfolioInput? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  GDeletePortfolioInputBuilder();

  GDeletePortfolioInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GDeletePortfolioInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GDeletePortfolioInput;
  }

  @override
  void update(void Function(GDeletePortfolioInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GDeletePortfolioInput build() => _build();

  _$GDeletePortfolioInput _build() {
    final _$result = _$v ??
        new _$GDeletePortfolioInput._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GDeletePortfolioInput', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$GExchangePrizeInput extends GExchangePrizeInput {
  @override
  final String userId;
  @override
  final int prizeId;
  @override
  final int? amount;

  factory _$GExchangePrizeInput(
          [void Function(GExchangePrizeInputBuilder)? updates]) =>
      (new GExchangePrizeInputBuilder()..update(updates))._build();

  _$GExchangePrizeInput._(
      {required this.userId, required this.prizeId, this.amount})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        userId, r'GExchangePrizeInput', 'userId');
    BuiltValueNullFieldError.checkNotNull(
        prizeId, r'GExchangePrizeInput', 'prizeId');
  }

  @override
  GExchangePrizeInput rebuild(
          void Function(GExchangePrizeInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GExchangePrizeInputBuilder toBuilder() =>
      new GExchangePrizeInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GExchangePrizeInput &&
        userId == other.userId &&
        prizeId == other.prizeId &&
        amount == other.amount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, prizeId.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GExchangePrizeInput')
          ..add('userId', userId)
          ..add('prizeId', prizeId)
          ..add('amount', amount))
        .toString();
  }
}

class GExchangePrizeInputBuilder
    implements Builder<GExchangePrizeInput, GExchangePrizeInputBuilder> {
  _$GExchangePrizeInput? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  int? _prizeId;
  int? get prizeId => _$this._prizeId;
  set prizeId(int? prizeId) => _$this._prizeId = prizeId;

  int? _amount;
  int? get amount => _$this._amount;
  set amount(int? amount) => _$this._amount = amount;

  GExchangePrizeInputBuilder();

  GExchangePrizeInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _prizeId = $v.prizeId;
      _amount = $v.amount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GExchangePrizeInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GExchangePrizeInput;
  }

  @override
  void update(void Function(GExchangePrizeInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GExchangePrizeInput build() => _build();

  _$GExchangePrizeInput _build() {
    final _$result = _$v ??
        new _$GExchangePrizeInput._(
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'GExchangePrizeInput', 'userId'),
            prizeId: BuiltValueNullFieldError.checkNotNull(
                prizeId, r'GExchangePrizeInput', 'prizeId'),
            amount: amount);
    replace(_$result);
    return _$result;
  }
}

class _$GJSONObject extends GJSONObject {
  @override
  final String value;

  factory _$GJSONObject([void Function(GJSONObjectBuilder)? updates]) =>
      (new GJSONObjectBuilder()..update(updates))._build();

  _$GJSONObject._({required this.value}) : super._() {
    BuiltValueNullFieldError.checkNotNull(value, r'GJSONObject', 'value');
  }

  @override
  GJSONObject rebuild(void Function(GJSONObjectBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GJSONObjectBuilder toBuilder() => new GJSONObjectBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GJSONObject && value == other.value;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GJSONObject')..add('value', value))
        .toString();
  }
}

class GJSONObjectBuilder implements Builder<GJSONObject, GJSONObjectBuilder> {
  _$GJSONObject? _$v;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  GJSONObjectBuilder();

  GJSONObjectBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GJSONObject other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GJSONObject;
  }

  @override
  void update(void Function(GJSONObjectBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GJSONObject build() => _build();

  _$GJSONObject _build() {
    final _$result = _$v ??
        new _$GJSONObject._(
            value: BuiltValueNullFieldError.checkNotNull(
                value, r'GJSONObject', 'value'));
    replace(_$result);
    return _$result;
  }
}

class _$GMarkAsAdminInput extends GMarkAsAdminInput {
  @override
  final String adminMember;
  @override
  final String userId;
  @override
  final String artistId;

  factory _$GMarkAsAdminInput(
          [void Function(GMarkAsAdminInputBuilder)? updates]) =>
      (new GMarkAsAdminInputBuilder()..update(updates))._build();

  _$GMarkAsAdminInput._(
      {required this.adminMember, required this.userId, required this.artistId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        adminMember, r'GMarkAsAdminInput', 'adminMember');
    BuiltValueNullFieldError.checkNotNull(
        userId, r'GMarkAsAdminInput', 'userId');
    BuiltValueNullFieldError.checkNotNull(
        artistId, r'GMarkAsAdminInput', 'artistId');
  }

  @override
  GMarkAsAdminInput rebuild(void Function(GMarkAsAdminInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMarkAsAdminInputBuilder toBuilder() =>
      new GMarkAsAdminInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMarkAsAdminInput &&
        adminMember == other.adminMember &&
        userId == other.userId &&
        artistId == other.artistId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, adminMember.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, artistId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMarkAsAdminInput')
          ..add('adminMember', adminMember)
          ..add('userId', userId)
          ..add('artistId', artistId))
        .toString();
  }
}

class GMarkAsAdminInputBuilder
    implements Builder<GMarkAsAdminInput, GMarkAsAdminInputBuilder> {
  _$GMarkAsAdminInput? _$v;

  String? _adminMember;
  String? get adminMember => _$this._adminMember;
  set adminMember(String? adminMember) => _$this._adminMember = adminMember;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _artistId;
  String? get artistId => _$this._artistId;
  set artistId(String? artistId) => _$this._artistId = artistId;

  GMarkAsAdminInputBuilder();

  GMarkAsAdminInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _adminMember = $v.adminMember;
      _userId = $v.userId;
      _artistId = $v.artistId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMarkAsAdminInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GMarkAsAdminInput;
  }

  @override
  void update(void Function(GMarkAsAdminInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMarkAsAdminInput build() => _build();

  _$GMarkAsAdminInput _build() {
    final _$result = _$v ??
        new _$GMarkAsAdminInput._(
            adminMember: BuiltValueNullFieldError.checkNotNull(
                adminMember, r'GMarkAsAdminInput', 'adminMember'),
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'GMarkAsAdminInput', 'userId'),
            artistId: BuiltValueNullFieldError.checkNotNull(
                artistId, r'GMarkAsAdminInput', 'artistId'));
    replace(_$result);
    return _$result;
  }
}

class _$GMarkAsMemberInput extends GMarkAsMemberInput {
  @override
  final String member;
  @override
  final String artistId;
  @override
  final BuiltList<GStatusUser> mapping;

  factory _$GMarkAsMemberInput(
          [void Function(GMarkAsMemberInputBuilder)? updates]) =>
      (new GMarkAsMemberInputBuilder()..update(updates))._build();

  _$GMarkAsMemberInput._(
      {required this.member, required this.artistId, required this.mapping})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        member, r'GMarkAsMemberInput', 'member');
    BuiltValueNullFieldError.checkNotNull(
        artistId, r'GMarkAsMemberInput', 'artistId');
    BuiltValueNullFieldError.checkNotNull(
        mapping, r'GMarkAsMemberInput', 'mapping');
  }

  @override
  GMarkAsMemberInput rebuild(
          void Function(GMarkAsMemberInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMarkAsMemberInputBuilder toBuilder() =>
      new GMarkAsMemberInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMarkAsMemberInput &&
        member == other.member &&
        artistId == other.artistId &&
        mapping == other.mapping;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, member.hashCode);
    _$hash = $jc(_$hash, artistId.hashCode);
    _$hash = $jc(_$hash, mapping.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMarkAsMemberInput')
          ..add('member', member)
          ..add('artistId', artistId)
          ..add('mapping', mapping))
        .toString();
  }
}

class GMarkAsMemberInputBuilder
    implements Builder<GMarkAsMemberInput, GMarkAsMemberInputBuilder> {
  _$GMarkAsMemberInput? _$v;

  String? _member;
  String? get member => _$this._member;
  set member(String? member) => _$this._member = member;

  String? _artistId;
  String? get artistId => _$this._artistId;
  set artistId(String? artistId) => _$this._artistId = artistId;

  ListBuilder<GStatusUser>? _mapping;
  ListBuilder<GStatusUser> get mapping =>
      _$this._mapping ??= new ListBuilder<GStatusUser>();
  set mapping(ListBuilder<GStatusUser>? mapping) => _$this._mapping = mapping;

  GMarkAsMemberInputBuilder();

  GMarkAsMemberInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _member = $v.member;
      _artistId = $v.artistId;
      _mapping = $v.mapping.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMarkAsMemberInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GMarkAsMemberInput;
  }

  @override
  void update(void Function(GMarkAsMemberInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMarkAsMemberInput build() => _build();

  _$GMarkAsMemberInput _build() {
    _$GMarkAsMemberInput _$result;
    try {
      _$result = _$v ??
          new _$GMarkAsMemberInput._(
              member: BuiltValueNullFieldError.checkNotNull(
                  member, r'GMarkAsMemberInput', 'member'),
              artistId: BuiltValueNullFieldError.checkNotNull(
                  artistId, r'GMarkAsMemberInput', 'artistId'),
              mapping: mapping.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'mapping';
        mapping.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GMarkAsMemberInput', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMarkAsReadInput extends GMarkAsReadInput {
  @override
  final String roomId;
  @override
  final String userId;
  @override
  final String messageId;

  factory _$GMarkAsReadInput(
          [void Function(GMarkAsReadInputBuilder)? updates]) =>
      (new GMarkAsReadInputBuilder()..update(updates))._build();

  _$GMarkAsReadInput._(
      {required this.roomId, required this.userId, required this.messageId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        roomId, r'GMarkAsReadInput', 'roomId');
    BuiltValueNullFieldError.checkNotNull(
        userId, r'GMarkAsReadInput', 'userId');
    BuiltValueNullFieldError.checkNotNull(
        messageId, r'GMarkAsReadInput', 'messageId');
  }

  @override
  GMarkAsReadInput rebuild(void Function(GMarkAsReadInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMarkAsReadInputBuilder toBuilder() =>
      new GMarkAsReadInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMarkAsReadInput &&
        roomId == other.roomId &&
        userId == other.userId &&
        messageId == other.messageId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, roomId.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, messageId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMarkAsReadInput')
          ..add('roomId', roomId)
          ..add('userId', userId)
          ..add('messageId', messageId))
        .toString();
  }
}

class GMarkAsReadInputBuilder
    implements Builder<GMarkAsReadInput, GMarkAsReadInputBuilder> {
  _$GMarkAsReadInput? _$v;

  String? _roomId;
  String? get roomId => _$this._roomId;
  set roomId(String? roomId) => _$this._roomId = roomId;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _messageId;
  String? get messageId => _$this._messageId;
  set messageId(String? messageId) => _$this._messageId = messageId;

  GMarkAsReadInputBuilder();

  GMarkAsReadInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _roomId = $v.roomId;
      _userId = $v.userId;
      _messageId = $v.messageId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMarkAsReadInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GMarkAsReadInput;
  }

  @override
  void update(void Function(GMarkAsReadInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMarkAsReadInput build() => _build();

  _$GMarkAsReadInput _build() {
    final _$result = _$v ??
        new _$GMarkAsReadInput._(
            roomId: BuiltValueNullFieldError.checkNotNull(
                roomId, r'GMarkAsReadInput', 'roomId'),
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'GMarkAsReadInput', 'userId'),
            messageId: BuiltValueNullFieldError.checkNotNull(
                messageId, r'GMarkAsReadInput', 'messageId'));
    replace(_$result);
    return _$result;
  }
}

class _$GRegisterCreditInput extends GRegisterCreditInput {
  @override
  final BuiltList<GRegisterInfo> registerInfo;

  factory _$GRegisterCreditInput(
          [void Function(GRegisterCreditInputBuilder)? updates]) =>
      (new GRegisterCreditInputBuilder()..update(updates))._build();

  _$GRegisterCreditInput._({required this.registerInfo}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        registerInfo, r'GRegisterCreditInput', 'registerInfo');
  }

  @override
  GRegisterCreditInput rebuild(
          void Function(GRegisterCreditInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRegisterCreditInputBuilder toBuilder() =>
      new GRegisterCreditInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRegisterCreditInput && registerInfo == other.registerInfo;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, registerInfo.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GRegisterCreditInput')
          ..add('registerInfo', registerInfo))
        .toString();
  }
}

class GRegisterCreditInputBuilder
    implements Builder<GRegisterCreditInput, GRegisterCreditInputBuilder> {
  _$GRegisterCreditInput? _$v;

  ListBuilder<GRegisterInfo>? _registerInfo;
  ListBuilder<GRegisterInfo> get registerInfo =>
      _$this._registerInfo ??= new ListBuilder<GRegisterInfo>();
  set registerInfo(ListBuilder<GRegisterInfo>? registerInfo) =>
      _$this._registerInfo = registerInfo;

  GRegisterCreditInputBuilder();

  GRegisterCreditInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _registerInfo = $v.registerInfo.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRegisterCreditInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GRegisterCreditInput;
  }

  @override
  void update(void Function(GRegisterCreditInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRegisterCreditInput build() => _build();

  _$GRegisterCreditInput _build() {
    _$GRegisterCreditInput _$result;
    try {
      _$result = _$v ??
          new _$GRegisterCreditInput._(registerInfo: registerInfo.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'registerInfo';
        registerInfo.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GRegisterCreditInput', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GRegisterInfo extends GRegisterInfo {
  @override
  final String isrc;
  @override
  final String commitUser;
  @override
  final String creditRole;
  @override
  final String creditName;
  @override
  final String email;
  @override
  final bool isInvite;
  @override
  final String? memo;

  factory _$GRegisterInfo([void Function(GRegisterInfoBuilder)? updates]) =>
      (new GRegisterInfoBuilder()..update(updates))._build();

  _$GRegisterInfo._(
      {required this.isrc,
      required this.commitUser,
      required this.creditRole,
      required this.creditName,
      required this.email,
      required this.isInvite,
      this.memo})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(isrc, r'GRegisterInfo', 'isrc');
    BuiltValueNullFieldError.checkNotNull(
        commitUser, r'GRegisterInfo', 'commitUser');
    BuiltValueNullFieldError.checkNotNull(
        creditRole, r'GRegisterInfo', 'creditRole');
    BuiltValueNullFieldError.checkNotNull(
        creditName, r'GRegisterInfo', 'creditName');
    BuiltValueNullFieldError.checkNotNull(email, r'GRegisterInfo', 'email');
    BuiltValueNullFieldError.checkNotNull(
        isInvite, r'GRegisterInfo', 'isInvite');
  }

  @override
  GRegisterInfo rebuild(void Function(GRegisterInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRegisterInfoBuilder toBuilder() => new GRegisterInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRegisterInfo &&
        isrc == other.isrc &&
        commitUser == other.commitUser &&
        creditRole == other.creditRole &&
        creditName == other.creditName &&
        email == other.email &&
        isInvite == other.isInvite &&
        memo == other.memo;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, isrc.hashCode);
    _$hash = $jc(_$hash, commitUser.hashCode);
    _$hash = $jc(_$hash, creditRole.hashCode);
    _$hash = $jc(_$hash, creditName.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, isInvite.hashCode);
    _$hash = $jc(_$hash, memo.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GRegisterInfo')
          ..add('isrc', isrc)
          ..add('commitUser', commitUser)
          ..add('creditRole', creditRole)
          ..add('creditName', creditName)
          ..add('email', email)
          ..add('isInvite', isInvite)
          ..add('memo', memo))
        .toString();
  }
}

class GRegisterInfoBuilder
    implements Builder<GRegisterInfo, GRegisterInfoBuilder> {
  _$GRegisterInfo? _$v;

  String? _isrc;
  String? get isrc => _$this._isrc;
  set isrc(String? isrc) => _$this._isrc = isrc;

  String? _commitUser;
  String? get commitUser => _$this._commitUser;
  set commitUser(String? commitUser) => _$this._commitUser = commitUser;

  String? _creditRole;
  String? get creditRole => _$this._creditRole;
  set creditRole(String? creditRole) => _$this._creditRole = creditRole;

  String? _creditName;
  String? get creditName => _$this._creditName;
  set creditName(String? creditName) => _$this._creditName = creditName;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  bool? _isInvite;
  bool? get isInvite => _$this._isInvite;
  set isInvite(bool? isInvite) => _$this._isInvite = isInvite;

  String? _memo;
  String? get memo => _$this._memo;
  set memo(String? memo) => _$this._memo = memo;

  GRegisterInfoBuilder();

  GRegisterInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isrc = $v.isrc;
      _commitUser = $v.commitUser;
      _creditRole = $v.creditRole;
      _creditName = $v.creditName;
      _email = $v.email;
      _isInvite = $v.isInvite;
      _memo = $v.memo;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRegisterInfo other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GRegisterInfo;
  }

  @override
  void update(void Function(GRegisterInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRegisterInfo build() => _build();

  _$GRegisterInfo _build() {
    final _$result = _$v ??
        new _$GRegisterInfo._(
            isrc: BuiltValueNullFieldError.checkNotNull(
                isrc, r'GRegisterInfo', 'isrc'),
            commitUser: BuiltValueNullFieldError.checkNotNull(
                commitUser, r'GRegisterInfo', 'commitUser'),
            creditRole: BuiltValueNullFieldError.checkNotNull(
                creditRole, r'GRegisterInfo', 'creditRole'),
            creditName: BuiltValueNullFieldError.checkNotNull(
                creditName, r'GRegisterInfo', 'creditName'),
            email: BuiltValueNullFieldError.checkNotNull(
                email, r'GRegisterInfo', 'email'),
            isInvite: BuiltValueNullFieldError.checkNotNull(
                isInvite, r'GRegisterInfo', 'isInvite'),
            memo: memo);
    replace(_$result);
    return _$result;
  }
}

class _$GRegisterPortfolioInput extends GRegisterPortfolioInput {
  @override
  final String userId;
  @override
  final String title;
  @override
  final String description;
  @override
  final String imgUrl;
  @override
  final String category;
  @override
  final String releaseDate;
  @override
  final String externalUrl;

  factory _$GRegisterPortfolioInput(
          [void Function(GRegisterPortfolioInputBuilder)? updates]) =>
      (new GRegisterPortfolioInputBuilder()..update(updates))._build();

  _$GRegisterPortfolioInput._(
      {required this.userId,
      required this.title,
      required this.description,
      required this.imgUrl,
      required this.category,
      required this.releaseDate,
      required this.externalUrl})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        userId, r'GRegisterPortfolioInput', 'userId');
    BuiltValueNullFieldError.checkNotNull(
        title, r'GRegisterPortfolioInput', 'title');
    BuiltValueNullFieldError.checkNotNull(
        description, r'GRegisterPortfolioInput', 'description');
    BuiltValueNullFieldError.checkNotNull(
        imgUrl, r'GRegisterPortfolioInput', 'imgUrl');
    BuiltValueNullFieldError.checkNotNull(
        category, r'GRegisterPortfolioInput', 'category');
    BuiltValueNullFieldError.checkNotNull(
        releaseDate, r'GRegisterPortfolioInput', 'releaseDate');
    BuiltValueNullFieldError.checkNotNull(
        externalUrl, r'GRegisterPortfolioInput', 'externalUrl');
  }

  @override
  GRegisterPortfolioInput rebuild(
          void Function(GRegisterPortfolioInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRegisterPortfolioInputBuilder toBuilder() =>
      new GRegisterPortfolioInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRegisterPortfolioInput &&
        userId == other.userId &&
        title == other.title &&
        description == other.description &&
        imgUrl == other.imgUrl &&
        category == other.category &&
        releaseDate == other.releaseDate &&
        externalUrl == other.externalUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, imgUrl.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, releaseDate.hashCode);
    _$hash = $jc(_$hash, externalUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GRegisterPortfolioInput')
          ..add('userId', userId)
          ..add('title', title)
          ..add('description', description)
          ..add('imgUrl', imgUrl)
          ..add('category', category)
          ..add('releaseDate', releaseDate)
          ..add('externalUrl', externalUrl))
        .toString();
  }
}

class GRegisterPortfolioInputBuilder
    implements
        Builder<GRegisterPortfolioInput, GRegisterPortfolioInputBuilder> {
  _$GRegisterPortfolioInput? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _imgUrl;
  String? get imgUrl => _$this._imgUrl;
  set imgUrl(String? imgUrl) => _$this._imgUrl = imgUrl;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  String? _releaseDate;
  String? get releaseDate => _$this._releaseDate;
  set releaseDate(String? releaseDate) => _$this._releaseDate = releaseDate;

  String? _externalUrl;
  String? get externalUrl => _$this._externalUrl;
  set externalUrl(String? externalUrl) => _$this._externalUrl = externalUrl;

  GRegisterPortfolioInputBuilder();

  GRegisterPortfolioInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _title = $v.title;
      _description = $v.description;
      _imgUrl = $v.imgUrl;
      _category = $v.category;
      _releaseDate = $v.releaseDate;
      _externalUrl = $v.externalUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRegisterPortfolioInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GRegisterPortfolioInput;
  }

  @override
  void update(void Function(GRegisterPortfolioInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRegisterPortfolioInput build() => _build();

  _$GRegisterPortfolioInput _build() {
    final _$result = _$v ??
        new _$GRegisterPortfolioInput._(
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'GRegisterPortfolioInput', 'userId'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'GRegisterPortfolioInput', 'title'),
            description: BuiltValueNullFieldError.checkNotNull(
                description, r'GRegisterPortfolioInput', 'description'),
            imgUrl: BuiltValueNullFieldError.checkNotNull(
                imgUrl, r'GRegisterPortfolioInput', 'imgUrl'),
            category: BuiltValueNullFieldError.checkNotNull(
                category, r'GRegisterPortfolioInput', 'category'),
            releaseDate: BuiltValueNullFieldError.checkNotNull(
                releaseDate, r'GRegisterPortfolioInput', 'releaseDate'),
            externalUrl: BuiltValueNullFieldError.checkNotNull(
                externalUrl, r'GRegisterPortfolioInput', 'externalUrl'));
    replace(_$result);
    return _$result;
  }
}

class _$GRegisterReleases extends GRegisterReleases {
  @override
  final BuiltList<GReleaseData> releases;

  factory _$GRegisterReleases(
          [void Function(GRegisterReleasesBuilder)? updates]) =>
      (new GRegisterReleasesBuilder()..update(updates))._build();

  _$GRegisterReleases._({required this.releases}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        releases, r'GRegisterReleases', 'releases');
  }

  @override
  GRegisterReleases rebuild(void Function(GRegisterReleasesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRegisterReleasesBuilder toBuilder() =>
      new GRegisterReleasesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRegisterReleases && releases == other.releases;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, releases.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GRegisterReleases')
          ..add('releases', releases))
        .toString();
  }
}

class GRegisterReleasesBuilder
    implements Builder<GRegisterReleases, GRegisterReleasesBuilder> {
  _$GRegisterReleases? _$v;

  ListBuilder<GReleaseData>? _releases;
  ListBuilder<GReleaseData> get releases =>
      _$this._releases ??= new ListBuilder<GReleaseData>();
  set releases(ListBuilder<GReleaseData>? releases) =>
      _$this._releases = releases;

  GRegisterReleasesBuilder();

  GRegisterReleasesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _releases = $v.releases.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRegisterReleases other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GRegisterReleases;
  }

  @override
  void update(void Function(GRegisterReleasesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRegisterReleases build() => _build();

  _$GRegisterReleases _build() {
    _$GRegisterReleases _$result;
    try {
      _$result = _$v ?? new _$GRegisterReleases._(releases: releases.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'releases';
        releases.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GRegisterReleases', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GReleaseData extends GReleaseData {
  @override
  final String upc;
  @override
  final String format;
  @override
  final int trackCount;
  @override
  final String title;
  @override
  final String releaseDate;
  @override
  final String isrc;
  @override
  final int trackNo;
  @override
  final String trackTitle;
  @override
  final String trackTitleVersion;
  @override
  final String artistId;
  @override
  final String? imageUrl;

  factory _$GReleaseData([void Function(GReleaseDataBuilder)? updates]) =>
      (new GReleaseDataBuilder()..update(updates))._build();

  _$GReleaseData._(
      {required this.upc,
      required this.format,
      required this.trackCount,
      required this.title,
      required this.releaseDate,
      required this.isrc,
      required this.trackNo,
      required this.trackTitle,
      required this.trackTitleVersion,
      required this.artistId,
      this.imageUrl})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(upc, r'GReleaseData', 'upc');
    BuiltValueNullFieldError.checkNotNull(format, r'GReleaseData', 'format');
    BuiltValueNullFieldError.checkNotNull(
        trackCount, r'GReleaseData', 'trackCount');
    BuiltValueNullFieldError.checkNotNull(title, r'GReleaseData', 'title');
    BuiltValueNullFieldError.checkNotNull(
        releaseDate, r'GReleaseData', 'releaseDate');
    BuiltValueNullFieldError.checkNotNull(isrc, r'GReleaseData', 'isrc');
    BuiltValueNullFieldError.checkNotNull(trackNo, r'GReleaseData', 'trackNo');
    BuiltValueNullFieldError.checkNotNull(
        trackTitle, r'GReleaseData', 'trackTitle');
    BuiltValueNullFieldError.checkNotNull(
        trackTitleVersion, r'GReleaseData', 'trackTitleVersion');
    BuiltValueNullFieldError.checkNotNull(
        artistId, r'GReleaseData', 'artistId');
  }

  @override
  GReleaseData rebuild(void Function(GReleaseDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GReleaseDataBuilder toBuilder() => new GReleaseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GReleaseData &&
        upc == other.upc &&
        format == other.format &&
        trackCount == other.trackCount &&
        title == other.title &&
        releaseDate == other.releaseDate &&
        isrc == other.isrc &&
        trackNo == other.trackNo &&
        trackTitle == other.trackTitle &&
        trackTitleVersion == other.trackTitleVersion &&
        artistId == other.artistId &&
        imageUrl == other.imageUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, upc.hashCode);
    _$hash = $jc(_$hash, format.hashCode);
    _$hash = $jc(_$hash, trackCount.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, releaseDate.hashCode);
    _$hash = $jc(_$hash, isrc.hashCode);
    _$hash = $jc(_$hash, trackNo.hashCode);
    _$hash = $jc(_$hash, trackTitle.hashCode);
    _$hash = $jc(_$hash, trackTitleVersion.hashCode);
    _$hash = $jc(_$hash, artistId.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GReleaseData')
          ..add('upc', upc)
          ..add('format', format)
          ..add('trackCount', trackCount)
          ..add('title', title)
          ..add('releaseDate', releaseDate)
          ..add('isrc', isrc)
          ..add('trackNo', trackNo)
          ..add('trackTitle', trackTitle)
          ..add('trackTitleVersion', trackTitleVersion)
          ..add('artistId', artistId)
          ..add('imageUrl', imageUrl))
        .toString();
  }
}

class GReleaseDataBuilder
    implements Builder<GReleaseData, GReleaseDataBuilder> {
  _$GReleaseData? _$v;

  String? _upc;
  String? get upc => _$this._upc;
  set upc(String? upc) => _$this._upc = upc;

  String? _format;
  String? get format => _$this._format;
  set format(String? format) => _$this._format = format;

  int? _trackCount;
  int? get trackCount => _$this._trackCount;
  set trackCount(int? trackCount) => _$this._trackCount = trackCount;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _releaseDate;
  String? get releaseDate => _$this._releaseDate;
  set releaseDate(String? releaseDate) => _$this._releaseDate = releaseDate;

  String? _isrc;
  String? get isrc => _$this._isrc;
  set isrc(String? isrc) => _$this._isrc = isrc;

  int? _trackNo;
  int? get trackNo => _$this._trackNo;
  set trackNo(int? trackNo) => _$this._trackNo = trackNo;

  String? _trackTitle;
  String? get trackTitle => _$this._trackTitle;
  set trackTitle(String? trackTitle) => _$this._trackTitle = trackTitle;

  String? _trackTitleVersion;
  String? get trackTitleVersion => _$this._trackTitleVersion;
  set trackTitleVersion(String? trackTitleVersion) =>
      _$this._trackTitleVersion = trackTitleVersion;

  String? _artistId;
  String? get artistId => _$this._artistId;
  set artistId(String? artistId) => _$this._artistId = artistId;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  GReleaseDataBuilder();

  GReleaseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _upc = $v.upc;
      _format = $v.format;
      _trackCount = $v.trackCount;
      _title = $v.title;
      _releaseDate = $v.releaseDate;
      _isrc = $v.isrc;
      _trackNo = $v.trackNo;
      _trackTitle = $v.trackTitle;
      _trackTitleVersion = $v.trackTitleVersion;
      _artistId = $v.artistId;
      _imageUrl = $v.imageUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GReleaseData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GReleaseData;
  }

  @override
  void update(void Function(GReleaseDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GReleaseData build() => _build();

  _$GReleaseData _build() {
    final _$result = _$v ??
        new _$GReleaseData._(
            upc: BuiltValueNullFieldError.checkNotNull(
                upc, r'GReleaseData', 'upc'),
            format: BuiltValueNullFieldError.checkNotNull(
                format, r'GReleaseData', 'format'),
            trackCount: BuiltValueNullFieldError.checkNotNull(
                trackCount, r'GReleaseData', 'trackCount'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'GReleaseData', 'title'),
            releaseDate: BuiltValueNullFieldError.checkNotNull(
                releaseDate, r'GReleaseData', 'releaseDate'),
            isrc: BuiltValueNullFieldError.checkNotNull(
                isrc, r'GReleaseData', 'isrc'),
            trackNo: BuiltValueNullFieldError.checkNotNull(
                trackNo, r'GReleaseData', 'trackNo'),
            trackTitle: BuiltValueNullFieldError.checkNotNull(
                trackTitle, r'GReleaseData', 'trackTitle'),
            trackTitleVersion: BuiltValueNullFieldError.checkNotNull(
                trackTitleVersion, r'GReleaseData', 'trackTitleVersion'),
            artistId: BuiltValueNullFieldError.checkNotNull(
                artistId, r'GReleaseData', 'artistId'),
            imageUrl: imageUrl);
    replace(_$result);
    return _$result;
  }
}

class _$GReportOfferInput extends GReportOfferInput {
  @override
  final int offerId;
  @override
  final String reporterUserId;
  @override
  final String reportContent;

  factory _$GReportOfferInput(
          [void Function(GReportOfferInputBuilder)? updates]) =>
      (new GReportOfferInputBuilder()..update(updates))._build();

  _$GReportOfferInput._(
      {required this.offerId,
      required this.reporterUserId,
      required this.reportContent})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        offerId, r'GReportOfferInput', 'offerId');
    BuiltValueNullFieldError.checkNotNull(
        reporterUserId, r'GReportOfferInput', 'reporterUserId');
    BuiltValueNullFieldError.checkNotNull(
        reportContent, r'GReportOfferInput', 'reportContent');
  }

  @override
  GReportOfferInput rebuild(void Function(GReportOfferInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GReportOfferInputBuilder toBuilder() =>
      new GReportOfferInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GReportOfferInput &&
        offerId == other.offerId &&
        reporterUserId == other.reporterUserId &&
        reportContent == other.reportContent;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, offerId.hashCode);
    _$hash = $jc(_$hash, reporterUserId.hashCode);
    _$hash = $jc(_$hash, reportContent.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GReportOfferInput')
          ..add('offerId', offerId)
          ..add('reporterUserId', reporterUserId)
          ..add('reportContent', reportContent))
        .toString();
  }
}

class GReportOfferInputBuilder
    implements Builder<GReportOfferInput, GReportOfferInputBuilder> {
  _$GReportOfferInput? _$v;

  int? _offerId;
  int? get offerId => _$this._offerId;
  set offerId(int? offerId) => _$this._offerId = offerId;

  String? _reporterUserId;
  String? get reporterUserId => _$this._reporterUserId;
  set reporterUserId(String? reporterUserId) =>
      _$this._reporterUserId = reporterUserId;

  String? _reportContent;
  String? get reportContent => _$this._reportContent;
  set reportContent(String? reportContent) =>
      _$this._reportContent = reportContent;

  GReportOfferInputBuilder();

  GReportOfferInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _offerId = $v.offerId;
      _reporterUserId = $v.reporterUserId;
      _reportContent = $v.reportContent;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GReportOfferInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GReportOfferInput;
  }

  @override
  void update(void Function(GReportOfferInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GReportOfferInput build() => _build();

  _$GReportOfferInput _build() {
    final _$result = _$v ??
        new _$GReportOfferInput._(
            offerId: BuiltValueNullFieldError.checkNotNull(
                offerId, r'GReportOfferInput', 'offerId'),
            reporterUserId: BuiltValueNullFieldError.checkNotNull(
                reporterUserId, r'GReportOfferInput', 'reporterUserId'),
            reportContent: BuiltValueNullFieldError.checkNotNull(
                reportContent, r'GReportOfferInput', 'reportContent'));
    replace(_$result);
    return _$result;
  }
}

class _$GReportUserInput extends GReportUserInput {
  @override
  final String reportedUserId;
  @override
  final String reporterUserId;
  @override
  final String reportContent;

  factory _$GReportUserInput(
          [void Function(GReportUserInputBuilder)? updates]) =>
      (new GReportUserInputBuilder()..update(updates))._build();

  _$GReportUserInput._(
      {required this.reportedUserId,
      required this.reporterUserId,
      required this.reportContent})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        reportedUserId, r'GReportUserInput', 'reportedUserId');
    BuiltValueNullFieldError.checkNotNull(
        reporterUserId, r'GReportUserInput', 'reporterUserId');
    BuiltValueNullFieldError.checkNotNull(
        reportContent, r'GReportUserInput', 'reportContent');
  }

  @override
  GReportUserInput rebuild(void Function(GReportUserInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GReportUserInputBuilder toBuilder() =>
      new GReportUserInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GReportUserInput &&
        reportedUserId == other.reportedUserId &&
        reporterUserId == other.reporterUserId &&
        reportContent == other.reportContent;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, reportedUserId.hashCode);
    _$hash = $jc(_$hash, reporterUserId.hashCode);
    _$hash = $jc(_$hash, reportContent.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GReportUserInput')
          ..add('reportedUserId', reportedUserId)
          ..add('reporterUserId', reporterUserId)
          ..add('reportContent', reportContent))
        .toString();
  }
}

class GReportUserInputBuilder
    implements Builder<GReportUserInput, GReportUserInputBuilder> {
  _$GReportUserInput? _$v;

  String? _reportedUserId;
  String? get reportedUserId => _$this._reportedUserId;
  set reportedUserId(String? reportedUserId) =>
      _$this._reportedUserId = reportedUserId;

  String? _reporterUserId;
  String? get reporterUserId => _$this._reporterUserId;
  set reporterUserId(String? reporterUserId) =>
      _$this._reporterUserId = reporterUserId;

  String? _reportContent;
  String? get reportContent => _$this._reportContent;
  set reportContent(String? reportContent) =>
      _$this._reportContent = reportContent;

  GReportUserInputBuilder();

  GReportUserInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reportedUserId = $v.reportedUserId;
      _reporterUserId = $v.reporterUserId;
      _reportContent = $v.reportContent;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GReportUserInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GReportUserInput;
  }

  @override
  void update(void Function(GReportUserInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GReportUserInput build() => _build();

  _$GReportUserInput _build() {
    final _$result = _$v ??
        new _$GReportUserInput._(
            reportedUserId: BuiltValueNullFieldError.checkNotNull(
                reportedUserId, r'GReportUserInput', 'reportedUserId'),
            reporterUserId: BuiltValueNullFieldError.checkNotNull(
                reporterUserId, r'GReportUserInput', 'reporterUserId'),
            reportContent: BuiltValueNullFieldError.checkNotNull(
                reportContent, r'GReportUserInput', 'reportContent'));
    replace(_$result);
    return _$result;
  }
}

class _$GRequestPrizeInput extends GRequestPrizeInput {
  @override
  final String userId;
  @override
  final int prizeId;

  factory _$GRequestPrizeInput(
          [void Function(GRequestPrizeInputBuilder)? updates]) =>
      (new GRequestPrizeInputBuilder()..update(updates))._build();

  _$GRequestPrizeInput._({required this.userId, required this.prizeId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        userId, r'GRequestPrizeInput', 'userId');
    BuiltValueNullFieldError.checkNotNull(
        prizeId, r'GRequestPrizeInput', 'prizeId');
  }

  @override
  GRequestPrizeInput rebuild(
          void Function(GRequestPrizeInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRequestPrizeInputBuilder toBuilder() =>
      new GRequestPrizeInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRequestPrizeInput &&
        userId == other.userId &&
        prizeId == other.prizeId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, prizeId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GRequestPrizeInput')
          ..add('userId', userId)
          ..add('prizeId', prizeId))
        .toString();
  }
}

class GRequestPrizeInputBuilder
    implements Builder<GRequestPrizeInput, GRequestPrizeInputBuilder> {
  _$GRequestPrizeInput? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  int? _prizeId;
  int? get prizeId => _$this._prizeId;
  set prizeId(int? prizeId) => _$this._prizeId = prizeId;

  GRequestPrizeInputBuilder();

  GRequestPrizeInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _prizeId = $v.prizeId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRequestPrizeInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GRequestPrizeInput;
  }

  @override
  void update(void Function(GRequestPrizeInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRequestPrizeInput build() => _build();

  _$GRequestPrizeInput _build() {
    final _$result = _$v ??
        new _$GRequestPrizeInput._(
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'GRequestPrizeInput', 'userId'),
            prizeId: BuiltValueNullFieldError.checkNotNull(
                prizeId, r'GRequestPrizeInput', 'prizeId'));
    replace(_$result);
    return _$result;
  }
}

class _$GRequestToAccessArtistInput extends GRequestToAccessArtistInput {
  @override
  final String userId;
  @override
  final BuiltList<String> artistIds;

  factory _$GRequestToAccessArtistInput(
          [void Function(GRequestToAccessArtistInputBuilder)? updates]) =>
      (new GRequestToAccessArtistInputBuilder()..update(updates))._build();

  _$GRequestToAccessArtistInput._(
      {required this.userId, required this.artistIds})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        userId, r'GRequestToAccessArtistInput', 'userId');
    BuiltValueNullFieldError.checkNotNull(
        artistIds, r'GRequestToAccessArtistInput', 'artistIds');
  }

  @override
  GRequestToAccessArtistInput rebuild(
          void Function(GRequestToAccessArtistInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRequestToAccessArtistInputBuilder toBuilder() =>
      new GRequestToAccessArtistInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRequestToAccessArtistInput &&
        userId == other.userId &&
        artistIds == other.artistIds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, artistIds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GRequestToAccessArtistInput')
          ..add('userId', userId)
          ..add('artistIds', artistIds))
        .toString();
  }
}

class GRequestToAccessArtistInputBuilder
    implements
        Builder<GRequestToAccessArtistInput,
            GRequestToAccessArtistInputBuilder> {
  _$GRequestToAccessArtistInput? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  ListBuilder<String>? _artistIds;
  ListBuilder<String> get artistIds =>
      _$this._artistIds ??= new ListBuilder<String>();
  set artistIds(ListBuilder<String>? artistIds) =>
      _$this._artistIds = artistIds;

  GRequestToAccessArtistInputBuilder();

  GRequestToAccessArtistInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _artistIds = $v.artistIds.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRequestToAccessArtistInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GRequestToAccessArtistInput;
  }

  @override
  void update(void Function(GRequestToAccessArtistInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRequestToAccessArtistInput build() => _build();

  _$GRequestToAccessArtistInput _build() {
    _$GRequestToAccessArtistInput _$result;
    try {
      _$result = _$v ??
          new _$GRequestToAccessArtistInput._(
              userId: BuiltValueNullFieldError.checkNotNull(
                  userId, r'GRequestToAccessArtistInput', 'userId'),
              artistIds: artistIds.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'artistIds';
        artistIds.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GRequestToAccessArtistInput', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GSearchOptionsOffersInput extends GSearchOptionsOffersInput {
  @override
  final String? owner;
  @override
  final String? category;
  @override
  final String? targetRole;
  @override
  final String? place;
  @override
  final int? minPrice;
  @override
  final int? maxPrice;
  @override
  final String? sortBy;

  factory _$GSearchOptionsOffersInput(
          [void Function(GSearchOptionsOffersInputBuilder)? updates]) =>
      (new GSearchOptionsOffersInputBuilder()..update(updates))._build();

  _$GSearchOptionsOffersInput._(
      {this.owner,
      this.category,
      this.targetRole,
      this.place,
      this.minPrice,
      this.maxPrice,
      this.sortBy})
      : super._();

  @override
  GSearchOptionsOffersInput rebuild(
          void Function(GSearchOptionsOffersInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSearchOptionsOffersInputBuilder toBuilder() =>
      new GSearchOptionsOffersInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchOptionsOffersInput &&
        owner == other.owner &&
        category == other.category &&
        targetRole == other.targetRole &&
        place == other.place &&
        minPrice == other.minPrice &&
        maxPrice == other.maxPrice &&
        sortBy == other.sortBy;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, owner.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, targetRole.hashCode);
    _$hash = $jc(_$hash, place.hashCode);
    _$hash = $jc(_$hash, minPrice.hashCode);
    _$hash = $jc(_$hash, maxPrice.hashCode);
    _$hash = $jc(_$hash, sortBy.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSearchOptionsOffersInput')
          ..add('owner', owner)
          ..add('category', category)
          ..add('targetRole', targetRole)
          ..add('place', place)
          ..add('minPrice', minPrice)
          ..add('maxPrice', maxPrice)
          ..add('sortBy', sortBy))
        .toString();
  }
}

class GSearchOptionsOffersInputBuilder
    implements
        Builder<GSearchOptionsOffersInput, GSearchOptionsOffersInputBuilder> {
  _$GSearchOptionsOffersInput? _$v;

  String? _owner;
  String? get owner => _$this._owner;
  set owner(String? owner) => _$this._owner = owner;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  String? _targetRole;
  String? get targetRole => _$this._targetRole;
  set targetRole(String? targetRole) => _$this._targetRole = targetRole;

  String? _place;
  String? get place => _$this._place;
  set place(String? place) => _$this._place = place;

  int? _minPrice;
  int? get minPrice => _$this._minPrice;
  set minPrice(int? minPrice) => _$this._minPrice = minPrice;

  int? _maxPrice;
  int? get maxPrice => _$this._maxPrice;
  set maxPrice(int? maxPrice) => _$this._maxPrice = maxPrice;

  String? _sortBy;
  String? get sortBy => _$this._sortBy;
  set sortBy(String? sortBy) => _$this._sortBy = sortBy;

  GSearchOptionsOffersInputBuilder();

  GSearchOptionsOffersInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _owner = $v.owner;
      _category = $v.category;
      _targetRole = $v.targetRole;
      _place = $v.place;
      _minPrice = $v.minPrice;
      _maxPrice = $v.maxPrice;
      _sortBy = $v.sortBy;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchOptionsOffersInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSearchOptionsOffersInput;
  }

  @override
  void update(void Function(GSearchOptionsOffersInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchOptionsOffersInput build() => _build();

  _$GSearchOptionsOffersInput _build() {
    final _$result = _$v ??
        new _$GSearchOptionsOffersInput._(
            owner: owner,
            category: category,
            targetRole: targetRole,
            place: place,
            minPrice: minPrice,
            maxPrice: maxPrice,
            sortBy: sortBy);
    replace(_$result);
    return _$result;
  }
}

class _$GSearchProductsQuery extends GSearchProductsQuery {
  @override
  final String? upc;
  @override
  final String? productTitle;
  @override
  final String? artistId;
  @override
  final String? productType;

  factory _$GSearchProductsQuery(
          [void Function(GSearchProductsQueryBuilder)? updates]) =>
      (new GSearchProductsQueryBuilder()..update(updates))._build();

  _$GSearchProductsQuery._(
      {this.upc, this.productTitle, this.artistId, this.productType})
      : super._();

  @override
  GSearchProductsQuery rebuild(
          void Function(GSearchProductsQueryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSearchProductsQueryBuilder toBuilder() =>
      new GSearchProductsQueryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchProductsQuery &&
        upc == other.upc &&
        productTitle == other.productTitle &&
        artistId == other.artistId &&
        productType == other.productType;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, upc.hashCode);
    _$hash = $jc(_$hash, productTitle.hashCode);
    _$hash = $jc(_$hash, artistId.hashCode);
    _$hash = $jc(_$hash, productType.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSearchProductsQuery')
          ..add('upc', upc)
          ..add('productTitle', productTitle)
          ..add('artistId', artistId)
          ..add('productType', productType))
        .toString();
  }
}

class GSearchProductsQueryBuilder
    implements Builder<GSearchProductsQuery, GSearchProductsQueryBuilder> {
  _$GSearchProductsQuery? _$v;

  String? _upc;
  String? get upc => _$this._upc;
  set upc(String? upc) => _$this._upc = upc;

  String? _productTitle;
  String? get productTitle => _$this._productTitle;
  set productTitle(String? productTitle) => _$this._productTitle = productTitle;

  String? _artistId;
  String? get artistId => _$this._artistId;
  set artistId(String? artistId) => _$this._artistId = artistId;

  String? _productType;
  String? get productType => _$this._productType;
  set productType(String? productType) => _$this._productType = productType;

  GSearchProductsQueryBuilder();

  GSearchProductsQueryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _upc = $v.upc;
      _productTitle = $v.productTitle;
      _artistId = $v.artistId;
      _productType = $v.productType;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchProductsQuery other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSearchProductsQuery;
  }

  @override
  void update(void Function(GSearchProductsQueryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchProductsQuery build() => _build();

  _$GSearchProductsQuery _build() {
    final _$result = _$v ??
        new _$GSearchProductsQuery._(
            upc: upc,
            productTitle: productTitle,
            artistId: artistId,
            productType: productType);
    replace(_$result);
    return _$result;
  }
}

class _$GSearchTracksQuery extends GSearchTracksQuery {
  @override
  final String? isrc;
  @override
  final String? trackTitle;
  @override
  final String? artistId;

  factory _$GSearchTracksQuery(
          [void Function(GSearchTracksQueryBuilder)? updates]) =>
      (new GSearchTracksQueryBuilder()..update(updates))._build();

  _$GSearchTracksQuery._({this.isrc, this.trackTitle, this.artistId})
      : super._();

  @override
  GSearchTracksQuery rebuild(
          void Function(GSearchTracksQueryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSearchTracksQueryBuilder toBuilder() =>
      new GSearchTracksQueryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchTracksQuery &&
        isrc == other.isrc &&
        trackTitle == other.trackTitle &&
        artistId == other.artistId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, isrc.hashCode);
    _$hash = $jc(_$hash, trackTitle.hashCode);
    _$hash = $jc(_$hash, artistId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSearchTracksQuery')
          ..add('isrc', isrc)
          ..add('trackTitle', trackTitle)
          ..add('artistId', artistId))
        .toString();
  }
}

class GSearchTracksQueryBuilder
    implements Builder<GSearchTracksQuery, GSearchTracksQueryBuilder> {
  _$GSearchTracksQuery? _$v;

  String? _isrc;
  String? get isrc => _$this._isrc;
  set isrc(String? isrc) => _$this._isrc = isrc;

  String? _trackTitle;
  String? get trackTitle => _$this._trackTitle;
  set trackTitle(String? trackTitle) => _$this._trackTitle = trackTitle;

  String? _artistId;
  String? get artistId => _$this._artistId;
  set artistId(String? artistId) => _$this._artistId = artistId;

  GSearchTracksQueryBuilder();

  GSearchTracksQueryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isrc = $v.isrc;
      _trackTitle = $v.trackTitle;
      _artistId = $v.artistId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchTracksQuery other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSearchTracksQuery;
  }

  @override
  void update(void Function(GSearchTracksQueryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchTracksQuery build() => _build();

  _$GSearchTracksQuery _build() {
    final _$result = _$v ??
        new _$GSearchTracksQuery._(
            isrc: isrc, trackTitle: trackTitle, artistId: artistId);
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

class _$GStatusUser extends GStatusUser {
  @override
  final String userId;
  @override
  final String status;

  factory _$GStatusUser([void Function(GStatusUserBuilder)? updates]) =>
      (new GStatusUserBuilder()..update(updates))._build();

  _$GStatusUser._({required this.userId, required this.status}) : super._() {
    BuiltValueNullFieldError.checkNotNull(userId, r'GStatusUser', 'userId');
    BuiltValueNullFieldError.checkNotNull(status, r'GStatusUser', 'status');
  }

  @override
  GStatusUser rebuild(void Function(GStatusUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GStatusUserBuilder toBuilder() => new GStatusUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GStatusUser &&
        userId == other.userId &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GStatusUser')
          ..add('userId', userId)
          ..add('status', status))
        .toString();
  }
}

class GStatusUserBuilder implements Builder<GStatusUser, GStatusUserBuilder> {
  _$GStatusUser? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  GStatusUserBuilder();

  GStatusUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GStatusUser other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GStatusUser;
  }

  @override
  void update(void Function(GStatusUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GStatusUser build() => _build();

  _$GStatusUser _build() {
    final _$result = _$v ??
        new _$GStatusUser._(
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'GStatusUser', 'userId'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'GStatusUser', 'status'));
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateArtistInput extends GUpdateArtistInput {
  @override
  final String artistId;
  @override
  final String? displayNameJp;
  @override
  final String? displayNameEn;
  @override
  final String? displayNameKana;
  @override
  final String? imgUrl;
  @override
  final int? fsp;
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

  factory _$GUpdateArtistInput(
          [void Function(GUpdateArtistInputBuilder)? updates]) =>
      (new GUpdateArtistInputBuilder()..update(updates))._build();

  _$GUpdateArtistInput._(
      {required this.artistId,
      this.displayNameJp,
      this.displayNameEn,
      this.displayNameKana,
      this.imgUrl,
      this.fsp,
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
        artistId, r'GUpdateArtistInput', 'artistId');
  }

  @override
  GUpdateArtistInput rebuild(
          void Function(GUpdateArtistInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateArtistInputBuilder toBuilder() =>
      new GUpdateArtistInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateArtistInput &&
        artistId == other.artistId &&
        displayNameJp == other.displayNameJp &&
        displayNameEn == other.displayNameEn &&
        displayNameKana == other.displayNameKana &&
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
    _$hash = $jc(_$hash, artistId.hashCode);
    _$hash = $jc(_$hash, displayNameJp.hashCode);
    _$hash = $jc(_$hash, displayNameEn.hashCode);
    _$hash = $jc(_$hash, displayNameKana.hashCode);
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
    return (newBuiltValueToStringHelper(r'GUpdateArtistInput')
          ..add('artistId', artistId)
          ..add('displayNameJp', displayNameJp)
          ..add('displayNameEn', displayNameEn)
          ..add('displayNameKana', displayNameKana)
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

class GUpdateArtistInputBuilder
    implements Builder<GUpdateArtistInput, GUpdateArtistInputBuilder> {
  _$GUpdateArtistInput? _$v;

  String? _artistId;
  String? get artistId => _$this._artistId;
  set artistId(String? artistId) => _$this._artistId = artistId;

  String? _displayNameJp;
  String? get displayNameJp => _$this._displayNameJp;
  set displayNameJp(String? displayNameJp) =>
      _$this._displayNameJp = displayNameJp;

  String? _displayNameEn;
  String? get displayNameEn => _$this._displayNameEn;
  set displayNameEn(String? displayNameEn) =>
      _$this._displayNameEn = displayNameEn;

  String? _displayNameKana;
  String? get displayNameKana => _$this._displayNameKana;
  set displayNameKana(String? displayNameKana) =>
      _$this._displayNameKana = displayNameKana;

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

  GUpdateArtistInputBuilder();

  GUpdateArtistInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _artistId = $v.artistId;
      _displayNameJp = $v.displayNameJp;
      _displayNameEn = $v.displayNameEn;
      _displayNameKana = $v.displayNameKana;
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
  void replace(GUpdateArtistInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateArtistInput;
  }

  @override
  void update(void Function(GUpdateArtistInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateArtistInput build() => _build();

  _$GUpdateArtistInput _build() {
    final _$result = _$v ??
        new _$GUpdateArtistInput._(
            artistId: BuiltValueNullFieldError.checkNotNull(
                artistId, r'GUpdateArtistInput', 'artistId'),
            displayNameJp: displayNameJp,
            displayNameEn: displayNameEn,
            displayNameKana: displayNameKana,
            imgUrl: imgUrl,
            fsp: fsp,
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

class _$GUpdateBelongsToArtistStatusInput
    extends GUpdateBelongsToArtistStatusInput {
  @override
  final String userId;
  @override
  final String artistId;
  @override
  final String? nextStatus;
  @override
  final bool? nextStatusIsAdmin;

  factory _$GUpdateBelongsToArtistStatusInput(
          [void Function(GUpdateBelongsToArtistStatusInputBuilder)? updates]) =>
      (new GUpdateBelongsToArtistStatusInputBuilder()..update(updates))
          ._build();

  _$GUpdateBelongsToArtistStatusInput._(
      {required this.userId,
      required this.artistId,
      this.nextStatus,
      this.nextStatusIsAdmin})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        userId, r'GUpdateBelongsToArtistStatusInput', 'userId');
    BuiltValueNullFieldError.checkNotNull(
        artistId, r'GUpdateBelongsToArtistStatusInput', 'artistId');
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
        userId == other.userId &&
        artistId == other.artistId &&
        nextStatus == other.nextStatus &&
        nextStatusIsAdmin == other.nextStatusIsAdmin;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, artistId.hashCode);
    _$hash = $jc(_$hash, nextStatus.hashCode);
    _$hash = $jc(_$hash, nextStatusIsAdmin.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateBelongsToArtistStatusInput')
          ..add('userId', userId)
          ..add('artistId', artistId)
          ..add('nextStatus', nextStatus)
          ..add('nextStatusIsAdmin', nextStatusIsAdmin))
        .toString();
  }
}

class GUpdateBelongsToArtistStatusInputBuilder
    implements
        Builder<GUpdateBelongsToArtistStatusInput,
            GUpdateBelongsToArtistStatusInputBuilder> {
  _$GUpdateBelongsToArtistStatusInput? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _artistId;
  String? get artistId => _$this._artistId;
  set artistId(String? artistId) => _$this._artistId = artistId;

  String? _nextStatus;
  String? get nextStatus => _$this._nextStatus;
  set nextStatus(String? nextStatus) => _$this._nextStatus = nextStatus;

  bool? _nextStatusIsAdmin;
  bool? get nextStatusIsAdmin => _$this._nextStatusIsAdmin;
  set nextStatusIsAdmin(bool? nextStatusIsAdmin) =>
      _$this._nextStatusIsAdmin = nextStatusIsAdmin;

  GUpdateBelongsToArtistStatusInputBuilder();

  GUpdateBelongsToArtistStatusInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _artistId = $v.artistId;
      _nextStatus = $v.nextStatus;
      _nextStatusIsAdmin = $v.nextStatusIsAdmin;
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
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'GUpdateBelongsToArtistStatusInput', 'userId'),
            artistId: BuiltValueNullFieldError.checkNotNull(
                artistId, r'GUpdateBelongsToArtistStatusInput', 'artistId'),
            nextStatus: nextStatus,
            nextStatusIsAdmin: nextStatusIsAdmin);
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateCreditInput extends GUpdateCreditInput {
  @override
  final int creditId;
  @override
  final String commitUser;
  @override
  final String? creditRole;
  @override
  final String? creditName;
  @override
  final String? email;
  @override
  final bool? isInvite;
  @override
  final String? memo;

  factory _$GUpdateCreditInput(
          [void Function(GUpdateCreditInputBuilder)? updates]) =>
      (new GUpdateCreditInputBuilder()..update(updates))._build();

  _$GUpdateCreditInput._(
      {required this.creditId,
      required this.commitUser,
      this.creditRole,
      this.creditName,
      this.email,
      this.isInvite,
      this.memo})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        creditId, r'GUpdateCreditInput', 'creditId');
    BuiltValueNullFieldError.checkNotNull(
        commitUser, r'GUpdateCreditInput', 'commitUser');
  }

  @override
  GUpdateCreditInput rebuild(
          void Function(GUpdateCreditInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateCreditInputBuilder toBuilder() =>
      new GUpdateCreditInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateCreditInput &&
        creditId == other.creditId &&
        commitUser == other.commitUser &&
        creditRole == other.creditRole &&
        creditName == other.creditName &&
        email == other.email &&
        isInvite == other.isInvite &&
        memo == other.memo;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, creditId.hashCode);
    _$hash = $jc(_$hash, commitUser.hashCode);
    _$hash = $jc(_$hash, creditRole.hashCode);
    _$hash = $jc(_$hash, creditName.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, isInvite.hashCode);
    _$hash = $jc(_$hash, memo.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateCreditInput')
          ..add('creditId', creditId)
          ..add('commitUser', commitUser)
          ..add('creditRole', creditRole)
          ..add('creditName', creditName)
          ..add('email', email)
          ..add('isInvite', isInvite)
          ..add('memo', memo))
        .toString();
  }
}

class GUpdateCreditInputBuilder
    implements Builder<GUpdateCreditInput, GUpdateCreditInputBuilder> {
  _$GUpdateCreditInput? _$v;

  int? _creditId;
  int? get creditId => _$this._creditId;
  set creditId(int? creditId) => _$this._creditId = creditId;

  String? _commitUser;
  String? get commitUser => _$this._commitUser;
  set commitUser(String? commitUser) => _$this._commitUser = commitUser;

  String? _creditRole;
  String? get creditRole => _$this._creditRole;
  set creditRole(String? creditRole) => _$this._creditRole = creditRole;

  String? _creditName;
  String? get creditName => _$this._creditName;
  set creditName(String? creditName) => _$this._creditName = creditName;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  bool? _isInvite;
  bool? get isInvite => _$this._isInvite;
  set isInvite(bool? isInvite) => _$this._isInvite = isInvite;

  String? _memo;
  String? get memo => _$this._memo;
  set memo(String? memo) => _$this._memo = memo;

  GUpdateCreditInputBuilder();

  GUpdateCreditInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _creditId = $v.creditId;
      _commitUser = $v.commitUser;
      _creditRole = $v.creditRole;
      _creditName = $v.creditName;
      _email = $v.email;
      _isInvite = $v.isInvite;
      _memo = $v.memo;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateCreditInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateCreditInput;
  }

  @override
  void update(void Function(GUpdateCreditInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateCreditInput build() => _build();

  _$GUpdateCreditInput _build() {
    final _$result = _$v ??
        new _$GUpdateCreditInput._(
            creditId: BuiltValueNullFieldError.checkNotNull(
                creditId, r'GUpdateCreditInput', 'creditId'),
            commitUser: BuiltValueNullFieldError.checkNotNull(
                commitUser, r'GUpdateCreditInput', 'commitUser'),
            creditRole: creditRole,
            creditName: creditName,
            email: email,
            isInvite: isInvite,
            memo: memo);
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateOfferInput extends GUpdateOfferInput {
  @override
  final int id;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final int? fee;
  @override
  final String? imageUrl;
  @override
  final String? category;
  @override
  final String? place;
  @override
  final String? attention;
  @override
  final String? requiredSkill;
  @override
  final String? targetRole;
  @override
  final BuiltList<String>? attachedImgs;
  @override
  final BuiltList<String>? attachedFiles;
  @override
  final bool? publicity;
  @override
  final String? deadline;

  factory _$GUpdateOfferInput(
          [void Function(GUpdateOfferInputBuilder)? updates]) =>
      (new GUpdateOfferInputBuilder()..update(updates))._build();

  _$GUpdateOfferInput._(
      {required this.id,
      this.title,
      this.description,
      this.fee,
      this.imageUrl,
      this.category,
      this.place,
      this.attention,
      this.requiredSkill,
      this.targetRole,
      this.attachedImgs,
      this.attachedFiles,
      this.publicity,
      this.deadline})
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
        category == other.category &&
        place == other.place &&
        attention == other.attention &&
        requiredSkill == other.requiredSkill &&
        targetRole == other.targetRole &&
        attachedImgs == other.attachedImgs &&
        attachedFiles == other.attachedFiles &&
        publicity == other.publicity &&
        deadline == other.deadline;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, fee.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, place.hashCode);
    _$hash = $jc(_$hash, attention.hashCode);
    _$hash = $jc(_$hash, requiredSkill.hashCode);
    _$hash = $jc(_$hash, targetRole.hashCode);
    _$hash = $jc(_$hash, attachedImgs.hashCode);
    _$hash = $jc(_$hash, attachedFiles.hashCode);
    _$hash = $jc(_$hash, publicity.hashCode);
    _$hash = $jc(_$hash, deadline.hashCode);
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
          ..add('category', category)
          ..add('place', place)
          ..add('attention', attention)
          ..add('requiredSkill', requiredSkill)
          ..add('targetRole', targetRole)
          ..add('attachedImgs', attachedImgs)
          ..add('attachedFiles', attachedFiles)
          ..add('publicity', publicity)
          ..add('deadline', deadline))
        .toString();
  }
}

class GUpdateOfferInputBuilder
    implements Builder<GUpdateOfferInput, GUpdateOfferInputBuilder> {
  _$GUpdateOfferInput? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

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

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  String? _place;
  String? get place => _$this._place;
  set place(String? place) => _$this._place = place;

  String? _attention;
  String? get attention => _$this._attention;
  set attention(String? attention) => _$this._attention = attention;

  String? _requiredSkill;
  String? get requiredSkill => _$this._requiredSkill;
  set requiredSkill(String? requiredSkill) =>
      _$this._requiredSkill = requiredSkill;

  String? _targetRole;
  String? get targetRole => _$this._targetRole;
  set targetRole(String? targetRole) => _$this._targetRole = targetRole;

  ListBuilder<String>? _attachedImgs;
  ListBuilder<String> get attachedImgs =>
      _$this._attachedImgs ??= new ListBuilder<String>();
  set attachedImgs(ListBuilder<String>? attachedImgs) =>
      _$this._attachedImgs = attachedImgs;

  ListBuilder<String>? _attachedFiles;
  ListBuilder<String> get attachedFiles =>
      _$this._attachedFiles ??= new ListBuilder<String>();
  set attachedFiles(ListBuilder<String>? attachedFiles) =>
      _$this._attachedFiles = attachedFiles;

  bool? _publicity;
  bool? get publicity => _$this._publicity;
  set publicity(bool? publicity) => _$this._publicity = publicity;

  String? _deadline;
  String? get deadline => _$this._deadline;
  set deadline(String? deadline) => _$this._deadline = deadline;

  GUpdateOfferInputBuilder();

  GUpdateOfferInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _description = $v.description;
      _fee = $v.fee;
      _imageUrl = $v.imageUrl;
      _category = $v.category;
      _place = $v.place;
      _attention = $v.attention;
      _requiredSkill = $v.requiredSkill;
      _targetRole = $v.targetRole;
      _attachedImgs = $v.attachedImgs?.toBuilder();
      _attachedFiles = $v.attachedFiles?.toBuilder();
      _publicity = $v.publicity;
      _deadline = $v.deadline;
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
    _$GUpdateOfferInput _$result;
    try {
      _$result = _$v ??
          new _$GUpdateOfferInput._(
              id: BuiltValueNullFieldError.checkNotNull(
                  id, r'GUpdateOfferInput', 'id'),
              title: title,
              description: description,
              fee: fee,
              imageUrl: imageUrl,
              category: category,
              place: place,
              attention: attention,
              requiredSkill: requiredSkill,
              targetRole: targetRole,
              attachedImgs: _attachedImgs?.build(),
              attachedFiles: _attachedFiles?.build(),
              publicity: publicity,
              deadline: deadline);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'attachedImgs';
        _attachedImgs?.build();
        _$failedField = 'attachedFiles';
        _attachedFiles?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GUpdateOfferInput', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateOfferStatusInput extends GUpdateOfferStatusInput {
  @override
  final int id;
  @override
  final String userId;
  @override
  final String status;

  factory _$GUpdateOfferStatusInput(
          [void Function(GUpdateOfferStatusInputBuilder)? updates]) =>
      (new GUpdateOfferStatusInputBuilder()..update(updates))._build();

  _$GUpdateOfferStatusInput._(
      {required this.id, required this.userId, required this.status})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'GUpdateOfferStatusInput', 'id');
    BuiltValueNullFieldError.checkNotNull(
        userId, r'GUpdateOfferStatusInput', 'userId');
    BuiltValueNullFieldError.checkNotNull(
        status, r'GUpdateOfferStatusInput', 'status');
  }

  @override
  GUpdateOfferStatusInput rebuild(
          void Function(GUpdateOfferStatusInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateOfferStatusInputBuilder toBuilder() =>
      new GUpdateOfferStatusInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateOfferStatusInput &&
        id == other.id &&
        userId == other.userId &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateOfferStatusInput')
          ..add('id', id)
          ..add('userId', userId)
          ..add('status', status))
        .toString();
  }
}

class GUpdateOfferStatusInputBuilder
    implements
        Builder<GUpdateOfferStatusInput, GUpdateOfferStatusInputBuilder> {
  _$GUpdateOfferStatusInput? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  GUpdateOfferStatusInputBuilder();

  GUpdateOfferStatusInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateOfferStatusInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateOfferStatusInput;
  }

  @override
  void update(void Function(GUpdateOfferStatusInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateOfferStatusInput build() => _build();

  _$GUpdateOfferStatusInput _build() {
    final _$result = _$v ??
        new _$GUpdateOfferStatusInput._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GUpdateOfferStatusInput', 'id'),
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'GUpdateOfferStatusInput', 'userId'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'GUpdateOfferStatusInput', 'status'));
    replace(_$result);
    return _$result;
  }
}

class _$GUpdatePortfolioInput extends GUpdatePortfolioInput {
  @override
  final int id;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? imgUrl;
  @override
  final String? category;
  @override
  final String? releaseDate;
  @override
  final String? externalUrl;

  factory _$GUpdatePortfolioInput(
          [void Function(GUpdatePortfolioInputBuilder)? updates]) =>
      (new GUpdatePortfolioInputBuilder()..update(updates))._build();

  _$GUpdatePortfolioInput._(
      {required this.id,
      this.title,
      this.description,
      this.imgUrl,
      this.category,
      this.releaseDate,
      this.externalUrl})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'GUpdatePortfolioInput', 'id');
  }

  @override
  GUpdatePortfolioInput rebuild(
          void Function(GUpdatePortfolioInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdatePortfolioInputBuilder toBuilder() =>
      new GUpdatePortfolioInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdatePortfolioInput &&
        id == other.id &&
        title == other.title &&
        description == other.description &&
        imgUrl == other.imgUrl &&
        category == other.category &&
        releaseDate == other.releaseDate &&
        externalUrl == other.externalUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, imgUrl.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, releaseDate.hashCode);
    _$hash = $jc(_$hash, externalUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdatePortfolioInput')
          ..add('id', id)
          ..add('title', title)
          ..add('description', description)
          ..add('imgUrl', imgUrl)
          ..add('category', category)
          ..add('releaseDate', releaseDate)
          ..add('externalUrl', externalUrl))
        .toString();
  }
}

class GUpdatePortfolioInputBuilder
    implements Builder<GUpdatePortfolioInput, GUpdatePortfolioInputBuilder> {
  _$GUpdatePortfolioInput? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _imgUrl;
  String? get imgUrl => _$this._imgUrl;
  set imgUrl(String? imgUrl) => _$this._imgUrl = imgUrl;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  String? _releaseDate;
  String? get releaseDate => _$this._releaseDate;
  set releaseDate(String? releaseDate) => _$this._releaseDate = releaseDate;

  String? _externalUrl;
  String? get externalUrl => _$this._externalUrl;
  set externalUrl(String? externalUrl) => _$this._externalUrl = externalUrl;

  GUpdatePortfolioInputBuilder();

  GUpdatePortfolioInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _description = $v.description;
      _imgUrl = $v.imgUrl;
      _category = $v.category;
      _releaseDate = $v.releaseDate;
      _externalUrl = $v.externalUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdatePortfolioInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdatePortfolioInput;
  }

  @override
  void update(void Function(GUpdatePortfolioInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdatePortfolioInput build() => _build();

  _$GUpdatePortfolioInput _build() {
    final _$result = _$v ??
        new _$GUpdatePortfolioInput._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GUpdatePortfolioInput', 'id'),
            title: title,
            description: description,
            imgUrl: imgUrl,
            category: category,
            releaseDate: releaseDate,
            externalUrl: externalUrl);
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateProductInput extends GUpdateProductInput {
  @override
  final String upc;
  @override
  final String? title;
  @override
  final String? imgUrl;
  @override
  final String? type;
  @override
  final String? distributedAt;
  @override
  final String? artistId;

  factory _$GUpdateProductInput(
          [void Function(GUpdateProductInputBuilder)? updates]) =>
      (new GUpdateProductInputBuilder()..update(updates))._build();

  _$GUpdateProductInput._(
      {required this.upc,
      this.title,
      this.imgUrl,
      this.type,
      this.distributedAt,
      this.artistId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(upc, r'GUpdateProductInput', 'upc');
  }

  @override
  GUpdateProductInput rebuild(
          void Function(GUpdateProductInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateProductInputBuilder toBuilder() =>
      new GUpdateProductInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateProductInput &&
        upc == other.upc &&
        title == other.title &&
        imgUrl == other.imgUrl &&
        type == other.type &&
        distributedAt == other.distributedAt &&
        artistId == other.artistId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, upc.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, imgUrl.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, distributedAt.hashCode);
    _$hash = $jc(_$hash, artistId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateProductInput')
          ..add('upc', upc)
          ..add('title', title)
          ..add('imgUrl', imgUrl)
          ..add('type', type)
          ..add('distributedAt', distributedAt)
          ..add('artistId', artistId))
        .toString();
  }
}

class GUpdateProductInputBuilder
    implements Builder<GUpdateProductInput, GUpdateProductInputBuilder> {
  _$GUpdateProductInput? _$v;

  String? _upc;
  String? get upc => _$this._upc;
  set upc(String? upc) => _$this._upc = upc;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _imgUrl;
  String? get imgUrl => _$this._imgUrl;
  set imgUrl(String? imgUrl) => _$this._imgUrl = imgUrl;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _distributedAt;
  String? get distributedAt => _$this._distributedAt;
  set distributedAt(String? distributedAt) =>
      _$this._distributedAt = distributedAt;

  String? _artistId;
  String? get artistId => _$this._artistId;
  set artistId(String? artistId) => _$this._artistId = artistId;

  GUpdateProductInputBuilder();

  GUpdateProductInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _upc = $v.upc;
      _title = $v.title;
      _imgUrl = $v.imgUrl;
      _type = $v.type;
      _distributedAt = $v.distributedAt;
      _artistId = $v.artistId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateProductInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateProductInput;
  }

  @override
  void update(void Function(GUpdateProductInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateProductInput build() => _build();

  _$GUpdateProductInput _build() {
    final _$result = _$v ??
        new _$GUpdateProductInput._(
            upc: BuiltValueNullFieldError.checkNotNull(
                upc, r'GUpdateProductInput', 'upc'),
            title: title,
            imgUrl: imgUrl,
            type: type,
            distributedAt: distributedAt,
            artistId: artistId);
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateTrackInput extends GUpdateTrackInput {
  @override
  final String isrc;
  @override
  final String? title;

  factory _$GUpdateTrackInput(
          [void Function(GUpdateTrackInputBuilder)? updates]) =>
      (new GUpdateTrackInputBuilder()..update(updates))._build();

  _$GUpdateTrackInput._({required this.isrc, this.title}) : super._() {
    BuiltValueNullFieldError.checkNotNull(isrc, r'GUpdateTrackInput', 'isrc');
  }

  @override
  GUpdateTrackInput rebuild(void Function(GUpdateTrackInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateTrackInputBuilder toBuilder() =>
      new GUpdateTrackInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateTrackInput &&
        isrc == other.isrc &&
        title == other.title;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, isrc.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateTrackInput')
          ..add('isrc', isrc)
          ..add('title', title))
        .toString();
  }
}

class GUpdateTrackInputBuilder
    implements Builder<GUpdateTrackInput, GUpdateTrackInputBuilder> {
  _$GUpdateTrackInput? _$v;

  String? _isrc;
  String? get isrc => _$this._isrc;
  set isrc(String? isrc) => _$this._isrc = isrc;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  GUpdateTrackInputBuilder();

  GUpdateTrackInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isrc = $v.isrc;
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateTrackInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateTrackInput;
  }

  @override
  void update(void Function(GUpdateTrackInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateTrackInput build() => _build();

  _$GUpdateTrackInput _build() {
    final _$result = _$v ??
        new _$GUpdateTrackInput._(
            isrc: BuiltValueNullFieldError.checkNotNull(
                isrc, r'GUpdateTrackInput', 'isrc'),
            title: title);
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
  final String? fcmToken;
  @override
  final String? interestOffer;

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
      this.greeting,
      this.skill,
      this.xHandle,
      this.instagramHandle,
      this.fbHandle,
      this.fcmToken,
      this.interestOffer})
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
        greeting == other.greeting &&
        skill == other.skill &&
        xHandle == other.xHandle &&
        instagramHandle == other.instagramHandle &&
        fbHandle == other.fbHandle &&
        fcmToken == other.fcmToken &&
        interestOffer == other.interestOffer;
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
    _$hash = $jc(_$hash, greeting.hashCode);
    _$hash = $jc(_$hash, skill.hashCode);
    _$hash = $jc(_$hash, xHandle.hashCode);
    _$hash = $jc(_$hash, instagramHandle.hashCode);
    _$hash = $jc(_$hash, fbHandle.hashCode);
    _$hash = $jc(_$hash, fcmToken.hashCode);
    _$hash = $jc(_$hash, interestOffer.hashCode);
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
          ..add('greeting', greeting)
          ..add('skill', skill)
          ..add('xHandle', xHandle)
          ..add('instagramHandle', instagramHandle)
          ..add('fbHandle', fbHandle)
          ..add('fcmToken', fcmToken)
          ..add('interestOffer', interestOffer))
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

  String? _fcmToken;
  String? get fcmToken => _$this._fcmToken;
  set fcmToken(String? fcmToken) => _$this._fcmToken = fcmToken;

  String? _interestOffer;
  String? get interestOffer => _$this._interestOffer;
  set interestOffer(String? interestOffer) =>
      _$this._interestOffer = interestOffer;

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
      _greeting = $v.greeting;
      _skill = $v.skill;
      _xHandle = $v.xHandle;
      _instagramHandle = $v.instagramHandle;
      _fbHandle = $v.fbHandle;
      _fcmToken = $v.fcmToken;
      _interestOffer = $v.interestOffer;
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
            greeting: greeting,
            skill: skill,
            xHandle: xHandle,
            instagramHandle: instagramHandle,
            fbHandle: fbHandle,
            fcmToken: fcmToken,
            interestOffer: interestOffer);
    replace(_$result);
    return _$result;
  }
}

class _$GUsePrizeInput extends GUsePrizeInput {
  @override
  final String representationUserId;
  @override
  final String userId;
  @override
  final int prizeId;
  @override
  final String? code;

  factory _$GUsePrizeInput([void Function(GUsePrizeInputBuilder)? updates]) =>
      (new GUsePrizeInputBuilder()..update(updates))._build();

  _$GUsePrizeInput._(
      {required this.representationUserId,
      required this.userId,
      required this.prizeId,
      this.code})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        representationUserId, r'GUsePrizeInput', 'representationUserId');
    BuiltValueNullFieldError.checkNotNull(userId, r'GUsePrizeInput', 'userId');
    BuiltValueNullFieldError.checkNotNull(
        prizeId, r'GUsePrizeInput', 'prizeId');
  }

  @override
  GUsePrizeInput rebuild(void Function(GUsePrizeInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUsePrizeInputBuilder toBuilder() =>
      new GUsePrizeInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUsePrizeInput &&
        representationUserId == other.representationUserId &&
        userId == other.userId &&
        prizeId == other.prizeId &&
        code == other.code;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, representationUserId.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, prizeId.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUsePrizeInput')
          ..add('representationUserId', representationUserId)
          ..add('userId', userId)
          ..add('prizeId', prizeId)
          ..add('code', code))
        .toString();
  }
}

class GUsePrizeInputBuilder
    implements Builder<GUsePrizeInput, GUsePrizeInputBuilder> {
  _$GUsePrizeInput? _$v;

  String? _representationUserId;
  String? get representationUserId => _$this._representationUserId;
  set representationUserId(String? representationUserId) =>
      _$this._representationUserId = representationUserId;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  int? _prizeId;
  int? get prizeId => _$this._prizeId;
  set prizeId(int? prizeId) => _$this._prizeId = prizeId;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  GUsePrizeInputBuilder();

  GUsePrizeInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _representationUserId = $v.representationUserId;
      _userId = $v.userId;
      _prizeId = $v.prizeId;
      _code = $v.code;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUsePrizeInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUsePrizeInput;
  }

  @override
  void update(void Function(GUsePrizeInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUsePrizeInput build() => _build();

  _$GUsePrizeInput _build() {
    final _$result = _$v ??
        new _$GUsePrizeInput._(
            representationUserId: BuiltValueNullFieldError.checkNotNull(
                representationUserId,
                r'GUsePrizeInput',
                'representationUserId'),
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'GUsePrizeInput', 'userId'),
            prizeId: BuiltValueNullFieldError.checkNotNull(
                prizeId, r'GUsePrizeInput', 'prizeId'),
            code: code);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
