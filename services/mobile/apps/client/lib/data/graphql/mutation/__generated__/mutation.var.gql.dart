// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:client/data/graphql/__generated__/schema.schema.gql.dart'
    as _i1;
import 'package:client/data/graphql/__generated__/serializers.gql.dart' as _i2;

part 'mutation.var.gql.g.dart';

abstract class GAddNewConnectionVars
    implements Built<GAddNewConnectionVars, GAddNewConnectionVarsBuilder> {
  GAddNewConnectionVars._();

  factory GAddNewConnectionVars(
          [void Function(GAddNewConnectionVarsBuilder b) updates]) =
      _$GAddNewConnectionVars;

  _i1.GAddNewConnectionByUserInput get input;
  static Serializer<GAddNewConnectionVars> get serializer =>
      _$gAddNewConnectionVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GAddNewConnectionVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAddNewConnectionVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GAddNewConnectionVars.serializer,
        json,
      );
}

abstract class GCreateNewMessageRoomVars
    implements
        Built<GCreateNewMessageRoomVars, GCreateNewMessageRoomVarsBuilder> {
  GCreateNewMessageRoomVars._();

  factory GCreateNewMessageRoomVars(
          [void Function(GCreateNewMessageRoomVarsBuilder b) updates]) =
      _$GCreateNewMessageRoomVars;

  _i1.GCreateNewMessageRoomInput get input;
  static Serializer<GCreateNewMessageRoomVars> get serializer =>
      _$gCreateNewMessageRoomVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GCreateNewMessageRoomVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateNewMessageRoomVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GCreateNewMessageRoomVars.serializer,
        json,
      );
}

abstract class GSendMessageVars
    implements Built<GSendMessageVars, GSendMessageVarsBuilder> {
  GSendMessageVars._();

  factory GSendMessageVars([void Function(GSendMessageVarsBuilder b) updates]) =
      _$GSendMessageVars;

  _i1.GSendMessageInput get input;
  static Serializer<GSendMessageVars> get serializer =>
      _$gSendMessageVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GSendMessageVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendMessageVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GSendMessageVars.serializer,
        json,
      );
}

abstract class GCreateNewOfferVars
    implements Built<GCreateNewOfferVars, GCreateNewOfferVarsBuilder> {
  GCreateNewOfferVars._();

  factory GCreateNewOfferVars(
          [void Function(GCreateNewOfferVarsBuilder b) updates]) =
      _$GCreateNewOfferVars;

  _i1.GCreateNewOfferInput get input;
  static Serializer<GCreateNewOfferVars> get serializer =>
      _$gCreateNewOfferVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GCreateNewOfferVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateNewOfferVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GCreateNewOfferVars.serializer,
        json,
      );
}

abstract class GUpdateOfferVars
    implements Built<GUpdateOfferVars, GUpdateOfferVarsBuilder> {
  GUpdateOfferVars._();

  factory GUpdateOfferVars([void Function(GUpdateOfferVarsBuilder b) updates]) =
      _$GUpdateOfferVars;

  _i1.GUpdateOfferInput get input;
  static Serializer<GUpdateOfferVars> get serializer =>
      _$gUpdateOfferVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GUpdateOfferVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateOfferVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GUpdateOfferVars.serializer,
        json,
      );
}

abstract class GDeleteOfferVars
    implements Built<GDeleteOfferVars, GDeleteOfferVarsBuilder> {
  GDeleteOfferVars._();

  factory GDeleteOfferVars([void Function(GDeleteOfferVarsBuilder b) updates]) =
      _$GDeleteOfferVars;

  _i1.GDeleteOfferInput get input;
  static Serializer<GDeleteOfferVars> get serializer =>
      _$gDeleteOfferVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GDeleteOfferVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GDeleteOfferVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GDeleteOfferVars.serializer,
        json,
      );
}

abstract class GCreateNewUserDataVars
    implements Built<GCreateNewUserDataVars, GCreateNewUserDataVarsBuilder> {
  GCreateNewUserDataVars._();

  factory GCreateNewUserDataVars(
          [void Function(GCreateNewUserDataVarsBuilder b) updates]) =
      _$GCreateNewUserDataVars;

  _i1.GCreateNewUserDataInput get input;
  static Serializer<GCreateNewUserDataVars> get serializer =>
      _$gCreateNewUserDataVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GCreateNewUserDataVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateNewUserDataVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GCreateNewUserDataVars.serializer,
        json,
      );
}

