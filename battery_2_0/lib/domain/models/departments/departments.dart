








import 'package:freezed_annotation/freezed_annotation.dart';

part 'departments.freezed.dart';
part 'departments.g.dart';

@freezed
class Departments with _$Departments {
  const Departments._();
  const factory Departments({
    required Map<String, dynamic> departments,
  }) = _Departments;

  factory Departments.fromJson(Map<String, dynamic> json) => _$DepartmentsFromJson(json);


  String get description => departments['description'].toString();
  String get route => departments['route'].toString();

}