
import 'package:battery_2_0/presentation/widgets/app_text_styles.dart';
import 'package:battery_2_0/presentation/widgets/calendar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';


import '../../../../../data/departments/logistic/sim_items_impl.dart';
import '../../../../../domain/models/departments/logistic/sim_items/sim_items.dart';
import '../../../../widgets/app_colors.dart';

class SelectedItemEdit extends StatefulWidget {
  final Map itemData;
  const SelectedItemEdit({super.key, required this.itemData});

  @override
  State<SelectedItemEdit> createState() => _SelectedItemEditState();
}

class _SelectedItemEditState extends State<SelectedItemEdit> {

  

  late SimItems item;
  late Map dataToSave;

  TextEditingController categoryCntr = TextEditingController();
  TextEditingController nameCntr = TextEditingController();
  TextEditingController colorCntr = TextEditingController();
  TextEditingController producerCntr = TextEditingController();
  TextEditingController unitCntr = TextEditingController();
  TextEditingController quantityCntr = TextEditingController();
  TextEditingController dateCntr = TextEditingController();

  @override
  void initState(){
    item = SimItems(item: Map.from(widget.itemData));
    dataToSave = Map.from(widget.itemData);
    categoryCntr.text = dataToSave['category'];
    nameCntr.text = dataToSave['name'];
    colorCntr.text = dataToSave['color'];
    producerCntr.text = dataToSave['producer'];
    unitCntr.text = dataToSave['unit'];
    quantityCntr.text = dataToSave['quantity'].toString();
    dateCntr.text = dataToSave['fifo'];
    super.initState();
  }

