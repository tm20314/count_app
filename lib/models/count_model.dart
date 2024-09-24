import 'package:freezed_annotation/freezed_annotation.dart';

part 'count_model.freezed.dart';
part 'count_model.g.dart';

@freezed
class PersonCountData with _$PersonCountData {
  const factory PersonCountData({
    required DateTime time,
    required int count,
  }) = _PersonCountData;

  factory PersonCountData.fromJson(Map<String, dynamic> json) =>
      _$PersonCountDataFromJson(json);
}
