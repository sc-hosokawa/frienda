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

  int get count;
  int get offset;
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

  String get userId;
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

abstract class GGetOverviewDataVars
    implements Built<GGetOverviewDataVars, GGetOverviewDataVarsBuilder> {
  GGetOverviewDataVars._();

  factory GGetOverviewDataVars(
          [void Function(GGetOverviewDataVarsBuilder b) updates]) =
      _$GGetOverviewDataVars;

  String? get artistId;
  static Serializer<GGetOverviewDataVars> get serializer =>
      _$gGetOverviewDataVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetOverviewDataVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOverviewDataVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetOverviewDataVars.serializer,
        json,
      );
}

abstract class GGetTrendingDataVars
    implements Built<GGetTrendingDataVars, GGetTrendingDataVarsBuilder> {
  GGetTrendingDataVars._();

  factory GGetTrendingDataVars(
          [void Function(GGetTrendingDataVarsBuilder b) updates]) =
      _$GGetTrendingDataVars;

  String? get artistId;
  static Serializer<GGetTrendingDataVars> get serializer =>
      _$gGetTrendingDataVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetTrendingDataVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetTrendingDataVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetTrendingDataVars.serializer,
        json,
      );
}

abstract class GGetLineChartDataVars
    implements Built<GGetLineChartDataVars, GGetLineChartDataVarsBuilder> {
  GGetLineChartDataVars._();

  factory GGetLineChartDataVars(
          [void Function(GGetLineChartDataVarsBuilder b) updates]) =
      _$GGetLineChartDataVars;

  String? get artistId;
  String? get isrc;
  String? get dsp;
  String? get period;
  static Serializer<GGetLineChartDataVars> get serializer =>
      _$gGetLineChartDataVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetLineChartDataVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetLineChartDataVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetLineChartDataVars.serializer,
        json,
      );
}

abstract class GGetPlaybacksByGenderDataVars
    implements
        Built<GGetPlaybacksByGenderDataVars,
            GGetPlaybacksByGenderDataVarsBuilder> {
  GGetPlaybacksByGenderDataVars._();

  factory GGetPlaybacksByGenderDataVars(
          [void Function(GGetPlaybacksByGenderDataVarsBuilder b) updates]) =
      _$GGetPlaybacksByGenderDataVars;

  String? get artistId;
  String? get isrc;
  String? get dsp;
  String? get period;
  static Serializer<GGetPlaybacksByGenderDataVars> get serializer =>
      _$gGetPlaybacksByGenderDataVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetPlaybacksByGenderDataVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetPlaybacksByGenderDataVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetPlaybacksByGenderDataVars.serializer,
        json,
      );
}

abstract class GGetPlaybacksByGenerationDataVars
    implements
        Built<GGetPlaybacksByGenerationDataVars,
            GGetPlaybacksByGenerationDataVarsBuilder> {
  GGetPlaybacksByGenerationDataVars._();

  factory GGetPlaybacksByGenerationDataVars(
          [void Function(GGetPlaybacksByGenerationDataVarsBuilder b) updates]) =
      _$GGetPlaybacksByGenerationDataVars;

  String? get artistId;
  String? get isrc;
  String? get dsp;
  String? get period;
  static Serializer<GGetPlaybacksByGenerationDataVars> get serializer =>
      _$gGetPlaybacksByGenerationDataVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetPlaybacksByGenerationDataVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetPlaybacksByGenerationDataVars? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetPlaybacksByGenerationDataVars.serializer,
        json,
      );
}

abstract class GGetCommunitiesVars
    implements Built<GGetCommunitiesVars, GGetCommunitiesVarsBuilder> {
  GGetCommunitiesVars._();

  factory GGetCommunitiesVars(
          [void Function(GGetCommunitiesVarsBuilder b) updates]) =
      _$GGetCommunitiesVars;

  static Serializer<GGetCommunitiesVars> get serializer =>
      _$gGetCommunitiesVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetCommunitiesVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetCommunitiesVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetCommunitiesVars.serializer,
        json,
      );
}

