
import 'package:battery_2_0/domain/models/accesses/accesses.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


import '../../../domain/repository/departments/accesses_names.dart';
import '../../../domain/repository/departments/logistic/sim_storage_repo.dart';

class SimStorageImpl extends SimStorageRepository{
  
  // меню склада сырья и материалов
  @override
  List simStorageMain(Accesses? allAccesses, String depence) {
    List sim = [];

    var catalog = {'description': 'каталог', 'route': '/logistic/sim/catalog', 'icon': MdiIcons.bookOpenPageVariantOutline,};
    var identification = {'description': 'идентификация', 'route': '/logistic/sim/identification', 'icon': MdiIcons.qrcode,};

    sim.add(catalog);
    sim.add(identification);

    for (var dp in allAccesses!.accessesList) {
      dp['depence'] == depence && dp['chapter'] == simOrders ? {
        dp['route'] = '/logistic/sim/orders',
        dp['description'] = 'заявки',
        dp['icon'] = MdiIcons.fileDocumentOutline,
        sim.add(dp)
      } : null;
      dp['depence'] == depence && dp['chapter'] == simAdmission ? {
        dp['route'] = '/logistic/sim/admission', 
        dp['description'] = 'поступление',
        dp['icon'] = 'fileDocumentOutline',
        dp['icon'] = MdiIcons.packageVariantClosedPlus,
        sim.add(dp)
      } : null;

    }

    return sim;
  }
}