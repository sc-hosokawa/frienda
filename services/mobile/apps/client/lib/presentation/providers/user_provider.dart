import 'package:flutter_riverpod/flutter_riverpod.dart';

// ユーザーの状態を表すクラス
class UserData {
  final String id;
  final String name;
  final String? email;
  final String? imageUrl;
  final int fspBalance;
  final int credentialBalance;
  final String role;
  final String primaryRole;
  final String? greeting;
  final String? skill;
  final String? xHandle;
  final String? instagramHandle;
  final String? fbHandle;
  final String? interestOffer;
  final DateTime? createdAt;
  final List<ArtistByUser> belongsToArtists;
  final ArtistByUser? primaryArtist;

  UserData({
    required this.id,
    required this.name,
    this.email,
    this.imageUrl,
    required this.fspBalance,
    required this.credentialBalance,
    required this.role,
    required this.primaryRole,
    this.greeting,
    this.skill,
    this.xHandle,
    this.instagramHandle,
    this.fbHandle,
    this.interestOffer,
    this.createdAt,
    required this.belongsToArtists,
    this.primaryArtist,
  });

  // JSONからインスタンスを生成するファクトリメソッド
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?,
      fspBalance: json['fspBalance'] as int,
      credentialBalance: json['credentialBalance'] as int,
      role: json['role'] as String,
      primaryRole: json['primaryRole'] as String,
      greeting: json['greeting'] as String?,
      skill: json['skill'] as String?,
      xHandle: json['xHandle'] as String?,
      instagramHandle: json['instagramHandle'] as String?,
      fbHandle: json['fbHandle'] as String?,
      interestOffer: json['interestOffer'] as String?,
      belongsToArtists: (json['belongsToArtists'] as List)
          .map((e) => ArtistByUser.fromJson(e as Map<String, dynamic>))
          .toList(),
      primaryArtist: json['primaryArtist'] != null
          ? ArtistByUser.fromJson(json['primaryArtist'] as Map<String, dynamic>)
          : null,
    );
  }

  // copyWithメソッドを追加
  UserData copyWith({
    String? id,
    String? email,
    String? name,
    String? imageUrl,
    int? fspBalance,
    int? credentialBalance,
    String? role,
    String? primaryRole,
    String? greeting,
    String? skill,
    String? xHandle,
    String? instagramHandle,
    String? fbHandle,
    String? interestOffer,
    DateTime? createdAt,
    List<ArtistByUser>? belongsToArtists,
    ArtistByUser? primaryArtist,
  }) {
    return UserData(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      fspBalance: fspBalance ?? this.fspBalance,
      credentialBalance: credentialBalance ?? this.credentialBalance,
      role: role ?? this.role,
      primaryRole: primaryRole ?? this.primaryRole,
      greeting: greeting ?? this.greeting,
      skill: skill ?? this.skill,
      xHandle: xHandle ?? this.xHandle,
      instagramHandle: instagramHandle ?? this.instagramHandle,
      fbHandle: fbHandle ?? this.fbHandle,
      interestOffer: interestOffer ?? this.interestOffer,
      belongsToArtists: belongsToArtists ?? this.belongsToArtists,
      primaryArtist: primaryArtist ?? this.primaryArtist,
    );
  }

  // アーティスト名からArtistByUserを取得するメソッドを追加
  ArtistByUser? getArtistByName(String artistName) {
    return belongsToArtists.firstWhere(
      (artist) => artist.name == artistName,
      orElse: () => belongsToArtists.first,
    );
  }

  // アーティストIDからArtistByUserを取得するメソッドを追加
  ArtistByUser? getArtistById(String artistId) {
    return belongsToArtists.firstWhere(
      (artist) => artist.artistId == artistId,
      orElse: () => belongsToArtists.first,
    );
  }
}

// アーティスト情報を表すクラス
class ArtistByUser {
  final int? mappingId;
  final String artistId;
  final String id;
  final String name;
  final String? imageUrl;
  final int fsp;
  final String? status;
  final bool? isAdmin;

  ArtistByUser({
    this.mappingId,
    required this.artistId,
    required this.id,
    required this.name,
    this.imageUrl,
    required this.fsp,
    this.status,
    this.isAdmin,
  });

  factory ArtistByUser.fromJson(Map<String, dynamic> json) {
    return ArtistByUser(
      artistId: json['artistId'] as String,
      mappingId: json['mappingId'] as int?,
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?,
      fsp: json['fsp'] as int,
      status: json['status'] as String?,
      isAdmin: json['isAdmin'] as bool?,
    );
  }
}

// ユーザー状態を管理するNotifierProvider
final userProvider = NotifierProvider<UserNotifier, UserData?>(() {
  return UserNotifier();
});

class UserNotifier extends Notifier<UserData?> {
  @override
  UserData? build() {
    return null;
  }

  // FSP残高を更新するメソッドを追加
  void updateBalance(int newBalance) {
    if (state != null) {
      state = state!.copyWith(fspBalance: newBalance);
    }
  }

  void updateUser(UserData user) {
    state = user;
  }

  void clearUser() {
    state = null;
  }
}
