




import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repository/departments/logistic/sim_nomenclature_repo.dart';
import '../../../domain/repository/server/sim.dart';
import '../../../presentation/widgets/logistic/sim_storage/sim_elements_dialog.dart';
import '../../bloc/logistic/sim_nomenclature_bloc.dart';
import '../../server/connect_impl.dart';

class SimNomenclatureImpl extends SimNomenclatureRepository{
  
  // Получение списка номенклатуры
  @override
  Future<List> getNomenclature() async {
    List nomenclature = [];
    await ConnectionImpl().request(simGetNomenclature, {}).then((value) async {
      value is List ? nomenclature = value : null;
    });
    return nomenclature;
  }

  // Получение списка категорий ВСЕХ
  @override
  Future getAllCategories(BuildContext context, Map nmState) async {
    dynamic requestResult;
    await ConnectionImpl().request(simGetCategories, {}).then((value) async {
      value is List ? await simElementsDialog(context, 'выберите существующую категорию', value).then((value){
        value == null ? null : {
          nmState['category'] = value,
          context.read<SimNomenclatureBloc>().add(SimNomenclatureChange(data: Map.from(nmState)))
        };
      }) : null;
      requestResult = value;
    });
    return requestResult;
  }

  // Получение списка поставщиков ВСЕХ
  @override
  Future getAllProducers(BuildContext context, Map nmState) async {
    dynamic requestResult;
    await ConnectionImpl().request(simAllProducers, {}).then((value) async {
      value is List ? await simElementsDialog(context, 'выберите существующего поставщика', value).then((value){
        value == null ? null : {
          nmState['producer'] = value,
          context.read<SimNomenclatureBloc>().add(SimNomenclatureChange(data: Map.from(nmState)))
        };
      }) : null;
      requestResult = value;
    });
    return requestResult;
  }


  // Получение списка ед. измерения ВСЕХ
  @override
  Future getAllUnits(BuildContext context, Map nmState) async {
    dynamic requestResult;
    await ConnectionImpl().request(simAllUnits, {}).then((value) async {
      value is List ? await simElementsDialog(context, 'выберите из существующего списка', value).then((value){
        value == null ? null : {
          nmState['unit'] = value,
          context.read<SimNomenclatureBloc>().add(SimNomenclatureChange(data: Map.from(nmState)))
        };
      }) : null;
      requestResult = value;
    });
    return requestResult;
  }


  // добавить номенклатуру
  @override
  Future addNomenclature(Map nmState) async {
    dynamic requestResult;
    await ConnectionImpl().request(simAddNomenclature, nmState).then((value) async {
      requestResult = value;
    });
    return requestResult;
  }




}