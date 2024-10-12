// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema.schema.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GAddNewConnectionInput> _$gAddNewConnectionInputSerializer =
    new _$GAddNewConnectionInputSerializer();
Serializer<GCreateNewMessageRoomInput> _$gCreateNewMessageRoomInputSerializer =
    new _$GCreateNewMessageRoomInputSerializer();
Serializer<GCreateNewNotificationInput>
    _$gCreateNewNotificationInputSerializer =
    new _$GCreateNewNotificationInputSerializer();
Serializer<GCreateNewOfferInput> _$gCreateNewOfferInputSerializer =
    new _$GCreateNewOfferInputSerializer();
Serializer<GCreateNewUserDataInput> _$gCreateNewUserDataInputSerializer =
    new _$GCreateNewUserDataInputSerializer();
Serializer<GDeleteNotificationInput> _$gDeleteNotificationInputSerializer =
    new _$GDeleteNotificationInputSerializer();
Serializer<GDeleteOfferInput> _$gDeleteOfferInputSerializer =
    new _$GDeleteOfferInputSerializer();
Serializer<GSendMessageInput> _$gSendMessageInputSerializer =
    new _$GSendMessageInputSerializer();
Serializer<GUpdateNotificationInput> _$gUpdateNotificationInputSerializer =
    new _$GUpdateNotificationInputSerializer();
Serializer<GUpdateOfferInput> _$gUpdateOfferInputSerializer =
    new _$GUpdateOfferInputSerializer();

