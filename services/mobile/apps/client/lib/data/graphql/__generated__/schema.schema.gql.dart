// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:client/data/graphql/__generated__/serializers.gql.dart' as _i1;

part 'schema.schema.gql.g.dart';

abstract class GAddNewConnectionByUserInput
    implements
        Built<GAddNewConnectionByUserInput,
            GAddNewConnectionByUserInputBuilder> {
  GAddNewConnectionByUserInput._();

  factory GAddNewConnectionByUserInput(
          [void Function(GAddNewConnectionByUserInputBuilder b) updates]) =
      _$GAddNewConnectionByUserInput;

  String get userId;
  static Serializer<GAddNewConnectionByUserInput> get serializer =>
      _$gAddNewConnectionByUserInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAddNewConnectionByUserInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAddNewConnectionByUserInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAddNewConnectionByUserInput.serializer,
        json,
      );
}

abstract class GContactToAdminInput
    implements Built<GContactToAdminInput, GContactToAdminInputBuilder> {
  GContactToAdminInput._();

  factory GContactToAdminInput(
          [void Function(GContactToAdminInputBuilder b) updates]) =
      _$GContactToAdminInput;

  String get username;
  String get category;
  String get email;
  String get content;
  static Serializer<GContactToAdminInput> get serializer =>
      _$gContactToAdminInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GContactToAdminInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GContactToAdminInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GContactToAdminInput.serializer,
        json,
      );
}

abstract class GCreateNewArtistInput
    implements Built<GCreateNewArtistInput, GCreateNewArtistInputBuilder> {
  GCreateNewArtistInput._();

  factory GCreateNewArtistInput(
          [void Function(GCreateNewArtistInputBuilder b) updates]) =
      _$GCreateNewArtistInput;

  String get name;
  String? get imgUrl;
  int get fsp;
  String? get status;
  String? get since;
  String? get universalId;
  String? get appleKey;
  String? get spotifyKey;
  String? get lineKey;
  String? get amazonKey;
  String? get youtubeKey;
  static Serializer<GCreateNewArtistInput> get serializer =>
      _$gCreateNewArtistInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateNewArtistInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateNewArtistInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateNewArtistInput.serializer,
        json,
      );
}

abstract class GCreateNewMessageRoomInput
    implements
        Built<GCreateNewMessageRoomInput, GCreateNewMessageRoomInputBuilder> {
  GCreateNewMessageRoomInput._();

  factory GCreateNewMessageRoomInput(
          [void Function(GCreateNewMessageRoomInputBuilder b) updates]) =
      _$GCreateNewMessageRoomInput;

  String get category;
  static Serializer<GCreateNewMessageRoomInput> get serializer =>
      _$gCreateNewMessageRoomInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateNewMessageRoomInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateNewMessageRoomInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateNewMessageRoomInput.serializer,
        json,
      );
}

abstract class GCreateNewNotificationInput
    implements
        Built<GCreateNewNotificationInput, GCreateNewNotificationInputBuilder> {
  GCreateNewNotificationInput._();

  factory GCreateNewNotificationInput(
          [void Function(GCreateNewNotificationInputBuilder b) updates]) =
      _$GCreateNewNotificationInput;

  String get title;
  String get content;
  String? get target;
  String? get userId;
  static Serializer<GCreateNewNotificationInput> get serializer =>
      _$gCreateNewNotificationInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateNewNotificationInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateNewNotificationInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateNewNotificationInput.serializer,
        json,
      );
}

abstract class GCreateNewOfferInput
    implements Built<GCreateNewOfferInput, GCreateNewOfferInputBuilder> {
  GCreateNewOfferInput._();

  factory GCreateNewOfferInput(
          [void Function(GCreateNewOfferInputBuilder b) updates]) =
      _$GCreateNewOfferInput;

  String get owner;
  String get releaseDt;
  String get title;
  String get description;
  int get fee;
  String? get imageUrl;
  int? get raidId;
  String? get category;
  static Serializer<GCreateNewOfferInput> get serializer =>
      _$gCreateNewOfferInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateNewOfferInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateNewOfferInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateNewOfferInput.serializer,
        json,
      );
}

abstract class GCreateNewTransactionInput
    implements
        Built<GCreateNewTransactionInput, GCreateNewTransactionInputBuilder> {
  GCreateNewTransactionInput._();

  factory GCreateNewTransactionInput(
          [void Function(GCreateNewTransactionInputBuilder b) updates]) =
      _$GCreateNewTransactionInput;

  String? get from;
  String get to;
  int get amount;
  String? get note;
  static Serializer<GCreateNewTransactionInput> get serializer =>
      _$gCreateNewTransactionInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateNewTransactionInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateNewTransactionInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateNewTransactionInput.serializer,
        json,
      );
}

abstract class GCreateNewUserDataInput
    implements Built<GCreateNewUserDataInput, GCreateNewUserDataInputBuilder> {
  GCreateNewUserDataInput._();

  factory GCreateNewUserDataInput(
          [void Function(GCreateNewUserDataInputBuilder b) updates]) =
      _$GCreateNewUserDataInput;

  String get email;
  String get name;
  String? get imageUrl;
  String? get invitedBy;
  String get category;
  String get primaryCategory;
  static Serializer<GCreateNewUserDataInput> get serializer =>
      _$gCreateNewUserDataInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateNewUserDataInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateNewUserDataInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateNewUserDataInput.serializer,
        json,
      );
}

