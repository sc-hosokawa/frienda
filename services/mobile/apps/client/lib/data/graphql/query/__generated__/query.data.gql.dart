// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:client/data/graphql/__generated__/schema.schema.gql.dart'
    as _i2;
import 'package:client/data/graphql/__generated__/serializers.gql.dart' as _i1;

part 'query.data.gql.g.dart';

abstract class GHealthCheckData
    implements Built<GHealthCheckData, GHealthCheckDataBuilder> {
  GHealthCheckData._();

  factory GHealthCheckData([void Function(GHealthCheckDataBuilder b) updates]) =
      _$GHealthCheckData;

  static void _initializeBuilder(GHealthCheckDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GHealthCheckData_healthCheck get healthCheck;
  static Serializer<GHealthCheckData> get serializer =>
      _$gHealthCheckDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GHealthCheckData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GHealthCheckData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GHealthCheckData.serializer,
        json,
      );
}

abstract class GHealthCheckData_healthCheck
    implements
        Built<GHealthCheckData_healthCheck,
            GHealthCheckData_healthCheckBuilder> {
  GHealthCheckData_healthCheck._();

  factory GHealthCheckData_healthCheck(
          [void Function(GHealthCheckData_healthCheckBuilder b) updates]) =
      _$GHealthCheckData_healthCheck;

  static void _initializeBuilder(GHealthCheckData_healthCheckBuilder b) =>
      b..G__typename = 'HealthCheck';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get status;
  static Serializer<GHealthCheckData_healthCheck> get serializer =>
      _$gHealthCheckDataHealthCheckSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GHealthCheckData_healthCheck.serializer,
        this,
      ) as Map<String, dynamic>);

  static GHealthCheckData_healthCheck? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GHealthCheckData_healthCheck.serializer,
        json,
      );
}

abstract class GGetOverviewDataData
    implements Built<GGetOverviewDataData, GGetOverviewDataDataBuilder> {
  GGetOverviewDataData._();

  factory GGetOverviewDataData(
          [void Function(GGetOverviewDataDataBuilder b) updates]) =
      _$GGetOverviewDataData;

  static void _initializeBuilder(GGetOverviewDataDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetOverviewDataData_getOverviewData get getOverviewData;
  static Serializer<GGetOverviewDataData> get serializer =>
      _$gGetOverviewDataDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetOverviewDataData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOverviewDataData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetOverviewDataData.serializer,
        json,
      );
}

abstract class GGetOverviewDataData_getOverviewData
    implements
        Built<GGetOverviewDataData_getOverviewData,
            GGetOverviewDataData_getOverviewDataBuilder> {
  GGetOverviewDataData_getOverviewData._();

  factory GGetOverviewDataData_getOverviewData(
      [void Function(GGetOverviewDataData_getOverviewDataBuilder b)
          updates]) = _$GGetOverviewDataData_getOverviewData;

  static void _initializeBuilder(
          GGetOverviewDataData_getOverviewDataBuilder b) =>
      b..G__typename = 'TotalOverviewData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get totalPlaybacks;
  int get weeklyPlaybacks;
  static Serializer<GGetOverviewDataData_getOverviewData> get serializer =>
      _$gGetOverviewDataDataGetOverviewDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetOverviewDataData_getOverviewData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOverviewDataData_getOverviewData? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetOverviewDataData_getOverviewData.serializer,
        json,
      );
}

abstract class GGetTrendingDataData
    implements Built<GGetTrendingDataData, GGetTrendingDataDataBuilder> {
  GGetTrendingDataData._();

  factory GGetTrendingDataData(
          [void Function(GGetTrendingDataDataBuilder b) updates]) =
      _$GGetTrendingDataData;

  static void _initializeBuilder(GGetTrendingDataDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetTrendingDataData_getTrendingData get getTrendingData;
  static Serializer<GGetTrendingDataData> get serializer =>
      _$gGetTrendingDataDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetTrendingDataData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetTrendingDataData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetTrendingDataData.serializer,
        json,
      );
}

abstract class GGetTrendingDataData_getTrendingData
    implements
        Built<GGetTrendingDataData_getTrendingData,
            GGetTrendingDataData_getTrendingDataBuilder> {
  GGetTrendingDataData_getTrendingData._();

  factory GGetTrendingDataData_getTrendingData(
      [void Function(GGetTrendingDataData_getTrendingDataBuilder b)
          updates]) = _$GGetTrendingDataData_getTrendingData;

  static void _initializeBuilder(
          GGetTrendingDataData_getTrendingDataBuilder b) =>
      b..G__typename = 'TrendingData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GGetTrendingDataData_getTrendingData_trendingTracks>
      get trendingTracks;
  static Serializer<GGetTrendingDataData_getTrendingData> get serializer =>
      _$gGetTrendingDataDataGetTrendingDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetTrendingDataData_getTrendingData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetTrendingDataData_getTrendingData? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetTrendingDataData_getTrendingData.serializer,
        json,
      );
}

abstract class GGetTrendingDataData_getTrendingData_trendingTracks
    implements
        Built<GGetTrendingDataData_getTrendingData_trendingTracks,
            GGetTrendingDataData_getTrendingData_trendingTracksBuilder> {
  GGetTrendingDataData_getTrendingData_trendingTracks._();

  factory GGetTrendingDataData_getTrendingData_trendingTracks(
      [void Function(
              GGetTrendingDataData_getTrendingData_trendingTracksBuilder b)
          updates]) = _$GGetTrendingDataData_getTrendingData_trendingTracks;

  static void _initializeBuilder(
          GGetTrendingDataData_getTrendingData_trendingTracksBuilder b) =>
      b..G__typename = 'TrackData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get isrc;
  String? get imgUrl;
  String get title;
  static Serializer<GGetTrendingDataData_getTrendingData_trendingTracks>
      get serializer =>
          _$gGetTrendingDataDataGetTrendingDataTrendingTracksSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetTrendingDataData_getTrendingData_trendingTracks.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetTrendingDataData_getTrendingData_trendingTracks? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetTrendingDataData_getTrendingData_trendingTracks.serializer,
        json,
      );
}

abstract class GGetLineChartDataData
    implements Built<GGetLineChartDataData, GGetLineChartDataDataBuilder> {
  GGetLineChartDataData._();

  factory GGetLineChartDataData(
          [void Function(GGetLineChartDataDataBuilder b) updates]) =
      _$GGetLineChartDataData;

  static void _initializeBuilder(GGetLineChartDataDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetLineChartDataData_getLineChartData get getLineChartData;
  static Serializer<GGetLineChartDataData> get serializer =>
      _$gGetLineChartDataDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetLineChartDataData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetLineChartDataData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetLineChartDataData.serializer,
        json,
      );
}

abstract class GGetLineChartDataData_getLineChartData
    implements
        Built<GGetLineChartDataData_getLineChartData,
            GGetLineChartDataData_getLineChartDataBuilder> {
  GGetLineChartDataData_getLineChartData._();

  factory GGetLineChartDataData_getLineChartData(
      [void Function(GGetLineChartDataData_getLineChartDataBuilder b)
          updates]) = _$GGetLineChartDataData_getLineChartData;

  static void _initializeBuilder(
          GGetLineChartDataData_getLineChartDataBuilder b) =>
      b..G__typename = 'ChartData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<int> get lineChartData;
  static Serializer<GGetLineChartDataData_getLineChartData> get serializer =>
      _$gGetLineChartDataDataGetLineChartDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetLineChartDataData_getLineChartData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetLineChartDataData_getLineChartData? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetLineChartDataData_getLineChartData.serializer,
        json,
      );
}

abstract class GGetPlaybacksByGenderDataData
    implements
        Built<GGetPlaybacksByGenderDataData,
            GGetPlaybacksByGenderDataDataBuilder> {
  GGetPlaybacksByGenderDataData._();

  factory GGetPlaybacksByGenderDataData(
          [void Function(GGetPlaybacksByGenderDataDataBuilder b) updates]) =
      _$GGetPlaybacksByGenderDataData;

  static void _initializeBuilder(GGetPlaybacksByGenderDataDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetPlaybacksByGenderDataData_getPlaybacksByGenderData
      get getPlaybacksByGenderData;
  static Serializer<GGetPlaybacksByGenderDataData> get serializer =>
      _$gGetPlaybacksByGenderDataDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetPlaybacksByGenderDataData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetPlaybacksByGenderDataData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetPlaybacksByGenderDataData.serializer,
        json,
      );
}

abstract class GGetPlaybacksByGenderDataData_getPlaybacksByGenderData
    implements
        Built<GGetPlaybacksByGenderDataData_getPlaybacksByGenderData,
            GGetPlaybacksByGenderDataData_getPlaybacksByGenderDataBuilder> {
  GGetPlaybacksByGenderDataData_getPlaybacksByGenderData._();

  factory GGetPlaybacksByGenderDataData_getPlaybacksByGenderData(
      [void Function(
              GGetPlaybacksByGenderDataData_getPlaybacksByGenderDataBuilder b)
          updates]) = _$GGetPlaybacksByGenderDataData_getPlaybacksByGenderData;

  static void _initializeBuilder(
          GGetPlaybacksByGenderDataData_getPlaybacksByGenderDataBuilder b) =>
      b..G__typename = 'PlaybacksByGenderData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get malePlaybacks;
  int get femalePlaybacks;
  int get unknownPlaybacks;
  static Serializer<GGetPlaybacksByGenderDataData_getPlaybacksByGenderData>
      get serializer =>
          _$gGetPlaybacksByGenderDataDataGetPlaybacksByGenderDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetPlaybacksByGenderDataData_getPlaybacksByGenderData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetPlaybacksByGenderDataData_getPlaybacksByGenderData? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetPlaybacksByGenderDataData_getPlaybacksByGenderData.serializer,
        json,
      );
}

abstract class GGetPlaybacksByGenerationDataData
    implements
        Built<GGetPlaybacksByGenerationDataData,
            GGetPlaybacksByGenerationDataDataBuilder> {
  GGetPlaybacksByGenerationDataData._();

  factory GGetPlaybacksByGenerationDataData(
          [void Function(GGetPlaybacksByGenerationDataDataBuilder b) updates]) =
      _$GGetPlaybacksByGenerationDataData;

  static void _initializeBuilder(GGetPlaybacksByGenerationDataDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetPlaybacksByGenerationDataData_getPlaybacksByGenerationData
      get getPlaybacksByGenerationData;
  static Serializer<GGetPlaybacksByGenerationDataData> get serializer =>
      _$gGetPlaybacksByGenerationDataDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetPlaybacksByGenerationDataData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetPlaybacksByGenerationDataData? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetPlaybacksByGenerationDataData.serializer,
        json,
      );
}

