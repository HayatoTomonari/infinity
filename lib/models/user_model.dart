import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @Default('') String userId,
    @Default('') String userName,
    @Default('') String teamId,
    @Default(0) int assets,
    @Default('') String email,
    @Default('') String imageUrl,
    @Default('') String phone,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}