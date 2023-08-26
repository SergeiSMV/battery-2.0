import 'package:battery_2_0/presentation/view/logistic/sim_storage/selected_item/selected_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


import '../../../../data/departments/logistic/sim_storage_impl.dart';
import '../../../../data/providers/user/user_accesses_provider.dart';
import '../../../../data/server/connect_impl.dart';
import '../../../../domain/models/departments/logistic/sim_storage_main/sim_storage_main.dart';
import '../../../../domain/repository/server/sim.dart';
import '../../../widgets/app_colors.dart';
import '../../../widgets/app_text_styles.dart';
import '../../../widgets/logistic/sim_storage/coming/barcode_scanner.dart';

class SimStorage extends ConsumerWidget {
  const SimStorage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final allUserAccesses = ref.watch(allAccessesProvider).value;
    List simStorageMain = SimStorageImpl().simStorageMain(allUserAccesses!, 'склад сырья и материалов');
    final messenger = ScaffoldMessenger.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.keyboard_arrow_left, color: firmColor, size: 25,),
        ),
        iconTheme: IconThemeData(color: firmColor),
        backgroundColor: Colors.green.shade100,
        title: Text('склад сырья и материалов', style: firm14,),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('lib/images/tunglogo.png'), opacity: 0.2, scale: 4.0, alignment: Alignment(0, -0.7),)),
          ),
          Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 4 / 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10
                ),
                itemCount: simStorageMain.length,
                itemBuilder: (contect, index){
      
                  SimStorageMain element = SimStorageMain(elements: simStorageMain[index]);
      
                  return InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50, 
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: const Offset(2.0, 2.0),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(element.icon, size: 40, color: firmColor),
                            const SizedBox(height: 10,),
                            Text(element.description, style: firm14,),
                          ],
                        ),
                      ),
                    ),
                    onTap: () async {
                      // идентификация
                      element.description == 'идентификация' ? {
                        barcodeScanner(context).then((itemId) async {
                          itemId == null ? messenger._toast('ничего не найдено') : {
                            await ConnectionImpl().request(checkItemIdExist, {'item_id': itemId}).then((value) async {
                              value == 0 ? messenger._toast('ничего не найдено') :
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SelectedItem(itemId: itemId, mainContext: context,)));
                            })
                          };
                        })
                      } 
                      : context.push(element.route);
                    },
                  );
                }
              ),
            ),
            const SizedBox(height: 10,)
          ],
        ),
        ]
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