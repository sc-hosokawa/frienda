// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:client/data/graphql/__generated__/serializers.gql.dart' as _i1;

part 'query.var.gql.g.dart';

abstract class GHealthCheckVars
    implements Built<GHealthCheckVars, GHealthCheckVarsBuilder> {
  GHealthCheckVars._();

  factory GHealthCheckVars([void Function(GHealthCheckVarsBuilder b) updates]) =
      _$GHealthCheckVars;

  static Serializer<GHealthCheckVars> get serializer =>
      _$gHealthCheckVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GHealthCheckVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GHealthCheckVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GHealthCheckVars.serializer,
        json,
      );
}

abstract class GGetUserInfoVars
    implements Built<GGetUserInfoVars, GGetUserInfoVarsBuilder> {
  GGetUserInfoVars._();

  factory GGetUserInfoVars([void Function(GGetUserInfoVarsBuilder b) updates]) =
      _$GGetUserInfoVars;

  static Serializer<GGetUserInfoVars> get serializer =>
      _$gGetUserInfoVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetUserInfoVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetUserInfoVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetUserInfoVars.serializer,
        json,
      );
}

abstract class GGetAllOffersVars
    implements Built<GGetAllOffersVars, GGetAllOffersVarsBuilder> {
  GGetAllOffersVars._();

  factory GGetAllOffersVars(
          [void Function(GGetAllOffersVarsBuilder b) updates]) =
      _$GGetAllOffersVars;

  static Serializer<GGetAllOffersVars> get serializer =>
      _$gGetAllOffersVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetAllOffersVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetAllOffersVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetAllOffersVars.serializer,
        json,
      );
}

abstract class GGetMessageRoomsVars
    implements Built<GGetMessageRoomsVars, GGetMessageRoomsVarsBuilder> {
  GGetMessageRoomsVars._();

  factory GGetMessageRoomsVars(
          [void Function(GGetMessageRoomsVarsBuilder b) updates]) =
      _$GGetMessageRoomsVars;

  static Serializer<GGetMessageRoomsVars> get serializer =>
      _$gGetMessageRoomsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMessageRoomsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMessageRoomsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetMessageRoomsVars.serializer,
        json,
      );
}

abstract class GGetMessagesByMessageRoomIdVars
    implements
        Built<GGetMessagesByMessageRoomIdVars,
            GGetMessagesByMessageRoomIdVarsBuilder> {
  GGetMessagesByMessageRoomIdVars._();

  factory GGetMessagesByMessageRoomIdVars(
          [void Function(GGetMessagesByMessageRoomIdVarsBuilder b) updates]) =
      _$GGetMessagesByMessageRoomIdVars;

  String get messageRoomId;
  static Serializer<GGetMessagesByMessageRoomIdVars> get serializer =>
      _$gGetMessagesByMessageRoomIdVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMessagesByMessageRoomIdVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMessagesByMessageRoomIdVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetMessagesByMessageRoomIdVars.serializer,
        json,
      );
}

abstract class GGetNotificationsVars
    implements Built<GGetNotificationsVars, GGetNotificationsVarsBuilder> {
  GGetNotificationsVars._();

  factory GGetNotificationsVars(
          [void Function(GGetNotificationsVarsBuilder b) updates]) =
      _$GGetNotificationsVars;

  static Serializer<GGetNotificationsVars> get serializer =>
      _$gGetNotificationsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetNotificationsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetNotificationsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetNotificationsVars.serializer,
        json,
      );
}

abstract class GGetUserDataVars
    implements Built<GGetUserDataVars, GGetUserDataVarsBuilder> {
  GGetUserDataVars._();

  factory GGetUserDataVars([void Function(GGetUserDataVarsBuilder b) updates]) =
      _$GGetUserDataVars;

  static Serializer<GGetUserDataVars> get serializer =>
      _$gGetUserDataVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetUserDataVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetUserDataVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetUserDataVars.serializer,
        json,
      );
}
