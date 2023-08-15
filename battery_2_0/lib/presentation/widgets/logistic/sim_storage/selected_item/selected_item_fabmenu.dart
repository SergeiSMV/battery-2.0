// ignore_for_file: avoid_print

import 'package:battery_2_0/presentation/widgets/app_text_styles.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../app_colors.dart';
import 'sim_del_alertdialog.dart';

// удаление позиции
Widget delItem(BuildContext context, Map itemData){
  return Row(
    children: [
      Bubble(
        color: Colors.grey.shade700.withOpacity(0.9),
        nip: BubbleNip.rightTop,
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 1, bottom: 1),
          child: Text('удалить позицию', style: white14,),
        ),
      ),
      const SizedBox(width: 5,),
      FloatingActionButton(
        elevation: 3.0,
        backgroundColor: Colors.red,
        heroTag: 'delItems',
        onPressed: (){ simDeleteAlertDialog(context, itemData); },
        child: Icon(MdiIcons.deleteForever, color: Colors.white, size: 25,),
      ),
    ],
  );
}


// редактирование позиции
Widget itemEdit(BuildContext context, Map itemData, Function refresh){
  return Row(
    children: [
      Bubble(
        color: Colors.grey.shade700.withOpacity(0.9),
        nip: BubbleNip.rightTop,
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 1, bottom: 1),
          child: Text('редактировать', style: white14,),
        ),
      ),
      const SizedBox(width: 5,),
      FloatingActionButton(
        elevation: 3.0,
        backgroundColor: firmColor.withOpacity(0.7),
        heroTag: 'itemEdit',
        onPressed: (){ context.pushNamed('selected_item_edit', extra: itemData).then((_){ refresh(); }); }, 
        child: Icon(MdiIcons.squareEditOutline, color: Colors.white, size: 25,),
      ),
    ],
  );
}


// перемещение позиции
Widget itemMoving(){
  return Row(
    children: [
      Bubble(
        color: Colors.grey.shade700.withOpacity(0.9),
        nip: BubbleNip.rightTop,
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 1, bottom: 1),
          child: Text('переместить', style: white14,),
        ),
      ),
      const SizedBox(width: 5,),
      FloatingActionButton(
        elevation: 3.0,
        backgroundColor: firmColor.withOpacity(0.7),
        heroTag: 'itemMoving',
        onPressed: (){ print('TAP the itemMoving'); },
        child: Icon(MdiIcons.arrowDecision, color: Colors.white, size: 25,),
      ),
    ],
  );
}



// изменение статуса позиции
Widget itemStatus(){
  return Row(
    children: [
      Bubble(
        color: Colors.grey.shade700.withOpacity(0.9),
        nip: BubbleNip.rightTop,
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 1, bottom: 1),
          child: Text('статус', style: white14,),
        ),
      ),
      const SizedBox(width: 5,),
      FloatingActionButton(
        elevation: 3.0,
        backgroundColor: firmColor.withOpacity(0.7),
        heroTag: 'itemStatus',
        onPressed: (){ print('TAP the itemStatus'); },
        child: Icon(MdiIcons.alertRhombus, color: Colors.white, size: 25,),
      ),
    ],
  );
}

// добавление фото позиции
Widget itemAddPhoto(){
  return Row(
    children: [
      Bubble(
        color: Colors.grey.shade700.withOpacity(0.9),
        nip: BubbleNip.rightTop,
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 1, bottom: 1),
          child: Text('фото', style: white14,),
        ),
      ),
      const SizedBox(width: 5,),
      FloatingActionButton(
        elevation: 3.0,
        backgroundColor: firmColor.withOpacity(0.7),
        heroTag: 'itemAddPhoto',
        onPressed: (){ print('TAP the itemAddPhoto'); },
        child: Icon(MdiIcons.cameraPlus, color: Colors.white, size: 25,),
      ),
    ],
  );
}

// история движения позиции
Widget itemHistory(){
  return Row(
    children: [
      Bubble(
        color: Colors.grey.shade700.withOpacity(0.9),
        nip: BubbleNip.rightTop,
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 1, bottom: 1),
          child: Text('история', style: white14,),
        ),
      ),
      const SizedBox(width: 5,),
      FloatingActionButton(
        elevation: 3.0,
        backgroundColor: firmColor.withOpacity(0.7),
        heroTag: 'itemHistory',
        onPressed: (){ print('TAP the itemHistory'); },
        child: Icon(MdiIcons.history, color: Colors.white, size: 25,),
      ),
    ],
  );
}

