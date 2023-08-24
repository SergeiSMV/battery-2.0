import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../../data/providers/logistic/sim/sim_orders_provider.dart';
import '../../../../../domain/models/departments/logistic/sim_orders/sim_order_items.dart';
import '../../../../widgets/app_colors.dart';
import '../../../../widgets/app_text_styles.dart';

class SimOrderSelected extends ConsumerWidget {
  final String num;
  const SimOrderSelected({super.key, required this.num});

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final orderItems = ref.watch(simSelectedOrderProvider(num));
    // final closedOrders = ref.watch(closeOrdersProvider);
    // // ignore: unused_local_variable
    // final allUserAccesses = ref.watch(allAccessesProvider).value;
    // bool addOrder = SimOrdersImpl().addOrderButton(allUserAccesses);
            
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () { Navigator.pop(context); },
          icon: Icon(Icons.keyboard_arrow_left, color: firmColor, size: 25,),
        ),
        backgroundColor: Colors.green.shade100,
        title: Text('заявка $num', style: firm14,),
      ),
      body: ProgressHUD(
        padding: const EdgeInsets.all(20.0),
        child: Consumer(
          builder: ((context, ref, child) {
            
            // return Center(child: Text(num, style: firm16,));
            
            return orderItems.when(
              loading: () => const Scaffold(body: Center(child: CircularProgressIndicator(strokeWidth: 2.0,))),
              error: (error, _) => Text(error.toString()), 
              data: (data){
      
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index){
                    
                    SimOrderItems item = SimOrderItems(item: data[index]);
                    int status = data[index]['status'];
      
                    late Widget trailing;
      
                    if (status == 0){ trailing = Icon(MdiIcons.bookmarkRemove, size: 30, color: Colors.red); }
                    else if (status == 1) { trailing = Icon(MdiIcons.bookmarkPlus, size: 30, color: Colors.blue); }
                    else if (status == 2) { trailing = Icon(MdiIcons.bookmarkMinus, size: 30, color: Colors.yellow); } 
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
                            title: Text(item.name, style: firm12),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('поставщик: ${item.producer}', style: firm10),
                                Text('местоположение: ${item.place} | ${item.cell}', style: firm10),
                                Text('к выдаче:  ${item.quantity} ${item.unit}', style: firm10),
                                item.extradition.isEmpty ? const SizedBox.shrink() : Text('выдано:  ${item.extradition} ${item.unit}', style: firm10),
                                item.comment.isEmpty ? const SizedBox.shrink() : Text('комментарий:  ${item.comment}', style: firm10),
                              ],
                            ),
                            onTap: () { }
                          ),
                        )
                      ),
                    );
                  }
                );
              }
            );



          })
        ),
      ),
    );



  }
}