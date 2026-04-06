class Input$BlockUserInput {
  factory Input$BlockUserInput({
    required String blockedUserId,
    required String blockerUserId,
  }) =>
      Input$BlockUserInput._({
        r'blockedUserId': blockedUserId,
        r'blockerUserId': blockerUserId,
      });

  Input$BlockUserInput._(this._$data);

  factory Input$BlockUserInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$blockedUserId = data['blockedUserId'];
    result$data['blockedUserId'] = (l$blockedUserId as String);
    final l$blockerUserId = data['blockerUserId'];
    result$data['blockerUserId'] = (l$blockerUserId as String);
    return Input$BlockUserInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get blockedUserId => (_$data['blockedUserId'] as String);

  String get blockerUserId => (_$data['blockerUserId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$blockedUserId = blockedUserId;
    result$data['blockedUserId'] = l$blockedUserId;
    final l$blockerUserId = blockerUserId;
    result$data['blockerUserId'] = l$blockerUserId;
    return result$data;
  }

  CopyWith$Input$BlockUserInput<Input$BlockUserInput> get copyWith =>
      CopyWith$Input$BlockUserInput(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$BlockUserInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$blockedUserId = blockedUserId;
    final lOther$blockedUserId = other.blockedUserId;
    if (l$blockedUserId != lOther$blockedUserId) {
      return false;
    }
    final l$blockerUserId = blockerUserId;
    final lOther$blockerUserId = other.blockerUserId;
    if (l$blockerUserId != lOther$blockerUserId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$blockedUserId = blockedUserId;
    final l$blockerUserId = blockerUserId;
    return Object.hashAll([
      l$blockedUserId,
      l$blockerUserId,
    ]);
  }
}

abstract class CopyWith$Input$BlockUserInput<TRes> {
  factory CopyWith$Input$BlockUserInput(
    Input$BlockUserInput instance,
    TRes Function(Input$BlockUserInput) then,
  ) = _CopyWithImpl$Input$BlockUserInput;

  factory CopyWith$Input$BlockUserInput.stub(TRes res) =
      _CopyWithStubImpl$Input$BlockUserInput;

  TRes call({
    String? blockedUserId,
    String? blockerUserId,
  });
}

class _CopyWithImpl$Input$BlockUserInput<TRes>
    implements CopyWith$Input$BlockUserInput<TRes> {
  _CopyWithImpl$Input$BlockUserInput(
    this._instance,
    this._then,
  );

  final Input$BlockUserInput _instance;

  final TRes Function(Input$BlockUserInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? blockedUserId = _undefined,
    Object? blockerUserId = _undefined,
  }) =>
      _then(Input$BlockUserInput._({
        ..._instance._$data,
        if (blockedUserId != _undefined && blockedUserId != null)
          'blockedUserId': (blockedUserId as String),
        if (blockerUserId != _undefined && blockerUserId != null)
          'blockerUserId': (blockerUserId as String),
      }));
}

class _CopyWithStubImpl$Input$BlockUserInput<TRes>
    implements CopyWith$Input$BlockUserInput<TRes> {
  _CopyWithStubImpl$Input$BlockUserInput(this._res);

  TRes _res;

  call({
    String? blockedUserId,
    String? blockerUserId,
  }) =>
      _res;
}

class Input$ContactToAdminInput {
  factory Input$ContactToAdminInput({
    required String username,
    required String category,
    required String email,
    required String content,
  }) =>
      Input$ContactToAdminInput._({
        r'username': username,
        r'category': category,
        r'email': email,
        r'content': content,
      });

  Input$ContactToAdminInput._(this._$data);

  factory Input$ContactToAdminInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$username = data['username'];
    result$data['username'] = (l$username as String);
    final l$category = data['category'];
    result$data['category'] = (l$category as String);
    final l$email = data['email'];
    result$data['email'] = (l$email as String);
    final l$content = data['content'];
    result$data['content'] = (l$content as String);
    return Input$ContactToAdminInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get username => (_$data['username'] as String);

  String get category => (_$data['category'] as String);

  String get email => (_$data['email'] as String);

  String get content => (_$data['content'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$username = username;
    result$data['username'] = l$username;
    final l$category = category;
    result$data['category'] = l$category;
    final l$email = email;
    result$data['email'] = l$email;
    final l$content = content;
    result$data['content'] = l$content;
    return result$data;
  }

  CopyWith$Input$ContactToAdminInput<Input$ContactToAdminInput> get copyWith =>
      CopyWith$Input$ContactToAdminInput(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$ContactToAdminInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$username = username;
    final lOther$username = other.username;
    if (l$username != lOther$username) {
      return false;
    }
    final l$category = category;
    final lOther$category = other.category;
    if (l$category != lOther$category) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (l$email != lOther$email) {
      return false;
    }
    final l$content = content;
    final lOther$content = other.content;
    if (l$content != lOther$content) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$username = username;
    final l$category = category;
    final l$email = email;
    final l$content = content;
    return Object.hashAll([
      l$username,
      l$category,
      l$email,
      l$content,
    ]);
  }
}

abstract class CopyWith$Input$ContactToAdminInput<TRes> {
  factory CopyWith$Input$ContactToAdminInput(
    Input$ContactToAdminInput instance,
    TRes Function(Input$ContactToAdminInput) then,
  ) = _CopyWithImpl$Input$ContactToAdminInput;

  factory CopyWith$Input$ContactToAdminInput.stub(TRes res) =
      _CopyWithStubImpl$Input$ContactToAdminInput;

  TRes call({
    String? username,
    String? category,
    String? email,
    String? content,
  });
}

class _CopyWithImpl$Input$ContactToAdminInput<TRes>
    implements CopyWith$Input$ContactToAdminInput<TRes> {
  _CopyWithImpl$Input$ContactToAdminInput(
    this._instance,
    this._then,
  );

  final Input$ContactToAdminInput _instance;

  final TRes Function(Input$ContactToAdminInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? username = _undefined,
    Object? category = _undefined,
    Object? email = _undefined,
    Object? content = _undefined,
  }) =>
      _then(Input$ContactToAdminInput._({
        ..._instance._$data,
        if (username != _undefined && username != null)
          'username': (username as String),
        if (category != _undefined && category != null)
          'category': (category as String),
        if (email != _undefined && email != null) 'email': (email as String),
        if (content != _undefined && content != null)
          'content': (content as String),
      }));
}

class _CopyWithStubImpl$Input$ContactToAdminInput<TRes>
    implements CopyWith$Input$ContactToAdminInput<TRes> {
  _CopyWithStubImpl$Input$ContactToAdminInput(this._res);

  TRes _res;

  call({
    String? username,
    String? category,
    String? email,
    String? content,
  }) =>
      _res;
}

class Input$CreateNewArtistInput {
  factory Input$CreateNewArtistInput({
    required String displayNameJp,
    required String displayNameEn,
    String? displayNameKana,
    String? imgUrl,
    int? fsp,
    String? status,
    String? since,
    String? universalId,
    String? appleKey,
    String? spotifyKey,
    String? lineKey,
    String? amazonKey,
    String? youtubeKey,
  }) =>
      Input$CreateNewArtistInput._({
        r'displayNameJp': displayNameJp,
        r'displayNameEn': displayNameEn,
        if (displayNameKana != null) r'displayNameKana': displayNameKana,
        if (imgUrl != null) r'imgUrl': imgUrl,
        if (fsp != null) r'fsp': fsp,
        if (status != null) r'status': status,
        if (since != null) r'since': since,
        if (universalId != null) r'universalId': universalId,
        if (appleKey != null) r'appleKey': appleKey,
        if (spotifyKey != null) r'spotifyKey': spotifyKey,
        if (lineKey != null) r'lineKey': lineKey,
        if (amazonKey != null) r'amazonKey': amazonKey,
        if (youtubeKey != null) r'youtubeKey': youtubeKey,
      });

  Input$CreateNewArtistInput._(this._$data);

  factory Input$CreateNewArtistInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$displayNameJp = data['displayNameJp'];
    result$data['displayNameJp'] = (l$displayNameJp as String);
    final l$displayNameEn = data['displayNameEn'];
    result$data['displayNameEn'] = (l$displayNameEn as String);
    if (data.containsKey('displayNameKana')) {
      final l$displayNameKana = data['displayNameKana'];
      result$data['displayNameKana'] = (l$displayNameKana as String?);
    }
    if (data.containsKey('imgUrl')) {
      final l$imgUrl = data['imgUrl'];
      result$data['imgUrl'] = (l$imgUrl as String?);
    }
    if (data.containsKey('fsp')) {
      final l$fsp = data['fsp'];
      result$data['fsp'] = (l$fsp as int?);
    }
    if (data.containsKey('status')) {
      final l$status = data['status'];
      result$data['status'] = (l$status as String?);
    }
    if (data.containsKey('since')) {
      final l$since = data['since'];
      result$data['since'] = (l$since as String?);
    }
    if (data.containsKey('universalId')) {
      final l$universalId = data['universalId'];
      result$data['universalId'] = (l$universalId as String?);
    }
    if (data.containsKey('appleKey')) {
      final l$appleKey = data['appleKey'];
      result$data['appleKey'] = (l$appleKey as String?);
    }
    if (data.containsKey('spotifyKey')) {
      final l$spotifyKey = data['spotifyKey'];
      result$data['spotifyKey'] = (l$spotifyKey as String?);
    }
    if (data.containsKey('lineKey')) {
      final l$lineKey = data['lineKey'];
      result$data['lineKey'] = (l$lineKey as String?);
    }
    if (data.containsKey('amazonKey')) {
      final l$amazonKey = data['amazonKey'];
      result$data['amazonKey'] = (l$amazonKey as String?);
    }
    if (data.containsKey('youtubeKey')) {
      final l$youtubeKey = data['youtubeKey'];
      result$data['youtubeKey'] = (l$youtubeKey as String?);
    }
    return Input$CreateNewArtistInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get displayNameJp => (_$data['displayNameJp'] as String);

  String get displayNameEn => (_$data['displayNameEn'] as String);

  String? get displayNameKana => (_$data['displayNameKana'] as String?);

  String? get imgUrl => (_$data['imgUrl'] as String?);

  int? get fsp => (_$data['fsp'] as int?);

  String? get status => (_$data['status'] as String?);

  String? get since => (_$data['since'] as String?);

  String? get universalId => (_$data['universalId'] as String?);

  String? get appleKey => (_$data['appleKey'] as String?);

  String? get spotifyKey => (_$data['spotifyKey'] as String?);

  String? get lineKey => (_$data['lineKey'] as String?);

  String? get amazonKey => (_$data['amazonKey'] as String?);

  String? get youtubeKey => (_$data['youtubeKey'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$displayNameJp = displayNameJp;
    result$data['displayNameJp'] = l$displayNameJp;
    final l$displayNameEn = displayNameEn;
    result$data['displayNameEn'] = l$displayNameEn;
    if (_$data.containsKey('displayNameKana')) {
      final l$displayNameKana = displayNameKana;
      result$data['displayNameKana'] = l$displayNameKana;
    }
    if (_$data.containsKey('imgUrl')) {
      final l$imgUrl = imgUrl;
      result$data['imgUrl'] = l$imgUrl;
    }
    if (_$data.containsKey('fsp')) {
      final l$fsp = fsp;
      result$data['fsp'] = l$fsp;
    }
    if (_$data.containsKey('status')) {
      final l$status = status;
      result$data['status'] = l$status;
    }
    if (_$data.containsKey('since')) {
      final l$since = since;
      result$data['since'] = l$since;
    }
    if (_$data.containsKey('universalId')) {
      final l$universalId = universalId;
      result$data['universalId'] = l$universalId;
    }
    if (_$data.containsKey('appleKey')) {
      final l$appleKey = appleKey;
      result$data['appleKey'] = l$appleKey;
    }
    if (_$data.containsKey('spotifyKey')) {
      final l$spotifyKey = spotifyKey;
      result$data['spotifyKey'] = l$spotifyKey;
    }
    if (_$data.containsKey('lineKey')) {
      final l$lineKey = lineKey;
      result$data['lineKey'] = l$lineKey;
    }
    if (_$data.containsKey('amazonKey')) {
      final l$amazonKey = amazonKey;
      result$data['amazonKey'] = l$amazonKey;
    }
    if (_$data.containsKey('youtubeKey')) {
      final l$youtubeKey = youtubeKey;
      result$data['youtubeKey'] = l$youtubeKey;
    }
    return result$data;
  }

  CopyWith$Input$CreateNewArtistInput<Input$CreateNewArtistInput>
      get copyWith => CopyWith$Input$CreateNewArtistInput(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$CreateNewArtistInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$displayNameJp = displayNameJp;
    final lOther$displayNameJp = other.displayNameJp;
    if (l$displayNameJp != lOther$displayNameJp) {
      return false;
    }
    final l$displayNameEn = displayNameEn;
    final lOther$displayNameEn = other.displayNameEn;
    if (l$displayNameEn != lOther$displayNameEn) {
      return false;
    }
    final l$displayNameKana = displayNameKana;
    final lOther$displayNameKana = other.displayNameKana;
    if (_$data.containsKey('displayNameKana') !=
        other._$data.containsKey('displayNameKana')) {
      return false;
    }
    if (l$displayNameKana != lOther$displayNameKana) {
      return false;
    }
    final l$imgUrl = imgUrl;
    final lOther$imgUrl = other.imgUrl;
    if (_$data.containsKey('imgUrl') != other._$data.containsKey('imgUrl')) {
      return false;
    }
    if (l$imgUrl != lOther$imgUrl) {
      return false;
    }
    final l$fsp = fsp;
    final lOther$fsp = other.fsp;
    if (_$data.containsKey('fsp') != other._$data.containsKey('fsp')) {
      return false;
    }
    if (l$fsp != lOther$fsp) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (_$data.containsKey('status') != other._$data.containsKey('status')) {
      return false;
    }
    if (l$status != lOther$status) {
      return false;
    }
    final l$since = since;
    final lOther$since = other.since;
    if (_$data.containsKey('since') != other._$data.containsKey('since')) {
      return false;
    }
    if (l$since != lOther$since) {
      return false;
    }
    final l$universalId = universalId;
    final lOther$universalId = other.universalId;
    if (_$data.containsKey('universalId') !=
        other._$data.containsKey('universalId')) {
      return false;
    }
    if (l$universalId != lOther$universalId) {
      return false;
    }
    final l$appleKey = appleKey;
    final lOther$appleKey = other.appleKey;
    if (_$data.containsKey('appleKey') !=
        other._$data.containsKey('appleKey')) {
      return false;
    }
    if (l$appleKey != lOther$appleKey) {
      return false;
    }
    final l$spotifyKey = spotifyKey;
    final lOther$spotifyKey = other.spotifyKey;
    if (_$data.containsKey('spotifyKey') !=
        other._$data.containsKey('spotifyKey')) {
      return false;
    }
    if (l$spotifyKey != lOther$spotifyKey) {
      return false;
    }
    final l$lineKey = lineKey;
    final lOther$lineKey = other.lineKey;
    if (_$data.containsKey('lineKey') != other._$data.containsKey('lineKey')) {
      return false;
    }
    if (l$lineKey != lOther$lineKey) {
      return false;
    }
    final l$amazonKey = amazonKey;
    final lOther$amazonKey = other.amazonKey;
    if (_$data.containsKey('amazonKey') !=
        other._$data.containsKey('amazonKey')) {
      return false;
    }
    if (l$amazonKey != lOther$amazonKey) {
      return false;
    }
    final l$youtubeKey = youtubeKey;
    final lOther$youtubeKey = other.youtubeKey;
    if (_$data.containsKey('youtubeKey') !=
        other._$data.containsKey('youtubeKey')) {
      return false;
    }
    if (l$youtubeKey != lOther$youtubeKey) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$displayNameJp = displayNameJp;
    final l$displayNameEn = displayNameEn;
    final l$displayNameKana = displayNameKana;
    final l$imgUrl = imgUrl;
    final l$fsp = fsp;
    final l$status = status;
    final l$since = since;
    final l$universalId = universalId;
    final l$appleKey = appleKey;
    final l$spotifyKey = spotifyKey;
    final l$lineKey = lineKey;
    final l$amazonKey = amazonKey;
    final l$youtubeKey = youtubeKey;
    return Object.hashAll([
      l$displayNameJp,
      l$displayNameEn,
      _$data.containsKey('displayNameKana') ? l$displayNameKana : const {},
      _$data.containsKey('imgUrl') ? l$imgUrl : const {},
      _$data.containsKey('fsp') ? l$fsp : const {},
      _$data.containsKey('status') ? l$status : const {},
      _$data.containsKey('since') ? l$since : const {},
      _$data.containsKey('universalId') ? l$universalId : const {},
      _$data.containsKey('appleKey') ? l$appleKey : const {},
      _$data.containsKey('spotifyKey') ? l$spotifyKey : const {},
      _$data.containsKey('lineKey') ? l$lineKey : const {},
      _$data.containsKey('amazonKey') ? l$amazonKey : const {},
      _$data.containsKey('youtubeKey') ? l$youtubeKey : const {},
    ]);
  }
}

abstract class CopyWith$Input$CreateNewArtistInput<TRes> {
  factory CopyWith$Input$CreateNewArtistInput(
    Input$CreateNewArtistInput instance,
    TRes Function(Input$CreateNewArtistInput) then,
  ) = _CopyWithImpl$Input$CreateNewArtistInput;

  factory CopyWith$Input$CreateNewArtistInput.stub(TRes res) =
      _CopyWithStubImpl$Input$CreateNewArtistInput;

  TRes call({
    String? displayNameJp,
    String? displayNameEn,
    String? displayNameKana,
    String? imgUrl,
    int? fsp,
    String? status,
    String? since,
    String? universalId,
    String? appleKey,
    String? spotifyKey,
    String? lineKey,
    String? amazonKey,
    String? youtubeKey,
  });
}

class _CopyWithImpl$Input$CreateNewArtistInput<TRes>
    implements CopyWith$Input$CreateNewArtistInput<TRes> {
  _CopyWithImpl$Input$CreateNewArtistInput(
    this._instance,
    this._then,
  );

  final Input$CreateNewArtistInput _instance;

  final TRes Function(Input$CreateNewArtistInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? displayNameJp = _undefined,
    Object? displayNameEn = _undefined,
    Object? displayNameKana = _undefined,
    Object? imgUrl = _undefined,
    Object? fsp = _undefined,
    Object? status = _undefined,
    Object? since = _undefined,
    Object? universalId = _undefined,
    Object? appleKey = _undefined,
    Object? spotifyKey = _undefined,
    Object? lineKey = _undefined,
    Object? amazonKey = _undefined,
    Object? youtubeKey = _undefined,
  }) =>
      _then(Input$CreateNewArtistInput._({
        ..._instance._$data,
        if (displayNameJp != _undefined && displayNameJp != null)
          'displayNameJp': (displayNameJp as String),
        if (displayNameEn != _undefined && displayNameEn != null)
          'displayNameEn': (displayNameEn as String),
        if (displayNameKana != _undefined)
          'displayNameKana': (displayNameKana as String?),
        if (imgUrl != _undefined) 'imgUrl': (imgUrl as String?),
        if (fsp != _undefined) 'fsp': (fsp as int?),
        if (status != _undefined) 'status': (status as String?),
        if (since != _undefined) 'since': (since as String?),
        if (universalId != _undefined) 'universalId': (universalId as String?),
        if (appleKey != _undefined) 'appleKey': (appleKey as String?),
        if (spotifyKey != _undefined) 'spotifyKey': (spotifyKey as String?),
        if (lineKey != _undefined) 'lineKey': (lineKey as String?),
        if (amazonKey != _undefined) 'amazonKey': (amazonKey as String?),
        if (youtubeKey != _undefined) 'youtubeKey': (youtubeKey as String?),
      }));
}

class _CopyWithStubImpl$Input$CreateNewArtistInput<TRes>
    implements CopyWith$Input$CreateNewArtistInput<TRes> {
  _CopyWithStubImpl$Input$CreateNewArtistInput(this._res);

  TRes _res;

  call({
    String? displayNameJp,
    String? displayNameEn,
    String? displayNameKana,
    String? imgUrl,
    int? fsp,
    String? status,
    String? since,
    String? universalId,
    String? appleKey,
    String? spotifyKey,
    String? lineKey,
    String? amazonKey,
    String? youtubeKey,
  }) =>
      _res;
}

class Input$CreateNewMessageRoomInput {
  factory Input$CreateNewMessageRoomInput({
    required String category,
    required String createdBy,
    required List<String> userList,
  }) =>
      Input$CreateNewMessageRoomInput._({
        r'category': category,
        r'createdBy': createdBy,
        r'userList': userList,
      });

  Input$CreateNewMessageRoomInput._(this._$data);

  factory Input$CreateNewMessageRoomInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$category = data['category'];
    result$data['category'] = (l$category as String);
    final l$createdBy = data['createdBy'];
    result$data['createdBy'] = (l$createdBy as String);
    final l$userList = data['userList'];
    result$data['userList'] =
        (l$userList as List<dynamic>).map((e) => (e as String)).toList();
    return Input$CreateNewMessageRoomInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get category => (_$data['category'] as String);

  String get createdBy => (_$data['createdBy'] as String);

  List<String> get userList => (_$data['userList'] as List<String>);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$category = category;
    result$data['category'] = l$category;
    final l$createdBy = createdBy;
    result$data['createdBy'] = l$createdBy;
    final l$userList = userList;
    result$data['userList'] = l$userList.map((e) => e).toList();
    return result$data;
  }

  CopyWith$Input$CreateNewMessageRoomInput<Input$CreateNewMessageRoomInput>
      get copyWith => CopyWith$Input$CreateNewMessageRoomInput(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$CreateNewMessageRoomInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$category = category;
    final lOther$category = other.category;
    if (l$category != lOther$category) {
      return false;
    }
    final l$createdBy = createdBy;
    final lOther$createdBy = other.createdBy;
    if (l$createdBy != lOther$createdBy) {
      return false;
    }
    final l$userList = userList;
    final lOther$userList = other.userList;
    if (l$userList.length != lOther$userList.length) {
      return false;
    }
    for (int i = 0; i < l$userList.length; i++) {
      final l$userList$entry = l$userList[i];
      final lOther$userList$entry = lOther$userList[i];
      if (l$userList$entry != lOther$userList$entry) {
        return false;
      }
    }
    return true;
  }

  @override
  int get hashCode {
    final l$category = category;
    final l$createdBy = createdBy;
    final l$userList = userList;
    return Object.hashAll([
      l$category,
      l$createdBy,
      Object.hashAll(l$userList.map((v) => v)),
    ]);
  }
}

abstract class CopyWith$Input$CreateNewMessageRoomInput<TRes> {
  factory CopyWith$Input$CreateNewMessageRoomInput(
    Input$CreateNewMessageRoomInput instance,
    TRes Function(Input$CreateNewMessageRoomInput) then,
  ) = _CopyWithImpl$Input$CreateNewMessageRoomInput;

  factory CopyWith$Input$CreateNewMessageRoomInput.stub(TRes res) =
      _CopyWithStubImpl$Input$CreateNewMessageRoomInput;

  TRes call({
    String? category,
    String? createdBy,
    List<String>? userList,
  });
}

class _CopyWithImpl$Input$CreateNewMessageRoomInput<TRes>
    implements CopyWith$Input$CreateNewMessageRoomInput<TRes> {
  _CopyWithImpl$Input$CreateNewMessageRoomInput(
    this._instance,
    this._then,
  );

  final Input$CreateNewMessageRoomInput _instance;

  final TRes Function(Input$CreateNewMessageRoomInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? category = _undefined,
    Object? createdBy = _undefined,
    Object? userList = _undefined,
  }) =>
      _then(Input$CreateNewMessageRoomInput._({
        ..._instance._$data,
        if (category != _undefined && category != null)
          'category': (category as String),
        if (createdBy != _undefined && createdBy != null)
          'createdBy': (createdBy as String),
        if (userList != _undefined && userList != null)
          'userList': (userList as List<String>),
      }));
}

class _CopyWithStubImpl$Input$CreateNewMessageRoomInput<TRes>
    implements CopyWith$Input$CreateNewMessageRoomInput<TRes> {
  _CopyWithStubImpl$Input$CreateNewMessageRoomInput(this._res);

  TRes _res;

  call({
    String? category,
    String? createdBy,
    List<String>? userList,
  }) =>
      _res;
}

class Input$CreateNewOfferInput {
  factory Input$CreateNewOfferInput({
    required String owner,
    String? deadline,
    required String title,
    required String description,
    required int fee,
    String? imageUrl,
    int? raidId,
    String? category,
    required String place,
    String? attention,
    String? requiredSkill,
    String? targetRole,
    bool? publicity,
    List<String>? attachedImgs,
    List<String>? attachedFiles,
  }) =>
      Input$CreateNewOfferInput._({
        r'owner': owner,
        if (deadline != null) r'deadline': deadline,
        r'title': title,
        r'description': description,
        r'fee': fee,
        if (imageUrl != null) r'imageUrl': imageUrl,
        if (raidId != null) r'raidId': raidId,
        if (category != null) r'category': category,
        r'place': place,
        if (attention != null) r'attention': attention,
        if (requiredSkill != null) r'requiredSkill': requiredSkill,
        if (targetRole != null) r'targetRole': targetRole,
        if (publicity != null) r'publicity': publicity,
        if (attachedImgs != null) r'attachedImgs': attachedImgs,
        if (attachedFiles != null) r'attachedFiles': attachedFiles,
      });

  Input$CreateNewOfferInput._(this._$data);

  factory Input$CreateNewOfferInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$owner = data['owner'];
    result$data['owner'] = (l$owner as String);
    if (data.containsKey('deadline')) {
      final l$deadline = data['deadline'];
      result$data['deadline'] = (l$deadline as String?);
    }
    final l$title = data['title'];
    result$data['title'] = (l$title as String);
    final l$description = data['description'];
    result$data['description'] = (l$description as String);
    final l$fee = data['fee'];
    result$data['fee'] = (l$fee as int);
    if (data.containsKey('imageUrl')) {
      final l$imageUrl = data['imageUrl'];
      result$data['imageUrl'] = (l$imageUrl as String?);
    }
    if (data.containsKey('raidId')) {
      final l$raidId = data['raidId'];
      result$data['raidId'] = (l$raidId as int?);
    }
    if (data.containsKey('category')) {
      final l$category = data['category'];
      result$data['category'] = (l$category as String?);
    }
    final l$place = data['place'];
    result$data['place'] = (l$place as String);
    if (data.containsKey('attention')) {
      final l$attention = data['attention'];
      result$data['attention'] = (l$attention as String?);
    }
    if (data.containsKey('requiredSkill')) {
      final l$requiredSkill = data['requiredSkill'];
      result$data['requiredSkill'] = (l$requiredSkill as String?);
    }
    if (data.containsKey('targetRole')) {
      final l$targetRole = data['targetRole'];
      result$data['targetRole'] = (l$targetRole as String?);
    }
    if (data.containsKey('publicity')) {
      final l$publicity = data['publicity'];
      result$data['publicity'] = (l$publicity as bool?);
    }
    if (data.containsKey('attachedImgs')) {
      final l$attachedImgs = data['attachedImgs'];
      result$data['attachedImgs'] = (l$attachedImgs as List<dynamic>?)
          ?.map((e) => (e as String))
          .toList();
    }
    if (data.containsKey('attachedFiles')) {
      final l$attachedFiles = data['attachedFiles'];
      result$data['attachedFiles'] = (l$attachedFiles as List<dynamic>?)
          ?.map((e) => (e as String))
          .toList();
    }
    return Input$CreateNewOfferInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get owner => (_$data['owner'] as String);

  String? get deadline => (_$data['deadline'] as String?);

  String get title => (_$data['title'] as String);

  String get description => (_$data['description'] as String);

  int get fee => (_$data['fee'] as int);

  String? get imageUrl => (_$data['imageUrl'] as String?);

  int? get raidId => (_$data['raidId'] as int?);

  String? get category => (_$data['category'] as String?);

  String get place => (_$data['place'] as String);

  String? get attention => (_$data['attention'] as String?);

  String? get requiredSkill => (_$data['requiredSkill'] as String?);

  String? get targetRole => (_$data['targetRole'] as String?);

  bool? get publicity => (_$data['publicity'] as bool?);

  List<String>? get attachedImgs => (_$data['attachedImgs'] as List<String>?);

