// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GHealthCheckVars> _$gHealthCheckVarsSerializer =
    new _$GHealthCheckVarsSerializer();
Serializer<GGetUserDataVars> _$gGetUserDataVarsSerializer =
    new _$GGetUserDataVarsSerializer();
Serializer<GGetOffersVars> _$gGetOffersVarsSerializer =
    new _$GGetOffersVarsSerializer();
Serializer<GGetMessageRoomsVars> _$gGetMessageRoomsVarsSerializer =
    new _$GGetMessageRoomsVarsSerializer();
Serializer<GGetMessagesByMessageRoomIdVars>
    _$gGetMessagesByMessageRoomIdVarsSerializer =
    new _$GGetMessagesByMessageRoomIdVarsSerializer();
Serializer<GGetNotificationsVars> _$gGetNotificationsVarsSerializer =
    new _$GGetNotificationsVarsSerializer();

class _$GHealthCheckVarsSerializer
    implements StructuredSerializer<GHealthCheckVars> {
  @override
  final Iterable<Type> types = const [GHealthCheckVars, _$GHealthCheckVars];
  @override
  final String wireName = 'GHealthCheckVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GHealthCheckVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GHealthCheckVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GHealthCheckVarsBuilder().build();
  }
}

class _$GGetUserDataVarsSerializer
    implements StructuredSerializer<GGetUserDataVars> {
  @override
  final Iterable<Type> types = const [GGetUserDataVars, _$GGetUserDataVars];
  @override
  final String wireName = 'GGetUserDataVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GGetUserDataVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GGetUserDataVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GGetUserDataVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetOffersVarsSerializer
    implements StructuredSerializer<GGetOffersVars> {
  @override
  final Iterable<Type> types = const [GGetOffersVars, _$GGetOffersVars];
  @override
  final String wireName = 'GGetOffersVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GGetOffersVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GGetOffersVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GGetOffersVarsBuilder().build();
  }
}

