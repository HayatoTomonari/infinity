// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TeamModel _$$_TeamModelFromJson(Map<String, dynamic> json) => _$_TeamModel(
      teamId: json['teamId'] as String? ?? '',
      teamName: json['teamName'] as String? ?? '',
      assets: json['assets'] as int? ?? 0,
      imageUrl: json['imageUrl'] as String? ?? '',
    );

Map<String, dynamic> _$$_TeamModelToJson(_$_TeamModel instance) =>
    <String, dynamic>{
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'assets': instance.assets,
      'imageUrl': instance.imageUrl,
    };
