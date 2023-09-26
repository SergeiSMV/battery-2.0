





import 'package:battery_2_0/domain/models/user/user.dart';
import 'package:battery_2_0/presentation/widgets/app_colors.dart';
import 'package:battery_2_0/presentation/widgets/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data/providers/user/user_accesses_provider.dart';
import '../../../data/providers/users/all_users_provider.dart';
import '../../../domain/repository/departments/accesses_names.dart';

class AllUsers extends ConsumerWidget {
  const AllUsers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final users = ref.watch(allUsersProvider);
    final chaptersAccess = ref.watch(otherChaptersAccess);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon:Icon(Icons.keyboard_arrow_left, color: firmColor, size: 25,), 
        ),
        iconTheme: IconThemeData(
          color: firmColor,
        ),
        backgroundColor: Colors.green.shade100,
        title: Text('все пользователи', style: firm14,),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10,),
          Consumer(
            builder: ((context, ref, child) {
              return users.when(
                error: (error, _) => Text(error.toString()), 
                loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 1.0,)),
                data: (data) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index){
                    var user = User(userInfoData: data[index]);
                    return Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.blue.shade50.withOpacity(0.5), shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(5)),
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(top: 3, bottom: 3),
                            child: Text('${user.surname} ${user.name} ${user.patronymic}', style: firm12),
                          ),
                          subtitle: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user.position, style: grey12),
                              Text(user.department, style: grey12),
                            ],
                          ),
                          onTap: (){

                            chaptersAccess.contains(usersSettings) ?

                            context.pushNamed('selected_user', pathParameters: {
                              'id': user.id,
                              'name': user.name,
                              'surname': user.surname,
                              'patronymic': user.patronymic,
                              'position': user.position,
                              'department': user.department
                            }) : null;
                          },
                        ),
                      ),
                    );
                  }
                ),
              );
            }
          )
          ),
        ],
      ));
  }
}