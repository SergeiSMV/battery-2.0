


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  Future getProducers(BuildContext context, TextEditingController producerCntr, Map itemData);

  // Получение списка ед. измерения по категории, наименованию и поставщику
  Future getUnits(BuildContext context, TextEditingController unitCntr, Map itemData);

  // Сохранение корректировки
  Future saveEdit(Map dataToSave, Map defaultData);

  // Получение списка складов
  Future getPlaces(BuildContext context, Map replaceState);

  // Получение списка ячеек
  Future getCells(BuildContext context, String place, Map replaceState);

  // Проверка занятости выбранной ячейки
  Future checkCell(BuildContext context, List allItems, Map replaceState);

  // перемещение ТМЦ
  Future<String> replace(Map replaceData);


  // получение записей истории выбранной позиции
  Future getHistory(String itemId);

  // изменение статуса ТМЦ
  Future changeStatus(Map defaultData, Map changeData);

  // кнопка удаления фото
  bool imageDeleteButton(Accesses? allAccesses);

  // сохранение фото
  Future savePhoto(Map itemData, ImageSource source);

  // удаление фото
  Future deletePhoto(Map itemData, String link);

}