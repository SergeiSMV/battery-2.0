// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../widgets/app_colors.dart';

// удаление позиции
Widget delItem(){
  return FloatingActionButton(
    elevation: 3.0,
    backgroundColor: Colors.red,
    heroTag: 'delItems',
    onPressed: (){ print('TAP the delItems'); },
    child: Icon(MdiIcons.deleteForever, color: Colors.white, size: 30,),
    // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    // icon: Icon(MdiIcons.deleteForever, color: Colors.white,),
    // label: Text('удалить', style: white14),
  );
}
// final Widget delItem = Container(
//   height: 40,
//   width: 170,
//   decoration: BoxDecoration(color: Colors.red, shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10)),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.end,
//     children: [
//       const SizedBox(width: 10,),
//       Icon(MdiIcons.deleteForever, color: Colors.white,),
//       const Expanded(child: SizedBox(width: 10,)),
//       Text('удалить', style: white14),
//       const SizedBox(width: 10,),
//     ],
//   ),
// );


// перемещение позиции
Widget itemMoving(){
  return FloatingActionButton(
    elevation: 3.0,
    backgroundColor: firmColor.withOpacity(0.7),
    heroTag: 'itemMoving',
    onPressed: (){ print('TAP the itemMoving'); },
    child: Icon(MdiIcons.arrowDecision, color: Colors.white, size: 30,),
    // label: Text('переместить', style: white14),
    // icon: Icon(MdiIcons.arrowRightCircle, color: Colors.white,),
    // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );
}
// final Widget itemMoving = Container(
//   height: 40,
//   width: 170,
//   decoration: BoxDecoration(color: firmColor.withOpacity(0.7), shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10)),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.end,
//     children: [
//       const SizedBox(width: 10,),
//       Icon(MdiIcons.arrowRightCircle, color: Colors.white,),
//       const Expanded(child: SizedBox(width: 10,)),
//       Text('переместить', style: white14),
//       const SizedBox(width: 10,),
//     ],
//   ),
// );


// редактирование позиции
Widget itemEdit(){
  return FloatingActionButton(
    elevation: 3.0,
    backgroundColor: firmColor.withOpacity(0.7),
    heroTag: 'itemEdit',
    onPressed: (){ print('TAP the itemEdit'); }, 
    child: Icon(MdiIcons.squareEditOutline, color: Colors.white, size: 30,),
    // label: Text('редактировать', style: white14),
    // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    // icon: Icon(MdiIcons.fileEdit, color: Colors.white,),
  );
}
// final Widget itemEdit = Container(
//   height: 40,
//   width: 170,
//   decoration: BoxDecoration(color: firmColor.withOpacity(0.7), shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10)),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.end,
//     children: [
//       const SizedBox(width: 10,),
//       Icon(MdiIcons.fileEdit, color: Colors.white,),
//       const Expanded(child: SizedBox(width: 10,)),
//       Text('редактировать', style: white14),
//       const SizedBox(width: 10,),
//     ],
//   ),
// );


// изменение статуса позиции
Widget itemStatus(){
  return FloatingActionButton(
    elevation: 3.0,
    backgroundColor: firmColor.withOpacity(0.7),
    heroTag: 'itemStatus',
    onPressed: (){ print('TAP the itemStatus'); },
    child: Icon(MdiIcons.alertRhombus, color: Colors.white, size: 30,),
    // label: Text('статус', style: white14),
    // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    // icon: Icon(MdiIcons.pauseOctagon, color: Colors.white,),
  );
}
// final Widget itemStatus = Container(
//   height: 40,
//   width: 170,
//   decoration: BoxDecoration(color: firmColor.withOpacity(0.7), shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10)),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.end,
//     children: [
//       const SizedBox(width: 10,),
//       Icon(MdiIcons.pauseOctagon, color: Colors.white,),
//       const Expanded(child: SizedBox(width: 10,)),
//       Text('статус', style: white14),
//       const SizedBox(width: 10,),
//     ],
//   ),
// );


// добавление фото позиции
Widget itemAddPhoto(){
  return FloatingActionButton(
    elevation: 3.0,
    backgroundColor: firmColor.withOpacity(0.7),
    heroTag: 'itemAddPhoto',
    onPressed: (){ print('TAP the itemAddPhoto'); },
    child: Icon(MdiIcons.cameraPlus, color: Colors.white, size: 30,),
    // label: Text('фото', style: white14),
    // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    // icon: Icon(MdiIcons.imagePlus, color: Colors.white,),
  );
}
// final Widget itemAddPhoto = Container(
//   height: 40,
//   width: 170,
//   decoration: BoxDecoration(color: firmColor.withOpacity(0.7), shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10)),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.end,
//     children: [
//       const SizedBox(width: 10,),
//       Icon(MdiIcons.imagePlus, color: Colors.white,),
//       const Expanded(child: SizedBox(width: 10,)),
//       Text('фото', style: white14),
//       const SizedBox(width: 10,),
//     ],
//   ),
// );


// история движения позиции
Widget itemHistory(){
  return FloatingActionButton(
    elevation: 3.0,
    backgroundColor: firmColor.withOpacity(0.7),
    heroTag: 'itemHistory',
    onPressed: (){ print('TAP the itemHistory'); },
    child: Icon(MdiIcons.history, color: Colors.white, size: 30,),
    // label: Text('история', style: white14),
    // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    // icon: Icon(MdiIcons.clipboardTextClock, color: Colors.white,),
  );
}
// final Widget itemHistory = Container(
//   height: 40,
//   width: 170,
//   decoration: BoxDecoration(color: firmColor.withOpacity(0.7), shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10)),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.end,
//     children: [
//       const SizedBox(width: 10,),
//       Icon(MdiIcons.clipboardTextClock, color: Colors.white,),
//       const Expanded(child: SizedBox(width: 10,)),
//       Text('история', style: white14),
//       const SizedBox(width: 10,),
//     ],
//   ),
// );

