// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArtistImpl _$$ArtistImplFromJson(Map<String, dynamic> json) => _$ArtistImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      isPremium: json['isPremium'] as bool? ?? false,
    );

const _$$ArtistImplFieldMap = <String, String>{
  'id': 'id',
  'name': 'name',
  'email': 'email',
  'phone': 'phone',
  'isPremium': 'isPremium',
};

// ignore: unused_element
abstract class _$$ArtistImplPerFieldToJson {
  // ignore: unused_element
  static Object? id(int instance) => instance;
  // ignore: unused_element
  static Object? name(String instance) => instance;
  // ignore: unused_element
  static Object? email(String instance) => instance;
  // ignore: unused_element
  static Object? phone(String instance) => instance;
  // ignore: unused_element
  static Object? isPremium(bool instance) => instance;
}

Map<String, dynamic> _$$ArtistImplToJson(_$ArtistImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'isPremium': instance.isPremium,
    };
