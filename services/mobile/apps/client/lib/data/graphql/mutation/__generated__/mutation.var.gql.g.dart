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
Serializer<GCreateNewUserDataVars> _$gCreateNewUserDataVarsSerializer =
    new _$GCreateNewUserDataVarsSerializer();
Serializer<GUpdateUserDataVars> _$gUpdateUserDataVarsSerializer =
    new _$GUpdateUserDataVarsSerializer();
Serializer<GUpdateBelongsToArtistStatusVars>
    _$gUpdateBelongsToArtistStatusVarsSerializer =
    new _$GUpdateBelongsToArtistStatusVarsSerializer();
Serializer<GContactToAdminVars> _$gContactToAdminVarsSerializer =
    new _$GContactToAdminVarsSerializer();
Serializer<GCreateNewNotificationVars> _$gCreateNewNotificationVarsSerializer =
    new _$GCreateNewNotificationVarsSerializer();
Serializer<GUpdateNotificationVars> _$gUpdateNotificationVarsSerializer =
    new _$GUpdateNotificationVarsSerializer();
Serializer<GDeleteNotificationVars> _$gDeleteNotificationVarsSerializer =
    new _$GDeleteNotificationVarsSerializer();
Serializer<GCreateFspTxVars> _$gCreateFspTxVarsSerializer =
    new _$GCreateFspTxVarsSerializer();
Serializer<GCreateNewArtistVars> _$gCreateNewArtistVarsSerializer =
    new _$GCreateNewArtistVarsSerializer();

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
          specifiedType: const FullType(_i1.GAddNewConnectionByUserInput)),
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
                  specifiedType:
                      const FullType(_i1.GAddNewConnectionByUserInput))!
              as _i1.GAddNewConnectionByUserInput);
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

class _$GCreateNewUserDataVarsSerializer
    implements StructuredSerializer<GCreateNewUserDataVars> {
  @override
  final Iterable<Type> types = const [
    GCreateNewUserDataVars,
    _$GCreateNewUserDataVars
  ];
  @override
  final String wireName = 'GCreateNewUserDataVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateNewUserDataVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'input',
      serializers.serialize(object.input,
          specifiedType: const FullType(_i1.GCreateNewUserDataInput)),
    ];

    return result;
  }

  @override
  GCreateNewUserDataVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateNewUserDataVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'input':
          result.input.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i1.GCreateNewUserDataInput))!
              as _i1.GCreateNewUserDataInput);
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateUserDataVarsSerializer
    implements StructuredSerializer<GUpdateUserDataVars> {
  @override
  final Iterable<Type> types = const [
    GUpdateUserDataVars,
    _$GUpdateUserDataVars
  ];
  @override
  final String wireName = 'GUpdateUserDataVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateUserDataVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'input',
      serializers.serialize(object.input,
          specifiedType: const FullType(_i1.GUpdateUserDataInput)),
    ];

    return result;
  }

  @override
  GUpdateUserDataVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateUserDataVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'input':
          result.input.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i1.GUpdateUserDataInput))!
              as _i1.GUpdateUserDataInput);
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateBelongsToArtistStatusVarsSerializer
    implements StructuredSerializer<GUpdateBelongsToArtistStatusVars> {
  @override
  final Iterable<Type> types = const [
    GUpdateBelongsToArtistStatusVars,
    _$GUpdateBelongsToArtistStatusVars
  ];
  @override
  final String wireName = 'GUpdateBelongsToArtistStatusVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateBelongsToArtistStatusVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'input',
      serializers.serialize(object.input,
          specifiedType: const FullType(_i1.GUpdateBelongsToArtistStatusInput)),
    ];

    return result;
  }

  @override
  GUpdateBelongsToArtistStatusVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateBelongsToArtistStatusVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'input':
          result.input.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(_i1.GUpdateBelongsToArtistStatusInput))!
              as _i1.GUpdateBelongsToArtistStatusInput);
          break;
      }
    }

    return result.build();
  }
}

