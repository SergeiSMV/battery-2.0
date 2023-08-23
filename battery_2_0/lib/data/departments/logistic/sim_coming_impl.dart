import 'package:battery_2_0/domain/repository/departments/logistic/sim_coming_repo.dart';
import 'package:battery_2_0/presentation/widgets/calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../../domain/models/accesses/accesses.dart';
import '../../../domain/repository/departments/accesses_names.dart';
import '../../../domain/repository/server/sim.dart';
import '../../../presentation/widgets/logistic/sim_storage/coming/barcode_scanner.dart';
import '../../../presentation/widgets/logistic/sim_storage/cell_dialog.dart';
import '../../../presentation/widgets/logistic/sim_storage/selected_item/replace/sim_multiple_cells_dialog.dart';
import '../../../presentation/widgets/logistic/sim_storage/sim_elements_dialog.dart';
import '../../bloc/logistic/sim_coming_bloc.dart';
import '../../server/connect_impl.dart';

class SimComingImpl extends SimComingRepository{
  
  // инициализация даты
  @override
  void initDate(BuildContext context, Map comingState) {
    if(comingState['fifo'] == ''){
      var now = DateTime.now();
      var formatter = DateFormat('dd.MM.yyyy');
      String today = formatter.format(now);
      comingState['fifo'] = today.toString();
      context.read<SimComingBloc>().add(SimComingChange(data: Map.from(comingState)));
    }
    else { null; }
  }

  // обновление даты
  @override
  void updateDate(BuildContext context, String selectedDate, Map comingState) {
    comingState['fifo'] == selectedDate.toString() ? null : 
    {
      comingState['fifo'] = selectedDate.toString(),
      context.read<SimComingBloc>().add(SimComingChange(data: Map.from(comingState)))
    };
  }
  
  // инициализация автора
  @override
  void initAuthor(BuildContext context, Map comingState) {
    if(comingState['author'] == ''){
      final userInfo = GetStorage().read('info');
      String author = '${userInfo['surname']} ${userInfo['name'][0]}.${userInfo['patronymic'][0]}.';
      comingState['author'] = author.toString();
      context.read<SimComingBloc>().add(SimComingChange(data: Map.from(comingState)));
    }
    else { null; }
  }
  
  // заполнение по штрих коду
  @override
  Future fillBarcode(BuildContext context, Map comingState) async {
    dynamic requestResult;
    await barcodeScanner(context).then((barcodeValue) async {
      barcodeValue == null ? null :
      await ConnectionImpl().request(simCheckBarcode, {'barcode': barcodeValue}).then((responceValue) async {
        if(responceValue == 'empty'){
          comingState['barcode'] = barcodeValue.toString();
          comingState['category'] = ''; comingState['name'] = ''; comingState['color'] = '';
          comingState['producer'] = ''; comingState['unit'] = ''; comingState['quantity'] = '0';
          comingState['pallet_size'] = 'standart'; comingState['pallet_height'] = '0';
          context.read<SimComingBloc>().add(SimComingChange(data: Map.from(comingState)));
          requestResult = responceValue;
        }
        else if (responceValue is Map){
          comingState['barcode'] = ''; comingState['category'] = responceValue['category'].toString(); 
          comingState['name'] = responceValue['name'].toString(); comingState['color'] = responceValue['color'].toString();
          comingState['producer'] = responceValue['producer'].toString(); comingState['unit'] = responceValue['unit'].toString();
          context.read<SimComingBloc>().add(SimComingChange(data: Map.from(comingState)));
          requestResult = 'done';
        }
        else { requestResult = responceValue; }
      });
    });
      
    return requestResult;
  }
  
  // запрос категорий
  @override
  Future comingCategories(BuildContext context, Map comingState) async {
    dynamic requestResult;
    await ConnectionImpl().request(simGetCategories, {}).then((value) async {
      value is List ? await simElementsDialog(context, 'выберите категорию', value).then((value){
        value == null ? null : {
          comingState['category'] = value, comingState['name'] = '', comingState['color'] = '',
          comingState['producer'] = '', comingState['unit'] = '',
          context.read<SimComingBloc>().add(SimComingChange(data: Map.from(comingState)))
        };
      }) : null;
      requestResult = value;
    });
    return requestResult;
  }

  // запрос наименований
  @override
  Future comingNames(BuildContext context, Map comingState) async {
    String category = comingState['category'];
    Map requestData = {'category': category};
    dynamic requestResult;
    await ConnectionImpl().request(simGetNames, requestData).then((value) async {
      value is List ? await simElementsDialog(context, 'выберите наименование', value).then((value){
        value == null ? null : {
          comingState['name'] = value, comingState['color'] = '',
          comingState['producer'] = '', comingState['unit'] = '',
          context.read<SimComingBloc>().add(SimComingChange(data: Map.from(comingState)))
        };
      }) : null;
      requestResult = value;
    });
    return requestResult;
  }

  // запрос цветов
  @override
  Future comingColors(BuildContext context, Map comingState) async {
    dynamic requestResult;
    await ConnectionImpl().request(simGetColors, {}).then((value) async {
      value is List ? await simElementsDialog(context, 'выберите цвет', value).then((value){
        value == null ? null : {
          comingState['color'] = value,
          context.read<SimComingBloc>().add(SimComingChange(data: Map.from(comingState)))
        };
      }) : null;
      requestResult = value;
    });
    return requestResult;
  }

