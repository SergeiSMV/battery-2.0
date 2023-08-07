
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sim_items.freezed.dart';
part 'sim_items.g.dart';

@freezed
class SimItems with _$SimItems {
  const SimItems._();
  const factory SimItems({
    required Map<dynamic, dynamic> item,
  }) = _SimItems;

  factory SimItems.fromJson(Map<String, dynamic> json) => _$SimItemsFromJson(json);

  String get id => item['itemId'].toString();
  String get place => item['place'].toString();
  String get cell => item['cell'].toString();
  String get category => item['category'].toString();
  String get fullName => item['fullName'].toString();
  String get name => item['name'].toString();
  String get color => item['color'].toString();
  String get producer => item['producer'].toString();
  int get quantity => item['quantity'];
  int get reserve => item['reserve'];
  String get unit => item['unit'].toString();
  String get fifo => item['fifo'].toString();
  DateTime get date => item['date'];
  String get author => item['author'].toString();
  String get status => item['status'];
  List get comment => item['comment'];
  String get palletSize => item['pallet_size'].toString();
  List get images => item['images'];
  

}