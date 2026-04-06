// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:admin/graphql/__generated__/serializers.gql.dart' as _i1;
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gql_code_builder/src/serializers/default_scalar_serializer.dart'
    as _i2;

part 'schema.schema.gql.g.dart';

abstract class GBlockUserInput
    implements Built<GBlockUserInput, GBlockUserInputBuilder> {
  GBlockUserInput._();

  factory GBlockUserInput([void Function(GBlockUserInputBuilder b) updates]) =
      _$GBlockUserInput;

  String get blockedUserId;
  String get blockerUserId;
  static Serializer<GBlockUserInput> get serializer =>
      _$gBlockUserInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GBlockUserInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GBlockUserInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GBlockUserInput.serializer,
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

  String get displayNameJp;
  String get displayNameEn;
  String? get displayNameKana;
  String? get imgUrl;
  int? get fsp;
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
  String get createdBy;
  BuiltList<String> get userList;
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

abstract class GCreateNewOfferInput
    implements Built<GCreateNewOfferInput, GCreateNewOfferInputBuilder> {
  GCreateNewOfferInput._();

  factory GCreateNewOfferInput(
          [void Function(GCreateNewOfferInputBuilder b) updates]) =
      _$GCreateNewOfferInput;

  String get owner;
  String? get deadline;
  String get title;
  String get description;
  int get fee;
  String? get imageUrl;
  int? get raidId;
  String? get category;
  String get place;
  String? get attention;
  String? get requiredSkill;
  String? get targetRole;
  bool? get publicity;
  BuiltList<String>? get attachedImgs;
  BuiltList<String>? get attachedFiles;
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

abstract class GCreateNewPrizeInput
    implements Built<GCreateNewPrizeInput, GCreateNewPrizeInputBuilder> {
  GCreateNewPrizeInput._();

  factory GCreateNewPrizeInput(
          [void Function(GCreateNewPrizeInputBuilder b) updates]) =
      _$GCreateNewPrizeInput;

  String get name;
  int get point;
  String get description;
  String get representation;
  String? get condition;
  String? get imgUrl;
  bool? get publicity;
  static Serializer<GCreateNewPrizeInput> get serializer =>
      _$gCreateNewPrizeInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateNewPrizeInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateNewPrizeInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateNewPrizeInput.serializer,
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

  String get id;
  String? get fcmToken;
  String get email;
  String get name;
  String get realname;
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

abstract class GCreateQuestInput
    implements Built<GCreateQuestInput, GCreateQuestInputBuilder> {
  GCreateQuestInput._();

  factory GCreateQuestInput(
          [void Function(GCreateQuestInputBuilder b) updates]) =
      _$GCreateQuestInput;

  String get name;
  String get description;
  static Serializer<GCreateQuestInput> get serializer =>
      _$gCreateQuestInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateQuestInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateQuestInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateQuestInput.serializer,
        json,
      );
}

abstract class GDeleteCreditInput
    implements Built<GDeleteCreditInput, GDeleteCreditInputBuilder> {
  GDeleteCreditInput._();

  factory GDeleteCreditInput(
          [void Function(GDeleteCreditInputBuilder b) updates]) =
      _$GDeleteCreditInput;

  int get creditId;
  static Serializer<GDeleteCreditInput> get serializer =>
      _$gDeleteCreditInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GDeleteCreditInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GDeleteCreditInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GDeleteCreditInput.serializer,
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

abstract class GDeletePortfolioInput
    implements Built<GDeletePortfolioInput, GDeletePortfolioInputBuilder> {
  GDeletePortfolioInput._();

  factory GDeletePortfolioInput(
          [void Function(GDeletePortfolioInputBuilder b) updates]) =
      _$GDeletePortfolioInput;

  int get id;
  static Serializer<GDeletePortfolioInput> get serializer =>
      _$gDeletePortfolioInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GDeletePortfolioInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GDeletePortfolioInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GDeletePortfolioInput.serializer,
        json,
      );
}

abstract class GExchangePrizeInput
    implements Built<GExchangePrizeInput, GExchangePrizeInputBuilder> {
  GExchangePrizeInput._();

  factory GExchangePrizeInput(
          [void Function(GExchangePrizeInputBuilder b) updates]) =
      _$GExchangePrizeInput;

  String get userId;
  int get prizeId;
  int? get amount;
  static Serializer<GExchangePrizeInput> get serializer =>
      _$gExchangePrizeInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GExchangePrizeInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GExchangePrizeInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GExchangePrizeInput.serializer,
        json,
      );
}

abstract class GJSONObject implements Built<GJSONObject, GJSONObjectBuilder> {
  GJSONObject._();

  factory GJSONObject([String? value]) =>
      _$GJSONObject((b) => value != null ? (b..value = value) : b);

  String get value;
  @BuiltValueSerializer(custom: true)
  static Serializer<GJSONObject> get serializer =>
      _i2.DefaultScalarSerializer<GJSONObject>(
          (Object serialized) => GJSONObject((serialized as String?)));
}

abstract class GMarkAsAdminInput
    implements Built<GMarkAsAdminInput, GMarkAsAdminInputBuilder> {
  GMarkAsAdminInput._();

  factory GMarkAsAdminInput(
          [void Function(GMarkAsAdminInputBuilder b) updates]) =
      _$GMarkAsAdminInput;

  String get adminMember;
  String get userId;
  String get artistId;
  static Serializer<GMarkAsAdminInput> get serializer =>
      _$gMarkAsAdminInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMarkAsAdminInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMarkAsAdminInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMarkAsAdminInput.serializer,
        json,
      );
}

