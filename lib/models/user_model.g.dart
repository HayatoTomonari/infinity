// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      userId: json['userId'] as String? ?? '',
      userName: json['userName'] as String? ?? '',
      teamId: json['teamId'] as String? ?? '',
      assets: json['assets'] as int? ?? 0,
      email: json['email'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'teamId': instance.teamId,
      'assets': instance.assets,
      'email': instance.email,
      'imageUrl': instance.imageUrl,
      'phone': instance.phone,
    };
