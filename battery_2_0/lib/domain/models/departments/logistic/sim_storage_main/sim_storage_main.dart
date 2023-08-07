

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sim_storage_main.freezed.dart';
part 'sim_storage_main.g.dart';

@freezed
class SimStorageMain with _$SimStorageMain {
  const SimStorageMain._();
  const factory SimStorageMain({
    required Map<String, dynamic> elements,
  }) = _SimStorageMain;

  factory SimStorageMain.fromJson(Map<String, dynamic> json) => _$SimStorageMainFromJson(json);


  String get description => elements['description'].toString();
  String get route => elements['route'].toString();
  IconData get icon => elements['icon'];

}