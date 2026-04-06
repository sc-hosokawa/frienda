// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mutation.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GCreateNewMessageRoomData> _$gCreateNewMessageRoomDataSerializer =
    new _$GCreateNewMessageRoomDataSerializer();
Serializer<GCreateNewMessageRoomData_createNewMessageRoom>
    _$gCreateNewMessageRoomDataCreateNewMessageRoomSerializer =
    new _$GCreateNewMessageRoomData_createNewMessageRoomSerializer();
Serializer<GSendMessageData> _$gSendMessageDataSerializer =
    new _$GSendMessageDataSerializer();
Serializer<GSendMessageData_sendMessage>
    _$gSendMessageDataSendMessageSerializer =
    new _$GSendMessageData_sendMessageSerializer();
Serializer<GCreateNewOfferData> _$gCreateNewOfferDataSerializer =
    new _$GCreateNewOfferDataSerializer();
Serializer<GCreateNewOfferData_createNewOffer>
    _$gCreateNewOfferDataCreateNewOfferSerializer =
    new _$GCreateNewOfferData_createNewOfferSerializer();
Serializer<GUpdateOfferInfoData> _$gUpdateOfferInfoDataSerializer =
    new _$GUpdateOfferInfoDataSerializer();
Serializer<GUpdateOfferInfoData_updateOfferInfo>
    _$gUpdateOfferInfoDataUpdateOfferInfoSerializer =
    new _$GUpdateOfferInfoData_updateOfferInfoSerializer();
Serializer<GDeleteOfferData> _$gDeleteOfferDataSerializer =
    new _$GDeleteOfferDataSerializer();
Serializer<GDeleteOfferData_deleteOffer>
    _$gDeleteOfferDataDeleteOfferSerializer =
    new _$GDeleteOfferData_deleteOfferSerializer();

class _$GCreateNewMessageRoomDataSerializer
    implements StructuredSerializer<GCreateNewMessageRoomData> {
  @override
  final Iterable<Type> types = const [
    GCreateNewMessageRoomData,
    _$GCreateNewMessageRoomData
  ];
  @override
  final String wireName = 'GCreateNewMessageRoomData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateNewMessageRoomData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'createNewMessageRoom',
      serializers.serialize(object.createNewMessageRoom,
          specifiedType:
              const FullType(GCreateNewMessageRoomData_createNewMessageRoom)),
    ];

    return result;
  }

  @override
  GCreateNewMessageRoomData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateNewMessageRoomDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'createNewMessageRoom':
          result.createNewMessageRoom.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GCreateNewMessageRoomData_createNewMessageRoom))!
              as GCreateNewMessageRoomData_createNewMessageRoom);
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateNewMessageRoomData_createNewMessageRoomSerializer
    implements
        StructuredSerializer<GCreateNewMessageRoomData_createNewMessageRoom> {
  @override
  final Iterable<Type> types = const [
    GCreateNewMessageRoomData_createNewMessageRoom,
    _$GCreateNewMessageRoomData_createNewMessageRoom
  ];
  @override
  final String wireName = 'GCreateNewMessageRoomData_createNewMessageRoom';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GCreateNewMessageRoomData_createNewMessageRoom object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GCreateNewMessageRoomData_createNewMessageRoom deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateNewMessageRoomData_createNewMessageRoomBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GSendMessageDataSerializer
    implements StructuredSerializer<GSendMessageData> {
  @override
  final Iterable<Type> types = const [GSendMessageData, _$GSendMessageData];
  @override
  final String wireName = 'GSendMessageData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GSendMessageData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'sendMessage',
      serializers.serialize(object.sendMessage,
          specifiedType: const FullType(GSendMessageData_sendMessage)),
    ];

    return result;
  }

  @override
  GSendMessageData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSendMessageDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'sendMessage':
          result.sendMessage.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GSendMessageData_sendMessage))!
              as GSendMessageData_sendMessage);
          break;
      }
    }

    return result.build();
  }
}

