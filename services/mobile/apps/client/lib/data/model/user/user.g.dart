// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      email: json['email'] as String,
      fsp: (json['fsp'] as num).toInt(),
      isAdmin: json['isAdmin'] as bool? ?? false,
    );

const _$$UserImplFieldMap = <String, String>{
  'id': 'id',
  'username': 'username',
  'email': 'email',
  'fsp': 'fsp',
  'isAdmin': 'isAdmin',
};

// ignore: unused_element
abstract class _$$UserImplPerFieldToJson {
  // ignore: unused_element
  static Object? id(int instance) => instance;
  // ignore: unused_element
  static Object? username(String instance) => instance;
  // ignore: unused_element
  static Object? email(String instance) => instance;
  // ignore: unused_element
  static Object? fsp(int instance) => instance;
  // ignore: unused_element
  static Object? isAdmin(bool instance) => instance;
}

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'fsp': instance.fsp,
      'isAdmin': instance.isAdmin,
    };