abstract class GGetPlaybacksByGenerationDataData_getPlaybacksByGenerationData
    implements
        Built<GGetPlaybacksByGenerationDataData_getPlaybacksByGenerationData,
            GGetPlaybacksByGenerationDataData_getPlaybacksByGenerationDataBuilder> {
  GGetPlaybacksByGenerationDataData_getPlaybacksByGenerationData._();

  factory GGetPlaybacksByGenerationDataData_getPlaybacksByGenerationData(
          [void Function(
                  GGetPlaybacksByGenerationDataData_getPlaybacksByGenerationDataBuilder
                      b)
              updates]) =
      _$GGetPlaybacksByGenerationDataData_getPlaybacksByGenerationData;

  static void _initializeBuilder(
          GGetPlaybacksByGenerationDataData_getPlaybacksByGenerationDataBuilder
              b) =>
      b..G__typename = 'PlaybacksByGenerationData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get playbacksOver60;
  int get playbacks50S;
  int get playbacks40S;
  int get playbacks30S;
  int get playbacks20S;
  int get playbacksUnder10S;
  static Serializer<
          GGetPlaybacksByGenerationDataData_getPlaybacksByGenerationData>
      get serializer =>
          _$gGetPlaybacksByGenerationDataDataGetPlaybacksByGenerationDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetPlaybacksByGenerationDataData_getPlaybacksByGenerationData
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetPlaybacksByGenerationDataData_getPlaybacksByGenerationData?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetPlaybacksByGenerationDataData_getPlaybacksByGenerationData
                .serializer,
            json,
          );
}

abstract class GGetCommunitiesData
    implements Built<GGetCommunitiesData, GGetCommunitiesDataBuilder> {
  GGetCommunitiesData._();

  factory GGetCommunitiesData(
          [void Function(GGetCommunitiesDataBuilder b) updates]) =
      _$GGetCommunitiesData;

  static void _initializeBuilder(GGetCommunitiesDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetCommunitiesData_getCommunities get getCommunities;
  static Serializer<GGetCommunitiesData> get serializer =>
      _$gGetCommunitiesDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetCommunitiesData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetCommunitiesData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetCommunitiesData.serializer,
        json,
      );
}

abstract class GGetCommunitiesData_getCommunities
    implements
        Built<GGetCommunitiesData_getCommunities,
            GGetCommunitiesData_getCommunitiesBuilder> {
  GGetCommunitiesData_getCommunities._();

  factory GGetCommunitiesData_getCommunities(
      [void Function(GGetCommunitiesData_getCommunitiesBuilder b)
          updates]) = _$GGetCommunitiesData_getCommunities;

  static void _initializeBuilder(GGetCommunitiesData_getCommunitiesBuilder b) =>
      b..G__typename = 'ConnectedUsersData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GGetCommunitiesData_getCommunities_connectedUserList>
      get connectedUserList;
  int? get countOfUsers;
  static Serializer<GGetCommunitiesData_getCommunities> get serializer =>
      _$gGetCommunitiesDataGetCommunitiesSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetCommunitiesData_getCommunities.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetCommunitiesData_getCommunities? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetCommunitiesData_getCommunities.serializer,
        json,
      );
}

abstract class GGetCommunitiesData_getCommunities_connectedUserList
    implements
        Built<GGetCommunitiesData_getCommunities_connectedUserList,
            GGetCommunitiesData_getCommunities_connectedUserListBuilder> {
  GGetCommunitiesData_getCommunities_connectedUserList._();

  factory GGetCommunitiesData_getCommunities_connectedUserList(
      [void Function(
              GGetCommunitiesData_getCommunities_connectedUserListBuilder b)
          updates]) = _$GGetCommunitiesData_getCommunities_connectedUserList;

  static void _initializeBuilder(
          GGetCommunitiesData_getCommunities_connectedUserListBuilder b) =>
      b..G__typename = 'ConnectedUserByUserData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  GGetCommunitiesData_getCommunities_connectedUserList_connectedUser
      get connectedUser;
  static Serializer<GGetCommunitiesData_getCommunities_connectedUserList>
      get serializer =>
          _$gGetCommunitiesDataGetCommunitiesConnectedUserListSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetCommunitiesData_getCommunities_connectedUserList.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetCommunitiesData_getCommunities_connectedUserList? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetCommunitiesData_getCommunities_connectedUserList.serializer,
        json,
      );
}

abstract class GGetCommunitiesData_getCommunities_connectedUserList_connectedUser
    implements
        Built<
            GGetCommunitiesData_getCommunities_connectedUserList_connectedUser,
            GGetCommunitiesData_getCommunities_connectedUserList_connectedUserBuilder> {
  GGetCommunitiesData_getCommunities_connectedUserList_connectedUser._();

  factory GGetCommunitiesData_getCommunities_connectedUserList_connectedUser(
          [void Function(
                  GGetCommunitiesData_getCommunities_connectedUserList_connectedUserBuilder
                      b)
              updates]) =
      _$GGetCommunitiesData_getCommunities_connectedUserList_connectedUser;

  static void _initializeBuilder(
          GGetCommunitiesData_getCommunities_connectedUserList_connectedUserBuilder
              b) =>
      b..G__typename = 'UserBasicData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get name;
  String? get imageUrl;
  String get role;
  String get primaryRole;
  GGetCommunitiesData_getCommunities_connectedUserList_connectedUser_primaryArtist?
      get primaryArtist;
  static Serializer<
          GGetCommunitiesData_getCommunities_connectedUserList_connectedUser>
      get serializer =>
          _$gGetCommunitiesDataGetCommunitiesConnectedUserListConnectedUserSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetCommunitiesData_getCommunities_connectedUserList_connectedUser
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetCommunitiesData_getCommunities_connectedUserList_connectedUser?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetCommunitiesData_getCommunities_connectedUserList_connectedUser
                .serializer,
            json,
          );
}

abstract class GGetCommunitiesData_getCommunities_connectedUserList_connectedUser_primaryArtist
    implements
        Built<
            GGetCommunitiesData_getCommunities_connectedUserList_connectedUser_primaryArtist,
            GGetCommunitiesData_getCommunities_connectedUserList_connectedUser_primaryArtistBuilder> {
  GGetCommunitiesData_getCommunities_connectedUserList_connectedUser_primaryArtist._();

  factory GGetCommunitiesData_getCommunities_connectedUserList_connectedUser_primaryArtist(
          [void Function(
                  GGetCommunitiesData_getCommunities_connectedUserList_connectedUser_primaryArtistBuilder
                      b)
              updates]) =
      _$GGetCommunitiesData_getCommunities_connectedUserList_connectedUser_primaryArtist;

  static void _initializeBuilder(
          GGetCommunitiesData_getCommunities_connectedUserList_connectedUser_primaryArtistBuilder
              b) =>
      b..G__typename = 'ArtistByUserData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get name;
  String? get imageUrl;
  int get fsp;
  String get status;
  bool get isAdmin;
  static Serializer<
          GGetCommunitiesData_getCommunities_connectedUserList_connectedUser_primaryArtist>
      get serializer =>
          _$gGetCommunitiesDataGetCommunitiesConnectedUserListConnectedUserPrimaryArtistSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetCommunitiesData_getCommunities_connectedUserList_connectedUser_primaryArtist
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetCommunitiesData_getCommunities_connectedUserList_connectedUser_primaryArtist?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetCommunitiesData_getCommunities_connectedUserList_connectedUser_primaryArtist
                .serializer,
            json,
          );
}

abstract class GGetUserInfoData
    implements Built<GGetUserInfoData, GGetUserInfoDataBuilder> {
  GGetUserInfoData._();

  factory GGetUserInfoData([void Function(GGetUserInfoDataBuilder b) updates]) =
      _$GGetUserInfoData;

  static void _initializeBuilder(GGetUserInfoDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetUserInfoData_getUserInfo get getUserInfo;
  static Serializer<GGetUserInfoData> get serializer =>
      _$gGetUserInfoDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetUserInfoData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetUserInfoData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetUserInfoData.serializer,
        json,
      );
}

abstract class GGetUserInfoData_getUserInfo
    implements
        Built<GGetUserInfoData_getUserInfo,
            GGetUserInfoData_getUserInfoBuilder> {
  GGetUserInfoData_getUserInfo._();

  factory GGetUserInfoData_getUserInfo(
          [void Function(GGetUserInfoData_getUserInfoBuilder b) updates]) =
      _$GGetUserInfoData_getUserInfo;

  static void _initializeBuilder(GGetUserInfoData_getUserInfoBuilder b) =>
      b..G__typename = 'UserFullData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetUserInfoData_getUserInfo_userInfo get userInfo;
  static Serializer<GGetUserInfoData_getUserInfo> get serializer =>
      _$gGetUserInfoDataGetUserInfoSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetUserInfoData_getUserInfo.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetUserInfoData_getUserInfo? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetUserInfoData_getUserInfo.serializer,
        json,
      );
}

abstract class GGetUserInfoData_getUserInfo_userInfo
    implements
        Built<GGetUserInfoData_getUserInfo_userInfo,
            GGetUserInfoData_getUserInfo_userInfoBuilder> {
  GGetUserInfoData_getUserInfo_userInfo._();

  factory GGetUserInfoData_getUserInfo_userInfo(
      [void Function(GGetUserInfoData_getUserInfo_userInfoBuilder b)
          updates]) = _$GGetUserInfoData_getUserInfo_userInfo;

  static void _initializeBuilder(
          GGetUserInfoData_getUserInfo_userInfoBuilder b) =>
      b..G__typename = 'UserDetailData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get email;
  String get name;
  String? get imageUrl;
  int get fspBalance;
  int get credentialBalance;
  String get role;
  String get primaryRole;
  BuiltList<GGetUserInfoData_getUserInfo_userInfo_belongsToArtists>
      get belongsToArtists;
  GGetUserInfoData_getUserInfo_userInfo_primaryArtist? get primaryArtist;
  static Serializer<GGetUserInfoData_getUserInfo_userInfo> get serializer =>
      _$gGetUserInfoDataGetUserInfoUserInfoSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetUserInfoData_getUserInfo_userInfo.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetUserInfoData_getUserInfo_userInfo? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetUserInfoData_getUserInfo_userInfo.serializer,
        json,
      );
}

