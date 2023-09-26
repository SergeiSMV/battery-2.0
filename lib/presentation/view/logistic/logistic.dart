



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data/departments/departments_in_impl.dart';
import '../../../data/providers/user/user_accesses_provider.dart';
import '../../widgets/app_colors.dart';
import '../../widgets/app_text_styles.dart';

class Logistic extends ConsumerWidget {
  const Logistic({super.key});

  

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final allUserAccesses = ref.watch(allAccessesProvider);
    List logisticAccesses = DepartmentsInImpl().departmentsAccesses(allUserAccesses.value, 'департамент логистики');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.keyboard_arrow_left, color: firmColor, size: 25,),
        ),
        iconTheme: IconThemeData(color: firmColor),
        backgroundColor: Colors.green.shade100,
        title: Text('департамент логистики', style: firm14,),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: logisticAccesses.length,
                shrinkWrap: true,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5, bottom: 8),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.blue.shade50.withOpacity(0.5), shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(5)),
                      child: ListTile(
                        leading: Text(logisticAccesses[index]['description'], style: firm14,),
                        onTap: (){
                          context.push(logisticAccesses[index]['route']);
                        },
                      ),
                    ),
                  );
                }
              ),
            ),
          ),
        ],
      )
    );
  }
}