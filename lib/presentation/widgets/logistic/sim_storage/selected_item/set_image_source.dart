import 'package:battery_2_0/presentation/widgets/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../../data/departments/logistic/sim_items_impl.dart';
import '../../../app_colors.dart';



setImageSource(BuildContext motherContext, Map itemData){

  final messenger = ScaffoldMessenger.of(motherContext);

  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: motherContext, 
    builder: (context){
      return Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
          color: Colors.white
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            const SizedBox(height: 20),
            Text('выберите источник изображения', style: firm16, textAlign: TextAlign.center,),
            const SizedBox(height: 5),

            Divider(color: firmColor, indent: 30, endIndent: 30,),
            
            Flexible(
              child: Container(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton.icon(
                      onPressed: () async { 
                        ProgressHUD.of(motherContext)?.showWithText('сохраняем фото');
                        await SimItemsImpl().savePhoto(itemData, ImageSource.gallery).then((value) {
                          ProgressHUD.of(motherContext)?.dismiss();
                          value == 'done' ? messenger.toast('изображение сохранено') : messenger.toast(value);
                          Navigator.pop(context);
                        });
                      }, 
                      icon: Icon(MdiIcons.folderImage, color: firmColor, size: 25,),
                      label: Text('галерея', style: firm14,),
                    ),
                    TextButton.icon(
                      onPressed: () async { 
                        ProgressHUD.of(motherContext)?.showWithText('сохраняем фото');
                        await SimItemsImpl().savePhoto(itemData, ImageSource.camera).then((value) {
                          ProgressHUD.of(motherContext)?.dismiss();
                          value == 'done' ? messenger.toast('изображение сохранено') : messenger.toast(value);
                          Navigator.pop(context);
                        });
                      }, 
                      icon: Icon(MdiIcons.camera, color: firmColor, size: 25,),
                      label: Text('камера', style: firm14,),
                    ),
                  ],
                )
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    }
  );
}


extension on ScaffoldMessengerState {
  void toast(String message){
    showSnackBar(
      SnackBar(
        content: Text(message), 
        duration: const Duration(seconds: 5),
      )
    );
  }
}