abstract class GGetUserInfoData_getUserInfo_userInfo_belongsToArtists
    implements
        Built<GGetUserInfoData_getUserInfo_userInfo_belongsToArtists,
            GGetUserInfoData_getUserInfo_userInfo_belongsToArtistsBuilder> {
  GGetUserInfoData_getUserInfo_userInfo_belongsToArtists._();

  factory GGetUserInfoData_getUserInfo_userInfo_belongsToArtists(
      [void Function(
              GGetUserInfoData_getUserInfo_userInfo_belongsToArtistsBuilder b)
          updates]) = _$GGetUserInfoData_getUserInfo_userInfo_belongsToArtists;

  static void _initializeBuilder(
          GGetUserInfoData_getUserInfo_userInfo_belongsToArtistsBuilder b) =>
      b..G__typename = 'ArtistByUserData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get name;
  String? get imageUrl;
  int get fsp;
  String get status;
  bool get isAdmin;
  static Serializer<GGetUserInfoData_getUserInfo_userInfo_belongsToArtists>
      get serializer =>
          _$gGetUserInfoDataGetUserInfoUserInfoBelongsToArtistsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetUserInfoData_getUserInfo_userInfo_belongsToArtists.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetUserInfoData_getUserInfo_userInfo_belongsToArtists? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetUserInfoData_getUserInfo_userInfo_belongsToArtists.serializer,
        json,
      );
}

abstract class GGetUserInfoData_getUserInfo_userInfo_primaryArtist
    implements
        Built<GGetUserInfoData_getUserInfo_userInfo_primaryArtist,
            GGetUserInfoData_getUserInfo_userInfo_primaryArtistBuilder> {
  GGetUserInfoData_getUserInfo_userInfo_primaryArtist._();

  factory GGetUserInfoData_getUserInfo_userInfo_primaryArtist(
      [void Function(
              GGetUserInfoData_getUserInfo_userInfo_primaryArtistBuilder b)
          updates]) = _$GGetUserInfoData_getUserInfo_userInfo_primaryArtist;

  static void _initializeBuilder(
          GGetUserInfoData_getUserInfo_userInfo_primaryArtistBuilder b) =>
      b..G__typename = 'ArtistByUserData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get name;
  String? get imageUrl;
  int get fsp;
  String get status;
  bool get isAdmin;
  static Serializer<GGetUserInfoData_getUserInfo_userInfo_primaryArtist>
      get serializer =>
          _$gGetUserInfoDataGetUserInfoUserInfoPrimaryArtistSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetUserInfoData_getUserInfo_userInfo_primaryArtist.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetUserInfoData_getUserInfo_userInfo_primaryArtist? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetUserInfoData_getUserInfo_userInfo_primaryArtist.serializer,
        json,
      );
}

abstract class GGetOfferStatsByUserData
    implements
        Built<GGetOfferStatsByUserData, GGetOfferStatsByUserDataBuilder> {
  GGetOfferStatsByUserData._();

  factory GGetOfferStatsByUserData(
          [void Function(GGetOfferStatsByUserDataBuilder b) updates]) =
      _$GGetOfferStatsByUserData;

  static void _initializeBuilder(GGetOfferStatsByUserDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetOfferStatsByUserData_getOfferStatsByUser get getOfferStatsByUser;
  static Serializer<GGetOfferStatsByUserData> get serializer =>
      _$gGetOfferStatsByUserDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetOfferStatsByUserData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOfferStatsByUserData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetOfferStatsByUserData.serializer,
        json,
      );
}

abstract class GGetOfferStatsByUserData_getOfferStatsByUser
    implements
        Built<GGetOfferStatsByUserData_getOfferStatsByUser,
            GGetOfferStatsByUserData_getOfferStatsByUserBuilder> {
  GGetOfferStatsByUserData_getOfferStatsByUser._();

  factory GGetOfferStatsByUserData_getOfferStatsByUser(
      [void Function(GGetOfferStatsByUserData_getOfferStatsByUserBuilder b)
          updates]) = _$GGetOfferStatsByUserData_getOfferStatsByUser;

  static void _initializeBuilder(
          GGetOfferStatsByUserData_getOfferStatsByUserBuilder b) =>
      b..G__typename = 'OfferStatsByUserData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get totalOffers;
  int get ongoingOffers;
  int get appliedOffers;
  int get completedOffers;
  int get totalEarnings;
  static Serializer<GGetOfferStatsByUserData_getOfferStatsByUser>
      get serializer => _$gGetOfferStatsByUserDataGetOfferStatsByUserSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetOfferStatsByUserData_getOfferStatsByUser.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOfferStatsByUserData_getOfferStatsByUser? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetOfferStatsByUserData_getOfferStatsByUser.serializer,
        json,
      );
}

abstract class GGetOffersByOwnerData
    implements Built<GGetOffersByOwnerData, GGetOffersByOwnerDataBuilder> {
  GGetOffersByOwnerData._();

  factory GGetOffersByOwnerData(
          [void Function(GGetOffersByOwnerDataBuilder b) updates]) =
      _$GGetOffersByOwnerData;

  static void _initializeBuilder(GGetOffersByOwnerDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetOffersByOwnerData_getOffersByOwner get getOffersByOwner;
  static Serializer<GGetOffersByOwnerData> get serializer =>
      _$gGetOffersByOwnerDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetOffersByOwnerData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOffersByOwnerData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetOffersByOwnerData.serializer,
        json,
      );
}

abstract class GGetOffersByOwnerData_getOffersByOwner
    implements
        Built<GGetOffersByOwnerData_getOffersByOwner,
            GGetOffersByOwnerData_getOffersByOwnerBuilder> {
  GGetOffersByOwnerData_getOffersByOwner._();

  factory GGetOffersByOwnerData_getOffersByOwner(
      [void Function(GGetOffersByOwnerData_getOffersByOwnerBuilder b)
          updates]) = _$GGetOffersByOwnerData_getOffersByOwner;

  static void _initializeBuilder(
          GGetOffersByOwnerData_getOffersByOwnerBuilder b) =>
      b..G__typename = 'OffersData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GGetOffersByOwnerData_getOffersByOwner_offerList> get offerList;
  static Serializer<GGetOffersByOwnerData_getOffersByOwner> get serializer =>
      _$gGetOffersByOwnerDataGetOffersByOwnerSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetOffersByOwnerData_getOffersByOwner.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOffersByOwnerData_getOffersByOwner? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetOffersByOwnerData_getOffersByOwner.serializer,
        json,
      );
}

abstract class GGetOffersByOwnerData_getOffersByOwner_offerList
    implements
        Built<GGetOffersByOwnerData_getOffersByOwner_offerList,
            GGetOffersByOwnerData_getOffersByOwner_offerListBuilder> {
  GGetOffersByOwnerData_getOffersByOwner_offerList._();

  factory GGetOffersByOwnerData_getOffersByOwner_offerList(
      [void Function(GGetOffersByOwnerData_getOffersByOwner_offerListBuilder b)
          updates]) = _$GGetOffersByOwnerData_getOffersByOwner_offerList;

  static void _initializeBuilder(
          GGetOffersByOwnerData_getOffersByOwner_offerListBuilder b) =>
      b..G__typename = 'OfferData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String get title;
  String get description;
  String? get imageUrl;
  int get fee;
  String? get category;
  static Serializer<GGetOffersByOwnerData_getOffersByOwner_offerList>
      get serializer =>
          _$gGetOffersByOwnerDataGetOffersByOwnerOfferListSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetOffersByOwnerData_getOffersByOwner_offerList.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOffersByOwnerData_getOffersByOwner_offerList? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetOffersByOwnerData_getOffersByOwner_offerList.serializer,
        json,
      );
}

abstract class GGetOffersByStatusData
    implements Built<GGetOffersByStatusData, GGetOffersByStatusDataBuilder> {
  GGetOffersByStatusData._();

  factory GGetOffersByStatusData(
          [void Function(GGetOffersByStatusDataBuilder b) updates]) =
      _$GGetOffersByStatusData;

  static void _initializeBuilder(GGetOffersByStatusDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetOffersByStatusData_getOffersByStatus get getOffersByStatus;
  static Serializer<GGetOffersByStatusData> get serializer =>
      _$gGetOffersByStatusDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetOffersByStatusData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOffersByStatusData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetOffersByStatusData.serializer,
        json,
      );
}

abstract class GGetOffersByStatusData_getOffersByStatus
    implements
        Built<GGetOffersByStatusData_getOffersByStatus,
            GGetOffersByStatusData_getOffersByStatusBuilder> {
  GGetOffersByStatusData_getOffersByStatus._();

  factory GGetOffersByStatusData_getOffersByStatus(
      [void Function(GGetOffersByStatusData_getOffersByStatusBuilder b)
          updates]) = _$GGetOffersByStatusData_getOffersByStatus;

  static void _initializeBuilder(
          GGetOffersByStatusData_getOffersByStatusBuilder b) =>
      b..G__typename = 'OfferByStatusData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GGetOffersByStatusData_getOffersByStatus_inprogressOffers>
      get inprogressOffers;
  BuiltList<GGetOffersByStatusData_getOffersByStatus_appliedOffers>
      get appliedOffers;
  static Serializer<GGetOffersByStatusData_getOffersByStatus> get serializer =>
      _$gGetOffersByStatusDataGetOffersByStatusSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetOffersByStatusData_getOffersByStatus.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOffersByStatusData_getOffersByStatus? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetOffersByStatusData_getOffersByStatus.serializer,
        json,
      );
}

abstract class GGetOffersByStatusData_getOffersByStatus_inprogressOffers
    implements
        Built<GGetOffersByStatusData_getOffersByStatus_inprogressOffers,
            GGetOffersByStatusData_getOffersByStatus_inprogressOffersBuilder> {
  GGetOffersByStatusData_getOffersByStatus_inprogressOffers._();

  factory GGetOffersByStatusData_getOffersByStatus_inprogressOffers(
      [void Function(
              GGetOffersByStatusData_getOffersByStatus_inprogressOffersBuilder
                  b)
          updates]) = _$GGetOffersByStatusData_getOffersByStatus_inprogressOffers;

  static void _initializeBuilder(
          GGetOffersByStatusData_getOffersByStatus_inprogressOffersBuilder b) =>
      b..G__typename = 'OfferData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String get title;
  String get description;
  String? get imageUrl;
  int get fee;
  String? get category;
  static Serializer<GGetOffersByStatusData_getOffersByStatus_inprogressOffers>
      get serializer =>
          _$gGetOffersByStatusDataGetOffersByStatusInprogressOffersSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetOffersByStatusData_getOffersByStatus_inprogressOffers.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOffersByStatusData_getOffersByStatus_inprogressOffers? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetOffersByStatusData_getOffersByStatus_inprogressOffers.serializer,
        json,
      );
}