class _$GSendMessageData_sendMessageSerializer
    implements StructuredSerializer<GSendMessageData_sendMessage> {
  @override
  final Iterable<Type> types = const [
    GSendMessageData_sendMessage,
    _$GSendMessageData_sendMessage
  ];
  @override
  final String wireName = 'GSendMessageData_sendMessage';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSendMessageData_sendMessage object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
      'sentAt',
      serializers.serialize(object.sentAt,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.attachedFile;
    if (value != null) {
      result
        ..add('attachedFile')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.attachedImg;
    if (value != null) {
      result
        ..add('attachedImg')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    return result;
  }

  @override
  GSendMessageData_sendMessage deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSendMessageData_sendMessageBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'sentAt':
          result.sentAt = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'attachedFile':
          result.attachedFile.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'attachedImg':
          result.attachedImg.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateNewOfferDataSerializer
    implements StructuredSerializer<GCreateNewOfferData> {
  @override
  final Iterable<Type> types = const [
    GCreateNewOfferData,
    _$GCreateNewOfferData
  ];
  @override
  final String wireName = 'GCreateNewOfferData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateNewOfferData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'createNewOffer',
      serializers.serialize(object.createNewOffer,
          specifiedType: const FullType(GCreateNewOfferData_createNewOffer)),
    ];

    return result;
  }

  @override
  GCreateNewOfferData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateNewOfferDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'createNewOffer':
          result.createNewOffer.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GCreateNewOfferData_createNewOffer))!
              as GCreateNewOfferData_createNewOffer);
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateNewOfferData_createNewOfferSerializer
    implements StructuredSerializer<GCreateNewOfferData_createNewOffer> {
  @override
  final Iterable<Type> types = const [
    GCreateNewOfferData_createNewOffer,
    _$GCreateNewOfferData_createNewOffer
  ];
  @override
  final String wireName = 'GCreateNewOfferData_createNewOffer';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateNewOfferData_createNewOffer object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GCreateNewOfferData_createNewOffer deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCreateNewOfferData_createNewOfferBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateOfferInfoDataSerializer
    implements StructuredSerializer<GUpdateOfferInfoData> {
  @override
  final Iterable<Type> types = const [
    GUpdateOfferInfoData,
    _$GUpdateOfferInfoData
  ];
  @override
  final String wireName = 'GUpdateOfferInfoData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateOfferInfoData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'updateOfferInfo',
      serializers.serialize(object.updateOfferInfo,
          specifiedType: const FullType(GUpdateOfferInfoData_updateOfferInfo)),
    ];

    return result;
  }

  @override
  GUpdateOfferInfoData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateOfferInfoDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'updateOfferInfo':
          result.updateOfferInfo.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GUpdateOfferInfoData_updateOfferInfo))!
              as GUpdateOfferInfoData_updateOfferInfo);
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateOfferInfoData_updateOfferInfoSerializer
    implements StructuredSerializer<GUpdateOfferInfoData_updateOfferInfo> {
  @override
  final Iterable<Type> types = const [
    GUpdateOfferInfoData_updateOfferInfo,
    _$GUpdateOfferInfoData_updateOfferInfo
  ];
  @override
  final String wireName = 'GUpdateOfferInfoData_updateOfferInfo';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateOfferInfoData_updateOfferInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GUpdateOfferInfoData_updateOfferInfo deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateOfferInfoData_updateOfferInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GDeleteOfferDataSerializer
    implements StructuredSerializer<GDeleteOfferData> {
  @override
  final Iterable<Type> types = const [GDeleteOfferData, _$GDeleteOfferData];
  @override
  final String wireName = 'GDeleteOfferData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GDeleteOfferData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'deleteOffer',
      serializers.serialize(object.deleteOffer,
          specifiedType: const FullType(GDeleteOfferData_deleteOffer)),
    ];

    return result;
  }

  @override
  GDeleteOfferData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GDeleteOfferDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'deleteOffer':
          result.deleteOffer.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GDeleteOfferData_deleteOffer))!
              as GDeleteOfferData_deleteOffer);
          break;
      }
    }

    return result.build();
  }
}

