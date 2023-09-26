
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sim_coming.freezed.dart';
part 'sim_coming.g.dart';

@freezed
class SimComing with _$SimComing {
  const SimComing._();
  const factory SimComing({
    required Map<dynamic, dynamic> item,
  }) = _SimComing;

  factory SimComing.fromJson(Map<String, dynamic> json) => _$SimComingFromJson(json);

  String get category => item['category'].toString();
  String get name => item['name'].toString();
  String get color => item['color'].toString();
  String get producer => item['producer'].toString();
  String get barcode => item['barcode'].toString();
  String get quantity => item['quantity'].toString();
  String get unit => item['unit'].toString();
  String get place => item['place'].toString();
  String get cell => item['cell'].toString();
  String get fifo => item['fifo'].toString();
  String get author => item['author'].toString();
  String get palletSize => item['pallet_size'].toString();
  String get palletHeight => item['pallet_height'].toString();

}