  List<String>? get attachedFiles => (_$data['attachedFiles'] as List<String>?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$owner = owner;
    result$data['owner'] = l$owner;
    if (_$data.containsKey('deadline')) {
      final l$deadline = deadline;
      result$data['deadline'] = l$deadline;
    }
    final l$title = title;
    result$data['title'] = l$title;
    final l$description = description;
    result$data['description'] = l$description;
    final l$fee = fee;
    result$data['fee'] = l$fee;
    if (_$data.containsKey('imageUrl')) {
      final l$imageUrl = imageUrl;
      result$data['imageUrl'] = l$imageUrl;
    }
    if (_$data.containsKey('raidId')) {
      final l$raidId = raidId;
      result$data['raidId'] = l$raidId;
    }
    if (_$data.containsKey('category')) {
      final l$category = category;
      result$data['category'] = l$category;
    }
    final l$place = place;
    result$data['place'] = l$place;
    if (_$data.containsKey('attention')) {
      final l$attention = attention;
      result$data['attention'] = l$attention;
    }
    if (_$data.containsKey('requiredSkill')) {
      final l$requiredSkill = requiredSkill;
      result$data['requiredSkill'] = l$requiredSkill;
    }
    if (_$data.containsKey('targetRole')) {
      final l$targetRole = targetRole;
      result$data['targetRole'] = l$targetRole;
    }
    if (_$data.containsKey('publicity')) {
      final l$publicity = publicity;
      result$data['publicity'] = l$publicity;
    }
    if (_$data.containsKey('attachedImgs')) {
      final l$attachedImgs = attachedImgs;
      result$data['attachedImgs'] = l$attachedImgs?.map((e) => e).toList();
    }
    if (_$data.containsKey('attachedFiles')) {
      final l$attachedFiles = attachedFiles;
      result$data['attachedFiles'] = l$attachedFiles?.map((e) => e).toList();
    }
    return result$data;
  }

  CopyWith$Input$CreateNewOfferInput<Input$CreateNewOfferInput> get copyWith =>
      CopyWith$Input$CreateNewOfferInput(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$CreateNewOfferInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$owner = owner;
    final lOther$owner = other.owner;
    if (l$owner != lOther$owner) {
      return false;
    }
    final l$deadline = deadline;
    final lOther$deadline = other.deadline;
    if (_$data.containsKey('deadline') !=
        other._$data.containsKey('deadline')) {
      return false;
    }
    if (l$deadline != lOther$deadline) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    final l$fee = fee;
    final lOther$fee = other.fee;
    if (l$fee != lOther$fee) {
      return false;
    }
    final l$imageUrl = imageUrl;
    final lOther$imageUrl = other.imageUrl;
    if (_$data.containsKey('imageUrl') !=
        other._$data.containsKey('imageUrl')) {
      return false;
    }
    if (l$imageUrl != lOther$imageUrl) {
      return false;
    }
    final l$raidId = raidId;
    final lOther$raidId = other.raidId;
    if (_$data.containsKey('raidId') != other._$data.containsKey('raidId')) {
      return false;
    }
    if (l$raidId != lOther$raidId) {
      return false;
    }
    final l$category = category;
    final lOther$category = other.category;
    if (_$data.containsKey('category') !=
        other._$data.containsKey('category')) {
      return false;
    }
    if (l$category != lOther$category) {
      return false;
    }
    final l$place = place;
    final lOther$place = other.place;
    if (l$place != lOther$place) {
      return false;
    }
    final l$attention = attention;
    final lOther$attention = other.attention;
    if (_$data.containsKey('attention') !=
        other._$data.containsKey('attention')) {
      return false;
    }
    if (l$attention != lOther$attention) {
      return false;
    }
    final l$requiredSkill = requiredSkill;
    final lOther$requiredSkill = other.requiredSkill;
    if (_$data.containsKey('requiredSkill') !=
        other._$data.containsKey('requiredSkill')) {
      return false;
    }
    if (l$requiredSkill != lOther$requiredSkill) {
      return false;
    }
    final l$targetRole = targetRole;
    final lOther$targetRole = other.targetRole;
    if (_$data.containsKey('targetRole') !=
        other._$data.containsKey('targetRole')) {
      return false;
    }
    if (l$targetRole != lOther$targetRole) {
      return false;
    }
    final l$publicity = publicity;
    final lOther$publicity = other.publicity;
    if (_$data.containsKey('publicity') !=
        other._$data.containsKey('publicity')) {
      return false;
    }
    if (l$publicity != lOther$publicity) {
      return false;
    }
    final l$attachedImgs = attachedImgs;
    final lOther$attachedImgs = other.attachedImgs;
    if (_$data.containsKey('attachedImgs') !=
        other._$data.containsKey('attachedImgs')) {
      return false;
    }
    if (l$attachedImgs != null && lOther$attachedImgs != null) {
      if (l$attachedImgs.length != lOther$attachedImgs.length) {
        return false;
      }
      for (int i = 0; i < l$attachedImgs.length; i++) {
        final l$attachedImgs$entry = l$attachedImgs[i];
        final lOther$attachedImgs$entry = lOther$attachedImgs[i];
        if (l$attachedImgs$entry != lOther$attachedImgs$entry) {
          return false;
        }
      }
    } else if (l$attachedImgs != lOther$attachedImgs) {
      return false;
    }
    final l$attachedFiles = attachedFiles;
    final lOther$attachedFiles = other.attachedFiles;
    if (_$data.containsKey('attachedFiles') !=
        other._$data.containsKey('attachedFiles')) {
      return false;
    }
    if (l$attachedFiles != null && lOther$attachedFiles != null) {
      if (l$attachedFiles.length != lOther$attachedFiles.length) {
        return false;
      }
      for (int i = 0; i < l$attachedFiles.length; i++) {
        final l$attachedFiles$entry = l$attachedFiles[i];
        final lOther$attachedFiles$entry = lOther$attachedFiles[i];
        if (l$attachedFiles$entry != lOther$attachedFiles$entry) {
          return false;
        }
      }
    } else if (l$attachedFiles != lOther$attachedFiles) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$owner = owner;
    final l$deadline = deadline;
    final l$title = title;
    final l$description = description;
    final l$fee = fee;
    final l$imageUrl = imageUrl;
    final l$raidId = raidId;
    final l$category = category;
    final l$place = place;
    final l$attention = attention;
    final l$requiredSkill = requiredSkill;
    final l$targetRole = targetRole;
    final l$publicity = publicity;
    final l$attachedImgs = attachedImgs;
    final l$attachedFiles = attachedFiles;
    return Object.hashAll([
      l$owner,
      _$data.containsKey('deadline') ? l$deadline : const {},
      l$title,
      l$description,
      l$fee,
      _$data.containsKey('imageUrl') ? l$imageUrl : const {},
      _$data.containsKey('raidId') ? l$raidId : const {},
      _$data.containsKey('category') ? l$category : const {},
      l$place,
      _$data.containsKey('attention') ? l$attention : const {},
      _$data.containsKey('requiredSkill') ? l$requiredSkill : const {},
      _$data.containsKey('targetRole') ? l$targetRole : const {},
      _$data.containsKey('publicity') ? l$publicity : const {},
      _$data.containsKey('attachedImgs')
          ? l$attachedImgs == null
              ? null
              : Object.hashAll(l$attachedImgs.map((v) => v))
          : const {},
      _$data.containsKey('attachedFiles')
          ? l$attachedFiles == null
              ? null
              : Object.hashAll(l$attachedFiles.map((v) => v))
          : const {},
    ]);
  }
}

abstract class CopyWith$Input$CreateNewOfferInput<TRes> {
  factory CopyWith$Input$CreateNewOfferInput(
    Input$CreateNewOfferInput instance,
    TRes Function(Input$CreateNewOfferInput) then,
  ) = _CopyWithImpl$Input$CreateNewOfferInput;

  factory CopyWith$Input$CreateNewOfferInput.stub(TRes res) =
      _CopyWithStubImpl$Input$CreateNewOfferInput;

  TRes call({
    String? owner,
    String? deadline,
    String? title,
    String? description,
    int? fee,
    String? imageUrl,
    int? raidId,
    String? category,
    String? place,
    String? attention,
    String? requiredSkill,
    String? targetRole,
    bool? publicity,
    List<String>? attachedImgs,
    List<String>? attachedFiles,
  });
}

class _CopyWithImpl$Input$CreateNewOfferInput<TRes>
    implements CopyWith$Input$CreateNewOfferInput<TRes> {
  _CopyWithImpl$Input$CreateNewOfferInput(
    this._instance,
    this._then,
  );

  final Input$CreateNewOfferInput _instance;

  final TRes Function(Input$CreateNewOfferInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? owner = _undefined,
    Object? deadline = _undefined,
    Object? title = _undefined,
    Object? description = _undefined,
    Object? fee = _undefined,
    Object? imageUrl = _undefined,
    Object? raidId = _undefined,
    Object? category = _undefined,
    Object? place = _undefined,
    Object? attention = _undefined,
    Object? requiredSkill = _undefined,
    Object? targetRole = _undefined,
    Object? publicity = _undefined,
    Object? attachedImgs = _undefined,
    Object? attachedFiles = _undefined,
  }) =>
      _then(Input$CreateNewOfferInput._({
        ..._instance._$data,
        if (owner != _undefined && owner != null) 'owner': (owner as String),
        if (deadline != _undefined) 'deadline': (deadline as String?),
        if (title != _undefined && title != null) 'title': (title as String),
        if (description != _undefined && description != null)
          'description': (description as String),
        if (fee != _undefined && fee != null) 'fee': (fee as int),
        if (imageUrl != _undefined) 'imageUrl': (imageUrl as String?),
        if (raidId != _undefined) 'raidId': (raidId as int?),
        if (category != _undefined) 'category': (category as String?),
        if (place != _undefined && place != null) 'place': (place as String),
        if (attention != _undefined) 'attention': (attention as String?),
        if (requiredSkill != _undefined)
          'requiredSkill': (requiredSkill as String?),
        if (targetRole != _undefined) 'targetRole': (targetRole as String?),
        if (publicity != _undefined) 'publicity': (publicity as bool?),
        if (attachedImgs != _undefined)
          'attachedImgs': (attachedImgs as List<String>?),
        if (attachedFiles != _undefined)
          'attachedFiles': (attachedFiles as List<String>?),
      }));
}

class _CopyWithStubImpl$Input$CreateNewOfferInput<TRes>
    implements CopyWith$Input$CreateNewOfferInput<TRes> {
  _CopyWithStubImpl$Input$CreateNewOfferInput(this._res);

  TRes _res;

  call({
    String? owner,
    String? deadline,
    String? title,
    String? description,
    int? fee,
    String? imageUrl,
    int? raidId,
    String? category,
    String? place,
    String? attention,
    String? requiredSkill,
    String? targetRole,
    bool? publicity,
    List<String>? attachedImgs,
    List<String>? attachedFiles,
  }) =>
      _res;
}

class Input$CreateNewPrizeInput {
  factory Input$CreateNewPrizeInput({
    required String name,
    required int point,
    required String description,
    required String representation,
    String? condition,
    String? imgUrl,
    bool? publicity,
  }) =>
      Input$CreateNewPrizeInput._({
        r'name': name,
        r'point': point,
        r'description': description,
        r'representation': representation,
        if (condition != null) r'condition': condition,
        if (imgUrl != null) r'imgUrl': imgUrl,
        if (publicity != null) r'publicity': publicity,
      });

  Input$CreateNewPrizeInput._(this._$data);

  factory Input$CreateNewPrizeInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$name = data['name'];
    result$data['name'] = (l$name as String);
    final l$point = data['point'];
    result$data['point'] = (l$point as int);
    final l$description = data['description'];
    result$data['description'] = (l$description as String);
    final l$representation = data['representation'];
    result$data['representation'] = (l$representation as String);
    if (data.containsKey('condition')) {
      final l$condition = data['condition'];
      result$data['condition'] = (l$condition as String?);
    }
    if (data.containsKey('imgUrl')) {
      final l$imgUrl = data['imgUrl'];
      result$data['imgUrl'] = (l$imgUrl as String?);
    }
    if (data.containsKey('publicity')) {
      final l$publicity = data['publicity'];
      result$data['publicity'] = (l$publicity as bool?);
    }
    return Input$CreateNewPrizeInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get name => (_$data['name'] as String);

  int get point => (_$data['point'] as int);

  String get description => (_$data['description'] as String);

  String get representation => (_$data['representation'] as String);

  String? get condition => (_$data['condition'] as String?);

  String? get imgUrl => (_$data['imgUrl'] as String?);

  bool? get publicity => (_$data['publicity'] as bool?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$name = name;
    result$data['name'] = l$name;
    final l$point = point;
    result$data['point'] = l$point;
    final l$description = description;
    result$data['description'] = l$description;
    final l$representation = representation;
    result$data['representation'] = l$representation;
    if (_$data.containsKey('condition')) {
      final l$condition = condition;
      result$data['condition'] = l$condition;
    }
    if (_$data.containsKey('imgUrl')) {
      final l$imgUrl = imgUrl;
      result$data['imgUrl'] = l$imgUrl;
    }
    if (_$data.containsKey('publicity')) {
      final l$publicity = publicity;
      result$data['publicity'] = l$publicity;
    }
    return result$data;
  }

  CopyWith$Input$CreateNewPrizeInput<Input$CreateNewPrizeInput> get copyWith =>
      CopyWith$Input$CreateNewPrizeInput(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$CreateNewPrizeInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$point = point;
    final lOther$point = other.point;
    if (l$point != lOther$point) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    final l$representation = representation;
    final lOther$representation = other.representation;
    if (l$representation != lOther$representation) {
      return false;
    }
    final l$condition = condition;
    final lOther$condition = other.condition;
    if (_$data.containsKey('condition') !=
        other._$data.containsKey('condition')) {
      return false;
    }
    if (l$condition != lOther$condition) {
      return false;
    }
    final l$imgUrl = imgUrl;
    final lOther$imgUrl = other.imgUrl;
    if (_$data.containsKey('imgUrl') != other._$data.containsKey('imgUrl')) {
      return false;
    }
    if (l$imgUrl != lOther$imgUrl) {
      return false;
    }
    final l$publicity = publicity;
    final lOther$publicity = other.publicity;
    if (_$data.containsKey('publicity') !=
        other._$data.containsKey('publicity')) {
      return false;
    }
    if (l$publicity != lOther$publicity) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$name = name;
    final l$point = point;
    final l$description = description;
    final l$representation = representation;
    final l$condition = condition;
    final l$imgUrl = imgUrl;
    final l$publicity = publicity;
    return Object.hashAll([
      l$name,
      l$point,
      l$description,
      l$representation,
      _$data.containsKey('condition') ? l$condition : const {},
      _$data.containsKey('imgUrl') ? l$imgUrl : const {},
      _$data.containsKey('publicity') ? l$publicity : const {},
    ]);
  }
}

abstract class CopyWith$Input$CreateNewPrizeInput<TRes> {
  factory CopyWith$Input$CreateNewPrizeInput(
    Input$CreateNewPrizeInput instance,
    TRes Function(Input$CreateNewPrizeInput) then,
  ) = _CopyWithImpl$Input$CreateNewPrizeInput;

  factory CopyWith$Input$CreateNewPrizeInput.stub(TRes res) =
      _CopyWithStubImpl$Input$CreateNewPrizeInput;

  TRes call({
    String? name,
    int? point,
    String? description,
    String? representation,
    String? condition,
    String? imgUrl,
    bool? publicity,
  });
}

class _CopyWithImpl$Input$CreateNewPrizeInput<TRes>
    implements CopyWith$Input$CreateNewPrizeInput<TRes> {
  _CopyWithImpl$Input$CreateNewPrizeInput(
    this._instance,
    this._then,
  );

  final Input$CreateNewPrizeInput _instance;

  final TRes Function(Input$CreateNewPrizeInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? name = _undefined,
    Object? point = _undefined,
    Object? description = _undefined,
    Object? representation = _undefined,
    Object? condition = _undefined,
    Object? imgUrl = _undefined,
    Object? publicity = _undefined,
  }) =>
      _then(Input$CreateNewPrizeInput._({
        ..._instance._$data,
        if (name != _undefined && name != null) 'name': (name as String),
        if (point != _undefined && point != null) 'point': (point as int),
        if (description != _undefined && description != null)
          'description': (description as String),
        if (representation != _undefined && representation != null)
          'representation': (representation as String),
        if (condition != _undefined) 'condition': (condition as String?),
        if (imgUrl != _undefined) 'imgUrl': (imgUrl as String?),
        if (publicity != _undefined) 'publicity': (publicity as bool?),
      }));
}

class _CopyWithStubImpl$Input$CreateNewPrizeInput<TRes>
    implements CopyWith$Input$CreateNewPrizeInput<TRes> {
  _CopyWithStubImpl$Input$CreateNewPrizeInput(this._res);

  TRes _res;

  call({
    String? name,
    int? point,
    String? description,
    String? representation,
    String? condition,
    String? imgUrl,
    bool? publicity,
  }) =>
      _res;
}

class Input$CreateNewTransactionInput {
  factory Input$CreateNewTransactionInput({
    String? from,
    required String to,
    required int amount,
    String? note,
  }) =>
      Input$CreateNewTransactionInput._({
        if (from != null) r'from': from,
        r'to': to,
        r'amount': amount,
        if (note != null) r'note': note,
      });

  Input$CreateNewTransactionInput._(this._$data);

  factory Input$CreateNewTransactionInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('from')) {
      final l$from = data['from'];
      result$data['from'] = (l$from as String?);
    }
    final l$to = data['to'];
    result$data['to'] = (l$to as String);
    final l$amount = data['amount'];
    result$data['amount'] = (l$amount as int);
    if (data.containsKey('note')) {
      final l$note = data['note'];
      result$data['note'] = (l$note as String?);
    }
    return Input$CreateNewTransactionInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String? get from => (_$data['from'] as String?);

  String get to => (_$data['to'] as String);

  int get amount => (_$data['amount'] as int);

  String? get note => (_$data['note'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('from')) {
      final l$from = from;
      result$data['from'] = l$from;
    }
    final l$to = to;
    result$data['to'] = l$to;
    final l$amount = amount;
    result$data['amount'] = l$amount;
    if (_$data.containsKey('note')) {
      final l$note = note;
      result$data['note'] = l$note;
    }
    return result$data;
  }

  CopyWith$Input$CreateNewTransactionInput<Input$CreateNewTransactionInput>
      get copyWith => CopyWith$Input$CreateNewTransactionInput(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$CreateNewTransactionInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$from = from;
    final lOther$from = other.from;
    if (_$data.containsKey('from') != other._$data.containsKey('from')) {
      return false;
    }
    if (l$from != lOther$from) {
      return false;
    }
    final l$to = to;
    final lOther$to = other.to;
    if (l$to != lOther$to) {
      return false;
    }
    final l$amount = amount;
    final lOther$amount = other.amount;
    if (l$amount != lOther$amount) {
      return false;
    }
    final l$note = note;
    final lOther$note = other.note;
    if (_$data.containsKey('note') != other._$data.containsKey('note')) {
      return false;
    }
    if (l$note != lOther$note) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$from = from;
    final l$to = to;
    final l$amount = amount;
    final l$note = note;
    return Object.hashAll([
      _$data.containsKey('from') ? l$from : const {},
      l$to,
      l$amount,
      _$data.containsKey('note') ? l$note : const {},
    ]);
  }
}

abstract class CopyWith$Input$CreateNewTransactionInput<TRes> {
  factory CopyWith$Input$CreateNewTransactionInput(
    Input$CreateNewTransactionInput instance,
    TRes Function(Input$CreateNewTransactionInput) then,
  ) = _CopyWithImpl$Input$CreateNewTransactionInput;

  factory CopyWith$Input$CreateNewTransactionInput.stub(TRes res) =
      _CopyWithStubImpl$Input$CreateNewTransactionInput;

  TRes call({
    String? from,
    String? to,
    int? amount,
    String? note,
  });
}

class _CopyWithImpl$Input$CreateNewTransactionInput<TRes>
    implements CopyWith$Input$CreateNewTransactionInput<TRes> {
  _CopyWithImpl$Input$CreateNewTransactionInput(
    this._instance,
    this._then,
  );

  final Input$CreateNewTransactionInput _instance;

  final TRes Function(Input$CreateNewTransactionInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? from = _undefined,
    Object? to = _undefined,
    Object? amount = _undefined,
    Object? note = _undefined,
  }) =>
      _then(Input$CreateNewTransactionInput._({
        ..._instance._$data,
        if (from != _undefined) 'from': (from as String?),
        if (to != _undefined && to != null) 'to': (to as String),
        if (amount != _undefined && amount != null) 'amount': (amount as int),
        if (note != _undefined) 'note': (note as String?),
      }));
}

class _CopyWithStubImpl$Input$CreateNewTransactionInput<TRes>
    implements CopyWith$Input$CreateNewTransactionInput<TRes> {
  _CopyWithStubImpl$Input$CreateNewTransactionInput(this._res);

  TRes _res;

  call({
    String? from,
    String? to,
    int? amount,
    String? note,
  }) =>
      _res;
}

class Input$CreateNewUserDataInput {
  factory Input$CreateNewUserDataInput({
    required String id,
    String? fcmToken,
    required String email,
    required String name,
    required String realname,
    String? imageUrl,
    String? invitedBy,
    required String category,
    required String primaryCategory,
  }) =>
      Input$CreateNewUserDataInput._({
        r'id': id,
        if (fcmToken != null) r'fcmToken': fcmToken,
        r'email': email,
        r'name': name,
        r'realname': realname,
        if (imageUrl != null) r'imageUrl': imageUrl,
        if (invitedBy != null) r'invitedBy': invitedBy,
        r'category': category,
        r'primaryCategory': primaryCategory,
      });

  Input$CreateNewUserDataInput._(this._$data);

  factory Input$CreateNewUserDataInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    if (data.containsKey('fcmToken')) {
      final l$fcmToken = data['fcmToken'];
      result$data['fcmToken'] = (l$fcmToken as String?);
    }
    final l$email = data['email'];
    result$data['email'] = (l$email as String);
    final l$name = data['name'];
    result$data['name'] = (l$name as String);
    final l$realname = data['realname'];
    result$data['realname'] = (l$realname as String);
    if (data.containsKey('imageUrl')) {
      final l$imageUrl = data['imageUrl'];
      result$data['imageUrl'] = (l$imageUrl as String?);
    }
    if (data.containsKey('invitedBy')) {
      final l$invitedBy = data['invitedBy'];
      result$data['invitedBy'] = (l$invitedBy as String?);
    }
    final l$category = data['category'];
    result$data['category'] = (l$category as String);
    final l$primaryCategory = data['primaryCategory'];
    result$data['primaryCategory'] = (l$primaryCategory as String);
    return Input$CreateNewUserDataInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  String? get fcmToken => (_$data['fcmToken'] as String?);

  String get email => (_$data['email'] as String);

  String get name => (_$data['name'] as String);

  String get realname => (_$data['realname'] as String);

  String? get imageUrl => (_$data['imageUrl'] as String?);

  String? get invitedBy => (_$data['invitedBy'] as String?);

  String get category => (_$data['category'] as String);

  String get primaryCategory => (_$data['primaryCategory'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    if (_$data.containsKey('fcmToken')) {
      final l$fcmToken = fcmToken;
      result$data['fcmToken'] = l$fcmToken;
    }
    final l$email = email;
    result$data['email'] = l$email;
    final l$name = name;
    result$data['name'] = l$name;
    final l$realname = realname;
    result$data['realname'] = l$realname;
    if (_$data.containsKey('imageUrl')) {
      final l$imageUrl = imageUrl;
      result$data['imageUrl'] = l$imageUrl;
    }
    if (_$data.containsKey('invitedBy')) {
      final l$invitedBy = invitedBy;
      result$data['invitedBy'] = l$invitedBy;
    }
    final l$category = category;
    result$data['category'] = l$category;
    final l$primaryCategory = primaryCategory;
    result$data['primaryCategory'] = l$primaryCategory;
    return result$data;
  }

  CopyWith$Input$CreateNewUserDataInput<Input$CreateNewUserDataInput>
      get copyWith => CopyWith$Input$CreateNewUserDataInput(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$CreateNewUserDataInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$fcmToken = fcmToken;
    final lOther$fcmToken = other.fcmToken;
    if (_$data.containsKey('fcmToken') !=
        other._$data.containsKey('fcmToken')) {
      return false;
    }
    if (l$fcmToken != lOther$fcmToken) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (l$email != lOther$email) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$realname = realname;
    final lOther$realname = other.realname;
    if (l$realname != lOther$realname) {
      return false;
    }
    final l$imageUrl = imageUrl;
    final lOther$imageUrl = other.imageUrl;
    if (_$data.containsKey('imageUrl') !=
        other._$data.containsKey('imageUrl')) {
      return false;
    }
    if (l$imageUrl != lOther$imageUrl) {
      return false;
    }
    final l$invitedBy = invitedBy;
    final lOther$invitedBy = other.invitedBy;
    if (_$data.containsKey('invitedBy') !=
        other._$data.containsKey('invitedBy')) {
      return false;
    }
    if (l$invitedBy != lOther$invitedBy) {
      return false;
    }
    final l$category = category;
    final lOther$category = other.category;
    if (l$category != lOther$category) {
      return false;
    }
    final l$primaryCategory = primaryCategory;
    final lOther$primaryCategory = other.primaryCategory;
    if (l$primaryCategory != lOther$primaryCategory) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$fcmToken = fcmToken;
    final l$email = email;
    final l$name = name;
    final l$realname = realname;
    final l$imageUrl = imageUrl;
    final l$invitedBy = invitedBy;
    final l$category = category;
    final l$primaryCategory = primaryCategory;
    return Object.hashAll([
      l$id,
      _$data.containsKey('fcmToken') ? l$fcmToken : const {},
      l$email,
      l$name,
      l$realname,
      _$data.containsKey('imageUrl') ? l$imageUrl : const {},
      _$data.containsKey('invitedBy') ? l$invitedBy : const {},
      l$category,
      l$primaryCategory,
    ]);
  }
}

abstract class CopyWith$Input$CreateNewUserDataInput<TRes> {
  factory CopyWith$Input$CreateNewUserDataInput(
    Input$CreateNewUserDataInput instance,
    TRes Function(Input$CreateNewUserDataInput) then,
  ) = _CopyWithImpl$Input$CreateNewUserDataInput;

  factory CopyWith$Input$CreateNewUserDataInput.stub(TRes res) =
      _CopyWithStubImpl$Input$CreateNewUserDataInput;

  TRes call({
    String? id,
    String? fcmToken,
    String? email,
    String? name,
    String? realname,
    String? imageUrl,
    String? invitedBy,
    String? category,
    String? primaryCategory,
  });
}

class _CopyWithImpl$Input$CreateNewUserDataInput<TRes>
    implements CopyWith$Input$CreateNewUserDataInput<TRes> {
  _CopyWithImpl$Input$CreateNewUserDataInput(
    this._instance,
    this._then,
  );

  final Input$CreateNewUserDataInput _instance;

  final TRes Function(Input$CreateNewUserDataInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? fcmToken = _undefined,
    Object? email = _undefined,
    Object? name = _undefined,
    Object? realname = _undefined,
    Object? imageUrl = _undefined,
    Object? invitedBy = _undefined,
    Object? category = _undefined,
    Object? primaryCategory = _undefined,
  }) =>
      _then(Input$CreateNewUserDataInput._({
        ..._instance._$data,
        if (id != _undefined && id != null) 'id': (id as String),
        if (fcmToken != _undefined) 'fcmToken': (fcmToken as String?),
        if (email != _undefined && email != null) 'email': (email as String),
        if (name != _undefined && name != null) 'name': (name as String),
        if (realname != _undefined && realname != null)
          'realname': (realname as String),
        if (imageUrl != _undefined) 'imageUrl': (imageUrl as String?),
        if (invitedBy != _undefined) 'invitedBy': (invitedBy as String?),
        if (category != _undefined && category != null)
          'category': (category as String),
        if (primaryCategory != _undefined && primaryCategory != null)
          'primaryCategory': (primaryCategory as String),
      }));
}

class _CopyWithStubImpl$Input$CreateNewUserDataInput<TRes>
    implements CopyWith$Input$CreateNewUserDataInput<TRes> {
  _CopyWithStubImpl$Input$CreateNewUserDataInput(this._res);

  TRes _res;

  call({
    String? id,
    String? fcmToken,
    String? email,
    String? name,
    String? realname,
    String? imageUrl,
    String? invitedBy,
    String? category,
    String? primaryCategory,
  }) =>
      _res;
}

class Input$CreateQuestInput {
  factory Input$CreateQuestInput({
    required String name,
    required String description,
  }) =>
      Input$CreateQuestInput._({
        r'name': name,
        r'description': description,
      });

  Input$CreateQuestInput._(this._$data);

  factory Input$CreateQuestInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$name = data['name'];
    result$data['name'] = (l$name as String);
    final l$description = data['description'];
    result$data['description'] = (l$description as String);
    return Input$CreateQuestInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get name => (_$data['name'] as String);

  String get description => (_$data['description'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$name = name;
    result$data['name'] = l$name;
    final l$description = description;
    result$data['description'] = l$description;
    return result$data;
  }

  CopyWith$Input$CreateQuestInput<Input$CreateQuestInput> get copyWith =>
      CopyWith$Input$CreateQuestInput(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$CreateQuestInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$name = name;
    final l$description = description;
    return Object.hashAll([
      l$name,
      l$description,
    ]);
  }
}

abstract class CopyWith$Input$CreateQuestInput<TRes> {
  factory CopyWith$Input$CreateQuestInput(
    Input$CreateQuestInput instance,
    TRes Function(Input$CreateQuestInput) then,
  ) = _CopyWithImpl$Input$CreateQuestInput;

  factory CopyWith$Input$CreateQuestInput.stub(TRes res) =
      _CopyWithStubImpl$Input$CreateQuestInput;

