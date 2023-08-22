

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../departments/logistic/sim_items_impl.dart';



final simSelectedItemProvider = FutureProvider.autoDispose.family<Map, String>((ref, id) async {
  Map selectedItemPack = await SimItemsImpl().selectedItem(id);
  ref.onDispose(() { imageCache.clear(); });
  return selectedItemPack;
});
