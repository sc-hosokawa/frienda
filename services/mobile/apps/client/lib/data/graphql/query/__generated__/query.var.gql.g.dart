// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GHealthCheckVars> _$gHealthCheckVarsSerializer =
    new _$GHealthCheckVarsSerializer();
Serializer<GGetUserInfoVars> _$gGetUserInfoVarsSerializer =
    new _$GGetUserInfoVarsSerializer();
Serializer<GGetAllOffersVars> _$gGetAllOffersVarsSerializer =
    new _$GGetAllOffersVarsSerializer();
Serializer<GGetMessageRoomsVars> _$gGetMessageRoomsVarsSerializer =
    new _$GGetMessageRoomsVarsSerializer();
Serializer<GGetMessagesByMessageRoomIdVars>
    _$gGetMessagesByMessageRoomIdVarsSerializer =
    new _$GGetMessagesByMessageRoomIdVarsSerializer();
Serializer<GGetNotificationsVars> _$gGetNotificationsVarsSerializer =
    new _$GGetNotificationsVarsSerializer();
Serializer<GGetUserDataVars> _$gGetUserDataVarsSerializer =
    new _$GGetUserDataVarsSerializer();

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

class _$GGetUserInfoVarsSerializer
    implements StructuredSerializer<GGetUserInfoVars> {
  @override
  final Iterable<Type> types = const [GGetUserInfoVars, _$GGetUserInfoVars];
  @override
  final String wireName = 'GGetUserInfoVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GGetUserInfoVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GGetUserInfoVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GGetUserInfoVarsBuilder().build();
  }
}

class _$GGetAllOffersVarsSerializer
    implements StructuredSerializer<GGetAllOffersVars> {
  @override
  final Iterable<Type> types = const [GGetAllOffersVars, _$GGetAllOffersVars];
  @override
  final String wireName = 'GGetAllOffersVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GGetAllOffersVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GGetAllOffersVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GGetAllOffersVarsBuilder().build();
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
    return <Object?>[];
  }

  @override
  GGetMessageRoomsVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GGetMessageRoomsVarsBuilder().build();
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
    return <Object?>[];
  }

  @override
  GGetNotificationsVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GGetNotificationsVarsBuilder().build();
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
    return <Object?>[];
  }

  @override
  GGetUserDataVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GGetUserDataVarsBuilder().build();
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

class _$GGetUserInfoVars extends GGetUserInfoVars {
  factory _$GGetUserInfoVars(
          [void Function(GGetUserInfoVarsBuilder)? updates]) =>
      (new GGetUserInfoVarsBuilder()..update(updates))._build();

  _$GGetUserInfoVars._() : super._();

