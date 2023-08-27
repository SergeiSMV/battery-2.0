import 'package:battery_2_0/domain/models/user/user.dart';
import 'package:battery_2_0/presentation/widgets/app_colors.dart';
import 'package:battery_2_0/presentation/widgets/app_text_styles.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../data/departments/departments_in_impl.dart';
import '../../data/user/device_impl.dart';
import '../../data/providers/user/user_accesses_provider.dart';
import '../../data/user/user_impl.dart';
import '../../domain/repository/departments/accesses_names.dart';
import '../../local_services.dart';



class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  ConsumerState  <Home> createState() => _Home();
}



class _Home extends ConsumerState <Home> {

  @override
  void initState(){
    super.initState();
    _listenNotification();
  }

  _listenNotification(){
    FirebaseMessaging.onMessage.listen((message) {
      if(message.notification != null){
        LocalNotificationServices.createNotification(message);
      } else { null; }
    });
  }

  @override
  Widget build(BuildContext context) {

    final allUserAccesses = ref.watch(allAccessesProvider);
    final chaptersAccess = ref.watch(otherChaptersAccess);
    final User user = User(userInfoData: UserImpl().savedUserInfo());
    final messenger = ScaffoldMessenger.of(context);

    return Scaffold(
      body: ProgressHUD(
        padding: const EdgeInsets.all(20.0),
        child: Builder(
          builder: (context) {
            return Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('lib/images/tunglogo.png'), opacity: 0.3, scale: 4.0, alignment: Alignment(0, -0.7),)),
                ),
                Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 100,),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('${user.name} ${user.patronymic} ${user.surname}', style: firm18),
                              Text(user.position, style: firm12),
                              Text(user.department, style: firm12),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: Consumer(
                            builder: ((context, ref, child) {
                              return allUserAccesses.when(
                                error: (error, _) => Text(error.toString()), 
                                loading: () => CircularProgressIndicator(strokeWidth: 2.0, color: firmColor,),
                                data: (data) => Builder(
                                  builder: (context){ 
      
                                    List departments = UserImpl().departmentsAccess(data);
      
                                    return departments.isNotEmpty ? 
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: departments.length,
                                        itemBuilder: (context, index){
                                          var department = departments[index];
                                          return Padding(
                                            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
                                            child: Container(
                                              decoration: BoxDecoration(color: Colors.blue.shade50.withOpacity(0.5), shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(5)),
                                              child: ListTile(
                                                title: Text(department.description, style: firm14),
                                                onTap: (){
                                                  int inChapters = DepartmentsInImpl().inQuantity(allUserAccesses.value, department.description);
                                                  List singleChapter = DepartmentsInImpl().departmentsAccesses(allUserAccesses.value, department.description);
                                                  inChapters == 1 ? context.push(singleChapter[0]['route']) : context.push(department.route);
                                                },
                                              ),
                                            ),
                                          );
                                        }
                                      )
                                    :
                                    Center(
                                      child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 250, width: 250, child: Lottie.asset('lib/images/lottie/stop.json')),
                                        Text('нет доступа ни к одному департаменту', style: firm16,),
                                        ],
                                      )
                                    );
                                  }
                                )
                              );
                            })
                          ),
                        ),
                        const SizedBox(height: 30,),
                        Center(
                          child: SizedBox(
                            width: 200,
                            height: 35,
                            child: TextButton(
                              onPressed: () async {
                                ProgressHUD.of(context)?.showWithText('завершение сеанса');
                                await UserImpl().exitAccount().then((value){
                                  ProgressHUD.of(context)?.dismiss();
                                  value == 'done' ? {
                                    DeviceImpl().clearCurrentDeviceId(),
                                    UserImpl().clearUserInfo(),
                                    context.pushReplacement('/')
                                  } : messenger._toast(value);
                                });
                              }, 
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(MdiIcons.exitRun, size: 20, color: firmColor),
                                    const SizedBox(width: 10,),
                                    Text('выход', style: firm14,),
                                  ],
                                )
                              )
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
      
                        chaptersAccess.contains(allUsers) ? 
      
                          Center(
                            child: SizedBox(
                              width: 200,
                              height: 35,
                              child: TextButton(
                                onPressed: (){
                                  context.push('/all_users');
                                }, 
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(MdiIcons.accountMultiple, size: 20, color: firmColor),
                                      const SizedBox(width: 10,),
                                      Text('пользователи', style: firm14,),
                                    ],
                                  )
                                )
                              ),
                            ),
                          )
                         : const SizedBox.shrink()
                      ],
                    ),
                  )
                ),
              ],
            );
          }
        ),
      ),
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