abstract class GGetOffersByStatusData_getOffersByStatus_appliedOffers
    implements
        Built<GGetOffersByStatusData_getOffersByStatus_appliedOffers,
            GGetOffersByStatusData_getOffersByStatus_appliedOffersBuilder> {
  GGetOffersByStatusData_getOffersByStatus_appliedOffers._();

  factory GGetOffersByStatusData_getOffersByStatus_appliedOffers(
      [void Function(
              GGetOffersByStatusData_getOffersByStatus_appliedOffersBuilder b)
          updates]) = _$GGetOffersByStatusData_getOffersByStatus_appliedOffers;

  static void _initializeBuilder(
          GGetOffersByStatusData_getOffersByStatus_appliedOffersBuilder b) =>
      b..G__typename = 'OfferData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String get title;
  String get description;
  String? get imageUrl;
  int get fee;
  String? get category;
  static Serializer<GGetOffersByStatusData_getOffersByStatus_appliedOffers>
      get serializer =>
          _$gGetOffersByStatusDataGetOffersByStatusAppliedOffersSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetOffersByStatusData_getOffersByStatus_appliedOffers.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOffersByStatusData_getOffersByStatus_appliedOffers? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetOffersByStatusData_getOffersByStatus_appliedOffers.serializer,
        json,
      );
}

abstract class GGetOffersData
    implements Built<GGetOffersData, GGetOffersDataBuilder> {
  GGetOffersData._();

  factory GGetOffersData([void Function(GGetOffersDataBuilder b) updates]) =
      _$GGetOffersData;

  static void _initializeBuilder(GGetOffersDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetOffersData_getOffers get getOffers;
  static Serializer<GGetOffersData> get serializer =>
      _$gGetOffersDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetOffersData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOffersData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetOffersData.serializer,
        json,
      );
}

abstract class GGetOffersData_getOffers
    implements
        Built<GGetOffersData_getOffers, GGetOffersData_getOffersBuilder> {
  GGetOffersData_getOffers._();

  factory GGetOffersData_getOffers(
          [void Function(GGetOffersData_getOffersBuilder b) updates]) =
      _$GGetOffersData_getOffers;

  static void _initializeBuilder(GGetOffersData_getOffersBuilder b) =>
      b..G__typename = 'OffersData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GGetOffersData_getOffers_offerList> get offerList;
  static Serializer<GGetOffersData_getOffers> get serializer =>
      _$gGetOffersDataGetOffersSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetOffersData_getOffers.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOffersData_getOffers? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetOffersData_getOffers.serializer,
        json,
      );
}

abstract class GGetOffersData_getOffers_offerList
    implements
        Built<GGetOffersData_getOffers_offerList,
            GGetOffersData_getOffers_offerListBuilder> {
  GGetOffersData_getOffers_offerList._();

  factory GGetOffersData_getOffers_offerList(
      [void Function(GGetOffersData_getOffers_offerListBuilder b)
          updates]) = _$GGetOffersData_getOffers_offerList;

  static void _initializeBuilder(GGetOffersData_getOffers_offerListBuilder b) =>
      b..G__typename = 'OfferData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String get title;
  String get description;
  String? get imageUrl;
  int get fee;
  String? get category;
  static Serializer<GGetOffersData_getOffers_offerList> get serializer =>
      _$gGetOffersDataGetOffersOfferListSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetOffersData_getOffers_offerList.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOffersData_getOffers_offerList? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetOffersData_getOffers_offerList.serializer,
        json,
      );
}

abstract class GGetAllOffersData
    implements Built<GGetAllOffersData, GGetAllOffersDataBuilder> {
  GGetAllOffersData._();

  factory GGetAllOffersData(
          [void Function(GGetAllOffersDataBuilder b) updates]) =
      _$GGetAllOffersData;

  static void _initializeBuilder(GGetAllOffersDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GGetAllOffersData_getAllOffers> get getAllOffers;
  static Serializer<GGetAllOffersData> get serializer =>
      _$gGetAllOffersDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetAllOffersData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetAllOffersData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetAllOffersData.serializer,
        json,
      );
}

abstract class GGetAllOffersData_getAllOffers
    implements
        Built<GGetAllOffersData_getAllOffers,
            GGetAllOffersData_getAllOffersBuilder> {
  GGetAllOffersData_getAllOffers._();

  factory GGetAllOffersData_getAllOffers(
          [void Function(GGetAllOffersData_getAllOffersBuilder b) updates]) =
      _$GGetAllOffersData_getAllOffers;

  static void _initializeBuilder(GGetAllOffersData_getAllOffersBuilder b) =>
      b..G__typename = 'OfferData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String get title;
  String get description;
  String? get imageUrl;
  int get fee;
  String? get category;
  static Serializer<GGetAllOffersData_getAllOffers> get serializer =>
      _$gGetAllOffersDataGetAllOffersSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetAllOffersData_getAllOffers.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetAllOffersData_getAllOffers? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetAllOffersData_getAllOffers.serializer,
        json,
      );
}

abstract class GGetOffersByCategoryData
    implements
        Built<GGetOffersByCategoryData, GGetOffersByCategoryDataBuilder> {
  GGetOffersByCategoryData._();

  factory GGetOffersByCategoryData(
          [void Function(GGetOffersByCategoryDataBuilder b) updates]) =
      _$GGetOffersByCategoryData;

  static void _initializeBuilder(GGetOffersByCategoryDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetOffersByCategoryData_getOffersByCategory get getOffersByCategory;
  static Serializer<GGetOffersByCategoryData> get serializer =>
      _$gGetOffersByCategoryDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetOffersByCategoryData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOffersByCategoryData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetOffersByCategoryData.serializer,
        json,
      );
}

abstract class GGetOffersByCategoryData_getOffersByCategory
    implements
        Built<GGetOffersByCategoryData_getOffersByCategory,
            GGetOffersByCategoryData_getOffersByCategoryBuilder> {
  GGetOffersByCategoryData_getOffersByCategory._();

  factory GGetOffersByCategoryData_getOffersByCategory(
      [void Function(GGetOffersByCategoryData_getOffersByCategoryBuilder b)
          updates]) = _$GGetOffersByCategoryData_getOffersByCategory;

  static void _initializeBuilder(
          GGetOffersByCategoryData_getOffersByCategoryBuilder b) =>
      b..G__typename = 'OffersData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GGetOffersByCategoryData_getOffersByCategory_offerList>
      get offerList;
  static Serializer<GGetOffersByCategoryData_getOffersByCategory>
      get serializer => _$gGetOffersByCategoryDataGetOffersByCategorySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetOffersByCategoryData_getOffersByCategory.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOffersByCategoryData_getOffersByCategory? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetOffersByCategoryData_getOffersByCategory.serializer,
        json,
      );
}

abstract class GGetOffersByCategoryData_getOffersByCategory_offerList
    implements
        Built<GGetOffersByCategoryData_getOffersByCategory_offerList,
            GGetOffersByCategoryData_getOffersByCategory_offerListBuilder> {
  GGetOffersByCategoryData_getOffersByCategory_offerList._();

  factory GGetOffersByCategoryData_getOffersByCategory_offerList(
      [void Function(
              GGetOffersByCategoryData_getOffersByCategory_offerListBuilder b)
          updates]) = _$GGetOffersByCategoryData_getOffersByCategory_offerList;

  static void _initializeBuilder(
          GGetOffersByCategoryData_getOffersByCategory_offerListBuilder b) =>
      b..G__typename = 'OfferData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String get title;
  String get description;
  String? get imageUrl;
  int get fee;
  String? get category;
  static Serializer<GGetOffersByCategoryData_getOffersByCategory_offerList>
      get serializer =>
          _$gGetOffersByCategoryDataGetOffersByCategoryOfferListSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetOffersByCategoryData_getOffersByCategory_offerList.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOffersByCategoryData_getOffersByCategory_offerList? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetOffersByCategoryData_getOffersByCategory_offerList.serializer,
        json,
      );
}

abstract class GGetMessageRoomsData
    implements Built<GGetMessageRoomsData, GGetMessageRoomsDataBuilder> {
  GGetMessageRoomsData._();

  factory GGetMessageRoomsData(
          [void Function(GGetMessageRoomsDataBuilder b) updates]) =
      _$GGetMessageRoomsData;

  static void _initializeBuilder(GGetMessageRoomsDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetMessageRoomsData_getMessageRooms get getMessageRooms;
  static Serializer<GGetMessageRoomsData> get serializer =>
      _$gGetMessageRoomsDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMessageRoomsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMessageRoomsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetMessageRoomsData.serializer,
        json,
      );
}

abstract class GGetMessageRoomsData_getMessageRooms
    implements
        Built<GGetMessageRoomsData_getMessageRooms,
            GGetMessageRoomsData_getMessageRoomsBuilder> {
  GGetMessageRoomsData_getMessageRooms._();

  factory GGetMessageRoomsData_getMessageRooms(
      [void Function(GGetMessageRoomsData_getMessageRoomsBuilder b)
          updates]) = _$GGetMessageRoomsData_getMessageRooms;

  static void _initializeBuilder(
          GGetMessageRoomsData_getMessageRoomsBuilder b) =>
      b..G__typename = 'MessageRoomsByUserData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GGetMessageRoomsData_getMessageRooms_messageRoomList>
      get messageRoomList;
  int get countOfMessageRooms;
  static Serializer<GGetMessageRoomsData_getMessageRooms> get serializer =>
      _$gGetMessageRoomsDataGetMessageRoomsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMessageRoomsData_getMessageRooms.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMessageRoomsData_getMessageRooms? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetMessageRoomsData_getMessageRooms.serializer,
        json,
      );
}

abstract class GGetMessageRoomsData_getMessageRooms_messageRoomList
    implements
        Built<GGetMessageRoomsData_getMessageRooms_messageRoomList,
            GGetMessageRoomsData_getMessageRooms_messageRoomListBuilder> {
  GGetMessageRoomsData_getMessageRooms_messageRoomList._();

  factory GGetMessageRoomsData_getMessageRooms_messageRoomList(
      [void Function(
              GGetMessageRoomsData_getMessageRooms_messageRoomListBuilder b)
          updates]) = _$GGetMessageRoomsData_getMessageRooms_messageRoomList;

  static void _initializeBuilder(
          GGetMessageRoomsData_getMessageRooms_messageRoomListBuilder b) =>
      b..G__typename = 'MessageRoomData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String? get category;
  String? get latestMessage;
  String? get latestSentAt;
  bool get isRead;
  static Serializer<GGetMessageRoomsData_getMessageRooms_messageRoomList>
      get serializer =>
          _$gGetMessageRoomsDataGetMessageRoomsMessageRoomListSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMessageRoomsData_getMessageRooms_messageRoomList.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMessageRoomsData_getMessageRooms_messageRoomList? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetMessageRoomsData_getMessageRooms_messageRoomList.serializer,
        json,
      );
}

