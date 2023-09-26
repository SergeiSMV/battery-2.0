

import 'package:flutter/material.dart';

abstract class SimNomenclatureRepository{

  Future<List> getNomenclature();

  // Получение списка категорий
  Future getAllCategories(BuildContext context, Map nmState);

  // Получение списка поставщиков ВСЕХ
  Future getAllProducers(BuildContext context, Map nmState);

  // Получение списка ед. измерения ВСЕХ
  Future getAllUnits(BuildContext context, Map nmState);

  // добавить номенклатуру
  Future addNomenclature(Map nmState);


}