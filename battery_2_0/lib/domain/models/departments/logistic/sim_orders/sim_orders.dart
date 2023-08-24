
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sim_orders.freezed.dart';
part 'sim_orders.g.dart';

@freezed
class SimOrders with _$SimOrders {
  const SimOrders._();
  const factory SimOrders({
    required Map<dynamic, dynamic> orders,
  }) = _SimOrders;

  factory SimOrders.fromJson(Map<String, dynamic> json) => _$SimOrdersFromJson(json);

  String get num => orders['num'].toString();
  String get date => orders['date'].toString();
  String get time => orders['time'].toString();
  String get customer => orders['customer'].toString();
  int get status => orders['status'];
  DateTime get dateFormat => orders['dateFormat'];
  

}