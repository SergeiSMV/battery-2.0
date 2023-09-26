import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../../../../../data/providers/logistic/sim/sim_selected_item_history_provider.dart';
import '../../../../widgets/app_colors.dart';
import '../../../../widgets/app_text_styles.dart';


class SelectedItemHistory extends ConsumerWidget {
  final String itemId;
  const SelectedItemHistory({super.key, required this.itemId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final historyList = ref.watch(simSelectedItemHistoryProvider(itemId));

    return Consumer(
      builder: ((context, ref, child) {
        return historyList.when(
          loading: () => const Scaffold(body: Center(child: CircularProgressIndicator(strokeWidth: 2.0,))),
          error: (error, _) => Text(error.toString()),
          data: (data) {

            final DateFormat formatter = DateFormat('dd.MM.yyyy');

            return Scaffold(
              appBar: AppBar(
                elevation: 1,
                leading: IconButton(
                  onPressed: () { Navigator.pop(context); },
                  icon: Icon(Icons.keyboard_arrow_left, color: firmColor, size: 25,),
                ),
                backgroundColor: Colors.green.shade100,
                title: Text('история', style: firm14,),
              ),
              body: data.isEmpty ? Center(child: Text('нет истории', style: firm14,)) :
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 5,),
                    Expanded(
                      child: GroupedListView(
                        elements: data, 
                        groupBy: (element) => element['format_date'],
                        groupComparator: (value1, value2) => value1.compareTo(value2),
                        order: GroupedListOrder.DESC,
                        useStickyGroupSeparators: true,
                        floatingHeader: true,
                        groupSeparatorBuilder: (value) => Container(
                          color: Colors.transparent,
                          height: 25,
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.8), shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
                                child: Text(formatter.format(value).toString(), style: white14,),
                              )
                            )
                          ),
                        ),
                                          
                        itemBuilder: (context, element) {
                          return Card(
                            elevation: 1.0,
                            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                            child: SizedBox(
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                title: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(element['action'], style: firm14,),
                                    Text(element['comment'], style: firm12,),
                                    const SizedBox(height: 3,),
                                    Text('автор: ${element['author']}', style: grey12,),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
            );
          }
        );
      })
    );
  }
}