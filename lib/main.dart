import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'local_services.dart';
import 'presentation/widgets/app.dart';


void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('ru');
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) async {
    await Firebase.initializeApp();
    LocalNotificationServices.initialize();
    runApp(const ProviderScope(child: App()));
  });
}