abstract class GDeleteNotificationInput
    implements
        Built<GDeleteNotificationInput, GDeleteNotificationInputBuilder> {
  GDeleteNotificationInput._();

  factory GDeleteNotificationInput(
          [void Function(GDeleteNotificationInputBuilder b) updates]) =
      _$GDeleteNotificationInput;

  String get id;
  static Serializer<GDeleteNotificationInput> get serializer =>
      _$gDeleteNotificationInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GDeleteNotificationInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GDeleteNotificationInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GDeleteNotificationInput.serializer,
        json,
      );
}

abstract class GDeleteOfferInput
    implements Built<GDeleteOfferInput, GDeleteOfferInputBuilder> {
  GDeleteOfferInput._();

  factory GDeleteOfferInput(
          [void Function(GDeleteOfferInputBuilder b) updates]) =
      _$GDeleteOfferInput;

  int get id;
  static Serializer<GDeleteOfferInput> get serializer =>
      _$gDeleteOfferInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GDeleteOfferInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GDeleteOfferInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GDeleteOfferInput.serializer,
        json,
      );
}

abstract class GSendMessageInput
    implements Built<GSendMessageInput, GSendMessageInputBuilder> {
  GSendMessageInput._();

  factory GSendMessageInput(
          [void Function(GSendMessageInputBuilder b) updates]) =
      _$GSendMessageInput;

  String get roomId;
  String get sentBy;
  String get message;
  BuiltList<String>? get attachedFile;
  BuiltList<String>? get attachedImg;
  static Serializer<GSendMessageInput> get serializer =>
      _$gSendMessageInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendMessageInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendMessageInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSendMessageInput.serializer,
        json,
      );
}

class GTransactionDirection extends EnumClass {
  const GTransactionDirection._(String name) : super(name);

  static const GTransactionDirection IN = _$gTransactionDirectionIN;

  static const GTransactionDirection OUT = _$gTransactionDirectionOUT;

  @BuiltValueEnumConst(
    wireName: 'gUnknownEnumValue',
    fallback: true,
  )
  static const GTransactionDirection gUnknownEnumValue =
      _$gTransactionDirectiongUnknownEnumValue;

  static Serializer<GTransactionDirection> get serializer =>
      _$gTransactionDirectionSerializer;

  static BuiltSet<GTransactionDirection> get values =>
      _$gTransactionDirectionValues;

  static GTransactionDirection valueOf(String name) =>
      _$gTransactionDirectionValueOf(name);
}

abstract class GUpdateBelongsToArtistStatusInput
    implements
        Built<GUpdateBelongsToArtistStatusInput,
            GUpdateBelongsToArtistStatusInputBuilder> {
  GUpdateBelongsToArtistStatusInput._();

  factory GUpdateBelongsToArtistStatusInput(
          [void Function(GUpdateBelongsToArtistStatusInputBuilder b) updates]) =
      _$GUpdateBelongsToArtistStatusInput;

  String get id;
  String? get artistId;
  String? get status;
  static Serializer<GUpdateBelongsToArtistStatusInput> get serializer =>
      _$gUpdateBelongsToArtistStatusInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateBelongsToArtistStatusInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateBelongsToArtistStatusInput? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateBelongsToArtistStatusInput.serializer,
        json,
      );
}

abstract class GUpdateNotificationInput
    implements
        Built<GUpdateNotificationInput, GUpdateNotificationInputBuilder> {
  GUpdateNotificationInput._();

  factory GUpdateNotificationInput(
          [void Function(GUpdateNotificationInputBuilder b) updates]) =
      _$GUpdateNotificationInput;

  String get id;
  String? get title;
  String? get content;
  static Serializer<GUpdateNotificationInput> get serializer =>
      _$gUpdateNotificationInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateNotificationInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateNotificationInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateNotificationInput.serializer,
        json,
      );
}

abstract class GUpdateOfferInput
    implements Built<GUpdateOfferInput, GUpdateOfferInputBuilder> {
  GUpdateOfferInput._();

  factory GUpdateOfferInput(
          [void Function(GUpdateOfferInputBuilder b) updates]) =
      _$GUpdateOfferInput;

  String get id;
  String? get title;
  String? get description;
  int? get fee;
  String? get imageUrl;
  int? get raidId;
  String? get category;
  static Serializer<GUpdateOfferInput> get serializer =>
      _$gUpdateOfferInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateOfferInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateOfferInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateOfferInput.serializer,
        json,
      );
}

abstract class GUpdateUserDataInput
    implements Built<GUpdateUserDataInput, GUpdateUserDataInputBuilder> {
  GUpdateUserDataInput._();

  factory GUpdateUserDataInput(
          [void Function(GUpdateUserDataInputBuilder b) updates]) =
      _$GUpdateUserDataInput;

  String get id;
  String? get email;
  String? get name;
  String? get imageUrl;
  String? get primaryCategory;
  String? get evmAddr;
  String? get status;
  static Serializer<GUpdateUserDataInput> get serializer =>
      _$gUpdateUserDataInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateUserDataInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateUserDataInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateUserDataInput.serializer,
        json,
      );
}

const Map<String, Set<String>> possibleTypesMap = {};