abstract class GGetOfferStatsByUserVars
    implements
        Built<GGetOfferStatsByUserVars, GGetOfferStatsByUserVarsBuilder> {
  GGetOfferStatsByUserVars._();

  factory GGetOfferStatsByUserVars(
          [void Function(GGetOfferStatsByUserVarsBuilder b) updates]) =
      _$GGetOfferStatsByUserVars;

  String get userId;
  static Serializer<GGetOfferStatsByUserVars> get serializer =>
      _$gGetOfferStatsByUserVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetOfferStatsByUserVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOfferStatsByUserVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetOfferStatsByUserVars.serializer,
        json,
      );
}

abstract class GGetOffersByOwnerVars
    implements Built<GGetOffersByOwnerVars, GGetOffersByOwnerVarsBuilder> {
  GGetOffersByOwnerVars._();

  factory GGetOffersByOwnerVars(
          [void Function(GGetOffersByOwnerVarsBuilder b) updates]) =
      _$GGetOffersByOwnerVars;

  String get ownerId;
  static Serializer<GGetOffersByOwnerVars> get serializer =>
      _$gGetOffersByOwnerVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetOffersByOwnerVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOffersByOwnerVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetOffersByOwnerVars.serializer,
        json,
      );
}

abstract class GGetOffersByStatusVars
    implements Built<GGetOffersByStatusVars, GGetOffersByStatusVarsBuilder> {
  GGetOffersByStatusVars._();

  factory GGetOffersByStatusVars(
          [void Function(GGetOffersByStatusVarsBuilder b) updates]) =
      _$GGetOffersByStatusVars;

  String get userId;
  static Serializer<GGetOffersByStatusVars> get serializer =>
      _$gGetOffersByStatusVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetOffersByStatusVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOffersByStatusVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetOffersByStatusVars.serializer,
        json,
      );
}

abstract class GGetOffersVars
    implements Built<GGetOffersVars, GGetOffersVarsBuilder> {
  GGetOffersVars._();

  factory GGetOffersVars([void Function(GGetOffersVarsBuilder b) updates]) =
      _$GGetOffersVars;

  int get count;
  static Serializer<GGetOffersVars> get serializer =>
      _$gGetOffersVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetOffersVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOffersVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetOffersVars.serializer,
        json,
      );
}

abstract class GGetOffersByCategoryVars
    implements
        Built<GGetOffersByCategoryVars, GGetOffersByCategoryVarsBuilder> {
  GGetOffersByCategoryVars._();

  factory GGetOffersByCategoryVars(
          [void Function(GGetOffersByCategoryVarsBuilder b) updates]) =
      _$GGetOffersByCategoryVars;

  String get category;
  static Serializer<GGetOffersByCategoryVars> get serializer =>
      _$gGetOffersByCategoryVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetOffersByCategoryVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOffersByCategoryVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetOffersByCategoryVars.serializer,
        json,
      );
}

abstract class GGetMessagesInProgressVars
    implements
        Built<GGetMessagesInProgressVars, GGetMessagesInProgressVarsBuilder> {
  GGetMessagesInProgressVars._();

  factory GGetMessagesInProgressVars(
          [void Function(GGetMessagesInProgressVarsBuilder b) updates]) =
      _$GGetMessagesInProgressVars;

  static Serializer<GGetMessagesInProgressVars> get serializer =>
      _$gGetMessagesInProgressVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMessagesInProgressVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMessagesInProgressVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetMessagesInProgressVars.serializer,
        json,
      );
}

abstract class GGetAllNotificationsVars
    implements
        Built<GGetAllNotificationsVars, GGetAllNotificationsVarsBuilder> {
  GGetAllNotificationsVars._();

  factory GGetAllNotificationsVars(
          [void Function(GGetAllNotificationsVarsBuilder b) updates]) =
      _$GGetAllNotificationsVars;

  static Serializer<GGetAllNotificationsVars> get serializer =>
      _$gGetAllNotificationsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetAllNotificationsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetAllNotificationsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetAllNotificationsVars.serializer,
        json,
      );
}

abstract class GGetBelongedArtistsVars
    implements Built<GGetBelongedArtistsVars, GGetBelongedArtistsVarsBuilder> {
  GGetBelongedArtistsVars._();

  factory GGetBelongedArtistsVars(
          [void Function(GGetBelongedArtistsVarsBuilder b) updates]) =
      _$GGetBelongedArtistsVars;

  String get userId;
  static Serializer<GGetBelongedArtistsVars> get serializer =>
      _$gGetBelongedArtistsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetBelongedArtistsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetBelongedArtistsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetBelongedArtistsVars.serializer,
        json,
      );
}

