// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'health_check.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Healthcheck _$HealthcheckFromJson(Map<String, dynamic> json) {
  return _Healthcheck.fromJson(json);
}

/// @nodoc
mixin _$Healthcheck {
  String get status => throw _privateConstructorUsedError;

  /// Serializes this Healthcheck to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Healthcheck
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HealthcheckCopyWith<Healthcheck> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthcheckCopyWith<$Res> {
  factory $HealthcheckCopyWith(
          Healthcheck value, $Res Function(Healthcheck) then) =
      _$HealthcheckCopyWithImpl<$Res, Healthcheck>;
  @useResult
  $Res call({String status});
}

/// @nodoc
class _$HealthcheckCopyWithImpl<$Res, $Val extends Healthcheck>
    implements $HealthcheckCopyWith<$Res> {
  _$HealthcheckCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Healthcheck
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HealthcheckImplCopyWith<$Res>
    implements $HealthcheckCopyWith<$Res> {
  factory _$$HealthcheckImplCopyWith(
          _$HealthcheckImpl value, $Res Function(_$HealthcheckImpl) then) =
      __$$HealthcheckImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status});
}

/// @nodoc
class __$$HealthcheckImplCopyWithImpl<$Res>
    extends _$HealthcheckCopyWithImpl<$Res, _$HealthcheckImpl>
    implements _$$HealthcheckImplCopyWith<$Res> {
  __$$HealthcheckImplCopyWithImpl(
      _$HealthcheckImpl _value, $Res Function(_$HealthcheckImpl) _then)
      : super(_value, _then);

  /// Create a copy of Healthcheck
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_$HealthcheckImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HealthcheckImpl implements _Healthcheck {
  const _$HealthcheckImpl({required this.status});

  factory _$HealthcheckImpl.fromJson(Map<String, dynamic> json) =>
      _$$HealthcheckImplFromJson(json);

  @override
  final String status;

  @override
  String toString() {
    return 'Healthcheck(status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthcheckImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status);

  /// Create a copy of Healthcheck
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthcheckImplCopyWith<_$HealthcheckImpl> get copyWith =>
      __$$HealthcheckImplCopyWithImpl<_$HealthcheckImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HealthcheckImplToJson(
      this,
    );
  }
}

abstract class _Healthcheck implements Healthcheck {
  const factory _Healthcheck({required final String status}) =
      _$HealthcheckImpl;

  factory _Healthcheck.fromJson(Map<String, dynamic> json) =
      _$HealthcheckImpl.fromJson;

  @override
  String get status;

  /// Create a copy of Healthcheck
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HealthcheckImplCopyWith<_$HealthcheckImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
