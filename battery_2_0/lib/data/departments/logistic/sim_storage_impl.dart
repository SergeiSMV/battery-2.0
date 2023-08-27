
import 'package:battery_2_0/domain/models/accesses/accesses.dart';
import 'package:battery_2_0/presentation/widgets/logistic/sim_storage/coming/barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


import '../../../domain/repository/departments/accesses_names.dart';
import '../../../domain/repository/departments/logistic/sim_storage_repo.dart';
import '../../../domain/repository/server/sim.dart';
import '../../../presentation/view/logistic/sim_storage/selected_item/selected_item.dart';
import '../../server/connect_impl.dart';

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
      dp['depence'] == depence && dp['chapter'] == simComing ? {
        dp['route'] = '/logistic/sim/coming', 
        dp['description'] = 'поступление',
        dp['icon'] = 'fileDocumentOutline',
        dp['icon'] = MdiIcons.packageVariantClosedPlus,
        sim.add(dp)
      } : null;

    }

    return sim;
  }


  // КНОПКА настройки склада (проверка доступа)
  @override
  bool storageSettingButton(Accesses? allAccesses) {
    bool settingAccess = false;
    const String dependence = 'склад сырья и материалов';
    for (var dp in allAccesses!.accessesList) {
      dp['depence'] == dependence && dp['chapter'] == simSetting ? settingAccess = true : null;
    }
    return settingAccess;
  }


  // роутер настроек склада
  @override
  void settingRouter(BuildContext context, String route) {
    null;
  }


  // идетификация ТМЦ
  @override
  Widget simItemsIdentify(BuildContext context) {
    final messenger = ScaffoldMessenger.of(context);
    return barcodeScanner(context).then((itemId) async {
      itemId == null ? messenger._toast('ничего не найдено') : {
        await ConnectionImpl().request(simItemDelPhoto, {'item_id': itemId}).then((value) async {
          value == 0 ? messenger._toast('ничего не найдено') :
          Navigator.push(context, MaterialPageRoute(builder: (context) => SelectedItem(itemId: itemId, mainContext: context,)));
        })
      };
    });
  }




}


extension on ScaffoldMessengerState {
  void _toast(String message){
    showSnackBar(
      SnackBar(
        content: Text(message), 
        duration: const Duration(seconds: 4),
      )
    );
  }
}