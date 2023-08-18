


import 'package:battery_2_0/presentation/widgets/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../data/bloc/logistic/sim_item_replace_bloc.dart';
import '../../../../../../domain/models/departments/logistic/sim_items/sim_items.dart';
import '../../../../app_colors.dart';


simMultipleCellsDialog(BuildContext motherContext, List checkCell){
  return showModalBottomSheet(
    enableDrag: false,
    isDismissible: false,
    useSafeArea: true,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: motherContext, 
    builder: (context){

      Map replaceState = motherContext.read<SimItemReplaceBloc>().state;

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
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text('На выбранной ячейке уже размещены следующие комплектующие.', style: firm16, textAlign: TextAlign.center,),
            ),
            const SizedBox(height: 5),

            Divider(color: firmColor, indent: 30, endIndent: 30,),
            
            Flexible(
              child: Container(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: checkCell.length,
                  itemBuilder: (contex, index){

                    SimItems item = SimItems(item: Map.from(checkCell[index]));

                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                      child: ListTile(
                        visualDensity: const VisualDensity(vertical: -3),
                        title: Text(item.fullName, textAlign: TextAlign.center, style: firm14),
                        subtitle: Text('${item.place} ${item.cell}, ${item.quantity} ${item.unit}.', textAlign: TextAlign.center, style: grey14),
                        onTap: (){
                        },
                      ),
                    );
                  }
                ),
              ),
            ),
            const SizedBox(height: 10),
            Divider(color: firmColor, indent: 30, endIndent: 30,),
            Text('Что имеено Вы желаете сделать?', style: firm16, textAlign: TextAlign.center,),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(3.0)),
                      color: Colors.blue,
                    ),
                    height: 35,
                    width: MediaQuery.of(context).size.width * 0.875,
                    child: TextButton(onPressed: () {
                      replaceState['merge'] = 'yes';
                      replaceState['merge_items'] = checkCell;
                      replaceState['replace']['pallet_size'] = checkCell[0]['pallet_size'];
                      motherContext.read<SimItemReplaceBloc>().add(UpdateReplaceValueEvent(updateData: replaceState));
                      Navigator.pop(context);
                    }, child: Text('объединить', style: white16,))
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(3.0)),
                      color: Colors.blue,
                    ),
                    height: 35,
                    width: MediaQuery.of(context).size.width * 0.875,
                    child: TextButton(onPressed: () {
                      replaceState['replace']['cell'] = '';
                      motherContext.read<SimItemReplaceBloc>().add(UpdateReplaceValueEvent(updateData: replaceState));
                      Navigator.pop(context);
                    }, child: Text('выбрать другую ячейку', style: white16,))
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      );
    }
  );
}