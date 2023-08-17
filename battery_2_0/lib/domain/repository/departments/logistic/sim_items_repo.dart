


import 'package:flutter/material.dart';

import '../../../models/accesses/accesses.dart';

abstract class SimItemsRepository{

  // фильтр сырья и комплектующих
  void filterItems(BuildContext context, List items, String filter);

  // FAB меню выбранной позиции
  List<Widget> selectedItemFabMenu(Accesses? allAccesses, BuildContext context, Map itemData, Function refresh, List allItems);

  // запрос конкретного ТМЦ со списком одинаковых ТМЦ согласно выбранному
  Future selectedItem(String itemId);

  // формирование и отправка данных для создания qr кодов
  Future<String> sendQrCodes(List items);

  // добавление к полученному API ключ:значение полное наименование, наименование для поиска, дату для фильтра по FIFO
  List editDataItems(List startItems);

  // удаление позиции
  Future<String> deleteItem(Map itemData);
  
  // Получение списка категорий
  Future getCategories(BuildContext context, TextEditingController categoryCntr);

  // Получение списка наименований по категории
  Future getNames(BuildContext context, TextEditingController nameCntr, Map itemData);
  
  // Получение списка цветов
  Future getColors(BuildContext context, TextEditingController colorCntr);

  // Получение списка поставщиков по категории и наименованию
  Future getProducers(BuildContext context, TextEditingController colorCntr, Map itemData);

  // Получение списка ед. измерения по категории, наименованию и поставщику
  Future getUnits(BuildContext context, TextEditingController colorCntr, Map itemData);

  // Сохранение корректировки
  Future saveEdit(Map dataToSave, Map defaultData);

  // Получение списка складов
  Future getPlaces(BuildContext context);

  // Получение списка ячеек
  Future getCells(BuildContext context, String place);

  // Проверка занятости выбранной ячейки
  List checkCell(List allItems, String place, String cell, String itemId);

  // перемещение ТМЦ
  Future<String> replace(Map locatesData, Map defaultData);

}