import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../../data/bloc/logistic/sim_order_cart_bloc.dart';
import '../../../../../data/bloc/logistic/sim_uniq_items_bloc.dart';
import '../../../../../data/departments/logistic/sim_orders_impl.dart';
import '../../../../../domain/models/departments/logistic/sim_items/sim_items.dart';
import '../../../../widgets/app_colors.dart';
import '../../../../widgets/app_text_styles.dart';
import 'sim_order_dialog.dart';
import 'sim_order_edit_dialog.dart';


class SimOrderAdd extends StatefulWidget {
  final List uniqItems;
  const SimOrderAdd({super.key, required this.uniqItems});

  @override
  State<SimOrderAdd> createState() => _SimOrderAddState();
}


class _SimOrderAddState extends State<SimOrderAdd> {

  final TextEditingController searchController = TextEditingController();
  bool searchIsActive = false;
  late double searchContainerHeight = searchIsActive ? 100.0 : 0.0;
  bool isShowCart = false;

  @override
  void dispose(){
    searchController.clear();
    searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<SimOrderCartBloc>(create: (context) => SimOrderCartBloc()),
        BlocProvider<SimUniqItemsBloc>(create: (context) => SimUniqItemsBloc()..add(InitUniqItemsEvent(data: widget.uniqItems))),
      ], 
      child: Builder(
        builder: (context){

          List cart = context.watch<SimOrderCartBloc>().state;
          List uniqItems = context.watch<SimUniqItemsBloc>().state;
          final messenger = ScaffoldMessenger.of(context);

          return Scaffold(
            appBar: AppBar(
              elevation: 1,
              leading: IconButton(
                onPressed: () { Navigator.pop(context); },
                icon: Icon(Icons.keyboard_arrow_left, color: firmColor, size: 25,),
              ),
              backgroundColor: Colors.green.shade100,
              title: Text('новая заявка', style: firm14,),
              actions: [
                // поиск
                Padding(
                  padding: const EdgeInsets.only(right: 17),
                  child: IconButton(
                    onPressed: (){ 
                      setState(() {
                        searchIsActive = !searchIsActive;
                        searchIsActive ? null : searchController.clear();
                      });
                    }, 
                    icon: Icon(MdiIcons.magnify, size: 25, color: firmColor),
                  ),
                ),
              ],
            ),
            
            body: ProgressHUD(
              padding: const EdgeInsets.all(20.0),
              child: Builder(
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      
                      // контейнер поиска
                      AnimatedContainer(
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
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
                                      width: 1,
                                    ), 
                                    borderRadius: const BorderRadius.all(Radius.circular(5.0))
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: firmColor.withOpacity(0.8), 
                                      width: 1,
                                    ), 
                                    borderRadius: const BorderRadius.all(Radius.circular(5.0))
                                  ),
                                  prefixIcon: Icon(MdiIcons.magnify, size: 25, color: firmColor,),
                                  suffixIcon: searchController.text.isEmpty ? 
                                    const SizedBox.shrink() 
                                    :
                                    IconButton(
                                      splashRadius: 20, 
                                      onPressed: (){
                                        context.read<SimUniqItemsBloc>().add(UniqItemsClearSearchEvent());
                                        searchController.clear(); 
                                        setState(() {});
                                      }, 
                                      icon: const Icon(Icons.clear, color: Color(0xFF095D82)))
                                ),
                                onChanged: (text){
                                  text = text.toLowerCase();
                                  context.read<SimUniqItemsBloc>().add(UniqItemsSearchEvent(text: text));
                                },        
                              ) 
                              : 
                              const SizedBox.shrink(),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10,),

                      Expanded(
                        child: BlocBuilder<SimOrderCartBloc, List>(
                          builder: ((context, state){

                            return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: uniqItems.length,
                              itemBuilder: (context, index){

                                SimItems item = SimItems(item: uniqItems[index]);
                                Color cardColor = SimOrdersImpl().uiCheckQuantity(state, uniqItems[index]) == -1 ? Colors.white : Colors.orange.shade50;
                                int quantity = SimOrdersImpl().uiCheckQuantity(state, uniqItems[index]) == -1 ? uniqItems[index]['quantity'] : 
                                  SimOrdersImpl().uiCheckQuantity(state, uniqItems[index]);
                                String comment = SimOrdersImpl().uiGetComment(state, uniqItems[index]);
                                int inOrder = uniqItems[index]['quantity'] - quantity;

                                return Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: cardColor,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 1, blurRadius: 1, offset: const Offset(0, 2))]
                                    ),
                                    child: Padding(
                                      // padding: const EdgeInsets.all(5.0),
                                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                                      child: ListTile(
                                        visualDensity: const VisualDensity(vertical: -4),
                                        tileColor: Colors.white,
                                        title: Text(item.fullName, style: firm12),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('поставщик: ${item.producer}', style: firm10),
                                            Text('доступно:  $quantity ${item.unit}', style: firm10),
                                            SimOrdersImpl().uiCheckQuantity(state, uniqItems[index]) == -1 ? const SizedBox.shrink() : 
                                              Text('заказано:  $inOrder ${item.unit}', style: firm10),
                                            comment.isEmpty ? const SizedBox.shrink() : Text('комментарий:  $comment', style: firm10),
                                          ],
                                        ),
                                        trailing: SimOrdersImpl().uiCheckQuantity(state, uniqItems[index]) == -1 ? const SizedBox.shrink() : 
                                          IconButton(icon: Icon(MdiIcons.fileDocumentEdit, size: 25, color: Colors.grey.shade700), onPressed: () { 
                                            simOrderEditDialog(context, uniqItems[index], quantity, inOrder, comment);
                                          } 
                                          ),
                                        onTap: () {
                                          quantity == 0 ? messenger._toast('Нет остатка на складе. При необходимости отредактируйте позицию.')
                                          :
                                          simOrderDialog(context, uniqItems[index], quantity);
                                        }
                                      ),
                                    ),
                                  ),
                                );
                              }
                            );
                          }),
                        ),
                      ),

                      const SizedBox(height: 5),

                      cart.isEmpty || !isShowCart ? const SizedBox.shrink() : 
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 80, bottom: 23),
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(color: mainColor, shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(5)),
                          child: TextButton(
                            onPressed: () async { 
                              ProgressHUD.of(context)?.showWithText('отправляем');
                              await SimOrdersImpl().sendNewOrder(cart).then((value){
                                ProgressHUD.of(context)?.dismiss();
                                value == 'done' ? messenger._toast('заявка суспешно создана') : messenger._toast(value);
                                Navigator.pop(context);
                              });
                            }, 
                            child: Text('отправить', style: white14)
                          )
                        ),
                      ),

                    ],
                  );
                }
              ),
            ),

            floatingActionButton:
            cart.isEmpty ? const SizedBox.shrink() :
            FloatingActionButton(
              elevation: 3,
              onPressed: () {
                isShowCart ? context.read<SimUniqItemsBloc>().add(UniqItemsClearSearchEvent()) : 
                  context.read<SimUniqItemsBloc>().add(CartContentEvent(cart: cart.toList()));
                setState((){ isShowCart = !isShowCart; });
              },
              backgroundColor: Colors.amber,
              child: isShowCart ? Icon(MdiIcons.close, size: 30, color: firmColor) :  Icon(MdiIcons.fileDocument, size: 30, color: firmColor),
            )

          );
        }
      )
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