  TRes call({
    String? name,
    String? description,
  });
}

class _CopyWithImpl$Input$CreateQuestInput<TRes>
    implements CopyWith$Input$CreateQuestInput<TRes> {
  _CopyWithImpl$Input$CreateQuestInput(
    this._instance,
    this._then,
  );

  final Input$CreateQuestInput _instance;

  final TRes Function(Input$CreateQuestInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? name = _undefined,
    Object? description = _undefined,
  }) =>
      _then(Input$CreateQuestInput._({
        ..._instance._$data,
        if (name != _undefined && name != null) 'name': (name as String),
        if (description != _undefined && description != null)
          'description': (description as String),
      }));
}

class _CopyWithStubImpl$Input$CreateQuestInput<TRes>
    implements CopyWith$Input$CreateQuestInput<TRes> {
  _CopyWithStubImpl$Input$CreateQuestInput(this._res);

  TRes _res;

  call({
    String? name,
    String? description,
  }) =>
      _res;
}

class Input$DeleteCreditInput {
  factory Input$DeleteCreditInput({required int creditId}) =>
      Input$DeleteCreditInput._({
        r'creditId': creditId,
      });

  Input$DeleteCreditInput._(this._$data);

  factory Input$DeleteCreditInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$creditId = data['creditId'];
    result$data['creditId'] = (l$creditId as int);
    return Input$DeleteCreditInput._(result$data);
  }

  Map<String, dynamic> _$data;

  int get creditId => (_$data['creditId'] as int);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$creditId = creditId;
    result$data['creditId'] = l$creditId;
    return result$data;
  }

  CopyWith$Input$DeleteCreditInput<Input$DeleteCreditInput> get copyWith =>
      CopyWith$Input$DeleteCreditInput(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$DeleteCreditInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$creditId = creditId;
    final lOther$creditId = other.creditId;
    if (l$creditId != lOther$creditId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$creditId = creditId;
    return Object.hashAll([l$creditId]);
  }
}

abstract class CopyWith$Input$DeleteCreditInput<TRes> {
  factory CopyWith$Input$DeleteCreditInput(
    Input$DeleteCreditInput instance,
    TRes Function(Input$DeleteCreditInput) then,
  ) = _CopyWithImpl$Input$DeleteCreditInput;

  factory CopyWith$Input$DeleteCreditInput.stub(TRes res) =
      _CopyWithStubImpl$Input$DeleteCreditInput;

  TRes call({int? creditId});
}

class _CopyWithImpl$Input$DeleteCreditInput<TRes>
    implements CopyWith$Input$DeleteCreditInput<TRes> {
  _CopyWithImpl$Input$DeleteCreditInput(
    this._instance,
    this._then,
  );

  final Input$DeleteCreditInput _instance;

  final TRes Function(Input$DeleteCreditInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? creditId = _undefined}) =>
      _then(Input$DeleteCreditInput._({
        ..._instance._$data,
        if (creditId != _undefined && creditId != null)
          'creditId': (creditId as int),
      }));
}

class _CopyWithStubImpl$Input$DeleteCreditInput<TRes>
    implements CopyWith$Input$DeleteCreditInput<TRes> {
  _CopyWithStubImpl$Input$DeleteCreditInput(this._res);

  TRes _res;

  call({int? creditId}) => _res;
}

class Input$DeleteOfferInput {
  factory Input$DeleteOfferInput({required int id}) =>
      Input$DeleteOfferInput._({
        r'id': id,
      });

  Input$DeleteOfferInput._(this._$data);

  factory Input$DeleteOfferInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as int);
    return Input$DeleteOfferInput._(result$data);
  }

  Map<String, dynamic> _$data;

  int get id => (_$data['id'] as int);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    return result$data;
  }

  CopyWith$Input$DeleteOfferInput<Input$DeleteOfferInput> get copyWith =>
      CopyWith$Input$DeleteOfferInput(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$DeleteOfferInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    return Object.hashAll([l$id]);
  }
}

abstract class CopyWith$Input$DeleteOfferInput<TRes> {
  factory CopyWith$Input$DeleteOfferInput(
    Input$DeleteOfferInput instance,
    TRes Function(Input$DeleteOfferInput) then,
  ) = _CopyWithImpl$Input$DeleteOfferInput;

  factory CopyWith$Input$DeleteOfferInput.stub(TRes res) =
      _CopyWithStubImpl$Input$DeleteOfferInput;

  TRes call({int? id});
}

class _CopyWithImpl$Input$DeleteOfferInput<TRes>
    implements CopyWith$Input$DeleteOfferInput<TRes> {
  _CopyWithImpl$Input$DeleteOfferInput(
    this._instance,
    this._then,
  );

  final Input$DeleteOfferInput _instance;

  final TRes Function(Input$DeleteOfferInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? id = _undefined}) => _then(Input$DeleteOfferInput._({
        ..._instance._$data,
        if (id != _undefined && id != null) 'id': (id as int),
      }));
}

class _CopyWithStubImpl$Input$DeleteOfferInput<TRes>
    implements CopyWith$Input$DeleteOfferInput<TRes> {
  _CopyWithStubImpl$Input$DeleteOfferInput(this._res);

  TRes _res;

  call({int? id}) => _res;
}

class Input$DeletePortfolioInput {
  factory Input$DeletePortfolioInput({required int id}) =>
      Input$DeletePortfolioInput._({
        r'id': id,
      });

  Input$DeletePortfolioInput._(this._$data);

  factory Input$DeletePortfolioInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as int);
    return Input$DeletePortfolioInput._(result$data);
  }

  Map<String, dynamic> _$data;

  int get id => (_$data['id'] as int);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    return result$data;
  }

  CopyWith$Input$DeletePortfolioInput<Input$DeletePortfolioInput>
      get copyWith => CopyWith$Input$DeletePortfolioInput(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$DeletePortfolioInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    return Object.hashAll([l$id]);
  }
}

abstract class CopyWith$Input$DeletePortfolioInput<TRes> {
  factory CopyWith$Input$DeletePortfolioInput(
    Input$DeletePortfolioInput instance,
    TRes Function(Input$DeletePortfolioInput) then,
  ) = _CopyWithImpl$Input$DeletePortfolioInput;

  factory CopyWith$Input$DeletePortfolioInput.stub(TRes res) =
      _CopyWithStubImpl$Input$DeletePortfolioInput;

  TRes call({int? id});
}

class _CopyWithImpl$Input$DeletePortfolioInput<TRes>
    implements CopyWith$Input$DeletePortfolioInput<TRes> {
  _CopyWithImpl$Input$DeletePortfolioInput(
    this._instance,
    this._then,
  );

  final Input$DeletePortfolioInput _instance;

  final TRes Function(Input$DeletePortfolioInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? id = _undefined}) => _then(Input$DeletePortfolioInput._({
        ..._instance._$data,
        if (id != _undefined && id != null) 'id': (id as int),
      }));
}

class _CopyWithStubImpl$Input$DeletePortfolioInput<TRes>
    implements CopyWith$Input$DeletePortfolioInput<TRes> {
  _CopyWithStubImpl$Input$DeletePortfolioInput(this._res);

  TRes _res;

  call({int? id}) => _res;
}

class Input$ExchangePrizeInput {
  factory Input$ExchangePrizeInput({
    required String userId,
    required int prizeId,
    int? amount,
  }) =>
      Input$ExchangePrizeInput._({
        r'userId': userId,
        r'prizeId': prizeId,
        if (amount != null) r'amount': amount,
      });

  Input$ExchangePrizeInput._(this._$data);

  factory Input$ExchangePrizeInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    final l$prizeId = data['prizeId'];
    result$data['prizeId'] = (l$prizeId as int);
    if (data.containsKey('amount')) {
      final l$amount = data['amount'];
      result$data['amount'] = (l$amount as int?);
    }
    return Input$ExchangePrizeInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  int get prizeId => (_$data['prizeId'] as int);

  int? get amount => (_$data['amount'] as int?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$userId = userId;
    result$data['userId'] = l$userId;
    final l$prizeId = prizeId;
    result$data['prizeId'] = l$prizeId;
    if (_$data.containsKey('amount')) {
      final l$amount = amount;
      result$data['amount'] = l$amount;
    }
    return result$data;
  }

  CopyWith$Input$ExchangePrizeInput<Input$ExchangePrizeInput> get copyWith =>
      CopyWith$Input$ExchangePrizeInput(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$ExchangePrizeInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$prizeId = prizeId;
    final lOther$prizeId = other.prizeId;
    if (l$prizeId != lOther$prizeId) {
      return false;
    }
    final l$amount = amount;
    final lOther$amount = other.amount;
    if (_$data.containsKey('amount') != other._$data.containsKey('amount')) {
      return false;
    }
    if (l$amount != lOther$amount) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$prizeId = prizeId;
    final l$amount = amount;
    return Object.hashAll([
      l$userId,
      l$prizeId,
      _$data.containsKey('amount') ? l$amount : const {},
    ]);
  }
}

abstract class CopyWith$Input$ExchangePrizeInput<TRes> {
  factory CopyWith$Input$ExchangePrizeInput(
    Input$ExchangePrizeInput instance,
    TRes Function(Input$ExchangePrizeInput) then,
  ) = _CopyWithImpl$Input$ExchangePrizeInput;

  factory CopyWith$Input$ExchangePrizeInput.stub(TRes res) =
      _CopyWithStubImpl$Input$ExchangePrizeInput;

  TRes call({
    String? userId,
    int? prizeId,
    int? amount,
  });
}

class _CopyWithImpl$Input$ExchangePrizeInput<TRes>
    implements CopyWith$Input$ExchangePrizeInput<TRes> {
  _CopyWithImpl$Input$ExchangePrizeInput(
    this._instance,
    this._then,
  );

  final Input$ExchangePrizeInput _instance;

  final TRes Function(Input$ExchangePrizeInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? userId = _undefined,
    Object? prizeId = _undefined,
    Object? amount = _undefined,
  }) =>
      _then(Input$ExchangePrizeInput._({
        ..._instance._$data,
        if (userId != _undefined && userId != null)
          'userId': (userId as String),
        if (prizeId != _undefined && prizeId != null)
          'prizeId': (prizeId as int),
        if (amount != _undefined) 'amount': (amount as int?),
      }));
}

class _CopyWithStubImpl$Input$ExchangePrizeInput<TRes>
    implements CopyWith$Input$ExchangePrizeInput<TRes> {
  _CopyWithStubImpl$Input$ExchangePrizeInput(this._res);

  TRes _res;

  call({
    String? userId,
    int? prizeId,
    int? amount,
  }) =>
      _res;
}

class Input$MarkAsAdminInput {
  factory Input$MarkAsAdminInput({
    required String adminMember,
    required String userId,
    required String artistId,
  }) =>
      Input$MarkAsAdminInput._({
        r'adminMember': adminMember,
        r'userId': userId,
        r'artistId': artistId,
      });

  Input$MarkAsAdminInput._(this._$data);

  factory Input$MarkAsAdminInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$adminMember = data['adminMember'];
    result$data['adminMember'] = (l$adminMember as String);
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    final l$artistId = data['artistId'];
    result$data['artistId'] = (l$artistId as String);
    return Input$MarkAsAdminInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get adminMember => (_$data['adminMember'] as String);

  String get userId => (_$data['userId'] as String);

  String get artistId => (_$data['artistId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$adminMember = adminMember;
    result$data['adminMember'] = l$adminMember;
    final l$userId = userId;
    result$data['userId'] = l$userId;
    final l$artistId = artistId;
    result$data['artistId'] = l$artistId;
    return result$data;
  }

  CopyWith$Input$MarkAsAdminInput<Input$MarkAsAdminInput> get copyWith =>
      CopyWith$Input$MarkAsAdminInput(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$MarkAsAdminInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$adminMember = adminMember;
    final lOther$adminMember = other.adminMember;
    if (l$adminMember != lOther$adminMember) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$artistId = artistId;
    final lOther$artistId = other.artistId;
    if (l$artistId != lOther$artistId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$adminMember = adminMember;
    final l$userId = userId;
    final l$artistId = artistId;
    return Object.hashAll([
      l$adminMember,
      l$userId,
      l$artistId,
    ]);
  }
}

abstract class CopyWith$Input$MarkAsAdminInput<TRes> {
  factory CopyWith$Input$MarkAsAdminInput(
    Input$MarkAsAdminInput instance,
    TRes Function(Input$MarkAsAdminInput) then,
  ) = _CopyWithImpl$Input$MarkAsAdminInput;

  factory CopyWith$Input$MarkAsAdminInput.stub(TRes res) =
      _CopyWithStubImpl$Input$MarkAsAdminInput;

  TRes call({
    String? adminMember,
    String? userId,
    String? artistId,
  });
}

class _CopyWithImpl$Input$MarkAsAdminInput<TRes>
    implements CopyWith$Input$MarkAsAdminInput<TRes> {
  _CopyWithImpl$Input$MarkAsAdminInput(
    this._instance,
    this._then,
  );

  final Input$MarkAsAdminInput _instance;

  final TRes Function(Input$MarkAsAdminInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? adminMember = _undefined,
    Object? userId = _undefined,
    Object? artistId = _undefined,
  }) =>
      _then(Input$MarkAsAdminInput._({
        ..._instance._$data,
        if (adminMember != _undefined && adminMember != null)
          'adminMember': (adminMember as String),
        if (userId != _undefined && userId != null)
          'userId': (userId as String),
        if (artistId != _undefined && artistId != null)
          'artistId': (artistId as String),
      }));
}

class _CopyWithStubImpl$Input$MarkAsAdminInput<TRes>
    implements CopyWith$Input$MarkAsAdminInput<TRes> {
  _CopyWithStubImpl$Input$MarkAsAdminInput(this._res);

  TRes _res;

  call({
    String? adminMember,
    String? userId,
    String? artistId,
  }) =>
      _res;
}

class Input$MarkAsMemberInput {
  factory Input$MarkAsMemberInput({
    required String member,
    required String artistId,
    required List<Input$StatusUser> mapping,
  }) =>
      Input$MarkAsMemberInput._({
        r'member': member,
        r'artistId': artistId,
        r'mapping': mapping,
      });

  Input$MarkAsMemberInput._(this._$data);

  factory Input$MarkAsMemberInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$member = data['member'];
    result$data['member'] = (l$member as String);
    final l$artistId = data['artistId'];
    result$data['artistId'] = (l$artistId as String);
    final l$mapping = data['mapping'];
    result$data['mapping'] = (l$mapping as List<dynamic>)
        .map((e) => Input$StatusUser.fromJson((e as Map<String, dynamic>)))
        .toList();
    return Input$MarkAsMemberInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get member => (_$data['member'] as String);

  String get artistId => (_$data['artistId'] as String);

  List<Input$StatusUser> get mapping =>
      (_$data['mapping'] as List<Input$StatusUser>);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$member = member;
    result$data['member'] = l$member;
    final l$artistId = artistId;
    result$data['artistId'] = l$artistId;
    final l$mapping = mapping;
    result$data['mapping'] = l$mapping.map((e) => e.toJson()).toList();
    return result$data;
  }

  CopyWith$Input$MarkAsMemberInput<Input$MarkAsMemberInput> get copyWith =>
      CopyWith$Input$MarkAsMemberInput(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$MarkAsMemberInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$member = member;
    final lOther$member = other.member;
    if (l$member != lOther$member) {
      return false;
    }
    final l$artistId = artistId;
    final lOther$artistId = other.artistId;
    if (l$artistId != lOther$artistId) {
      return false;
    }
    final l$mapping = mapping;
    final lOther$mapping = other.mapping;
    if (l$mapping.length != lOther$mapping.length) {
      return false;
    }
    for (int i = 0; i < l$mapping.length; i++) {
      final l$mapping$entry = l$mapping[i];
      final lOther$mapping$entry = lOther$mapping[i];
      if (l$mapping$entry != lOther$mapping$entry) {
        return false;
      }
    }
    return true;
  }

  @override
  int get hashCode {
    final l$member = member;
    final l$artistId = artistId;
    final l$mapping = mapping;
    return Object.hashAll([
      l$member,
      l$artistId,
      Object.hashAll(l$mapping.map((v) => v)),
    ]);
  }
}

abstract class CopyWith$Input$MarkAsMemberInput<TRes> {
  factory CopyWith$Input$MarkAsMemberInput(
    Input$MarkAsMemberInput instance,
    TRes Function(Input$MarkAsMemberInput) then,
  ) = _CopyWithImpl$Input$MarkAsMemberInput;

  factory CopyWith$Input$MarkAsMemberInput.stub(TRes res) =
      _CopyWithStubImpl$Input$MarkAsMemberInput;

  TRes call({
    String? member,
    String? artistId,
    List<Input$StatusUser>? mapping,
  });
  TRes mapping(
      Iterable<Input$StatusUser> Function(
              Iterable<CopyWith$Input$StatusUser<Input$StatusUser>>)
          _fn);
}

class _CopyWithImpl$Input$MarkAsMemberInput<TRes>
    implements CopyWith$Input$MarkAsMemberInput<TRes> {
  _CopyWithImpl$Input$MarkAsMemberInput(
    this._instance,
    this._then,
  );

  final Input$MarkAsMemberInput _instance;

  final TRes Function(Input$MarkAsMemberInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? member = _undefined,
    Object? artistId = _undefined,
    Object? mapping = _undefined,
  }) =>
      _then(Input$MarkAsMemberInput._({
        ..._instance._$data,
        if (member != _undefined && member != null)
          'member': (member as String),
        if (artistId != _undefined && artistId != null)
          'artistId': (artistId as String),
        if (mapping != _undefined && mapping != null)
          'mapping': (mapping as List<Input$StatusUser>),
      }));

  TRes mapping(
          Iterable<Input$StatusUser> Function(
                  Iterable<CopyWith$Input$StatusUser<Input$StatusUser>>)
              _fn) =>
      call(
          mapping: _fn(_instance.mapping.map((e) => CopyWith$Input$StatusUser(
                e,
                (i) => i,
              ))).toList());
}

class _CopyWithStubImpl$Input$MarkAsMemberInput<TRes>
    implements CopyWith$Input$MarkAsMemberInput<TRes> {
  _CopyWithStubImpl$Input$MarkAsMemberInput(this._res);

  TRes _res;

  call({
    String? member,
    String? artistId,
    List<Input$StatusUser>? mapping,
  }) =>
      _res;

  mapping(_fn) => _res;
}

class Input$MarkAsReadInput {
  factory Input$MarkAsReadInput({
    required String roomId,
    required String userId,
    required String messageId,
  }) =>
      Input$MarkAsReadInput._({
        r'roomId': roomId,
        r'userId': userId,
        r'messageId': messageId,
      });

  Input$MarkAsReadInput._(this._$data);

  factory Input$MarkAsReadInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$roomId = data['roomId'];
    result$data['roomId'] = (l$roomId as String);
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    final l$messageId = data['messageId'];
    result$data['messageId'] = (l$messageId as String);
    return Input$MarkAsReadInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get roomId => (_$data['roomId'] as String);

  String get userId => (_$data['userId'] as String);

  String get messageId => (_$data['messageId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$roomId = roomId;
    result$data['roomId'] = l$roomId;
    final l$userId = userId;
    result$data['userId'] = l$userId;
    final l$messageId = messageId;
    result$data['messageId'] = l$messageId;
    return result$data;
  }

  CopyWith$Input$MarkAsReadInput<Input$MarkAsReadInput> get copyWith =>
      CopyWith$Input$MarkAsReadInput(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$MarkAsReadInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$roomId = roomId;
    final lOther$roomId = other.roomId;
    if (l$roomId != lOther$roomId) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$messageId = messageId;
    final lOther$messageId = other.messageId;
    if (l$messageId != lOther$messageId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$roomId = roomId;
    final l$userId = userId;
    final l$messageId = messageId;
    return Object.hashAll([
      l$roomId,
      l$userId,
      l$messageId,
    ]);
  }
}

abstract class CopyWith$Input$MarkAsReadInput<TRes> {
  factory CopyWith$Input$MarkAsReadInput(
    Input$MarkAsReadInput instance,
    TRes Function(Input$MarkAsReadInput) then,
  ) = _CopyWithImpl$Input$MarkAsReadInput;

  factory CopyWith$Input$MarkAsReadInput.stub(TRes res) =
      _CopyWithStubImpl$Input$MarkAsReadInput;

  TRes call({
    String? roomId,
    String? userId,
    String? messageId,
  });
}

class _CopyWithImpl$Input$MarkAsReadInput<TRes>
    implements CopyWith$Input$MarkAsReadInput<TRes> {
  _CopyWithImpl$Input$MarkAsReadInput(
    this._instance,
    this._then,
  );

  final Input$MarkAsReadInput _instance;

  final TRes Function(Input$MarkAsReadInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? roomId = _undefined,
    Object? userId = _undefined,
    Object? messageId = _undefined,
  }) =>
      _then(Input$MarkAsReadInput._({
        ..._instance._$data,
        if (roomId != _undefined && roomId != null)
          'roomId': (roomId as String),
        if (userId != _undefined && userId != null)
          'userId': (userId as String),
        if (messageId != _undefined && messageId != null)
          'messageId': (messageId as String),
      }));
}

class _CopyWithStubImpl$Input$MarkAsReadInput<TRes>
    implements CopyWith$Input$MarkAsReadInput<TRes> {
  _CopyWithStubImpl$Input$MarkAsReadInput(this._res);

  TRes _res;

  call({
    String? roomId,
    String? userId,
    String? messageId,
  }) =>
      _res;
}

class Input$RegisterCreditInput {
  factory Input$RegisterCreditInput(
          {required List<Input$RegisterInfo> registerInfo}) =>
      Input$RegisterCreditInput._({
        r'registerInfo': registerInfo,
      });

  Input$RegisterCreditInput._(this._$data);

  factory Input$RegisterCreditInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$registerInfo = data['registerInfo'];
    result$data['registerInfo'] = (l$registerInfo as List<dynamic>)
        .map((e) => Input$RegisterInfo.fromJson((e as Map<String, dynamic>)))
        .toList();
    return Input$RegisterCreditInput._(result$data);
  }

  Map<String, dynamic> _$data;

  List<Input$RegisterInfo> get registerInfo =>
      (_$data['registerInfo'] as List<Input$RegisterInfo>);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$registerInfo = registerInfo;
    result$data['registerInfo'] =
        l$registerInfo.map((e) => e.toJson()).toList();
    return result$data;
  }

  CopyWith$Input$RegisterCreditInput<Input$RegisterCreditInput> get copyWith =>
      CopyWith$Input$RegisterCreditInput(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$RegisterCreditInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$registerInfo = registerInfo;
    final lOther$registerInfo = other.registerInfo;
    if (l$registerInfo.length != lOther$registerInfo.length) {
      return false;
    }
    for (int i = 0; i < l$registerInfo.length; i++) {
      final l$registerInfo$entry = l$registerInfo[i];
      final lOther$registerInfo$entry = lOther$registerInfo[i];
      if (l$registerInfo$entry != lOther$registerInfo$entry) {
        return false;
      }
    }
    return true;
  }

  @override
  int get hashCode {
    final l$registerInfo = registerInfo;
    return Object.hashAll([Object.hashAll(l$registerInfo.map((v) => v))]);
  }
}

abstract class CopyWith$Input$RegisterCreditInput<TRes> {
  factory CopyWith$Input$RegisterCreditInput(
    Input$RegisterCreditInput instance,
    TRes Function(Input$RegisterCreditInput) then,
  ) = _CopyWithImpl$Input$RegisterCreditInput;

  factory CopyWith$Input$RegisterCreditInput.stub(TRes res) =
      _CopyWithStubImpl$Input$RegisterCreditInput;

  TRes call({List<Input$RegisterInfo>? registerInfo});
  TRes registerInfo(
      Iterable<Input$RegisterInfo> Function(
              Iterable<CopyWith$Input$RegisterInfo<Input$RegisterInfo>>)
          _fn);
}

class _CopyWithImpl$Input$RegisterCreditInput<TRes>
    implements CopyWith$Input$RegisterCreditInput<TRes> {
  _CopyWithImpl$Input$RegisterCreditInput(
    this._instance,
    this._then,
  );

  final Input$RegisterCreditInput _instance;

  final TRes Function(Input$RegisterCreditInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? registerInfo = _undefined}) =>
      _then(Input$RegisterCreditInput._({
        ..._instance._$data,
        if (registerInfo != _undefined && registerInfo != null)
          'registerInfo': (registerInfo as List<Input$RegisterInfo>),
      }));

  TRes registerInfo(
          Iterable<Input$RegisterInfo> Function(
                  Iterable<CopyWith$Input$RegisterInfo<Input$RegisterInfo>>)
              _fn) =>
      call(
          registerInfo:
              _fn(_instance.registerInfo.map((e) => CopyWith$Input$RegisterInfo(
                    e,
                    (i) => i,
                  ))).toList());
}

class _CopyWithStubImpl$Input$RegisterCreditInput<TRes>
    implements CopyWith$Input$RegisterCreditInput<TRes> {
  _CopyWithStubImpl$Input$RegisterCreditInput(this._res);

  TRes _res;

  call({List<Input$RegisterInfo>? registerInfo}) => _res;

  registerInfo(_fn) => _res;
}

class Input$RegisterInfo {
  factory Input$RegisterInfo({
    required String isrc,
    required String commitUser,
    required String creditRole,
    required String creditName,
    required String email,
    required bool isInvite,
    String? memo,
  }) =>
      Input$RegisterInfo._({
        r'isrc': isrc,
        r'commitUser': commitUser,
        r'creditRole': creditRole,
        r'creditName': creditName,
        r'email': email,
        r'isInvite': isInvite,
        if (memo != null) r'memo': memo,
      });

  Input$RegisterInfo._(this._$data);

  factory Input$RegisterInfo.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$isrc = data['isrc'];
    result$data['isrc'] = (l$isrc as String);
    final l$commitUser = data['commitUser'];
    result$data['commitUser'] = (l$commitUser as String);
    final l$creditRole = data['creditRole'];
    result$data['creditRole'] = (l$creditRole as String);
    final l$creditName = data['creditName'];
    result$data['creditName'] = (l$creditName as String);
    final l$email = data['email'];
    result$data['email'] = (l$email as String);
    final l$isInvite = data['isInvite'];
    result$data['isInvite'] = (l$isInvite as bool);
    if (data.containsKey('memo')) {
      final l$memo = data['memo'];
      result$data['memo'] = (l$memo as String?);
    }
    return Input$RegisterInfo._(result$data);
  }

  Map<String, dynamic> _$data;

  String get isrc => (_$data['isrc'] as String);

  String get commitUser => (_$data['commitUser'] as String);

  String get creditRole => (_$data['creditRole'] as String);

  String get creditName => (_$data['creditName'] as String);

  String get email => (_$data['email'] as String);

  bool get isInvite => (_$data['isInvite'] as bool);

  String? get memo => (_$data['memo'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$isrc = isrc;
    result$data['isrc'] = l$isrc;
    final l$commitUser = commitUser;
    result$data['commitUser'] = l$commitUser;
    final l$creditRole = creditRole;
    result$data['creditRole'] = l$creditRole;
    final l$creditName = creditName;
    result$data['creditName'] = l$creditName;
    final l$email = email;
    result$data['email'] = l$email;
    final l$isInvite = isInvite;
    result$data['isInvite'] = l$isInvite;
    if (_$data.containsKey('memo')) {
      final l$memo = memo;
      result$data['memo'] = l$memo;
    }
    return result$data;
  }

  CopyWith$Input$RegisterInfo<Input$RegisterInfo> get copyWith =>
      CopyWith$Input$RegisterInfo(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$RegisterInfo || runtimeType != other.runtimeType) {
      return false;
    }
    final l$isrc = isrc;
    final lOther$isrc = other.isrc;
    if (l$isrc != lOther$isrc) {
      return false;
    }
    final l$commitUser = commitUser;
    final lOther$commitUser = other.commitUser;
    if (l$commitUser != lOther$commitUser) {
      return false;
    }
    final l$creditRole = creditRole;
    final lOther$creditRole = other.creditRole;
    if (l$creditRole != lOther$creditRole) {
      return false;
    }
    final l$creditName = creditName;
    final lOther$creditName = other.creditName;
    if (l$creditName != lOther$creditName) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (l$email != lOther$email) {
      return false;
    }
    final l$isInvite = isInvite;
    final lOther$isInvite = other.isInvite;
    if (l$isInvite != lOther$isInvite) {
      return false;
    }
    final l$memo = memo;
    final lOther$memo = other.memo;
    if (_$data.containsKey('memo') != other._$data.containsKey('memo')) {
      return false;
    }
    if (l$memo != lOther$memo) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$isrc = isrc;
    final l$commitUser = commitUser;
    final l$creditRole = creditRole;
    final l$creditName = creditName;
    final l$email = email;
    final l$isInvite = isInvite;
    final l$memo = memo;
    return Object.hashAll([
      l$isrc,
      l$commitUser,
      l$creditRole,
      l$creditName,
      l$email,
      l$isInvite,
      _$data.containsKey('memo') ? l$memo : const {},
    ]);
  }
}