class _$GGetMessageRoomsVarsSerializer
    implements StructuredSerializer<GGetMessageRoomsVars> {
  @override
  final Iterable<Type> types = const [
    GGetMessageRoomsVars,
    _$GGetMessageRoomsVars
  ];
  @override
  final String wireName = 'GGetMessageRoomsVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GGetMessageRoomsVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GGetMessageRoomsVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GGetMessageRoomsVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetMessagesByMessageRoomIdVarsSerializer
    implements StructuredSerializer<GGetMessagesByMessageRoomIdVars> {
  @override
  final Iterable<Type> types = const [
    GGetMessagesByMessageRoomIdVars,
    _$GGetMessagesByMessageRoomIdVars
  ];
  @override
  final String wireName = 'GGetMessagesByMessageRoomIdVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GGetMessagesByMessageRoomIdVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
      'messageRoomId',
      serializers.serialize(object.messageRoomId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GGetMessagesByMessageRoomIdVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GGetMessagesByMessageRoomIdVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'messageRoomId':
          result.messageRoomId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetNotificationsVarsSerializer
    implements StructuredSerializer<GGetNotificationsVars> {
  @override
  final Iterable<Type> types = const [
    GGetNotificationsVars,
    _$GGetNotificationsVars
  ];
  @override
  final String wireName = 'GGetNotificationsVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GGetNotificationsVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GGetNotificationsVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GGetNotificationsVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GHealthCheckVars extends GHealthCheckVars {
  factory _$GHealthCheckVars(
          [void Function(GHealthCheckVarsBuilder)? updates]) =>
      (new GHealthCheckVarsBuilder()..update(updates))._build();

  _$GHealthCheckVars._() : super._();

  @override
  GHealthCheckVars rebuild(void Function(GHealthCheckVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GHealthCheckVarsBuilder toBuilder() =>
      new GHealthCheckVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GHealthCheckVars;
  }

  @override
  int get hashCode {
    return 71222430;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GHealthCheckVars').toString();
  }
}

class GHealthCheckVarsBuilder
    implements Builder<GHealthCheckVars, GHealthCheckVarsBuilder> {
  _$GHealthCheckVars? _$v;

  GHealthCheckVarsBuilder();

  @override
  void replace(GHealthCheckVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GHealthCheckVars;
  }

  @override
  void update(void Function(GHealthCheckVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GHealthCheckVars build() => _build();

  _$GHealthCheckVars _build() {
    final _$result = _$v ?? new _$GHealthCheckVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GGetUserDataVars extends GGetUserDataVars {
  @override
  final String userId;

  factory _$GGetUserDataVars(
          [void Function(GGetUserDataVarsBuilder)? updates]) =>
      (new GGetUserDataVarsBuilder()..update(updates))._build();

  _$GGetUserDataVars._({required this.userId}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        userId, r'GGetUserDataVars', 'userId');
  }

  @override
  GGetUserDataVars rebuild(void Function(GGetUserDataVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetUserDataVarsBuilder toBuilder() =>
      new GGetUserDataVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetUserDataVars && userId == other.userId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetUserDataVars')
          ..add('userId', userId))
        .toString();
  }
}

class GGetUserDataVarsBuilder
    implements Builder<GGetUserDataVars, GGetUserDataVarsBuilder> {
  _$GGetUserDataVars? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  GGetUserDataVarsBuilder();

  GGetUserDataVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetUserDataVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetUserDataVars;
  }

  @override
  void update(void Function(GGetUserDataVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetUserDataVars build() => _build();

  _$GGetUserDataVars _build() {
    final _$result = _$v ??
        new _$GGetUserDataVars._(
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'GGetUserDataVars', 'userId'));
    replace(_$result);
    return _$result;
  }
}

class _$GGetOffersVars extends GGetOffersVars {
  factory _$GGetOffersVars([void Function(GGetOffersVarsBuilder)? updates]) =>
      (new GGetOffersVarsBuilder()..update(updates))._build();

  _$GGetOffersVars._() : super._();

  @override
  GGetOffersVars rebuild(void Function(GGetOffersVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetOffersVarsBuilder toBuilder() =>
      new GGetOffersVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetOffersVars;
  }

  @override
  int get hashCode {
    return 704756872;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GGetOffersVars').toString();
  }
}

class GGetOffersVarsBuilder
    implements Builder<GGetOffersVars, GGetOffersVarsBuilder> {
  _$GGetOffersVars? _$v;

  GGetOffersVarsBuilder();

  @override
  void replace(GGetOffersVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetOffersVars;
  }

  @override
  void update(void Function(GGetOffersVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetOffersVars build() => _build();

  _$GGetOffersVars _build() {
    final _$result = _$v ?? new _$GGetOffersVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GGetMessageRoomsVars extends GGetMessageRoomsVars {
  @override
  final String userId;

  factory _$GGetMessageRoomsVars(
          [void Function(GGetMessageRoomsVarsBuilder)? updates]) =>
      (new GGetMessageRoomsVarsBuilder()..update(updates))._build();

  _$GGetMessageRoomsVars._({required this.userId}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        userId, r'GGetMessageRoomsVars', 'userId');
  }

  @override
  GGetMessageRoomsVars rebuild(
          void Function(GGetMessageRoomsVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetMessageRoomsVarsBuilder toBuilder() =>
      new GGetMessageRoomsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetMessageRoomsVars && userId == other.userId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetMessageRoomsVars')
          ..add('userId', userId))
        .toString();
  }
}

class GGetMessageRoomsVarsBuilder
    implements Builder<GGetMessageRoomsVars, GGetMessageRoomsVarsBuilder> {
  _$GGetMessageRoomsVars? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  GGetMessageRoomsVarsBuilder();

  GGetMessageRoomsVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetMessageRoomsVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetMessageRoomsVars;
  }

  @override
  void update(void Function(GGetMessageRoomsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetMessageRoomsVars build() => _build();

  _$GGetMessageRoomsVars _build() {
    final _$result = _$v ??
        new _$GGetMessageRoomsVars._(
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'GGetMessageRoomsVars', 'userId'));
    replace(_$result);
    return _$result;
  }
}

class _$GGetMessagesByMessageRoomIdVars
    extends GGetMessagesByMessageRoomIdVars {
  @override
  final String userId;
  @override
  final String messageRoomId;

  factory _$GGetMessagesByMessageRoomIdVars(
          [void Function(GGetMessagesByMessageRoomIdVarsBuilder)? updates]) =>
      (new GGetMessagesByMessageRoomIdVarsBuilder()..update(updates))._build();

  _$GGetMessagesByMessageRoomIdVars._(
      {required this.userId, required this.messageRoomId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        userId, r'GGetMessagesByMessageRoomIdVars', 'userId');
    BuiltValueNullFieldError.checkNotNull(
        messageRoomId, r'GGetMessagesByMessageRoomIdVars', 'messageRoomId');
  }

  @override
  GGetMessagesByMessageRoomIdVars rebuild(
          void Function(GGetMessagesByMessageRoomIdVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetMessagesByMessageRoomIdVarsBuilder toBuilder() =>
      new GGetMessagesByMessageRoomIdVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetMessagesByMessageRoomIdVars &&
        userId == other.userId &&
        messageRoomId == other.messageRoomId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, messageRoomId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetMessagesByMessageRoomIdVars')
          ..add('userId', userId)
          ..add('messageRoomId', messageRoomId))
        .toString();
  }
}

class GGetMessagesByMessageRoomIdVarsBuilder
    implements
        Builder<GGetMessagesByMessageRoomIdVars,
            GGetMessagesByMessageRoomIdVarsBuilder> {
  _$GGetMessagesByMessageRoomIdVars? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _messageRoomId;
  String? get messageRoomId => _$this._messageRoomId;
  set messageRoomId(String? messageRoomId) =>
      _$this._messageRoomId = messageRoomId;

  GGetMessagesByMessageRoomIdVarsBuilder();

  GGetMessagesByMessageRoomIdVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _messageRoomId = $v.messageRoomId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetMessagesByMessageRoomIdVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetMessagesByMessageRoomIdVars;
  }

  @override
  void update(void Function(GGetMessagesByMessageRoomIdVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetMessagesByMessageRoomIdVars build() => _build();

  _$GGetMessagesByMessageRoomIdVars _build() {
    final _$result = _$v ??
        new _$GGetMessagesByMessageRoomIdVars._(
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'GGetMessagesByMessageRoomIdVars', 'userId'),
            messageRoomId: BuiltValueNullFieldError.checkNotNull(messageRoomId,
                r'GGetMessagesByMessageRoomIdVars', 'messageRoomId'));
    replace(_$result);
    return _$result;
  }
}

class _$GGetNotificationsVars extends GGetNotificationsVars {
  @override
  final String userId;

  factory _$GGetNotificationsVars(
          [void Function(GGetNotificationsVarsBuilder)? updates]) =>
      (new GGetNotificationsVarsBuilder()..update(updates))._build();

  _$GGetNotificationsVars._({required this.userId}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        userId, r'GGetNotificationsVars', 'userId');
  }

  @override
  GGetNotificationsVars rebuild(
          void Function(GGetNotificationsVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetNotificationsVarsBuilder toBuilder() =>
      new GGetNotificationsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetNotificationsVars && userId == other.userId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetNotificationsVars')
          ..add('userId', userId))
        .toString();
  }
}

class GGetNotificationsVarsBuilder
    implements Builder<GGetNotificationsVars, GGetNotificationsVarsBuilder> {
  _$GGetNotificationsVars? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  GGetNotificationsVarsBuilder();

  GGetNotificationsVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetNotificationsVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetNotificationsVars;
  }

  @override
  void update(void Function(GGetNotificationsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetNotificationsVars build() => _build();

  _$GGetNotificationsVars _build() {
    final _$result = _$v ??
        new _$GGetNotificationsVars._(
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'GGetNotificationsVars', 'userId'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
