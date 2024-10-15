// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mutation.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GAddNewConnectionData> _$gAddNewConnectionDataSerializer =
    new _$GAddNewConnectionDataSerializer();
Serializer<GAddNewConnectionData_addNewConnection>
    _$gAddNewConnectionDataAddNewConnectionSerializer =
    new _$GAddNewConnectionData_addNewConnectionSerializer();
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
Serializer<GUpdateOfferData> _$gUpdateOfferDataSerializer =
    new _$GUpdateOfferDataSerializer();
Serializer<GUpdateOfferData_updateOffer>
    _$gUpdateOfferDataUpdateOfferSerializer =
    new _$GUpdateOfferData_updateOfferSerializer();
Serializer<GDeleteOfferData> _$gDeleteOfferDataSerializer =
    new _$GDeleteOfferDataSerializer();
Serializer<GDeleteOfferData_deleteOffer>
    _$gDeleteOfferDataDeleteOfferSerializer =
    new _$GDeleteOfferData_deleteOfferSerializer();

class _$GAddNewConnectionDataSerializer
    implements StructuredSerializer<GAddNewConnectionData> {
  @override
  final Iterable<Type> types = const [
    GAddNewConnectionData,
    _$GAddNewConnectionData
  ];
  @override
  final String wireName = 'GAddNewConnectionData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAddNewConnectionData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'addNewConnection',
      serializers.serialize(object.addNewConnection,
          specifiedType:
              const FullType(GAddNewConnectionData_addNewConnection)),
    ];

    return result;
  }

  @override
  GAddNewConnectionData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAddNewConnectionDataBuilder();

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
        case 'addNewConnection':
          result.addNewConnection.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GAddNewConnectionData_addNewConnection))!
              as GAddNewConnectionData_addNewConnection);
          break;
      }
    }

    return result.build();
  }
}

class _$GAddNewConnectionData_addNewConnectionSerializer
    implements StructuredSerializer<GAddNewConnectionData_addNewConnection> {
  @override
  final Iterable<Type> types = const [
    GAddNewConnectionData_addNewConnection,
    _$GAddNewConnectionData_addNewConnection
  ];
  @override
  final String wireName = 'GAddNewConnectionData_addNewConnection';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAddNewConnectionData_addNewConnection object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'mapId',
      serializers.serialize(object.mapId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GAddNewConnectionData_addNewConnection deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAddNewConnectionData_addNewConnectionBuilder();

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
        case 'mapId':
          result.mapId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

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
    ];

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
      serializers.serialize(object.id, specifiedType: const FullType(String)),
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
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateOfferDataSerializer
    implements StructuredSerializer<GUpdateOfferData> {
  @override
  final Iterable<Type> types = const [GUpdateOfferData, _$GUpdateOfferData];
  @override
  final String wireName = 'GUpdateOfferData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GUpdateOfferData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'updateOffer',
      serializers.serialize(object.updateOffer,
          specifiedType: const FullType(GUpdateOfferData_updateOffer)),
    ];

    return result;
  }

  @override
  GUpdateOfferData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateOfferDataBuilder();

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
        case 'updateOffer':
          result.updateOffer.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GUpdateOfferData_updateOffer))!
              as GUpdateOfferData_updateOffer);
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateOfferData_updateOfferSerializer
    implements StructuredSerializer<GUpdateOfferData_updateOffer> {
  @override
  final Iterable<Type> types = const [
    GUpdateOfferData_updateOffer,
    _$GUpdateOfferData_updateOffer
  ];
  @override
  final String wireName = 'GUpdateOfferData_updateOffer';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateOfferData_updateOffer object,
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
  GUpdateOfferData_updateOffer deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateOfferData_updateOfferBuilder();

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
      serializers.serialize(object.id, specifiedType: const FullType(String)),
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
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GAddNewConnectionData extends GAddNewConnectionData {
  @override
  final String G__typename;
  @override
  final GAddNewConnectionData_addNewConnection addNewConnection;

  factory _$GAddNewConnectionData(
          [void Function(GAddNewConnectionDataBuilder)? updates]) =>
      (new GAddNewConnectionDataBuilder()..update(updates))._build();

  _$GAddNewConnectionData._(
      {required this.G__typename, required this.addNewConnection})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GAddNewConnectionData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        addNewConnection, r'GAddNewConnectionData', 'addNewConnection');
  }

  @override
  GAddNewConnectionData rebuild(
          void Function(GAddNewConnectionDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAddNewConnectionDataBuilder toBuilder() =>
      new GAddNewConnectionDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAddNewConnectionData &&
        G__typename == other.G__typename &&
        addNewConnection == other.addNewConnection;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, addNewConnection.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAddNewConnectionData')
          ..add('G__typename', G__typename)
          ..add('addNewConnection', addNewConnection))
        .toString();
  }
}