abstract class CopyWith$Input$RegisterInfo<TRes> {
  factory CopyWith$Input$RegisterInfo(
    Input$RegisterInfo instance,
    TRes Function(Input$RegisterInfo) then,
  ) = _CopyWithImpl$Input$RegisterInfo;

  factory CopyWith$Input$RegisterInfo.stub(TRes res) =
      _CopyWithStubImpl$Input$RegisterInfo;

  TRes call({
    String? isrc,
    String? commitUser,
    String? creditRole,
    String? creditName,
    String? email,
    bool? isInvite,
    String? memo,
  });
}

class _CopyWithImpl$Input$RegisterInfo<TRes>
    implements CopyWith$Input$RegisterInfo<TRes> {
  _CopyWithImpl$Input$RegisterInfo(
    this._instance,
    this._then,
  );

  final Input$RegisterInfo _instance;

  final TRes Function(Input$RegisterInfo) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? isrc = _undefined,
    Object? commitUser = _undefined,
    Object? creditRole = _undefined,
    Object? creditName = _undefined,
    Object? email = _undefined,
    Object? isInvite = _undefined,
    Object? memo = _undefined,
  }) =>
      _then(Input$RegisterInfo._({
        ..._instance._$data,
        if (isrc != _undefined && isrc != null) 'isrc': (isrc as String),
        if (commitUser != _undefined && commitUser != null)
          'commitUser': (commitUser as String),
        if (creditRole != _undefined && creditRole != null)
          'creditRole': (creditRole as String),
        if (creditName != _undefined && creditName != null)
          'creditName': (creditName as String),
        if (email != _undefined && email != null) 'email': (email as String),
        if (isInvite != _undefined && isInvite != null)
          'isInvite': (isInvite as bool),
        if (memo != _undefined) 'memo': (memo as String?),
      }));
}

class _CopyWithStubImpl$Input$RegisterInfo<TRes>
    implements CopyWith$Input$RegisterInfo<TRes> {
  _CopyWithStubImpl$Input$RegisterInfo(this._res);

  TRes _res;

  call({
    String? isrc,
    String? commitUser,
    String? creditRole,
    String? creditName,
    String? email,
    bool? isInvite,
    String? memo,
  }) =>
      _res;
}

class Input$RegisterPortfolioInput {
  factory Input$RegisterPortfolioInput({
    required String userId,
    required String title,
    required String description,
    required String imgUrl,
    required String category,
    required String releaseDate,
    required String externalUrl,
  }) =>
      Input$RegisterPortfolioInput._({
        r'userId': userId,
        r'title': title,
        r'description': description,
        r'imgUrl': imgUrl,
        r'category': category,
        r'releaseDate': releaseDate,
        r'externalUrl': externalUrl,
      });

  Input$RegisterPortfolioInput._(this._$data);

  factory Input$RegisterPortfolioInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    final l$title = data['title'];
    result$data['title'] = (l$title as String);
    final l$description = data['description'];
    result$data['description'] = (l$description as String);
    final l$imgUrl = data['imgUrl'];
    result$data['imgUrl'] = (l$imgUrl as String);
    final l$category = data['category'];
    result$data['category'] = (l$category as String);
    final l$releaseDate = data['releaseDate'];
    result$data['releaseDate'] = (l$releaseDate as String);
    final l$externalUrl = data['externalUrl'];
    result$data['externalUrl'] = (l$externalUrl as String);
    return Input$RegisterPortfolioInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  String get title => (_$data['title'] as String);

  String get description => (_$data['description'] as String);

  String get imgUrl => (_$data['imgUrl'] as String);

  String get category => (_$data['category'] as String);

  String get releaseDate => (_$data['releaseDate'] as String);

  String get externalUrl => (_$data['externalUrl'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$userId = userId;
    result$data['userId'] = l$userId;
    final l$title = title;
    result$data['title'] = l$title;
    final l$description = description;
    result$data['description'] = l$description;
    final l$imgUrl = imgUrl;
    result$data['imgUrl'] = l$imgUrl;
    final l$category = category;
    result$data['category'] = l$category;
    final l$releaseDate = releaseDate;
    result$data['releaseDate'] = l$releaseDate;
    final l$externalUrl = externalUrl;
    result$data['externalUrl'] = l$externalUrl;
    return result$data;
  }

  CopyWith$Input$RegisterPortfolioInput<Input$RegisterPortfolioInput>
      get copyWith => CopyWith$Input$RegisterPortfolioInput(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$RegisterPortfolioInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    final l$imgUrl = imgUrl;
    final lOther$imgUrl = other.imgUrl;
    if (l$imgUrl != lOther$imgUrl) {
      return false;
    }
    final l$category = category;
    final lOther$category = other.category;
    if (l$category != lOther$category) {
      return false;
    }
    final l$releaseDate = releaseDate;
    final lOther$releaseDate = other.releaseDate;
    if (l$releaseDate != lOther$releaseDate) {
      return false;
    }
    final l$externalUrl = externalUrl;
    final lOther$externalUrl = other.externalUrl;
    if (l$externalUrl != lOther$externalUrl) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$title = title;
    final l$description = description;
    final l$imgUrl = imgUrl;
    final l$category = category;
    final l$releaseDate = releaseDate;
    final l$externalUrl = externalUrl;
    return Object.hashAll([
      l$userId,
      l$title,
      l$description,
      l$imgUrl,
      l$category,
      l$releaseDate,
      l$externalUrl,
    ]);
  }
}

abstract class CopyWith$Input$RegisterPortfolioInput<TRes> {
  factory CopyWith$Input$RegisterPortfolioInput(
    Input$RegisterPortfolioInput instance,
    TRes Function(Input$RegisterPortfolioInput) then,
  ) = _CopyWithImpl$Input$RegisterPortfolioInput;

  factory CopyWith$Input$RegisterPortfolioInput.stub(TRes res) =
      _CopyWithStubImpl$Input$RegisterPortfolioInput;

  TRes call({
    String? userId,
    String? title,
    String? description,
    String? imgUrl,
    String? category,
    String? releaseDate,
    String? externalUrl,
  });
}

class _CopyWithImpl$Input$RegisterPortfolioInput<TRes>
    implements CopyWith$Input$RegisterPortfolioInput<TRes> {
  _CopyWithImpl$Input$RegisterPortfolioInput(
    this._instance,
    this._then,
  );

  final Input$RegisterPortfolioInput _instance;

  final TRes Function(Input$RegisterPortfolioInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? userId = _undefined,
    Object? title = _undefined,
    Object? description = _undefined,
    Object? imgUrl = _undefined,
    Object? category = _undefined,
    Object? releaseDate = _undefined,
    Object? externalUrl = _undefined,
  }) =>
      _then(Input$RegisterPortfolioInput._({
        ..._instance._$data,
        if (userId != _undefined && userId != null)
          'userId': (userId as String),
        if (title != _undefined && title != null) 'title': (title as String),
        if (description != _undefined && description != null)
          'description': (description as String),
        if (imgUrl != _undefined && imgUrl != null)
          'imgUrl': (imgUrl as String),
        if (category != _undefined && category != null)
          'category': (category as String),
        if (releaseDate != _undefined && releaseDate != null)
          'releaseDate': (releaseDate as String),
        if (externalUrl != _undefined && externalUrl != null)
          'externalUrl': (externalUrl as String),
      }));
}

class _CopyWithStubImpl$Input$RegisterPortfolioInput<TRes>
    implements CopyWith$Input$RegisterPortfolioInput<TRes> {
  _CopyWithStubImpl$Input$RegisterPortfolioInput(this._res);

  TRes _res;

  call({
    String? userId,
    String? title,
    String? description,
    String? imgUrl,
    String? category,
    String? releaseDate,
    String? externalUrl,
  }) =>
      _res;
}

class Input$RegisterReleases {
  factory Input$RegisterReleases({required List<Input$ReleaseData> releases}) =>
      Input$RegisterReleases._({
        r'releases': releases,
      });

  Input$RegisterReleases._(this._$data);

  factory Input$RegisterReleases.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$releases = data['releases'];
    result$data['releases'] = (l$releases as List<dynamic>)
        .map((e) => Input$ReleaseData.fromJson((e as Map<String, dynamic>)))
        .toList();
    return Input$RegisterReleases._(result$data);
  }

  Map<String, dynamic> _$data;

  List<Input$ReleaseData> get releases =>
      (_$data['releases'] as List<Input$ReleaseData>);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$releases = releases;
    result$data['releases'] = l$releases.map((e) => e.toJson()).toList();
    return result$data;
  }

  CopyWith$Input$RegisterReleases<Input$RegisterReleases> get copyWith =>
      CopyWith$Input$RegisterReleases(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$RegisterReleases || runtimeType != other.runtimeType) {
      return false;
    }
    final l$releases = releases;
    final lOther$releases = other.releases;
    if (l$releases.length != lOther$releases.length) {
      return false;
    }
    for (int i = 0; i < l$releases.length; i++) {
      final l$releases$entry = l$releases[i];
      final lOther$releases$entry = lOther$releases[i];
      if (l$releases$entry != lOther$releases$entry) {
        return false;
      }
    }
    return true;
  }

  @override
  int get hashCode {
    final l$releases = releases;
    return Object.hashAll([Object.hashAll(l$releases.map((v) => v))]);
  }
}

abstract class CopyWith$Input$RegisterReleases<TRes> {
  factory CopyWith$Input$RegisterReleases(
    Input$RegisterReleases instance,
    TRes Function(Input$RegisterReleases) then,
  ) = _CopyWithImpl$Input$RegisterReleases;

  factory CopyWith$Input$RegisterReleases.stub(TRes res) =
      _CopyWithStubImpl$Input$RegisterReleases;

  TRes call({List<Input$ReleaseData>? releases});
  TRes releases(
      Iterable<Input$ReleaseData> Function(
              Iterable<CopyWith$Input$ReleaseData<Input$ReleaseData>>)
          _fn);
}

class _CopyWithImpl$Input$RegisterReleases<TRes>
    implements CopyWith$Input$RegisterReleases<TRes> {
  _CopyWithImpl$Input$RegisterReleases(
    this._instance,
    this._then,
  );

  final Input$RegisterReleases _instance;

  final TRes Function(Input$RegisterReleases) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? releases = _undefined}) => _then(Input$RegisterReleases._({
        ..._instance._$data,
        if (releases != _undefined && releases != null)
          'releases': (releases as List<Input$ReleaseData>),
      }));

  TRes releases(
          Iterable<Input$ReleaseData> Function(
                  Iterable<CopyWith$Input$ReleaseData<Input$ReleaseData>>)
              _fn) =>
      call(
          releases:
              _fn(_instance.releases.map((e) => CopyWith$Input$ReleaseData(
                    e,
                    (i) => i,
                  ))).toList());
}

class _CopyWithStubImpl$Input$RegisterReleases<TRes>
    implements CopyWith$Input$RegisterReleases<TRes> {
  _CopyWithStubImpl$Input$RegisterReleases(this._res);

  TRes _res;

  call({List<Input$ReleaseData>? releases}) => _res;

  releases(_fn) => _res;
}

class Input$ReleaseData {
  factory Input$ReleaseData({
    required String upc,
    required String format,
    required int trackCount,
    required String title,
    required String releaseDate,
    required String isrc,
    required int trackNo,
    required String trackTitle,
    required String trackTitleVersion,
    required String artistId,
    String? imageUrl,
  }) =>
      Input$ReleaseData._({
        r'upc': upc,
        r'format': format,
        r'trackCount': trackCount,
        r'title': title,
        r'releaseDate': releaseDate,
        r'isrc': isrc,
        r'trackNo': trackNo,
        r'trackTitle': trackTitle,
        r'trackTitleVersion': trackTitleVersion,
        r'artistId': artistId,
        if (imageUrl != null) r'imageUrl': imageUrl,
      });

  Input$ReleaseData._(this._$data);

  factory Input$ReleaseData.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$upc = data['upc'];
    result$data['upc'] = (l$upc as String);
    final l$format = data['format'];
    result$data['format'] = (l$format as String);
    final l$trackCount = data['trackCount'];
    result$data['trackCount'] = (l$trackCount as int);
    final l$title = data['title'];
    result$data['title'] = (l$title as String);
    final l$releaseDate = data['releaseDate'];
    result$data['releaseDate'] = (l$releaseDate as String);
    final l$isrc = data['isrc'];
    result$data['isrc'] = (l$isrc as String);
    final l$trackNo = data['trackNo'];
    result$data['trackNo'] = (l$trackNo as int);
    final l$trackTitle = data['trackTitle'];
    result$data['trackTitle'] = (l$trackTitle as String);
    final l$trackTitleVersion = data['trackTitleVersion'];
    result$data['trackTitleVersion'] = (l$trackTitleVersion as String);
    final l$artistId = data['artistId'];
    result$data['artistId'] = (l$artistId as String);
    if (data.containsKey('imageUrl')) {
      final l$imageUrl = data['imageUrl'];
      result$data['imageUrl'] = (l$imageUrl as String?);
    }
    return Input$ReleaseData._(result$data);
  }

  Map<String, dynamic> _$data;

  String get upc => (_$data['upc'] as String);

  String get format => (_$data['format'] as String);

  int get trackCount => (_$data['trackCount'] as int);

  String get title => (_$data['title'] as String);

  String get releaseDate => (_$data['releaseDate'] as String);

  String get isrc => (_$data['isrc'] as String);

  int get trackNo => (_$data['trackNo'] as int);

  String get trackTitle => (_$data['trackTitle'] as String);

  String get trackTitleVersion => (_$data['trackTitleVersion'] as String);

  String get artistId => (_$data['artistId'] as String);

  String? get imageUrl => (_$data['imageUrl'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$upc = upc;
    result$data['upc'] = l$upc;
    final l$format = format;
    result$data['format'] = l$format;
    final l$trackCount = trackCount;
    result$data['trackCount'] = l$trackCount;
    final l$title = title;
    result$data['title'] = l$title;
    final l$releaseDate = releaseDate;
    result$data['releaseDate'] = l$releaseDate;
    final l$isrc = isrc;
    result$data['isrc'] = l$isrc;
    final l$trackNo = trackNo;
    result$data['trackNo'] = l$trackNo;
    final l$trackTitle = trackTitle;
    result$data['trackTitle'] = l$trackTitle;
    final l$trackTitleVersion = trackTitleVersion;
    result$data['trackTitleVersion'] = l$trackTitleVersion;
    final l$artistId = artistId;
    result$data['artistId'] = l$artistId;
    if (_$data.containsKey('imageUrl')) {
      final l$imageUrl = imageUrl;
      result$data['imageUrl'] = l$imageUrl;
    }
    return result$data;
  }

  CopyWith$Input$ReleaseData<Input$ReleaseData> get copyWith =>
      CopyWith$Input$ReleaseData(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$ReleaseData || runtimeType != other.runtimeType) {
      return false;
    }
    final l$upc = upc;
    final lOther$upc = other.upc;
    if (l$upc != lOther$upc) {
      return false;
    }
    final l$format = format;
    final lOther$format = other.format;
    if (l$format != lOther$format) {
      return false;
    }
    final l$trackCount = trackCount;
    final lOther$trackCount = other.trackCount;
    if (l$trackCount != lOther$trackCount) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$releaseDate = releaseDate;
    final lOther$releaseDate = other.releaseDate;
    if (l$releaseDate != lOther$releaseDate) {
      return false;
    }
    final l$isrc = isrc;
    final lOther$isrc = other.isrc;
    if (l$isrc != lOther$isrc) {
      return false;
    }
    final l$trackNo = trackNo;
    final lOther$trackNo = other.trackNo;
    if (l$trackNo != lOther$trackNo) {
      return false;
    }
    final l$trackTitle = trackTitle;
    final lOther$trackTitle = other.trackTitle;
    if (l$trackTitle != lOther$trackTitle) {
      return false;
    }
    final l$trackTitleVersion = trackTitleVersion;
    final lOther$trackTitleVersion = other.trackTitleVersion;
    if (l$trackTitleVersion != lOther$trackTitleVersion) {
      return false;
    }
    final l$artistId = artistId;
    final lOther$artistId = other.artistId;
    if (l$artistId != lOther$artistId) {
      return false;
    }
    final l$imageUrl = imageUrl;
    final lOther$imageUrl = other.imageUrl;
    if (_$data.containsKey('imageUrl') !=
        other._$data.containsKey('imageUrl')) {
      return false;
    }
    if (l$imageUrl != lOther$imageUrl) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$upc = upc;
    final l$format = format;
    final l$trackCount = trackCount;
    final l$title = title;
    final l$releaseDate = releaseDate;
    final l$isrc = isrc;
    final l$trackNo = trackNo;
    final l$trackTitle = trackTitle;
    final l$trackTitleVersion = trackTitleVersion;
    final l$artistId = artistId;
    final l$imageUrl = imageUrl;
    return Object.hashAll([
      l$upc,
      l$format,
      l$trackCount,
      l$title,
      l$releaseDate,
      l$isrc,
      l$trackNo,
      l$trackTitle,
      l$trackTitleVersion,
      l$artistId,
      _$data.containsKey('imageUrl') ? l$imageUrl : const {},
    ]);
  }
}

abstract class CopyWith$Input$ReleaseData<TRes> {
  factory CopyWith$Input$ReleaseData(
    Input$ReleaseData instance,
    TRes Function(Input$ReleaseData) then,
  ) = _CopyWithImpl$Input$ReleaseData;

  factory CopyWith$Input$ReleaseData.stub(TRes res) =
      _CopyWithStubImpl$Input$ReleaseData;

  TRes call({
    String? upc,
    String? format,
    int? trackCount,
    String? title,
    String? releaseDate,
    String? isrc,
    int? trackNo,
    String? trackTitle,
    String? trackTitleVersion,
    String? artistId,
    String? imageUrl,
  });
}

class _CopyWithImpl$Input$ReleaseData<TRes>
    implements CopyWith$Input$ReleaseData<TRes> {
  _CopyWithImpl$Input$ReleaseData(
    this._instance,
    this._then,
  );

  final Input$ReleaseData _instance;

  final TRes Function(Input$ReleaseData) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? upc = _undefined,
    Object? format = _undefined,
    Object? trackCount = _undefined,
    Object? title = _undefined,
    Object? releaseDate = _undefined,
    Object? isrc = _undefined,
    Object? trackNo = _undefined,
    Object? trackTitle = _undefined,
    Object? trackTitleVersion = _undefined,
    Object? artistId = _undefined,
    Object? imageUrl = _undefined,
  }) =>
      _then(Input$ReleaseData._({
        ..._instance._$data,
        if (upc != _undefined && upc != null) 'upc': (upc as String),
        if (format != _undefined && format != null)
          'format': (format as String),
        if (trackCount != _undefined && trackCount != null)
          'trackCount': (trackCount as int),
        if (title != _undefined && title != null) 'title': (title as String),
        if (releaseDate != _undefined && releaseDate != null)
          'releaseDate': (releaseDate as String),
        if (isrc != _undefined && isrc != null) 'isrc': (isrc as String),
        if (trackNo != _undefined && trackNo != null)
          'trackNo': (trackNo as int),
        if (trackTitle != _undefined && trackTitle != null)
          'trackTitle': (trackTitle as String),
        if (trackTitleVersion != _undefined && trackTitleVersion != null)
          'trackTitleVersion': (trackTitleVersion as String),
        if (artistId != _undefined && artistId != null)
          'artistId': (artistId as String),
        if (imageUrl != _undefined) 'imageUrl': (imageUrl as String?),
      }));
}

class _CopyWithStubImpl$Input$ReleaseData<TRes>
    implements CopyWith$Input$ReleaseData<TRes> {
  _CopyWithStubImpl$Input$ReleaseData(this._res);

  TRes _res;

  call({
    String? upc,
    String? format,
    int? trackCount,
    String? title,
    String? releaseDate,
    String? isrc,
    int? trackNo,
    String? trackTitle,
    String? trackTitleVersion,
    String? artistId,
    String? imageUrl,
  }) =>
      _res;
}

class Input$ReportOfferInput {
  factory Input$ReportOfferInput({
    required int offerId,
    required String reporterUserId,
    required String reportContent,
  }) =>
      Input$ReportOfferInput._({
        r'offerId': offerId,
        r'reporterUserId': reporterUserId,
        r'reportContent': reportContent,
      });

  Input$ReportOfferInput._(this._$data);

  factory Input$ReportOfferInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$offerId = data['offerId'];
    result$data['offerId'] = (l$offerId as int);
    final l$reporterUserId = data['reporterUserId'];
    result$data['reporterUserId'] = (l$reporterUserId as String);
    final l$reportContent = data['reportContent'];
    result$data['reportContent'] = (l$reportContent as String);
    return Input$ReportOfferInput._(result$data);
  }

  Map<String, dynamic> _$data;

  int get offerId => (_$data['offerId'] as int);

  String get reporterUserId => (_$data['reporterUserId'] as String);

  String get reportContent => (_$data['reportContent'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$offerId = offerId;
    result$data['offerId'] = l$offerId;
    final l$reporterUserId = reporterUserId;
    result$data['reporterUserId'] = l$reporterUserId;
    final l$reportContent = reportContent;
    result$data['reportContent'] = l$reportContent;
    return result$data;
  }

  CopyWith$Input$ReportOfferInput<Input$ReportOfferInput> get copyWith =>
      CopyWith$Input$ReportOfferInput(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$ReportOfferInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$offerId = offerId;
    final lOther$offerId = other.offerId;
    if (l$offerId != lOther$offerId) {
      return false;
    }
    final l$reporterUserId = reporterUserId;
    final lOther$reporterUserId = other.reporterUserId;
    if (l$reporterUserId != lOther$reporterUserId) {
      return false;
    }
    final l$reportContent = reportContent;
    final lOther$reportContent = other.reportContent;
    if (l$reportContent != lOther$reportContent) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$offerId = offerId;
    final l$reporterUserId = reporterUserId;
    final l$reportContent = reportContent;
    return Object.hashAll([
      l$offerId,
      l$reporterUserId,
      l$reportContent,
    ]);
  }
}

abstract class CopyWith$Input$ReportOfferInput<TRes> {
  factory CopyWith$Input$ReportOfferInput(
    Input$ReportOfferInput instance,
    TRes Function(Input$ReportOfferInput) then,
  ) = _CopyWithImpl$Input$ReportOfferInput;

  factory CopyWith$Input$ReportOfferInput.stub(TRes res) =
      _CopyWithStubImpl$Input$ReportOfferInput;

  TRes call({
    int? offerId,
    String? reporterUserId,
    String? reportContent,
  });
}

class _CopyWithImpl$Input$ReportOfferInput<TRes>
    implements CopyWith$Input$ReportOfferInput<TRes> {
  _CopyWithImpl$Input$ReportOfferInput(
    this._instance,
    this._then,
  );

  final Input$ReportOfferInput _instance;

  final TRes Function(Input$ReportOfferInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? offerId = _undefined,
    Object? reporterUserId = _undefined,
    Object? reportContent = _undefined,
  }) =>
      _then(Input$ReportOfferInput._({
        ..._instance._$data,
        if (offerId != _undefined && offerId != null)
          'offerId': (offerId as int),
        if (reporterUserId != _undefined && reporterUserId != null)
          'reporterUserId': (reporterUserId as String),
        if (reportContent != _undefined && reportContent != null)
          'reportContent': (reportContent as String),
      }));
}

class _CopyWithStubImpl$Input$ReportOfferInput<TRes>
    implements CopyWith$Input$ReportOfferInput<TRes> {
  _CopyWithStubImpl$Input$ReportOfferInput(this._res);

  TRes _res;

  call({
    int? offerId,
    String? reporterUserId,
    String? reportContent,
  }) =>
      _res;
}

class Input$ReportUserInput {
  factory Input$ReportUserInput({
    required String reportedUserId,
    required String reporterUserId,
    required String reportContent,
  }) =>
      Input$ReportUserInput._({
        r'reportedUserId': reportedUserId,
        r'reporterUserId': reporterUserId,
        r'reportContent': reportContent,
      });

  Input$ReportUserInput._(this._$data);

  factory Input$ReportUserInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$reportedUserId = data['reportedUserId'];
    result$data['reportedUserId'] = (l$reportedUserId as String);
    final l$reporterUserId = data['reporterUserId'];
    result$data['reporterUserId'] = (l$reporterUserId as String);
    final l$reportContent = data['reportContent'];
    result$data['reportContent'] = (l$reportContent as String);
    return Input$ReportUserInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get reportedUserId => (_$data['reportedUserId'] as String);

  String get reporterUserId => (_$data['reporterUserId'] as String);

  String get reportContent => (_$data['reportContent'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$reportedUserId = reportedUserId;
    result$data['reportedUserId'] = l$reportedUserId;
    final l$reporterUserId = reporterUserId;
    result$data['reporterUserId'] = l$reporterUserId;
    final l$reportContent = reportContent;
    result$data['reportContent'] = l$reportContent;
    return result$data;
  }

  CopyWith$Input$ReportUserInput<Input$ReportUserInput> get copyWith =>
      CopyWith$Input$ReportUserInput(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$ReportUserInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$reportedUserId = reportedUserId;
    final lOther$reportedUserId = other.reportedUserId;
    if (l$reportedUserId != lOther$reportedUserId) {
      return false;
    }
    final l$reporterUserId = reporterUserId;
    final lOther$reporterUserId = other.reporterUserId;
    if (l$reporterUserId != lOther$reporterUserId) {
      return false;
    }
    final l$reportContent = reportContent;
    final lOther$reportContent = other.reportContent;
    if (l$reportContent != lOther$reportContent) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$reportedUserId = reportedUserId;
    final l$reporterUserId = reporterUserId;
    final l$reportContent = reportContent;
    return Object.hashAll([
      l$reportedUserId,
      l$reporterUserId,
      l$reportContent,
    ]);
  }
}

abstract class CopyWith$Input$ReportUserInput<TRes> {
  factory CopyWith$Input$ReportUserInput(
    Input$ReportUserInput instance,
    TRes Function(Input$ReportUserInput) then,
  ) = _CopyWithImpl$Input$ReportUserInput;

  factory CopyWith$Input$ReportUserInput.stub(TRes res) =
      _CopyWithStubImpl$Input$ReportUserInput;

  TRes call({
    String? reportedUserId,
    String? reporterUserId,
    String? reportContent,
  });
}

class _CopyWithImpl$Input$ReportUserInput<TRes>
    implements CopyWith$Input$ReportUserInput<TRes> {
  _CopyWithImpl$Input$ReportUserInput(
    this._instance,
    this._then,
  );

  final Input$ReportUserInput _instance;

  final TRes Function(Input$ReportUserInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? reportedUserId = _undefined,
    Object? reporterUserId = _undefined,
    Object? reportContent = _undefined,
  }) =>
      _then(Input$ReportUserInput._({
        ..._instance._$data,
        if (reportedUserId != _undefined && reportedUserId != null)
          'reportedUserId': (reportedUserId as String),
        if (reporterUserId != _undefined && reporterUserId != null)
          'reporterUserId': (reporterUserId as String),
        if (reportContent != _undefined && reportContent != null)
          'reportContent': (reportContent as String),
      }));
}

class _CopyWithStubImpl$Input$ReportUserInput<TRes>
    implements CopyWith$Input$ReportUserInput<TRes> {
  _CopyWithStubImpl$Input$ReportUserInput(this._res);

  TRes _res;

  call({
    String? reportedUserId,
    String? reporterUserId,
    String? reportContent,
  }) =>
      _res;
}

class Input$RequestPrizeInput {
  factory Input$RequestPrizeInput({
    required String userId,
    required int prizeId,
  }) =>
      Input$RequestPrizeInput._({
        r'userId': userId,
        r'prizeId': prizeId,
      });

  Input$RequestPrizeInput._(this._$data);

  factory Input$RequestPrizeInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    final l$prizeId = data['prizeId'];
    result$data['prizeId'] = (l$prizeId as int);
    return Input$RequestPrizeInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  int get prizeId => (_$data['prizeId'] as int);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$userId = userId;
    result$data['userId'] = l$userId;
    final l$prizeId = prizeId;
    result$data['prizeId'] = l$prizeId;
    return result$data;
  }

  CopyWith$Input$RequestPrizeInput<Input$RequestPrizeInput> get copyWith =>
      CopyWith$Input$RequestPrizeInput(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$RequestPrizeInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$prizeId = prizeId;
    final lOther$prizeId = other.prizeId;
    if (l$prizeId != lOther$prizeId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$prizeId = prizeId;
    return Object.hashAll([
      l$userId,
      l$prizeId,
    ]);
  }
}

abstract class CopyWith$Input$RequestPrizeInput<TRes> {
  factory CopyWith$Input$RequestPrizeInput(
    Input$RequestPrizeInput instance,
    TRes Function(Input$RequestPrizeInput) then,
  ) = _CopyWithImpl$Input$RequestPrizeInput;

  factory CopyWith$Input$RequestPrizeInput.stub(TRes res) =
      _CopyWithStubImpl$Input$RequestPrizeInput;

  TRes call({
    String? userId,
    int? prizeId,
  });
}

