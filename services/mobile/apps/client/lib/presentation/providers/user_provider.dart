import 'package:flutter_riverpod/flutter_riverpod.dart';

// ユーザーの状態を表すクラス
class UserData {
  final String id;
  final String email;
  final String name;
  final String? imageUrl;
  final int fspBalance;
  final int credentialBalance;
  final String role;
  final String primaryRole;
  final List<ArtistByUser> belongsToArtists;
  final ArtistByUser? primaryArtist;

  UserData({
    required this.id,
    required this.email,
    required this.name,
    this.imageUrl,
    required this.fspBalance,
    required this.credentialBalance,
    required this.role,
    required this.primaryRole,
    required this.belongsToArtists,
    this.primaryArtist,
  });

  // JSONからインスタンスを生成するファクトリメソッド
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?,
      fspBalance: json['fspBalance'] as int,
      credentialBalance: json['credentialBalance'] as int,
      role: json['role'] as String,
      primaryRole: json['primaryRole'] as String,
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
    List<ArtistByUser>? belongsToArtists,
    ArtistByUser? primaryArtist,
  }) {
    return UserData(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      fspBalance: fspBalance ?? this.fspBalance,
      credentialBalance: credentialBalance ?? this.credentialBalance,
      role: role ?? this.role,
      primaryRole: primaryRole ?? this.primaryRole,
      belongsToArtists: belongsToArtists ?? this.belongsToArtists,
      primaryArtist: primaryArtist ?? this.primaryArtist,
    );
  }
}

// アーティスト情報を表すクラス
class ArtistByUser {
  final String id;
  final String name;
  final String? imageUrl;
  final int fsp;
  final String status;
  final bool isAdmin;

  ArtistByUser({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.fsp,
    required this.status,
    required this.isAdmin,
  });

  factory ArtistByUser.fromJson(Map<String, dynamic> json) {
    return ArtistByUser(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?,
      fsp: json['fsp'] as int,
      status: json['status'] as String,
      isAdmin: json['isAdmin'] as bool,
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
