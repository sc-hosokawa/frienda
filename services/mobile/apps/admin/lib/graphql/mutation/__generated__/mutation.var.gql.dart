// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:admin/graphql/__generated__/schema.schema.gql.dart' as _i1;
import 'package:admin/graphql/__generated__/serializers.gql.dart' as _i2;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mutation.var.gql.g.dart';

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

abstract class GUpdateOfferInfoVars
    implements Built<GUpdateOfferInfoVars, GUpdateOfferInfoVarsBuilder> {
  GUpdateOfferInfoVars._();

  factory GUpdateOfferInfoVars(
          [void Function(GUpdateOfferInfoVarsBuilder b) updates]) =
      _$GUpdateOfferInfoVars;

  _i1.GUpdateOfferInput get input;
  static Serializer<GUpdateOfferInfoVars> get serializer =>
      _$gUpdateOfferInfoVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GUpdateOfferInfoVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateOfferInfoVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GUpdateOfferInfoVars.serializer,
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