class _$GContactToAdminVarsSerializer
    implements StructuredSerializer<GContactToAdminVars> {
  @override
  final Iterable<Type> types = const [
    GContactToAdminVars,
    _$GContactToAdminVars
  ];
  @override
  final String wireName = 'GContactToAdminVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GContactToAdminVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'input',
      serializers.serialize(object.input,
          specifiedType: const FullType(_i1.GContactToAdminInput)),
    ];

    return result;
  }

  @override
  GContactToAdminVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GContactToAdminVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'input':
          result.input.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i1.GContactToAdminInput))!
              as _i1.GContactToAdminInput);
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateNewNotificationVarsSerializer
    implements StructuredSerializer<GCreateNewNotificationVars> {
  @override
  final Iterable<Type> types = const [
    GCreateNewNotificationVars,
    _$GCreateNewNotificationVars
  ];
  @override
  final String wireName = 'GCreateNewNotificationVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateNewNotificationVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'input',
      serializers.serialize(object.input,
          specifiedType: const FullType(_i1.GCreateNewNotificationInput)),
    ];

    return result;
  }

  @override
  GCreateNewNotificationVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateNewNotificationVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'input':
          result.input.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(_i1.GCreateNewNotificationInput))!
              as _i1.GCreateNewNotificationInput);
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateNotificationVarsSerializer
    implements StructuredSerializer<GUpdateNotificationVars> {
  @override
  final Iterable<Type> types = const [
    GUpdateNotificationVars,
    _$GUpdateNotificationVars
  ];
  @override
  final String wireName = 'GUpdateNotificationVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateNotificationVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'input',
      serializers.serialize(object.input,
          specifiedType: const FullType(_i1.GUpdateNotificationInput)),
    ];

    return result;
  }

  @override
  GUpdateNotificationVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateNotificationVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'input':
          result.input.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i1.GUpdateNotificationInput))!
              as _i1.GUpdateNotificationInput);
          break;
      }
    }

    return result.build();
  }
}

class _$GDeleteNotificationVarsSerializer
    implements StructuredSerializer<GDeleteNotificationVars> {
  @override
  final Iterable<Type> types = const [
    GDeleteNotificationVars,
    _$GDeleteNotificationVars
  ];
  @override
  final String wireName = 'GDeleteNotificationVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GDeleteNotificationVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'input',
      serializers.serialize(object.input,
          specifiedType: const FullType(_i1.GDeleteNotificationInput)),
    ];

    return result;
  }

  @override
  GDeleteNotificationVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GDeleteNotificationVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'input':
          result.input.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i1.GDeleteNotificationInput))!
              as _i1.GDeleteNotificationInput);
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateFspTxVarsSerializer
    implements StructuredSerializer<GCreateFspTxVars> {
  @override
  final Iterable<Type> types = const [GCreateFspTxVars, _$GCreateFspTxVars];
  @override
  final String wireName = 'GCreateFspTxVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GCreateFspTxVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'input',
      serializers.serialize(object.input,
          specifiedType: const FullType(_i1.GCreateNewTransactionInput)),
    ];

    return result;
  }

  @override
  GCreateFspTxVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateFspTxVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'input':
          result.input.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(_i1.GCreateNewTransactionInput))!
              as _i1.GCreateNewTransactionInput);
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateNewArtistVarsSerializer
    implements StructuredSerializer<GCreateNewArtistVars> {
  @override
  final Iterable<Type> types = const [
    GCreateNewArtistVars,
    _$GCreateNewArtistVars
  ];
  @override
  final String wireName = 'GCreateNewArtistVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateNewArtistVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'input',
      serializers.serialize(object.input,
          specifiedType: const FullType(_i1.GCreateNewArtistInput)),
    ];

    return result;
  }

  @override
  GCreateNewArtistVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateNewArtistVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'input':
          result.input.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i1.GCreateNewArtistInput))!
              as _i1.GCreateNewArtistInput);
          break;
      }
    }

    return result.build();
  }
}

class _$GAddNewConnectionVars extends GAddNewConnectionVars {
  @override
  final _i1.GAddNewConnectionByUserInput input;

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

