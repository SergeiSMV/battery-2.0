import 'package:battery_2_0/presentation/widgets/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../../view/logistic/sim_storage/sim_orders/sim_orders_alert.dart';
import '../../../../widgets/app_colors.dart';

simExItemDialog(BuildContext mainContext, Map item) {

  String quantity = '';

  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: mainContext,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {

          return Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0)),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Text('${item['category']} ${item['name']} ${item['color']}', style: firm14),
                Text('поставщик: ${item['producer']}', style: firm12),
                Divider(color: firmColor, indent: 15, endIndent: 15, height: 30, thickness: 1),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text('укажите фактическое количество для выдачи:', style: firm12, textAlign: TextAlign.center,),
                ),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    constraints: const BoxConstraints(maxHeight: 100),
                    decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(5)),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 13, color: firmColor),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(5),
                        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                        hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade400, fontFamily: 'Montserrat'),
                        hintText: 'укажите количество',
                        prefixIcon: const IconTheme(data: IconThemeData(color: Color(0xFF78909C)), child: Icon(Icons.onetwothree, size: 25)),
                      ),
                      onChanged: (value) {
                        setState((){ quantity = value; });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 10),


                quantity.isEmpty ? const SizedBox.shrink() : 
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(color: mainColor, shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(5)),
                      child: TextButton(
                        onPressed: (){
                            int.parse(quantity) > item['baseItemQuantity'] ? 
                            simOrdersAlert(mainContext, 'превышен допустимый остаток', 'lib/images/lottie/close.json') :
                            Navigator.pop(context, quantity);
                        }, child: Text('подтвердить', style: white14)
                      )
                    ),
                  ),
                
                Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: const SizedBox(height: 10),
                ),
              ],
            ),
          );
        }
      );
    }
  );
}