abstract class GGetMessagesInProgressData
    implements
        Built<GGetMessagesInProgressData, GGetMessagesInProgressDataBuilder> {
  GGetMessagesInProgressData._();

  factory GGetMessagesInProgressData(
          [void Function(GGetMessagesInProgressDataBuilder b) updates]) =
      _$GGetMessagesInProgressData;

  static void _initializeBuilder(GGetMessagesInProgressDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetMessagesInProgressData_getMessagesInProgress get getMessagesInProgress;
  static Serializer<GGetMessagesInProgressData> get serializer =>
      _$gGetMessagesInProgressDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMessagesInProgressData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMessagesInProgressData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetMessagesInProgressData.serializer,
        json,
      );
}

abstract class GGetMessagesInProgressData_getMessagesInProgress
    implements
        Built<GGetMessagesInProgressData_getMessagesInProgress,
            GGetMessagesInProgressData_getMessagesInProgressBuilder> {
  GGetMessagesInProgressData_getMessagesInProgress._();

  factory GGetMessagesInProgressData_getMessagesInProgress(
      [void Function(GGetMessagesInProgressData_getMessagesInProgressBuilder b)
          updates]) = _$GGetMessagesInProgressData_getMessagesInProgress;

  static void _initializeBuilder(
          GGetMessagesInProgressData_getMessagesInProgressBuilder b) =>
      b..G__typename = 'MessageRoomsByUserData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GGetMessagesInProgressData_getMessagesInProgress_messageRoomList>
      get messageRoomList;
  int get countOfMessageRooms;
  static Serializer<GGetMessagesInProgressData_getMessagesInProgress>
      get serializer =>
          _$gGetMessagesInProgressDataGetMessagesInProgressSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMessagesInProgressData_getMessagesInProgress.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMessagesInProgressData_getMessagesInProgress? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetMessagesInProgressData_getMessagesInProgress.serializer,
        json,
      );
}

abstract class GGetMessagesInProgressData_getMessagesInProgress_messageRoomList
    implements
        Built<GGetMessagesInProgressData_getMessagesInProgress_messageRoomList,
            GGetMessagesInProgressData_getMessagesInProgress_messageRoomListBuilder> {
  GGetMessagesInProgressData_getMessagesInProgress_messageRoomList._();

  factory GGetMessagesInProgressData_getMessagesInProgress_messageRoomList(
          [void Function(
                  GGetMessagesInProgressData_getMessagesInProgress_messageRoomListBuilder
                      b)
              updates]) =
      _$GGetMessagesInProgressData_getMessagesInProgress_messageRoomList;

  static void _initializeBuilder(
          GGetMessagesInProgressData_getMessagesInProgress_messageRoomListBuilder
              b) =>
      b..G__typename = 'MessageRoomData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String? get category;
  String? get latestMessage;
  String? get latestSentAt;
  bool get isRead;
  static Serializer<
          GGetMessagesInProgressData_getMessagesInProgress_messageRoomList>
      get serializer =>
          _$gGetMessagesInProgressDataGetMessagesInProgressMessageRoomListSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMessagesInProgressData_getMessagesInProgress_messageRoomList
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMessagesInProgressData_getMessagesInProgress_messageRoomList?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetMessagesInProgressData_getMessagesInProgress_messageRoomList
                .serializer,
            json,
          );
}

abstract class GGetMessagesByMessageRoomIdData
    implements
        Built<GGetMessagesByMessageRoomIdData,
            GGetMessagesByMessageRoomIdDataBuilder> {
  GGetMessagesByMessageRoomIdData._();

  factory GGetMessagesByMessageRoomIdData(
          [void Function(GGetMessagesByMessageRoomIdDataBuilder b) updates]) =
      _$GGetMessagesByMessageRoomIdData;

  static void _initializeBuilder(GGetMessagesByMessageRoomIdDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId
      get getMessagesByMessageRoomId;
  static Serializer<GGetMessagesByMessageRoomIdData> get serializer =>
      _$gGetMessagesByMessageRoomIdDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMessagesByMessageRoomIdData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMessagesByMessageRoomIdData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetMessagesByMessageRoomIdData.serializer,
        json,
      );
}

abstract class GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId
    implements
        Built<GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId,
            GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomIdBuilder> {
  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId._();

  factory GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId(
      [void Function(
              GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomIdBuilder
                  b)
          updates]) = _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId;

  static void _initializeBuilder(
          GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomIdBuilder
              b) =>
      b..G__typename = 'MessagesByRoomIdByUserData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to get to;
  BuiltList<
          GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList>
      get messageList;
  static Serializer<GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId>
      get serializer =>
          _$gGetMessagesByMessageRoomIdDataGetMessagesByMessageRoomIdSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId.serializer,
        json,
      );
}

abstract class GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to
    implements
        Built<GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to,
            GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_toBuilder> {
  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to._();

  factory GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to(
          [void Function(
                  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_toBuilder
                      b)
              updates]) =
      _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to;

  static void _initializeBuilder(
          GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_toBuilder
              b) =>
      b..G__typename = 'UserSimpleData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get name;
  String? get imageUrl;
  static Serializer<
          GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to>
      get serializer =>
          _$gGetMessagesByMessageRoomIdDataGetMessagesByMessageRoomIdToSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_to
                .serializer,
            json,
          );
}

abstract class GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList
    implements
        Built<
            GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList,
            GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageListBuilder> {
  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList._();

  factory GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList(
          [void Function(
                  GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageListBuilder
                      b)
              updates]) =
      _$GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList;

  static void _initializeBuilder(
          GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageListBuilder
              b) =>
      b..G__typename = 'MessageTempData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get content;
  String get sentAt;
  static Serializer<
          GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList>
      get serializer =>
          _$gGetMessagesByMessageRoomIdDataGetMessagesByMessageRoomIdMessageListSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetMessagesByMessageRoomIdData_getMessagesByMessageRoomId_messageList
                .serializer,
            json,
          );
}

abstract class GGetNotificationsData
    implements Built<GGetNotificationsData, GGetNotificationsDataBuilder> {
  GGetNotificationsData._();

  factory GGetNotificationsData(
          [void Function(GGetNotificationsDataBuilder b) updates]) =
      _$GGetNotificationsData;

  static void _initializeBuilder(GGetNotificationsDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetNotificationsData_getNotifications get getNotifications;
  static Serializer<GGetNotificationsData> get serializer =>
      _$gGetNotificationsDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetNotificationsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetNotificationsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetNotificationsData.serializer,
        json,
      );
}

abstract class GGetNotificationsData_getNotifications
    implements
        Built<GGetNotificationsData_getNotifications,
            GGetNotificationsData_getNotificationsBuilder> {
  GGetNotificationsData_getNotifications._();

  factory GGetNotificationsData_getNotifications(
      [void Function(GGetNotificationsData_getNotificationsBuilder b)
          updates]) = _$GGetNotificationsData_getNotifications;

  static void _initializeBuilder(
          GGetNotificationsData_getNotificationsBuilder b) =>
      b..G__typename = 'NotificationsData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GGetNotificationsData_getNotifications_notifications>
      get notifications;
  static Serializer<GGetNotificationsData_getNotifications> get serializer =>
      _$gGetNotificationsDataGetNotificationsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetNotificationsData_getNotifications.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetNotificationsData_getNotifications? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetNotificationsData_getNotifications.serializer,
        json,
      );
}

abstract class GGetNotificationsData_getNotifications_notifications
    implements
        Built<GGetNotificationsData_getNotifications_notifications,
            GGetNotificationsData_getNotifications_notificationsBuilder> {
  GGetNotificationsData_getNotifications_notifications._();

  factory GGetNotificationsData_getNotifications_notifications(
      [void Function(
              GGetNotificationsData_getNotifications_notificationsBuilder b)
          updates]) = _$GGetNotificationsData_getNotifications_notifications;

  static void _initializeBuilder(
          GGetNotificationsData_getNotifications_notificationsBuilder b) =>
      b..G__typename = 'NotificationData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get title;
  String get content;
  String get createdAt;
  String get updatedAt;
  static Serializer<GGetNotificationsData_getNotifications_notifications>
      get serializer =>
          _$gGetNotificationsDataGetNotificationsNotificationsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetNotificationsData_getNotifications_notifications.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetNotificationsData_getNotifications_notifications? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetNotificationsData_getNotifications_notifications.serializer,
        json,
      );
}

abstract class GGetAllNotificationsData
    implements
        Built<GGetAllNotificationsData, GGetAllNotificationsDataBuilder> {
  GGetAllNotificationsData._();

  factory GGetAllNotificationsData(
          [void Function(GGetAllNotificationsDataBuilder b) updates]) =
      _$GGetAllNotificationsData;

  static void _initializeBuilder(GGetAllNotificationsDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetAllNotificationsData_getAllNotifications get getAllNotifications;
  static Serializer<GGetAllNotificationsData> get serializer =>
      _$gGetAllNotificationsDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetAllNotificationsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetAllNotificationsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetAllNotificationsData.serializer,
        json,
      );
}

abstract class GGetAllNotificationsData_getAllNotifications
    implements
        Built<GGetAllNotificationsData_getAllNotifications,
            GGetAllNotificationsData_getAllNotificationsBuilder> {
  GGetAllNotificationsData_getAllNotifications._();

  factory GGetAllNotificationsData_getAllNotifications(
      [void Function(GGetAllNotificationsData_getAllNotificationsBuilder b)
          updates]) = _$GGetAllNotificationsData_getAllNotifications;

  static void _initializeBuilder(
          GGetAllNotificationsData_getAllNotificationsBuilder b) =>
      b..G__typename = 'NotificationsData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GGetAllNotificationsData_getAllNotifications_notifications>
      get notifications;
  static Serializer<GGetAllNotificationsData_getAllNotifications>
      get serializer => _$gGetAllNotificationsDataGetAllNotificationsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetAllNotificationsData_getAllNotifications.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetAllNotificationsData_getAllNotifications? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetAllNotificationsData_getAllNotifications.serializer,
        json,
      );
}