class _CopyWithImpl$Input$RequestPrizeInput<TRes>
    implements CopyWith$Input$RequestPrizeInput<TRes> {
  _CopyWithImpl$Input$RequestPrizeInput(
    this._instance,
    this._then,
  );

  final Input$RequestPrizeInput _instance;

  final TRes Function(Input$RequestPrizeInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? userId = _undefined,
    Object? prizeId = _undefined,
  }) =>
      _then(Input$RequestPrizeInput._({
        ..._instance._$data,
        if (userId != _undefined && userId != null)
          'userId': (userId as String),
        if (prizeId != _undefined && prizeId != null)
          'prizeId': (prizeId as int),
      }));
}

class _CopyWithStubImpl$Input$RequestPrizeInput<TRes>
    implements CopyWith$Input$RequestPrizeInput<TRes> {
  _CopyWithStubImpl$Input$RequestPrizeInput(this._res);

  TRes _res;

  call({
    String? userId,
    int? prizeId,
  }) =>
      _res;
}

class Input$RequestToAccessArtistInput {
  factory Input$RequestToAccessArtistInput({
    required String userId,
    required List<String> artistIds,
  }) =>
      Input$RequestToAccessArtistInput._({
        r'userId': userId,
        r'artistIds': artistIds,
      });

  Input$RequestToAccessArtistInput._(this._$data);

  factory Input$RequestToAccessArtistInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    final l$artistIds = data['artistIds'];
    result$data['artistIds'] =
        (l$artistIds as List<dynamic>).map((e) => (e as String)).toList();
    return Input$RequestToAccessArtistInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  List<String> get artistIds => (_$data['artistIds'] as List<String>);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$userId = userId;
    result$data['userId'] = l$userId;
    final l$artistIds = artistIds;
    result$data['artistIds'] = l$artistIds.map((e) => e).toList();
    return result$data;
  }

  CopyWith$Input$RequestToAccessArtistInput<Input$RequestToAccessArtistInput>
      get copyWith => CopyWith$Input$RequestToAccessArtistInput(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$RequestToAccessArtistInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$artistIds = artistIds;
    final lOther$artistIds = other.artistIds;
    if (l$artistIds.length != lOther$artistIds.length) {
      return false;
    }
    for (int i = 0; i < l$artistIds.length; i++) {
      final l$artistIds$entry = l$artistIds[i];
      final lOther$artistIds$entry = lOther$artistIds[i];
      if (l$artistIds$entry != lOther$artistIds$entry) {
        return false;
      }
    }
    return true;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$artistIds = artistIds;
    return Object.hashAll([
      l$userId,
      Object.hashAll(l$artistIds.map((v) => v)),
    ]);
  }
}

abstract class CopyWith$Input$RequestToAccessArtistInput<TRes> {
  factory CopyWith$Input$RequestToAccessArtistInput(
    Input$RequestToAccessArtistInput instance,
    TRes Function(Input$RequestToAccessArtistInput) then,
  ) = _CopyWithImpl$Input$RequestToAccessArtistInput;

  factory CopyWith$Input$RequestToAccessArtistInput.stub(TRes res) =
      _CopyWithStubImpl$Input$RequestToAccessArtistInput;

  TRes call({
    String? userId,
    List<String>? artistIds,
  });
}

class _CopyWithImpl$Input$RequestToAccessArtistInput<TRes>
    implements CopyWith$Input$RequestToAccessArtistInput<TRes> {
  _CopyWithImpl$Input$RequestToAccessArtistInput(
    this._instance,
    this._then,
  );

  final Input$RequestToAccessArtistInput _instance;

  final TRes Function(Input$RequestToAccessArtistInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? userId = _undefined,
    Object? artistIds = _undefined,
  }) =>
      _then(Input$RequestToAccessArtistInput._({
        ..._instance._$data,
        if (userId != _undefined && userId != null)
          'userId': (userId as String),
        if (artistIds != _undefined && artistIds != null)
          'artistIds': (artistIds as List<String>),
      }));
}

class _CopyWithStubImpl$Input$RequestToAccessArtistInput<TRes>
    implements CopyWith$Input$RequestToAccessArtistInput<TRes> {
  _CopyWithStubImpl$Input$RequestToAccessArtistInput(this._res);

  TRes _res;

  call({
    String? userId,
    List<String>? artistIds,
  }) =>
      _res;
}

class Input$SearchOptionsOffersInput {
  factory Input$SearchOptionsOffersInput({
    String? owner,
    String? category,
    String? targetRole,
    String? place,
    int? minPrice,
    int? maxPrice,
    String? sortBy,
  }) =>
      Input$SearchOptionsOffersInput._({
        if (owner != null) r'owner': owner,
        if (category != null) r'category': category,
        if (targetRole != null) r'targetRole': targetRole,
        if (place != null) r'place': place,
        if (minPrice != null) r'minPrice': minPrice,
        if (maxPrice != null) r'maxPrice': maxPrice,
        if (sortBy != null) r'sortBy': sortBy,
      });

  Input$SearchOptionsOffersInput._(this._$data);

  factory Input$SearchOptionsOffersInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('owner')) {
      final l$owner = data['owner'];
      result$data['owner'] = (l$owner as String?);
    }
    if (data.containsKey('category')) {
      final l$category = data['category'];
      result$data['category'] = (l$category as String?);
    }
    if (data.containsKey('targetRole')) {
      final l$targetRole = data['targetRole'];
      result$data['targetRole'] = (l$targetRole as String?);
    }
    if (data.containsKey('place')) {
      final l$place = data['place'];
      result$data['place'] = (l$place as String?);
    }
    if (data.containsKey('minPrice')) {
      final l$minPrice = data['minPrice'];
      result$data['minPrice'] = (l$minPrice as int?);
    }
    if (data.containsKey('maxPrice')) {
      final l$maxPrice = data['maxPrice'];
      result$data['maxPrice'] = (l$maxPrice as int?);
    }
    if (data.containsKey('sortBy')) {
      final l$sortBy = data['sortBy'];
      result$data['sortBy'] = (l$sortBy as String?);
    }
    return Input$SearchOptionsOffersInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String? get owner => (_$data['owner'] as String?);

  String? get category => (_$data['category'] as String?);

  String? get targetRole => (_$data['targetRole'] as String?);

  String? get place => (_$data['place'] as String?);

  int? get minPrice => (_$data['minPrice'] as int?);

  int? get maxPrice => (_$data['maxPrice'] as int?);

  String? get sortBy => (_$data['sortBy'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('owner')) {
      final l$owner = owner;
      result$data['owner'] = l$owner;
    }
    if (_$data.containsKey('category')) {
      final l$category = category;
      result$data['category'] = l$category;
    }
    if (_$data.containsKey('targetRole')) {
      final l$targetRole = targetRole;
      result$data['targetRole'] = l$targetRole;
    }
    if (_$data.containsKey('place')) {
      final l$place = place;
      result$data['place'] = l$place;
    }
    if (_$data.containsKey('minPrice')) {
      final l$minPrice = minPrice;
      result$data['minPrice'] = l$minPrice;
    }
    if (_$data.containsKey('maxPrice')) {
      final l$maxPrice = maxPrice;
      result$data['maxPrice'] = l$maxPrice;
    }
    if (_$data.containsKey('sortBy')) {
      final l$sortBy = sortBy;
      result$data['sortBy'] = l$sortBy;
    }
    return result$data;
  }

  CopyWith$Input$SearchOptionsOffersInput<Input$SearchOptionsOffersInput>
      get copyWith => CopyWith$Input$SearchOptionsOffersInput(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$SearchOptionsOffersInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$owner = owner;
    final lOther$owner = other.owner;
    if (_$data.containsKey('owner') != other._$data.containsKey('owner')) {
      return false;
    }
    if (l$owner != lOther$owner) {
      return false;
    }
    final l$category = category;
    final lOther$category = other.category;
    if (_$data.containsKey('category') !=
        other._$data.containsKey('category')) {
      return false;
    }
    if (l$category != lOther$category) {
      return false;
    }
    final l$targetRole = targetRole;
    final lOther$targetRole = other.targetRole;
    if (_$data.containsKey('targetRole') !=
        other._$data.containsKey('targetRole')) {
      return false;
    }
    if (l$targetRole != lOther$targetRole) {
      return false;
    }
    final l$place = place;
    final lOther$place = other.place;
    if (_$data.containsKey('place') != other._$data.containsKey('place')) {
      return false;
    }
    if (l$place != lOther$place) {
      return false;
    }
    final l$minPrice = minPrice;
    final lOther$minPrice = other.minPrice;
    if (_$data.containsKey('minPrice') !=
        other._$data.containsKey('minPrice')) {
      return false;
    }
    if (l$minPrice != lOther$minPrice) {
      return false;
    }
    final l$maxPrice = maxPrice;
    final lOther$maxPrice = other.maxPrice;
    if (_$data.containsKey('maxPrice') !=
        other._$data.containsKey('maxPrice')) {
      return false;
    }
    if (l$maxPrice != lOther$maxPrice) {
      return false;
    }
    final l$sortBy = sortBy;
    final lOther$sortBy = other.sortBy;
    if (_$data.containsKey('sortBy') != other._$data.containsKey('sortBy')) {
      return false;
    }
    if (l$sortBy != lOther$sortBy) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$owner = owner;
    final l$category = category;
    final l$targetRole = targetRole;
    final l$place = place;
    final l$minPrice = minPrice;
    final l$maxPrice = maxPrice;
    final l$sortBy = sortBy;
    return Object.hashAll([
      _$data.containsKey('owner') ? l$owner : const {},
      _$data.containsKey('category') ? l$category : const {},
      _$data.containsKey('targetRole') ? l$targetRole : const {},
      _$data.containsKey('place') ? l$place : const {},
      _$data.containsKey('minPrice') ? l$minPrice : const {},
      _$data.containsKey('maxPrice') ? l$maxPrice : const {},
      _$data.containsKey('sortBy') ? l$sortBy : const {},
    ]);
  }
}

abstract class CopyWith$Input$SearchOptionsOffersInput<TRes> {
  factory CopyWith$Input$SearchOptionsOffersInput(
    Input$SearchOptionsOffersInput instance,
    TRes Function(Input$SearchOptionsOffersInput) then,
  ) = _CopyWithImpl$Input$SearchOptionsOffersInput;

  factory CopyWith$Input$SearchOptionsOffersInput.stub(TRes res) =
      _CopyWithStubImpl$Input$SearchOptionsOffersInput;

  TRes call({
    String? owner,
    String? category,
    String? targetRole,
    String? place,
    int? minPrice,
    int? maxPrice,
    String? sortBy,
  });
}

class _CopyWithImpl$Input$SearchOptionsOffersInput<TRes>
    implements CopyWith$Input$SearchOptionsOffersInput<TRes> {
  _CopyWithImpl$Input$SearchOptionsOffersInput(
    this._instance,
    this._then,
  );

  final Input$SearchOptionsOffersInput _instance;

  final TRes Function(Input$SearchOptionsOffersInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? owner = _undefined,
    Object? category = _undefined,
    Object? targetRole = _undefined,
    Object? place = _undefined,
    Object? minPrice = _undefined,
    Object? maxPrice = _undefined,
    Object? sortBy = _undefined,
  }) =>
      _then(Input$SearchOptionsOffersInput._({
        ..._instance._$data,
        if (owner != _undefined) 'owner': (owner as String?),
        if (category != _undefined) 'category': (category as String?),
        if (targetRole != _undefined) 'targetRole': (targetRole as String?),
        if (place != _undefined) 'place': (place as String?),
        if (minPrice != _undefined) 'minPrice': (minPrice as int?),
        if (maxPrice != _undefined) 'maxPrice': (maxPrice as int?),
        if (sortBy != _undefined) 'sortBy': (sortBy as String?),
      }));
}

class _CopyWithStubImpl$Input$SearchOptionsOffersInput<TRes>
    implements CopyWith$Input$SearchOptionsOffersInput<TRes> {
  _CopyWithStubImpl$Input$SearchOptionsOffersInput(this._res);

  TRes _res;

  call({
    String? owner,
    String? category,
    String? targetRole,
    String? place,
    int? minPrice,
    int? maxPrice,
    String? sortBy,
  }) =>
      _res;
}

class Input$SearchProductsQuery {
  factory Input$SearchProductsQuery({
    String? upc,
    String? productTitle,
    String? artistId,
    String? productType,
  }) =>
      Input$SearchProductsQuery._({
        if (upc != null) r'upc': upc,
        if (productTitle != null) r'productTitle': productTitle,
        if (artistId != null) r'artistId': artistId,
        if (productType != null) r'productType': productType,
      });

  Input$SearchProductsQuery._(this._$data);

  factory Input$SearchProductsQuery.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('upc')) {
      final l$upc = data['upc'];
      result$data['upc'] = (l$upc as String?);
    }
    if (data.containsKey('productTitle')) {
      final l$productTitle = data['productTitle'];
      result$data['productTitle'] = (l$productTitle as String?);
    }
    if (data.containsKey('artistId')) {
      final l$artistId = data['artistId'];
      result$data['artistId'] = (l$artistId as String?);
    }
    if (data.containsKey('productType')) {
      final l$productType = data['productType'];
      result$data['productType'] = (l$productType as String?);
    }
    return Input$SearchProductsQuery._(result$data);
  }

  Map<String, dynamic> _$data;

  String? get upc => (_$data['upc'] as String?);

  String? get productTitle => (_$data['productTitle'] as String?);

  String? get artistId => (_$data['artistId'] as String?);

  String? get productType => (_$data['productType'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('upc')) {
      final l$upc = upc;
      result$data['upc'] = l$upc;
    }
    if (_$data.containsKey('productTitle')) {
      final l$productTitle = productTitle;
      result$data['productTitle'] = l$productTitle;
    }
    if (_$data.containsKey('artistId')) {
      final l$artistId = artistId;
      result$data['artistId'] = l$artistId;
    }
    if (_$data.containsKey('productType')) {
      final l$productType = productType;
      result$data['productType'] = l$productType;
    }
    return result$data;
  }

  CopyWith$Input$SearchProductsQuery<Input$SearchProductsQuery> get copyWith =>
      CopyWith$Input$SearchProductsQuery(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$SearchProductsQuery ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$upc = upc;
    final lOther$upc = other.upc;
    if (_$data.containsKey('upc') != other._$data.containsKey('upc')) {
      return false;
    }
    if (l$upc != lOther$upc) {
      return false;
    }
    final l$productTitle = productTitle;
    final lOther$productTitle = other.productTitle;
    if (_$data.containsKey('productTitle') !=
        other._$data.containsKey('productTitle')) {
      return false;
    }
    if (l$productTitle != lOther$productTitle) {
      return false;
    }
    final l$artistId = artistId;
    final lOther$artistId = other.artistId;
    if (_$data.containsKey('artistId') !=
        other._$data.containsKey('artistId')) {
      return false;
    }
    if (l$artistId != lOther$artistId) {
      return false;
    }
    final l$productType = productType;
    final lOther$productType = other.productType;
    if (_$data.containsKey('productType') !=
        other._$data.containsKey('productType')) {
      return false;
    }
    if (l$productType != lOther$productType) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$upc = upc;
    final l$productTitle = productTitle;
    final l$artistId = artistId;
    final l$productType = productType;
    return Object.hashAll([
      _$data.containsKey('upc') ? l$upc : const {},
      _$data.containsKey('productTitle') ? l$productTitle : const {},
      _$data.containsKey('artistId') ? l$artistId : const {},
      _$data.containsKey('productType') ? l$productType : const {},
    ]);
  }
}

abstract class CopyWith$Input$SearchProductsQuery<TRes> {
  factory CopyWith$Input$SearchProductsQuery(
    Input$SearchProductsQuery instance,
    TRes Function(Input$SearchProductsQuery) then,
  ) = _CopyWithImpl$Input$SearchProductsQuery;

  factory CopyWith$Input$SearchProductsQuery.stub(TRes res) =
      _CopyWithStubImpl$Input$SearchProductsQuery;

  TRes call({
    String? upc,
    String? productTitle,
    String? artistId,
    String? productType,
  });
}

class _CopyWithImpl$Input$SearchProductsQuery<TRes>
    implements CopyWith$Input$SearchProductsQuery<TRes> {
  _CopyWithImpl$Input$SearchProductsQuery(
    this._instance,
    this._then,
  );

  final Input$SearchProductsQuery _instance;

  final TRes Function(Input$SearchProductsQuery) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? upc = _undefined,
    Object? productTitle = _undefined,
    Object? artistId = _undefined,
    Object? productType = _undefined,
  }) =>
      _then(Input$SearchProductsQuery._({
        ..._instance._$data,
        if (upc != _undefined) 'upc': (upc as String?),
        if (productTitle != _undefined)
          'productTitle': (productTitle as String?),
        if (artistId != _undefined) 'artistId': (artistId as String?),
        if (productType != _undefined) 'productType': (productType as String?),
      }));
}

class _CopyWithStubImpl$Input$SearchProductsQuery<TRes>
    implements CopyWith$Input$SearchProductsQuery<TRes> {
  _CopyWithStubImpl$Input$SearchProductsQuery(this._res);

  TRes _res;

  call({
    String? upc,
    String? productTitle,
    String? artistId,
    String? productType,
  }) =>
      _res;
}

class Input$SearchTracksQuery {
  factory Input$SearchTracksQuery({
    String? isrc,
    String? trackTitle,
    String? artistId,
  }) =>
      Input$SearchTracksQuery._({
        if (isrc != null) r'isrc': isrc,
        if (trackTitle != null) r'trackTitle': trackTitle,
        if (artistId != null) r'artistId': artistId,
      });

  Input$SearchTracksQuery._(this._$data);

  factory Input$SearchTracksQuery.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('isrc')) {
      final l$isrc = data['isrc'];
      result$data['isrc'] = (l$isrc as String?);
    }
    if (data.containsKey('trackTitle')) {
      final l$trackTitle = data['trackTitle'];
      result$data['trackTitle'] = (l$trackTitle as String?);
    }
    if (data.containsKey('artistId')) {
      final l$artistId = data['artistId'];
      result$data['artistId'] = (l$artistId as String?);
    }
    return Input$SearchTracksQuery._(result$data);
  }

  Map<String, dynamic> _$data;

  String? get isrc => (_$data['isrc'] as String?);

  String? get trackTitle => (_$data['trackTitle'] as String?);

  String? get artistId => (_$data['artistId'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('isrc')) {
      final l$isrc = isrc;
      result$data['isrc'] = l$isrc;
    }
    if (_$data.containsKey('trackTitle')) {
      final l$trackTitle = trackTitle;
      result$data['trackTitle'] = l$trackTitle;
    }
    if (_$data.containsKey('artistId')) {
      final l$artistId = artistId;
      result$data['artistId'] = l$artistId;
    }
    return result$data;
  }

  CopyWith$Input$SearchTracksQuery<Input$SearchTracksQuery> get copyWith =>
      CopyWith$Input$SearchTracksQuery(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$SearchTracksQuery || runtimeType != other.runtimeType) {
      return false;
    }
    final l$isrc = isrc;
    final lOther$isrc = other.isrc;
    if (_$data.containsKey('isrc') != other._$data.containsKey('isrc')) {
      return false;
    }
    if (l$isrc != lOther$isrc) {
      return false;
    }
    final l$trackTitle = trackTitle;
    final lOther$trackTitle = other.trackTitle;
    if (_$data.containsKey('trackTitle') !=
        other._$data.containsKey('trackTitle')) {
      return false;
    }
    if (l$trackTitle != lOther$trackTitle) {
      return false;
    }
    final l$artistId = artistId;
    final lOther$artistId = other.artistId;
    if (_$data.containsKey('artistId') !=
        other._$data.containsKey('artistId')) {
      return false;
    }
    if (l$artistId != lOther$artistId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$isrc = isrc;
    final l$trackTitle = trackTitle;
    final l$artistId = artistId;
    return Object.hashAll([
      _$data.containsKey('isrc') ? l$isrc : const {},
      _$data.containsKey('trackTitle') ? l$trackTitle : const {},
      _$data.containsKey('artistId') ? l$artistId : const {},
    ]);
  }
}

abstract class CopyWith$Input$SearchTracksQuery<TRes> {
  factory CopyWith$Input$SearchTracksQuery(
    Input$SearchTracksQuery instance,
    TRes Function(Input$SearchTracksQuery) then,
  ) = _CopyWithImpl$Input$SearchTracksQuery;

  factory CopyWith$Input$SearchTracksQuery.stub(TRes res) =
      _CopyWithStubImpl$Input$SearchTracksQuery;

  TRes call({
    String? isrc,
    String? trackTitle,
    String? artistId,
  });
}

class _CopyWithImpl$Input$SearchTracksQuery<TRes>
    implements CopyWith$Input$SearchTracksQuery<TRes> {
  _CopyWithImpl$Input$SearchTracksQuery(
    this._instance,
    this._then,
  );

  final Input$SearchTracksQuery _instance;

  final TRes Function(Input$SearchTracksQuery) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? isrc = _undefined,
    Object? trackTitle = _undefined,
    Object? artistId = _undefined,
  }) =>
      _then(Input$SearchTracksQuery._({
        ..._instance._$data,
        if (isrc != _undefined) 'isrc': (isrc as String?),
        if (trackTitle != _undefined) 'trackTitle': (trackTitle as String?),
        if (artistId != _undefined) 'artistId': (artistId as String?),
      }));
}

class _CopyWithStubImpl$Input$SearchTracksQuery<TRes>
    implements CopyWith$Input$SearchTracksQuery<TRes> {
  _CopyWithStubImpl$Input$SearchTracksQuery(this._res);

  TRes _res;

  call({
    String? isrc,
    String? trackTitle,
    String? artistId,
  }) =>
      _res;
}

class Input$SendMessageInput {
  factory Input$SendMessageInput({
    required String roomId,
    required String sentBy,
    required String message,
    List<String>? attachedFile,
    List<String>? attachedImg,
  }) =>
      Input$SendMessageInput._({
        r'roomId': roomId,
        r'sentBy': sentBy,
        r'message': message,
        if (attachedFile != null) r'attachedFile': attachedFile,
        if (attachedImg != null) r'attachedImg': attachedImg,
      });

  Input$SendMessageInput._(this._$data);

  factory Input$SendMessageInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$roomId = data['roomId'];
    result$data['roomId'] = (l$roomId as String);
    final l$sentBy = data['sentBy'];
    result$data['sentBy'] = (l$sentBy as String);
    final l$message = data['message'];
    result$data['message'] = (l$message as String);
    if (data.containsKey('attachedFile')) {
      final l$attachedFile = data['attachedFile'];
      result$data['attachedFile'] = (l$attachedFile as List<dynamic>?)
          ?.map((e) => (e as String))
          .toList();
    }
    if (data.containsKey('attachedImg')) {
      final l$attachedImg = data['attachedImg'];
      result$data['attachedImg'] =
          (l$attachedImg as List<dynamic>?)?.map((e) => (e as String)).toList();
    }
    return Input$SendMessageInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get roomId => (_$data['roomId'] as String);

  String get sentBy => (_$data['sentBy'] as String);

  String get message => (_$data['message'] as String);

  List<String>? get attachedFile => (_$data['attachedFile'] as List<String>?);

  List<String>? get attachedImg => (_$data['attachedImg'] as List<String>?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$roomId = roomId;
    result$data['roomId'] = l$roomId;
    final l$sentBy = sentBy;
    result$data['sentBy'] = l$sentBy;
    final l$message = message;
    result$data['message'] = l$message;
    if (_$data.containsKey('attachedFile')) {
      final l$attachedFile = attachedFile;
      result$data['attachedFile'] = l$attachedFile?.map((e) => e).toList();
    }
    if (_$data.containsKey('attachedImg')) {
      final l$attachedImg = attachedImg;
      result$data['attachedImg'] = l$attachedImg?.map((e) => e).toList();
    }
    return result$data;
  }

  CopyWith$Input$SendMessageInput<Input$SendMessageInput> get copyWith =>
      CopyWith$Input$SendMessageInput(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$SendMessageInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$roomId = roomId;
    final lOther$roomId = other.roomId;
    if (l$roomId != lOther$roomId) {
      return false;
    }
    final l$sentBy = sentBy;
    final lOther$sentBy = other.sentBy;
    if (l$sentBy != lOther$sentBy) {
      return false;
    }
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) {
      return false;
    }
    final l$attachedFile = attachedFile;
    final lOther$attachedFile = other.attachedFile;
    if (_$data.containsKey('attachedFile') !=
        other._$data.containsKey('attachedFile')) {
      return false;
    }
    if (l$attachedFile != null && lOther$attachedFile != null) {
      if (l$attachedFile.length != lOther$attachedFile.length) {
        return false;
      }
      for (int i = 0; i < l$attachedFile.length; i++) {
        final l$attachedFile$entry = l$attachedFile[i];
        final lOther$attachedFile$entry = lOther$attachedFile[i];
        if (l$attachedFile$entry != lOther$attachedFile$entry) {
          return false;
        }
      }
    } else if (l$attachedFile != lOther$attachedFile) {
      return false;
    }
    final l$attachedImg = attachedImg;
    final lOther$attachedImg = other.attachedImg;
    if (_$data.containsKey('attachedImg') !=
        other._$data.containsKey('attachedImg')) {
      return false;
    }
    if (l$attachedImg != null && lOther$attachedImg != null) {
      if (l$attachedImg.length != lOther$attachedImg.length) {
        return false;
      }
      for (int i = 0; i < l$attachedImg.length; i++) {
        final l$attachedImg$entry = l$attachedImg[i];
        final lOther$attachedImg$entry = lOther$attachedImg[i];
        if (l$attachedImg$entry != lOther$attachedImg$entry) {
          return false;
        }
      }
    } else if (l$attachedImg != lOther$attachedImg) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$roomId = roomId;
    final l$sentBy = sentBy;
    final l$message = message;
    final l$attachedFile = attachedFile;
    final l$attachedImg = attachedImg;
    return Object.hashAll([
      l$roomId,
      l$sentBy,
      l$message,
      _$data.containsKey('attachedFile')
          ? l$attachedFile == null
              ? null
              : Object.hashAll(l$attachedFile.map((v) => v))
          : const {},
      _$data.containsKey('attachedImg')
          ? l$attachedImg == null
              ? null
              : Object.hashAll(l$attachedImg.map((v) => v))
          : const {},
    ]);
  }
}

abstract class CopyWith$Input$SendMessageInput<TRes> {
  factory CopyWith$Input$SendMessageInput(
    Input$SendMessageInput instance,
    TRes Function(Input$SendMessageInput) then,
  ) = _CopyWithImpl$Input$SendMessageInput;

  factory CopyWith$Input$SendMessageInput.stub(TRes res) =
      _CopyWithStubImpl$Input$SendMessageInput;

  TRes call({
    String? roomId,
    String? sentBy,
    String? message,
    List<String>? attachedFile,
    List<String>? attachedImg,
  });
}

class _CopyWithImpl$Input$SendMessageInput<TRes>
    implements CopyWith$Input$SendMessageInput<TRes> {
  _CopyWithImpl$Input$SendMessageInput(
    this._instance,
    this._then,
  );

  final Input$SendMessageInput _instance;

  final TRes Function(Input$SendMessageInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? roomId = _undefined,
    Object? sentBy = _undefined,
    Object? message = _undefined,
    Object? attachedFile = _undefined,
    Object? attachedImg = _undefined,
  }) =>
      _then(Input$SendMessageInput._({
        ..._instance._$data,
        if (roomId != _undefined && roomId != null)
          'roomId': (roomId as String),
        if (sentBy != _undefined && sentBy != null)
          'sentBy': (sentBy as String),
        if (message != _undefined && message != null)
          'message': (message as String),
        if (attachedFile != _undefined)
          'attachedFile': (attachedFile as List<String>?),
        if (attachedImg != _undefined)
          'attachedImg': (attachedImg as List<String>?),
      }));
}

class _CopyWithStubImpl$Input$SendMessageInput<TRes>
    implements CopyWith$Input$SendMessageInput<TRes> {
  _CopyWithStubImpl$Input$SendMessageInput(this._res);

  TRes _res;

  call({
    String? roomId,
    String? sentBy,
    String? message,
    List<String>? attachedFile,
    List<String>? attachedImg,
  }) =>
      _res;
}

class Input$StatusUser {
  factory Input$StatusUser({
    required String userId,
    required String status,
  }) =>
      Input$StatusUser._({
        r'userId': userId,
        r'status': status,
      });

  Input$StatusUser._(this._$data);

  factory Input$StatusUser.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    final l$status = data['status'];
    result$data['status'] = (l$status as String);
    return Input$StatusUser._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  String get status => (_$data['status'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$userId = userId;
    result$data['userId'] = l$userId;
    final l$status = status;
    result$data['status'] = l$status;
    return result$data;
  }

  CopyWith$Input$StatusUser<Input$StatusUser> get copyWith =>
      CopyWith$Input$StatusUser(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$StatusUser || runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$status = status;
    return Object.hashAll([
      l$userId,
      l$status,
    ]);
  }
}

abstract class CopyWith$Input$StatusUser<TRes> {
  factory CopyWith$Input$StatusUser(
    Input$StatusUser instance,
    TRes Function(Input$StatusUser) then,
  ) = _CopyWithImpl$Input$StatusUser;

