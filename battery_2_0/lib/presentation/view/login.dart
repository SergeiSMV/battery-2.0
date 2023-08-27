import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:go_router/go_router.dart';

import '../../data/user/login_impl.dart';
import '../widgets/app_text_styles.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final identifier = TextEditingController();
  final password = TextEditingController();
  bool saveDevice = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressHUD(
        padding: const EdgeInsets.all(20.0),
        child: Builder(
          builder: (context) {

            return Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    children: [
                      Image.asset('lib/images/tunglogo.png', scale: 5.0,),
                      const SizedBox(height: 30),
      
                      Padding(
                        padding: const EdgeInsets.only(left: 35, right: 35),
                        child: SizedBox(
                          height: 35,
                          width: 310,
                          child: TextField(
                            controller: identifier,
                            style: firm18,
                            minLines: 1,
                            obscureText: false,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10.0),
                              hintStyle: grey14,
                              hintText: 'идентификатор',
                              prefixIcon: const IconTheme(data: IconThemeData(color: Color(0xFF78909C)), child: Icon(Icons.person)),
                              isCollapsed: true),
                            onChanged: (value) { 
                              setState(() {});
                            },
                          ),
                        ),
                      ),
      
                      const SizedBox(height: 10),
      
                      Padding(
                        padding: const EdgeInsets.only(left: 35, right: 35),
                        child: SizedBox(
                          height: 35,
                          width: 310,
                          child: TextField(
                            controller: password,
                            style: firm18,
                            minLines: 1,
                            obscureText: true,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10.0),
                              hintStyle: grey14,
                              hintText: 'пароль',
                              prefixIcon: const IconTheme(data: IconThemeData(color: Color(0xFF78909C)), child: Icon(Icons.lock)),
                              isCollapsed: true),
                            onChanged: (value) { 
                              setState(() {});
                            },
                          ),
                        ),
                      ),
      
                      const SizedBox(height: 15,),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 30, right: 30),
                      //   child: CheckboxListTile(
                      //     activeColor: firmColor,
                      //     title: Text('сохранить данные для входа', style: firm12,),
                      //     subtitle: Text('* автоматический вход при следующем посещении', style: grey10),
                      //     value: saveDevice, 
                      //     onChanged: (value){
                      //       if (mounted){
                      //         setState(() {
                      //           saveDevice = value!;
                      //         });
                      //       }
                      //     }
                      //   ),
                      // ),
                      const SizedBox(height: 20),
                      identifier.text.isEmpty || password.text.isEmpty ? const SizedBox.shrink() :
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: TextButton(
                          child: Center(
                            child: Container(
                              height: 35,
                              decoration: BoxDecoration(color: const Color(0xFFff8c00), borderRadius: BorderRadius.circular(5)), 
                              child: const Center(child: Text('вход', style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),))
                            ),
                          ),
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            final progress = ProgressHUD.of(context);
                            progress?.showWithText('проверка...');
                            final messenger = ScaffoldMessenger.of(context);
                            await LoginImpl(userData: {'login': identifier.text, 'password': password.text}, autoLogin: saveDevice,).login().then((value){
                              value == 'доступ разрешен' ? context.pushReplacement('/home') : messenger.toast(value);
                            });
                          }, 
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: SizedBox(
                          child: Text(
                            'Unconditional user is Logistics Department by LLC RAZ "Tungstone". '
                            'Customer: I.V.Kortnev Director of the Logistics Department LLC RAZ "Tungstone", kortnev@tungstone.ru '
                            'All rights owned by S.S.Semenov, fluthon313@gmail.com, 2023',
                            style: grey10,
                            textAlign: TextAlign.center
                          ),
                        ),
                      ),
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
}

extension on ScaffoldMessengerState {
  void toast(String message){
    showSnackBar(
      SnackBar(
        content: Center(child: Text(message)), 
        duration: const Duration(seconds: 4),
      )
    );
  }
}