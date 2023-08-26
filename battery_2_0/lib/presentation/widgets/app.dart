
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../local_services.dart';
import 'router.dart';


class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {


  @override
  void initState() {
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
    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white.withOpacity(0),
            statusBarIconBrightness: Brightness.dark
          ),
        ),
      ),
    );
  }
}