  // запрос списка поставщиков по категории и наименованию
  @override
  Future comingProducers(BuildContext context, Map comingState) async {
    String category = comingState['category'];
    String name = comingState['name'];
    Map requestData = {'category': category, 'name': name};
    dynamic requestResult;
    await ConnectionImpl().request(simGetProducers, requestData).then((value) async {
      value is List ? await simElementsDialog(context, 'выберите поставщика', value).then((value){
        value == null ? null : {
          comingState['producer'] = value,
          context.read<SimComingBloc>().add(SimComingChange(data: Map.from(comingState)))
        };
      }) : null;
      requestResult = value;
    });
    return requestResult;
  }

  // получение штрих кода
  @override
  Future comingBarcode(BuildContext context, Map comingState) async {
    dynamic requestResult;
    await barcodeScanner(context).then((barcodeValue) async {
      barcodeValue == null ? null : {
        comingState['barcode'] = barcodeValue,
        context.read<SimComingBloc>().add(SimComingChange(data: Map.from(comingState)))
      };
    });
    return requestResult;
  }

  // запрос единиц измерения
  @override
  Future comingUnits(BuildContext context, Map comingState) async {
    String category = comingState['category'];
    String name = comingState['name'];
    String producer = comingState['producer'];
    Map requestData = {'category': category, 'name': name, 'producer': producer};
    dynamic requestResult;
    await ConnectionImpl().request(simGetUnits, requestData).then((value) async {
      value is List ? await simElementsDialog(context, 'выберите ед. измерения', value).then((value){
        value == null ? null : {
          comingState['unit'] = value,
          context.read<SimComingBloc>().add(SimComingChange(data: Map.from(comingState)))
        };
      }) : null;
      requestResult = value;
    });
    return requestResult;
  }

  // проверка доступа на ручное размещение
  @override
  bool comingManualAccess(Accesses? allAccesses) {
    bool comingManual = false;
    const String dependence = 'склад сырья и материалов';
    for (var dp in allAccesses!.accessesList) {
      dp['depence'] == dependence && dp['chapter'] == simComingManual ? comingManual = true : null;
    }
    return comingManual;
  }

  // изменение даты поступления
  @override
  Future comingFifo(BuildContext context, Map comingState) async {
    await calendar(context).then((value){
      value == null ? null : {
        comingState['fifo'] = value,
        context.read<SimComingBloc>().add(SimComingChange(data: Map.from(comingState)))
      };
    });
  }

  // выбор размера паллета
  @override
  Future comingPalletSize(BuildContext context, Map comingState) async {
    List choicePallet = ['стандартный', 'большой'];
    await simElementsDialog(context, 'выберите размер паллета', choicePallet).then((value){
      value == null ? null : {
        comingState['pallet_size'] = value == 'стандартный' ? 'standart' : 'big',
        context.read<SimComingBloc>().add(SimComingChange(data: Map.from(comingState)))
      };
    });
  }

  // Получение списка складов
  @override
  Future comingPlaces(BuildContext context, Map comingState) async {
    dynamic responce;
    await ConnectionImpl().request(simGetPlaces, {}).then((value) async {
      value is List ? await simElementsDialog(context, 'выберите размер паллета', value).then((value) { 
        value == null ? null : {
          comingState['place'] = value, comingState['cell'] = '',
          context.read<SimComingBloc>().add(SimComingChange(data: Map.from(comingState)))
        };
      }) : null;
      responce = value;
    });
    return responce;
  }

  // Получение списка ячеек
  @override
  Future comingCells(BuildContext context, String place, Map comingState) async {
    dynamic requestResult;
    await ConnectionImpl().request(simGetCells, {'place': place}).then((value) async {
      value is List ? {
        await cellDialog(context, value).then((cellValue){
          cellValue == null ? null : {
            comingState['cell'] = cellValue,
            context.read<SimComingBloc>().add(SimComingChange(data: Map.from(comingState)))
          };
        })
      } : null;
      requestResult = value;
    });
    return requestResult;
  }


  // Проверка занятости выбранной ячейки
  @override
  Future comingCheckCell(BuildContext context, List allItems, Map comingState) async {
    String place = comingState['place'];
    String cell = comingState['cell'];
    List roommates = [];
    for (var r in allItems){
      if(r['place'] == place && r['cell'] == cell){
        r.remove('date');
        roommates.add(r);
      }
    }
    roommates.isEmpty ? {
      comingState['merge'] = 'no', comingState['merge_items'] = [],
      context.read<SimComingBloc>().add(SimComingChange(data: Map.from(comingState)))
    } : {
      await simMultipleCellsDialog(context, roommates).then((result){
        result == 'merge' ? {
          comingState['merge'] = 'yes', comingState['merge_items'] = roommates,
          comingState['pallet_size'] = '',
          context.read<SimComingBloc>().add(SimComingChange(data: Map.from(comingState)))
        } : {
          comingState['cell'] = '',
          context.read<SimComingBloc>().add(SimComingChange(data: Map.from(comingState)))
        };
      })
    };
  }






}