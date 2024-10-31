class Input$AddNewConnectionByUserInput {
  factory Input$AddNewConnectionByUserInput({required String userId}) =>
      Input$AddNewConnectionByUserInput._({
        r'userId': userId,
      });

  Input$AddNewConnectionByUserInput._(this._$data);

  factory Input$AddNewConnectionByUserInput.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    return Input$AddNewConnectionByUserInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$userId = userId;
    result$data['userId'] = l$userId;
    return result$data;
  }

  CopyWith$Input$AddNewConnectionByUserInput<Input$AddNewConnectionByUserInput>
      get copyWith => CopyWith$Input$AddNewConnectionByUserInput(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Input$AddNewConnectionByUserInput) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    return Object.hashAll([l$userId]);
  }
}

abstract class CopyWith$Input$AddNewConnectionByUserInput<TRes> {
  factory CopyWith$Input$AddNewConnectionByUserInput(
    Input$AddNewConnectionByUserInput instance,
    TRes Function(Input$AddNewConnectionByUserInput) then,
  ) = _CopyWithImpl$Input$AddNewConnectionByUserInput;

  factory CopyWith$Input$AddNewConnectionByUserInput.stub(TRes res) =
      _CopyWithStubImpl$Input$AddNewConnectionByUserInput;

  TRes call({String? userId});
}

class _CopyWithImpl$Input$AddNewConnectionByUserInput<TRes>
    implements CopyWith$Input$AddNewConnectionByUserInput<TRes> {
  _CopyWithImpl$Input$AddNewConnectionByUserInput(
    this._instance,
    this._then,
  );

  final Input$AddNewConnectionByUserInput _instance;

  final TRes Function(Input$AddNewConnectionByUserInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? userId = _undefined}) =>
      _then(Input$AddNewConnectionByUserInput._({
        ..._instance._$data,
        if (userId != _undefined && userId != null)
          'userId': (userId as String),
      }));
}

