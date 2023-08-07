import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'presentation/widgets/app.dart';

// TESTING NUMBER 2

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('ru');
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(const ProviderScope(child: App()));
  });
}