  factory CopyWith$Input$StatusUser.stub(TRes res) =
      _CopyWithStubImpl$Input$StatusUser;

  TRes call({
    String? userId,
    String? status,
  });
}

class _CopyWithImpl$Input$StatusUser<TRes>
    implements CopyWith$Input$StatusUser<TRes> {
  _CopyWithImpl$Input$StatusUser(
    this._instance,
    this._then,
  );

  final Input$StatusUser _instance;

  final TRes Function(Input$StatusUser) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? userId = _undefined,
    Object? status = _undefined,
  }) =>
      _then(Input$StatusUser._({
        ..._instance._$data,
        if (userId != _undefined && userId != null)
          'userId': (userId as String),
        if (status != _undefined && status != null)
          'status': (status as String),
      }));
}

class _CopyWithStubImpl$Input$StatusUser<TRes>
    implements CopyWith$Input$StatusUser<TRes> {
  _CopyWithStubImpl$Input$StatusUser(this._res);

  TRes _res;

  call({
    String? userId,
    String? status,
  }) =>
      _res;
}

class Input$UpdateArtistInput {
  factory Input$UpdateArtistInput({
    required String artistId,
    String? displayNameJp,
    String? displayNameEn,
    String? displayNameKana,
    String? imgUrl,
    int? fsp,
    String? status,
    String? since,
    String? universalId,
    String? appleKey,
    String? spotifyKey,
    String? lineKey,
    String? amazonKey,
    String? youtubeKey,
  }) =>
      Input$UpdateArtistInput._({
        r'artistId': artistId,
        if (displayNameJp != null) r'displayNameJp': displayNameJp,
        if (displayNameEn != null) r'displayNameEn': displayNameEn,
        if (displayNameKana != null) r'displayNameKana': displayNameKana,
        if (imgUrl != null) r'imgUrl': imgUrl,
        if (fsp != null) r'fsp': fsp,
        if (status != null) r'status': status,
        if (since != null) r'since': since,
        if (universalId != null) r'universalId': universalId,
        if (appleKey != null) r'appleKey': appleKey,
        if (spotifyKey != null) r'spotifyKey': spotifyKey,
        if (lineKey != null) r'lineKey': lineKey,
        if (amazonKey != null) r'amazonKey': amazonKey,
        if (youtubeKey != null) r'youtubeKey': youtubeKey,
      });

  Input$UpdateArtistInput._(this._$data);

  factory Input$UpdateArtistInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$artistId = data['artistId'];
    result$data['artistId'] = (l$artistId as String);
    if (data.containsKey('displayNameJp')) {
      final l$displayNameJp = data['displayNameJp'];
      result$data['displayNameJp'] = (l$displayNameJp as String?);
    }
    if (data.containsKey('displayNameEn')) {
      final l$displayNameEn = data['displayNameEn'];
      result$data['displayNameEn'] = (l$displayNameEn as String?);
    }
    if (data.containsKey('displayNameKana')) {
      final l$displayNameKana = data['displayNameKana'];
      result$data['displayNameKana'] = (l$displayNameKana as String?);
    }
    if (data.containsKey('imgUrl')) {
      final l$imgUrl = data['imgUrl'];
      result$data['imgUrl'] = (l$imgUrl as String?);
    }
    if (data.containsKey('fsp')) {
      final l$fsp = data['fsp'];
      result$data['fsp'] = (l$fsp as int?);
    }
    if (data.containsKey('status')) {
      final l$status = data['status'];
      result$data['status'] = (l$status as String?);
    }
    if (data.containsKey('since')) {
      final l$since = data['since'];
      result$data['since'] = (l$since as String?);
    }
    if (data.containsKey('universalId')) {
      final l$universalId = data['universalId'];
      result$data['universalId'] = (l$universalId as String?);
    }
    if (data.containsKey('appleKey')) {
      final l$appleKey = data['appleKey'];
      result$data['appleKey'] = (l$appleKey as String?);
    }
    if (data.containsKey('spotifyKey')) {
      final l$spotifyKey = data['spotifyKey'];
      result$data['spotifyKey'] = (l$spotifyKey as String?);
    }
    if (data.containsKey('lineKey')) {
      final l$lineKey = data['lineKey'];
      result$data['lineKey'] = (l$lineKey as String?);
    }
    if (data.containsKey('amazonKey')) {
      final l$amazonKey = data['amazonKey'];
      result$data['amazonKey'] = (l$amazonKey as String?);
    }
    if (data.containsKey('youtubeKey')) {
      final l$youtubeKey = data['youtubeKey'];
      result$data['youtubeKey'] = (l$youtubeKey as String?);
    }
    return Input$UpdateArtistInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get artistId => (_$data['artistId'] as String);

  String? get displayNameJp => (_$data['displayNameJp'] as String?);

  String? get displayNameEn => (_$data['displayNameEn'] as String?);

  String? get displayNameKana => (_$data['displayNameKana'] as String?);

  String? get imgUrl => (_$data['imgUrl'] as String?);

  int? get fsp => (_$data['fsp'] as int?);

  String? get status => (_$data['status'] as String?);

  String? get since => (_$data['since'] as String?);

  String? get universalId => (_$data['universalId'] as String?);

  String? get appleKey => (_$data['appleKey'] as String?);

  String? get spotifyKey => (_$data['spotifyKey'] as String?);

  String? get lineKey => (_$data['lineKey'] as String?);

  String? get amazonKey => (_$data['amazonKey'] as String?);

  String? get youtubeKey => (_$data['youtubeKey'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$artistId = artistId;
    result$data['artistId'] = l$artistId;
    if (_$data.containsKey('displayNameJp')) {
      final l$displayNameJp = displayNameJp;
      result$data['displayNameJp'] = l$displayNameJp;
    }
    if (_$data.containsKey('displayNameEn')) {
      final l$displayNameEn = displayNameEn;
      result$data['displayNameEn'] = l$displayNameEn;
    }
    if (_$data.containsKey('displayNameKana')) {
      final l$displayNameKana = displayNameKana;
      result$data['displayNameKana'] = l$displayNameKana;
    }
    if (_$data.containsKey('imgUrl')) {
      final l$imgUrl = imgUrl;
      result$data['imgUrl'] = l$imgUrl;
    }
    if (_$data.containsKey('fsp')) {
      final l$fsp = fsp;
      result$data['fsp'] = l$fsp;
    }
    if (_$data.containsKey('status')) {
      final l$status = status;
      result$data['status'] = l$status;
    }
    if (_$data.containsKey('since')) {
      final l$since = since;
      result$data['since'] = l$since;
    }
    if (_$data.containsKey('universalId')) {
      final l$universalId = universalId;
      result$data['universalId'] = l$universalId;
    }
    if (_$data.containsKey('appleKey')) {
      final l$appleKey = appleKey;
      result$data['appleKey'] = l$appleKey;
    }
    if (_$data.containsKey('spotifyKey')) {
      final l$spotifyKey = spotifyKey;
      result$data['spotifyKey'] = l$spotifyKey;
    }
    if (_$data.containsKey('lineKey')) {
      final l$lineKey = lineKey;
      result$data['lineKey'] = l$lineKey;
    }
    if (_$data.containsKey('amazonKey')) {
      final l$amazonKey = amazonKey;
      result$data['amazonKey'] = l$amazonKey;
    }
    if (_$data.containsKey('youtubeKey')) {
      final l$youtubeKey = youtubeKey;
      result$data['youtubeKey'] = l$youtubeKey;
    }
    return result$data;
  }

  CopyWith$Input$UpdateArtistInput<Input$UpdateArtistInput> get copyWith =>
      CopyWith$Input$UpdateArtistInput(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$UpdateArtistInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$artistId = artistId;
    final lOther$artistId = other.artistId;
    if (l$artistId != lOther$artistId) {
      return false;
    }
    final l$displayNameJp = displayNameJp;
    final lOther$displayNameJp = other.displayNameJp;
    if (_$data.containsKey('displayNameJp') !=
        other._$data.containsKey('displayNameJp')) {
      return false;
    }
    if (l$displayNameJp != lOther$displayNameJp) {
      return false;
    }
    final l$displayNameEn = displayNameEn;
    final lOther$displayNameEn = other.displayNameEn;
    if (_$data.containsKey('displayNameEn') !=
        other._$data.containsKey('displayNameEn')) {
      return false;
    }
    if (l$displayNameEn != lOther$displayNameEn) {
      return false;
    }
    final l$displayNameKana = displayNameKana;
    final lOther$displayNameKana = other.displayNameKana;
    if (_$data.containsKey('displayNameKana') !=
        other._$data.containsKey('displayNameKana')) {
      return false;
    }
    if (l$displayNameKana != lOther$displayNameKana) {
      return false;
    }
    final l$imgUrl = imgUrl;
    final lOther$imgUrl = other.imgUrl;
    if (_$data.containsKey('imgUrl') != other._$data.containsKey('imgUrl')) {
      return false;
    }
    if (l$imgUrl != lOther$imgUrl) {
      return false;
    }
    final l$fsp = fsp;
    final lOther$fsp = other.fsp;
    if (_$data.containsKey('fsp') != other._$data.containsKey('fsp')) {
      return false;
    }
    if (l$fsp != lOther$fsp) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (_$data.containsKey('status') != other._$data.containsKey('status')) {
      return false;
    }
    if (l$status != lOther$status) {
      return false;
    }
    final l$since = since;
    final lOther$since = other.since;
    if (_$data.containsKey('since') != other._$data.containsKey('since')) {
      return false;
    }
    if (l$since != lOther$since) {
      return false;
    }
    final l$universalId = universalId;
    final lOther$universalId = other.universalId;
    if (_$data.containsKey('universalId') !=
        other._$data.containsKey('universalId')) {
      return false;
    }
    if (l$universalId != lOther$universalId) {
      return false;
    }
    final l$appleKey = appleKey;
    final lOther$appleKey = other.appleKey;
    if (_$data.containsKey('appleKey') !=
        other._$data.containsKey('appleKey')) {
      return false;
    }
    if (l$appleKey != lOther$appleKey) {
      return false;
    }
    final l$spotifyKey = spotifyKey;
    final lOther$spotifyKey = other.spotifyKey;
    if (_$data.containsKey('spotifyKey') !=
        other._$data.containsKey('spotifyKey')) {
      return false;
    }
    if (l$spotifyKey != lOther$spotifyKey) {
      return false;
    }
    final l$lineKey = lineKey;
    final lOther$lineKey = other.lineKey;
    if (_$data.containsKey('lineKey') != other._$data.containsKey('lineKey')) {
      return false;
    }
    if (l$lineKey != lOther$lineKey) {
      return false;
    }
    final l$amazonKey = amazonKey;
    final lOther$amazonKey = other.amazonKey;
    if (_$data.containsKey('amazonKey') !=
        other._$data.containsKey('amazonKey')) {
      return false;
    }
    if (l$amazonKey != lOther$amazonKey) {
      return false;
    }
    final l$youtubeKey = youtubeKey;
    final lOther$youtubeKey = other.youtubeKey;
    if (_$data.containsKey('youtubeKey') !=
        other._$data.containsKey('youtubeKey')) {
      return false;
    }
    if (l$youtubeKey != lOther$youtubeKey) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$artistId = artistId;
    final l$displayNameJp = displayNameJp;
    final l$displayNameEn = displayNameEn;
    final l$displayNameKana = displayNameKana;
    final l$imgUrl = imgUrl;
    final l$fsp = fsp;
    final l$status = status;
    final l$since = since;
    final l$universalId = universalId;
    final l$appleKey = appleKey;
    final l$spotifyKey = spotifyKey;
    final l$lineKey = lineKey;
    final l$amazonKey = amazonKey;
    final l$youtubeKey = youtubeKey;
    return Object.hashAll([
      l$artistId,
      _$data.containsKey('displayNameJp') ? l$displayNameJp : const {},
      _$data.containsKey('displayNameEn') ? l$displayNameEn : const {},
      _$data.containsKey('displayNameKana') ? l$displayNameKana : const {},
      _$data.containsKey('imgUrl') ? l$imgUrl : const {},
      _$data.containsKey('fsp') ? l$fsp : const {},
      _$data.containsKey('status') ? l$status : const {},
      _$data.containsKey('since') ? l$since : const {},
      _$data.containsKey('universalId') ? l$universalId : const {},
      _$data.containsKey('appleKey') ? l$appleKey : const {},
      _$data.containsKey('spotifyKey') ? l$spotifyKey : const {},
      _$data.containsKey('lineKey') ? l$lineKey : const {},
      _$data.containsKey('amazonKey') ? l$amazonKey : const {},
      _$data.containsKey('youtubeKey') ? l$youtubeKey : const {},
    ]);
  }
}

abstract class CopyWith$Input$UpdateArtistInput<TRes> {
  factory CopyWith$Input$UpdateArtistInput(
    Input$UpdateArtistInput instance,
    TRes Function(Input$UpdateArtistInput) then,
  ) = _CopyWithImpl$Input$UpdateArtistInput;

  factory CopyWith$Input$UpdateArtistInput.stub(TRes res) =
      _CopyWithStubImpl$Input$UpdateArtistInput;

  TRes call({
    String? artistId,
    String? displayNameJp,
    String? displayNameEn,
    String? displayNameKana,
    String? imgUrl,
    int? fsp,
    String? status,
    String? since,
    String? universalId,
    String? appleKey,
    String? spotifyKey,
    String? lineKey,
    String? amazonKey,
    String? youtubeKey,
  });
}

class _CopyWithImpl$Input$UpdateArtistInput<TRes>
    implements CopyWith$Input$UpdateArtistInput<TRes> {
  _CopyWithImpl$Input$UpdateArtistInput(
    this._instance,
    this._then,
  );

  final Input$UpdateArtistInput _instance;

  final TRes Function(Input$UpdateArtistInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? artistId = _undefined,
    Object? displayNameJp = _undefined,
    Object? displayNameEn = _undefined,
    Object? displayNameKana = _undefined,
    Object? imgUrl = _undefined,
    Object? fsp = _undefined,
    Object? status = _undefined,
    Object? since = _undefined,
    Object? universalId = _undefined,
    Object? appleKey = _undefined,
    Object? spotifyKey = _undefined,
    Object? lineKey = _undefined,
    Object? amazonKey = _undefined,
    Object? youtubeKey = _undefined,
  }) =>
      _then(Input$UpdateArtistInput._({
        ..._instance._$data,
        if (artistId != _undefined && artistId != null)
          'artistId': (artistId as String),
        if (displayNameJp != _undefined)
          'displayNameJp': (displayNameJp as String?),
        if (displayNameEn != _undefined)
          'displayNameEn': (displayNameEn as String?),
        if (displayNameKana != _undefined)
          'displayNameKana': (displayNameKana as String?),
        if (imgUrl != _undefined) 'imgUrl': (imgUrl as String?),
        if (fsp != _undefined) 'fsp': (fsp as int?),
        if (status != _undefined) 'status': (status as String?),
        if (since != _undefined) 'since': (since as String?),
        if (universalId != _undefined) 'universalId': (universalId as String?),
        if (appleKey != _undefined) 'appleKey': (appleKey as String?),
        if (spotifyKey != _undefined) 'spotifyKey': (spotifyKey as String?),
        if (lineKey != _undefined) 'lineKey': (lineKey as String?),
        if (amazonKey != _undefined) 'amazonKey': (amazonKey as String?),
        if (youtubeKey != _undefined) 'youtubeKey': (youtubeKey as String?),
      }));
}

class _CopyWithStubImpl$Input$UpdateArtistInput<TRes>
    implements CopyWith$Input$UpdateArtistInput<TRes> {
  _CopyWithStubImpl$Input$UpdateArtistInput(this._res);

  TRes _res;

  call({
    String? artistId,
    String? displayNameJp,
    String? displayNameEn,
    String? displayNameKana,
    String? imgUrl,
    int? fsp,
    String? status,
    String? since,
    String? universalId,
    String? appleKey,
    String? spotifyKey,
    String? lineKey,
    String? amazonKey,
    String? youtubeKey,
  }) =>
      _res;
}

class Input$UpdateBelongsToArtistStatusInput {
  factory Input$UpdateBelongsToArtistStatusInput({
    required String userId,
    required String artistId,
    String? nextStatus,
    bool? nextStatusIsAdmin,
  }) =>
      Input$UpdateBelongsToArtistStatusInput._({
        r'userId': userId,
        r'artistId': artistId,
        if (nextStatus != null) r'nextStatus': nextStatus,
        if (nextStatusIsAdmin != null) r'nextStatusIsAdmin': nextStatusIsAdmin,
      });

  Input$UpdateBelongsToArtistStatusInput._(this._$data);

  factory Input$UpdateBelongsToArtistStatusInput.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    final l$artistId = data['artistId'];
    result$data['artistId'] = (l$artistId as String);
    if (data.containsKey('nextStatus')) {
      final l$nextStatus = data['nextStatus'];
      result$data['nextStatus'] = (l$nextStatus as String?);
    }
    if (data.containsKey('nextStatusIsAdmin')) {
      final l$nextStatusIsAdmin = data['nextStatusIsAdmin'];
      result$data['nextStatusIsAdmin'] = (l$nextStatusIsAdmin as bool?);
    }
    return Input$UpdateBelongsToArtistStatusInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  String get artistId => (_$data['artistId'] as String);

  String? get nextStatus => (_$data['nextStatus'] as String?);

  bool? get nextStatusIsAdmin => (_$data['nextStatusIsAdmin'] as bool?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$userId = userId;
    result$data['userId'] = l$userId;
    final l$artistId = artistId;
    result$data['artistId'] = l$artistId;
    if (_$data.containsKey('nextStatus')) {
      final l$nextStatus = nextStatus;
      result$data['nextStatus'] = l$nextStatus;
    }
    if (_$data.containsKey('nextStatusIsAdmin')) {
      final l$nextStatusIsAdmin = nextStatusIsAdmin;
      result$data['nextStatusIsAdmin'] = l$nextStatusIsAdmin;
    }
    return result$data;
  }

  CopyWith$Input$UpdateBelongsToArtistStatusInput<
          Input$UpdateBelongsToArtistStatusInput>
      get copyWith => CopyWith$Input$UpdateBelongsToArtistStatusInput(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$UpdateBelongsToArtistStatusInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$artistId = artistId;
    final lOther$artistId = other.artistId;
    if (l$artistId != lOther$artistId) {
      return false;
    }
    final l$nextStatus = nextStatus;
    final lOther$nextStatus = other.nextStatus;
    if (_$data.containsKey('nextStatus') !=
        other._$data.containsKey('nextStatus')) {
      return false;
    }
    if (l$nextStatus != lOther$nextStatus) {
      return false;
    }
    final l$nextStatusIsAdmin = nextStatusIsAdmin;
    final lOther$nextStatusIsAdmin = other.nextStatusIsAdmin;
    if (_$data.containsKey('nextStatusIsAdmin') !=
        other._$data.containsKey('nextStatusIsAdmin')) {
      return false;
    }
    if (l$nextStatusIsAdmin != lOther$nextStatusIsAdmin) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$artistId = artistId;
    final l$nextStatus = nextStatus;
    final l$nextStatusIsAdmin = nextStatusIsAdmin;
    return Object.hashAll([
      l$userId,
      l$artistId,
      _$data.containsKey('nextStatus') ? l$nextStatus : const {},
      _$data.containsKey('nextStatusIsAdmin') ? l$nextStatusIsAdmin : const {},
    ]);
  }
}

abstract class CopyWith$Input$UpdateBelongsToArtistStatusInput<TRes> {
  factory CopyWith$Input$UpdateBelongsToArtistStatusInput(
    Input$UpdateBelongsToArtistStatusInput instance,
    TRes Function(Input$UpdateBelongsToArtistStatusInput) then,
  ) = _CopyWithImpl$Input$UpdateBelongsToArtistStatusInput;

  factory CopyWith$Input$UpdateBelongsToArtistStatusInput.stub(TRes res) =
      _CopyWithStubImpl$Input$UpdateBelongsToArtistStatusInput;

  TRes call({
    String? userId,
    String? artistId,
    String? nextStatus,
    bool? nextStatusIsAdmin,
  });
}

class _CopyWithImpl$Input$UpdateBelongsToArtistStatusInput<TRes>
    implements CopyWith$Input$UpdateBelongsToArtistStatusInput<TRes> {
  _CopyWithImpl$Input$UpdateBelongsToArtistStatusInput(
    this._instance,
    this._then,
  );

  final Input$UpdateBelongsToArtistStatusInput _instance;

  final TRes Function(Input$UpdateBelongsToArtistStatusInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? userId = _undefined,
    Object? artistId = _undefined,
    Object? nextStatus = _undefined,
    Object? nextStatusIsAdmin = _undefined,
  }) =>
      _then(Input$UpdateBelongsToArtistStatusInput._({
        ..._instance._$data,
        if (userId != _undefined && userId != null)
          'userId': (userId as String),
        if (artistId != _undefined && artistId != null)
          'artistId': (artistId as String),
        if (nextStatus != _undefined) 'nextStatus': (nextStatus as String?),
        if (nextStatusIsAdmin != _undefined)
          'nextStatusIsAdmin': (nextStatusIsAdmin as bool?),
      }));
}

class _CopyWithStubImpl$Input$UpdateBelongsToArtistStatusInput<TRes>
    implements CopyWith$Input$UpdateBelongsToArtistStatusInput<TRes> {
  _CopyWithStubImpl$Input$UpdateBelongsToArtistStatusInput(this._res);

  TRes _res;

  call({
    String? userId,
    String? artistId,
    String? nextStatus,
    bool? nextStatusIsAdmin,
  }) =>
      _res;
}

class Input$UpdateCreditInput {
  factory Input$UpdateCreditInput({
    required int creditId,
    required String commitUser,
    String? creditRole,
    String? creditName,
    String? email,
    bool? isInvite,
    String? memo,
  }) =>
      Input$UpdateCreditInput._({
        r'creditId': creditId,
        r'commitUser': commitUser,
        if (creditRole != null) r'creditRole': creditRole,
        if (creditName != null) r'creditName': creditName,
        if (email != null) r'email': email,
        if (isInvite != null) r'isInvite': isInvite,
        if (memo != null) r'memo': memo,
      });

  Input$UpdateCreditInput._(this._$data);

  factory Input$UpdateCreditInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$creditId = data['creditId'];
    result$data['creditId'] = (l$creditId as int);
    final l$commitUser = data['commitUser'];
    result$data['commitUser'] = (l$commitUser as String);
    if (data.containsKey('creditRole')) {
      final l$creditRole = data['creditRole'];
      result$data['creditRole'] = (l$creditRole as String?);
    }
    if (data.containsKey('creditName')) {
      final l$creditName = data['creditName'];
      result$data['creditName'] = (l$creditName as String?);
    }
    if (data.containsKey('email')) {
      final l$email = data['email'];
      result$data['email'] = (l$email as String?);
    }
    if (data.containsKey('isInvite')) {
      final l$isInvite = data['isInvite'];
      result$data['isInvite'] = (l$isInvite as bool?);
    }
    if (data.containsKey('memo')) {
      final l$memo = data['memo'];
      result$data['memo'] = (l$memo as String?);
    }
    return Input$UpdateCreditInput._(result$data);
  }

  Map<String, dynamic> _$data;

  int get creditId => (_$data['creditId'] as int);

  String get commitUser => (_$data['commitUser'] as String);

  String? get creditRole => (_$data['creditRole'] as String?);

  String? get creditName => (_$data['creditName'] as String?);

  String? get email => (_$data['email'] as String?);

  bool? get isInvite => (_$data['isInvite'] as bool?);

  String? get memo => (_$data['memo'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$creditId = creditId;
    result$data['creditId'] = l$creditId;
    final l$commitUser = commitUser;
    result$data['commitUser'] = l$commitUser;
    if (_$data.containsKey('creditRole')) {
      final l$creditRole = creditRole;
      result$data['creditRole'] = l$creditRole;
    }
    if (_$data.containsKey('creditName')) {
      final l$creditName = creditName;
      result$data['creditName'] = l$creditName;
    }
    if (_$data.containsKey('email')) {
      final l$email = email;
      result$data['email'] = l$email;
    }
    if (_$data.containsKey('isInvite')) {
      final l$isInvite = isInvite;
      result$data['isInvite'] = l$isInvite;
    }
    if (_$data.containsKey('memo')) {
      final l$memo = memo;
      result$data['memo'] = l$memo;
    }
    return result$data;
  }

  CopyWith$Input$UpdateCreditInput<Input$UpdateCreditInput> get copyWith =>
      CopyWith$Input$UpdateCreditInput(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$UpdateCreditInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$creditId = creditId;
    final lOther$creditId = other.creditId;
    if (l$creditId != lOther$creditId) {
      return false;
    }
    final l$commitUser = commitUser;
    final lOther$commitUser = other.commitUser;
    if (l$commitUser != lOther$commitUser) {
      return false;
    }
    final l$creditRole = creditRole;
    final lOther$creditRole = other.creditRole;
    if (_$data.containsKey('creditRole') !=
        other._$data.containsKey('creditRole')) {
      return false;
    }
    if (l$creditRole != lOther$creditRole) {
      return false;
    }
    final l$creditName = creditName;
    final lOther$creditName = other.creditName;
    if (_$data.containsKey('creditName') !=
        other._$data.containsKey('creditName')) {
      return false;
    }
    if (l$creditName != lOther$creditName) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (_$data.containsKey('email') != other._$data.containsKey('email')) {
      return false;
    }
    if (l$email != lOther$email) {
      return false;
    }
    final l$isInvite = isInvite;
    final lOther$isInvite = other.isInvite;
    if (_$data.containsKey('isInvite') !=
        other._$data.containsKey('isInvite')) {
      return false;
    }
    if (l$isInvite != lOther$isInvite) {
      return false;
    }
    final l$memo = memo;
    final lOther$memo = other.memo;
    if (_$data.containsKey('memo') != other._$data.containsKey('memo')) {
      return false;
    }
    if (l$memo != lOther$memo) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$creditId = creditId;
    final l$commitUser = commitUser;
    final l$creditRole = creditRole;
    final l$creditName = creditName;
    final l$email = email;
    final l$isInvite = isInvite;
    final l$memo = memo;
    return Object.hashAll([
      l$creditId,
      l$commitUser,
      _$data.containsKey('creditRole') ? l$creditRole : const {},
      _$data.containsKey('creditName') ? l$creditName : const {},
      _$data.containsKey('email') ? l$email : const {},
      _$data.containsKey('isInvite') ? l$isInvite : const {},
      _$data.containsKey('memo') ? l$memo : const {},
    ]);
  }
}

abstract class CopyWith$Input$UpdateCreditInput<TRes> {
  factory CopyWith$Input$UpdateCreditInput(
    Input$UpdateCreditInput instance,
    TRes Function(Input$UpdateCreditInput) then,
  ) = _CopyWithImpl$Input$UpdateCreditInput;

  factory CopyWith$Input$UpdateCreditInput.stub(TRes res) =
      _CopyWithStubImpl$Input$UpdateCreditInput;

  TRes call({
    int? creditId,
    String? commitUser,
    String? creditRole,
    String? creditName,
    String? email,
    bool? isInvite,
    String? memo,
  });
}

class _CopyWithImpl$Input$UpdateCreditInput<TRes>
    implements CopyWith$Input$UpdateCreditInput<TRes> {
  _CopyWithImpl$Input$UpdateCreditInput(
    this._instance,
    this._then,
  );

  final Input$UpdateCreditInput _instance;

  final TRes Function(Input$UpdateCreditInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? creditId = _undefined,
    Object? commitUser = _undefined,
    Object? creditRole = _undefined,
    Object? creditName = _undefined,
    Object? email = _undefined,
    Object? isInvite = _undefined,
    Object? memo = _undefined,
  }) =>
      _then(Input$UpdateCreditInput._({
        ..._instance._$data,
        if (creditId != _undefined && creditId != null)
          'creditId': (creditId as int),
        if (commitUser != _undefined && commitUser != null)
          'commitUser': (commitUser as String),
        if (creditRole != _undefined) 'creditRole': (creditRole as String?),
        if (creditName != _undefined) 'creditName': (creditName as String?),
        if (email != _undefined) 'email': (email as String?),
        if (isInvite != _undefined) 'isInvite': (isInvite as bool?),
        if (memo != _undefined) 'memo': (memo as String?),
      }));
}

class _CopyWithStubImpl$Input$UpdateCreditInput<TRes>
    implements CopyWith$Input$UpdateCreditInput<TRes> {
  _CopyWithStubImpl$Input$UpdateCreditInput(this._res);

  TRes _res;

  call({
    int? creditId,
    String? commitUser,
    String? creditRole,
    String? creditName,
    String? email,
    bool? isInvite,
    String? memo,
  }) =>
      _res;
}

