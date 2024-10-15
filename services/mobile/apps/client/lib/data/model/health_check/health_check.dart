import 'package:freezed_annotation/freezed_annotation.dart';

part 'health_check.freezed.dart';
part 'health_check.g.dart';

@freezed
class Healthcheck with _$Healthcheck {
  const factory Healthcheck({
    required String status,
  }) = _Healthcheck;

  // json形式で受け取るためのコードを生成するために記述
  factory Healthcheck.fromJson(Map<String, dynamic> json) =>
      _$HealthcheckFromJson(json);
}
