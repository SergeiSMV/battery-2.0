

import 'package:flutter/material.dart';

import '../../../models/accesses/accesses.dart';

abstract class SimStorageRepository{

  // меню склада сырья и материалов
  List simStorageMain(Accesses? allAccesses, String depence);

  // КНОПКА настройки склада (проверка доступа)
  bool storageSettingButton(Accesses? allAccesses);

  // идентификация ТМЦ
  Widget simItemsIdentify(BuildContext context);

}