class _$GDeleteOfferData_deleteOfferSerializer
    implements StructuredSerializer<GDeleteOfferData_deleteOffer> {
  @override
  final Iterable<Type> types = const [
    GDeleteOfferData_deleteOffer,
    _$GDeleteOfferData_deleteOffer
  ];
  @override
  final String wireName = 'GDeleteOfferData_deleteOffer';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GDeleteOfferData_deleteOffer object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GDeleteOfferData_deleteOffer deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GDeleteOfferData_deleteOfferBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateNewMessageRoomData extends GCreateNewMessageRoomData {
  @override
  final String G__typename;
  @override
  final GCreateNewMessageRoomData_createNewMessageRoom createNewMessageRoom;

  factory _$GCreateNewMessageRoomData(
          [void Function(GCreateNewMessageRoomDataBuilder)? updates]) =>
      (new GCreateNewMessageRoomDataBuilder()..update(updates))._build();

  _$GCreateNewMessageRoomData._(
      {required this.G__typename, required this.createNewMessageRoom})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GCreateNewMessageRoomData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(createNewMessageRoom,
        r'GCreateNewMessageRoomData', 'createNewMessageRoom');
  }

  @override
  GCreateNewMessageRoomData rebuild(
          void Function(GCreateNewMessageRoomDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateNewMessageRoomDataBuilder toBuilder() =>
      new GCreateNewMessageRoomDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateNewMessageRoomData &&
        G__typename == other.G__typename &&
        createNewMessageRoom == other.createNewMessageRoom;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, createNewMessageRoom.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateNewMessageRoomData')
          ..add('G__typename', G__typename)
          ..add('createNewMessageRoom', createNewMessageRoom))
        .toString();
  }
}

