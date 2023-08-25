

import 'package:battery_2_0/presentation/widgets/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/bloc/logistic/sim_order_cart_bloc.dart';
import '../../../../widgets/app_colors.dart';
import 'sim_orders_alert.dart';

simOrderDialog(BuildContext mainContext, Map item, int remainder) {

  String quantity = '';
  String comment = '';

  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: mainContext,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {

          List savedCart = mainContext.read<SimOrderCartBloc>().state;

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
                Text('доступно: $remainder ${item['unit']}', style: firm12),
                Divider(color: firmColor, indent: 15, endIndent: 15, height: 30, thickness: 1),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text('укажите нужное количество и комментарий при необходимости:', style: firm12, textAlign: TextAlign.center,),
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

                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15,),
                  child: Container(
                    constraints: const BoxConstraints(maxHeight: 100),
                    decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(5)),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 13, color: firmColor),
                      minLines: 1,
                      maxLines: 5,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(5),
                        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                        hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade400, fontFamily: 'Montserrat'),
                        hintText: 'комментарий',
                        prefixIcon: const IconTheme(data: IconThemeData(color: Color(0xFF78909C)), child: Icon(Icons.edit, size: 20)),
                      ),
                      onChanged: (value) {
                        setState((){ comment = value; });
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
                          List cart = savedCart;
                          Map itemOrder = {
                            'category': item['category'],
                            'name': item['name'],
                            'color': item['color'],
                            'producer': item['producer'],
                            'unit': item['unit'],
                            'q_order': quantity,
                            'comment': comment
                          };
                          int.parse(quantity) > remainder ? {
                            simOrdersAlert(mainContext, 'превышен допустимый остаток', 'lib/images/lottie/close.json'),  
                          }
                          :
                          {
                            orderCheckDuplicate(cart, itemOrder) ? null : cart.add(itemOrder),
                            mainContext.read<SimOrderCartBloc>().add(OrderCartChangeEvent(data: cart.toList())),
                            Navigator.pop(context)
                          };
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


bool orderCheckDuplicate(List cart, Map orderData) {
  bool result = false;
  if (cart.any((element) =>
    element.values.contains(orderData['category']) &&
    element.values.contains(orderData['name']) &&
    element.values.contains(orderData['color']) &&
    element.values.contains(orderData['producer']) &&
    element.values.contains(orderData['unit']))) {
    for (var s in cart) {
      if (s['category'] == orderData['category'] &&
          s['name'] == orderData['name'] &&
          s['color'] == orderData['color'] &&
          s['producer'] == orderData['producer'] &&
          s['unit'] == orderData['unit']) {
        s['q_order'] = (int.parse(orderData['q_order']) + int.parse(s['q_order'])).toString();
        result = true;
        break;
      } else {
        continue;
      }
    }
  } else { result = false; }
  return result;
}