class _$GAddNewConnectionInputSerializer
    implements StructuredSerializer<GAddNewConnectionInput> {
  @override
  final Iterable<Type> types = const [
    GAddNewConnectionInput,
    _$GAddNewConnectionInput
  ];
  @override
  final String wireName = 'GAddNewConnectionInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAddNewConnectionInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GAddNewConnectionInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAddNewConnectionInputBuilder();

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

class _$GCreateNewMessageRoomInputSerializer
    implements StructuredSerializer<GCreateNewMessageRoomInput> {
  @override
  final Iterable<Type> types = const [
    GCreateNewMessageRoomInput,
    _$GCreateNewMessageRoomInput
  ];
  @override
  final String wireName = 'GCreateNewMessageRoomInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateNewMessageRoomInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'content',
      serializers.serialize(object.content,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GCreateNewMessageRoomInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateNewMessageRoomInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateNewNotificationInputSerializer
    implements StructuredSerializer<GCreateNewNotificationInput> {
  @override
  final Iterable<Type> types = const [
    GCreateNewNotificationInput,
    _$GCreateNewNotificationInput
  ];
  @override
  final String wireName = 'GCreateNewNotificationInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateNewNotificationInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'content',
      serializers.serialize(object.content,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GCreateNewNotificationInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateNewNotificationInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateNewOfferInputSerializer
    implements StructuredSerializer<GCreateNewOfferInput> {
  @override
  final Iterable<Type> types = const [
    GCreateNewOfferInput,
    _$GCreateNewOfferInput
  ];
  @override
  final String wireName = 'GCreateNewOfferInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateNewOfferInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'content',
      serializers.serialize(object.content,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GCreateNewOfferInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateNewOfferInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateNewUserDataInputSerializer
    implements StructuredSerializer<GCreateNewUserDataInput> {
  @override
  final Iterable<Type> types = const [
    GCreateNewUserDataInput,
    _$GCreateNewUserDataInput
  ];
  @override
  final String wireName = 'GCreateNewUserDataInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateNewUserDataInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'firstName',
      serializers.serialize(object.firstName,
          specifiedType: const FullType(String)),
      'lastName',
      serializers.serialize(object.lastName,
          specifiedType: const FullType(String)),
      'imageUrl',
      serializers.serialize(object.imageUrl,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GCreateNewUserDataInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateNewUserDataInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'firstName':
          result.firstName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'lastName':
          result.lastName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'imageUrl':
          result.imageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GDeleteNotificationInputSerializer
    implements StructuredSerializer<GDeleteNotificationInput> {
  @override
  final Iterable<Type> types = const [
    GDeleteNotificationInput,
    _$GDeleteNotificationInput
  ];
  @override
  final String wireName = 'GDeleteNotificationInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GDeleteNotificationInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GDeleteNotificationInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GDeleteNotificationInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GDeleteOfferInputSerializer
    implements StructuredSerializer<GDeleteOfferInput> {
  @override
  final Iterable<Type> types = const [GDeleteOfferInput, _$GDeleteOfferInput];
  @override
  final String wireName = 'GDeleteOfferInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, GDeleteOfferInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GDeleteOfferInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GDeleteOfferInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GSendMessageInputSerializer
    implements StructuredSerializer<GSendMessageInput> {
  @override
  final Iterable<Type> types = const [GSendMessageInput, _$GSendMessageInput];
  @override
  final String wireName = 'GSendMessageInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, GSendMessageInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'content',
      serializers.serialize(object.content,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GSendMessageInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSendMessageInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateNotificationInputSerializer
    implements StructuredSerializer<GUpdateNotificationInput> {
  @override
  final Iterable<Type> types = const [
    GUpdateNotificationInput,
    _$GUpdateNotificationInput
  ];
  @override
  final String wireName = 'GUpdateNotificationInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateNotificationInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'content',
      serializers.serialize(object.content,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GUpdateNotificationInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateNotificationInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateOfferInputSerializer
    implements StructuredSerializer<GUpdateOfferInput> {
  @override
  final Iterable<Type> types = const [GUpdateOfferInput, _$GUpdateOfferInput];
  @override
  final String wireName = 'GUpdateOfferInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, GUpdateOfferInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'content',
      serializers.serialize(object.content,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GUpdateOfferInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateOfferInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GAddNewConnectionInput extends GAddNewConnectionInput {
  @override
  final String userId;

  factory _$GAddNewConnectionInput(
          [void Function(GAddNewConnectionInputBuilder)? updates]) =>
      (new GAddNewConnectionInputBuilder()..update(updates))._build();

  _$GAddNewConnectionInput._({required this.userId}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        userId, r'GAddNewConnectionInput', 'userId');
  }

  @override
  GAddNewConnectionInput rebuild(
          void Function(GAddNewConnectionInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAddNewConnectionInputBuilder toBuilder() =>
      new GAddNewConnectionInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAddNewConnectionInput && userId == other.userId;
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
    return (newBuiltValueToStringHelper(r'GAddNewConnectionInput')
          ..add('userId', userId))
        .toString();
  }
}

class GAddNewConnectionInputBuilder
    implements Builder<GAddNewConnectionInput, GAddNewConnectionInputBuilder> {
  _$GAddNewConnectionInput? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  GAddNewConnectionInputBuilder();

  GAddNewConnectionInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAddNewConnectionInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAddNewConnectionInput;
  }

  @override
  void update(void Function(GAddNewConnectionInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAddNewConnectionInput build() => _build();

  _$GAddNewConnectionInput _build() {
    final _$result = _$v ??
        new _$GAddNewConnectionInput._(
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'GAddNewConnectionInput', 'userId'));
    replace(_$result);
    return _$result;
  }
}

class _$GCreateNewMessageRoomInput extends GCreateNewMessageRoomInput {
  @override
  final String title;
  @override
  final String content;

  factory _$GCreateNewMessageRoomInput(
          [void Function(GCreateNewMessageRoomInputBuilder)? updates]) =>
      (new GCreateNewMessageRoomInputBuilder()..update(updates))._build();

  _$GCreateNewMessageRoomInput._({required this.title, required this.content})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        title, r'GCreateNewMessageRoomInput', 'title');
    BuiltValueNullFieldError.checkNotNull(
        content, r'GCreateNewMessageRoomInput', 'content');
  }

  @override
  GCreateNewMessageRoomInput rebuild(
          void Function(GCreateNewMessageRoomInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateNewMessageRoomInputBuilder toBuilder() =>
      new GCreateNewMessageRoomInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateNewMessageRoomInput &&
        title == other.title &&
        content == other.content;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateNewMessageRoomInput')
          ..add('title', title)
          ..add('content', content))
        .toString();
  }
}

class GCreateNewMessageRoomInputBuilder
    implements
        Builder<GCreateNewMessageRoomInput, GCreateNewMessageRoomInputBuilder> {
  _$GCreateNewMessageRoomInput? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  GCreateNewMessageRoomInputBuilder();

  GCreateNewMessageRoomInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _content = $v.content;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateNewMessageRoomInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateNewMessageRoomInput;
  }

  @override
  void update(void Function(GCreateNewMessageRoomInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateNewMessageRoomInput build() => _build();

  _$GCreateNewMessageRoomInput _build() {
    final _$result = _$v ??
        new _$GCreateNewMessageRoomInput._(
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'GCreateNewMessageRoomInput', 'title'),
            content: BuiltValueNullFieldError.checkNotNull(
                content, r'GCreateNewMessageRoomInput', 'content'));
    replace(_$result);
    return _$result;
  }
}

class _$GCreateNewNotificationInput extends GCreateNewNotificationInput {
  @override
  final String title;
  @override
  final String content;

  factory _$GCreateNewNotificationInput(
          [void Function(GCreateNewNotificationInputBuilder)? updates]) =>
      (new GCreateNewNotificationInputBuilder()..update(updates))._build();

  _$GCreateNewNotificationInput._({required this.title, required this.content})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        title, r'GCreateNewNotificationInput', 'title');
    BuiltValueNullFieldError.checkNotNull(
        content, r'GCreateNewNotificationInput', 'content');
  }

  @override
  GCreateNewNotificationInput rebuild(
          void Function(GCreateNewNotificationInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateNewNotificationInputBuilder toBuilder() =>
      new GCreateNewNotificationInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateNewNotificationInput &&
        title == other.title &&
        content == other.content;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateNewNotificationInput')
          ..add('title', title)
          ..add('content', content))
        .toString();
  }
}

class GCreateNewNotificationInputBuilder
    implements
        Builder<GCreateNewNotificationInput,
            GCreateNewNotificationInputBuilder> {
  _$GCreateNewNotificationInput? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  GCreateNewNotificationInputBuilder();

  GCreateNewNotificationInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _content = $v.content;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateNewNotificationInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateNewNotificationInput;
  }

  @override
  void update(void Function(GCreateNewNotificationInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateNewNotificationInput build() => _build();

  _$GCreateNewNotificationInput _build() {
    final _$result = _$v ??
        new _$GCreateNewNotificationInput._(
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'GCreateNewNotificationInput', 'title'),
            content: BuiltValueNullFieldError.checkNotNull(
                content, r'GCreateNewNotificationInput', 'content'));
    replace(_$result);
    return _$result;
  }
}

class _$GCreateNewOfferInput extends GCreateNewOfferInput {
  @override
  final String title;
  @override
  final String content;

  factory _$GCreateNewOfferInput(
          [void Function(GCreateNewOfferInputBuilder)? updates]) =>
      (new GCreateNewOfferInputBuilder()..update(updates))._build();

  _$GCreateNewOfferInput._({required this.title, required this.content})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        title, r'GCreateNewOfferInput', 'title');
    BuiltValueNullFieldError.checkNotNull(
        content, r'GCreateNewOfferInput', 'content');
  }

  @override
  GCreateNewOfferInput rebuild(
          void Function(GCreateNewOfferInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateNewOfferInputBuilder toBuilder() =>
      new GCreateNewOfferInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateNewOfferInput &&
        title == other.title &&
        content == other.content;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateNewOfferInput')
          ..add('title', title)
          ..add('content', content))
        .toString();
  }
}

class GCreateNewOfferInputBuilder
    implements Builder<GCreateNewOfferInput, GCreateNewOfferInputBuilder> {
  _$GCreateNewOfferInput? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  GCreateNewOfferInputBuilder();

  GCreateNewOfferInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _content = $v.content;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateNewOfferInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateNewOfferInput;
  }

  @override
  void update(void Function(GCreateNewOfferInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateNewOfferInput build() => _build();

  _$GCreateNewOfferInput _build() {
    final _$result = _$v ??
        new _$GCreateNewOfferInput._(
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'GCreateNewOfferInput', 'title'),
            content: BuiltValueNullFieldError.checkNotNull(
                content, r'GCreateNewOfferInput', 'content'));
    replace(_$result);
    return _$result;
  }
}

class _$GCreateNewUserDataInput extends GCreateNewUserDataInput {
  @override
  final String email;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String imageUrl;

  factory _$GCreateNewUserDataInput(
          [void Function(GCreateNewUserDataInputBuilder)? updates]) =>
      (new GCreateNewUserDataInputBuilder()..update(updates))._build();

  _$GCreateNewUserDataInput._(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.imageUrl})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        email, r'GCreateNewUserDataInput', 'email');
    BuiltValueNullFieldError.checkNotNull(
        firstName, r'GCreateNewUserDataInput', 'firstName');
    BuiltValueNullFieldError.checkNotNull(
        lastName, r'GCreateNewUserDataInput', 'lastName');
    BuiltValueNullFieldError.checkNotNull(
        imageUrl, r'GCreateNewUserDataInput', 'imageUrl');
  }

  @override
  GCreateNewUserDataInput rebuild(
          void Function(GCreateNewUserDataInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateNewUserDataInputBuilder toBuilder() =>
      new GCreateNewUserDataInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateNewUserDataInput &&
        email == other.email &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        imageUrl == other.imageUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateNewUserDataInput')
          ..add('email', email)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('imageUrl', imageUrl))
        .toString();
  }
}

class GCreateNewUserDataInputBuilder
    implements
        Builder<GCreateNewUserDataInput, GCreateNewUserDataInputBuilder> {
  _$GCreateNewUserDataInput? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  GCreateNewUserDataInputBuilder();

  GCreateNewUserDataInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _imageUrl = $v.imageUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateNewUserDataInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateNewUserDataInput;
  }

  @override
  void update(void Function(GCreateNewUserDataInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateNewUserDataInput build() => _build();

  _$GCreateNewUserDataInput _build() {
    final _$result = _$v ??
        new _$GCreateNewUserDataInput._(
            email: BuiltValueNullFieldError.checkNotNull(
                email, r'GCreateNewUserDataInput', 'email'),
            firstName: BuiltValueNullFieldError.checkNotNull(
                firstName, r'GCreateNewUserDataInput', 'firstName'),
            lastName: BuiltValueNullFieldError.checkNotNull(
                lastName, r'GCreateNewUserDataInput', 'lastName'),
            imageUrl: BuiltValueNullFieldError.checkNotNull(
                imageUrl, r'GCreateNewUserDataInput', 'imageUrl'));
    replace(_$result);
    return _$result;
  }
}

class _$GDeleteNotificationInput extends GDeleteNotificationInput {
  @override
  final String id;

  factory _$GDeleteNotificationInput(
          [void Function(GDeleteNotificationInputBuilder)? updates]) =>
      (new GDeleteNotificationInputBuilder()..update(updates))._build();

  _$GDeleteNotificationInput._({required this.id}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        id, r'GDeleteNotificationInput', 'id');
  }

  @override
  GDeleteNotificationInput rebuild(
          void Function(GDeleteNotificationInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GDeleteNotificationInputBuilder toBuilder() =>
      new GDeleteNotificationInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GDeleteNotificationInput && id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GDeleteNotificationInput')
          ..add('id', id))
        .toString();
  }
}

class GDeleteNotificationInputBuilder
    implements
        Builder<GDeleteNotificationInput, GDeleteNotificationInputBuilder> {
  _$GDeleteNotificationInput? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  GDeleteNotificationInputBuilder();

  GDeleteNotificationInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GDeleteNotificationInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GDeleteNotificationInput;
  }

  @override
  void update(void Function(GDeleteNotificationInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GDeleteNotificationInput build() => _build();

  _$GDeleteNotificationInput _build() {
    final _$result = _$v ??
        new _$GDeleteNotificationInput._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GDeleteNotificationInput', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$GDeleteOfferInput extends GDeleteOfferInput {
  @override
  final String id;

  factory _$GDeleteOfferInput(
          [void Function(GDeleteOfferInputBuilder)? updates]) =>
      (new GDeleteOfferInputBuilder()..update(updates))._build();

  _$GDeleteOfferInput._({required this.id}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'GDeleteOfferInput', 'id');
  }

  @override
  GDeleteOfferInput rebuild(void Function(GDeleteOfferInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GDeleteOfferInputBuilder toBuilder() =>
      new GDeleteOfferInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GDeleteOfferInput && id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GDeleteOfferInput')..add('id', id))
        .toString();
  }
}

class GDeleteOfferInputBuilder
    implements Builder<GDeleteOfferInput, GDeleteOfferInputBuilder> {
  _$GDeleteOfferInput? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  GDeleteOfferInputBuilder();

  GDeleteOfferInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GDeleteOfferInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GDeleteOfferInput;
  }

  @override
  void update(void Function(GDeleteOfferInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GDeleteOfferInput build() => _build();

  _$GDeleteOfferInput _build() {
    final _$result = _$v ??
        new _$GDeleteOfferInput._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GDeleteOfferInput', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$GSendMessageInput extends GSendMessageInput {
  @override
  final String title;
  @override
  final String content;

  factory _$GSendMessageInput(
          [void Function(GSendMessageInputBuilder)? updates]) =>
      (new GSendMessageInputBuilder()..update(updates))._build();

  _$GSendMessageInput._({required this.title, required this.content})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(title, r'GSendMessageInput', 'title');
    BuiltValueNullFieldError.checkNotNull(
        content, r'GSendMessageInput', 'content');
  }

  @override
  GSendMessageInput rebuild(void Function(GSendMessageInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSendMessageInputBuilder toBuilder() =>
      new GSendMessageInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSendMessageInput &&
        title == other.title &&
        content == other.content;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSendMessageInput')
          ..add('title', title)
          ..add('content', content))
        .toString();
  }
}

class GSendMessageInputBuilder
    implements Builder<GSendMessageInput, GSendMessageInputBuilder> {
  _$GSendMessageInput? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  GSendMessageInputBuilder();

  GSendMessageInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _content = $v.content;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSendMessageInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSendMessageInput;
  }

  @override
  void update(void Function(GSendMessageInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSendMessageInput build() => _build();

  _$GSendMessageInput _build() {
    final _$result = _$v ??
        new _$GSendMessageInput._(
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'GSendMessageInput', 'title'),
            content: BuiltValueNullFieldError.checkNotNull(
                content, r'GSendMessageInput', 'content'));
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateNotificationInput extends GUpdateNotificationInput {
  @override
  final String id;
  @override
  final String title;
  @override
  final String content;

  factory _$GUpdateNotificationInput(
          [void Function(GUpdateNotificationInputBuilder)? updates]) =>
      (new GUpdateNotificationInputBuilder()..update(updates))._build();

  _$GUpdateNotificationInput._(
      {required this.id, required this.title, required this.content})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        id, r'GUpdateNotificationInput', 'id');
    BuiltValueNullFieldError.checkNotNull(
        title, r'GUpdateNotificationInput', 'title');
    BuiltValueNullFieldError.checkNotNull(
        content, r'GUpdateNotificationInput', 'content');
  }

  @override
  GUpdateNotificationInput rebuild(
          void Function(GUpdateNotificationInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateNotificationInputBuilder toBuilder() =>
      new GUpdateNotificationInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateNotificationInput &&
        id == other.id &&
        title == other.title &&
        content == other.content;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateNotificationInput')
          ..add('id', id)
          ..add('title', title)
          ..add('content', content))
        .toString();
  }
}

class GUpdateNotificationInputBuilder
    implements
        Builder<GUpdateNotificationInput, GUpdateNotificationInputBuilder> {
  _$GUpdateNotificationInput? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  GUpdateNotificationInputBuilder();

  GUpdateNotificationInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _content = $v.content;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateNotificationInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateNotificationInput;
  }

  @override
  void update(void Function(GUpdateNotificationInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateNotificationInput build() => _build();

  _$GUpdateNotificationInput _build() {
    final _$result = _$v ??
        new _$GUpdateNotificationInput._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GUpdateNotificationInput', 'id'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'GUpdateNotificationInput', 'title'),
            content: BuiltValueNullFieldError.checkNotNull(
                content, r'GUpdateNotificationInput', 'content'));
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateOfferInput extends GUpdateOfferInput {
  @override
  final String id;
  @override
  final String title;
  @override
  final String content;

  factory _$GUpdateOfferInput(
          [void Function(GUpdateOfferInputBuilder)? updates]) =>
      (new GUpdateOfferInputBuilder()..update(updates))._build();

  _$GUpdateOfferInput._(
      {required this.id, required this.title, required this.content})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'GUpdateOfferInput', 'id');
    BuiltValueNullFieldError.checkNotNull(title, r'GUpdateOfferInput', 'title');
    BuiltValueNullFieldError.checkNotNull(
        content, r'GUpdateOfferInput', 'content');
  }

  @override
  GUpdateOfferInput rebuild(void Function(GUpdateOfferInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateOfferInputBuilder toBuilder() =>
      new GUpdateOfferInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateOfferInput &&
        id == other.id &&
        title == other.title &&
        content == other.content;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateOfferInput')
          ..add('id', id)
          ..add('title', title)
          ..add('content', content))
        .toString();
  }
}

class GUpdateOfferInputBuilder
    implements Builder<GUpdateOfferInput, GUpdateOfferInputBuilder> {
  _$GUpdateOfferInput? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  GUpdateOfferInputBuilder();

  GUpdateOfferInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _content = $v.content;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateOfferInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateOfferInput;
  }

  @override
  void update(void Function(GUpdateOfferInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateOfferInput build() => _build();

  _$GUpdateOfferInput _build() {
    final _$result = _$v ??
        new _$GUpdateOfferInput._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GUpdateOfferInput', 'id'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'GUpdateOfferInput', 'title'),
            content: BuiltValueNullFieldError.checkNotNull(
                content, r'GUpdateOfferInput', 'content'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
