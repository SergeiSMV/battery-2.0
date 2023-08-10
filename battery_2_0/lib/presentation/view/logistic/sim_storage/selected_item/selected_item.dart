import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../../data/departments/logistic/sim_items_impl.dart';
import '../../../../../data/providers/logistic/sim/sim_selected_item_provider.dart';
import '../../../../../data/providers/user/user_accesses_provider.dart';
import '../../../../../domain/models/departments/logistic/sim_items/sim_items.dart';
import '../../../../../domain/models/departments/logistic/sim_same_items/sim_same_items.dart';
import '../../../../widgets/app_colors.dart';
import '../../../../widgets/app_text_styles.dart';


class SelectedItem extends ConsumerStatefulWidget {
  final String itemId;
  final BuildContext simCatalogContext;
  const SelectedItem({Key? key, required this.itemId, required this.simCatalogContext}) : super(key: key);

  @override
  ConsumerState  <SelectedItem> createState() => _SelectedItem();
}


class _SelectedItem extends ConsumerState <SelectedItem> with SingleTickerProviderStateMixin{

  late Animation<double> animation;
  late AnimationController animationController;
  late CurvedAnimation curvedAnimation;

  final GlobalKey<AnimatedFloatingActionButtonState> key = GlobalKey<AnimatedFloatingActionButtonState>();


  @override
  void initState(){
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 260));
    curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: animationController);
    animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {

    final itemPack = ref.watch(simSelectedItemProvider(widget.itemId));
    final allUserAccesses = ref.watch(allAccessesProvider).value;
    List<Widget> itemMenu = SimItemsImpl().selectedItemFabMenu(allUserAccesses!, widget.simCatalogContext);

    return Consumer(
      builder: ((context, ref, child) {
        return itemPack.when(
          loading: () => const Scaffold(body: Center(child: CircularProgressIndicator(strokeWidth: 2.0,))),
          error: (error, _) => Text(error.toString()), 
          data: (data) {
    
            SimItems item = SimItems(item: data['selected_item']);
            int totalQuantity = data['total_quantity'];
    
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () { Navigator.pop(context); },
                  icon: Icon(Icons.keyboard_arrow_left, color: firmColor, size: 25,),
                ),
                backgroundColor: appBarColor(item.status),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${item.category} ${item.name} ${item.color}', style: firm14,),
                    Text(item.producer, style: grey12,),
                  ],
                ),
              ),
              body: ProgressHUD(
                child: Builder(
                  builder: (context) {
    
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10,),
                          item.images.isEmpty ? 
                            Center(child: Image.asset('lib/images/no_photo.png', scale: 2.0, color: firmColor.withOpacity(0.5))) 
                            : 
                            Text('есть фото', style: firm14,),
                          Divider(indent: 20, endIndent: 20, thickness: 1.0, color: firmColor.withOpacity(0.4),),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(color: Colors.blue.shade100.withOpacity(0.5), shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('• Место хранения: ${item.place}', style: firm14,),
                                  const SizedBox(height: 4,),
                                  Text('• Ячейка: ${item.cell}', style: firm14,),
                                  const SizedBox(height: 4,),
                                  Text('• Количество в ячейке: ${item.quantity} ${item.unit}.', style: firm14,),
                                  const SizedBox(height: 4,),
                                  Text('• Количество в резерве: ${item.reserve} ${item.unit}.', style: firm14,),
                                  const SizedBox(height: 4,),
                                  Text('• Статус: ${itemStatus(item.status)}', style: firm14,),
                                  const SizedBox(height: 4,),
                                  Text('• Размер паллета: ${item.palletSize == 'big' ? 'большой' : 'стандартный'}', style: firm14,),
                                  const SizedBox(height: 4,),
                                  Text('• FIFO: ${item.fifo}', style: firm14,),
                                  const SizedBox(height: 4,),
                                  Text('• Принял: ${item.author}', style: firm14,),
                                ],
                              ),
                            ),
                          ),
                          Divider(indent: 20, endIndent: 20, thickness: 1.0, color: firmColor.withOpacity(0.4),),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(color: Colors.blue.shade100.withOpacity(0.1), shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('• Комментарии:' , style: firm14,),
                                  const SizedBox(height: 4,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: item.comment[0] == '' ? Text('комментарии отсутствуют', style: firm14,) : ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: item.comment.length,
                                      itemBuilder: (context, index){
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('${item.comment[index]};', style: firm12,),
                                            const SizedBox(height: 3,)
                                          ],
                                        );
                                      }
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Divider(indent: 20, endIndent: 20, thickness: 1.0, color: firmColor.withOpacity(0.4),),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(color: Colors.blue.shade100.withOpacity(0.3), shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('• Всего на хранении: $totalQuantity ${item.unit}.' , style: firm14,),
                                  const SizedBox(height: 4,),
                                  Text('• Места хранения:' , style: firm14,),
                                  const SizedBox(height: 4,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: data['same_items'].length,
                                      itemBuilder: (context, index){
              
                                        SimSameItems sameItem = SimSameItems(sameItem: data['same_items'][index]);
              
                                        return Row(
                                          children: [
                                            sameItemsIcon(sameItem.status),
                                            const SizedBox(width: 10,),
                                            Expanded(child: Text('${sameItem.info} ${item.unit}. (${sameItem.producer})', style: firm12,))
                                          ],
                                        );
                                      }
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Divider(indent: 20, endIndent: 20, thickness: 1.0, color: firmColor.withOpacity(0.4),),
                        ],
                      ),
                    );
                  }
                ),
              ),
    
    
              floatingActionButton: itemMenu.length == 1 ? const SizedBox.shrink() :
                AnimatedFloatingActionButton(
                  colorStartAnimation: firmColor,
                  colorEndAnimation: Colors.amber,
                  durationAnimation: 300,
                  animatedIconData: AnimatedIcons.menu_close,
                  key: key,
                  fabButtons: itemMenu
                ),
            );
          }
        );
      })
    );
  }
}


Color appBarColor(String status){
  late Color color; 
  if (status == 'work'){ color = const Color(0xFFffd77e); }
  else if (status == 'control'){ color = Colors.blue.shade200; }
  else { color = Colors.red; }
  return color;
}


String itemStatus(String status){
  late String textStatus;
  if (status == 'work'){ textStatus = 'в работе'; }
  else if (status == 'control'){ textStatus = 'на входном контроле'; }
  else { textStatus = 'движение приостановлено'; }
  return textStatus;
}

Widget sameItemsIcon(String status){
  late Widget icon;
  if (status == 'work'){ icon = Icon(MdiIcons.check, size: 20, color: Colors.green); }
  else if ( status == 'stop' ){ icon = Icon(MdiIcons.closeCircle, size: 20, color: Colors.red); }
  else if ( status == 'control' ){ icon = Icon(MdiIcons.timer, size: 20, color: Colors.blue.shade900); }
  else { icon = const SizedBox.shrink(); }
  return icon;
}