class Input$UpdateOfferInput {
  factory Input$UpdateOfferInput({
    required int id,
    String? title,
    String? description,
    int? fee,
    String? imageUrl,
    String? category,
    String? place,
    String? attention,
    String? requiredSkill,
    String? targetRole,
    List<String>? attachedImgs,
    List<String>? attachedFiles,
    bool? publicity,
    String? deadline,
  }) =>
      Input$UpdateOfferInput._({
        r'id': id,
        if (title != null) r'title': title,
        if (description != null) r'description': description,
        if (fee != null) r'fee': fee,
        if (imageUrl != null) r'imageUrl': imageUrl,
        if (category != null) r'category': category,
        if (place != null) r'place': place,
        if (attention != null) r'attention': attention,
        if (requiredSkill != null) r'requiredSkill': requiredSkill,
        if (targetRole != null) r'targetRole': targetRole,
        if (attachedImgs != null) r'attachedImgs': attachedImgs,
        if (attachedFiles != null) r'attachedFiles': attachedFiles,
        if (publicity != null) r'publicity': publicity,
        if (deadline != null) r'deadline': deadline,
      });

  Input$UpdateOfferInput._(this._$data);

  factory Input$UpdateOfferInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as int);
    if (data.containsKey('title')) {
      final l$title = data['title'];
      result$data['title'] = (l$title as String?);
    }
    if (data.containsKey('description')) {
      final l$description = data['description'];
      result$data['description'] = (l$description as String?);
    }
    if (data.containsKey('fee')) {
      final l$fee = data['fee'];
      result$data['fee'] = (l$fee as int?);
    }
    if (data.containsKey('imageUrl')) {
      final l$imageUrl = data['imageUrl'];
      result$data['imageUrl'] = (l$imageUrl as String?);
    }
    if (data.containsKey('category')) {
      final l$category = data['category'];
      result$data['category'] = (l$category as String?);
    }
    if (data.containsKey('place')) {
      final l$place = data['place'];
      result$data['place'] = (l$place as String?);
    }
    if (data.containsKey('attention')) {
      final l$attention = data['attention'];
      result$data['attention'] = (l$attention as String?);
    }
    if (data.containsKey('requiredSkill')) {
      final l$requiredSkill = data['requiredSkill'];
      result$data['requiredSkill'] = (l$requiredSkill as String?);
    }
    if (data.containsKey('targetRole')) {
      final l$targetRole = data['targetRole'];
      result$data['targetRole'] = (l$targetRole as String?);
    }
    if (data.containsKey('attachedImgs')) {
      final l$attachedImgs = data['attachedImgs'];
      result$data['attachedImgs'] = (l$attachedImgs as List<dynamic>?)
          ?.map((e) => (e as String))
          .toList();
    }
    if (data.containsKey('attachedFiles')) {
      final l$attachedFiles = data['attachedFiles'];
      result$data['attachedFiles'] = (l$attachedFiles as List<dynamic>?)
          ?.map((e) => (e as String))
          .toList();
    }
    if (data.containsKey('publicity')) {
      final l$publicity = data['publicity'];
      result$data['publicity'] = (l$publicity as bool?);
    }
    if (data.containsKey('deadline')) {
      final l$deadline = data['deadline'];
      result$data['deadline'] = (l$deadline as String?);
    }
    return Input$UpdateOfferInput._(result$data);
  }

  Map<String, dynamic> _$data;

  int get id => (_$data['id'] as int);

  String? get title => (_$data['title'] as String?);

  String? get description => (_$data['description'] as String?);

  int? get fee => (_$data['fee'] as int?);

  String? get imageUrl => (_$data['imageUrl'] as String?);

  String? get category => (_$data['category'] as String?);

  String? get place => (_$data['place'] as String?);

  String? get attention => (_$data['attention'] as String?);

  String? get requiredSkill => (_$data['requiredSkill'] as String?);

  String? get targetRole => (_$data['targetRole'] as String?);

  List<String>? get attachedImgs => (_$data['attachedImgs'] as List<String>?);

  List<String>? get attachedFiles => (_$data['attachedFiles'] as List<String>?);

  bool? get publicity => (_$data['publicity'] as bool?);

  String? get deadline => (_$data['deadline'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    if (_$data.containsKey('title')) {
      final l$title = title;
      result$data['title'] = l$title;
    }
    if (_$data.containsKey('description')) {
      final l$description = description;
      result$data['description'] = l$description;
    }
    if (_$data.containsKey('fee')) {
      final l$fee = fee;
      result$data['fee'] = l$fee;
    }
    if (_$data.containsKey('imageUrl')) {
      final l$imageUrl = imageUrl;
      result$data['imageUrl'] = l$imageUrl;
    }
    if (_$data.containsKey('category')) {
      final l$category = category;
      result$data['category'] = l$category;
    }
    if (_$data.containsKey('place')) {
      final l$place = place;
      result$data['place'] = l$place;
    }
    if (_$data.containsKey('attention')) {
      final l$attention = attention;
      result$data['attention'] = l$attention;
    }
    if (_$data.containsKey('requiredSkill')) {
      final l$requiredSkill = requiredSkill;
      result$data['requiredSkill'] = l$requiredSkill;
    }
    if (_$data.containsKey('targetRole')) {
      final l$targetRole = targetRole;
      result$data['targetRole'] = l$targetRole;
    }
    if (_$data.containsKey('attachedImgs')) {
      final l$attachedImgs = attachedImgs;
      result$data['attachedImgs'] = l$attachedImgs?.map((e) => e).toList();
    }
    if (_$data.containsKey('attachedFiles')) {
      final l$attachedFiles = attachedFiles;
      result$data['attachedFiles'] = l$attachedFiles?.map((e) => e).toList();
    }
    if (_$data.containsKey('publicity')) {
      final l$publicity = publicity;
      result$data['publicity'] = l$publicity;
    }
    if (_$data.containsKey('deadline')) {
      final l$deadline = deadline;
      result$data['deadline'] = l$deadline;
    }
    return result$data;
  }

  CopyWith$Input$UpdateOfferInput<Input$UpdateOfferInput> get copyWith =>
      CopyWith$Input$UpdateOfferInput(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$UpdateOfferInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (_$data.containsKey('title') != other._$data.containsKey('title')) {
      return false;
    }
    if (l$title != lOther$title) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (_$data.containsKey('description') !=
        other._$data.containsKey('description')) {
      return false;
    }
    if (l$description != lOther$description) {
      return false;
    }
    final l$fee = fee;
    final lOther$fee = other.fee;
    if (_$data.containsKey('fee') != other._$data.containsKey('fee')) {
      return false;
    }
    if (l$fee != lOther$fee) {
      return false;
    }
    final l$imageUrl = imageUrl;
    final lOther$imageUrl = other.imageUrl;
    if (_$data.containsKey('imageUrl') !=
        other._$data.containsKey('imageUrl')) {
      return false;
    }
    if (l$imageUrl != lOther$imageUrl) {
      return false;
    }
    final l$category = category;
    final lOther$category = other.category;
    if (_$data.containsKey('category') !=
        other._$data.containsKey('category')) {
      return false;
    }
    if (l$category != lOther$category) {
      return false;
    }
    final l$place = place;
    final lOther$place = other.place;
    if (_$data.containsKey('place') != other._$data.containsKey('place')) {
      return false;
    }
    if (l$place != lOther$place) {
      return false;
    }
    final l$attention = attention;
    final lOther$attention = other.attention;
    if (_$data.containsKey('attention') !=
        other._$data.containsKey('attention')) {
      return false;
    }
    if (l$attention != lOther$attention) {
      return false;
    }
    final l$requiredSkill = requiredSkill;
    final lOther$requiredSkill = other.requiredSkill;
    if (_$data.containsKey('requiredSkill') !=
        other._$data.containsKey('requiredSkill')) {
      return false;
    }
    if (l$requiredSkill != lOther$requiredSkill) {
      return false;
    }
    final l$targetRole = targetRole;
    final lOther$targetRole = other.targetRole;
    if (_$data.containsKey('targetRole') !=
        other._$data.containsKey('targetRole')) {
      return false;
    }
    if (l$targetRole != lOther$targetRole) {
      return false;
    }
    final l$attachedImgs = attachedImgs;
    final lOther$attachedImgs = other.attachedImgs;
    if (_$data.containsKey('attachedImgs') !=
        other._$data.containsKey('attachedImgs')) {
      return false;
    }
    if (l$attachedImgs != null && lOther$attachedImgs != null) {
      if (l$attachedImgs.length != lOther$attachedImgs.length) {
        return false;
      }
      for (int i = 0; i < l$attachedImgs.length; i++) {
        final l$attachedImgs$entry = l$attachedImgs[i];
        final lOther$attachedImgs$entry = lOther$attachedImgs[i];
        if (l$attachedImgs$entry != lOther$attachedImgs$entry) {
          return false;
        }
      }
    } else if (l$attachedImgs != lOther$attachedImgs) {
      return false;
    }
    final l$attachedFiles = attachedFiles;
    final lOther$attachedFiles = other.attachedFiles;
    if (_$data.containsKey('attachedFiles') !=
        other._$data.containsKey('attachedFiles')) {
      return false;
    }
    if (l$attachedFiles != null && lOther$attachedFiles != null) {
      if (l$attachedFiles.length != lOther$attachedFiles.length) {
        return false;
      }
      for (int i = 0; i < l$attachedFiles.length; i++) {
        final l$attachedFiles$entry = l$attachedFiles[i];
        final lOther$attachedFiles$entry = lOther$attachedFiles[i];
        if (l$attachedFiles$entry != lOther$attachedFiles$entry) {
          return false;
        }
      }
    } else if (l$attachedFiles != lOther$attachedFiles) {
      return false;
    }
    final l$publicity = publicity;
    final lOther$publicity = other.publicity;
    if (_$data.containsKey('publicity') !=
        other._$data.containsKey('publicity')) {
      return false;
    }
    if (l$publicity != lOther$publicity) {
      return false;
    }
    final l$deadline = deadline;
    final lOther$deadline = other.deadline;
    if (_$data.containsKey('deadline') !=
        other._$data.containsKey('deadline')) {
      return false;
    }
    if (l$deadline != lOther$deadline) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$title = title;
    final l$description = description;
    final l$fee = fee;
    final l$imageUrl = imageUrl;
    final l$category = category;
    final l$place = place;
    final l$attention = attention;
    final l$requiredSkill = requiredSkill;
    final l$targetRole = targetRole;
    final l$attachedImgs = attachedImgs;
    final l$attachedFiles = attachedFiles;
    final l$publicity = publicity;
    final l$deadline = deadline;
    return Object.hashAll([
      l$id,
      _$data.containsKey('title') ? l$title : const {},
      _$data.containsKey('description') ? l$description : const {},
      _$data.containsKey('fee') ? l$fee : const {},
      _$data.containsKey('imageUrl') ? l$imageUrl : const {},
      _$data.containsKey('category') ? l$category : const {},
      _$data.containsKey('place') ? l$place : const {},
      _$data.containsKey('attention') ? l$attention : const {},
      _$data.containsKey('requiredSkill') ? l$requiredSkill : const {},
      _$data.containsKey('targetRole') ? l$targetRole : const {},
      _$data.containsKey('attachedImgs')
          ? l$attachedImgs == null
              ? null
              : Object.hashAll(l$attachedImgs.map((v) => v))
          : const {},
      _$data.containsKey('attachedFiles')
          ? l$attachedFiles == null
              ? null
              : Object.hashAll(l$attachedFiles.map((v) => v))
          : const {},
      _$data.containsKey('publicity') ? l$publicity : const {},
      _$data.containsKey('deadline') ? l$deadline : const {},
    ]);
  }
}

abstract class CopyWith$Input$UpdateOfferInput<TRes> {
  factory CopyWith$Input$UpdateOfferInput(
    Input$UpdateOfferInput instance,
    TRes Function(Input$UpdateOfferInput) then,
  ) = _CopyWithImpl$Input$UpdateOfferInput;

  factory CopyWith$Input$UpdateOfferInput.stub(TRes res) =
      _CopyWithStubImpl$Input$UpdateOfferInput;

  TRes call({
    int? id,
    String? title,
    String? description,
    int? fee,
    String? imageUrl,
    String? category,
    String? place,
    String? attention,
    String? requiredSkill,
    String? targetRole,
    List<String>? attachedImgs,
    List<String>? attachedFiles,
    bool? publicity,
    String? deadline,
  });
}

class _CopyWithImpl$Input$UpdateOfferInput<TRes>
    implements CopyWith$Input$UpdateOfferInput<TRes> {
  _CopyWithImpl$Input$UpdateOfferInput(
    this._instance,
    this._then,
  );

  final Input$UpdateOfferInput _instance;

  final TRes Function(Input$UpdateOfferInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? title = _undefined,
    Object? description = _undefined,
    Object? fee = _undefined,
    Object? imageUrl = _undefined,
    Object? category = _undefined,
    Object? place = _undefined,
    Object? attention = _undefined,
    Object? requiredSkill = _undefined,
    Object? targetRole = _undefined,
    Object? attachedImgs = _undefined,
    Object? attachedFiles = _undefined,
    Object? publicity = _undefined,
    Object? deadline = _undefined,
  }) =>
      _then(Input$UpdateOfferInput._({
        ..._instance._$data,
        if (id != _undefined && id != null) 'id': (id as int),
        if (title != _undefined) 'title': (title as String?),
        if (description != _undefined) 'description': (description as String?),
        if (fee != _undefined) 'fee': (fee as int?),
        if (imageUrl != _undefined) 'imageUrl': (imageUrl as String?),
        if (category != _undefined) 'category': (category as String?),
        if (place != _undefined) 'place': (place as String?),
        if (attention != _undefined) 'attention': (attention as String?),
        if (requiredSkill != _undefined)
          'requiredSkill': (requiredSkill as String?),
        if (targetRole != _undefined) 'targetRole': (targetRole as String?),
        if (attachedImgs != _undefined)
          'attachedImgs': (attachedImgs as List<String>?),
        if (attachedFiles != _undefined)
          'attachedFiles': (attachedFiles as List<String>?),
        if (publicity != _undefined) 'publicity': (publicity as bool?),
        if (deadline != _undefined) 'deadline': (deadline as String?),
      }));
}

class _CopyWithStubImpl$Input$UpdateOfferInput<TRes>
    implements CopyWith$Input$UpdateOfferInput<TRes> {
  _CopyWithStubImpl$Input$UpdateOfferInput(this._res);

  TRes _res;

  call({
    int? id,
    String? title,
    String? description,
    int? fee,
    String? imageUrl,
    String? category,
    String? place,
    String? attention,
    String? requiredSkill,
    String? targetRole,
    List<String>? attachedImgs,
    List<String>? attachedFiles,
    bool? publicity,
    String? deadline,
  }) =>
      _res;
}

class Input$UpdateOfferStatusInput {
  factory Input$UpdateOfferStatusInput({
    required int id,
    required String userId,
    required String status,
  }) =>
      Input$UpdateOfferStatusInput._({
        r'id': id,
        r'userId': userId,
        r'status': status,
      });

  Input$UpdateOfferStatusInput._(this._$data);

  factory Input$UpdateOfferStatusInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as int);
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    final l$status = data['status'];
    result$data['status'] = (l$status as String);
    return Input$UpdateOfferStatusInput._(result$data);
  }

  Map<String, dynamic> _$data;

  int get id => (_$data['id'] as int);

  String get userId => (_$data['userId'] as String);

  String get status => (_$data['status'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    final l$userId = userId;
    result$data['userId'] = l$userId;
    final l$status = status;
    result$data['status'] = l$status;
    return result$data;
  }

  CopyWith$Input$UpdateOfferStatusInput<Input$UpdateOfferStatusInput>
      get copyWith => CopyWith$Input$UpdateOfferStatusInput(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$UpdateOfferStatusInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$userId = userId;
    final l$status = status;
    return Object.hashAll([
      l$id,
      l$userId,
      l$status,
    ]);
  }
}

abstract class CopyWith$Input$UpdateOfferStatusInput<TRes> {
  factory CopyWith$Input$UpdateOfferStatusInput(
    Input$UpdateOfferStatusInput instance,
    TRes Function(Input$UpdateOfferStatusInput) then,
  ) = _CopyWithImpl$Input$UpdateOfferStatusInput;

  factory CopyWith$Input$UpdateOfferStatusInput.stub(TRes res) =
      _CopyWithStubImpl$Input$UpdateOfferStatusInput;

  TRes call({
    int? id,
    String? userId,
    String? status,
  });
}

class _CopyWithImpl$Input$UpdateOfferStatusInput<TRes>
    implements CopyWith$Input$UpdateOfferStatusInput<TRes> {
  _CopyWithImpl$Input$UpdateOfferStatusInput(
    this._instance,
    this._then,
  );

  final Input$UpdateOfferStatusInput _instance;

  final TRes Function(Input$UpdateOfferStatusInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? userId = _undefined,
    Object? status = _undefined,
  }) =>
      _then(Input$UpdateOfferStatusInput._({
        ..._instance._$data,
        if (id != _undefined && id != null) 'id': (id as int),
        if (userId != _undefined && userId != null)
          'userId': (userId as String),
        if (status != _undefined && status != null)
          'status': (status as String),
      }));
}

class _CopyWithStubImpl$Input$UpdateOfferStatusInput<TRes>
    implements CopyWith$Input$UpdateOfferStatusInput<TRes> {
  _CopyWithStubImpl$Input$UpdateOfferStatusInput(this._res);

  TRes _res;

  call({
    int? id,
    String? userId,
    String? status,
  }) =>
      _res;
}

class Input$UpdatePortfolioInput {
  factory Input$UpdatePortfolioInput({
    required int id,
    String? title,
    String? description,
    String? imgUrl,
    String? category,
    String? releaseDate,
    String? externalUrl,
  }) =>
      Input$UpdatePortfolioInput._({
        r'id': id,
        if (title != null) r'title': title,
        if (description != null) r'description': description,
        if (imgUrl != null) r'imgUrl': imgUrl,
        if (category != null) r'category': category,
        if (releaseDate != null) r'releaseDate': releaseDate,
        if (externalUrl != null) r'externalUrl': externalUrl,
      });

  Input$UpdatePortfolioInput._(this._$data);

  factory Input$UpdatePortfolioInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as int);
    if (data.containsKey('title')) {
      final l$title = data['title'];
      result$data['title'] = (l$title as String?);
    }
    if (data.containsKey('description')) {
      final l$description = data['description'];
      result$data['description'] = (l$description as String?);
    }
    if (data.containsKey('imgUrl')) {
      final l$imgUrl = data['imgUrl'];
      result$data['imgUrl'] = (l$imgUrl as String?);
    }
    if (data.containsKey('category')) {
      final l$category = data['category'];
      result$data['category'] = (l$category as String?);
    }
    if (data.containsKey('releaseDate')) {
      final l$releaseDate = data['releaseDate'];
      result$data['releaseDate'] = (l$releaseDate as String?);
    }
    if (data.containsKey('externalUrl')) {
      final l$externalUrl = data['externalUrl'];
      result$data['externalUrl'] = (l$externalUrl as String?);
    }
    return Input$UpdatePortfolioInput._(result$data);
  }

  Map<String, dynamic> _$data;

  int get id => (_$data['id'] as int);

  String? get title => (_$data['title'] as String?);

  String? get description => (_$data['description'] as String?);

  String? get imgUrl => (_$data['imgUrl'] as String?);

  String? get category => (_$data['category'] as String?);

  String? get releaseDate => (_$data['releaseDate'] as String?);

  String? get externalUrl => (_$data['externalUrl'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    if (_$data.containsKey('title')) {
      final l$title = title;
      result$data['title'] = l$title;
    }
    if (_$data.containsKey('description')) {
      final l$description = description;
      result$data['description'] = l$description;
    }
    if (_$data.containsKey('imgUrl')) {
      final l$imgUrl = imgUrl;
      result$data['imgUrl'] = l$imgUrl;
    }
    if (_$data.containsKey('category')) {
      final l$category = category;
      result$data['category'] = l$category;
    }
    if (_$data.containsKey('releaseDate')) {
      final l$releaseDate = releaseDate;
      result$data['releaseDate'] = l$releaseDate;
    }
    if (_$data.containsKey('externalUrl')) {
      final l$externalUrl = externalUrl;
      result$data['externalUrl'] = l$externalUrl;
    }
    return result$data;
  }

  CopyWith$Input$UpdatePortfolioInput<Input$UpdatePortfolioInput>
      get copyWith => CopyWith$Input$UpdatePortfolioInput(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$UpdatePortfolioInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (_$data.containsKey('title') != other._$data.containsKey('title')) {
      return false;
    }
    if (l$title != lOther$title) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (_$data.containsKey('description') !=
        other._$data.containsKey('description')) {
      return false;
    }
    if (l$description != lOther$description) {
      return false;
    }
    final l$imgUrl = imgUrl;
    final lOther$imgUrl = other.imgUrl;
    if (_$data.containsKey('imgUrl') != other._$data.containsKey('imgUrl')) {
      return false;
    }
    if (l$imgUrl != lOther$imgUrl) {
      return false;
    }
    final l$category = category;
    final lOther$category = other.category;
    if (_$data.containsKey('category') !=
        other._$data.containsKey('category')) {
      return false;
    }
    if (l$category != lOther$category) {
      return false;
    }
    final l$releaseDate = releaseDate;
    final lOther$releaseDate = other.releaseDate;
    if (_$data.containsKey('releaseDate') !=
        other._$data.containsKey('releaseDate')) {
      return false;
    }
    if (l$releaseDate != lOther$releaseDate) {
      return false;
    }
    final l$externalUrl = externalUrl;
    final lOther$externalUrl = other.externalUrl;
    if (_$data.containsKey('externalUrl') !=
        other._$data.containsKey('externalUrl')) {
      return false;
    }
    if (l$externalUrl != lOther$externalUrl) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$title = title;
    final l$description = description;
    final l$imgUrl = imgUrl;
    final l$category = category;
    final l$releaseDate = releaseDate;
    final l$externalUrl = externalUrl;
    return Object.hashAll([
      l$id,
      _$data.containsKey('title') ? l$title : const {},
      _$data.containsKey('description') ? l$description : const {},
      _$data.containsKey('imgUrl') ? l$imgUrl : const {},
      _$data.containsKey('category') ? l$category : const {},
      _$data.containsKey('releaseDate') ? l$releaseDate : const {},
      _$data.containsKey('externalUrl') ? l$externalUrl : const {},
    ]);
  }
}

abstract class CopyWith$Input$UpdatePortfolioInput<TRes> {
  factory CopyWith$Input$UpdatePortfolioInput(
    Input$UpdatePortfolioInput instance,
    TRes Function(Input$UpdatePortfolioInput) then,
  ) = _CopyWithImpl$Input$UpdatePortfolioInput;

  factory CopyWith$Input$UpdatePortfolioInput.stub(TRes res) =
      _CopyWithStubImpl$Input$UpdatePortfolioInput;

  TRes call({
    int? id,
    String? title,
    String? description,
    String? imgUrl,
    String? category,
    String? releaseDate,
    String? externalUrl,
  });
}

class _CopyWithImpl$Input$UpdatePortfolioInput<TRes>
    implements CopyWith$Input$UpdatePortfolioInput<TRes> {
  _CopyWithImpl$Input$UpdatePortfolioInput(
    this._instance,
    this._then,
  );

  final Input$UpdatePortfolioInput _instance;

  final TRes Function(Input$UpdatePortfolioInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? title = _undefined,
    Object? description = _undefined,
    Object? imgUrl = _undefined,
    Object? category = _undefined,
    Object? releaseDate = _undefined,
    Object? externalUrl = _undefined,
  }) =>
      _then(Input$UpdatePortfolioInput._({
        ..._instance._$data,
        if (id != _undefined && id != null) 'id': (id as int),
        if (title != _undefined) 'title': (title as String?),
        if (description != _undefined) 'description': (description as String?),
        if (imgUrl != _undefined) 'imgUrl': (imgUrl as String?),
        if (category != _undefined) 'category': (category as String?),
        if (releaseDate != _undefined) 'releaseDate': (releaseDate as String?),
        if (externalUrl != _undefined) 'externalUrl': (externalUrl as String?),
      }));
}

class _CopyWithStubImpl$Input$UpdatePortfolioInput<TRes>
    implements CopyWith$Input$UpdatePortfolioInput<TRes> {
  _CopyWithStubImpl$Input$UpdatePortfolioInput(this._res);

  TRes _res;

  call({
    int? id,
    String? title,
    String? description,
    String? imgUrl,
    String? category,
    String? releaseDate,
    String? externalUrl,
  }) =>
      _res;
}

class Input$UpdateProductInput {
  factory Input$UpdateProductInput({
    required String upc,
    String? title,
    String? imgUrl,
    String? type,
    String? distributedAt,
    String? artistId,
  }) =>
      Input$UpdateProductInput._({
        r'upc': upc,
        if (title != null) r'title': title,
        if (imgUrl != null) r'imgUrl': imgUrl,
        if (type != null) r'type': type,
        if (distributedAt != null) r'distributedAt': distributedAt,
        if (artistId != null) r'artistId': artistId,
      });

  Input$UpdateProductInput._(this._$data);

  factory Input$UpdateProductInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$upc = data['upc'];
    result$data['upc'] = (l$upc as String);
    if (data.containsKey('title')) {
      final l$title = data['title'];
      result$data['title'] = (l$title as String?);
    }
    if (data.containsKey('imgUrl')) {
      final l$imgUrl = data['imgUrl'];
      result$data['imgUrl'] = (l$imgUrl as String?);
    }
    if (data.containsKey('type')) {
      final l$type = data['type'];
      result$data['type'] = (l$type as String?);
    }
    if (data.containsKey('distributedAt')) {
      final l$distributedAt = data['distributedAt'];
      result$data['distributedAt'] = (l$distributedAt as String?);
    }
    if (data.containsKey('artistId')) {
      final l$artistId = data['artistId'];
      result$data['artistId'] = (l$artistId as String?);
    }
    return Input$UpdateProductInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get upc => (_$data['upc'] as String);

  String? get title => (_$data['title'] as String?);

  String? get imgUrl => (_$data['imgUrl'] as String?);

  String? get type => (_$data['type'] as String?);

  String? get distributedAt => (_$data['distributedAt'] as String?);

  String? get artistId => (_$data['artistId'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$upc = upc;
    result$data['upc'] = l$upc;
    if (_$data.containsKey('title')) {
      final l$title = title;
      result$data['title'] = l$title;
    }
    if (_$data.containsKey('imgUrl')) {
      final l$imgUrl = imgUrl;
      result$data['imgUrl'] = l$imgUrl;
    }
    if (_$data.containsKey('type')) {
      final l$type = type;
      result$data['type'] = l$type;
    }
    if (_$data.containsKey('distributedAt')) {
      final l$distributedAt = distributedAt;
      result$data['distributedAt'] = l$distributedAt;
    }
    if (_$data.containsKey('artistId')) {
      final l$artistId = artistId;
      result$data['artistId'] = l$artistId;
    }
    return result$data;
  }

  CopyWith$Input$UpdateProductInput<Input$UpdateProductInput> get copyWith =>
      CopyWith$Input$UpdateProductInput(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$UpdateProductInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$upc = upc;
    final lOther$upc = other.upc;
    if (l$upc != lOther$upc) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (_$data.containsKey('title') != other._$data.containsKey('title')) {
      return false;
    }
    if (l$title != lOther$title) {
      return false;
    }
    final l$imgUrl = imgUrl;
    final lOther$imgUrl = other.imgUrl;
    if (_$data.containsKey('imgUrl') != other._$data.containsKey('imgUrl')) {
      return false;
    }
    if (l$imgUrl != lOther$imgUrl) {
      return false;
    }
    final l$type = type;
    final lOther$type = other.type;
    if (_$data.containsKey('type') != other._$data.containsKey('type')) {
      return false;
    }
    if (l$type != lOther$type) {
      return false;
    }
    final l$distributedAt = distributedAt;
    final lOther$distributedAt = other.distributedAt;
    if (_$data.containsKey('distributedAt') !=
        other._$data.containsKey('distributedAt')) {
      return false;
    }
    if (l$distributedAt != lOther$distributedAt) {
      return false;
    }
    final l$artistId = artistId;
    final lOther$artistId = other.artistId;
    if (_$data.containsKey('artistId') !=
        other._$data.containsKey('artistId')) {
      return false;
    }
    if (l$artistId != lOther$artistId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$upc = upc;
    final l$title = title;
    final l$imgUrl = imgUrl;
    final l$type = type;
    final l$distributedAt = distributedAt;
    final l$artistId = artistId;
    return Object.hashAll([
      l$upc,
      _$data.containsKey('title') ? l$title : const {},
      _$data.containsKey('imgUrl') ? l$imgUrl : const {},
      _$data.containsKey('type') ? l$type : const {},
      _$data.containsKey('distributedAt') ? l$distributedAt : const {},
      _$data.containsKey('artistId') ? l$artistId : const {},
    ]);
  }
}

abstract class CopyWith$Input$UpdateProductInput<TRes> {
  factory CopyWith$Input$UpdateProductInput(
    Input$UpdateProductInput instance,
    TRes Function(Input$UpdateProductInput) then,
  ) = _CopyWithImpl$Input$UpdateProductInput;

  factory CopyWith$Input$UpdateProductInput.stub(TRes res) =
      _CopyWithStubImpl$Input$UpdateProductInput;

  TRes call({
    String? upc,
    String? title,
    String? imgUrl,
    String? type,
    String? distributedAt,
    String? artistId,
  });
}

class _CopyWithImpl$Input$UpdateProductInput<TRes>
    implements CopyWith$Input$UpdateProductInput<TRes> {
  _CopyWithImpl$Input$UpdateProductInput(
    this._instance,
    this._then,
  );

  final Input$UpdateProductInput _instance;

  final TRes Function(Input$UpdateProductInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? upc = _undefined,
    Object? title = _undefined,
    Object? imgUrl = _undefined,
    Object? type = _undefined,
    Object? distributedAt = _undefined,
    Object? artistId = _undefined,
  }) =>
      _then(Input$UpdateProductInput._({
        ..._instance._$data,
        if (upc != _undefined && upc != null) 'upc': (upc as String),
        if (title != _undefined) 'title': (title as String?),
        if (imgUrl != _undefined) 'imgUrl': (imgUrl as String?),
        if (type != _undefined) 'type': (type as String?),
        if (distributedAt != _undefined)
          'distributedAt': (distributedAt as String?),
        if (artistId != _undefined) 'artistId': (artistId as String?),
      }));
}

class _CopyWithStubImpl$Input$UpdateProductInput<TRes>
    implements CopyWith$Input$UpdateProductInput<TRes> {
  _CopyWithStubImpl$Input$UpdateProductInput(this._res);

  TRes _res;

  call({
    String? upc,
    String? title,
    String? imgUrl,
    String? type,
    String? distributedAt,
    String? artistId,
  }) =>
      _res;
}

class Input$UpdateTrackInput {
  factory Input$UpdateTrackInput({
    required String isrc,
    String? title,
  }) =>
      Input$UpdateTrackInput._({
        r'isrc': isrc,
        if (title != null) r'title': title,
      });