abstract class GGetAllNotificationsData_getAllNotifications_notifications
    implements
        Built<GGetAllNotificationsData_getAllNotifications_notifications,
            GGetAllNotificationsData_getAllNotifications_notificationsBuilder> {
  GGetAllNotificationsData_getAllNotifications_notifications._();

  factory GGetAllNotificationsData_getAllNotifications_notifications(
      [void Function(
              GGetAllNotificationsData_getAllNotifications_notificationsBuilder
                  b)
          updates]) = _$GGetAllNotificationsData_getAllNotifications_notifications;

  static void _initializeBuilder(
          GGetAllNotificationsData_getAllNotifications_notificationsBuilder
              b) =>
      b..G__typename = 'NotificationData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get title;
  String get content;
  String get createdAt;
  String get updatedAt;
  static Serializer<GGetAllNotificationsData_getAllNotifications_notifications>
      get serializer =>
          _$gGetAllNotificationsDataGetAllNotificationsNotificationsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetAllNotificationsData_getAllNotifications_notifications.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetAllNotificationsData_getAllNotifications_notifications? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetAllNotificationsData_getAllNotifications_notifications.serializer,
        json,
      );
}

abstract class GGetUserDataData
    implements Built<GGetUserDataData, GGetUserDataDataBuilder> {
  GGetUserDataData._();

  factory GGetUserDataData([void Function(GGetUserDataDataBuilder b) updates]) =
      _$GGetUserDataData;

  static void _initializeBuilder(GGetUserDataDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetUserDataData_getUserData get getUserData;
  static Serializer<GGetUserDataData> get serializer =>
      _$gGetUserDataDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetUserDataData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetUserDataData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetUserDataData.serializer,
        json,
      );
}

abstract class GGetUserDataData_getUserData
    implements
        Built<GGetUserDataData_getUserData,
            GGetUserDataData_getUserDataBuilder> {
  GGetUserDataData_getUserData._();

  factory GGetUserDataData_getUserData(
          [void Function(GGetUserDataData_getUserDataBuilder b) updates]) =
      _$GGetUserDataData_getUserData;

  static void _initializeBuilder(GGetUserDataData_getUserDataBuilder b) =>
      b..G__typename = 'UserDetailData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get email;
  String get name;
  String? get imageUrl;
  int get fspBalance;
  int get credentialBalance;
  String get role;
  String get primaryRole;
  BuiltList<GGetUserDataData_getUserData_belongsToArtists> get belongsToArtists;
  GGetUserDataData_getUserData_primaryArtist? get primaryArtist;
  static Serializer<GGetUserDataData_getUserData> get serializer =>
      _$gGetUserDataDataGetUserDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetUserDataData_getUserData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetUserDataData_getUserData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetUserDataData_getUserData.serializer,
        json,
      );
}

abstract class GGetUserDataData_getUserData_belongsToArtists
    implements
        Built<GGetUserDataData_getUserData_belongsToArtists,
            GGetUserDataData_getUserData_belongsToArtistsBuilder> {
  GGetUserDataData_getUserData_belongsToArtists._();

  factory GGetUserDataData_getUserData_belongsToArtists(
      [void Function(GGetUserDataData_getUserData_belongsToArtistsBuilder b)
          updates]) = _$GGetUserDataData_getUserData_belongsToArtists;

  static void _initializeBuilder(
          GGetUserDataData_getUserData_belongsToArtistsBuilder b) =>
      b..G__typename = 'ArtistByUserData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get name;
  String? get imageUrl;
  int get fsp;
  String get status;
  bool get isAdmin;
  static Serializer<GGetUserDataData_getUserData_belongsToArtists>
      get serializer => _$gGetUserDataDataGetUserDataBelongsToArtistsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetUserDataData_getUserData_belongsToArtists.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetUserDataData_getUserData_belongsToArtists? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetUserDataData_getUserData_belongsToArtists.serializer,
        json,
      );
}

abstract class GGetUserDataData_getUserData_primaryArtist
    implements
        Built<GGetUserDataData_getUserData_primaryArtist,
            GGetUserDataData_getUserData_primaryArtistBuilder> {
  GGetUserDataData_getUserData_primaryArtist._();

  factory GGetUserDataData_getUserData_primaryArtist(
      [void Function(GGetUserDataData_getUserData_primaryArtistBuilder b)
          updates]) = _$GGetUserDataData_getUserData_primaryArtist;

  static void _initializeBuilder(
          GGetUserDataData_getUserData_primaryArtistBuilder b) =>
      b..G__typename = 'ArtistByUserData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get name;
  String? get imageUrl;
  int get fsp;
  String get status;
  bool get isAdmin;
  static Serializer<GGetUserDataData_getUserData_primaryArtist>
      get serializer => _$gGetUserDataDataGetUserDataPrimaryArtistSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetUserDataData_getUserData_primaryArtist.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetUserDataData_getUserData_primaryArtist? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetUserDataData_getUserData_primaryArtist.serializer,
        json,
      );
}

abstract class GGetBelongedArtistsData
    implements Built<GGetBelongedArtistsData, GGetBelongedArtistsDataBuilder> {
  GGetBelongedArtistsData._();

  factory GGetBelongedArtistsData(
          [void Function(GGetBelongedArtistsDataBuilder b) updates]) =
      _$GGetBelongedArtistsData;

  static void _initializeBuilder(GGetBelongedArtistsDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetBelongedArtistsData_getBelongedArtists get getBelongedArtists;
  static Serializer<GGetBelongedArtistsData> get serializer =>
      _$gGetBelongedArtistsDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetBelongedArtistsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetBelongedArtistsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetBelongedArtistsData.serializer,
        json,
      );
}

abstract class GGetBelongedArtistsData_getBelongedArtists
    implements
        Built<GGetBelongedArtistsData_getBelongedArtists,
            GGetBelongedArtistsData_getBelongedArtistsBuilder> {
  GGetBelongedArtistsData_getBelongedArtists._();

  factory GGetBelongedArtistsData_getBelongedArtists(
      [void Function(GGetBelongedArtistsData_getBelongedArtistsBuilder b)
          updates]) = _$GGetBelongedArtistsData_getBelongedArtists;

  static void _initializeBuilder(
          GGetBelongedArtistsData_getBelongedArtistsBuilder b) =>
      b..G__typename = 'ArtistByUserDataList';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GGetBelongedArtistsData_getBelongedArtists_artistList>
      get artistList;
  static Serializer<GGetBelongedArtistsData_getBelongedArtists>
      get serializer => _$gGetBelongedArtistsDataGetBelongedArtistsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetBelongedArtistsData_getBelongedArtists.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetBelongedArtistsData_getBelongedArtists? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetBelongedArtistsData_getBelongedArtists.serializer,
        json,
      );
}

abstract class GGetBelongedArtistsData_getBelongedArtists_artistList
    implements
        Built<GGetBelongedArtistsData_getBelongedArtists_artistList,
            GGetBelongedArtistsData_getBelongedArtists_artistListBuilder> {
  GGetBelongedArtistsData_getBelongedArtists_artistList._();

  factory GGetBelongedArtistsData_getBelongedArtists_artistList(
      [void Function(
              GGetBelongedArtistsData_getBelongedArtists_artistListBuilder b)
          updates]) = _$GGetBelongedArtistsData_getBelongedArtists_artistList;

  static void _initializeBuilder(
          GGetBelongedArtistsData_getBelongedArtists_artistListBuilder b) =>
      b..G__typename = 'ArtistByUserData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get name;
  String? get imageUrl;
  int get fsp;
  String get status;
  bool get isAdmin;
  static Serializer<GGetBelongedArtistsData_getBelongedArtists_artistList>
      get serializer =>
          _$gGetBelongedArtistsDataGetBelongedArtistsArtistListSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetBelongedArtistsData_getBelongedArtists_artistList.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetBelongedArtistsData_getBelongedArtists_artistList? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetBelongedArtistsData_getBelongedArtists_artistList.serializer,
        json,
      );
}

abstract class GGetUserDetailProfileData
    implements
        Built<GGetUserDetailProfileData, GGetUserDetailProfileDataBuilder> {
  GGetUserDetailProfileData._();

  factory GGetUserDetailProfileData(
          [void Function(GGetUserDetailProfileDataBuilder b) updates]) =
      _$GGetUserDetailProfileData;

  static void _initializeBuilder(GGetUserDetailProfileDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetUserDetailProfileData_getUserDetailProfile get getUserDetailProfile;
  static Serializer<GGetUserDetailProfileData> get serializer =>
      _$gGetUserDetailProfileDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetUserDetailProfileData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetUserDetailProfileData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetUserDetailProfileData.serializer,
        json,
      );
}

abstract class GGetUserDetailProfileData_getUserDetailProfile
    implements
        Built<GGetUserDetailProfileData_getUserDetailProfile,
            GGetUserDetailProfileData_getUserDetailProfileBuilder> {
  GGetUserDetailProfileData_getUserDetailProfile._();

  factory GGetUserDetailProfileData_getUserDetailProfile(
      [void Function(GGetUserDetailProfileData_getUserDetailProfileBuilder b)
          updates]) = _$GGetUserDetailProfileData_getUserDetailProfile;

  static void _initializeBuilder(
          GGetUserDetailProfileData_getUserDetailProfileBuilder b) =>
      b..G__typename = 'UserDetailData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get email;
  String get name;
  String? get imageUrl;
  int get fspBalance;
  int get credentialBalance;
  String get role;
  String get primaryRole;
  BuiltList<GGetUserDetailProfileData_getUserDetailProfile_belongsToArtists>
      get belongsToArtists;
  GGetUserDetailProfileData_getUserDetailProfile_primaryArtist?
      get primaryArtist;
  static Serializer<GGetUserDetailProfileData_getUserDetailProfile>
      get serializer =>
          _$gGetUserDetailProfileDataGetUserDetailProfileSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetUserDetailProfileData_getUserDetailProfile.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetUserDetailProfileData_getUserDetailProfile? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetUserDetailProfileData_getUserDetailProfile.serializer,
        json,
      );
}

abstract class GGetUserDetailProfileData_getUserDetailProfile_belongsToArtists
    implements
        Built<GGetUserDetailProfileData_getUserDetailProfile_belongsToArtists,
            GGetUserDetailProfileData_getUserDetailProfile_belongsToArtistsBuilder> {
  GGetUserDetailProfileData_getUserDetailProfile_belongsToArtists._();

  factory GGetUserDetailProfileData_getUserDetailProfile_belongsToArtists(
          [void Function(
                  GGetUserDetailProfileData_getUserDetailProfile_belongsToArtistsBuilder
                      b)
              updates]) =
      _$GGetUserDetailProfileData_getUserDetailProfile_belongsToArtists;

  static void _initializeBuilder(
          GGetUserDetailProfileData_getUserDetailProfile_belongsToArtistsBuilder
              b) =>
      b..G__typename = 'ArtistByUserData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get name;
  String? get imageUrl;
  int get fsp;
  String get status;
  bool get isAdmin;
  static Serializer<
          GGetUserDetailProfileData_getUserDetailProfile_belongsToArtists>
      get serializer =>
          _$gGetUserDetailProfileDataGetUserDetailProfileBelongsToArtistsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetUserDetailProfileData_getUserDetailProfile_belongsToArtists
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetUserDetailProfileData_getUserDetailProfile_belongsToArtists?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetUserDetailProfileData_getUserDetailProfile_belongsToArtists
                .serializer,
            json,
          );
}