class GAddNewConnectionDataBuilder
    implements Builder<GAddNewConnectionData, GAddNewConnectionDataBuilder> {
  _$GAddNewConnectionData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GAddNewConnectionData_addNewConnectionBuilder? _addNewConnection;
  GAddNewConnectionData_addNewConnectionBuilder get addNewConnection =>
      _$this._addNewConnection ??=
          new GAddNewConnectionData_addNewConnectionBuilder();
  set addNewConnection(
          GAddNewConnectionData_addNewConnectionBuilder? addNewConnection) =>
      _$this._addNewConnection = addNewConnection;

  GAddNewConnectionDataBuilder() {
    GAddNewConnectionData._initializeBuilder(this);
  }

  GAddNewConnectionDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _addNewConnection = $v.addNewConnection.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAddNewConnectionData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAddNewConnectionData;
  }

  @override
  void update(void Function(GAddNewConnectionDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAddNewConnectionData build() => _build();

  _$GAddNewConnectionData _build() {
    _$GAddNewConnectionData _$result;
    try {
      _$result = _$v ??
          new _$GAddNewConnectionData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GAddNewConnectionData', 'G__typename'),
              addNewConnection: addNewConnection.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'addNewConnection';
        addNewConnection.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GAddNewConnectionData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GAddNewConnectionData_addNewConnection
    extends GAddNewConnectionData_addNewConnection {
  @override
  final String G__typename;
  @override
  final String mapId;

  factory _$GAddNewConnectionData_addNewConnection(
          [void Function(GAddNewConnectionData_addNewConnectionBuilder)?
              updates]) =>
      (new GAddNewConnectionData_addNewConnectionBuilder()..update(updates))
          ._build();

  _$GAddNewConnectionData_addNewConnection._(
      {required this.G__typename, required this.mapId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GAddNewConnectionData_addNewConnection', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        mapId, r'GAddNewConnectionData_addNewConnection', 'mapId');
  }

  @override
  GAddNewConnectionData_addNewConnection rebuild(
          void Function(GAddNewConnectionData_addNewConnectionBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAddNewConnectionData_addNewConnectionBuilder toBuilder() =>
      new GAddNewConnectionData_addNewConnectionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAddNewConnectionData_addNewConnection &&
        G__typename == other.G__typename &&
        mapId == other.mapId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, mapId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GAddNewConnectionData_addNewConnection')
          ..add('G__typename', G__typename)
          ..add('mapId', mapId))
        .toString();
  }
}

class GAddNewConnectionData_addNewConnectionBuilder
    implements
        Builder<GAddNewConnectionData_addNewConnection,
            GAddNewConnectionData_addNewConnectionBuilder> {
  _$GAddNewConnectionData_addNewConnection? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _mapId;
  String? get mapId => _$this._mapId;
  set mapId(String? mapId) => _$this._mapId = mapId;

  GAddNewConnectionData_addNewConnectionBuilder() {
    GAddNewConnectionData_addNewConnection._initializeBuilder(this);
  }

  GAddNewConnectionData_addNewConnectionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _mapId = $v.mapId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAddNewConnectionData_addNewConnection other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAddNewConnectionData_addNewConnection;
  }

  @override
  void update(
      void Function(GAddNewConnectionData_addNewConnectionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAddNewConnectionData_addNewConnection build() => _build();

  _$GAddNewConnectionData_addNewConnection _build() {
    final _$result = _$v ??
        new _$GAddNewConnectionData_addNewConnection._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GAddNewConnectionData_addNewConnection', 'G__typename'),
            mapId: BuiltValueNullFieldError.checkNotNull(
                mapId, r'GAddNewConnectionData_addNewConnection', 'mapId'));
    replace(_$result);
    return _$result;
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

  factory _$GSendMessageData_sendMessage(
          [void Function(GSendMessageData_sendMessageBuilder)? updates]) =>
      (new GSendMessageData_sendMessageBuilder()..update(updates))._build();

  _$GSendMessageData_sendMessage._(
      {required this.G__typename, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GSendMessageData_sendMessage', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GSendMessageData_sendMessage', 'id');
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
    return (newBuiltValueToStringHelper(r'GSendMessageData_sendMessage')
          ..add('G__typename', G__typename)
          ..add('id', id))
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

  GSendMessageData_sendMessageBuilder() {
    GSendMessageData_sendMessage._initializeBuilder(this);
  }

  GSendMessageData_sendMessageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
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
    final _$result = _$v ??
        new _$GSendMessageData_sendMessage._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GSendMessageData_sendMessage', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GSendMessageData_sendMessage', 'id'));
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
  final String id;

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

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

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

class _$GUpdateOfferData extends GUpdateOfferData {
  @override
  final String G__typename;
  @override
  final GUpdateOfferData_updateOffer updateOffer;

  factory _$GUpdateOfferData(
          [void Function(GUpdateOfferDataBuilder)? updates]) =>
      (new GUpdateOfferDataBuilder()..update(updates))._build();

  _$GUpdateOfferData._({required this.G__typename, required this.updateOffer})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GUpdateOfferData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        updateOffer, r'GUpdateOfferData', 'updateOffer');
  }

  @override
  GUpdateOfferData rebuild(void Function(GUpdateOfferDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateOfferDataBuilder toBuilder() =>
      new GUpdateOfferDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateOfferData &&
        G__typename == other.G__typename &&
        updateOffer == other.updateOffer;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, updateOffer.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateOfferData')
          ..add('G__typename', G__typename)
          ..add('updateOffer', updateOffer))
        .toString();
  }
}

class GUpdateOfferDataBuilder
    implements Builder<GUpdateOfferData, GUpdateOfferDataBuilder> {
  _$GUpdateOfferData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GUpdateOfferData_updateOfferBuilder? _updateOffer;
  GUpdateOfferData_updateOfferBuilder get updateOffer =>
      _$this._updateOffer ??= new GUpdateOfferData_updateOfferBuilder();
  set updateOffer(GUpdateOfferData_updateOfferBuilder? updateOffer) =>
      _$this._updateOffer = updateOffer;

  GUpdateOfferDataBuilder() {
    GUpdateOfferData._initializeBuilder(this);
  }

  GUpdateOfferDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _updateOffer = $v.updateOffer.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateOfferData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateOfferData;
  }

  @override
  void update(void Function(GUpdateOfferDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateOfferData build() => _build();

  _$GUpdateOfferData _build() {
    _$GUpdateOfferData _$result;
    try {
      _$result = _$v ??
          new _$GUpdateOfferData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GUpdateOfferData', 'G__typename'),
              updateOffer: updateOffer.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'updateOffer';
        updateOffer.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GUpdateOfferData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateOfferData_updateOffer extends GUpdateOfferData_updateOffer {
  @override
  final String G__typename;
  @override
  final String id;

  factory _$GUpdateOfferData_updateOffer(
          [void Function(GUpdateOfferData_updateOfferBuilder)? updates]) =>
      (new GUpdateOfferData_updateOfferBuilder()..update(updates))._build();

  _$GUpdateOfferData_updateOffer._(
      {required this.G__typename, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GUpdateOfferData_updateOffer', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GUpdateOfferData_updateOffer', 'id');
  }

  @override
  GUpdateOfferData_updateOffer rebuild(
          void Function(GUpdateOfferData_updateOfferBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateOfferData_updateOfferBuilder toBuilder() =>
      new GUpdateOfferData_updateOfferBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateOfferData_updateOffer &&
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
    return (newBuiltValueToStringHelper(r'GUpdateOfferData_updateOffer')
          ..add('G__typename', G__typename)
          ..add('id', id))
        .toString();
  }
}

class GUpdateOfferData_updateOfferBuilder
    implements
        Builder<GUpdateOfferData_updateOffer,
            GUpdateOfferData_updateOfferBuilder> {
  _$GUpdateOfferData_updateOffer? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  GUpdateOfferData_updateOfferBuilder() {
    GUpdateOfferData_updateOffer._initializeBuilder(this);
  }

  GUpdateOfferData_updateOfferBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateOfferData_updateOffer other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateOfferData_updateOffer;
  }

  @override
  void update(void Function(GUpdateOfferData_updateOfferBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateOfferData_updateOffer build() => _build();

  _$GUpdateOfferData_updateOffer _build() {
    final _$result = _$v ??
        new _$GUpdateOfferData_updateOffer._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GUpdateOfferData_updateOffer', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GUpdateOfferData_updateOffer', 'id'));
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
  final String id;

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

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

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
