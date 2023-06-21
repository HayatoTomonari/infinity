import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_model.freezed.dart';
part 'team_model.g.dart';

@freezed
class TeamModel with _$TeamModel {
  const factory TeamModel({
    @Default('') String teamName,
    @Default('') String description,
    @Default('') String imageUrl,
    @Default(0) int assets,
    @Default(0) int goalAmount,
    @Default(0) int monthDeposit,
    @Default(0) int recruitmentNumbers,
    @Default(true) bool isPublic,
    @DateTimeConverter() startDate,
  }) = _TeamModel;

  factory TeamModel.fromJson(Map<String, dynamic> json) => _$TeamModelFromJson(json);
}

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String json) {
    return DateTime.parse(json).toLocal();
  }

  @override
  String toJson(DateTime dateTime) {
    return dateTime.toLocal().toString();
  }
}