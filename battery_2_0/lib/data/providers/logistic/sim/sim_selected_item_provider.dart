

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../departments/logistic/sim_storage_impl.dart';



final simSelectedItemProvider = FutureProvider.autoDispose.family<Map, String>((ref, id) async {
  Map selectedItemPack = await SimStorageImpl().selectedItem(id);
  ref.onDispose(() { });
  return selectedItemPack;
});
