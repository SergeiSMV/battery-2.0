

import 'package:flutter/material.dart';

import '../../../models/accesses/accesses.dart';

abstract class SimStorageRepository{

  // меню склада сырья и материалов
  List simStorageMain(Accesses? allAccesses, String depence);

  // фильтр сырья и комплектующих
  void filterItems(BuildContext context, List items, String filter);
  
  // добавление к полученному API ключ:значение полное наименование, наименование для поиска, дату для фильтра по FIFO
  List editDataItems(List startItems);

  // формирование и отправка данных для создания qr кодов
  Future<String> sendQrCodes(List items);

  // сбор одинаковых ТМЦ согласно выбранному
  Future selectedItem(String itemId);

  // меню выбранной позиции на складе сырья и материалов
  List<Widget> selectedItemFabMenu(Accesses? allAccesses);

}