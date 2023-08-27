
import 'package:battery_2_0/presentation/widgets/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../data/bloc/logistic/sim_items_bloc.dart';
import '../../../../data/departments/logistic/sim_items_impl.dart';
import '../../../../data/departments/logistic/sim_storage_impl.dart';
import '../../../../data/providers/logistic/sim/items_print_provider.dart';
import '../../../../data/providers/logistic/sim/sim_items_provider.dart';
import '../../../../data/providers/user/user_accesses_provider.dart';
import '../../../../domain/models/departments/logistic/sim_menu_values.dart';
import '../../../../domain/models/departments/logistic/sim_items/sim_items.dart';
import '../../../widgets/app_colors.dart';
import 'sim_settings/sim_setting_nm.dart';

class SimCatalog extends ConsumerStatefulWidget {
  const SimCatalog({super.key});

  @override
  ConsumerState<SimCatalog> createState() => _SimCatalogState();
}

class _SimCatalogState extends ConsumerState<SimCatalog> {


  final TextEditingController searchController = TextEditingController();
  bool searchIsActive = false;
  bool showCheckboxes = false;
  bool selectedContainer = false;
  late double searchContainerHeight = searchIsActive ? 100.0 : 0.0;


  @override
  void dispose(){
    searchController.clear();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final allSimItems = ref.watch(simItemsProvider);
    final selectedItems = ref.watch(itemsPrintProvider);
    final allUserAccesses = ref.watch(allAccessesProvider).value;
    bool settingAccess = SimStorageImpl().storageSettingButton(allUserAccesses!);
    
    return BlocProvider<SimItemsBloc>(
      create: (context) => SimItemsBloc(),
      child: Builder(
        builder: (context) {

          List itemsState = context.watch<SimItemsBloc>().state;

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
              title: Text('склад СиМ', style: firm14,),
              actions: [

                // настройки
                settingAccess ?

                IconButton(
                  onPressed: (){ 
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SimSettingNomenclature()));
                  }, 
                  icon: Icon(MdiIcons.alphaNBox, size: 25, color: firmColor),
                )
                : const SizedBox.shrink(),
                
                // поиск
                IconButton(
                  onPressed: (){ 
                    setState(() {
                      searchIsActive = !searchIsActive;
                      searchIsActive ? null : searchController.clear();
                    });
                  }, 
                  icon: Icon(MdiIcons.magnify, size: 25, color: firmColor),
                ),
                
                // фильтр комплектующих
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: PopupMenuButton(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    icon: Icon(MdiIcons.filter, size: 25, color: firmColor),
                    onSelected: (value){ SimItemsImpl().filterItems(context, itemsState, value); },
                    itemBuilder: (BuildContext context) { 
                      return FilterItems.choices.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice, style: firm12,),
                        );
                      }).toList();
                    },
                  )
                ),
              ],
            ),
            
            body: ProgressHUD(
              padding: const EdgeInsets.all(20.0),
              child: Builder(
                builder: (context) {
                  return Center(
                    child: Column(
                      children: [
            
                        // контейнер поиска
                        AnimatedContainer(
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                blurRadius: 2.0,
                                spreadRadius: 0.0,
                                offset: const Offset(2.0, 2.0),
                              )
                            ],
                          ),
                          curve: Curves.easeInOut,
                          duration: const Duration(milliseconds: 400),
                          height: searchIsActive ? 80.0 : 0.0,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: searchIsActive ? 
                                TextField(
                                  autofocus: false,
                                  controller: searchController,
                                  style: const TextStyle(fontSize: 15, color: Color(0xFF095D82), overflow: TextOverflow.ellipsis),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'поиск',
                                    contentPadding: const EdgeInsets.only(bottom: 15.0, left: 25),
                                    isDense: true,
                                    hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: firmColor.withOpacity(0.8), 
                                        width: 3,
                                      ), 
                                      borderRadius: const BorderRadius.all(Radius.circular(20.0))
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: firmColor.withOpacity(0.8), 
                                        width: 2,
                                      ), 
                                      borderRadius: const BorderRadius.all(Radius.circular(20.0))
                                    ),
                                    prefixIcon: Icon(MdiIcons.magnify, size: 25, color: firmColor,),
                                    suffixIcon: searchController.text.isEmpty ? 
                                      const SizedBox.shrink() 
                                      :
                                      IconButton(
                                        splashRadius: 20, 
                                        onPressed: (){
                                          context.read<SimItemsBloc>().add(SimStorageClearSearchEvent());
                                          searchController.clear(); 
                                          setState(() {});
                                        }, 
                                        icon: const Icon(Icons.clear, color: Color(0xFF095D82)))
                                  ),
                                  onChanged: (text){
                                    text = text.toLowerCase();
                                    context.read<SimItemsBloc>().add(SimStorageSearchEvent(text: text));
                                  },        
                                ) 
                                : 
                                const SizedBox.shrink(),
                            ),
                          ),
                        ),
            
                        // контейнер выбора ТМЦ на печать
                        AnimatedContainer(
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                blurRadius: 2.0,
                                spreadRadius: 0.0,
                                offset: const Offset(2.0, 2.0), // shadow direction: bottom right
                              )
                            ],
                          ),
                          curve: Curves.easeInOut,
                          duration: const Duration(milliseconds: 400),
                          height: selectedContainer ? 50.0 : 0.0,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: selectedContainer ? 
                                Row(
                                  children: [
                                    // количество ТМЦ на печать
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Text('на печать ${selectedItems.length} ед.', style: firm14,),
                                    ),

                                    const Expanded(child: SizedBox(width: 5,)),
                                    
                                    // печать - отправка на почту
                                    selectedItems.isNotEmpty ? 
                                      IconButton(
                                        onPressed: () async {
                                          final messenger = ScaffoldMessenger.of(context);
                                          final progress = ProgressHUD.of(context);
                                          progress?.showWithText('отправляем...');
                                          await SimItemsImpl().sendQrCodes(selectedItems.toList()).then((value) {
                                            value == 'done' ? {
                                              selectedContainer = !selectedContainer,
                                              selectedItems.clear(),
                                              showCheckboxes = !showCheckboxes,
                                              progress?.dismiss(),
                                              messenger.toast('успешно отправлено на печать')
                                            } : messenger.toast('ошибка отправки');
                                          });
                                          setState(() {
                                          });
                                        }, 
                                      icon: Icon(MdiIcons.printer, size: 25, color: firmColor)) 
                                      : 
                                      const SizedBox.shrink(),
                                    
                                    // иконка очистки или массового выбора
                                    Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: IconButton(onPressed: (){ 
                                        setState(() {
                                          selectedItems.isNotEmpty ? 
                                            selectedItems.clear() 
                                            : 
                                            {
                                              selectedItems.clear(),
                                              selectedItems.addAll(itemsState),
                                            };
                                        });
                                      }, 
                                      icon: selectedItems.isNotEmpty ? Icon(MdiIcons.minusBoxMultiple, size: 25, color: firmColor) : Icon(MdiIcons.plusBoxMultiple, size: 25, color: firmColor)),
                                    ),
                                  ],
                                ) 
                              
                              : const SizedBox.shrink(),
                            ),
                          ),
                        ),
            
                        const SizedBox(height: 10,),
                        
                        // список комплектующих
                        Expanded(
                          child: Consumer(
                            builder: ((context, ref, child) {
                              return allSimItems.when(
                                error: (error, _) => Center(child: Text('${error.toString()}\nОбратитесь к администратору!')),
                                loading: () => Center(child: CircularProgressIndicator(strokeWidth: 2.0, color: firmColor,)),
                                data: (data) => Builder(
                                  
                                  builder: (context){
                                    searchIsActive ? null : context.read<SimItemsBloc>().add(InitSimItemsEvent(data: data));           
                                    return BlocBuilder<SimItemsBloc, List>(
                                      builder: ((context, state) {
                                        return ListView.builder(
                                          physics: const BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: state.length,
                                          itemBuilder: (context, index){
                                            SimItems item = SimItems(item: state[index]);
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
                                                  child: GestureDetector(
                                                    onLongPress: (){ 
                                                      setState(() {
                                                        selectedContainer = !selectedContainer;
                                                        selectedItems.clear();
                                                        showCheckboxes = !showCheckboxes;
                                                      });
                                                    },
                                                    child: ListTile(
                                                      trailing: 
                                                      showCheckboxes ? 
                                                        Checkbox(
                                                          checkColor: Colors.white,
                                                          activeColor: firmColor,
                                                          value: selectedItems.contains(state[index]) ? true : false,
                                                          onChanged: (_) {
                                                            selectedItems.contains(state[index]) ?
                                                              selectedItems.removeWhere((element) => element['itemId'] == state[index]['itemId'])
                                                              :
                                                              selectedItems.add(state[index]);
                                                              setState(() { });
                                                          }
                                                        )
                                                        :
                                                        item.palletSize == 'big' ? Icon(MdiIcons.imageSizeSelectSmall, size: 15, color: Colors.grey.shade500) : const SizedBox.shrink(),
                                                      
                                                      visualDensity: const VisualDensity(vertical: -4),
                                                      tileColor: Colors.white,
                                                      leading: SizedBox(
                                                        height: double.infinity, 
                                                        child: CircleAvatar(
                                                          radius: 25,
                                                          backgroundColor: leadingColor(item.status), 
                                                          child: Text(item.cell, style: firm10, textAlign: TextAlign.center,)
                                                        )
                                                      ),
                                                      title: Text(item.fullName, style: firm12),
                                                      subtitle: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('поставщик: ${item.producer}', style: firm10),
                                                          Text('количество на остатке: ${item.quantity.toString()} ${item.unit}', style: firm10),
                                                          Text('FIFO: ${item.fifo}', style: firm10),
                                                        ],
                                                      ),
                                                      onTap: () {
                                                        context.pushNamed('selected_item', pathParameters: {'itemId': item.id}, extra: context);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        );
                                      })
                                    );
                                    
                                  }
                                ),
                              );
                            })
                          ),
                        ),
                      ],
                    ),
                  );
                }
              ),
            ),
          );
        }
      )
    );
  }
}

extension on ScaffoldMessengerState {
  void toast(String message){
    showSnackBar(
      SnackBar(
        content: Text(message), 
        duration: const Duration(seconds: 4),
      )
    );
  }
}

Color leadingColor(String status){
  late Color color; 
  if (status == 'work'){
    color = Colors.transparent;
  }
  else if (status == 'stop') {
    color = Colors.deepOrange.shade200;
  }
  else if (status == 'control') {
    color = Colors.blue.shade200;
  }
  return color;
}