abstract class GGetAllArtistsVars
    implements Built<GGetAllArtistsVars, GGetAllArtistsVarsBuilder> {
  GGetAllArtistsVars._();

  factory GGetAllArtistsVars(
          [void Function(GGetAllArtistsVarsBuilder b) updates]) =
      _$GGetAllArtistsVars;

  static Serializer<GGetAllArtistsVars> get serializer =>
      _$gGetAllArtistsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetAllArtistsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetAllArtistsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetAllArtistsVars.serializer,
        json,
      );
}

abstract class GGetArtistByIdVars
    implements Built<GGetArtistByIdVars, GGetArtistByIdVarsBuilder> {
  GGetArtistByIdVars._();

  factory GGetArtistByIdVars(
          [void Function(GGetArtistByIdVarsBuilder b) updates]) =
      _$GGetArtistByIdVars;

  String get artistId;
  static Serializer<GGetArtistByIdVars> get serializer =>
      _$gGetArtistByIdVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetArtistByIdVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetArtistByIdVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetArtistByIdVars.serializer,
        json,
      );
}

abstract class GGetPopularPrizesVars
    implements Built<GGetPopularPrizesVars, GGetPopularPrizesVarsBuilder> {
  GGetPopularPrizesVars._();

  factory GGetPopularPrizesVars(
          [void Function(GGetPopularPrizesVarsBuilder b) updates]) =
      _$GGetPopularPrizesVars;

  static Serializer<GGetPopularPrizesVars> get serializer =>
      _$gGetPopularPrizesVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetPopularPrizesVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetPopularPrizesVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetPopularPrizesVars.serializer,
        json,
      );
}

abstract class GGetAllPrizesVars
    implements Built<GGetAllPrizesVars, GGetAllPrizesVarsBuilder> {
  GGetAllPrizesVars._();

  factory GGetAllPrizesVars(
          [void Function(GGetAllPrizesVarsBuilder b) updates]) =
      _$GGetAllPrizesVars;

  static Serializer<GGetAllPrizesVars> get serializer =>
      _$gGetAllPrizesVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetAllPrizesVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetAllPrizesVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetAllPrizesVars.serializer,
        json,
      );
}

abstract class GGetPrizeDetailVars
    implements Built<GGetPrizeDetailVars, GGetPrizeDetailVarsBuilder> {
  GGetPrizeDetailVars._();

  factory GGetPrizeDetailVars(
          [void Function(GGetPrizeDetailVarsBuilder b) updates]) =
      _$GGetPrizeDetailVars;

  int get prizeId;
  static Serializer<GGetPrizeDetailVars> get serializer =>
      _$gGetPrizeDetailVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetPrizeDetailVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetPrizeDetailVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetPrizeDetailVars.serializer,
        json,
      );
}

abstract class GGetFspHistoryVars
    implements Built<GGetFspHistoryVars, GGetFspHistoryVarsBuilder> {
  GGetFspHistoryVars._();

  factory GGetFspHistoryVars(
          [void Function(GGetFspHistoryVarsBuilder b) updates]) =
      _$GGetFspHistoryVars;

  String get userId;
  int get count;
  static Serializer<GGetFspHistoryVars> get serializer =>
      _$gGetFspHistoryVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetFspHistoryVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetFspHistoryVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetFspHistoryVars.serializer,
        json,
      );
}

abstract class GGetFspHistoryByUserVars
    implements
        Built<GGetFspHistoryByUserVars, GGetFspHistoryByUserVarsBuilder> {
  GGetFspHistoryByUserVars._();

  factory GGetFspHistoryByUserVars(
          [void Function(GGetFspHistoryByUserVarsBuilder b) updates]) =
      _$GGetFspHistoryByUserVars;

  String get userId;
  int get count;
  static Serializer<GGetFspHistoryByUserVars> get serializer =>
      _$gGetFspHistoryByUserVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetFspHistoryByUserVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetFspHistoryByUserVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetFspHistoryByUserVars.serializer,
        json,
      );
}