abstract class GMarkAsMemberInput
    implements Built<GMarkAsMemberInput, GMarkAsMemberInputBuilder> {
  GMarkAsMemberInput._();

  factory GMarkAsMemberInput(
          [void Function(GMarkAsMemberInputBuilder b) updates]) =
      _$GMarkAsMemberInput;

  String get member;
  String get artistId;
  BuiltList<GStatusUser> get mapping;
  static Serializer<GMarkAsMemberInput> get serializer =>
      _$gMarkAsMemberInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMarkAsMemberInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMarkAsMemberInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMarkAsMemberInput.serializer,
        json,
      );
}

abstract class GMarkAsReadInput
    implements Built<GMarkAsReadInput, GMarkAsReadInputBuilder> {
  GMarkAsReadInput._();

  factory GMarkAsReadInput([void Function(GMarkAsReadInputBuilder b) updates]) =
      _$GMarkAsReadInput;

  String get roomId;
  String get userId;
  String get messageId;
  static Serializer<GMarkAsReadInput> get serializer =>
      _$gMarkAsReadInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMarkAsReadInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMarkAsReadInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMarkAsReadInput.serializer,
        json,
      );
}

abstract class GRegisterCreditInput
    implements Built<GRegisterCreditInput, GRegisterCreditInputBuilder> {
  GRegisterCreditInput._();

  factory GRegisterCreditInput(
          [void Function(GRegisterCreditInputBuilder b) updates]) =
      _$GRegisterCreditInput;

  BuiltList<GRegisterInfo> get registerInfo;
  static Serializer<GRegisterCreditInput> get serializer =>
      _$gRegisterCreditInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRegisterCreditInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRegisterCreditInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRegisterCreditInput.serializer,
        json,
      );
}

abstract class GRegisterInfo
    implements Built<GRegisterInfo, GRegisterInfoBuilder> {
  GRegisterInfo._();

  factory GRegisterInfo([void Function(GRegisterInfoBuilder b) updates]) =
      _$GRegisterInfo;

  String get isrc;
  String get commitUser;
  String get creditRole;
  String get creditName;
  String get email;
  bool get isInvite;
  String? get memo;
  static Serializer<GRegisterInfo> get serializer => _$gRegisterInfoSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRegisterInfo.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRegisterInfo? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRegisterInfo.serializer,
        json,
      );
}

abstract class GRegisterPortfolioInput
    implements Built<GRegisterPortfolioInput, GRegisterPortfolioInputBuilder> {
  GRegisterPortfolioInput._();

  factory GRegisterPortfolioInput(
          [void Function(GRegisterPortfolioInputBuilder b) updates]) =
      _$GRegisterPortfolioInput;

  String get userId;
  String get title;
  String get description;
  String get imgUrl;
  String get category;
  String get releaseDate;
  String get externalUrl;
  static Serializer<GRegisterPortfolioInput> get serializer =>
      _$gRegisterPortfolioInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRegisterPortfolioInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRegisterPortfolioInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRegisterPortfolioInput.serializer,
        json,
      );
}