abstract class GUpdateUserDataVars
    implements Built<GUpdateUserDataVars, GUpdateUserDataVarsBuilder> {
  GUpdateUserDataVars._();

  factory GUpdateUserDataVars(
          [void Function(GUpdateUserDataVarsBuilder b) updates]) =
      _$GUpdateUserDataVars;

  _i1.GUpdateUserDataInput get input;
  static Serializer<GUpdateUserDataVars> get serializer =>
      _$gUpdateUserDataVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GUpdateUserDataVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateUserDataVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GUpdateUserDataVars.serializer,
        json,
      );
}

abstract class GUpdateBelongsToArtistStatusVars
    implements
        Built<GUpdateBelongsToArtistStatusVars,
            GUpdateBelongsToArtistStatusVarsBuilder> {
  GUpdateBelongsToArtistStatusVars._();

  factory GUpdateBelongsToArtistStatusVars(
          [void Function(GUpdateBelongsToArtistStatusVarsBuilder b) updates]) =
      _$GUpdateBelongsToArtistStatusVars;

  _i1.GUpdateBelongsToArtistStatusInput get input;
  static Serializer<GUpdateBelongsToArtistStatusVars> get serializer =>
      _$gUpdateBelongsToArtistStatusVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GUpdateBelongsToArtistStatusVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateBelongsToArtistStatusVars? fromJson(
          Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GUpdateBelongsToArtistStatusVars.serializer,
        json,
      );
}

abstract class GContactToAdminVars
    implements Built<GContactToAdminVars, GContactToAdminVarsBuilder> {
  GContactToAdminVars._();

  factory GContactToAdminVars(
          [void Function(GContactToAdminVarsBuilder b) updates]) =
      _$GContactToAdminVars;

  _i1.GContactToAdminInput get input;
  static Serializer<GContactToAdminVars> get serializer =>
      _$gContactToAdminVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GContactToAdminVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GContactToAdminVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GContactToAdminVars.serializer,
        json,
      );
}

abstract class GCreateNewNotificationVars
    implements
        Built<GCreateNewNotificationVars, GCreateNewNotificationVarsBuilder> {
  GCreateNewNotificationVars._();

  factory GCreateNewNotificationVars(
          [void Function(GCreateNewNotificationVarsBuilder b) updates]) =
      _$GCreateNewNotificationVars;

  _i1.GCreateNewNotificationInput get input;
  static Serializer<GCreateNewNotificationVars> get serializer =>
      _$gCreateNewNotificationVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GCreateNewNotificationVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateNewNotificationVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GCreateNewNotificationVars.serializer,
        json,
      );
}

abstract class GUpdateNotificationVars
    implements Built<GUpdateNotificationVars, GUpdateNotificationVarsBuilder> {
  GUpdateNotificationVars._();

  factory GUpdateNotificationVars(
          [void Function(GUpdateNotificationVarsBuilder b) updates]) =
      _$GUpdateNotificationVars;

  _i1.GUpdateNotificationInput get input;
  static Serializer<GUpdateNotificationVars> get serializer =>
      _$gUpdateNotificationVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GUpdateNotificationVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateNotificationVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GUpdateNotificationVars.serializer,
        json,
      );
}

abstract class GDeleteNotificationVars
    implements Built<GDeleteNotificationVars, GDeleteNotificationVarsBuilder> {
  GDeleteNotificationVars._();

  factory GDeleteNotificationVars(
          [void Function(GDeleteNotificationVarsBuilder b) updates]) =
      _$GDeleteNotificationVars;

  _i1.GDeleteNotificationInput get input;
  static Serializer<GDeleteNotificationVars> get serializer =>
      _$gDeleteNotificationVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GDeleteNotificationVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GDeleteNotificationVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GDeleteNotificationVars.serializer,
        json,
      );
}

abstract class GCreateFspTxVars
    implements Built<GCreateFspTxVars, GCreateFspTxVarsBuilder> {
  GCreateFspTxVars._();

  factory GCreateFspTxVars([void Function(GCreateFspTxVarsBuilder b) updates]) =
      _$GCreateFspTxVars;

  _i1.GCreateNewTransactionInput get input;
  static Serializer<GCreateFspTxVars> get serializer =>
      _$gCreateFspTxVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GCreateFspTxVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateFspTxVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GCreateFspTxVars.serializer,
        json,
      );
}

abstract class GCreateNewArtistVars
    implements Built<GCreateNewArtistVars, GCreateNewArtistVarsBuilder> {
  GCreateNewArtistVars._();

  factory GCreateNewArtistVars(
          [void Function(GCreateNewArtistVarsBuilder b) updates]) =
      _$GCreateNewArtistVars;

  _i1.GCreateNewArtistInput get input;
  static Serializer<GCreateNewArtistVars> get serializer =>
      _$gCreateNewArtistVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GCreateNewArtistVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateNewArtistVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GCreateNewArtistVars.serializer,
        json,
      );
}
