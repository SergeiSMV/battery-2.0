import 'package:battery_2_0/presentation/view/logistic/sim_storage/sim_orders/sim_order_selected.dart';
import 'package:battery_2_0/presentation/view/logistic/sim_storage/sim_orders/sim_orders_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../../data/departments/logistic/sim_orders_impl.dart';
import '../../../../../data/providers/logistic/sim/sim_orders_provider.dart';
import '../../../../../data/providers/user/user_accesses_provider.dart';
import '../../../../../domain/models/departments/logistic/sim_orders/sim_orders.dart';
import '../../../../widgets/app_colors.dart';
import '../../../../widgets/app_text_styles.dart';

class SimOrdersView extends ConsumerWidget {
  const SimOrdersView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final openedOrders = ref.watch(simOrdersProvider);
    final closedOrders = ref.watch(closeOrdersProvider);
    // ignore: unused_local_variable
    final allUserAccesses = ref.watch(allAccessesProvider).value;
    bool addOrder = SimOrdersImpl().addOrderButton(allUserAccesses);
            
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () { Navigator.pop(context); },
          icon: Icon(Icons.keyboard_arrow_left, color: firmColor, size: 25,),
        ),
        backgroundColor: Colors.green.shade100,
        title: Text('заявки СиМ', style: firm14,),
        actions: [
          // история
          Padding(padding: const EdgeInsets.only(right: 17),
            child: IconButton( onPressed: (){ 
              Navigator.push(context, MaterialPageRoute(builder: (context) => SimOrdersHistory(closedOrders: closedOrders)));
            }, icon: Icon(MdiIcons.history, color: firmColor, size: 25,)),
          ),
        ],
      ),
      body: ProgressHUD(
        padding: const EdgeInsets.all(20.0),
        child: Consumer(
          builder: ((context, ref, child) {
            return openedOrders.when(
              loading: () => const Scaffold(body: Center(child: CircularProgressIndicator(strokeWidth: 2.0,))),
              error: (error, _) => Text(error.toString()), 
              data: (data){
      
                return data.isEmpty ?
                Center(child: SizedBox(height: 200, width: 200, child: Lottie.asset('lib/images/lottie/coffee_break.json'))) :
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index){
                    
                    SimOrders order = SimOrders(orders: data[index]);
                    data.sort((a, b) {return a['dateFormat'].compareTo(b['dateFormat']);});                 
      
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
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SimOrderSelected(num: order.num,)));
                            },
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
      floatingActionButton: 
      addOrder ? 
      FloatingActionButton.extended(
        elevation: 3,
        onPressed: () {  },
        backgroundColor: Colors.amber,
        label: Text('создать', style: firm12,),
        icon: Icon(MdiIcons.fileDocumentPlus, color: firmColor, size: 25,),
      ) : const SizedBox.shrink(),
    );



  }
}