  _i1.GAddNewConnectionByUserInputBuilder? _input;
  _i1.GAddNewConnectionByUserInputBuilder get input =>
      _$this._input ??= new _i1.GAddNewConnectionByUserInputBuilder();
  set input(_i1.GAddNewConnectionByUserInputBuilder? input) =>
      _$this._input = input;

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

class _$GCreateNewUserDataVars extends GCreateNewUserDataVars {
  @override
  final _i1.GCreateNewUserDataInput input;

  factory _$GCreateNewUserDataVars(
          [void Function(GCreateNewUserDataVarsBuilder)? updates]) =>
      (new GCreateNewUserDataVarsBuilder()..update(updates))._build();

  _$GCreateNewUserDataVars._({required this.input}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        input, r'GCreateNewUserDataVars', 'input');
  }

  @override
  GCreateNewUserDataVars rebuild(
          void Function(GCreateNewUserDataVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateNewUserDataVarsBuilder toBuilder() =>
      new GCreateNewUserDataVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateNewUserDataVars && input == other.input;
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
    return (newBuiltValueToStringHelper(r'GCreateNewUserDataVars')
          ..add('input', input))
        .toString();
  }
}

class GCreateNewUserDataVarsBuilder
    implements Builder<GCreateNewUserDataVars, GCreateNewUserDataVarsBuilder> {
  _$GCreateNewUserDataVars? _$v;

  _i1.GCreateNewUserDataInputBuilder? _input;
  _i1.GCreateNewUserDataInputBuilder get input =>
      _$this._input ??= new _i1.GCreateNewUserDataInputBuilder();
  set input(_i1.GCreateNewUserDataInputBuilder? input) => _$this._input = input;

  GCreateNewUserDataVarsBuilder();

  GCreateNewUserDataVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateNewUserDataVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateNewUserDataVars;
  }

