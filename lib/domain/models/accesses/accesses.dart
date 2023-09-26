





import 'package:freezed_annotation/freezed_annotation.dart';

part 'accesses.freezed.dart';
part 'accesses.g.dart';

@freezed
class Accesses with _$Accesses {
  const Accesses._();
  const factory Accesses({
    required List accessesList,
  }) = _Accesses;

  factory Accesses.fromJson(Map<String, dynamic> json) => _$AccessesFromJson(json);


}