



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../data/providers/logistic/sim/sim_nomenclature_provider.dart';

class SimSettingNomenclature extends ConsumerWidget {
  const SimSettingNomenclature({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final nomenclature = ref.watch(simNomenclatureProvider);


    return const Placeholder();
  }
}