abstract class GGetUserDetailProfileData_getUserDetailProfile_primaryArtist
    implements
        Built<GGetUserDetailProfileData_getUserDetailProfile_primaryArtist,
            GGetUserDetailProfileData_getUserDetailProfile_primaryArtistBuilder> {
  GGetUserDetailProfileData_getUserDetailProfile_primaryArtist._();

  factory GGetUserDetailProfileData_getUserDetailProfile_primaryArtist(
          [void Function(
                  GGetUserDetailProfileData_getUserDetailProfile_primaryArtistBuilder
                      b)
              updates]) =
      _$GGetUserDetailProfileData_getUserDetailProfile_primaryArtist;

  static void _initializeBuilder(
          GGetUserDetailProfileData_getUserDetailProfile_primaryArtistBuilder
              b) =>
      b..G__typename = 'ArtistByUserData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get name;
  String? get imageUrl;
  int get fsp;
  String get status;
  bool get isAdmin;
  static Serializer<
          GGetUserDetailProfileData_getUserDetailProfile_primaryArtist>
      get serializer =>
          _$gGetUserDetailProfileDataGetUserDetailProfilePrimaryArtistSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetUserDetailProfileData_getUserDetailProfile_primaryArtist.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetUserDetailProfileData_getUserDetailProfile_primaryArtist? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetUserDetailProfileData_getUserDetailProfile_primaryArtist.serializer,
        json,
      );
}

abstract class GGetAllArtistsData
    implements Built<GGetAllArtistsData, GGetAllArtistsDataBuilder> {
  GGetAllArtistsData._();

  factory GGetAllArtistsData(
          [void Function(GGetAllArtistsDataBuilder b) updates]) =
      _$GGetAllArtistsData;

  static void _initializeBuilder(GGetAllArtistsDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetAllArtistsData_getAllArtists get getAllArtists;
  static Serializer<GGetAllArtistsData> get serializer =>
      _$gGetAllArtistsDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetAllArtistsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetAllArtistsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetAllArtistsData.serializer,
        json,
      );
}

abstract class GGetAllArtistsData_getAllArtists
    implements
        Built<GGetAllArtistsData_getAllArtists,
            GGetAllArtistsData_getAllArtistsBuilder> {
  GGetAllArtistsData_getAllArtists._();

  factory GGetAllArtistsData_getAllArtists(
          [void Function(GGetAllArtistsData_getAllArtistsBuilder b) updates]) =
      _$GGetAllArtistsData_getAllArtists;

  static void _initializeBuilder(GGetAllArtistsData_getAllArtistsBuilder b) =>
      b..G__typename = 'ArtistsData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GGetAllArtistsData_getAllArtists_artistList> get artistList;
  static Serializer<GGetAllArtistsData_getAllArtists> get serializer =>
      _$gGetAllArtistsDataGetAllArtistsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetAllArtistsData_getAllArtists.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetAllArtistsData_getAllArtists? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetAllArtistsData_getAllArtists.serializer,
        json,
      );
}

abstract class GGetAllArtistsData_getAllArtists_artistList
    implements
        Built<GGetAllArtistsData_getAllArtists_artistList,
            GGetAllArtistsData_getAllArtists_artistListBuilder> {
  GGetAllArtistsData_getAllArtists_artistList._();

  factory GGetAllArtistsData_getAllArtists_artistList(
      [void Function(GGetAllArtistsData_getAllArtists_artistListBuilder b)
          updates]) = _$GGetAllArtistsData_getAllArtists_artistList;

  static void _initializeBuilder(
          GGetAllArtistsData_getAllArtists_artistListBuilder b) =>
      b..G__typename = 'ArtistData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get name;
  int get fsp;
  String? get imageUrl;
  static Serializer<GGetAllArtistsData_getAllArtists_artistList>
      get serializer => _$gGetAllArtistsDataGetAllArtistsArtistListSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetAllArtistsData_getAllArtists_artistList.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetAllArtistsData_getAllArtists_artistList? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetAllArtistsData_getAllArtists_artistList.serializer,
        json,
      );
}

abstract class GGetArtistByIdData
    implements Built<GGetArtistByIdData, GGetArtistByIdDataBuilder> {
  GGetArtistByIdData._();

  factory GGetArtistByIdData(
          [void Function(GGetArtistByIdDataBuilder b) updates]) =
      _$GGetArtistByIdData;

  static void _initializeBuilder(GGetArtistByIdDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetArtistByIdData_getArtistById get getArtistById;
  static Serializer<GGetArtistByIdData> get serializer =>
      _$gGetArtistByIdDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetArtistByIdData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetArtistByIdData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetArtistByIdData.serializer,
        json,
      );
}

abstract class GGetArtistByIdData_getArtistById
    implements
        Built<GGetArtistByIdData_getArtistById,
            GGetArtistByIdData_getArtistByIdBuilder> {
  GGetArtistByIdData_getArtistById._();

  factory GGetArtistByIdData_getArtistById(
          [void Function(GGetArtistByIdData_getArtistByIdBuilder b) updates]) =
      _$GGetArtistByIdData_getArtistById;

  static void _initializeBuilder(GGetArtistByIdData_getArtistByIdBuilder b) =>
      b..G__typename = 'ArtistFullData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
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
  static Serializer<GGetArtistByIdData_getArtistById> get serializer =>
      _$gGetArtistByIdDataGetArtistByIdSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetArtistByIdData_getArtistById.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetArtistByIdData_getArtistById? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetArtistByIdData_getArtistById.serializer,
        json,
      );
}

abstract class GGetPopularPrizesData
    implements Built<GGetPopularPrizesData, GGetPopularPrizesDataBuilder> {
  GGetPopularPrizesData._();

  factory GGetPopularPrizesData(
          [void Function(GGetPopularPrizesDataBuilder b) updates]) =
      _$GGetPopularPrizesData;

  static void _initializeBuilder(GGetPopularPrizesDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GGetPopularPrizesData_getPopularPrizes> get getPopularPrizes;
  static Serializer<GGetPopularPrizesData> get serializer =>
      _$gGetPopularPrizesDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetPopularPrizesData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetPopularPrizesData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetPopularPrizesData.serializer,
        json,
      );
}

abstract class GGetPopularPrizesData_getPopularPrizes
    implements
        Built<GGetPopularPrizesData_getPopularPrizes,
            GGetPopularPrizesData_getPopularPrizesBuilder> {
  GGetPopularPrizesData_getPopularPrizes._();

  factory GGetPopularPrizesData_getPopularPrizes(
      [void Function(GGetPopularPrizesData_getPopularPrizesBuilder b)
          updates]) = _$GGetPopularPrizesData_getPopularPrizes;

  static void _initializeBuilder(
          GGetPopularPrizesData_getPopularPrizesBuilder b) =>
      b..G__typename = 'PrizeData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String? get imgUrl;
  String get name;
  int get point;
  static Serializer<GGetPopularPrizesData_getPopularPrizes> get serializer =>
      _$gGetPopularPrizesDataGetPopularPrizesSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetPopularPrizesData_getPopularPrizes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetPopularPrizesData_getPopularPrizes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetPopularPrizesData_getPopularPrizes.serializer,
        json,
      );
}

abstract class GGetAllPrizesData
    implements Built<GGetAllPrizesData, GGetAllPrizesDataBuilder> {
  GGetAllPrizesData._();

  factory GGetAllPrizesData(
          [void Function(GGetAllPrizesDataBuilder b) updates]) =
      _$GGetAllPrizesData;

  static void _initializeBuilder(GGetAllPrizesDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GGetAllPrizesData_getAllPrizes> get getAllPrizes;
  static Serializer<GGetAllPrizesData> get serializer =>
      _$gGetAllPrizesDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetAllPrizesData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetAllPrizesData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetAllPrizesData.serializer,
        json,
      );
}

abstract class GGetAllPrizesData_getAllPrizes
    implements
        Built<GGetAllPrizesData_getAllPrizes,
            GGetAllPrizesData_getAllPrizesBuilder> {
  GGetAllPrizesData_getAllPrizes._();

  factory GGetAllPrizesData_getAllPrizes(
          [void Function(GGetAllPrizesData_getAllPrizesBuilder b) updates]) =
      _$GGetAllPrizesData_getAllPrizes;

  static void _initializeBuilder(GGetAllPrizesData_getAllPrizesBuilder b) =>
      b..G__typename = 'PrizeData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String? get imgUrl;
  String get name;
  int get point;
  static Serializer<GGetAllPrizesData_getAllPrizes> get serializer =>
      _$gGetAllPrizesDataGetAllPrizesSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetAllPrizesData_getAllPrizes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetAllPrizesData_getAllPrizes? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetAllPrizesData_getAllPrizes.serializer,
        json,
      );
}

abstract class GGetPrizeDetailData
    implements Built<GGetPrizeDetailData, GGetPrizeDetailDataBuilder> {
  GGetPrizeDetailData._();

  factory GGetPrizeDetailData(
          [void Function(GGetPrizeDetailDataBuilder b) updates]) =
      _$GGetPrizeDetailData;

  static void _initializeBuilder(GGetPrizeDetailDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetPrizeDetailData_getPrizeDetail get getPrizeDetail;
  static Serializer<GGetPrizeDetailData> get serializer =>
      _$gGetPrizeDetailDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetPrizeDetailData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetPrizeDetailData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetPrizeDetailData.serializer,
        json,
      );
}

abstract class GGetPrizeDetailData_getPrizeDetail
    implements
        Built<GGetPrizeDetailData_getPrizeDetail,
            GGetPrizeDetailData_getPrizeDetailBuilder> {
  GGetPrizeDetailData_getPrizeDetail._();

  factory GGetPrizeDetailData_getPrizeDetail(
      [void Function(GGetPrizeDetailData_getPrizeDetailBuilder b)
          updates]) = _$GGetPrizeDetailData_getPrizeDetail;

  static void _initializeBuilder(GGetPrizeDetailData_getPrizeDetailBuilder b) =>
      b..G__typename = 'PrizeDetailData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String? get imgUrl;
  String get name;
  int get point;
  String get description;
  String get representation;
  String? get condition;
  static Serializer<GGetPrizeDetailData_getPrizeDetail> get serializer =>
      _$gGetPrizeDetailDataGetPrizeDetailSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetPrizeDetailData_getPrizeDetail.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetPrizeDetailData_getPrizeDetail? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetPrizeDetailData_getPrizeDetail.serializer,
        json,
      );
}