  @override
  void update(void Function(GCreateNewUserDataVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateNewUserDataVars build() => _build();

  _$GCreateNewUserDataVars _build() {
    _$GCreateNewUserDataVars _$result;
    try {
      _$result = _$v ?? new _$GCreateNewUserDataVars._(input: input.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GCreateNewUserDataVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateUserDataVars extends GUpdateUserDataVars {
  @override
  final _i1.GUpdateUserDataInput input;

  factory _$GUpdateUserDataVars(
          [void Function(GUpdateUserDataVarsBuilder)? updates]) =>
      (new GUpdateUserDataVarsBuilder()..update(updates))._build();

  _$GUpdateUserDataVars._({required this.input}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        input, r'GUpdateUserDataVars', 'input');
  }

  @override
  GUpdateUserDataVars rebuild(
          void Function(GUpdateUserDataVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateUserDataVarsBuilder toBuilder() =>
      new GUpdateUserDataVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateUserDataVars && input == other.input;
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
    return (newBuiltValueToStringHelper(r'GUpdateUserDataVars')
          ..add('input', input))
        .toString();
  }
}

class GUpdateUserDataVarsBuilder
    implements Builder<GUpdateUserDataVars, GUpdateUserDataVarsBuilder> {
  _$GUpdateUserDataVars? _$v;

  _i1.GUpdateUserDataInputBuilder? _input;
  _i1.GUpdateUserDataInputBuilder get input =>
      _$this._input ??= new _i1.GUpdateUserDataInputBuilder();
  set input(_i1.GUpdateUserDataInputBuilder? input) => _$this._input = input;

  GUpdateUserDataVarsBuilder();

  GUpdateUserDataVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateUserDataVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateUserDataVars;
  }

  @override
  void update(void Function(GUpdateUserDataVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateUserDataVars build() => _build();

  _$GUpdateUserDataVars _build() {
    _$GUpdateUserDataVars _$result;
    try {
      _$result = _$v ?? new _$GUpdateUserDataVars._(input: input.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GUpdateUserDataVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateBelongsToArtistStatusVars
    extends GUpdateBelongsToArtistStatusVars {
  @override
  final _i1.GUpdateBelongsToArtistStatusInput input;

  factory _$GUpdateBelongsToArtistStatusVars(
          [void Function(GUpdateBelongsToArtistStatusVarsBuilder)? updates]) =>
      (new GUpdateBelongsToArtistStatusVarsBuilder()..update(updates))._build();

  _$GUpdateBelongsToArtistStatusVars._({required this.input}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        input, r'GUpdateBelongsToArtistStatusVars', 'input');
  }

  @override
  GUpdateBelongsToArtistStatusVars rebuild(
          void Function(GUpdateBelongsToArtistStatusVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateBelongsToArtistStatusVarsBuilder toBuilder() =>
      new GUpdateBelongsToArtistStatusVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateBelongsToArtistStatusVars && input == other.input;
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
    return (newBuiltValueToStringHelper(r'GUpdateBelongsToArtistStatusVars')
          ..add('input', input))
        .toString();
  }
}

class GUpdateBelongsToArtistStatusVarsBuilder
    implements
        Builder<GUpdateBelongsToArtistStatusVars,
            GUpdateBelongsToArtistStatusVarsBuilder> {
  _$GUpdateBelongsToArtistStatusVars? _$v;

  _i1.GUpdateBelongsToArtistStatusInputBuilder? _input;
  _i1.GUpdateBelongsToArtistStatusInputBuilder get input =>
      _$this._input ??= new _i1.GUpdateBelongsToArtistStatusInputBuilder();
  set input(_i1.GUpdateBelongsToArtistStatusInputBuilder? input) =>
      _$this._input = input;

  GUpdateBelongsToArtistStatusVarsBuilder();

  GUpdateBelongsToArtistStatusVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateBelongsToArtistStatusVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateBelongsToArtistStatusVars;
  }

  @override
  void update(void Function(GUpdateBelongsToArtistStatusVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateBelongsToArtistStatusVars build() => _build();

  _$GUpdateBelongsToArtistStatusVars _build() {
    _$GUpdateBelongsToArtistStatusVars _$result;
    try {
      _$result =
          _$v ?? new _$GUpdateBelongsToArtistStatusVars._(input: input.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GUpdateBelongsToArtistStatusVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GContactToAdminVars extends GContactToAdminVars {
  @override
  final _i1.GContactToAdminInput input;

  factory _$GContactToAdminVars(
          [void Function(GContactToAdminVarsBuilder)? updates]) =>
      (new GContactToAdminVarsBuilder()..update(updates))._build();

  _$GContactToAdminVars._({required this.input}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        input, r'GContactToAdminVars', 'input');
  }

  @override
  GContactToAdminVars rebuild(
          void Function(GContactToAdminVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GContactToAdminVarsBuilder toBuilder() =>
      new GContactToAdminVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GContactToAdminVars && input == other.input;
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
    return (newBuiltValueToStringHelper(r'GContactToAdminVars')
          ..add('input', input))
        .toString();
  }
}

class GContactToAdminVarsBuilder
    implements Builder<GContactToAdminVars, GContactToAdminVarsBuilder> {
  _$GContactToAdminVars? _$v;

  _i1.GContactToAdminInputBuilder? _input;
  _i1.GContactToAdminInputBuilder get input =>
      _$this._input ??= new _i1.GContactToAdminInputBuilder();
  set input(_i1.GContactToAdminInputBuilder? input) => _$this._input = input;

  GContactToAdminVarsBuilder();

  GContactToAdminVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GContactToAdminVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GContactToAdminVars;
  }

  @override
  void update(void Function(GContactToAdminVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GContactToAdminVars build() => _build();

  _$GContactToAdminVars _build() {
    _$GContactToAdminVars _$result;
    try {
      _$result = _$v ?? new _$GContactToAdminVars._(input: input.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GContactToAdminVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GCreateNewNotificationVars extends GCreateNewNotificationVars {
  @override
  final _i1.GCreateNewNotificationInput input;

  factory _$GCreateNewNotificationVars(
          [void Function(GCreateNewNotificationVarsBuilder)? updates]) =>
      (new GCreateNewNotificationVarsBuilder()..update(updates))._build();

  _$GCreateNewNotificationVars._({required this.input}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        input, r'GCreateNewNotificationVars', 'input');
  }

  @override
  GCreateNewNotificationVars rebuild(
          void Function(GCreateNewNotificationVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateNewNotificationVarsBuilder toBuilder() =>
      new GCreateNewNotificationVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateNewNotificationVars && input == other.input;
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
    return (newBuiltValueToStringHelper(r'GCreateNewNotificationVars')
          ..add('input', input))
        .toString();
  }
}

class GCreateNewNotificationVarsBuilder
    implements
        Builder<GCreateNewNotificationVars, GCreateNewNotificationVarsBuilder> {
  _$GCreateNewNotificationVars? _$v;

  _i1.GCreateNewNotificationInputBuilder? _input;
  _i1.GCreateNewNotificationInputBuilder get input =>
      _$this._input ??= new _i1.GCreateNewNotificationInputBuilder();
  set input(_i1.GCreateNewNotificationInputBuilder? input) =>
      _$this._input = input;

  GCreateNewNotificationVarsBuilder();

  GCreateNewNotificationVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateNewNotificationVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateNewNotificationVars;
  }

  @override
  void update(void Function(GCreateNewNotificationVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateNewNotificationVars build() => _build();

  _$GCreateNewNotificationVars _build() {
    _$GCreateNewNotificationVars _$result;
    try {
      _$result =
          _$v ?? new _$GCreateNewNotificationVars._(input: input.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GCreateNewNotificationVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateNotificationVars extends GUpdateNotificationVars {
  @override
  final _i1.GUpdateNotificationInput input;

  factory _$GUpdateNotificationVars(
          [void Function(GUpdateNotificationVarsBuilder)? updates]) =>
      (new GUpdateNotificationVarsBuilder()..update(updates))._build();

  _$GUpdateNotificationVars._({required this.input}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        input, r'GUpdateNotificationVars', 'input');
  }

  @override
  GUpdateNotificationVars rebuild(
          void Function(GUpdateNotificationVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateNotificationVarsBuilder toBuilder() =>
      new GUpdateNotificationVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateNotificationVars && input == other.input;
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
    return (newBuiltValueToStringHelper(r'GUpdateNotificationVars')
          ..add('input', input))
        .toString();
  }
}

class GUpdateNotificationVarsBuilder
    implements
        Builder<GUpdateNotificationVars, GUpdateNotificationVarsBuilder> {
  _$GUpdateNotificationVars? _$v;

  _i1.GUpdateNotificationInputBuilder? _input;
  _i1.GUpdateNotificationInputBuilder get input =>
      _$this._input ??= new _i1.GUpdateNotificationInputBuilder();
  set input(_i1.GUpdateNotificationInputBuilder? input) =>
      _$this._input = input;

  GUpdateNotificationVarsBuilder();

  GUpdateNotificationVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateNotificationVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateNotificationVars;
  }

  @override
  void update(void Function(GUpdateNotificationVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateNotificationVars build() => _build();

  _$GUpdateNotificationVars _build() {
    _$GUpdateNotificationVars _$result;
    try {
      _$result = _$v ?? new _$GUpdateNotificationVars._(input: input.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GUpdateNotificationVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GDeleteNotificationVars extends GDeleteNotificationVars {
  @override
  final _i1.GDeleteNotificationInput input;

  factory _$GDeleteNotificationVars(
          [void Function(GDeleteNotificationVarsBuilder)? updates]) =>
      (new GDeleteNotificationVarsBuilder()..update(updates))._build();

  _$GDeleteNotificationVars._({required this.input}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        input, r'GDeleteNotificationVars', 'input');
  }

  @override
  GDeleteNotificationVars rebuild(
          void Function(GDeleteNotificationVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GDeleteNotificationVarsBuilder toBuilder() =>
      new GDeleteNotificationVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GDeleteNotificationVars && input == other.input;
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
    return (newBuiltValueToStringHelper(r'GDeleteNotificationVars')
          ..add('input', input))
        .toString();
  }
}

class GDeleteNotificationVarsBuilder
    implements
        Builder<GDeleteNotificationVars, GDeleteNotificationVarsBuilder> {
  _$GDeleteNotificationVars? _$v;

  _i1.GDeleteNotificationInputBuilder? _input;
  _i1.GDeleteNotificationInputBuilder get input =>
      _$this._input ??= new _i1.GDeleteNotificationInputBuilder();
  set input(_i1.GDeleteNotificationInputBuilder? input) =>
      _$this._input = input;

  GDeleteNotificationVarsBuilder();

  GDeleteNotificationVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GDeleteNotificationVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GDeleteNotificationVars;
  }

  @override
  void update(void Function(GDeleteNotificationVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GDeleteNotificationVars build() => _build();

  _$GDeleteNotificationVars _build() {
    _$GDeleteNotificationVars _$result;
    try {
      _$result = _$v ?? new _$GDeleteNotificationVars._(input: input.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GDeleteNotificationVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GCreateFspTxVars extends GCreateFspTxVars {
  @override
  final _i1.GCreateNewTransactionInput input;

  factory _$GCreateFspTxVars(
          [void Function(GCreateFspTxVarsBuilder)? updates]) =>
      (new GCreateFspTxVarsBuilder()..update(updates))._build();

  _$GCreateFspTxVars._({required this.input}) : super._() {
    BuiltValueNullFieldError.checkNotNull(input, r'GCreateFspTxVars', 'input');
  }

  @override
  GCreateFspTxVars rebuild(void Function(GCreateFspTxVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateFspTxVarsBuilder toBuilder() =>
      new GCreateFspTxVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateFspTxVars && input == other.input;
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
    return (newBuiltValueToStringHelper(r'GCreateFspTxVars')
          ..add('input', input))
        .toString();
  }
}

class GCreateFspTxVarsBuilder
    implements Builder<GCreateFspTxVars, GCreateFspTxVarsBuilder> {
  _$GCreateFspTxVars? _$v;

  _i1.GCreateNewTransactionInputBuilder? _input;
  _i1.GCreateNewTransactionInputBuilder get input =>
      _$this._input ??= new _i1.GCreateNewTransactionInputBuilder();
  set input(_i1.GCreateNewTransactionInputBuilder? input) =>
      _$this._input = input;

  GCreateFspTxVarsBuilder();

  GCreateFspTxVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateFspTxVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateFspTxVars;
  }

  @override
  void update(void Function(GCreateFspTxVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateFspTxVars build() => _build();

  _$GCreateFspTxVars _build() {
    _$GCreateFspTxVars _$result;
    try {
      _$result = _$v ?? new _$GCreateFspTxVars._(input: input.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GCreateFspTxVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GCreateNewArtistVars extends GCreateNewArtistVars {
  @override
  final _i1.GCreateNewArtistInput input;

  factory _$GCreateNewArtistVars(
          [void Function(GCreateNewArtistVarsBuilder)? updates]) =>
      (new GCreateNewArtistVarsBuilder()..update(updates))._build();

  _$GCreateNewArtistVars._({required this.input}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        input, r'GCreateNewArtistVars', 'input');
  }

  @override
  GCreateNewArtistVars rebuild(
          void Function(GCreateNewArtistVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateNewArtistVarsBuilder toBuilder() =>
      new GCreateNewArtistVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateNewArtistVars && input == other.input;
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
    return (newBuiltValueToStringHelper(r'GCreateNewArtistVars')
          ..add('input', input))
        .toString();
  }
}

class GCreateNewArtistVarsBuilder
    implements Builder<GCreateNewArtistVars, GCreateNewArtistVarsBuilder> {
  _$GCreateNewArtistVars? _$v;

  _i1.GCreateNewArtistInputBuilder? _input;
  _i1.GCreateNewArtistInputBuilder get input =>
      _$this._input ??= new _i1.GCreateNewArtistInputBuilder();
  set input(_i1.GCreateNewArtistInputBuilder? input) => _$this._input = input;

  GCreateNewArtistVarsBuilder();

  GCreateNewArtistVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateNewArtistVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateNewArtistVars;
  }

  @override
  void update(void Function(GCreateNewArtistVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateNewArtistVars build() => _build();

  _$GCreateNewArtistVars _build() {
    _$GCreateNewArtistVars _$result;
    try {
      _$result = _$v ?? new _$GCreateNewArtistVars._(input: input.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GCreateNewArtistVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