  @override
  GGetUserInfoVars rebuild(void Function(GGetUserInfoVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetUserInfoVarsBuilder toBuilder() =>
      new GGetUserInfoVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetUserInfoVars;
  }

  @override
  int get hashCode {
    return 909751917;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GGetUserInfoVars').toString();
  }
}

class GGetUserInfoVarsBuilder
    implements Builder<GGetUserInfoVars, GGetUserInfoVarsBuilder> {
  _$GGetUserInfoVars? _$v;

  GGetUserInfoVarsBuilder();

  @override
  void replace(GGetUserInfoVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetUserInfoVars;
  }

  @override
  void update(void Function(GGetUserInfoVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetUserInfoVars build() => _build();

  _$GGetUserInfoVars _build() {
    final _$result = _$v ?? new _$GGetUserInfoVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GGetAllOffersVars extends GGetAllOffersVars {
  factory _$GGetAllOffersVars(
          [void Function(GGetAllOffersVarsBuilder)? updates]) =>
      (new GGetAllOffersVarsBuilder()..update(updates))._build();

  _$GGetAllOffersVars._() : super._();

  @override
  GGetAllOffersVars rebuild(void Function(GGetAllOffersVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetAllOffersVarsBuilder toBuilder() =>
      new GGetAllOffersVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetAllOffersVars;
  }

  @override
  int get hashCode {
    return 1064331430;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GGetAllOffersVars').toString();
  }
}

class GGetAllOffersVarsBuilder
    implements Builder<GGetAllOffersVars, GGetAllOffersVarsBuilder> {
  _$GGetAllOffersVars? _$v;

  GGetAllOffersVarsBuilder();

  @override
  void replace(GGetAllOffersVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetAllOffersVars;
  }

  @override
  void update(void Function(GGetAllOffersVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetAllOffersVars build() => _build();

  _$GGetAllOffersVars _build() {
    final _$result = _$v ?? new _$GGetAllOffersVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GGetMessageRoomsVars extends GGetMessageRoomsVars {
  factory _$GGetMessageRoomsVars(
          [void Function(GGetMessageRoomsVarsBuilder)? updates]) =>
      (new GGetMessageRoomsVarsBuilder()..update(updates))._build();

  _$GGetMessageRoomsVars._() : super._();

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
    return other is GGetMessageRoomsVars;
  }

  @override
  int get hashCode {
    return 753535444;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GGetMessageRoomsVars').toString();
  }
}

class GGetMessageRoomsVarsBuilder
    implements Builder<GGetMessageRoomsVars, GGetMessageRoomsVarsBuilder> {
  _$GGetMessageRoomsVars? _$v;

  GGetMessageRoomsVarsBuilder();

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
    final _$result = _$v ?? new _$GGetMessageRoomsVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GGetMessagesByMessageRoomIdVars
    extends GGetMessagesByMessageRoomIdVars {
  @override
  final String messageRoomId;

  factory _$GGetMessagesByMessageRoomIdVars(
          [void Function(GGetMessagesByMessageRoomIdVarsBuilder)? updates]) =>
      (new GGetMessagesByMessageRoomIdVarsBuilder()..update(updates))._build();

  _$GGetMessagesByMessageRoomIdVars._({required this.messageRoomId})
      : super._() {
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
        messageRoomId == other.messageRoomId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, messageRoomId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetMessagesByMessageRoomIdVars')
          ..add('messageRoomId', messageRoomId))
        .toString();
  }
}

class GGetMessagesByMessageRoomIdVarsBuilder
    implements
        Builder<GGetMessagesByMessageRoomIdVars,
            GGetMessagesByMessageRoomIdVarsBuilder> {
  _$GGetMessagesByMessageRoomIdVars? _$v;

  String? _messageRoomId;
  String? get messageRoomId => _$this._messageRoomId;
  set messageRoomId(String? messageRoomId) =>
      _$this._messageRoomId = messageRoomId;

  GGetMessagesByMessageRoomIdVarsBuilder();

  GGetMessagesByMessageRoomIdVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
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
            messageRoomId: BuiltValueNullFieldError.checkNotNull(messageRoomId,
                r'GGetMessagesByMessageRoomIdVars', 'messageRoomId'));
    replace(_$result);
    return _$result;
  }
}

class _$GGetNotificationsVars extends GGetNotificationsVars {
  factory _$GGetNotificationsVars(
          [void Function(GGetNotificationsVarsBuilder)? updates]) =>
      (new GGetNotificationsVarsBuilder()..update(updates))._build();

  _$GGetNotificationsVars._() : super._();

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
    return other is GGetNotificationsVars;
  }

  @override
  int get hashCode {
    return 646619994;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GGetNotificationsVars').toString();
  }
}

class GGetNotificationsVarsBuilder
    implements Builder<GGetNotificationsVars, GGetNotificationsVarsBuilder> {
  _$GGetNotificationsVars? _$v;

  GGetNotificationsVarsBuilder();

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
    final _$result = _$v ?? new _$GGetNotificationsVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GGetUserDataVars extends GGetUserDataVars {
  factory _$GGetUserDataVars(
          [void Function(GGetUserDataVarsBuilder)? updates]) =>
      (new GGetUserDataVarsBuilder()..update(updates))._build();

  _$GGetUserDataVars._() : super._();

  @override
  GGetUserDataVars rebuild(void Function(GGetUserDataVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetUserDataVarsBuilder toBuilder() =>
      new GGetUserDataVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetUserDataVars;
  }

  @override
  int get hashCode {
    return 914364733;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GGetUserDataVars').toString();
  }
}

class GGetUserDataVarsBuilder
    implements Builder<GGetUserDataVars, GGetUserDataVarsBuilder> {
  _$GGetUserDataVars? _$v;

  GGetUserDataVarsBuilder();

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
    final _$result = _$v ?? new _$GGetUserDataVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
