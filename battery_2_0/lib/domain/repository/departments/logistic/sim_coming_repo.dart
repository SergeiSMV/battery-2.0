



import 'package:flutter/material.dart';

import '../../../models/accesses/accesses.dart';

abstract class SimComingRepository{

  // инициализация даты
  void initDate(BuildContext context, Map comingState);

  // обновление даты
  void updateDate(BuildContext context, String selectedDate, Map comingState);

  // инициализация автора
  void initAuthor(BuildContext context, Map comingState);

  // заполнение по штрих коду
  Future fillBarcode(BuildContext context, Map comingState);

  // запрос категорий
  Future comingCategories(BuildContext context, Map comingState);

  // запрос наименований
  Future comingNames(BuildContext context, Map comingState);

  // запрос цветов
  Future comingColors(BuildContext context, Map comingState);

  // запрос списка поставщиков по категории и наименованию
  Future comingProducers(BuildContext context, Map comingState);

  // получение штрих кода
  Future comingBarcode(BuildContext context, Map comingState);

  // запрос единиц измерения
  Future comingUnits(BuildContext context, Map comingState);

  // проверка доступа на ручное размещение
  bool comingManualAccess(Accesses? allAccesses);

  // изменение даты поступления
  Future comingFifo(BuildContext context, Map comingState);

  // выбор размера паллета
  Future comingPalletSize(BuildContext context, Map comingState);

  // Получение списка складов
  Future comingPlaces(BuildContext context, Map comingState);

  // Получение списка ячеек
  Future comingCells(BuildContext context, String place, Map comingState);

  // Проверка занятости выбранной ячейки
  Future comingCheckCell(BuildContext context, List allItems, Map comingState);

}