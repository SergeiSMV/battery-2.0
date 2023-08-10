

import 'package:battery_2_0/presentation/widgets/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:lottie/lottie.dart';

import '../../../../../data/departments/logistic/sim_items_impl.dart';

simDeleteAlertDialog(BuildContext simCatalogContext, String id, String palletSize){
  return showDialog(
    context: simCatalogContext,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100, width: 100, child: Lottie.asset('lib/images/lottie/alert.json')),
            Center(child: Text('Вы уверены, что хотите удалить позицию? Данное действие невозможно будет отменить!', style: firm14, textAlign: TextAlign.center),),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    final messenger = ScaffoldMessenger.of(simCatalogContext);
                    final progress = ProgressHUD.of(simCatalogContext);
                    progress?.showWithText('удаляем');
                    String deleteResult = await SimItemsImpl().deleteItem(id, palletSize);
                    progress?.dismiss();
                    deleteResult == 'done' ? messenger.toast('удалено') : messenger.toast(deleteResult);
                  }, 
                  child: Text('удалить', style: red16,)
                ),
                const SizedBox(width: 20,),
                TextButton(onPressed: (){ Navigator.pop(context); }, child: Text('отмена', style: firm16,)),
              ],
            )
          ],
        ),
      );
    });
  }


  extension on ScaffoldMessengerState {
  void toast(String message){
    showSnackBar(
      SnackBar(
        content: Text(message, style: white16,), 
        duration: const Duration(seconds: 4),
      )
    );
  }
}