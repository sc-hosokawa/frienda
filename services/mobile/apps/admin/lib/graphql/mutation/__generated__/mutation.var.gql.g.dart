// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mutation.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GAddNewConnectionVars> _$gAddNewConnectionVarsSerializer =
    new _$GAddNewConnectionVarsSerializer();
Serializer<GCreateNewMessageRoomVars> _$gCreateNewMessageRoomVarsSerializer =
    new _$GCreateNewMessageRoomVarsSerializer();
Serializer<GSendMessageVars> _$gSendMessageVarsSerializer =
    new _$GSendMessageVarsSerializer();
Serializer<GCreateNewOfferVars> _$gCreateNewOfferVarsSerializer =
    new _$GCreateNewOfferVarsSerializer();
Serializer<GUpdateOfferVars> _$gUpdateOfferVarsSerializer =
    new _$GUpdateOfferVarsSerializer();
Serializer<GDeleteOfferVars> _$gDeleteOfferVarsSerializer =
    new _$GDeleteOfferVarsSerializer();

class _$GAddNewConnectionVarsSerializer
    implements StructuredSerializer<GAddNewConnectionVars> {
  @override
  final Iterable<Type> types = const [
    GAddNewConnectionVars,
    _$GAddNewConnectionVars
  ];
  @override
  final String wireName = 'GAddNewConnectionVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAddNewConnectionVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'input',
      serializers.serialize(object.input,
          specifiedType: const FullType(_i1.GAddNewConnectionInput)),
    ];

    return result;
  }

  @override
  GAddNewConnectionVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAddNewConnectionVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'input':
          result.input.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i1.GAddNewConnectionInput))!
              as _i1.GAddNewConnectionInput);
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateNewMessageRoomVarsSerializer
    implements StructuredSerializer<GCreateNewMessageRoomVars> {
  @override
  final Iterable<Type> types = const [
    GCreateNewMessageRoomVars,
    _$GCreateNewMessageRoomVars
  ];
  @override
  final String wireName = 'GCreateNewMessageRoomVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateNewMessageRoomVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'input',
      serializers.serialize(object.input,
          specifiedType: const FullType(_i1.GCreateNewMessageRoomInput)),
    ];

    return result;
  }

  @override
  GCreateNewMessageRoomVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateNewMessageRoomVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'input':
          result.input.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(_i1.GCreateNewMessageRoomInput))!
              as _i1.GCreateNewMessageRoomInput);
          break;
      }
    }

    return result.build();
  }
}

class _$GSendMessageVarsSerializer
    implements StructuredSerializer<GSendMessageVars> {
  @override
  final Iterable<Type> types = const [GSendMessageVars, _$GSendMessageVars];
  @override
  final String wireName = 'GSendMessageVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GSendMessageVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'input',
      serializers.serialize(object.input,
          specifiedType: const FullType(_i1.GSendMessageInput)),
    ];

    return result;
  }

  @override
  GSendMessageVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSendMessageVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'input':
          result.input.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i1.GSendMessageInput))!
              as _i1.GSendMessageInput);
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateNewOfferVarsSerializer
    implements StructuredSerializer<GCreateNewOfferVars> {
  @override
  final Iterable<Type> types = const [
    GCreateNewOfferVars,
    _$GCreateNewOfferVars
  ];
  @override
  final String wireName = 'GCreateNewOfferVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateNewOfferVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'input',
      serializers.serialize(object.input,
          specifiedType: const FullType(_i1.GCreateNewOfferInput)),
    ];

    return result;
  }

  @override
  GCreateNewOfferVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateNewOfferVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'input':
          result.input.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i1.GCreateNewOfferInput))!
              as _i1.GCreateNewOfferInput);
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateOfferVarsSerializer
    implements StructuredSerializer<GUpdateOfferVars> {
  @override
  final Iterable<Type> types = const [GUpdateOfferVars, _$GUpdateOfferVars];
  @override
  final String wireName = 'GUpdateOfferVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GUpdateOfferVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'input',
      serializers.serialize(object.input,
          specifiedType: const FullType(_i1.GUpdateOfferInput)),
    ];

    return result;
  }

  @override
  GUpdateOfferVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateOfferVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'input':
          result.input.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i1.GUpdateOfferInput))!
              as _i1.GUpdateOfferInput);
          break;
      }
    }

    return result.build();
  }
}

class _$GDeleteOfferVarsSerializer
    implements StructuredSerializer<GDeleteOfferVars> {
  @override
  final Iterable<Type> types = const [GDeleteOfferVars, _$GDeleteOfferVars];
  @override
  final String wireName = 'GDeleteOfferVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GDeleteOfferVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'input',
      serializers.serialize(object.input,
          specifiedType: const FullType(_i1.GDeleteOfferInput)),
    ];

    return result;
  }

  @override
  GDeleteOfferVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GDeleteOfferVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'input':
          result.input.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i1.GDeleteOfferInput))!
              as _i1.GDeleteOfferInput);
          break;
      }
    }

    return result.build();
  }
}

