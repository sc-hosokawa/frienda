// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:client/graphql/__generated__/serializers.gql.dart' as _i1;

part 'schema.schema.gql.g.dart';

abstract class GAddNewConnectionInput
    implements Built<GAddNewConnectionInput, GAddNewConnectionInputBuilder> {
  GAddNewConnectionInput._();

  factory GAddNewConnectionInput(
          [void Function(GAddNewConnectionInputBuilder b) updates]) =
      _$GAddNewConnectionInput;

  String get userId;
  static Serializer<GAddNewConnectionInput> get serializer =>
      _$gAddNewConnectionInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAddNewConnectionInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAddNewConnectionInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAddNewConnectionInput.serializer,
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

  String get title;
  String get content;
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

  String get title;
  String get content;
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

abstract class GCreateNewUserDataInput
    implements Built<GCreateNewUserDataInput, GCreateNewUserDataInputBuilder> {
  GCreateNewUserDataInput._();

  factory GCreateNewUserDataInput(
          [void Function(GCreateNewUserDataInputBuilder b) updates]) =
      _$GCreateNewUserDataInput;

  String get email;
  String get firstName;
  String get lastName;
  String get imageUrl;
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

  String get id;
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

  String get title;
  String get content;
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

abstract class GUpdateNotificationInput
    implements
        Built<GUpdateNotificationInput, GUpdateNotificationInputBuilder> {
  GUpdateNotificationInput._();

  factory GUpdateNotificationInput(
          [void Function(GUpdateNotificationInputBuilder b) updates]) =
      _$GUpdateNotificationInput;

  String get id;
  String get title;
  String get content;
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
  String get title;
  String get content;
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

const Map<String, Set<String>> possibleTypesMap = {};
