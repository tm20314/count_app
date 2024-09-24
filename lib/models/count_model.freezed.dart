// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'count_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PersonCountData _$PersonCountDataFromJson(Map<String, dynamic> json) {
  return _PersonCountData.fromJson(json);
}

/// @nodoc
mixin _$PersonCountData {
  DateTime get time => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;

  /// Serializes this PersonCountData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PersonCountData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PersonCountDataCopyWith<PersonCountData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PersonCountDataCopyWith<$Res> {
  factory $PersonCountDataCopyWith(
          PersonCountData value, $Res Function(PersonCountData) then) =
      _$PersonCountDataCopyWithImpl<$Res, PersonCountData>;
  @useResult
  $Res call({DateTime time, int count});
}

/// @nodoc
class _$PersonCountDataCopyWithImpl<$Res, $Val extends PersonCountData>
    implements $PersonCountDataCopyWith<$Res> {
  _$PersonCountDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PersonCountData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? count = null,
  }) {
    return _then(_value.copyWith(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PersonCountDataImplCopyWith<$Res>
    implements $PersonCountDataCopyWith<$Res> {
  factory _$$PersonCountDataImplCopyWith(_$PersonCountDataImpl value,
          $Res Function(_$PersonCountDataImpl) then) =
      __$$PersonCountDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime time, int count});
}

/// @nodoc
class __$$PersonCountDataImplCopyWithImpl<$Res>
    extends _$PersonCountDataCopyWithImpl<$Res, _$PersonCountDataImpl>
    implements _$$PersonCountDataImplCopyWith<$Res> {
  __$$PersonCountDataImplCopyWithImpl(
      _$PersonCountDataImpl _value, $Res Function(_$PersonCountDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of PersonCountData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? count = null,
  }) {
    return _then(_$PersonCountDataImpl(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PersonCountDataImpl implements _PersonCountData {
  const _$PersonCountDataImpl({required this.time, required this.count});

  factory _$PersonCountDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PersonCountDataImplFromJson(json);

  @override
  final DateTime time;
  @override
  final int count;

  @override
  String toString() {
    return 'PersonCountData(time: $time, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PersonCountDataImpl &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, time, count);

  /// Create a copy of PersonCountData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PersonCountDataImplCopyWith<_$PersonCountDataImpl> get copyWith =>
      __$$PersonCountDataImplCopyWithImpl<_$PersonCountDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PersonCountDataImplToJson(
      this,
    );
  }
}

abstract class _PersonCountData implements PersonCountData {
  const factory _PersonCountData(
      {required final DateTime time,
      required final int count}) = _$PersonCountDataImpl;

  factory _PersonCountData.fromJson(Map<String, dynamic> json) =
      _$PersonCountDataImpl.fromJson;

  @override
  DateTime get time;
  @override
  int get count;

  /// Create a copy of PersonCountData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PersonCountDataImplCopyWith<_$PersonCountDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
