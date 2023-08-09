import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../widgets/app_colors.dart';
import '../../../../widgets/app_text_styles.dart';

// удаление позиции
final Widget delItem = Container(
  height: 40,
  width: 170,
  decoration: BoxDecoration(color: Colors.red, shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10)),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      const SizedBox(width: 10,),
      Icon(MdiIcons.deleteForever, color: Colors.white,),
      const Expanded(child: SizedBox(width: 10,)),
      Text('удалить', style: white14),
      const SizedBox(width: 10,),
    ],
  ),
);

// перемещение позиции
final Widget itemMoving = Container(
  height: 40,
  width: 170,
  decoration: BoxDecoration(color: firmColor.withOpacity(0.7), shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10)),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      const SizedBox(width: 10,),
      Icon(MdiIcons.arrowRightCircle, color: Colors.white,),
      const Expanded(child: SizedBox(width: 10,)),
      Text('переместить', style: white14),
      const SizedBox(width: 10,),
    ],
  ),
);

// редактирование позиции
final Widget itemEdit = Container(
  height: 40,
  width: 170,
  decoration: BoxDecoration(color: firmColor.withOpacity(0.7), shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10)),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      const SizedBox(width: 10,),
      Icon(MdiIcons.fileEdit, color: Colors.white,),
      const Expanded(child: SizedBox(width: 10,)),
      Text('редактировать', style: white14),
      const SizedBox(width: 10,),
    ],
  ),
);

// изменение статуса позиции
final Widget itemStatus = Container(
  height: 40,
  width: 170,
  decoration: BoxDecoration(color: firmColor.withOpacity(0.7), shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10)),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      const SizedBox(width: 10,),
      Icon(MdiIcons.pauseOctagon, color: Colors.white,),
      const Expanded(child: SizedBox(width: 10,)),
      Text('статус', style: white14),
      const SizedBox(width: 10,),
    ],
  ),
);

// добавление фото позиции
final Widget itemAddPhoto = Container(
  height: 40,
  width: 170,
  decoration: BoxDecoration(color: firmColor.withOpacity(0.7), shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10)),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      const SizedBox(width: 10,),
      Icon(MdiIcons.imagePlus, color: Colors.white,),
      const Expanded(child: SizedBox(width: 10,)),
      Text('фото', style: white14),
      const SizedBox(width: 10,),
    ],
  ),
);

// история движения позиции
final Widget itemHistory = Container(
  height: 40,
  width: 170,
  decoration: BoxDecoration(color: firmColor.withOpacity(0.7), shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10)),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      const SizedBox(width: 10,),
      Icon(MdiIcons.clipboardTextClock, color: Colors.white,),
      const Expanded(child: SizedBox(width: 10,)),
      Text('история', style: white14),
      const SizedBox(width: 10,),
    ],
  ),
);