  @override
  void dispose(){
    categoryCntr.dispose();
    nameCntr.dispose();
    colorCntr.dispose();
    producerCntr.dispose();
    unitCntr.dispose();
    quantityCntr.dispose();
    dateCntr.dispose();
    super.dispose();
  }



  
  @override
  Widget build(BuildContext context) {

    bool compire = mapEquals(widget.itemData, dataToSave);

    final messenger = ScaffoldMessenger.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () { Navigator.pop(context); },
          icon: Icon(Icons.keyboard_arrow_left, color: firmColor, size: 25,),
        ),
        backgroundColor: Colors.green.shade100,
        title: Text('редактирование', style: firm14,),
      ),
      body: ProgressHUD(
        padding: const EdgeInsets.all(20.0),
        child: Builder(
          builder: (context) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text('Текущие данные:', style: firm16,),
                      const SizedBox(height: 10),
                      Text('категория: ${item.category}', style: firm14,),
                      Text('наименование: ${item.name}', style: firm14,),
                      Text('цвет: ${item.color.isEmpty ? "-" : item.color}', style: firm14,),
                      Text('поствщик: ${item.producer}', style: firm14,),
                      Text('количество: ${item.quantity.toString()} ${item.unit}.', style: firm14,),
                      Text('дата поступления: ${item.fifo}', style: firm14,),
                      Text('размер паллета: ${item.palletSize == 'big' ? 'большой' : 'стандартный'}', style: firm14,),
                      
                      const SizedBox(height: 10),
                      Divider(indent: 0, endIndent: 20, thickness: 1.0, color: firmColor.withOpacity(0.4),),
                      const SizedBox(height: 10),
                      
                      Text('Корректировка данных:', style: firm16,),
                      const SizedBox(height: 10),
                      
                      _enterValue('категория', TextInputType.text, categoryCntr, true, () async {
                        ProgressHUD.of(context)?.showWithText('загрузка');
                        await SimItemsImpl().getCategories(context, categoryCntr).then((value) {
                          ProgressHUD.of(context)?.dismiss();
                          value is List ? 
                            setState((){ 
                              categoryCntr.text.isEmpty || categoryCntr.text == dataToSave['category'] ? null : {
                                dataToSave['category'] = categoryCntr.text,
                                nameCntr.clear(), colorCntr.clear(), producerCntr.clear(), unitCntr.clear()
                              };
                            }) : messenger.toast(value);
                        });
                      }),

                      const SizedBox(height: 8),
                      _enterValue('наименование', TextInputType.text, nameCntr, true, () async {
                        categoryCntr.text.isEmpty ? messenger.toast('укажите категорию') :
                        {
                          ProgressHUD.of(context)?.showWithText('загрузка'),
                          await SimItemsImpl().getNames(context, nameCntr, dataToSave).then((value) {
                            ProgressHUD.of(context)?.dismiss();
                            value is List ? 
                              setState((){ 
                                nameCntr.text.isEmpty || nameCntr.text == dataToSave['name'] ?  null : {
                                  dataToSave['name'] = nameCntr.text,
                                  colorCntr.clear(), producerCntr.clear(), unitCntr.clear()
                                };
                              }) : messenger.toast(value);
                          })
                        };
                      }),

                      const SizedBox(height: 8),
                      _enterValue('цвет', TextInputType.text, colorCntr, true, () async { 
                        categoryCntr.text.isEmpty || nameCntr.text.isEmpty ? messenger.toast('укажите категорию и наименование') : 
                        {
                          ProgressHUD.of(context)?.showWithText('загрузка'),
                          await SimItemsImpl().getColors(context, colorCntr).then((value) {
                            ProgressHUD.of(context)?.dismiss();
                            value is List ? 
                              setState((){ 
                                colorCntr.text.isEmpty || colorCntr.text == dataToSave['name'] ?  null : {
                                  dataToSave['color'] = colorCntr.text,
                                };
                              }) : messenger.toast(value);
                          })
                        };
                      }),

                      const SizedBox(height: 8),
                      _enterValue('поставщик', TextInputType.text, producerCntr, true, () async {
                        categoryCntr.text.isEmpty || nameCntr.text.isEmpty ? messenger.toast('укажите категорию и наименование') : 
                        {
                          ProgressHUD.of(context)?.showWithText('загрузка'),
                          await SimItemsImpl().getProducers(context, producerCntr, dataToSave).then((value) {
                            ProgressHUD.of(context)?.dismiss();
                            value is List ? 
                              setState((){ 
                                producerCntr.text.isEmpty || producerCntr.text == dataToSave['producer'] ?  null : {
                                  dataToSave['producer'] = producerCntr.text,
                                };
                              }) : messenger.toast(value);
                          })
                        };
                      }),

                      const SizedBox(height: 8),
                      _enterValue('ед.изм.', TextInputType.text, unitCntr, true, () async {
                        categoryCntr.text.isEmpty || nameCntr.text.isEmpty || producerCntr.text.isEmpty ? 
                        messenger.toast('укажите категорию, наименование и поставщика') : {
                          ProgressHUD.of(context)?.showWithText('загрузка'),
                          await SimItemsImpl().getUnits(context, unitCntr, dataToSave).then((value) {
                            ProgressHUD.of(context)?.dismiss();
                            value is List ? 
                              setState((){ 
                                unitCntr.text.isEmpty || unitCntr.text == dataToSave['unit'] ?  null : {
                                  dataToSave['unit'] = unitCntr.text,
                                };
                              }) : messenger.toast(value);
                          })
                        };
                      }),

                      const SizedBox(height: 8),
                      _enterValue('количество', TextInputType.number, quantityCntr, false, (){}, (String value){
                        value.isEmpty || int.tryParse(value) == dataToSave['quantity'] ? null :
                        setState((){
                          dataToSave['quantity'] = int.tryParse(value);
                        });
                      }),
                      
                      const SizedBox(height: 8),
                      _enterValue('дата поступления', TextInputType.text, dateCntr, true, () async {
                        ProgressHUD.of(context)?.showWithText('загрузка');
                        await calendar(context, dateCntr).then((_) {
                          ProgressHUD.of(context)?.dismiss();
                          dateCntr.text.isEmpty || dateCntr.text == dataToSave['fifo'] ?  null :
                          setState((){ 
                              dataToSave['fifo'] = dateCntr.text;
                          });
                        });
                      }),
                      const SizedBox(height: 12),


                      categoryCntr.text.isEmpty || nameCntr.text.isEmpty || producerCntr.text.isEmpty || unitCntr.text.isEmpty
                      || compire || quantityCntr.text.isEmpty ? const SizedBox.shrink() :
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                          color: Colors.amber.shade600,
                        ),
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.875,
                        child: TextButton(onPressed: () async {
                          ProgressHUD.of(context)?.showWithText('вносим изменения');
                          await SimItemsImpl().saveEdit(dataToSave, Map.from(widget.itemData)).then((value) {
                            ProgressHUD.of(context)?.dismiss();
                            value == 'done' ? messenger.toast('изменения сохранены') : messenger.toast(value);
                            Navigator.pop(context);
                          });
                        }, child: Text('сохранить', style: firm14,))
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      )
    );
  }

  _enterValue(String leading, TextInputType type, TextEditingController controller, bool readOnly, Function func, [Function? onChange]){
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 20),
      child: Container(
        decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Text('$leading:', style: firm14),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: controller,
                  readOnly: readOnly,
                  keyboardType: type,
                  style: TextStyle(fontSize: 13, color: firmColor),
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                  ),
                  onChanged: (value){ onChange!(value); },
                  onTap: (){ func(); },
                ),
              ),
            ),
          ],
        ),
      ),
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