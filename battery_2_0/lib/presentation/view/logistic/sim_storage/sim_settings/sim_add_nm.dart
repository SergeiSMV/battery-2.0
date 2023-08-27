import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../../data/bloc/logistic/sim_nomenclature_bloc.dart';
import '../../../../../data/departments/logistic/sim_nomenclature_impl.dart';
import '../../../../widgets/app_colors.dart';
import '../../../../widgets/app_text_styles.dart';


class SimAddNomenclature extends ConsumerWidget {
  final List allNomenclature;
  const SimAddNomenclature({super.key, required this.allNomenclature});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<SimNomenclatureBloc>(create: (context) => SimNomenclatureBloc()),
      ],
      child: Builder(
        builder: (context) {

          final messenger = ScaffoldMessenger.of(context);
          Map nmcl = context.watch<SimNomenclatureBloc>().state;

          return ProgressHUD(
            padding: const EdgeInsets.all(20.0),
            child: Builder(
              builder: (context) {
                return Scaffold(
                  appBar: AppBar(
                    elevation: 1,
                    leading: IconButton(
                      onPressed: () { Navigator.pop(context); },
                      icon: Icon(Icons.keyboard_arrow_left, color: firmColor, size: 25,),
                    ),
                    backgroundColor: Colors.green.shade100,
                    title: Text('создание номенклатуры', style: firm14,),
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
                              const SizedBox(height: 10),

                              _enterValue('категория', nmcl['category'].toString(), (String value){
                                nmcl['category'] = value.toString();
                                context.read<SimNomenclatureBloc>().add(SimNomenclatureChange(data: Map.from(nmcl)));
                              }, IconButton(onPressed: () async {
                                ProgressHUD.of(context)?.showWithText('загрузка');
                                await SimNomenclatureImpl().getAllCategories(context, nmcl).then((value){
                                  ProgressHUD.of(context)?.dismiss();
                                  value is List ? null : messenger._toast(value);
                                });
                              }, icon: Icon(MdiIcons.menu, size: 25, color: firmColor), splashRadius: 1,)),

                              const SizedBox(height: 8),
                                       
                              _enterValue('наименование', nmcl['name'].toString(), (String value){
                                nmcl['name'] = value.toString();
                                context.read<SimNomenclatureBloc>().add(SimNomenclatureChange(data: Map.from(nmcl)));
                              }, const SizedBox.shrink()),

                              const SizedBox(height: 8),

                              _enterValue('поставщик', nmcl['producer'].toString(), (String value){
                                nmcl['producer'] = value.toString();
                                context.read<SimNomenclatureBloc>().add(SimNomenclatureChange(data: Map.from(nmcl)));
                              }, IconButton(onPressed: () async {
                                ProgressHUD.of(context)?.showWithText('загрузка');
                                await SimNomenclatureImpl().getAllProducers(context, nmcl).then((value){
                                  ProgressHUD.of(context)?.dismiss();
                                  value is List ? null : messenger._toast(value);
                                });
                              }, icon: Icon(MdiIcons.menu, size: 25, color: firmColor), splashRadius: 1,)),

                              const SizedBox(height: 8),

                              _enterValue('ед. измерения', nmcl['unit'].toString(), (String value){
                                nmcl['unit'] = value.toString();
                                context.read<SimNomenclatureBloc>().add(SimNomenclatureChange(data: Map.from(nmcl)));
                              }, IconButton(onPressed: () async {
                                ProgressHUD.of(context)?.showWithText('загрузка');
                                await SimNomenclatureImpl().getAllUnits(context, nmcl).then((value){
                                  ProgressHUD.of(context)?.dismiss();
                                  value is List ? null : messenger._toast(value);
                                });
                              }, icon: Icon(MdiIcons.menu, size: 25, color: firmColor), splashRadius: 1,)),

                              const SizedBox(height: 30),


                              nmcl['category'].toString().isEmpty || nmcl['name'].toString().isEmpty ||
                              nmcl['producer'].toString().isEmpty || nmcl['unit'].toString().isEmpty ?

                              const SizedBox.shrink() :

                              Padding(
                                padding: const EdgeInsets.only(left: 5, right: 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                    color: Colors.amber.shade600,
                                  ),
                                  height: 40,
                                  width: double.infinity,
                                  child: TextButton(onPressed: () async {
                                    ProgressHUD.of(context)?.showWithText('добавляем');
                                    await SimNomenclatureImpl().addNomenclature(nmcl).then((value) {
                                      ProgressHUD.of(context)?.dismiss();
                                      value == 'done' ? messenger._toast('номенклатура добавлена') : messenger._toast(value);
                                      Navigator.pop(context);
                                    });
                                  }, child: Text('сохранить', style: firm14,))
                                ),
                              ),

          
          
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
      ),
    );
  }


  _enterValue(String leading, String hint, Function handler, Widget suffix){
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
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
                  readOnly: false,
                  style: TextStyle(fontSize: 13, color: firmColor),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: firm14,
                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                    suffixIcon: suffix,
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