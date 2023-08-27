
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../departments/logistic/sim_nomenclature_impl.dart';



final simNomenclatureProvider = FutureProvider.autoDispose<List>((ref) async {
  List selectedItemPack = await SimNomenclatureImpl().getNomenclature();
  return selectedItemPack;
});
