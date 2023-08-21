import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grouped_list/grouped_list.dart';

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
                GroupedListView(
                  elements: data, 
                  groupBy: (element) => element['date'],
                  groupComparator: (value1, value2) => value1.compareTo(value2),
                  order: GroupedListOrder.DESC,
                  useStickyGroupSeparators: true,
                  groupSeparatorBuilder: (String value) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(value, textAlign: TextAlign.center, 
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  itemBuilder: (c, element) {
                    return Card(
                      elevation: 8.0,
                      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                      child: SizedBox(
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          title: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(element['action'], style: firm14,),
                              Text(element['comment'], style: firm14,),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
            );
          }
        );
      })
    );
  }
}