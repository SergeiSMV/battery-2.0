
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../../domain/models/departments/logistic/sim_orders/sim_orders.dart';
import '../../../../widgets/app_colors.dart';
import '../../../../widgets/app_text_styles.dart';

class SimOrdersHistory extends StatelessWidget {
  final List closedOrders;
  const SimOrdersHistory({super.key, required this.closedOrders});

  @override
  Widget build(BuildContext context) {

    final DateFormat formatter = DateFormat('dd.MM.yyyy');

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () { Navigator.pop(context); },
          icon: Icon(Icons.keyboard_arrow_left, color: firmColor, size: 25,),
        ),
        backgroundColor: Colors.green.shade100,
        title: Text('закрытые заявки СиМ', style: firm14,),
      ),
      body: closedOrders.isEmpty ? Center(child: Text('нет истории', style: firm14,)) :
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Expanded(
            child: GroupedListView(
              elements: closedOrders, 
              groupBy: (element) => element['dateFormat'],
              groupComparator: (value1, value2) => value1.compareTo(value2),
              order: GroupedListOrder.DESC,
              useStickyGroupSeparators: true,
              floatingHeader: true,
              groupSeparatorBuilder: (value) => Container(
                color: Colors.transparent,
                height: 35,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.green.withOpacity(0.8), shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
                      child: Text(formatter.format(value).toString(), style: white14,),
                    )
                  )
                ),
              ),

              itemBuilder: (context, element) {

                SimOrders order = SimOrders(orders: element);
                late Widget trailing;

      
                if (order.status == 0){ trailing = Icon(MdiIcons.bookmarkRemove, size: 30, color: Colors.red); }
                else if (order.status == 1) { trailing = Icon(MdiIcons.bookmarkPlus, size: 30, color: Colors.blue); }
                else if (order.status == 2) { trailing = Icon(MdiIcons.bookmarkMinus, size: 30, color: Colors.yellow); } 
                else { trailing = Icon(MdiIcons.bookmarkCheck, size: 30, color: Colors.green); }

                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow:  [BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 0.2, blurRadius: 0.2, offset: const Offset(0, 2))]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ListTile(
                        trailing: trailing,
                        visualDensity: const VisualDensity(vertical: -4),
                        tileColor: Colors.white,
                        title: Text('Заявка № ${order.num}', style: TextStyle(fontSize: 12, color: firmColor)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('автор: ${order.customer}', style: const TextStyle(fontSize: 10),),
                            Text('создано: ${order.date} ${order.time}', style: const TextStyle(fontSize: 10),),
                          ],
                        ),
                        onTap: (){
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SelectedOrder(num: order.num,)));
                        },
                      ),
                    )
                  ),
                );
              }
            )
          )
        ],
      ),
    );
  }
}