class GCreateNewMessageRoomDataBuilder
    implements
        Builder<GCreateNewMessageRoomData, GCreateNewMessageRoomDataBuilder> {
  _$GCreateNewMessageRoomData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GCreateNewMessageRoomData_createNewMessageRoomBuilder? _createNewMessageRoom;
  GCreateNewMessageRoomData_createNewMessageRoomBuilder
      get createNewMessageRoom => _$this._createNewMessageRoom ??=
          new GCreateNewMessageRoomData_createNewMessageRoomBuilder();
  set createNewMessageRoom(
          GCreateNewMessageRoomData_createNewMessageRoomBuilder?
              createNewMessageRoom) =>
      _$this._createNewMessageRoom = createNewMessageRoom;

  GCreateNewMessageRoomDataBuilder() {
    GCreateNewMessageRoomData._initializeBuilder(this);
  }

  GCreateNewMessageRoomDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _createNewMessageRoom = $v.createNewMessageRoom.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateNewMessageRoomData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateNewMessageRoomData;
  }

  @override
  void update(void Function(GCreateNewMessageRoomDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateNewMessageRoomData build() => _build();

  _$GCreateNewMessageRoomData _build() {
    _$GCreateNewMessageRoomData _$result;
    try {
      _$result = _$v ??
          new _$GCreateNewMessageRoomData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GCreateNewMessageRoomData', 'G__typename'),
              createNewMessageRoom: createNewMessageRoom.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createNewMessageRoom';
        createNewMessageRoom.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GCreateNewMessageRoomData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GCreateNewMessageRoomData_createNewMessageRoom
    extends GCreateNewMessageRoomData_createNewMessageRoom {
  @override
  final String G__typename;
  @override
  final String id;

  factory _$GCreateNewMessageRoomData_createNewMessageRoom(
          [void Function(GCreateNewMessageRoomData_createNewMessageRoomBuilder)?
              updates]) =>
      (new GCreateNewMessageRoomData_createNewMessageRoomBuilder()
            ..update(updates))
          ._build();

  _$GCreateNewMessageRoomData_createNewMessageRoom._(
      {required this.G__typename, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(G__typename,
        r'GCreateNewMessageRoomData_createNewMessageRoom', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GCreateNewMessageRoomData_createNewMessageRoom', 'id');
  }

  @override
  GCreateNewMessageRoomData_createNewMessageRoom rebuild(
          void Function(GCreateNewMessageRoomData_createNewMessageRoomBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateNewMessageRoomData_createNewMessageRoomBuilder toBuilder() =>
      new GCreateNewMessageRoomData_createNewMessageRoomBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateNewMessageRoomData_createNewMessageRoom &&
        G__typename == other.G__typename &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GCreateNewMessageRoomData_createNewMessageRoom')
          ..add('G__typename', G__typename)
          ..add('id', id))
        .toString();
  }
}

class GCreateNewMessageRoomData_createNewMessageRoomBuilder
    implements
        Builder<GCreateNewMessageRoomData_createNewMessageRoom,
            GCreateNewMessageRoomData_createNewMessageRoomBuilder> {
  _$GCreateNewMessageRoomData_createNewMessageRoom? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  GCreateNewMessageRoomData_createNewMessageRoomBuilder() {
    GCreateNewMessageRoomData_createNewMessageRoom._initializeBuilder(this);
  }

  GCreateNewMessageRoomData_createNewMessageRoomBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateNewMessageRoomData_createNewMessageRoom other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateNewMessageRoomData_createNewMessageRoom;
  }

  @override
  void update(
      void Function(GCreateNewMessageRoomData_createNewMessageRoomBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateNewMessageRoomData_createNewMessageRoom build() => _build();

  _$GCreateNewMessageRoomData_createNewMessageRoom _build() {
    final _$result = _$v ??
        new _$GCreateNewMessageRoomData_createNewMessageRoom._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GCreateNewMessageRoomData_createNewMessageRoom',
                'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GCreateNewMessageRoomData_createNewMessageRoom', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$GSendMessageData extends GSendMessageData {
  @override
  final String G__typename;
  @override
  final GSendMessageData_sendMessage sendMessage;

  factory _$GSendMessageData(
          [void Function(GSendMessageDataBuilder)? updates]) =>
      (new GSendMessageDataBuilder()..update(updates))._build();

  _$GSendMessageData._({required this.G__typename, required this.sendMessage})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GSendMessageData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        sendMessage, r'GSendMessageData', 'sendMessage');
  }

  @override
  GSendMessageData rebuild(void Function(GSendMessageDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSendMessageDataBuilder toBuilder() =>
      new GSendMessageDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSendMessageData &&
        G__typename == other.G__typename &&
        sendMessage == other.sendMessage;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, sendMessage.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSendMessageData')
          ..add('G__typename', G__typename)
          ..add('sendMessage', sendMessage))
        .toString();
  }
}

class GSendMessageDataBuilder
    implements Builder<GSendMessageData, GSendMessageDataBuilder> {
  _$GSendMessageData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GSendMessageData_sendMessageBuilder? _sendMessage;
  GSendMessageData_sendMessageBuilder get sendMessage =>
      _$this._sendMessage ??= new GSendMessageData_sendMessageBuilder();
  set sendMessage(GSendMessageData_sendMessageBuilder? sendMessage) =>
      _$this._sendMessage = sendMessage;

  GSendMessageDataBuilder() {
    GSendMessageData._initializeBuilder(this);
  }

  GSendMessageDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _sendMessage = $v.sendMessage.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSendMessageData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSendMessageData;
  }

  @override
  void update(void Function(GSendMessageDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSendMessageData build() => _build();

  _$GSendMessageData _build() {
    _$GSendMessageData _$result;
    try {
      _$result = _$v ??
          new _$GSendMessageData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GSendMessageData', 'G__typename'),
              sendMessage: sendMessage.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'sendMessage';
        sendMessage.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GSendMessageData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GSendMessageData_sendMessage extends GSendMessageData_sendMessage {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String message;
  @override
  final String sentAt;
  @override
  final BuiltList<String>? attachedFile;
  @override
  final BuiltList<String>? attachedImg;

  factory _$GSendMessageData_sendMessage(
          [void Function(GSendMessageData_sendMessageBuilder)? updates]) =>
      (new GSendMessageData_sendMessageBuilder()..update(updates))._build();

  _$GSendMessageData_sendMessage._(
      {required this.G__typename,
      required this.id,
      required this.message,
      required this.sentAt,
      this.attachedFile,
      this.attachedImg})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GSendMessageData_sendMessage', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GSendMessageData_sendMessage', 'id');
    BuiltValueNullFieldError.checkNotNull(
        message, r'GSendMessageData_sendMessage', 'message');
    BuiltValueNullFieldError.checkNotNull(
        sentAt, r'GSendMessageData_sendMessage', 'sentAt');
  }

  @override
  GSendMessageData_sendMessage rebuild(
          void Function(GSendMessageData_sendMessageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSendMessageData_sendMessageBuilder toBuilder() =>
      new GSendMessageData_sendMessageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSendMessageData_sendMessage &&
        G__typename == other.G__typename &&
        id == other.id &&
        message == other.message &&
        sentAt == other.sentAt &&
        attachedFile == other.attachedFile &&
        attachedImg == other.attachedImg;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, sentAt.hashCode);
    _$hash = $jc(_$hash, attachedFile.hashCode);
    _$hash = $jc(_$hash, attachedImg.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSendMessageData_sendMessage')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('message', message)
          ..add('sentAt', sentAt)
          ..add('attachedFile', attachedFile)
          ..add('attachedImg', attachedImg))
        .toString();
  }
}

class GSendMessageData_sendMessageBuilder
    implements
        Builder<GSendMessageData_sendMessage,
            GSendMessageData_sendMessageBuilder> {
  _$GSendMessageData_sendMessage? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _sentAt;
  String? get sentAt => _$this._sentAt;
  set sentAt(String? sentAt) => _$this._sentAt = sentAt;

  ListBuilder<String>? _attachedFile;
  ListBuilder<String> get attachedFile =>
      _$this._attachedFile ??= new ListBuilder<String>();
  set attachedFile(ListBuilder<String>? attachedFile) =>
      _$this._attachedFile = attachedFile;

  ListBuilder<String>? _attachedImg;
  ListBuilder<String> get attachedImg =>
      _$this._attachedImg ??= new ListBuilder<String>();
  set attachedImg(ListBuilder<String>? attachedImg) =>
      _$this._attachedImg = attachedImg;

  GSendMessageData_sendMessageBuilder() {
    GSendMessageData_sendMessage._initializeBuilder(this);
  }

  GSendMessageData_sendMessageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _message = $v.message;
      _sentAt = $v.sentAt;
      _attachedFile = $v.attachedFile?.toBuilder();
      _attachedImg = $v.attachedImg?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSendMessageData_sendMessage other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSendMessageData_sendMessage;
  }

  @override
  void update(void Function(GSendMessageData_sendMessageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSendMessageData_sendMessage build() => _build();

  _$GSendMessageData_sendMessage _build() {
    _$GSendMessageData_sendMessage _$result;
    try {
      _$result = _$v ??
          new _$GSendMessageData_sendMessage._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GSendMessageData_sendMessage', 'G__typename'),
              id: BuiltValueNullFieldError.checkNotNull(
                  id, r'GSendMessageData_sendMessage', 'id'),
              message: BuiltValueNullFieldError.checkNotNull(
                  message, r'GSendMessageData_sendMessage', 'message'),
              sentAt: BuiltValueNullFieldError.checkNotNull(
                  sentAt, r'GSendMessageData_sendMessage', 'sentAt'),
              attachedFile: _attachedFile?.build(),
              attachedImg: _attachedImg?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'attachedFile';
        _attachedFile?.build();
        _$failedField = 'attachedImg';
        _attachedImg?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GSendMessageData_sendMessage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GCreateNewOfferData extends GCreateNewOfferData {
  @override
  final String G__typename;
  @override
  final GCreateNewOfferData_createNewOffer createNewOffer;

  factory _$GCreateNewOfferData(
          [void Function(GCreateNewOfferDataBuilder)? updates]) =>
      (new GCreateNewOfferDataBuilder()..update(updates))._build();

  _$GCreateNewOfferData._(
      {required this.G__typename, required this.createNewOffer})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GCreateNewOfferData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        createNewOffer, r'GCreateNewOfferData', 'createNewOffer');
  }

  @override
  GCreateNewOfferData rebuild(
          void Function(GCreateNewOfferDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateNewOfferDataBuilder toBuilder() =>
      new GCreateNewOfferDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateNewOfferData &&
        G__typename == other.G__typename &&
        createNewOffer == other.createNewOffer;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, createNewOffer.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateNewOfferData')
          ..add('G__typename', G__typename)
          ..add('createNewOffer', createNewOffer))
        .toString();
  }
}

class GCreateNewOfferDataBuilder
    implements Builder<GCreateNewOfferData, GCreateNewOfferDataBuilder> {
  _$GCreateNewOfferData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GCreateNewOfferData_createNewOfferBuilder? _createNewOffer;
  GCreateNewOfferData_createNewOfferBuilder get createNewOffer =>
      _$this._createNewOffer ??=
          new GCreateNewOfferData_createNewOfferBuilder();
  set createNewOffer(
          GCreateNewOfferData_createNewOfferBuilder? createNewOffer) =>
      _$this._createNewOffer = createNewOffer;

  GCreateNewOfferDataBuilder() {
    GCreateNewOfferData._initializeBuilder(this);
  }

  GCreateNewOfferDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _createNewOffer = $v.createNewOffer.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateNewOfferData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateNewOfferData;
  }

  @override
  void update(void Function(GCreateNewOfferDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateNewOfferData build() => _build();

  _$GCreateNewOfferData _build() {
    _$GCreateNewOfferData _$result;
    try {
      _$result = _$v ??
          new _$GCreateNewOfferData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GCreateNewOfferData', 'G__typename'),
              createNewOffer: createNewOffer.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createNewOffer';
        createNewOffer.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GCreateNewOfferData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GCreateNewOfferData_createNewOffer
    extends GCreateNewOfferData_createNewOffer {
  @override
  final String G__typename;
  @override
  final int id;

  factory _$GCreateNewOfferData_createNewOffer(
          [void Function(GCreateNewOfferData_createNewOfferBuilder)?
              updates]) =>
      (new GCreateNewOfferData_createNewOfferBuilder()..update(updates))
          ._build();

  _$GCreateNewOfferData_createNewOffer._(
      {required this.G__typename, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GCreateNewOfferData_createNewOffer', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GCreateNewOfferData_createNewOffer', 'id');
  }

  @override
  GCreateNewOfferData_createNewOffer rebuild(
          void Function(GCreateNewOfferData_createNewOfferBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateNewOfferData_createNewOfferBuilder toBuilder() =>
      new GCreateNewOfferData_createNewOfferBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateNewOfferData_createNewOffer &&
        G__typename == other.G__typename &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateNewOfferData_createNewOffer')
          ..add('G__typename', G__typename)
          ..add('id', id))
        .toString();
  }
}

class GCreateNewOfferData_createNewOfferBuilder
    implements
        Builder<GCreateNewOfferData_createNewOffer,
            GCreateNewOfferData_createNewOfferBuilder> {
  _$GCreateNewOfferData_createNewOffer? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  GCreateNewOfferData_createNewOfferBuilder() {
    GCreateNewOfferData_createNewOffer._initializeBuilder(this);
  }

  GCreateNewOfferData_createNewOfferBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateNewOfferData_createNewOffer other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCreateNewOfferData_createNewOffer;
  }

  @override
  void update(
      void Function(GCreateNewOfferData_createNewOfferBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateNewOfferData_createNewOffer build() => _build();

  _$GCreateNewOfferData_createNewOffer _build() {
    final _$result = _$v ??
        new _$GCreateNewOfferData_createNewOffer._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GCreateNewOfferData_createNewOffer', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GCreateNewOfferData_createNewOffer', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateOfferInfoData extends GUpdateOfferInfoData {
  @override
  final String G__typename;
  @override
  final GUpdateOfferInfoData_updateOfferInfo updateOfferInfo;

  factory _$GUpdateOfferInfoData(
          [void Function(GUpdateOfferInfoDataBuilder)? updates]) =>
      (new GUpdateOfferInfoDataBuilder()..update(updates))._build();

  _$GUpdateOfferInfoData._(
      {required this.G__typename, required this.updateOfferInfo})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GUpdateOfferInfoData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        updateOfferInfo, r'GUpdateOfferInfoData', 'updateOfferInfo');
  }

  @override
  GUpdateOfferInfoData rebuild(
          void Function(GUpdateOfferInfoDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateOfferInfoDataBuilder toBuilder() =>
      new GUpdateOfferInfoDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateOfferInfoData &&
        G__typename == other.G__typename &&
        updateOfferInfo == other.updateOfferInfo;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, updateOfferInfo.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateOfferInfoData')
          ..add('G__typename', G__typename)
          ..add('updateOfferInfo', updateOfferInfo))
        .toString();
  }
}

class GUpdateOfferInfoDataBuilder
    implements Builder<GUpdateOfferInfoData, GUpdateOfferInfoDataBuilder> {
  _$GUpdateOfferInfoData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GUpdateOfferInfoData_updateOfferInfoBuilder? _updateOfferInfo;
  GUpdateOfferInfoData_updateOfferInfoBuilder get updateOfferInfo =>
      _$this._updateOfferInfo ??=
          new GUpdateOfferInfoData_updateOfferInfoBuilder();
  set updateOfferInfo(
          GUpdateOfferInfoData_updateOfferInfoBuilder? updateOfferInfo) =>
      _$this._updateOfferInfo = updateOfferInfo;

  GUpdateOfferInfoDataBuilder() {
    GUpdateOfferInfoData._initializeBuilder(this);
  }

  GUpdateOfferInfoDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _updateOfferInfo = $v.updateOfferInfo.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateOfferInfoData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateOfferInfoData;
  }

  @override
  void update(void Function(GUpdateOfferInfoDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateOfferInfoData build() => _build();

  _$GUpdateOfferInfoData _build() {
    _$GUpdateOfferInfoData _$result;
    try {
      _$result = _$v ??
          new _$GUpdateOfferInfoData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GUpdateOfferInfoData', 'G__typename'),
              updateOfferInfo: updateOfferInfo.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'updateOfferInfo';
        updateOfferInfo.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GUpdateOfferInfoData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateOfferInfoData_updateOfferInfo
    extends GUpdateOfferInfoData_updateOfferInfo {
  @override
  final String G__typename;
  @override
  final int id;

  factory _$GUpdateOfferInfoData_updateOfferInfo(
          [void Function(GUpdateOfferInfoData_updateOfferInfoBuilder)?
              updates]) =>
      (new GUpdateOfferInfoData_updateOfferInfoBuilder()..update(updates))
          ._build();

  _$GUpdateOfferInfoData_updateOfferInfo._(
      {required this.G__typename, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GUpdateOfferInfoData_updateOfferInfo', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GUpdateOfferInfoData_updateOfferInfo', 'id');
  }

  @override
  GUpdateOfferInfoData_updateOfferInfo rebuild(
          void Function(GUpdateOfferInfoData_updateOfferInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateOfferInfoData_updateOfferInfoBuilder toBuilder() =>
      new GUpdateOfferInfoData_updateOfferInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateOfferInfoData_updateOfferInfo &&
        G__typename == other.G__typename &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateOfferInfoData_updateOfferInfo')
          ..add('G__typename', G__typename)
          ..add('id', id))
        .toString();
  }
}

class GUpdateOfferInfoData_updateOfferInfoBuilder
    implements
        Builder<GUpdateOfferInfoData_updateOfferInfo,
            GUpdateOfferInfoData_updateOfferInfoBuilder> {
  _$GUpdateOfferInfoData_updateOfferInfo? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  GUpdateOfferInfoData_updateOfferInfoBuilder() {
    GUpdateOfferInfoData_updateOfferInfo._initializeBuilder(this);
  }

  GUpdateOfferInfoData_updateOfferInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateOfferInfoData_updateOfferInfo other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateOfferInfoData_updateOfferInfo;
  }

  @override
  void update(
      void Function(GUpdateOfferInfoData_updateOfferInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateOfferInfoData_updateOfferInfo build() => _build();

  _$GUpdateOfferInfoData_updateOfferInfo _build() {
    final _$result = _$v ??
        new _$GUpdateOfferInfoData_updateOfferInfo._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GUpdateOfferInfoData_updateOfferInfo', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GUpdateOfferInfoData_updateOfferInfo', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$GDeleteOfferData extends GDeleteOfferData {
  @override
  final String G__typename;
  @override
  final GDeleteOfferData_deleteOffer deleteOffer;

  factory _$GDeleteOfferData(
          [void Function(GDeleteOfferDataBuilder)? updates]) =>
      (new GDeleteOfferDataBuilder()..update(updates))._build();

  _$GDeleteOfferData._({required this.G__typename, required this.deleteOffer})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GDeleteOfferData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        deleteOffer, r'GDeleteOfferData', 'deleteOffer');
  }

  @override
  GDeleteOfferData rebuild(void Function(GDeleteOfferDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GDeleteOfferDataBuilder toBuilder() =>
      new GDeleteOfferDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GDeleteOfferData &&
        G__typename == other.G__typename &&
        deleteOffer == other.deleteOffer;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, deleteOffer.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GDeleteOfferData')
          ..add('G__typename', G__typename)
          ..add('deleteOffer', deleteOffer))
        .toString();
  }
}

class GDeleteOfferDataBuilder
    implements Builder<GDeleteOfferData, GDeleteOfferDataBuilder> {
  _$GDeleteOfferData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GDeleteOfferData_deleteOfferBuilder? _deleteOffer;
  GDeleteOfferData_deleteOfferBuilder get deleteOffer =>
      _$this._deleteOffer ??= new GDeleteOfferData_deleteOfferBuilder();
  set deleteOffer(GDeleteOfferData_deleteOfferBuilder? deleteOffer) =>
      _$this._deleteOffer = deleteOffer;

  GDeleteOfferDataBuilder() {
    GDeleteOfferData._initializeBuilder(this);
  }

  GDeleteOfferDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _deleteOffer = $v.deleteOffer.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GDeleteOfferData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GDeleteOfferData;
  }

  @override
  void update(void Function(GDeleteOfferDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GDeleteOfferData build() => _build();

  _$GDeleteOfferData _build() {
    _$GDeleteOfferData _$result;
    try {
      _$result = _$v ??
          new _$GDeleteOfferData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GDeleteOfferData', 'G__typename'),
              deleteOffer: deleteOffer.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'deleteOffer';
        deleteOffer.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GDeleteOfferData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GDeleteOfferData_deleteOffer extends GDeleteOfferData_deleteOffer {
  @override
  final String G__typename;
  @override
  final int id;

  factory _$GDeleteOfferData_deleteOffer(
          [void Function(GDeleteOfferData_deleteOfferBuilder)? updates]) =>
      (new GDeleteOfferData_deleteOfferBuilder()..update(updates))._build();

  _$GDeleteOfferData_deleteOffer._(
      {required this.G__typename, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GDeleteOfferData_deleteOffer', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GDeleteOfferData_deleteOffer', 'id');
  }

  @override
  GDeleteOfferData_deleteOffer rebuild(
          void Function(GDeleteOfferData_deleteOfferBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GDeleteOfferData_deleteOfferBuilder toBuilder() =>
      new GDeleteOfferData_deleteOfferBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GDeleteOfferData_deleteOffer &&
        G__typename == other.G__typename &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GDeleteOfferData_deleteOffer')
          ..add('G__typename', G__typename)
          ..add('id', id))
        .toString();
  }
}

class GDeleteOfferData_deleteOfferBuilder
    implements
        Builder<GDeleteOfferData_deleteOffer,
            GDeleteOfferData_deleteOfferBuilder> {
  _$GDeleteOfferData_deleteOffer? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  GDeleteOfferData_deleteOfferBuilder() {
    GDeleteOfferData_deleteOffer._initializeBuilder(this);
  }

  GDeleteOfferData_deleteOfferBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GDeleteOfferData_deleteOffer other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GDeleteOfferData_deleteOffer;
  }

  @override
  void update(void Function(GDeleteOfferData_deleteOfferBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GDeleteOfferData_deleteOffer build() => _build();

  _$GDeleteOfferData_deleteOffer _build() {
    final _$result = _$v ??
        new _$GDeleteOfferData_deleteOffer._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GDeleteOfferData_deleteOffer', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GDeleteOfferData_deleteOffer', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