class _$GAddNewConnectionVars extends GAddNewConnectionVars {
  @override
  final _i1.GAddNewConnectionInput input;

  factory _$GAddNewConnectionVars(
          [void Function(GAddNewConnectionVarsBuilder)? updates]) =>
      (new GAddNewConnectionVarsBuilder()..update(updates))._build();

  _$GAddNewConnectionVars._({required this.input}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        input, r'GAddNewConnectionVars', 'input');
  }

  @override
  GAddNewConnectionVars rebuild(
          void Function(GAddNewConnectionVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAddNewConnectionVarsBuilder toBuilder() =>
      new GAddNewConnectionVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAddNewConnectionVars && input == other.input;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, input.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAddNewConnectionVars')
          ..add('input', input))
        .toString();
  }
}

class GAddNewConnectionVarsBuilder
    implements Builder<GAddNewConnectionVars, GAddNewConnectionVarsBuilder> {
  _$GAddNewConnectionVars? _$v;

  _i1.GAddNewConnectionInputBuilder? _input;
  _i1.GAddNewConnectionInputBuilder get input =>
      _$this._input ??= new _i1.GAddNewConnectionInputBuilder();
  set input(_i1.GAddNewConnectionInputBuilder? input) => _$this._input = input;

  GAddNewConnectionVarsBuilder();

  GAddNewConnectionVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAddNewConnectionVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAddNewConnectionVars;
  }

  @override
  void update(void Function(GAddNewConnectionVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAddNewConnectionVars build() => _build();

  _$GAddNewConnectionVars _build() {
    _$GAddNewConnectionVars _$result;
    try {
      _$result = _$v ?? new _$GAddNewConnectionVars._(input: input.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GAddNewConnectionVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GCreateNewMessageRoomVars extends GCreateNewMessageRoomVars {
  @override
  final _i1.GCreateNewMessageRoomInput input;

  factory _$GCreateNewMessageRoomVars(
          [void Function(GCreateNewMessageRoomVarsBuilder)? updates]) =>
      (new GCreateNewMessageRoomVarsBuilder()..update(updates))._build();

  _$GCreateNewMessageRoomVars._({required this.input}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        input, r'GCreateNewMessageRoomVars', 'input');
  }

  @override
  GCreateNewMessageRoomVars rebuild(
          void Function(GCreateNewMessageRoomVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateNewMessageRoomVarsBuilder toBuilder() =>
      new GCreateNewMessageRoomVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateNewMessageRoomVars && input == other.input;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, input.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateNewMessageRoomVars')
          ..add('input', input))
        .toString();
  }
}

class GCreateNewMessageRoomVarsBuilder
    implements
        Builder<GCreateNewMessageRoomVars, GCreateNewMessageRoomVarsBuilder> {
  _$GCreateNewMessageRoomVars? _$v;

  _i1.GCreateNewMessageRoomInputBuilder? _input;
  _i1.GCreateNewMessageRoomInputBuilder get input =>
      _$this._input ??= new _i1.GCreateNewMessageRoomInputBuilder();
  set input(_i1.GCreateNewMessageRoomInputBuilder? input) =>
      _$this._input = input;

  GCreateNewMessageRoomVarsBuilder();

  GCreateNewMessageRoomVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateNewMessageRoomVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateNewMessageRoomVars;
  }

  @override
  void update(void Function(GCreateNewMessageRoomVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateNewMessageRoomVars build() => _build();

  _$GCreateNewMessageRoomVars _build() {
    _$GCreateNewMessageRoomVars _$result;
    try {
      _$result = _$v ?? new _$GCreateNewMessageRoomVars._(input: input.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GCreateNewMessageRoomVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GSendMessageVars extends GSendMessageVars {
  @override
  final _i1.GSendMessageInput input;

  factory _$GSendMessageVars(
          [void Function(GSendMessageVarsBuilder)? updates]) =>
      (new GSendMessageVarsBuilder()..update(updates))._build();

  _$GSendMessageVars._({required this.input}) : super._() {
    BuiltValueNullFieldError.checkNotNull(input, r'GSendMessageVars', 'input');
  }

  @override
  GSendMessageVars rebuild(void Function(GSendMessageVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSendMessageVarsBuilder toBuilder() =>
      new GSendMessageVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSendMessageVars && input == other.input;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, input.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSendMessageVars')
          ..add('input', input))
        .toString();
  }
}

class GSendMessageVarsBuilder
    implements Builder<GSendMessageVars, GSendMessageVarsBuilder> {
  _$GSendMessageVars? _$v;

  _i1.GSendMessageInputBuilder? _input;
  _i1.GSendMessageInputBuilder get input =>
      _$this._input ??= new _i1.GSendMessageInputBuilder();
  set input(_i1.GSendMessageInputBuilder? input) => _$this._input = input;

  GSendMessageVarsBuilder();

  GSendMessageVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSendMessageVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSendMessageVars;
  }

  @override
  void update(void Function(GSendMessageVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSendMessageVars build() => _build();

  _$GSendMessageVars _build() {
    _$GSendMessageVars _$result;
    try {
      _$result = _$v ?? new _$GSendMessageVars._(input: input.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GSendMessageVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GCreateNewOfferVars extends GCreateNewOfferVars {
  @override
  final _i1.GCreateNewOfferInput input;

  factory _$GCreateNewOfferVars(
          [void Function(GCreateNewOfferVarsBuilder)? updates]) =>
      (new GCreateNewOfferVarsBuilder()..update(updates))._build();

  _$GCreateNewOfferVars._({required this.input}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        input, r'GCreateNewOfferVars', 'input');
  }

  @override
  GCreateNewOfferVars rebuild(
          void Function(GCreateNewOfferVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateNewOfferVarsBuilder toBuilder() =>
      new GCreateNewOfferVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateNewOfferVars && input == other.input;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, input.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateNewOfferVars')
          ..add('input', input))
        .toString();
  }
}

class GCreateNewOfferVarsBuilder
    implements Builder<GCreateNewOfferVars, GCreateNewOfferVarsBuilder> {
  _$GCreateNewOfferVars? _$v;

  _i1.GCreateNewOfferInputBuilder? _input;
  _i1.GCreateNewOfferInputBuilder get input =>
      _$this._input ??= new _i1.GCreateNewOfferInputBuilder();
  set input(_i1.GCreateNewOfferInputBuilder? input) => _$this._input = input;

  GCreateNewOfferVarsBuilder();

  GCreateNewOfferVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateNewOfferVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateNewOfferVars;
  }

  @override
  void update(void Function(GCreateNewOfferVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateNewOfferVars build() => _build();

  _$GCreateNewOfferVars _build() {
    _$GCreateNewOfferVars _$result;
    try {
      _$result = _$v ?? new _$GCreateNewOfferVars._(input: input.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GCreateNewOfferVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateOfferVars extends GUpdateOfferVars {
  @override
  final _i1.GUpdateOfferInput input;

  factory _$GUpdateOfferVars(
          [void Function(GUpdateOfferVarsBuilder)? updates]) =>
      (new GUpdateOfferVarsBuilder()..update(updates))._build();

  _$GUpdateOfferVars._({required this.input}) : super._() {
    BuiltValueNullFieldError.checkNotNull(input, r'GUpdateOfferVars', 'input');
  }

  @override
  GUpdateOfferVars rebuild(void Function(GUpdateOfferVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateOfferVarsBuilder toBuilder() =>
      new GUpdateOfferVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateOfferVars && input == other.input;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, input.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateOfferVars')
          ..add('input', input))
        .toString();
  }
}

class GUpdateOfferVarsBuilder
    implements Builder<GUpdateOfferVars, GUpdateOfferVarsBuilder> {
  _$GUpdateOfferVars? _$v;

  _i1.GUpdateOfferInputBuilder? _input;
  _i1.GUpdateOfferInputBuilder get input =>
      _$this._input ??= new _i1.GUpdateOfferInputBuilder();
  set input(_i1.GUpdateOfferInputBuilder? input) => _$this._input = input;

  GUpdateOfferVarsBuilder();

  GUpdateOfferVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateOfferVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateOfferVars;
  }

  @override
  void update(void Function(GUpdateOfferVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateOfferVars build() => _build();

  _$GUpdateOfferVars _build() {
    _$GUpdateOfferVars _$result;
    try {
      _$result = _$v ?? new _$GUpdateOfferVars._(input: input.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GUpdateOfferVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GDeleteOfferVars extends GDeleteOfferVars {
  @override
  final _i1.GDeleteOfferInput input;

  factory _$GDeleteOfferVars(
          [void Function(GDeleteOfferVarsBuilder)? updates]) =>
      (new GDeleteOfferVarsBuilder()..update(updates))._build();

  _$GDeleteOfferVars._({required this.input}) : super._() {
    BuiltValueNullFieldError.checkNotNull(input, r'GDeleteOfferVars', 'input');
  }

  @override
  GDeleteOfferVars rebuild(void Function(GDeleteOfferVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GDeleteOfferVarsBuilder toBuilder() =>
      new GDeleteOfferVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GDeleteOfferVars && input == other.input;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, input.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GDeleteOfferVars')
          ..add('input', input))
        .toString();
  }
}

class GDeleteOfferVarsBuilder
    implements Builder<GDeleteOfferVars, GDeleteOfferVarsBuilder> {
  _$GDeleteOfferVars? _$v;

  _i1.GDeleteOfferInputBuilder? _input;
  _i1.GDeleteOfferInputBuilder get input =>
      _$this._input ??= new _i1.GDeleteOfferInputBuilder();
  set input(_i1.GDeleteOfferInputBuilder? input) => _$this._input = input;

  GDeleteOfferVarsBuilder();

  GDeleteOfferVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GDeleteOfferVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GDeleteOfferVars;
  }

  @override
  void update(void Function(GDeleteOfferVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GDeleteOfferVars build() => _build();

  _$GDeleteOfferVars _build() {
    _$GDeleteOfferVars _$result;
    try {
      _$result = _$v ?? new _$GDeleteOfferVars._(input: input.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GDeleteOfferVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
