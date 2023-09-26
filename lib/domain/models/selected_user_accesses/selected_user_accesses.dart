
import 'package:freezed_annotation/freezed_annotation.dart';

part 'selected_user_accesses.freezed.dart';
part 'selected_user_accesses.g.dart';

@freezed
class SelectedUserAccesses with _$SelectedUserAccesses {
  const SelectedUserAccesses._();
  const factory SelectedUserAccesses({
    required Map<String, dynamic> userAccesses,
  }) = _SelectedUserAccesses;

  factory SelectedUserAccesses.fromJson(Map<String, dynamic> json) => _$SelectedUserAccessesFromJson(json);

  String get rowId => userAccesses['row_id'].toString();
  String get chapter => userAccesses['chapter'].toString();
  String get department => userAccesses['department'].toString();
  String get depence => userAccesses['depence'].toString();
  String get description => userAccesses['description'].toString();
  String get access => userAccesses['access'];

}