

import 'package:flutter/material.dart';

import '../../../models/accesses/accesses.dart';

abstract class SimStorageRepository{

  // меню склада сырья и материалов
  List simStorageMain(Accesses? allAccesses, String depence);

  // идентификация ТМЦ
  Widget simItemsIdentify(BuildContext context);

}