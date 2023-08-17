
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_progress_hud/flutter_progress_hud.dart';

// import '../../../../../data/departments/logistic/sim_items_impl.dart';
// import '../../../../../domain/models/departments/logistic/sim_items/sim_items.dart';
// import '../../../../widgets/app_colors.dart';
// import '../../../../widgets/app_text_styles.dart';
// import '../../../../widgets/logistic/sim_storage/selected_item/sim_multiple_cells.dart';

// class SelectedItemReplace extends StatefulWidget {
//   final Map itemData;
//   final List allItems;
//   const SelectedItemReplace({super.key, required this.itemData, required this.allItems});

//   @override
//   State<SelectedItemReplace> createState() => _SelectedItemReplaceState();
// }

// class _SelectedItemReplaceState extends State<SelectedItemReplace> {

//   late SimItems item;
//   late Map locatesData;
//   late Map defaultData;
//   late String palletSize;
//   late List checkCell;
//   bool changePallet = false;
//   late String merge;


//   TextEditingController placeController = TextEditingController();
//   TextEditingController cellController = TextEditingController();
//   TextEditingController mergeController = TextEditingController();

//   @override
//   void initState(){
//     item = SimItems(item: Map.from(widget.itemData));
//     locatesData = {};
//     defaultData = {};
//     checkCell = [];
//     merge = '';
//     locatesData['itemId'] = item.id;
//     locatesData['pallet_size'] = item.palletSize;
//     locatesData['place'] = item.place;
//     locatesData['cell'] = item.cell;
//     defaultData['itemId'] = item.id;
//     defaultData['pallet_size'] = item.palletSize;
//     defaultData['place'] = item.place;
//     defaultData['cell'] = item.cell;
//     palletSize = item.palletSize == 'big' ? 'большой' : 'стандартный';
//     placeController.text = widget.itemData['place'];
//     cellController.text = widget.itemData['cell'];
//     super.initState();
//   }

//   @override
//   void dispose(){
//     placeController.dispose();
//     cellController.dispose();
//     mergeController.dispose();
//     super.dispose();
//   }


//   @override
//   Widget build(BuildContext context) {

//     final messenger = ScaffoldMessenger.of(context);
//     bool compire = mapEquals(locatesData, defaultData);

//     return Scaffold(
//       appBar: AppBar(
//         elevation: 1,
//         leading: IconButton(
//           onPressed: () { Navigator.pop(context); },
//           icon: Icon(Icons.keyboard_arrow_left, color: firmColor, size: 25,),
//         ),
//         backgroundColor: Colors.green.shade100,
//         title: Text('перемещение', style: firm14,),
//       ),
//       body: ProgressHUD(
//         padding: const EdgeInsets.all(20.0),
//         child: Builder(
//           builder: (context){
//             return Container(
//               height: double.infinity,
//               width: double.infinity,
//               color: Colors.white,
//               child: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 25),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 10),
//                       Text('${item.category} ${item.name} ${item.color}', style: firm14,),
//                       Text('${item.producer}, ${item.fifo}', style: firm14,),
//                       const SizedBox(height: 10),
//                       Divider(indent: 0, endIndent: 20, thickness: 1.0, color: firmColor.withOpacity(0.4),),
//                       Text('Текущее размещение:', style: firm16,),
//                       const SizedBox(height: 10),
//                       Text('Склад: ${item.place}', style: firm14,),
//                       Text('Ячейка: ${item.cell}', style: firm14,),
//                       Text('Размер паллета: ${item.palletSize == 'big' ? 'большой' : 'стандартный'}', style: firm14,),

//                       const SizedBox(height: 10),
//                       Divider(indent: 0, endIndent: 20, thickness: 1.0, color: firmColor.withOpacity(0.4),),
//                       const SizedBox(height: 10),

//                       Text('Куда перемещаем?', style: firm16,),
//                       const SizedBox(height: 10),

//                       _enterValue('склад', TextInputType.text, placeController, true, () async {
//                         ProgressHUD.of(context)?.showWithText('загрузка');
//                         await SimItemsImpl().getPlaces(context, placeController).then((value) {
//                           ProgressHUD.of(context)?.dismiss();
//                           value is List ? 
//                             setState((){ 
//                               placeController.text.isEmpty || placeController.text == locatesData['place'] ? null : {
//                                 locatesData['place'] = placeController.text,
//                                 cellController.clear(), 
//                               };
//                             }) : messenger.toast(value);
//                         });
//                       }),

