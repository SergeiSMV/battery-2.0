
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sim_same_items.freezed.dart';
part 'sim_same_items.g.dart';

@freezed
class SimSameItems with _$SimSameItems {
  const SimSameItems._();
  const factory SimSameItems({
    required Map<dynamic, dynamic> sameItem,
  }) = _SimSameItems;

  factory SimSameItems.fromJson(Map<String, dynamic> json) => _$SimSameItemsFromJson(json);

  String get info => '${sameItem['place']} ${sameItem['cell']} - ${sameItem['quantity']}';
  String get status => sameItem['status'];
  String get producer => sameItem['producer'];

}