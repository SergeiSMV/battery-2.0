
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../departments/logistic/sim_items_impl.dart';



final simNomenclatureProvider = FutureProvider.autoDispose<List>((ref) async {
  List selectedItemPack = await SimItemsImpl().getNomenclature();
  return selectedItemPack;
});
