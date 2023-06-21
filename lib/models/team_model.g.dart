// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TeamModel _$$_TeamModelFromJson(Map<String, dynamic> json) => _$_TeamModel(
      teamName: json['teamName'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      assets: json['assets'] as int? ?? 0,
      goalAmount: json['goalAmount'] as int? ?? 0,
      monthDeposit: json['monthDeposit'] as int? ?? 0,
      recruitmentNumbers: json['recruitmentNumbers'] as int? ?? 0,
      isPublic: json['isPublic'] as bool? ?? true,
      startDate: json['startDate'],
    );

Map<String, dynamic> _$$_TeamModelToJson(_$_TeamModel instance) =>
    <String, dynamic>{
      'teamName': instance.teamName,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'assets': instance.assets,
      'goalAmount': instance.goalAmount,
      'monthDeposit': instance.monthDeposit,
      'recruitmentNumbers': instance.recruitmentNumbers,
      'isPublic': instance.isPublic,
      'startDate': instance.startDate,
    };
