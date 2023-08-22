



import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:intl/intl.dart';

import '../../../../../data/departments/logistic/sim_items_impl.dart';
import '../../../../../domain/models/departments/logistic/sim_items/sim_items.dart';
import '../../../../widgets/app_colors.dart';
import '../../../../widgets/app_text_styles.dart';
import '../../../../widgets/calendar.dart';
import '../../../../widgets/logistic/sim_storage/selected_item/set_item_status.dart';

class SelectedItemStatus extends StatefulWidget {
  final Map itemData;
  const SelectedItemStatus({super.key, required this.itemData});

  @override
  State<SelectedItemStatus> createState() => _SelectedItemStatusState();
}

class _SelectedItemStatusState extends State<SelectedItemStatus> {

  late SimItems item;
  final DateFormat formatter = DateFormat('dd.MM.yyyy');
  final now = DateTime.now();
  TextEditingController status = TextEditingController();
  TextEditingController comment = TextEditingController();
  TextEditingController document = TextEditingController();
  TextEditingController date =TextEditingController();

  @override
  void initState(){
    item = SimItems(item: Map.from(widget.itemData));
    status.text = _itemStatus(item.status.toString());
    date.text = formatter.format(now);
    super.initState();
  }

  @override
  void dispose(){
    status.dispose();
    comment.dispose();
    document.dispose();
    date.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final messenger = ScaffoldMessenger.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () { Navigator.pop(context); },
          icon: Icon(Icons.keyboard_arrow_left, color: firmColor, size: 25,),
        ),
        backgroundColor: Colors.green.shade100,
        title: Text('статус', style: firm14,),
      ),
      body: ProgressHUD(
        padding: const EdgeInsets.all(20.0),
        child: Builder(
          builder: (context){
            return Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Текущий статус: ', style: firm14,),
                          Flexible(
                            child: Container(
                              decoration: BoxDecoration(color: _statusColor(item.status), shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(3)),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 3, bottom: 5, right: 5, left: 5),
                                child: Text(_itemStatus(item.status), style: firm14,),
                              )
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text('категория: ${item.category}', style: firm14,),
                      Text('наименование: ${item.name}', style: firm14,),
                      Text('цвет: ${item.color.isEmpty ? "-" : item.color}', style: firm14,),
                      Text('поствщик: ${item.producer}', style: firm14,),
                      Text('количество: ${item.quantity.toString()} ${item.unit}.', style: firm14,),
                      Text('дата поступления: ${item.fifo}', style: firm14,),
                      const SizedBox(height: 10),
                      Divider(indent: 0, endIndent: 15, thickness: 1.0, color: firmColor.withOpacity(0.4),),
                      const SizedBox(height: 10),
                
                      Text('Изменение статуса:', style: firm16,),
                      const SizedBox(height: 10),
                
                      _enterValue('статус', TextInputType.text, status, true, () async {
                        ProgressHUD.of(context)?.showWithText('загрузка');
                        await setItemStatus(context, status).whenComplete((){
                          ProgressHUD.of(context)?.dismiss();
                          setState(() {});
                        });
                      }),
                      const SizedBox(height: 8),
                
                      _enterValue('документ', TextInputType.text, document, false, (){ }, (value){ setState(() {}); }),
                      const SizedBox(height: 8),

                      _enterValue('дата', TextInputType.text, date, true, () async {
                        ProgressHUD.of(context)?.showWithText('загрузка');
                        await calendar(context, date).then((value){
                          ProgressHUD.of(context)?.dismiss();
                          setState(() {});
                        });
                      }),
                      const SizedBox(height: 12),

                      status.text == _itemStatus(item.status) || document.text.isEmpty ? const SizedBox.shrink() :
                      Padding(
                        padding: const EdgeInsets.only(left: 0, right: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                            color: Colors.amber.shade600,
                          ),
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: TextButton(onPressed: () async {
                            ProgressHUD.of(context)?.showWithText('меняем статус');
                            String newStatus =  _baseValueStatus(status.text);
                            Map defaultData = {'itemId': item.id, 'default_status': item.status};
                            Map changeData = {'new_status': newStatus, 'document': document.text, 'document_date': date.text};
                            await SimItemsImpl().changeStatus(defaultData, changeData).then((value) {
                              ProgressHUD.of(context)?.dismiss();
                              value == 'done' ? messenger.toast('статус изменен') : messenger.toast(value);
                              Navigator.pop(context);
                            });
                          }, child: Text('изменить сатус', style: firm14,))
                        ),
                      ),
                      const SizedBox(height: 8),


                    ],
                  ),
                ),
              ),
            );
          }
        ),
      ),
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
                  enableInteractiveSelection: false,
                  cursorColor: firmColor,
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

String _itemStatus(String status){
  late String textStatus;
  if (status == 'work'){ textStatus = 'в работе'; }
  else if (status == 'control'){ textStatus = 'на входном контроле'; }
  else { textStatus = 'движение приостановлено'; }
  return textStatus;
}

String _baseValueStatus(String status){
  late String textStatus;
  if (status == 'в работе'){ textStatus = 'work'; }
  else if (status == 'на входном контроле'){ textStatus = 'control'; }
  else { textStatus = 'stop'; }
  return textStatus;
}

Color _statusColor(String status){
  late Color color; 
  if (status == 'work'){ color = Colors.green.shade100; }
  else if (status == 'control'){ color = Colors.blue.shade100; }
  else { color = Colors.red; }
  return color;
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