abstract class GRegisterReleases
    implements Built<GRegisterReleases, GRegisterReleasesBuilder> {
  GRegisterReleases._();

  factory GRegisterReleases(
          [void Function(GRegisterReleasesBuilder b) updates]) =
      _$GRegisterReleases;

  BuiltList<GReleaseData> get releases;
  static Serializer<GRegisterReleases> get serializer =>
      _$gRegisterReleasesSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRegisterReleases.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRegisterReleases? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRegisterReleases.serializer,
        json,
      );
}

abstract class GReleaseData
    implements Built<GReleaseData, GReleaseDataBuilder> {
  GReleaseData._();

  factory GReleaseData([void Function(GReleaseDataBuilder b) updates]) =
      _$GReleaseData;

  String get upc;
  String get format;
  int get trackCount;
  String get title;
  String get releaseDate;
  String get isrc;
  int get trackNo;
  String get trackTitle;
  String get trackTitleVersion;
  String get artistId;
  String? get imageUrl;
  static Serializer<GReleaseData> get serializer => _$gReleaseDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GReleaseData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReleaseData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GReleaseData.serializer,
        json,
      );
}

abstract class GReportOfferInput
    implements Built<GReportOfferInput, GReportOfferInputBuilder> {
  GReportOfferInput._();

  factory GReportOfferInput(
          [void Function(GReportOfferInputBuilder b) updates]) =
      _$GReportOfferInput;

  int get offerId;
  String get reporterUserId;
  String get reportContent;
  static Serializer<GReportOfferInput> get serializer =>
      _$gReportOfferInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GReportOfferInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReportOfferInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GReportOfferInput.serializer,
        json,
      );
}

abstract class GReportUserInput
    implements Built<GReportUserInput, GReportUserInputBuilder> {
  GReportUserInput._();

  factory GReportUserInput([void Function(GReportUserInputBuilder b) updates]) =
      _$GReportUserInput;

  String get reportedUserId;
  String get reporterUserId;
  String get reportContent;
  static Serializer<GReportUserInput> get serializer =>
      _$gReportUserInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GReportUserInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReportUserInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GReportUserInput.serializer,
        json,
      );
}

abstract class GRequestPrizeInput
    implements Built<GRequestPrizeInput, GRequestPrizeInputBuilder> {
  GRequestPrizeInput._();

  factory GRequestPrizeInput(
          [void Function(GRequestPrizeInputBuilder b) updates]) =
      _$GRequestPrizeInput;

  String get userId;
  int get prizeId;
  static Serializer<GRequestPrizeInput> get serializer =>
      _$gRequestPrizeInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRequestPrizeInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRequestPrizeInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRequestPrizeInput.serializer,
        json,
      );
}

abstract class GRequestToAccessArtistInput
    implements
        Built<GRequestToAccessArtistInput, GRequestToAccessArtistInputBuilder> {
  GRequestToAccessArtistInput._();

  factory GRequestToAccessArtistInput(
          [void Function(GRequestToAccessArtistInputBuilder b) updates]) =
      _$GRequestToAccessArtistInput;

  String get userId;
  BuiltList<String> get artistIds;
  static Serializer<GRequestToAccessArtistInput> get serializer =>
      _$gRequestToAccessArtistInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRequestToAccessArtistInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRequestToAccessArtistInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRequestToAccessArtistInput.serializer,
        json,
      );
}

abstract class GSearchOptionsOffersInput
    implements
        Built<GSearchOptionsOffersInput, GSearchOptionsOffersInputBuilder> {
  GSearchOptionsOffersInput._();

  factory GSearchOptionsOffersInput(
          [void Function(GSearchOptionsOffersInputBuilder b) updates]) =
      _$GSearchOptionsOffersInput;

  String? get owner;
  String? get category;
  String? get targetRole;
  String? get place;
  int? get minPrice;
  int? get maxPrice;
  String? get sortBy;
  static Serializer<GSearchOptionsOffersInput> get serializer =>
      _$gSearchOptionsOffersInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchOptionsOffersInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchOptionsOffersInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchOptionsOffersInput.serializer,
        json,
      );
}

