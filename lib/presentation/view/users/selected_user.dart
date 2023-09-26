import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/bloc/users/users_accesses_bloc.dart';
import '../../../data/providers/users/users_accesses_provider.dart';
import '../../../data/users/users_impl.dart';
import '../../../domain/models/selected_user_accesses/selected_user_accesses.dart';
import '../../widgets/app_colors.dart';
import '../../widgets/app_text_styles.dart';

class SelectedUser extends ConsumerWidget {
  final String userId;
  final String name;
  final String surname;
  final String patronymic;
  final String position;
  final String department;
  const SelectedUser({super.key, 
    required this.userId, 
    required this.name, 
    required this.surname, 
    required this.patronymic,
    required this.position,
    required this.department
  });

  

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final userAccesses = ref.watch(usersAccessesProvider(userId));
    final newAccesses = ref.watch(newAccessesProvider);

    return ProgressHUD(
      padding: const EdgeInsets.all(20.0),
      child: Builder(
        builder: (context) {
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
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$surname $name $patronymic', style: firm14,),
                  Text(position, style: firm10,),
                  Text(department, style: firm10,),
                ],
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 5,),
                  Expanded(
                    child: Consumer(
                      builder: ((context, ref, child) {
                        return userAccesses.when(
                          error: (error, _) => Text(error.toString()),
                          loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 2.0,)),
                          data: (data) => BlocProvider<UsersAccessesBloc>(
                            create: (context) => UsersAccessesBloc()..add(UsersAccessesChange(data: data)),
                            child: BlocBuilder<UsersAccessesBloc, List>(
                              builder: ((context, state){
                                return Builder(
                                  builder: (context) {
                                    return ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: state.length,
                                      itemBuilder: (context, index) {
  
                                        bool isSwitched = state[index]['access'] == 1 ? true : false;
                                        SelectedUserAccesses access = SelectedUserAccesses(userAccesses: state[index]);
                                        
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 5, right: 5, bottom: 8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: isSwitched ? Colors.blue.shade50.withOpacity(0.5) : Colors.white, 
                                              shape: BoxShape.rectangle, 
                                              borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: ListTile(
                                              title: Padding(
                                                padding: const EdgeInsets.only(top: 3, bottom: 3),
                                                child: Text(access.description, style: isSwitched ? firm14 : grey12),
                                              ),
                                              subtitle: Text(access.depence, style: grey12),
                                              trailing: Switch(
                                                activeColor: firmColor,
                                                value: isSwitched,
                                                onChanged: (value) {
                                                  value ? state[index]['access'] = 1 : state[index]['access'] = 0;
                                                  context.read<UsersAccessesBloc>().add(UsersAccessesChange(data: state.toList()));
                                                  ref.read(newAccessesProvider.notifier).state = state.toList();
                                                },
                                              ),
                                              onTap: () {
                                                isSwitched ? state[index]['access'] = 0 : state[index]['access'] = 1;
                                                context.read<UsersAccessesBloc>().add(UsersAccessesChange(data: state.toList()));
                                                ref.read(newAccessesProvider.notifier).state = state.toList();
                                              },
                                            ),
                                          ),
                                        );
                                      }
                                    );
                                  }
                                );
                              })
                            ),
                          )
                        );
                      })
                    ),
                  ),
                ],
              )
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () async {
                final progress = ProgressHUD.of(context);
                progress?.show();
                final messenger = ScaffoldMessenger.of(context);
                Map saveData = {'user_id': userId, 'accesses': newAccesses};
                await UsersImpl().saveUserAccesses(saveData).then((value) => {
                  value == 'done' ? {
                    messenger.toast('сохранено'),
                    Future.delayed(const Duration(seconds: 1)).then((value) {progress?.dismiss(); Navigator.pop(context);}),
                  } : {
                    messenger.toast('ошибка сохранения'),
                    Future.delayed(const Duration(seconds: 1)).then((value) => progress?.dismiss()),
                  },
                });
              },
              backgroundColor: Colors.amber,
              label: Text('сохранить', style: firm12,),
              icon: Icon(Icons.save, color: firmColor,),
            ),
          );
        }
      ),
    );
  }
}

extension on ScaffoldMessengerState {
  void toast(String message){
    showSnackBar(
      SnackBar(
        content: Center(child: Text(message)), 
        duration: const Duration(seconds: 2),
      )
    );
  }
}