class _CopyWithStubImpl$Input$AddNewConnectionByUserInput<TRes>
    implements CopyWith$Input$AddNewConnectionByUserInput<TRes> {
  _CopyWithStubImpl$Input$AddNewConnectionByUserInput(this._res);

  TRes _res;

  call({String? userId}) => _res;
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
    if (!(other is Input$ContactToAdminInput) ||
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
    required String name,
    String? imgUrl,
    required int fsp,
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
        r'name': name,
        if (imgUrl != null) r'imgUrl': imgUrl,
        r'fsp': fsp,
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
    final l$name = data['name'];
    result$data['name'] = (l$name as String);
    if (data.containsKey('imgUrl')) {
      final l$imgUrl = data['imgUrl'];
      result$data['imgUrl'] = (l$imgUrl as String?);
    }
    final l$fsp = data['fsp'];
    result$data['fsp'] = (l$fsp as int);
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

  String get name => (_$data['name'] as String);

  String? get imgUrl => (_$data['imgUrl'] as String?);

  int get fsp => (_$data['fsp'] as int);

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
    final l$name = name;
    result$data['name'] = l$name;
    if (_$data.containsKey('imgUrl')) {
      final l$imgUrl = imgUrl;
      result$data['imgUrl'] = l$imgUrl;
    }
    final l$fsp = fsp;
    result$data['fsp'] = l$fsp;
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
    if (!(other is Input$CreateNewArtistInput) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
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
    final l$name = name;
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
      l$name,
      _$data.containsKey('imgUrl') ? l$imgUrl : const {},
      l$fsp,
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
    String? name,
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
    Object? name = _undefined,
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
        if (name != _undefined && name != null) 'name': (name as String),
        if (imgUrl != _undefined) 'imgUrl': (imgUrl as String?),
        if (fsp != _undefined && fsp != null) 'fsp': (fsp as int),
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
    String? name,
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
    if (!(other is Input$CreateNewMessageRoomInput) ||
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

class Input$CreateNewNotificationInput {
  factory Input$CreateNewNotificationInput({
    required String title,
    required String content,
    String? target,
    String? userId,
  }) =>
      Input$CreateNewNotificationInput._({
        r'title': title,
        r'content': content,
        if (target != null) r'target': target,
        if (userId != null) r'userId': userId,
      });

  Input$CreateNewNotificationInput._(this._$data);

  factory Input$CreateNewNotificationInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$title = data['title'];
    result$data['title'] = (l$title as String);
    final l$content = data['content'];
    result$data['content'] = (l$content as String);
    if (data.containsKey('target')) {
      final l$target = data['target'];
      result$data['target'] = (l$target as String?);
    }
    if (data.containsKey('userId')) {
      final l$userId = data['userId'];
      result$data['userId'] = (l$userId as String?);
    }
    return Input$CreateNewNotificationInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get title => (_$data['title'] as String);

  String get content => (_$data['content'] as String);

  String? get target => (_$data['target'] as String?);

  String? get userId => (_$data['userId'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$title = title;
    result$data['title'] = l$title;
    final l$content = content;
    result$data['content'] = l$content;
    if (_$data.containsKey('target')) {
      final l$target = target;
      result$data['target'] = l$target;
    }
    if (_$data.containsKey('userId')) {
      final l$userId = userId;
      result$data['userId'] = l$userId;
    }
    return result$data;
  }

  CopyWith$Input$CreateNewNotificationInput<Input$CreateNewNotificationInput>
      get copyWith => CopyWith$Input$CreateNewNotificationInput(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Input$CreateNewNotificationInput) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$content = content;
    final lOther$content = other.content;
    if (l$content != lOther$content) {
      return false;
    }
    final l$target = target;
    final lOther$target = other.target;
    if (_$data.containsKey('target') != other._$data.containsKey('target')) {
      return false;
    }
    if (l$target != lOther$target) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (_$data.containsKey('userId') != other._$data.containsKey('userId')) {
      return false;
    }
    if (l$userId != lOther$userId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$title = title;
    final l$content = content;
    final l$target = target;
    final l$userId = userId;
    return Object.hashAll([
      l$title,
      l$content,
      _$data.containsKey('target') ? l$target : const {},
      _$data.containsKey('userId') ? l$userId : const {},
    ]);
  }
}

abstract class CopyWith$Input$CreateNewNotificationInput<TRes> {
  factory CopyWith$Input$CreateNewNotificationInput(
    Input$CreateNewNotificationInput instance,
    TRes Function(Input$CreateNewNotificationInput) then,
  ) = _CopyWithImpl$Input$CreateNewNotificationInput;

  factory CopyWith$Input$CreateNewNotificationInput.stub(TRes res) =
      _CopyWithStubImpl$Input$CreateNewNotificationInput;

  TRes call({
    String? title,
    String? content,
    String? target,
    String? userId,
  });
}

class _CopyWithImpl$Input$CreateNewNotificationInput<TRes>
    implements CopyWith$Input$CreateNewNotificationInput<TRes> {
  _CopyWithImpl$Input$CreateNewNotificationInput(
    this._instance,
    this._then,
  );

  final Input$CreateNewNotificationInput _instance;

  final TRes Function(Input$CreateNewNotificationInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? title = _undefined,
    Object? content = _undefined,
    Object? target = _undefined,
    Object? userId = _undefined,
  }) =>
      _then(Input$CreateNewNotificationInput._({
        ..._instance._$data,
        if (title != _undefined && title != null) 'title': (title as String),
        if (content != _undefined && content != null)
          'content': (content as String),
        if (target != _undefined) 'target': (target as String?),
        if (userId != _undefined) 'userId': (userId as String?),
      }));
}

class _CopyWithStubImpl$Input$CreateNewNotificationInput<TRes>
    implements CopyWith$Input$CreateNewNotificationInput<TRes> {
  _CopyWithStubImpl$Input$CreateNewNotificationInput(this._res);

  TRes _res;

  call({
    String? title,
    String? content,
    String? target,
    String? userId,
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
    if (!(other is Input$CreateNewOfferInput) ||
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
    if (!(other is Input$CreateNewPrizeInput) ||
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
    if (!(other is Input$CreateNewTransactionInput) ||
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
    required String email,
    required String name,
    String? imageUrl,
    String? invitedBy,
    required String category,
    required String primaryCategory,
  }) =>
      Input$CreateNewUserDataInput._({
        r'id': id,
        r'email': email,
        r'name': name,
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
    final l$email = data['email'];
    result$data['email'] = (l$email as String);
    final l$name = data['name'];
    result$data['name'] = (l$name as String);
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

  String get email => (_$data['email'] as String);

  String get name => (_$data['name'] as String);

  String? get imageUrl => (_$data['imageUrl'] as String?);

  String? get invitedBy => (_$data['invitedBy'] as String?);

  String get category => (_$data['category'] as String);

  String get primaryCategory => (_$data['primaryCategory'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    final l$email = email;
    result$data['email'] = l$email;
    final l$name = name;
    result$data['name'] = l$name;
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
    if (!(other is Input$CreateNewUserDataInput) ||
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
    if (l$email != lOther$email) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
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
    final l$email = email;
    final l$name = name;
    final l$imageUrl = imageUrl;
    final l$invitedBy = invitedBy;
    final l$category = category;
    final l$primaryCategory = primaryCategory;
    return Object.hashAll([
      l$id,
      l$email,
      l$name,
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
    String? email,
    String? name,
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
    Object? email = _undefined,
    Object? name = _undefined,
    Object? imageUrl = _undefined,
    Object? invitedBy = _undefined,
    Object? category = _undefined,
    Object? primaryCategory = _undefined,
  }) =>
      _then(Input$CreateNewUserDataInput._({
        ..._instance._$data,
        if (id != _undefined && id != null) 'id': (id as String),
        if (email != _undefined && email != null) 'email': (email as String),
        if (name != _undefined && name != null) 'name': (name as String),
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
    String? email,
    String? name,
    String? imageUrl,
    String? invitedBy,
    String? category,
    String? primaryCategory,
  }) =>
      _res;
}

class Input$DeleteNotificationInput {
  factory Input$DeleteNotificationInput({required String id}) =>
      Input$DeleteNotificationInput._({
        r'id': id,
      });

  Input$DeleteNotificationInput._(this._$data);

  factory Input$DeleteNotificationInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    return Input$DeleteNotificationInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    return result$data;
  }

  CopyWith$Input$DeleteNotificationInput<Input$DeleteNotificationInput>
      get copyWith => CopyWith$Input$DeleteNotificationInput(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Input$DeleteNotificationInput) ||
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

abstract class CopyWith$Input$DeleteNotificationInput<TRes> {
  factory CopyWith$Input$DeleteNotificationInput(
    Input$DeleteNotificationInput instance,
    TRes Function(Input$DeleteNotificationInput) then,
  ) = _CopyWithImpl$Input$DeleteNotificationInput;

  factory CopyWith$Input$DeleteNotificationInput.stub(TRes res) =
      _CopyWithStubImpl$Input$DeleteNotificationInput;

  TRes call({String? id});
}

class _CopyWithImpl$Input$DeleteNotificationInput<TRes>
    implements CopyWith$Input$DeleteNotificationInput<TRes> {
  _CopyWithImpl$Input$DeleteNotificationInput(
    this._instance,
    this._then,
  );

  final Input$DeleteNotificationInput _instance;

  final TRes Function(Input$DeleteNotificationInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? id = _undefined}) =>
      _then(Input$DeleteNotificationInput._({
        ..._instance._$data,
        if (id != _undefined && id != null) 'id': (id as String),
      }));
}

class _CopyWithStubImpl$Input$DeleteNotificationInput<TRes>
    implements CopyWith$Input$DeleteNotificationInput<TRes> {
  _CopyWithStubImpl$Input$DeleteNotificationInput(this._res);

  TRes _res;

  call({String? id}) => _res;
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
    if (!(other is Input$DeleteOfferInput) ||
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
    if (!(other is Input$ExchangePrizeInput) ||
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
    if (!(other is Input$SendMessageInput) ||
        runtimeType != other.runtimeType) {
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
    if (!(other is Input$UpdateBelongsToArtistStatusInput) ||
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

class Input$UpdateNotificationInput {
  factory Input$UpdateNotificationInput({
    required String id,
    String? title,
    String? content,
  }) =>
      Input$UpdateNotificationInput._({
        r'id': id,
        if (title != null) r'title': title,
        if (content != null) r'content': content,
      });

  Input$UpdateNotificationInput._(this._$data);

  factory Input$UpdateNotificationInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    if (data.containsKey('title')) {
      final l$title = data['title'];
      result$data['title'] = (l$title as String?);
    }
    if (data.containsKey('content')) {
      final l$content = data['content'];
      result$data['content'] = (l$content as String?);
    }
    return Input$UpdateNotificationInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  String? get title => (_$data['title'] as String?);

  String? get content => (_$data['content'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    if (_$data.containsKey('title')) {
      final l$title = title;
      result$data['title'] = l$title;
    }
    if (_$data.containsKey('content')) {
      final l$content = content;
      result$data['content'] = l$content;
    }
    return result$data;
  }

  CopyWith$Input$UpdateNotificationInput<Input$UpdateNotificationInput>
      get copyWith => CopyWith$Input$UpdateNotificationInput(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Input$UpdateNotificationInput) ||
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
    final l$content = content;
    final lOther$content = other.content;
    if (_$data.containsKey('content') != other._$data.containsKey('content')) {
      return false;
    }
    if (l$content != lOther$content) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$title = title;
    final l$content = content;
    return Object.hashAll([
      l$id,
      _$data.containsKey('title') ? l$title : const {},
      _$data.containsKey('content') ? l$content : const {},
    ]);
  }
}

abstract class CopyWith$Input$UpdateNotificationInput<TRes> {
  factory CopyWith$Input$UpdateNotificationInput(
    Input$UpdateNotificationInput instance,
    TRes Function(Input$UpdateNotificationInput) then,
  ) = _CopyWithImpl$Input$UpdateNotificationInput;

  factory CopyWith$Input$UpdateNotificationInput.stub(TRes res) =
      _CopyWithStubImpl$Input$UpdateNotificationInput;

  TRes call({
    String? id,
    String? title,
    String? content,
  });
}

class _CopyWithImpl$Input$UpdateNotificationInput<TRes>
    implements CopyWith$Input$UpdateNotificationInput<TRes> {
  _CopyWithImpl$Input$UpdateNotificationInput(
    this._instance,
    this._then,
  );

  final Input$UpdateNotificationInput _instance;

  final TRes Function(Input$UpdateNotificationInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? title = _undefined,
    Object? content = _undefined,
  }) =>
      _then(Input$UpdateNotificationInput._({
        ..._instance._$data,
        if (id != _undefined && id != null) 'id': (id as String),
        if (title != _undefined) 'title': (title as String?),
        if (content != _undefined) 'content': (content as String?),
      }));
}

class _CopyWithStubImpl$Input$UpdateNotificationInput<TRes>
    implements CopyWith$Input$UpdateNotificationInput<TRes> {
  _CopyWithStubImpl$Input$UpdateNotificationInput(this._res);

  TRes _res;

  call({
    String? id,
    String? title,
    String? content,
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
    List<String>? attachedMedia,
    bool? publicity,
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
        if (attachedMedia != null) r'attachedMedia': attachedMedia,
        if (publicity != null) r'publicity': publicity,
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
    if (data.containsKey('attachedMedia')) {
      final l$attachedMedia = data['attachedMedia'];
      result$data['attachedMedia'] = (l$attachedMedia as List<dynamic>?)
          ?.map((e) => (e as String))
          .toList();
    }
    if (data.containsKey('publicity')) {
      final l$publicity = data['publicity'];
      result$data['publicity'] = (l$publicity as bool?);
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

  List<String>? get attachedMedia => (_$data['attachedMedia'] as List<String>?);

  bool? get publicity => (_$data['publicity'] as bool?);

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
    if (_$data.containsKey('attachedMedia')) {
      final l$attachedMedia = attachedMedia;
      result$data['attachedMedia'] = l$attachedMedia?.map((e) => e).toList();
    }
    if (_$data.containsKey('publicity')) {
      final l$publicity = publicity;
      result$data['publicity'] = l$publicity;
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
    if (!(other is Input$UpdateOfferInput) ||
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
    final l$attachedMedia = attachedMedia;
    final lOther$attachedMedia = other.attachedMedia;
    if (_$data.containsKey('attachedMedia') !=
        other._$data.containsKey('attachedMedia')) {
      return false;
    }
    if (l$attachedMedia != null && lOther$attachedMedia != null) {
      if (l$attachedMedia.length != lOther$attachedMedia.length) {
        return false;
      }
      for (int i = 0; i < l$attachedMedia.length; i++) {
        final l$attachedMedia$entry = l$attachedMedia[i];
        final lOther$attachedMedia$entry = lOther$attachedMedia[i];
        if (l$attachedMedia$entry != lOther$attachedMedia$entry) {
          return false;
        }
      }
    } else if (l$attachedMedia != lOther$attachedMedia) {
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
    final l$attachedMedia = attachedMedia;
    final l$publicity = publicity;
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
      _$data.containsKey('attachedMedia')
          ? l$attachedMedia == null
              ? null
              : Object.hashAll(l$attachedMedia.map((v) => v))
          : const {},
      _$data.containsKey('publicity') ? l$publicity : const {},
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
    List<String>? attachedMedia,
    bool? publicity,
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
    Object? attachedMedia = _undefined,
    Object? publicity = _undefined,
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
        if (attachedMedia != _undefined)
          'attachedMedia': (attachedMedia as List<String>?),
        if (publicity != _undefined) 'publicity': (publicity as bool?),
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
    List<String>? attachedMedia,
    bool? publicity,
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
    if (!(other is Input$UpdateOfferStatusInput) ||
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

class Input$UpdateUserDataInput {
  factory Input$UpdateUserDataInput({
    required String id,
    String? email,
    String? name,
    String? imageUrl,
    String? primaryCategory,
    String? evmAddr,
  }) =>
      Input$UpdateUserDataInput._({
        r'id': id,
        if (email != null) r'email': email,
        if (name != null) r'name': name,
        if (imageUrl != null) r'imageUrl': imageUrl,
        if (primaryCategory != null) r'primaryCategory': primaryCategory,
        if (evmAddr != null) r'evmAddr': evmAddr,
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
    return Input$UpdateUserDataInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  String? get email => (_$data['email'] as String?);

  String? get name => (_$data['name'] as String?);

  String? get imageUrl => (_$data['imageUrl'] as String?);

  String? get primaryCategory => (_$data['primaryCategory'] as String?);

  String? get evmAddr => (_$data['evmAddr'] as String?);

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
    if (!(other is Input$UpdateUserDataInput) ||
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
    return Object.hashAll([
      l$id,
      _$data.containsKey('email') ? l$email : const {},
      _$data.containsKey('name') ? l$name : const {},
      _$data.containsKey('imageUrl') ? l$imageUrl : const {},
      _$data.containsKey('primaryCategory') ? l$primaryCategory : const {},
      _$data.containsKey('evmAddr') ? l$evmAddr : const {},
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