abstract class GGetFspHistoryData
    implements Built<GGetFspHistoryData, GGetFspHistoryDataBuilder> {
  GGetFspHistoryData._();

  factory GGetFspHistoryData(
          [void Function(GGetFspHistoryDataBuilder b) updates]) =
      _$GGetFspHistoryData;

  static void _initializeBuilder(GGetFspHistoryDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetFspHistoryData_getFspHistory get getFspHistory;
  static Serializer<GGetFspHistoryData> get serializer =>
      _$gGetFspHistoryDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetFspHistoryData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetFspHistoryData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetFspHistoryData.serializer,
        json,
      );
}

abstract class GGetFspHistoryData_getFspHistory
    implements
        Built<GGetFspHistoryData_getFspHistory,
            GGetFspHistoryData_getFspHistoryBuilder> {
  GGetFspHistoryData_getFspHistory._();

  factory GGetFspHistoryData_getFspHistory(
          [void Function(GGetFspHistoryData_getFspHistoryBuilder b) updates]) =
      _$GGetFspHistoryData_getFspHistory;

  static void _initializeBuilder(GGetFspHistoryData_getFspHistoryBuilder b) =>
      b..G__typename = 'TransactionsData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GGetFspHistoryData_getFspHistory_transactionList>
      get transactionList;
  static Serializer<GGetFspHistoryData_getFspHistory> get serializer =>
      _$gGetFspHistoryDataGetFspHistorySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetFspHistoryData_getFspHistory.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetFspHistoryData_getFspHistory? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetFspHistoryData_getFspHistory.serializer,
        json,
      );
}

abstract class GGetFspHistoryData_getFspHistory_transactionList
    implements
        Built<GGetFspHistoryData_getFspHistory_transactionList,
            GGetFspHistoryData_getFspHistory_transactionListBuilder> {
  GGetFspHistoryData_getFspHistory_transactionList._();

  factory GGetFspHistoryData_getFspHistory_transactionList(
      [void Function(GGetFspHistoryData_getFspHistory_transactionListBuilder b)
          updates]) = _$GGetFspHistoryData_getFspHistory_transactionList;

  static void _initializeBuilder(
          GGetFspHistoryData_getFspHistory_transactionListBuilder b) =>
      b..G__typename = 'TransactionData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  GGetFspHistoryData_getFspHistory_transactionList_from? get from;
  GGetFspHistoryData_getFspHistory_transactionList_to? get to;
  int get amount;
  String get txAt;
  static Serializer<GGetFspHistoryData_getFspHistory_transactionList>
      get serializer =>
          _$gGetFspHistoryDataGetFspHistoryTransactionListSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetFspHistoryData_getFspHistory_transactionList.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetFspHistoryData_getFspHistory_transactionList? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetFspHistoryData_getFspHistory_transactionList.serializer,
        json,
      );
}

abstract class GGetFspHistoryData_getFspHistory_transactionList_from
    implements
        Built<GGetFspHistoryData_getFspHistory_transactionList_from,
            GGetFspHistoryData_getFspHistory_transactionList_fromBuilder> {
  GGetFspHistoryData_getFspHistory_transactionList_from._();

  factory GGetFspHistoryData_getFspHistory_transactionList_from(
      [void Function(
              GGetFspHistoryData_getFspHistory_transactionList_fromBuilder b)
          updates]) = _$GGetFspHistoryData_getFspHistory_transactionList_from;

  static void _initializeBuilder(
          GGetFspHistoryData_getFspHistory_transactionList_fromBuilder b) =>
      b..G__typename = 'UserSimpleData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get name;
  String? get imageUrl;
  static Serializer<GGetFspHistoryData_getFspHistory_transactionList_from>
      get serializer =>
          _$gGetFspHistoryDataGetFspHistoryTransactionListFromSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetFspHistoryData_getFspHistory_transactionList_from.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetFspHistoryData_getFspHistory_transactionList_from? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetFspHistoryData_getFspHistory_transactionList_from.serializer,
        json,
      );
}

abstract class GGetFspHistoryData_getFspHistory_transactionList_to
    implements
        Built<GGetFspHistoryData_getFspHistory_transactionList_to,
            GGetFspHistoryData_getFspHistory_transactionList_toBuilder> {
  GGetFspHistoryData_getFspHistory_transactionList_to._();

  factory GGetFspHistoryData_getFspHistory_transactionList_to(
      [void Function(
              GGetFspHistoryData_getFspHistory_transactionList_toBuilder b)
          updates]) = _$GGetFspHistoryData_getFspHistory_transactionList_to;

  static void _initializeBuilder(
          GGetFspHistoryData_getFspHistory_transactionList_toBuilder b) =>
      b..G__typename = 'UserSimpleData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get name;
  String? get imageUrl;
  static Serializer<GGetFspHistoryData_getFspHistory_transactionList_to>
      get serializer =>
          _$gGetFspHistoryDataGetFspHistoryTransactionListToSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetFspHistoryData_getFspHistory_transactionList_to.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetFspHistoryData_getFspHistory_transactionList_to? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetFspHistoryData_getFspHistory_transactionList_to.serializer,
        json,
      );
}

abstract class GGetFspHistoryByUserData
    implements
        Built<GGetFspHistoryByUserData, GGetFspHistoryByUserDataBuilder> {
  GGetFspHistoryByUserData._();

  factory GGetFspHistoryByUserData(
          [void Function(GGetFspHistoryByUserDataBuilder b) updates]) =
      _$GGetFspHistoryByUserData;

  static void _initializeBuilder(GGetFspHistoryByUserDataBuilder b) =>
      b..G__typename = 'QueryRoot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetFspHistoryByUserData_getFspHistoryByUser get getFspHistoryByUser;
  static Serializer<GGetFspHistoryByUserData> get serializer =>
      _$gGetFspHistoryByUserDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetFspHistoryByUserData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetFspHistoryByUserData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetFspHistoryByUserData.serializer,
        json,
      );
}

abstract class GGetFspHistoryByUserData_getFspHistoryByUser
    implements
        Built<GGetFspHistoryByUserData_getFspHistoryByUser,
            GGetFspHistoryByUserData_getFspHistoryByUserBuilder> {
  GGetFspHistoryByUserData_getFspHistoryByUser._();

  factory GGetFspHistoryByUserData_getFspHistoryByUser(
      [void Function(GGetFspHistoryByUserData_getFspHistoryByUserBuilder b)
          updates]) = _$GGetFspHistoryByUserData_getFspHistoryByUser;

  static void _initializeBuilder(
          GGetFspHistoryByUserData_getFspHistoryByUserBuilder b) =>
      b..G__typename = 'TransactionsByUserData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GGetFspHistoryByUserData_getFspHistoryByUser_transactionList>
      get transactionList;
  static Serializer<GGetFspHistoryByUserData_getFspHistoryByUser>
      get serializer => _$gGetFspHistoryByUserDataGetFspHistoryByUserSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetFspHistoryByUserData_getFspHistoryByUser.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetFspHistoryByUserData_getFspHistoryByUser? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetFspHistoryByUserData_getFspHistoryByUser.serializer,
        json,
      );
}

abstract class GGetFspHistoryByUserData_getFspHistoryByUser_transactionList
    implements
        Built<GGetFspHistoryByUserData_getFspHistoryByUser_transactionList,
            GGetFspHistoryByUserData_getFspHistoryByUser_transactionListBuilder> {
  GGetFspHistoryByUserData_getFspHistoryByUser_transactionList._();

  factory GGetFspHistoryByUserData_getFspHistoryByUser_transactionList(
          [void Function(
                  GGetFspHistoryByUserData_getFspHistoryByUser_transactionListBuilder
                      b)
              updates]) =
      _$GGetFspHistoryByUserData_getFspHistoryByUser_transactionList;

  static void _initializeBuilder(
          GGetFspHistoryByUserData_getFspHistoryByUser_transactionListBuilder
              b) =>
      b..G__typename = 'TransactionByUserData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  int get amount;
  _i2.GTransactionDirection get direction;
  GGetFspHistoryByUserData_getFspHistoryByUser_transactionList_counterParty
      get counterParty;
  String get txAt;
  static Serializer<
          GGetFspHistoryByUserData_getFspHistoryByUser_transactionList>
      get serializer =>
          _$gGetFspHistoryByUserDataGetFspHistoryByUserTransactionListSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetFspHistoryByUserData_getFspHistoryByUser_transactionList.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetFspHistoryByUserData_getFspHistoryByUser_transactionList? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetFspHistoryByUserData_getFspHistoryByUser_transactionList.serializer,
        json,
      );
}

abstract class GGetFspHistoryByUserData_getFspHistoryByUser_transactionList_counterParty
    implements
        Built<
            GGetFspHistoryByUserData_getFspHistoryByUser_transactionList_counterParty,
            GGetFspHistoryByUserData_getFspHistoryByUser_transactionList_counterPartyBuilder> {
  GGetFspHistoryByUserData_getFspHistoryByUser_transactionList_counterParty._();

  factory GGetFspHistoryByUserData_getFspHistoryByUser_transactionList_counterParty(
          [void Function(
                  GGetFspHistoryByUserData_getFspHistoryByUser_transactionList_counterPartyBuilder
                      b)
              updates]) =
      _$GGetFspHistoryByUserData_getFspHistoryByUser_transactionList_counterParty;

  static void _initializeBuilder(
          GGetFspHistoryByUserData_getFspHistoryByUser_transactionList_counterPartyBuilder
              b) =>
      b..G__typename = 'UserSimpleData';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get name;
  String? get imageUrl;
  static Serializer<
          GGetFspHistoryByUserData_getFspHistoryByUser_transactionList_counterParty>
      get serializer =>
          _$gGetFspHistoryByUserDataGetFspHistoryByUserTransactionListCounterPartySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetFspHistoryByUserData_getFspHistoryByUser_transactionList_counterParty
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetFspHistoryByUserData_getFspHistoryByUser_transactionList_counterParty?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetFspHistoryByUserData_getFspHistoryByUser_transactionList_counterParty
                .serializer,
            json,
          );
}
