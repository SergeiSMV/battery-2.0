import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../../data/departments/logistic/sim_orders_impl.dart';
import '../../../../../data/providers/logistic/sim/sim_orders_provider.dart';
import '../../../../../data/providers/user/user_accesses_provider.dart';
import '../../../../../domain/models/departments/logistic/sim_orders/sim_order_items.dart';
import '../../../../widgets/app_colors.dart';
import '../../../../widgets/app_text_styles.dart';

class SimOrderSelected extends ConsumerWidget {
  final String num;
  const SimOrderSelected({super.key, required this.num});

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final orderItems = ref.watch(simSelectedOrderProvider(num));
    final allUserAccesses = ref.watch(allAccessesProvider).value;
    bool exOrderAccess = SimOrdersImpl().simExOrdersAccess(allUserAccesses);
    bool takeOrderAccess = SimOrdersImpl().simTakeOrdersAccess(allUserAccesses);
    final messenger = ScaffoldMessenger.of(context);
            
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
        child: Builder(
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 5),
                Expanded(
                  child: Consumer(
                    builder: ((context, ref, child) {
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
                      
                              late Widget trailing;
                      
                              if (item.status == 0){ trailing = SizedBox(height: double.infinity, child: Icon(MdiIcons.bookmarkRemove, size: 30, color: Colors.red)); }
                              else if (item.status == 1) { trailing = SizedBox(height: double.infinity, child: Icon(MdiIcons.bookmarkPlus, size: 30, color: Colors.blue)); }
                              else if (item.status == 2) { trailing = SizedBox(height: double.infinity, child: Icon(MdiIcons.bookmarkMinus, size: 30, color: Colors.yellow)); } 
                              else { trailing = SizedBox(height: double.infinity, child: Icon(MdiIcons.bookmarkCheck, size: 30, color: Colors.green)); }
                          
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
                                      onTap: () { 
                                        if (item.status == 1){ !exOrderAccess ? null : messenger._toast('нет доступа на выдачу комплектующих по заявкам');}
                                        else if (item.status == 2){ takeOrderAccess ? null : messenger._toast('нет доступа на приемку комплектующих по заявкам');}
                                        else { messenger._toast('позиция выдана и закрыта для редактирования'); }
                                      }
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
              ],
            );
          }
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