//                       const SizedBox(height: 8),
//                       _enterValue('ячейка', TextInputType.text, cellController, true, () async {
//                         placeController.text.isEmpty ? messenger.toast('укажите склад') :
//                         {
//                           ProgressHUD.of(context)?.showWithText('загрузка'),
//                           await SimItemsImpl().getCells(context, cellController, placeController.text).then((value) {
//                             ProgressHUD.of(context)?.dismiss();
//                             value is List ? 
//                               setState((){ 
//                                 cellController.text.isEmpty || cellController.text == locatesData['cell'] ? null : {
//                                   locatesData['cell'] = cellController.text,
//                                   checkCell = SimItemsImpl().checkCell(widget.allItems, locatesData['place'], cellController.text, item.id),
//                                 }; 
//                               }) : messenger.toast(value);
//                           }),
//                           checkCell.isEmpty ? setState((){ merge = ''; }) : simToMultipleCells(context, checkCell, cellController, mergeController).whenComplete((){
//                             cellController.text == '' ? setState(() { 
//                               locatesData['cell'] = cellController.text;
//                             }) : null;
//                             mergeController.text == '' ? null : setState((){ merge = mergeController.text; });
//                           })
//                         };
//                       }),

//                       const SizedBox(height: 10),
//                       Divider(indent: 0, endIndent: 20, thickness: 1.0, color: firmColor.withOpacity(0.4),),
//                       const SizedBox(height: 15),

//                       Text(merge.isEmpty ? 'Параметры паллета:' : 'Параметры объединения:', style: firm16,),
//                       const SizedBox(height: 10),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 0, right: 20),
//                         child: Container(
//                           decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(5)),
//                           child: Row(
//                             children: [
//                               Switch(
//                                 value: changePallet,
//                                 activeColor: Colors.blue,
//                                 activeTrackColor: Colors.grey,
//                                 onChanged: (bool value){
//                                   setState(() {
//                                     changePallet = value;
//                                     palletSize == 'большой' ? palletSize = 'стандартный' : palletSize = 'большой';
//                                     locatesData['pallet_size'] == 'standart' ? locatesData['pallet_size'] = 'big' : locatesData['pallet_size'] = 'standart';
//                                   });
//                                 }
//                               ),
//                               const SizedBox(width: 5,),
//                               Expanded(
//                                 child: Text(
//                                   changePallet ? '${merge.isEmpty ? 'меняем' : 'объединяем'} на $palletSize паллет' : 
//                                   '${merge.isEmpty ? 'оставляем' : 'объединяем'} на $palletSize паллет', 
//                                   style: firm14
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 10),
//                       Divider(indent: 0, endIndent: 20, thickness: 1.0, color: firmColor.withOpacity(0.4),),
//                       const SizedBox(height: 10),

//                       cellController.text.isEmpty || compire ? const SizedBox.shrink() :
//                       Container(
//                         decoration: const BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(3.0)),
//                           color: Colors.blue,
//                         ),
//                         height: 35,
//                         width: MediaQuery.of(context).size.width * 0.875,
//                         child: TextButton(onPressed: () async {
//                           ProgressHUD.of(context)?.showWithText('вносим изменения');
//                           locatesData['change_pallet'] = changePallet;
//                           await SimItemsImpl().replace(locatesData, defaultData).then((value) {
//                             ProgressHUD.of(context)?.dismiss();
//                             value == 'done' ? messenger.toast('изменения сохранены') : messenger.toast(value);
//                             Navigator.pop(context);
//                           });
//                         }, child: Text('сохранить', style: white16,))
//                       ), 
                      

//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }
//         ),
//       ),
//     );
//   }

//   _enterValue(String leading, TextInputType type, TextEditingController controller, bool readOnly, Function func, [Function? onChange]){
//     return Padding(
//       padding: const EdgeInsets.only(left: 0, right: 20),
//       child: Container(
//         decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(5)),
//         child: Row(
//           children: [
//             const SizedBox(width: 10),
//             Text('$leading:', style: firm14),
//             Flexible(
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 10, right: 10),
//                 child: TextField(
//                   controller: controller,
//                   readOnly: readOnly,
//                   keyboardType: type,
//                   style: TextStyle(fontSize: 13, color: firmColor),
//                   decoration: const InputDecoration(
//                     enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
//                     focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
//                   ),
//                   onChanged: (value){ onChange!(value); },
//                   onTap: (){ func(); },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// extension on ScaffoldMessengerState {
//   void toast(String message){
//     showSnackBar(
//       SnackBar(
//         content: Text(message), 
//         duration: const Duration(seconds: 4),
//       )
//     );
//   }
// }

