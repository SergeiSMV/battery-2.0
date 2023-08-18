import 'package:battery_2_0/presentation/widgets/app_text_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

import '../../../../../data/bloc/logistic/sim_item_replace_bloc.dart';
import '../../../../../data/departments/logistic/sim_items_impl.dart';
import '../../../../../domain/models/departments/logistic/sim_items/sim_items.dart';
import '../../../../widgets/app_colors.dart';
import '../../../../widgets/logistic/sim_storage/selected_item/replace/sim_multiple_cells_dialog.dart';

class SelectedItemReplace extends StatelessWidget {
  final Map itemData;
  final List allItems;
  const SelectedItemReplace(
      {super.key, required this.itemData, required this.allItems});

  @override
  Widget build(BuildContext context) {

    final messenger = ScaffoldMessenger.of(context);
    SimItems item = SimItems(item: Map.from(itemData));

    return MultiBlocProvider(
      providers: [
        BlocProvider<SimItemReplaceBloc>(create: (context) => SimItemReplaceBloc()..add(InitEvent(initData: itemData))),
      ],
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          leading: IconButton(
            onPressed: () { Navigator.pop(context); },
            icon: Icon(Icons.keyboard_arrow_left, color: firmColor, size: 25,),
          ),
          backgroundColor: Colors.green.shade100,
          title: Text('перемещение', style: firm14,),
        ),
        body: ProgressHUD(
          padding: const EdgeInsets.all(20.0),
          child: Builder(builder: (context) {

            Map replaceState = context.watch<SimItemReplaceBloc>().state;
            SimItems replace = SimItems(item: Map.from(replaceState['replace']));
            bool merge = replaceState['merge'] == 'no' ? false : true;
            bool changePallet = replaceState['change_pallet'] == 'no' ? false : true;
            String palletSize = replace.palletSize == 'big' ? 'большой' : 'стандартный';
            bool compire = mapEquals(Map.from(replaceState['replace']), Map.from(replaceState['default']));

            return Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text('${item.category} ${item.name} ${item.color}', style: firm14,),
                      Text('${item.producer}, ${item.fifo}', style: firm14,),
                      const SizedBox(height: 10),
                      Divider(indent: 0, endIndent: 20, thickness: 1.0, color: firmColor.withOpacity(0.4),),
                      Text('Текущее размещение:', style: firm16,),
                      const SizedBox(height: 10),
                      Text('Склад: ${item.place}', style: firm14,),
                      Text('Ячейка: ${item.cell}', style: firm14,),
                      Text('Размер паллета: ${item.palletSize == 'big' ? 'большой' : 'стандартный'}', style: firm14,),

                      const SizedBox(height: 10),
                      Divider(indent: 0, endIndent: 20, thickness: 1.0, color: firmColor.withOpacity(0.4),),
                      const SizedBox(height: 10),

                      Text('Куда перемещаем?', style: firm16,),
                      const SizedBox(height: 10),

                      _enterValue('склад', replace.place, () async {
                        ProgressHUD.of(context)?.showWithText('загрузка');
                        await SimItemsImpl().getPlaces(context).then((value) {
                          ProgressHUD.of(context)?.dismiss();
                          value is List ? null : messenger.toast(value.toString());
                        });
                      }),

                      const SizedBox(height: 8),
                      _enterValue('ячейка', replace.cell, () async {
                        List roomates;
                        ProgressHUD.of(context)?.showWithText('загрузка');
                        await SimItemsImpl().getCells(context, replace.place).then((value) {
                          ProgressHUD.of(context)?.dismiss();
                          value is List ? {} : messenger.toast(value.toString());
                          roomates = SimItemsImpl().checkCell(allItems, replaceState['replace']['place'], replaceState['replace']['cell'], item.id);
                          roomates.isEmpty ? 
                          {
                            replaceState['merge'] = 'no',
                            replaceState['merge_items'] = [],
                            context.read<SimItemReplaceBloc>().add(UpdateReplaceValueEvent(updateData: replaceState))
                          } 
                          : 
                          {
                            replaceState['replace']['cell'] != item.cell ? simMultipleCellsDialog(context, roomates) : null
                          };
                        });
                      }),

                      const SizedBox(height: 10),
                      Divider(indent: 0, endIndent: 20, thickness: 1.0, color: firmColor.withOpacity(0.4),),
                      const SizedBox(height: 15),

                      Text(merge ? 'Параметры объединения:' : 'Параметры паллета:', style: firm16,),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 0, right: 20),
                        child: Container(
                          decoration: BoxDecoration(color: merge ? Colors.orange : Colors.green.shade50, borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            children: [
                              Switch(
                                value: changePallet,
                                activeColor: Colors.blue,
                                activeTrackColor: Colors.grey,
                                onChanged: (bool value){
                                  value ? replaceState['change_pallet'] = 'yes' : replaceState['change_pallet'] = 'no';
                                  replace.palletSize == 'big' ? replaceState['replace']['pallet_size'] = 'standart' : replaceState['replace']['pallet_size'] = 'big';
                                  context.read<SimItemReplaceBloc>().add(UpdateReplaceValueEvent(updateData: replaceState));
                                  print(replaceState);
                                }
                              ),
                              const SizedBox(width: 5,),
                              Expanded(
                                child: Text(
                                  changePallet ? '${merge ? 'объединяем' : 'меняем'} на $palletSize паллет' : 
                                  '${merge ? 'объединяем на' : 'оставляем'} $palletSize паллет', 
                                  style: firm14
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                      Divider(indent: 0, endIndent: 20, thickness: 1.0, color: firmColor.withOpacity(0.4),),
                      const SizedBox(height: 10),

                      replace.cell == '' || compire ? const SizedBox.shrink() :
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3.0)),
                          color: Colors.blue,
                        ),
                        height: 35,
                        width: MediaQuery.of(context).size.width * 0.875,
                        child: TextButton(onPressed: () async {
                          ProgressHUD.of(context)?.showWithText('перемещаем');
                          print(replaceState);
                          // await SimItemsImpl().replace(locatesData, defaultData).then((value) {
                          //   ProgressHUD.of(context)?.dismiss();
                          //   value == 'done' ? messenger.toast('изменения сохранены') : messenger.toast(value);
                          //   Navigator.pop(context);
                          // });
                        }, child: Text('сохранить', style: white16,))
                      ), 
                      

                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  _enterValue(String leading, String hint, Function func){
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 20),
      child: Container(
        decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Text('$leading:', style: firm14),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  readOnly: true,
                  style: TextStyle(fontSize: 13, color: firmColor),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: firm14,
                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                  ),
                  onTap: (){ func(); },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

extension on ScaffoldMessengerState {
  void toast(String message){
    showSnackBar(
      SnackBar(
        content: Text(message), 
        duration: const Duration(seconds: 4),
      )
    );
  }
}
