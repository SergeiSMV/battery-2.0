



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../../data/providers/logistic/sim/sim_nomenclature_provider.dart';
import '../../../../widgets/app_colors.dart';
import '../../../../widgets/app_text_styles.dart';
import 'sim_add_nm.dart';

class SimSettingNomenclature extends ConsumerWidget {
  const SimSettingNomenclature({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final nomenclature = ref.watch(simNomenclatureProvider);


    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () { Navigator.pop(context); },
          icon: Icon(Icons.keyboard_arrow_left, color: firmColor, size: 25,),
        ),
        backgroundColor: Colors.green.shade100,
        title: Text('номенклатура склада СиМ', style: firm14,),
      ),
      body: Consumer(
        builder: ((context, ref, child) {
          return nomenclature.when(
            error: (error, _) => Center(child: Text('${error.toString()}\nОбратитесь к администратору!')),
            loading: () => Center(child: CircularProgressIndicator(strokeWidth: 2.0, color: firmColor,)),
            data: (data){



              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index){

                  data.isNotEmpty ? data.sort((a, b) {return a['name'].toString().compareTo(b['name'].toString());}) : null;

                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow:  [BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 0.2, blurRadius: 0.2, offset: const Offset(0, 2))]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: ListTile(
                          visualDensity: const VisualDensity(vertical: -4),
                          tileColor: Colors.white,
                          title: Text('${data[index]['category']} ${data[index]['name']}', style: firm14),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('поставщик: ${data[index]['producer']}', style: firm12),
                              Text('ед. измерения: ${data[index]['unit']}.', style: firm12),
                            ],
                          ),
                          onTap: () {  },
                        ),
                      ),
                    ),
                  );
                }
              );
            }
          );
        })
      ),
      floatingActionButton: 
      FloatingActionButton(
        elevation: 3,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => SimAddNomenclature(allNomenclature: nomenclature.value!.toList()))).then((_) {
              ref.invalidate(simNomenclatureProvider);});
        },
        backgroundColor: Colors.amber,
        child: Icon(MdiIcons.plus, size: 30, color: firmColor),
      )
    );
  }


}