abstract class GSearchProductsQuery
    implements Built<GSearchProductsQuery, GSearchProductsQueryBuilder> {
  GSearchProductsQuery._();

  factory GSearchProductsQuery(
          [void Function(GSearchProductsQueryBuilder b) updates]) =
      _$GSearchProductsQuery;

  String? get upc;
  String? get productTitle;
  String? get artistId;
  String? get productType;
  static Serializer<GSearchProductsQuery> get serializer =>
      _$gSearchProductsQuerySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchProductsQuery.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchProductsQuery? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchProductsQuery.serializer,
        json,
      );
}

abstract class GSearchTracksQuery
    implements Built<GSearchTracksQuery, GSearchTracksQueryBuilder> {
  GSearchTracksQuery._();

  factory GSearchTracksQuery(
          [void Function(GSearchTracksQueryBuilder b) updates]) =
      _$GSearchTracksQuery;

  String? get isrc;
  String? get trackTitle;
  String? get artistId;
  static Serializer<GSearchTracksQuery> get serializer =>
      _$gSearchTracksQuerySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchTracksQuery.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchTracksQuery? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchTracksQuery.serializer,
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

abstract class GStatusUser implements Built<GStatusUser, GStatusUserBuilder> {
  GStatusUser._();

  factory GStatusUser([void Function(GStatusUserBuilder b) updates]) =
      _$GStatusUser;

  String get userId;
  String get status;
  static Serializer<GStatusUser> get serializer => _$gStatusUserSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GStatusUser.serializer,
        this,
      ) as Map<String, dynamic>);

  static GStatusUser? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GStatusUser.serializer,
        json,
      );
}

class GTransactionDirection extends EnumClass {
  const GTransactionDirection._(String name) : super(name);

  static const GTransactionDirection IN = _$gTransactionDirectionIN;

  static const GTransactionDirection OUT = _$gTransactionDirectionOUT;

  static Serializer<GTransactionDirection> get serializer =>
      _$gTransactionDirectionSerializer;

  static BuiltSet<GTransactionDirection> get values =>
      _$gTransactionDirectionValues;

  static GTransactionDirection valueOf(String name) =>
      _$gTransactionDirectionValueOf(name);
}

abstract class GUpdateArtistInput
    implements Built<GUpdateArtistInput, GUpdateArtistInputBuilder> {
  GUpdateArtistInput._();

  factory GUpdateArtistInput(
          [void Function(GUpdateArtistInputBuilder b) updates]) =
      _$GUpdateArtistInput;

  String get artistId;
  String? get displayNameJp;
  String? get displayNameEn;
  String? get displayNameKana;
  String? get imgUrl;
  int? get fsp;
  String? get status;
  String? get since;
  String? get universalId;
  String? get appleKey;
  String? get spotifyKey;
  String? get lineKey;
  String? get amazonKey;
  String? get youtubeKey;
  static Serializer<GUpdateArtistInput> get serializer =>
      _$gUpdateArtistInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateArtistInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateArtistInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateArtistInput.serializer,
        json,
      );
}

abstract class GUpdateBelongsToArtistStatusInput
    implements
        Built<GUpdateBelongsToArtistStatusInput,
            GUpdateBelongsToArtistStatusInputBuilder> {
  GUpdateBelongsToArtistStatusInput._();

  factory GUpdateBelongsToArtistStatusInput(
          [void Function(GUpdateBelongsToArtistStatusInputBuilder b) updates]) =
      _$GUpdateBelongsToArtistStatusInput;

  String get userId;
  String get artistId;
  String? get nextStatus;
  bool? get nextStatusIsAdmin;
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

abstract class GUpdateCreditInput
    implements Built<GUpdateCreditInput, GUpdateCreditInputBuilder> {
  GUpdateCreditInput._();

  factory GUpdateCreditInput(
          [void Function(GUpdateCreditInputBuilder b) updates]) =
      _$GUpdateCreditInput;

  int get creditId;
  String get commitUser;
  String? get creditRole;
  String? get creditName;
  String? get email;
  bool? get isInvite;
  String? get memo;
  static Serializer<GUpdateCreditInput> get serializer =>
      _$gUpdateCreditInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateCreditInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateCreditInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateCreditInput.serializer,
        json,
      );
}

