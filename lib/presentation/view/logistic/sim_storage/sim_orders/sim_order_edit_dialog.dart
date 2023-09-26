
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/bloc/logistic/sim_order_cart_bloc.dart';
import '../../../../../data/bloc/logistic/sim_uniq_items_bloc.dart';
import '../../../../widgets/app_colors.dart';
import '../../../../widgets/app_text_styles.dart';
import 'sim_orders_alert.dart';

simOrderEditDialog(BuildContext mainContext, Map item, int remainder, int inOrder, String comment) {

  String quantity = '';
  String newComment = '';

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
                Text('всего на складе: ${item['quantity']} ${item['unit']}', style: firm12),
                Text('всего заказано: $inOrder ${item['unit']}', style: firm12),
                
                TextButton(
                  onPressed: (){
                    List cart = savedCart;
                    Map itemOrder = {
                      'category': item['category'], 
                      'name': item['name'], 
                      'color': item['color'], 
                      'producer': item['producer'],
                      'unit': item['unit'],
                      'q_order': quantity,
                    };
                    editRemoveElement(cart, itemOrder);
                    mainContext.read<SimOrderCartBloc>().add(OrderCartChangeEvent(data: cart.toList()));
                    mainContext.read<SimUniqItemsBloc>().add(CartContentEvent(cart: cart.toList()));
                    cart.isEmpty ? mainContext.read<SimUniqItemsBloc>().add(UniqItemsClearSearchEvent()) : null;
                    Navigator.pop(context);
                  }, child: const Text('удалить из заявки', style: TextStyle(fontSize: 14, color: Colors.red))),
                
                Divider(color: firmColor, indent: 15, endIndent: 15, height: 30, thickness: 1),
                
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text('измените количество или удалите позицию из заявки:', style: firm12, textAlign: TextAlign.center,),
                ),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    constraints: const BoxConstraints(maxHeight: 100),
                    decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(5)),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      style: firm13,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(5),
                        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                        hintStyle: grey13,
                        hintText: 'укажите итоговое количество',
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
                        hintText: comment.isEmpty ? 'укажите комментарий' : comment,
                        prefixIcon: const IconTheme(data: IconThemeData(color: Color(0xFF78909C)), child: Icon(Icons.edit, size: 20)),
                      ),
                      onChanged: (value) {
                        setState((){ newComment = value; });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                quantity.isEmpty && newComment.isEmpty ? const SizedBox.shrink() : 
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      height: 35,
                      width: double.infinity,
                      decoration: BoxDecoration(color: mainColor, shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(5)),
                      child: TextButton(onPressed: (){
                        List cart = savedCart;
                        Map itemOrder = {
                          'category': item['category'],
                          'name': item['name'],
                          'color': item['color'],
                          'producer': item['producer'],
                          'unit': item['unit'],
                          'q_order': quantity,
                        };
                        int.parse(quantity.toString().isEmpty ? '0' : quantity) > item['quantity'] ? {
                          simOrdersAlert(mainContext, 'превышен допустимый остаток', 'lib/images/lottie/close.json')
                          }
                        :
                        {
                          editCheckDuplicate(cart, itemOrder, newComment) ? null : cart.add(itemOrder),
                          mainContext.read<SimOrderCartBloc>().add(OrderCartChangeEvent(data: cart.toList())),
                          Navigator.pop(context)
                        };
                      }, child: const Text('подтвердить', style: TextStyle(color: Colors.white, fontSize: 12)))
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


editRemoveElement(List cart, Map orderData){
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
        cart.removeWhere((element) => element == s);
        break;
      } else {
        continue;
      }
    }
  } else {
    null;
  }
}

bool editCheckDuplicate(List cart, Map orderData, String newComment) {
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
          s['producer'] == orderData['unit']) {
        orderData['q_order'].toString().isEmpty ? null : s['q_order'] = orderData['q_order'];
        newComment.isEmpty ? null : s['comment'] = newComment;
        result = true;
        break;
      } else {
        continue;
      }
    }
  } else {
    result = false;
  }
  return result;
}