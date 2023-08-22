

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../departments/logistic/sim_items_impl.dart';



final simSelectedItemHistoryProvider = FutureProvider.autoDispose.family<List, String>((ref, id) async {
  List selectedItemHistory = await SimItemsImpl().getHistory(id);
  ref.onDispose(() {  });
  return selectedItemHistory;
});