abstract class GUpdateOfferInput
    implements Built<GUpdateOfferInput, GUpdateOfferInputBuilder> {
  GUpdateOfferInput._();

  factory GUpdateOfferInput(
          [void Function(GUpdateOfferInputBuilder b) updates]) =
      _$GUpdateOfferInput;

  int get id;
  String? get title;
  String? get description;
  int? get fee;
  String? get imageUrl;
  String? get category;
  String? get place;
  String? get attention;
  String? get requiredSkill;
  String? get targetRole;
  BuiltList<String>? get attachedImgs;
  BuiltList<String>? get attachedFiles;
  bool? get publicity;
  String? get deadline;
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

abstract class GUpdateOfferStatusInput
    implements Built<GUpdateOfferStatusInput, GUpdateOfferStatusInputBuilder> {
  GUpdateOfferStatusInput._();

  factory GUpdateOfferStatusInput(
          [void Function(GUpdateOfferStatusInputBuilder b) updates]) =
      _$GUpdateOfferStatusInput;

  int get id;
  String get userId;
  String get status;
  static Serializer<GUpdateOfferStatusInput> get serializer =>
      _$gUpdateOfferStatusInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateOfferStatusInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateOfferStatusInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateOfferStatusInput.serializer,
        json,
      );
}

abstract class GUpdatePortfolioInput
    implements Built<GUpdatePortfolioInput, GUpdatePortfolioInputBuilder> {
  GUpdatePortfolioInput._();

  factory GUpdatePortfolioInput(
          [void Function(GUpdatePortfolioInputBuilder b) updates]) =
      _$GUpdatePortfolioInput;

  int get id;
  String? get title;
  String? get description;
  String? get imgUrl;
  String? get category;
  String? get releaseDate;
  String? get externalUrl;
  static Serializer<GUpdatePortfolioInput> get serializer =>
      _$gUpdatePortfolioInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdatePortfolioInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdatePortfolioInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdatePortfolioInput.serializer,
        json,
      );
}

abstract class GUpdateProductInput
    implements Built<GUpdateProductInput, GUpdateProductInputBuilder> {
  GUpdateProductInput._();

  factory GUpdateProductInput(
          [void Function(GUpdateProductInputBuilder b) updates]) =
      _$GUpdateProductInput;

  String get upc;
  String? get title;
  String? get imgUrl;
  String? get type;
  String? get distributedAt;
  String? get artistId;
  static Serializer<GUpdateProductInput> get serializer =>
      _$gUpdateProductInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateProductInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateProductInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateProductInput.serializer,
        json,
      );
}

abstract class GUpdateTrackInput
    implements Built<GUpdateTrackInput, GUpdateTrackInputBuilder> {
  GUpdateTrackInput._();

  factory GUpdateTrackInput(
          [void Function(GUpdateTrackInputBuilder b) updates]) =
      _$GUpdateTrackInput;

  String get isrc;
  String? get title;
  static Serializer<GUpdateTrackInput> get serializer =>
      _$gUpdateTrackInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateTrackInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateTrackInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateTrackInput.serializer,
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
  String? get greeting;
  String? get skill;
  String? get xHandle;
  String? get instagramHandle;
  String? get fbHandle;
  String? get fcmToken;
  String? get interestOffer;
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

abstract class GUsePrizeInput
    implements Built<GUsePrizeInput, GUsePrizeInputBuilder> {
  GUsePrizeInput._();

  factory GUsePrizeInput([void Function(GUsePrizeInputBuilder b) updates]) =
      _$GUsePrizeInput;

  String get representationUserId;
  String get userId;
  int get prizeId;
  String? get code;
  static Serializer<GUsePrizeInput> get serializer =>
      _$gUsePrizeInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUsePrizeInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUsePrizeInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUsePrizeInput.serializer,
        json,
      );
}

const Map<String, Set<String>> possibleTypesMap = {};
