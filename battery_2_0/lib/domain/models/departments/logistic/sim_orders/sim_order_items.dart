
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sim_order_items.freezed.dart';
part 'sim_order_items.g.dart';

@freezed
class SimOrderItems with _$SimOrderItems {
  const SimOrderItems._();
  const factory SimOrderItems({
    required Map<dynamic, dynamic> item,
  }) = _SimOrderItems;

  factory SimOrderItems.fromJson(Map<String, dynamic> json) => _$SimOrderItemsFromJson(json);

  String get name => '${item['category']} ${item['name']} ${item['color']}';
  int get id => item['item_id'];
  String get producer => item['producer'];
  String get place => item['place'];
  String get cell => item['cell'];
  int get quantity => item['quantity'];
  String get unit => item['unit'];
  int get status => item['status'];
  String get comment => item['comment'];
  String get extradition => item['fact_quant'] == 0 ? '' : item['fact_quant'].toString();
  

}