  Input$UpdateTrackInput._(this._$data);

  factory Input$UpdateTrackInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$isrc = data['isrc'];
    result$data['isrc'] = (l$isrc as String);
    if (data.containsKey('title')) {
      final l$title = data['title'];
      result$data['title'] = (l$title as String?);
    }
    return Input$UpdateTrackInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get isrc => (_$data['isrc'] as String);

  String? get title => (_$data['title'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$isrc = isrc;
    result$data['isrc'] = l$isrc;
    if (_$data.containsKey('title')) {
      final l$title = title;
      result$data['title'] = l$title;
    }
    return result$data;
  }

  CopyWith$Input$UpdateTrackInput<Input$UpdateTrackInput> get copyWith =>
      CopyWith$Input$UpdateTrackInput(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$UpdateTrackInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$isrc = isrc;
    final lOther$isrc = other.isrc;
    if (l$isrc != lOther$isrc) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (_$data.containsKey('title') != other._$data.containsKey('title')) {
      return false;
    }
    if (l$title != lOther$title) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$isrc = isrc;
    final l$title = title;
    return Object.hashAll([
      l$isrc,
      _$data.containsKey('title') ? l$title : const {},
    ]);
  }
}

abstract class CopyWith$Input$UpdateTrackInput<TRes> {
  factory CopyWith$Input$UpdateTrackInput(
    Input$UpdateTrackInput instance,
    TRes Function(Input$UpdateTrackInput) then,
  ) = _CopyWithImpl$Input$UpdateTrackInput;

  factory CopyWith$Input$UpdateTrackInput.stub(TRes res) =
      _CopyWithStubImpl$Input$UpdateTrackInput;

  TRes call({
    String? isrc,
    String? title,
  });
}

class _CopyWithImpl$Input$UpdateTrackInput<TRes>
    implements CopyWith$Input$UpdateTrackInput<TRes> {
  _CopyWithImpl$Input$UpdateTrackInput(
    this._instance,
    this._then,
  );

  final Input$UpdateTrackInput _instance;

  final TRes Function(Input$UpdateTrackInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? isrc = _undefined,
    Object? title = _undefined,
  }) =>
      _then(Input$UpdateTrackInput._({
        ..._instance._$data,
        if (isrc != _undefined && isrc != null) 'isrc': (isrc as String),
        if (title != _undefined) 'title': (title as String?),
      }));
}

class _CopyWithStubImpl$Input$UpdateTrackInput<TRes>
    implements CopyWith$Input$UpdateTrackInput<TRes> {
  _CopyWithStubImpl$Input$UpdateTrackInput(this._res);

  TRes _res;

  call({
    String? isrc,
    String? title,
  }) =>
      _res;
}

class Input$UpdateUserDataInput {
  factory Input$UpdateUserDataInput({
    required String id,
    String? email,
    String? name,
    String? imageUrl,
    String? primaryCategory,
    String? evmAddr,
    String? greeting,
    String? skill,
    String? xHandle,
    String? instagramHandle,
    String? fbHandle,
    String? fcmToken,
    String? interestOffer,
  }) =>
      Input$UpdateUserDataInput._({
        r'id': id,
        if (email != null) r'email': email,
        if (name != null) r'name': name,
        if (imageUrl != null) r'imageUrl': imageUrl,
        if (primaryCategory != null) r'primaryCategory': primaryCategory,
        if (evmAddr != null) r'evmAddr': evmAddr,
        if (greeting != null) r'greeting': greeting,
        if (skill != null) r'skill': skill,
        if (xHandle != null) r'xHandle': xHandle,
        if (instagramHandle != null) r'instagramHandle': instagramHandle,
        if (fbHandle != null) r'fbHandle': fbHandle,
        if (fcmToken != null) r'fcmToken': fcmToken,
        if (interestOffer != null) r'interestOffer': interestOffer,
      });

  Input$UpdateUserDataInput._(this._$data);

  factory Input$UpdateUserDataInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    if (data.containsKey('email')) {
      final l$email = data['email'];
      result$data['email'] = (l$email as String?);
    }
    if (data.containsKey('name')) {
      final l$name = data['name'];
      result$data['name'] = (l$name as String?);
    }
    if (data.containsKey('imageUrl')) {
      final l$imageUrl = data['imageUrl'];
      result$data['imageUrl'] = (l$imageUrl as String?);
    }
    if (data.containsKey('primaryCategory')) {
      final l$primaryCategory = data['primaryCategory'];
      result$data['primaryCategory'] = (l$primaryCategory as String?);
    }
    if (data.containsKey('evmAddr')) {
      final l$evmAddr = data['evmAddr'];
      result$data['evmAddr'] = (l$evmAddr as String?);
    }
    if (data.containsKey('greeting')) {
      final l$greeting = data['greeting'];
      result$data['greeting'] = (l$greeting as String?);
    }
    if (data.containsKey('skill')) {
      final l$skill = data['skill'];
      result$data['skill'] = (l$skill as String?);
    }
    if (data.containsKey('xHandle')) {
      final l$xHandle = data['xHandle'];
      result$data['xHandle'] = (l$xHandle as String?);
    }
    if (data.containsKey('instagramHandle')) {
      final l$instagramHandle = data['instagramHandle'];
      result$data['instagramHandle'] = (l$instagramHandle as String?);
    }
    if (data.containsKey('fbHandle')) {
      final l$fbHandle = data['fbHandle'];
      result$data['fbHandle'] = (l$fbHandle as String?);
    }
    if (data.containsKey('fcmToken')) {
      final l$fcmToken = data['fcmToken'];
      result$data['fcmToken'] = (l$fcmToken as String?);
    }
    if (data.containsKey('interestOffer')) {
      final l$interestOffer = data['interestOffer'];
      result$data['interestOffer'] = (l$interestOffer as String?);
    }
    return Input$UpdateUserDataInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  String? get email => (_$data['email'] as String?);

  String? get name => (_$data['name'] as String?);

  String? get imageUrl => (_$data['imageUrl'] as String?);

  String? get primaryCategory => (_$data['primaryCategory'] as String?);

  String? get evmAddr => (_$data['evmAddr'] as String?);

  String? get greeting => (_$data['greeting'] as String?);

  String? get skill => (_$data['skill'] as String?);

  String? get xHandle => (_$data['xHandle'] as String?);

  String? get instagramHandle => (_$data['instagramHandle'] as String?);

  String? get fbHandle => (_$data['fbHandle'] as String?);

  String? get fcmToken => (_$data['fcmToken'] as String?);

  String? get interestOffer => (_$data['interestOffer'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    if (_$data.containsKey('email')) {
      final l$email = email;
      result$data['email'] = l$email;
    }
    if (_$data.containsKey('name')) {
      final l$name = name;
      result$data['name'] = l$name;
    }
    if (_$data.containsKey('imageUrl')) {
      final l$imageUrl = imageUrl;
      result$data['imageUrl'] = l$imageUrl;
    }
    if (_$data.containsKey('primaryCategory')) {
      final l$primaryCategory = primaryCategory;
      result$data['primaryCategory'] = l$primaryCategory;
    }
    if (_$data.containsKey('evmAddr')) {
      final l$evmAddr = evmAddr;
      result$data['evmAddr'] = l$evmAddr;
    }
    if (_$data.containsKey('greeting')) {
      final l$greeting = greeting;
      result$data['greeting'] = l$greeting;
    }
    if (_$data.containsKey('skill')) {
      final l$skill = skill;
      result$data['skill'] = l$skill;
    }
    if (_$data.containsKey('xHandle')) {
      final l$xHandle = xHandle;
      result$data['xHandle'] = l$xHandle;
    }
    if (_$data.containsKey('instagramHandle')) {
      final l$instagramHandle = instagramHandle;
      result$data['instagramHandle'] = l$instagramHandle;
    }
    if (_$data.containsKey('fbHandle')) {
      final l$fbHandle = fbHandle;
      result$data['fbHandle'] = l$fbHandle;
    }
    if (_$data.containsKey('fcmToken')) {
      final l$fcmToken = fcmToken;
      result$data['fcmToken'] = l$fcmToken;
    }
    if (_$data.containsKey('interestOffer')) {
      final l$interestOffer = interestOffer;
      result$data['interestOffer'] = l$interestOffer;
    }
    return result$data;
  }

  CopyWith$Input$UpdateUserDataInput<Input$UpdateUserDataInput> get copyWith =>
      CopyWith$Input$UpdateUserDataInput(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$UpdateUserDataInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (_$data.containsKey('email') != other._$data.containsKey('email')) {
      return false;
    }
    if (l$email != lOther$email) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (_$data.containsKey('name') != other._$data.containsKey('name')) {
      return false;
    }
    if (l$name != lOther$name) {
      return false;
    }
    final l$imageUrl = imageUrl;
    final lOther$imageUrl = other.imageUrl;
    if (_$data.containsKey('imageUrl') !=
        other._$data.containsKey('imageUrl')) {
      return false;
    }
    if (l$imageUrl != lOther$imageUrl) {
      return false;
    }
    final l$primaryCategory = primaryCategory;
    final lOther$primaryCategory = other.primaryCategory;
    if (_$data.containsKey('primaryCategory') !=
        other._$data.containsKey('primaryCategory')) {
      return false;
    }
    if (l$primaryCategory != lOther$primaryCategory) {
      return false;
    }
    final l$evmAddr = evmAddr;
    final lOther$evmAddr = other.evmAddr;
    if (_$data.containsKey('evmAddr') != other._$data.containsKey('evmAddr')) {
      return false;
    }
    if (l$evmAddr != lOther$evmAddr) {
      return false;
    }
    final l$greeting = greeting;
    final lOther$greeting = other.greeting;
    if (_$data.containsKey('greeting') !=
        other._$data.containsKey('greeting')) {
      return false;
    }
    if (l$greeting != lOther$greeting) {
      return false;
    }
    final l$skill = skill;
    final lOther$skill = other.skill;
    if (_$data.containsKey('skill') != other._$data.containsKey('skill')) {
      return false;
    }
    if (l$skill != lOther$skill) {
      return false;
    }
    final l$xHandle = xHandle;
    final lOther$xHandle = other.xHandle;
    if (_$data.containsKey('xHandle') != other._$data.containsKey('xHandle')) {
      return false;
    }
    if (l$xHandle != lOther$xHandle) {
      return false;
    }
    final l$instagramHandle = instagramHandle;
    final lOther$instagramHandle = other.instagramHandle;
    if (_$data.containsKey('instagramHandle') !=
        other._$data.containsKey('instagramHandle')) {
      return false;
    }
    if (l$instagramHandle != lOther$instagramHandle) {
      return false;
    }
    final l$fbHandle = fbHandle;
    final lOther$fbHandle = other.fbHandle;
    if (_$data.containsKey('fbHandle') !=
        other._$data.containsKey('fbHandle')) {
      return false;
    }
    if (l$fbHandle != lOther$fbHandle) {
      return false;
    }
    final l$fcmToken = fcmToken;
    final lOther$fcmToken = other.fcmToken;
    if (_$data.containsKey('fcmToken') !=
        other._$data.containsKey('fcmToken')) {
      return false;
    }
    if (l$fcmToken != lOther$fcmToken) {
      return false;
    }
    final l$interestOffer = interestOffer;
    final lOther$interestOffer = other.interestOffer;
    if (_$data.containsKey('interestOffer') !=
        other._$data.containsKey('interestOffer')) {
      return false;
    }
    if (l$interestOffer != lOther$interestOffer) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$email = email;
    final l$name = name;
    final l$imageUrl = imageUrl;
    final l$primaryCategory = primaryCategory;
    final l$evmAddr = evmAddr;
    final l$greeting = greeting;
    final l$skill = skill;
    final l$xHandle = xHandle;
    final l$instagramHandle = instagramHandle;
    final l$fbHandle = fbHandle;
    final l$fcmToken = fcmToken;
    final l$interestOffer = interestOffer;
    return Object.hashAll([
      l$id,
      _$data.containsKey('email') ? l$email : const {},
      _$data.containsKey('name') ? l$name : const {},
      _$data.containsKey('imageUrl') ? l$imageUrl : const {},
      _$data.containsKey('primaryCategory') ? l$primaryCategory : const {},
      _$data.containsKey('evmAddr') ? l$evmAddr : const {},
      _$data.containsKey('greeting') ? l$greeting : const {},
      _$data.containsKey('skill') ? l$skill : const {},
      _$data.containsKey('xHandle') ? l$xHandle : const {},
      _$data.containsKey('instagramHandle') ? l$instagramHandle : const {},
      _$data.containsKey('fbHandle') ? l$fbHandle : const {},
      _$data.containsKey('fcmToken') ? l$fcmToken : const {},
      _$data.containsKey('interestOffer') ? l$interestOffer : const {},
    ]);
  }
}

abstract class CopyWith$Input$UpdateUserDataInput<TRes> {
  factory CopyWith$Input$UpdateUserDataInput(
    Input$UpdateUserDataInput instance,
    TRes Function(Input$UpdateUserDataInput) then,
  ) = _CopyWithImpl$Input$UpdateUserDataInput;

  factory CopyWith$Input$UpdateUserDataInput.stub(TRes res) =
      _CopyWithStubImpl$Input$UpdateUserDataInput;

  TRes call({
    String? id,
    String? email,
    String? name,
    String? imageUrl,
    String? primaryCategory,
    String? evmAddr,
    String? greeting,
    String? skill,
    String? xHandle,
    String? instagramHandle,
    String? fbHandle,
    String? fcmToken,
    String? interestOffer,
  });
}

class _CopyWithImpl$Input$UpdateUserDataInput<TRes>
    implements CopyWith$Input$UpdateUserDataInput<TRes> {
  _CopyWithImpl$Input$UpdateUserDataInput(
    this._instance,
    this._then,
  );

  final Input$UpdateUserDataInput _instance;

  final TRes Function(Input$UpdateUserDataInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? email = _undefined,
    Object? name = _undefined,
    Object? imageUrl = _undefined,
    Object? primaryCategory = _undefined,
    Object? evmAddr = _undefined,
    Object? greeting = _undefined,
    Object? skill = _undefined,
    Object? xHandle = _undefined,
    Object? instagramHandle = _undefined,
    Object? fbHandle = _undefined,
    Object? fcmToken = _undefined,
    Object? interestOffer = _undefined,
  }) =>
      _then(Input$UpdateUserDataInput._({
        ..._instance._$data,
        if (id != _undefined && id != null) 'id': (id as String),
        if (email != _undefined) 'email': (email as String?),
        if (name != _undefined) 'name': (name as String?),
        if (imageUrl != _undefined) 'imageUrl': (imageUrl as String?),
        if (primaryCategory != _undefined)
          'primaryCategory': (primaryCategory as String?),
        if (evmAddr != _undefined) 'evmAddr': (evmAddr as String?),
        if (greeting != _undefined) 'greeting': (greeting as String?),
        if (skill != _undefined) 'skill': (skill as String?),
        if (xHandle != _undefined) 'xHandle': (xHandle as String?),
        if (instagramHandle != _undefined)
          'instagramHandle': (instagramHandle as String?),
        if (fbHandle != _undefined) 'fbHandle': (fbHandle as String?),
        if (fcmToken != _undefined) 'fcmToken': (fcmToken as String?),
        if (interestOffer != _undefined)
          'interestOffer': (interestOffer as String?),
      }));
}

class _CopyWithStubImpl$Input$UpdateUserDataInput<TRes>
    implements CopyWith$Input$UpdateUserDataInput<TRes> {
  _CopyWithStubImpl$Input$UpdateUserDataInput(this._res);

  TRes _res;

  call({
    String? id,
    String? email,
    String? name,
    String? imageUrl,
    String? primaryCategory,
    String? evmAddr,
    String? greeting,
    String? skill,
    String? xHandle,
    String? instagramHandle,
    String? fbHandle,
    String? fcmToken,
    String? interestOffer,
  }) =>
      _res;
}

class Input$UsePrizeInput {
  factory Input$UsePrizeInput({
    required String representationUserId,
    required String userId,
    required int prizeId,
    String? code,
  }) =>
      Input$UsePrizeInput._({
        r'representationUserId': representationUserId,
        r'userId': userId,
        r'prizeId': prizeId,
        if (code != null) r'code': code,
      });

  Input$UsePrizeInput._(this._$data);

  factory Input$UsePrizeInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$representationUserId = data['representationUserId'];
    result$data['representationUserId'] = (l$representationUserId as String);
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    final l$prizeId = data['prizeId'];
    result$data['prizeId'] = (l$prizeId as int);
    if (data.containsKey('code')) {
      final l$code = data['code'];
      result$data['code'] = (l$code as String?);
    }
    return Input$UsePrizeInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get representationUserId => (_$data['representationUserId'] as String);

  String get userId => (_$data['userId'] as String);

  int get prizeId => (_$data['prizeId'] as int);

  String? get code => (_$data['code'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$representationUserId = representationUserId;
    result$data['representationUserId'] = l$representationUserId;
    final l$userId = userId;
    result$data['userId'] = l$userId;
    final l$prizeId = prizeId;
    result$data['prizeId'] = l$prizeId;
    if (_$data.containsKey('code')) {
      final l$code = code;
      result$data['code'] = l$code;
    }
    return result$data;
  }

  CopyWith$Input$UsePrizeInput<Input$UsePrizeInput> get copyWith =>
      CopyWith$Input$UsePrizeInput(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$UsePrizeInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$representationUserId = representationUserId;
    final lOther$representationUserId = other.representationUserId;
    if (l$representationUserId != lOther$representationUserId) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$prizeId = prizeId;
    final lOther$prizeId = other.prizeId;
    if (l$prizeId != lOther$prizeId) {
      return false;
    }
    final l$code = code;
    final lOther$code = other.code;
    if (_$data.containsKey('code') != other._$data.containsKey('code')) {
      return false;
    }
    if (l$code != lOther$code) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$representationUserId = representationUserId;
    final l$userId = userId;
    final l$prizeId = prizeId;
    final l$code = code;
    return Object.hashAll([
      l$representationUserId,
      l$userId,
      l$prizeId,
      _$data.containsKey('code') ? l$code : const {},
    ]);
  }
}

abstract class CopyWith$Input$UsePrizeInput<TRes> {
  factory CopyWith$Input$UsePrizeInput(
    Input$UsePrizeInput instance,
    TRes Function(Input$UsePrizeInput) then,
  ) = _CopyWithImpl$Input$UsePrizeInput;

  factory CopyWith$Input$UsePrizeInput.stub(TRes res) =
      _CopyWithStubImpl$Input$UsePrizeInput;

  TRes call({
    String? representationUserId,
    String? userId,
    int? prizeId,
    String? code,
  });
}

class _CopyWithImpl$Input$UsePrizeInput<TRes>
    implements CopyWith$Input$UsePrizeInput<TRes> {
  _CopyWithImpl$Input$UsePrizeInput(
    this._instance,
    this._then,
  );

  final Input$UsePrizeInput _instance;

  final TRes Function(Input$UsePrizeInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? representationUserId = _undefined,
    Object? userId = _undefined,
    Object? prizeId = _undefined,
    Object? code = _undefined,
  }) =>
      _then(Input$UsePrizeInput._({
        ..._instance._$data,
        if (representationUserId != _undefined && representationUserId != null)
          'representationUserId': (representationUserId as String),
        if (userId != _undefined && userId != null)
          'userId': (userId as String),
        if (prizeId != _undefined && prizeId != null)
          'prizeId': (prizeId as int),
        if (code != _undefined) 'code': (code as String?),
      }));
}

class _CopyWithStubImpl$Input$UsePrizeInput<TRes>
    implements CopyWith$Input$UsePrizeInput<TRes> {
  _CopyWithStubImpl$Input$UsePrizeInput(this._res);

  TRes _res;

  call({
    String? representationUserId,
    String? userId,
    int? prizeId,
    String? code,
  }) =>
      _res;
}

enum Enum$TransactionDirection {
  IN,
  OUT,
  $unknown;

  factory Enum$TransactionDirection.fromJson(String value) =>
      fromJson$Enum$TransactionDirection(value);

  String toJson() => toJson$Enum$TransactionDirection(this);
}

String toJson$Enum$TransactionDirection(Enum$TransactionDirection e) {
  switch (e) {
    case Enum$TransactionDirection.IN:
      return r'IN';
    case Enum$TransactionDirection.OUT:
      return r'OUT';
    case Enum$TransactionDirection.$unknown:
      return r'$unknown';
  }
}

Enum$TransactionDirection fromJson$Enum$TransactionDirection(String value) {
  switch (value) {
    case r'IN':
      return Enum$TransactionDirection.IN;
    case r'OUT':
      return Enum$TransactionDirection.OUT;
    default:
      return Enum$TransactionDirection.$unknown;
  }
}

enum Enum$__TypeKind {
  SCALAR,
  OBJECT,
  INTERFACE,
  UNION,
  ENUM,
  INPUT_OBJECT,
  LIST,
  NON_NULL,
  $unknown;

  factory Enum$__TypeKind.fromJson(String value) =>
      fromJson$Enum$__TypeKind(value);

  String toJson() => toJson$Enum$__TypeKind(this);
}

String toJson$Enum$__TypeKind(Enum$__TypeKind e) {
  switch (e) {
    case Enum$__TypeKind.SCALAR:
      return r'SCALAR';
    case Enum$__TypeKind.OBJECT:
      return r'OBJECT';
    case Enum$__TypeKind.INTERFACE:
      return r'INTERFACE';
    case Enum$__TypeKind.UNION:
      return r'UNION';
    case Enum$__TypeKind.ENUM:
      return r'ENUM';
    case Enum$__TypeKind.INPUT_OBJECT:
      return r'INPUT_OBJECT';
    case Enum$__TypeKind.LIST:
      return r'LIST';
    case Enum$__TypeKind.NON_NULL:
      return r'NON_NULL';
    case Enum$__TypeKind.$unknown:
      return r'$unknown';
  }
}

Enum$__TypeKind fromJson$Enum$__TypeKind(String value) {
  switch (value) {
    case r'SCALAR':
      return Enum$__TypeKind.SCALAR;
    case r'OBJECT':
      return Enum$__TypeKind.OBJECT;
    case r'INTERFACE':
      return Enum$__TypeKind.INTERFACE;
    case r'UNION':
      return Enum$__TypeKind.UNION;
    case r'ENUM':
      return Enum$__TypeKind.ENUM;
    case r'INPUT_OBJECT':
      return Enum$__TypeKind.INPUT_OBJECT;
    case r'LIST':
      return Enum$__TypeKind.LIST;
    case r'NON_NULL':
      return Enum$__TypeKind.NON_NULL;
    default:
      return Enum$__TypeKind.$unknown;
  }
}

enum Enum$__DirectiveLocation {
  QUERY,
  MUTATION,
  SUBSCRIPTION,
  FIELD,
  FRAGMENT_DEFINITION,
  FRAGMENT_SPREAD,
  INLINE_FRAGMENT,
  VARIABLE_DEFINITION,
  SCHEMA,
  SCALAR,
  OBJECT,
  FIELD_DEFINITION,
  ARGUMENT_DEFINITION,
  INTERFACE,
  UNION,
  ENUM,
  ENUM_VALUE,
  INPUT_OBJECT,
  INPUT_FIELD_DEFINITION,
  $unknown;

  factory Enum$__DirectiveLocation.fromJson(String value) =>
      fromJson$Enum$__DirectiveLocation(value);

  String toJson() => toJson$Enum$__DirectiveLocation(this);
}

String toJson$Enum$__DirectiveLocation(Enum$__DirectiveLocation e) {
  switch (e) {
    case Enum$__DirectiveLocation.QUERY:
      return r'QUERY';
    case Enum$__DirectiveLocation.MUTATION:
      return r'MUTATION';
    case Enum$__DirectiveLocation.SUBSCRIPTION:
      return r'SUBSCRIPTION';
    case Enum$__DirectiveLocation.FIELD:
      return r'FIELD';
    case Enum$__DirectiveLocation.FRAGMENT_DEFINITION:
      return r'FRAGMENT_DEFINITION';
    case Enum$__DirectiveLocation.FRAGMENT_SPREAD:
      return r'FRAGMENT_SPREAD';
    case Enum$__DirectiveLocation.INLINE_FRAGMENT:
      return r'INLINE_FRAGMENT';
    case Enum$__DirectiveLocation.VARIABLE_DEFINITION:
      return r'VARIABLE_DEFINITION';
    case Enum$__DirectiveLocation.SCHEMA:
      return r'SCHEMA';
    case Enum$__DirectiveLocation.SCALAR:
      return r'SCALAR';
    case Enum$__DirectiveLocation.OBJECT:
      return r'OBJECT';
    case Enum$__DirectiveLocation.FIELD_DEFINITION:
      return r'FIELD_DEFINITION';
    case Enum$__DirectiveLocation.ARGUMENT_DEFINITION:
      return r'ARGUMENT_DEFINITION';
    case Enum$__DirectiveLocation.INTERFACE:
      return r'INTERFACE';
    case Enum$__DirectiveLocation.UNION:
      return r'UNION';
    case Enum$__DirectiveLocation.ENUM:
      return r'ENUM';
    case Enum$__DirectiveLocation.ENUM_VALUE:
      return r'ENUM_VALUE';
    case Enum$__DirectiveLocation.INPUT_OBJECT:
      return r'INPUT_OBJECT';
    case Enum$__DirectiveLocation.INPUT_FIELD_DEFINITION:
      return r'INPUT_FIELD_DEFINITION';
    case Enum$__DirectiveLocation.$unknown:
      return r'$unknown';
  }
}

Enum$__DirectiveLocation fromJson$Enum$__DirectiveLocation(String value) {
  switch (value) {
    case r'QUERY':
      return Enum$__DirectiveLocation.QUERY;
    case r'MUTATION':
      return Enum$__DirectiveLocation.MUTATION;
    case r'SUBSCRIPTION':
      return Enum$__DirectiveLocation.SUBSCRIPTION;
    case r'FIELD':
      return Enum$__DirectiveLocation.FIELD;
    case r'FRAGMENT_DEFINITION':
      return Enum$__DirectiveLocation.FRAGMENT_DEFINITION;
    case r'FRAGMENT_SPREAD':
      return Enum$__DirectiveLocation.FRAGMENT_SPREAD;
    case r'INLINE_FRAGMENT':
      return Enum$__DirectiveLocation.INLINE_FRAGMENT;
    case r'VARIABLE_DEFINITION':
      return Enum$__DirectiveLocation.VARIABLE_DEFINITION;
    case r'SCHEMA':
      return Enum$__DirectiveLocation.SCHEMA;
    case r'SCALAR':
      return Enum$__DirectiveLocation.SCALAR;
    case r'OBJECT':
      return Enum$__DirectiveLocation.OBJECT;
    case r'FIELD_DEFINITION':
      return Enum$__DirectiveLocation.FIELD_DEFINITION;
    case r'ARGUMENT_DEFINITION':
      return Enum$__DirectiveLocation.ARGUMENT_DEFINITION;
    case r'INTERFACE':
      return Enum$__DirectiveLocation.INTERFACE;
    case r'UNION':
      return Enum$__DirectiveLocation.UNION;
    case r'ENUM':
      return Enum$__DirectiveLocation.ENUM;
    case r'ENUM_VALUE':
      return Enum$__DirectiveLocation.ENUM_VALUE;
    case r'INPUT_OBJECT':
      return Enum$__DirectiveLocation.INPUT_OBJECT;
    case r'INPUT_FIELD_DEFINITION':
      return Enum$__DirectiveLocation.INPUT_FIELD_DEFINITION;
    default:
      return Enum$__DirectiveLocation.$unknown;
  }
}

const possibleTypesMap = <String, Set<String>>{};
