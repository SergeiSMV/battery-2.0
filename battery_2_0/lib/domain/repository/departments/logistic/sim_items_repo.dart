


import 'package:flutter/material.dart';

import '../../../models/accesses/accesses.dart';

abstract class SimItemsRepository{

  // фильтр сырья и комплектующих
  void filterItems(BuildContext context, List items, String filter);

  // FAB меню выбранной позиции
  List<Widget> selectedItemFabMenu(Accesses? allAccesses, BuildContext context, String id, String palletSize);

  // запрос конкретного ТМЦ со списком одинаковых ТМЦ согласно выбранному
  Future selectedItem(String itemId);

  // формирование и отправка данных для создания qr кодов
  Future<String> sendQrCodes(List items);

  // добавление к полученному API ключ:значение полное наименование, наименование для поиска, дату для фильтра по FIFO
  List editDataItems(List startItems);

  // удаление позиции
  Future<String> deleteItem(String id, String palletSize);
  

}