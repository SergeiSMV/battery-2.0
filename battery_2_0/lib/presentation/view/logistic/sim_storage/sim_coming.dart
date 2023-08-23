import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../data/bloc/logistic/sim_coming_bloc.dart';
import '../../../../data/departments/logistic/sim_coming_impl.dart';
import '../../../../data/providers/logistic/sim/sim_items_provider.dart';
import '../../../../data/providers/user/user_accesses_provider.dart';
import '../../../../domain/models/departments/logistic/sim_coming/sim_coming.dart';
import '../../../widgets/app_colors.dart';
import '../../../widgets/app_text_styles.dart';
import '../../../widgets/logistic/sim_storage/coming/coming_description.dart';

class SimComingView extends ConsumerWidget {
  const SimComingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final allUserAccesses = ref.watch(allAccessesProvider).value;
    final allSimItems = ref.watch(simItemsProvider).value;
    bool comingManual = SimComingImpl().comingManualAccess(allUserAccesses);

    return MultiBlocProvider(
      providers: [
        BlocProvider<SimComingBloc>(create: (context) => SimComingBloc()),
      ],
      child: Builder(
        builder: (context) {

          final messenger = ScaffoldMessenger.of(context);
          Map comingState = context.watch<SimComingBloc>().state;

          SimComingImpl().initDate(context, comingState);
          SimComingImpl().initAuthor(context, comingState);

          SimComing coming = SimComing(item: comingState);


          return Scaffold(
            appBar: AppBar(
              elevation: 1,
              leading: IconButton(
                onPressed: () { Navigator.pop(context); },
                icon: Icon(Icons.keyboard_arrow_left, color: firmColor, size: 25,),
              ),
              backgroundColor: Colors.green.shade100,
              title: Text('поступление', style: firm14,),
            ),
            body: ProgressHUD(
              padding: const EdgeInsets.all(20.0),
              child: Builder(
                builder: (context) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        comingDescription(),
                        const SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextButton.icon(onPressed: () async { 
                            SimComingImpl().fillBarcode(context, comingState).then((value) {
                              if (value == 'done') { messenger._toast('данные заполнены'); }
                              else if (value == 'empty') { messenger._toast('данные по штрих-коду не найдены'); }
                              else { messenger._toast(value); }
                            }); 
                          },
                          icon: Icon(MdiIcons.barcode, color: firmColor, size: 25,), label: Text('поиск по штрих-коду', style: TextStyle(color: firmColor, fontSize: 12),)),
                        ),

                        Row(
                          children: [
                            Padding(padding: const EdgeInsets.only(left: 20), child: Text('основное', style: firm12,)),
                            Expanded(child: Divider(indent: 10, endIndent: 20, thickness: 1.0, color: firmColor.withOpacity(0.4))),
                          ],
                        ),
                              
                        const SizedBox(height: 10,),
                        
                        _readOnlyValue('категория', coming.category, () async {
                          ProgressHUD.of(context)?.showWithText('загрузка');
                          await SimComingImpl().comingCategories(context, comingState).then((value){
                            ProgressHUD.of(context)?.dismiss();
                            value is List ? null : messenger._toast(value);
                          });
                        }),
                        const SizedBox(height: 8,),
                  
                        _readOnlyValue('наименование', coming.name, () async {
                          ProgressHUD.of(context)?.showWithText('загрузка');
                          coming.category.isEmpty ? 
                          {messenger._toast('заполните поля выше'), ProgressHUD.of(context)?.dismiss()} :
                          await SimComingImpl().comingNames(context, comingState).then((value){
                            ProgressHUD.of(context)?.dismiss();
                            value is List ? null : messenger._toast(value);
                          });
                        }),
                        const SizedBox(height: 8,),

                        _readOnlyValue('поставщик', coming.producer, () async {
                          ProgressHUD.of(context)?.showWithText('загрузка');
                          coming.category.isEmpty || coming.name.isEmpty ? 
                          {messenger._toast('заполните поля выше'), ProgressHUD.of(context)?.dismiss()} :
                          await SimComingImpl().comingProducers(context, comingState).then((value){
                            ProgressHUD.of(context)?.dismiss();
                            value is List ? null : messenger._toast(value);
                          });
                        }),
                        const SizedBox(height: 8,),
                  
                        _readOnlyValue('цвет', coming.color, () async {
                          ProgressHUD.of(context)?.showWithText('загрузка');
                          await SimComingImpl().comingColors(context, comingState).then((value){
                            ProgressHUD.of(context)?.dismiss();
                            value is List ? null : messenger._toast(value);
                          });
                        }),
                        const SizedBox(height: 8,),
                        
                        _enterValue('количество', coming.quantity, (String value){
                          comingState['quantity'] = value.toString();
                          context.read<SimComingBloc>().add(SimComingChange(data: Map.from(comingState)));
                        }),
                        const SizedBox(height: 8,),

                        _readOnlyValue('единицы', coming.unit, () async {
                          ProgressHUD.of(context)?.showWithText('загрузка');
                          coming.category.isEmpty || coming.name.isEmpty || coming.producer.isEmpty ? 
                          {messenger._toast('заполните поля выше'), ProgressHUD.of(context)?.dismiss()} :
                          await SimComingImpl().comingUnits(context, comingState).then((value){
                            ProgressHUD.of(context)?.dismiss();
                            value is List ? null : messenger._toast(value);
                          });
                        }),
                        
                        Row(
                          children: [
                            Padding(padding: const EdgeInsets.only(left: 20), child: Text('дополнительно', style: firm12,)),
                            Expanded(child: Divider(indent: 10, endIndent: 20, thickness: 1.0, color: firmColor.withOpacity(0.4),  height: 40,)),
                          ],
                        ),
                  
                        _readOnlyValue('штрих код', coming.barcode, () async {
                          ProgressHUD.of(context)?.showWithText('загрузка');
                          await SimComingImpl().comingBarcode(context, comingState).then((_){
                            ProgressHUD.of(context)?.dismiss();
                          });
                        }),
                        const SizedBox(height: 8,),

                        _readOnlyValue('дата', coming.fifo, () async {
                          comingManual ? {
                            ProgressHUD.of(context)?.showWithText('загрузка'),
                            await SimComingImpl().comingFifo(context, comingState).then((_){
                              ProgressHUD.of(context)?.dismiss();
                            })
                          } : null;
                        }),
                        const SizedBox(height: 8,),

                        _readOnlyValue('размер паллета', _definePalletSize(coming.palletSize), () async {
                          ProgressHUD.of(context)?.showWithText('загрузка');
                          await SimComingImpl().comingPalletSize(context, comingState).then((_){
                            ProgressHUD.of(context)?.dismiss();
                          });
                        }),
                        const SizedBox(height: 8,),

                        _enterValue('высота паллета', coming.palletHeight, (String value){
                          comingState['pallet_height'] = value.toString();
                          context.read<SimComingBloc>().add(SimComingChange(data: Map.from(comingState)));
                        }),

                        !comingManual ? const SizedBox.shrink() :
                        Row(
                          children: [
                            Padding(padding: const EdgeInsets.only(left: 20), child: Text('параметры размещения', style: firm12,)),
                            Expanded(child: Divider(indent: 10, endIndent: 20, thickness: 1.0, color: firmColor.withOpacity(0.4),  height: 40,)),
                          ],
                        ),

                        !comingManual ? const SizedBox.shrink() :
                          _readOnlyValue('склад', coming.place, () async {
                            ProgressHUD.of(context)?.showWithText('загрузка');
                            await SimComingImpl().comingPlaces(context, comingState).then((value){
                              ProgressHUD.of(context)?.dismiss();
                              value is List ? null : messenger._toast(value); 
                            });
                          }),
                        comingManual ? const SizedBox(height: 8,) : const SizedBox.shrink(),

                        !comingManual ? const SizedBox.shrink() : 
                          _readOnlyValue('ячейка', coming.cell, () async {
                            ProgressHUD.of(context)?.showWithText('загрузка');
                            coming.place.isEmpty ? 
                            {messenger._toast('укажите склад'), ProgressHUD.of(context)?.dismiss()} :
                            await SimComingImpl().comingCells(context, coming.place,  comingState).then((value){
                              ProgressHUD.of(context)?.dismiss();
                              value is List ? null : messenger._toast(value);
                              SimComingImpl().comingCheckCell(context, allSimItems!, comingState);
                            });
                          }),
                        comingManual ? const SizedBox(height: 8,) : const SizedBox.shrink(),


                      ],
                    ),
                  );
                }
              ),
            ),
          );
        }
      ),
    );
  }

  _readOnlyValue(String leading, String hint, Function handler){
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
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
                  textAlignVertical: TextAlignVertical.center,
                  readOnly: true,
                  style: TextStyle(fontSize: 13, color: firmColor),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: firm14,
                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                    suffixIcon: _defineSuffixIcon(leading, hint),
                  ),
                  onTap: (){ handler(); },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _enterValue(String leading, String hint, Function handler){
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
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
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.number,
                  readOnly: false,
                  style: TextStyle(fontSize: 13, color: firmColor),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: grey14,
                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                    suffixIcon: _defineSuffixIcon(leading, hint),
                  ),
                  onChanged: (value){ handler(value); },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _definePalletSize(String state){
    late String palletSize;
    if (state == ''){ palletSize = ''; }
    else if (state == 'big'){ palletSize = 'большой'; }
    else { palletSize = 'стандартный'; }
    return palletSize;
  }

  Widget _defineSuffixIcon(String leading, String hint){
    Color? iconColor;
    IconData? icon;
    Widget suffixIcon = const SizedBox.shrink();
    if (leading == 'категория' || 
      leading == 'наименование' || 
      leading == 'поставщик' || 
      leading == 'количество' ||
      leading == 'единицы' ||
      leading == 'размер паллета' ||
      leading == 'высота паллета'
    ){
      iconColor = hint.isEmpty ? Colors.red : Colors.green;
      icon = hint.isEmpty ? MdiIcons.alertCircle : MdiIcons.checkBold;
      suffixIcon = Icon(icon, color: iconColor, size: 20,);
    }
    else if (leading == 'цвет' || leading == 'штрих код'){
      iconColor = hint.isEmpty ? Colors.grey.shade600 : Colors.green;
      icon = hint.isEmpty ? MdiIcons.alertCircle : MdiIcons.checkBold;
      suffixIcon = Icon(icon, color: iconColor, size: 20,);
    }
    return suffixIcon;
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