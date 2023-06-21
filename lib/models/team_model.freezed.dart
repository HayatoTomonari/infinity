// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TeamModel _$TeamModelFromJson(Map<String, dynamic> json) {
  return _TeamModel.fromJson(json);
}

/// @nodoc
mixin _$TeamModel {
  String get teamName => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  int get assets => throw _privateConstructorUsedError;
  int get goalAmount => throw _privateConstructorUsedError;
  int get monthDeposit => throw _privateConstructorUsedError;
  int get recruitmentNumbers => throw _privateConstructorUsedError;
  bool get isPublic => throw _privateConstructorUsedError;
  @DateTimeConverter()
  dynamic get startDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TeamModelCopyWith<TeamModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamModelCopyWith<$Res> {
  factory $TeamModelCopyWith(TeamModel value, $Res Function(TeamModel) then) =
      _$TeamModelCopyWithImpl<$Res, TeamModel>;
  @useResult
  $Res call(
      {String teamName,
      String description,
      String imageUrl,
      int assets,
      int goalAmount,
      int monthDeposit,
      int recruitmentNumbers,
      bool isPublic,
      @DateTimeConverter() dynamic startDate});
}

/// @nodoc
class _$TeamModelCopyWithImpl<$Res, $Val extends TeamModel>
    implements $TeamModelCopyWith<$Res> {
  _$TeamModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamName = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? assets = null,
    Object? goalAmount = null,
    Object? monthDeposit = null,
    Object? recruitmentNumbers = null,
    Object? isPublic = null,
    Object? startDate = freezed,
  }) {
    return _then(_value.copyWith(
      teamName: null == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      assets: null == assets
          ? _value.assets
          : assets // ignore: cast_nullable_to_non_nullable
              as int,
      goalAmount: null == goalAmount
          ? _value.goalAmount
          : goalAmount // ignore: cast_nullable_to_non_nullable
              as int,
      monthDeposit: null == monthDeposit
          ? _value.monthDeposit
          : monthDeposit // ignore: cast_nullable_to_non_nullable
              as int,
      recruitmentNumbers: null == recruitmentNumbers
          ? _value.recruitmentNumbers
          : recruitmentNumbers // ignore: cast_nullable_to_non_nullable
              as int,
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TeamModelCopyWith<$Res> implements $TeamModelCopyWith<$Res> {
  factory _$$_TeamModelCopyWith(
          _$_TeamModel value, $Res Function(_$_TeamModel) then) =
      __$$_TeamModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String teamName,
      String description,
      String imageUrl,
      int assets,
      int goalAmount,
      int monthDeposit,
      int recruitmentNumbers,
      bool isPublic,
      @DateTimeConverter() dynamic startDate});
}

/// @nodoc
class __$$_TeamModelCopyWithImpl<$Res>
    extends _$TeamModelCopyWithImpl<$Res, _$_TeamModel>
    implements _$$_TeamModelCopyWith<$Res> {
  __$$_TeamModelCopyWithImpl(
      _$_TeamModel _value, $Res Function(_$_TeamModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamName = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? assets = null,
    Object? goalAmount = null,
    Object? monthDeposit = null,
    Object? recruitmentNumbers = null,
    Object? isPublic = null,
    Object? startDate = freezed,
  }) {
    return _then(_$_TeamModel(
      teamName: null == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      assets: null == assets
          ? _value.assets
          : assets // ignore: cast_nullable_to_non_nullable
              as int,
      goalAmount: null == goalAmount
          ? _value.goalAmount
          : goalAmount // ignore: cast_nullable_to_non_nullable
              as int,
      monthDeposit: null == monthDeposit
          ? _value.monthDeposit
          : monthDeposit // ignore: cast_nullable_to_non_nullable
              as int,
      recruitmentNumbers: null == recruitmentNumbers
          ? _value.recruitmentNumbers
          : recruitmentNumbers // ignore: cast_nullable_to_non_nullable
              as int,
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      startDate: freezed == startDate ? _value.startDate! : startDate,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TeamModel with DiagnosticableTreeMixin implements _TeamModel {
  const _$_TeamModel(
      {this.teamName = '',
      this.description = '',
      this.imageUrl = '',
      this.assets = 0,
      this.goalAmount = 0,
      this.monthDeposit = 0,
      this.recruitmentNumbers = 0,
      this.isPublic = true,
      @DateTimeConverter() this.startDate});

  factory _$_TeamModel.fromJson(Map<String, dynamic> json) =>
      _$$_TeamModelFromJson(json);

  @override
  @JsonKey()
  final String teamName;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String imageUrl;
  @override
  @JsonKey()
  final int assets;
  @override
  @JsonKey()
  final int goalAmount;
  @override
  @JsonKey()
  final int monthDeposit;
  @override
  @JsonKey()
  final int recruitmentNumbers;
  @override
  @JsonKey()
  final bool isPublic;
  @override
  @DateTimeConverter()
  final dynamic startDate;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TeamModel(teamName: $teamName, description: $description, imageUrl: $imageUrl, assets: $assets, goalAmount: $goalAmount, monthDeposit: $monthDeposit, recruitmentNumbers: $recruitmentNumbers, isPublic: $isPublic, startDate: $startDate)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TeamModel'))
      ..add(DiagnosticsProperty('teamName', teamName))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('imageUrl', imageUrl))
      ..add(DiagnosticsProperty('assets', assets))
      ..add(DiagnosticsProperty('goalAmount', goalAmount))
      ..add(DiagnosticsProperty('monthDeposit', monthDeposit))
      ..add(DiagnosticsProperty('recruitmentNumbers', recruitmentNumbers))
      ..add(DiagnosticsProperty('isPublic', isPublic))
      ..add(DiagnosticsProperty('startDate', startDate));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TeamModel &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.assets, assets) || other.assets == assets) &&
            (identical(other.goalAmount, goalAmount) ||
                other.goalAmount == goalAmount) &&
            (identical(other.monthDeposit, monthDeposit) ||
                other.monthDeposit == monthDeposit) &&
            (identical(other.recruitmentNumbers, recruitmentNumbers) ||
                other.recruitmentNumbers == recruitmentNumbers) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            const DeepCollectionEquality().equals(other.startDate, startDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      teamName,
      description,
      imageUrl,
      assets,
      goalAmount,
      monthDeposit,
      recruitmentNumbers,
      isPublic,
      const DeepCollectionEquality().hash(startDate));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TeamModelCopyWith<_$_TeamModel> get copyWith =>
      __$$_TeamModelCopyWithImpl<_$_TeamModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TeamModelToJson(
      this,
    );
  }
}

abstract class _TeamModel implements TeamModel {
  const factory _TeamModel(
      {final String teamName,
      final String description,
      final String imageUrl,
      final int assets,
      final int goalAmount,
      final int monthDeposit,
      final int recruitmentNumbers,
      final bool isPublic,
      @DateTimeConverter() final dynamic startDate}) = _$_TeamModel;

  factory _TeamModel.fromJson(Map<String, dynamic> json) =
      _$_TeamModel.fromJson;

  @override
  String get teamName;
  @override
  String get description;
  @override
  String get imageUrl;
  @override
  int get assets;
  @override
  int get goalAmount;
  @override
  int get monthDeposit;
  @override
  int get recruitmentNumbers;
  @override
  bool get isPublic;
  @override
  @DateTimeConverter()
  dynamic get startDate;
  @override
  @JsonKey(ignore: true)
  _$$_TeamModelCopyWith<_$_TeamModel> get copyWith =>
      throw _privateConstructorUsedError;
}
