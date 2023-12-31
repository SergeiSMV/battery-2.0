import 'dart:convert';
import 'dart:io';

import 'package:battery_2_0/data/bloc/logistic/sim_items_bloc.dart';
import 'package:battery_2_0/domain/models/accesses/accesses.dart';
import 'package:battery_2_0/domain/repository/departments/logistic/sim_items_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../domain/repository/departments/accesses_names.dart';
import '../../../domain/repository/server/sim.dart';
import '../../../presentation/widgets/logistic/sim_storage/sim_multiple_cells_dialog.dart';
import '../../../presentation/widgets/logistic/sim_storage/selected_item/selected_item_fabmenu.dart';
import '../../../presentation/widgets/logistic/sim_storage/cell_dialog.dart';
import '../../../presentation/widgets/logistic/sim_storage/sim_elements_dialog.dart';
import '../../bloc/logistic/sim_item_replace_bloc.dart';
import '../../server/connect_impl.dart';

class SimItemsImpl extends SimItemsRepository{

  // добавление к полученному API ключ:значение полное наименование, наименование для поиска, дату для фильтра по FIFO
  @override
  List editDataItems(List startItems) {
    List fullNameItems = [];
    for (var i in startItems){
      i['fullName'] = '${i['category']} ${i['name']} ${i['color']}';
      i['searchName'] = '${i['category']} ${i['name']} ${i['color']} ${i['producer']} ${i['author']} ${i['fifo']}';
      DateTime date = DateFormat('dd.MM.yyyy').parse(i['fifo']);
      i['date'] = date;
      fullNameItems.add(i);
    }
    return fullNameItems;
  }

  // фильтр сырья и комплектующих
  @override
  void filterItems(BuildContext context, List items, String filter) {
    filter == 'по ячейке А↓' ? items.sort((a, b) {return a['cell'].toString().compareTo(b['cell'].toString());}) : null;
    filter == 'по ячейке Я↓' ? items.sort((a, b) {return b['cell'].toString().compareTo(a['cell'].toString());}) : null;
    filter == 'по категории А↓' ? items.sort((a, b) {return a['category'].toString().compareTo(b['category'].toString());}) : null;
    filter == 'по категории Я↓' ? items.sort((a, b) {return b['category'].toString().compareTo(a['category'].toString());}) : null;
    filter == 'по поставщику А↓' ? items.sort((a, b) {return a['producer'].toString().compareTo(b['producer'].toString());}) : null;
    filter == 'по поставщику Я↓' ? items.sort((a, b) {return b['producer'].toString().compareTo(a['producer'].toString());}) : null;
    filter == 'по статусу А↓' ? items.sort((a, b) {return a['status'].toString().compareTo(b['status'].toString());}) : null;
    filter == 'по статусу Я↓' ? items.sort((a, b) {return b['status'].toString().compareTo(a['status'].toString());}) : null;
    filter == 'по дате старые↓' ? items.sort((a, b) {return a['date'].toString().compareTo(b['date'].toString());}) : null;
    filter == 'по дате новые↓' ? items.sort((a, b) {return b['date'].toString().compareTo(a['date'].toString());}) : null;
    
    context.read<SimItemsBloc>().add(UpdateSimItemsEvent(data: items.toList()));
  }

  // формирование и отправка данных для создания qr кодов
  @override
  Future<String> sendQrCodes(List items) async {
    List itemsDataList = [];
    for (var element in items) { 
      itemsDataList.add(Map.from(element));
    }
    for (var i in itemsDataList){
      i.remove('fullName');
      i.remove('quantity'); i.remove('reserve'); i.remove('unit'); 
      i.remove('author'); i.remove('status'); i.remove('comment'); 
      i.remove('pallet_size'); i.remove('images'); i.remove('searchName'); 
      i.remove('date');
    }
    Map itemsData = {'items': itemsDataList};
    dynamic requestResult;
    await ConnectionImpl().request(simCreateQrcode, itemsData).then((value) async {
      requestResult = value;
    });
    return requestResult;
  }

  // запрос конкретного ТМЦ со списком одинаковых ТМЦ согласно выбранному
  @override
  Future selectedItem(String itemId) async {
    dynamic requestResult;
    await ConnectionImpl().request(simSelectedItem, {'itemId': itemId}).then((value) async {
      requestResult = value;
    });
    return requestResult;
  }

  // FAB меню выбранной позиции
  @override
  List<Widget> selectedItemFabMenu(Accesses? allAccesses, BuildContext context, Map itemData, Function refresh, List allItems) {
    const String dependence = 'склад сырья и материалов';
    List<Widget> itemMenu = [const SizedBox.shrink()];
    String itemId = itemData['itemId'].toString();

    for (var dp in allAccesses!.accessesList) {
      dp['depence'] == dependence && dp['chapter'] == simDelete ? itemMenu.add(delItem(context, itemData)) : null;
    }
    
    for (var dp in allAccesses.accessesList) {
      dp['depence'] == dependence && dp['chapter'] == simEdit ? itemMenu.add(itemEdit(context, itemData, refresh)) : null;
      dp['depence'] == dependence && dp['chapter'] == simMoving ? itemMenu.add(itemMoving(context, itemData, refresh, allItems)) : null;
      dp['depence'] == dependence && dp['chapter'] == simHistory ? itemMenu.add(itemHistory(context, itemId, refresh)) : null;
      dp['depence'] == dependence && dp['chapter'] == simStatus ? itemMenu.add(itemStatus(context, itemData, refresh)) : null;
      dp['depence'] == dependence && dp['chapter'] == simAddPhoto ? itemMenu.add(itemAddPhoto(context, itemData, refresh)) : null;
    }

    return itemMenu;
  }
  
  // удаление позиции
  @override
  Future<String> deleteItem(Map itemData) async {
    dynamic requestResult;
    await ConnectionImpl().request(simDeleteItem, itemData).then((value) async {
      requestResult = value;
    });
    return requestResult;
  }
  
  // Получение списка категорий
  @override
  Future getCategories(BuildContext context, TextEditingController categoryCntr) async {
    dynamic requestResult;
    await ConnectionImpl().request(simGetCategories, {}).then((value) async {
      value is List ? await simElementsDialog(context, 'выберите категорию', value).then((value){
        value == null ? null : {
          categoryCntr.text = value
        };
      }) : null;
      requestResult = value;
    });
    return requestResult;
  }
  
  // Получение списка наименований по категории
  @override
  Future getNames(BuildContext context, TextEditingController nameCntr, Map itemData) async {
    String category = itemData['category'];
    Map requestData = {'category': category};
    dynamic requestResult;
    await ConnectionImpl().request(simGetNames, requestData).then((value) async {
      value is List ? await simElementsDialog(context, 'выберите наименование', value).then((value){
        value == null ? null : {
          nameCntr.text = value
        };
      }) : null;
      requestResult = value;
    });
    return requestResult;
  }
  
  // Получение списка цветов
  @override
  Future getColors(BuildContext context, TextEditingController colorCntr) async {
    dynamic requestResult;
    await ConnectionImpl().request(simGetColors, {}).then((value) async {
      value is List ? await simElementsDialog(context, 'выберите цвет', value).then((value){
        value == null ? null : {
          colorCntr.text = value
        };
      }) : null;
      requestResult = value;
    });
    return requestResult;
  }


  // Получение списка поставщиков ВСЕХ
  @override
  Future<List> getAllProducers() async {
    List producers = [];
    await ConnectionImpl().request(simGetProducers, {}).then((value) async {
      value is List ? producers = value : null;
    });
    return producers;
  }

  
  // Получение списка поставщиков по категории и наименованию
  @override
  Future getProducers(BuildContext context, TextEditingController producerCntr, Map itemData) async {
    String category = itemData['category'];
    String name = itemData['name'];
    Map requestData = {'category': category, 'name': name};
    dynamic requestResult;
    await ConnectionImpl().request(simGetProducers, requestData).then((value) async {
      value is List ? await simElementsDialog(context, 'выберите поставщика', value).then((value){
        value == null ? null : {
          producerCntr.text = value
        };
      }) : null;
      requestResult = value;
    });
    return requestResult;
  }
  
  // Получение списка ед. измерения по категории, наименованию и поставщику
  @override
  Future getUnits(BuildContext context, TextEditingController unitCntr, Map itemData) async {
    String category = itemData['category'];
    String name = itemData['name'];
    String producer = itemData['producer'];
    Map requestData = {'category': category, 'name': name, 'producer': producer};
    dynamic requestResult;
    await ConnectionImpl().request(simGetUnits, requestData).then((value) async {
      value is List ? await simElementsDialog(context, 'выберите ед. измерения', value).then((value){
        value == null ? null : {
          unitCntr.text = value
        };
      }) : null;
      requestResult = value;
    });
    return requestResult;
  }
  
  // Сохранение корректировки
  @override
  Future saveEdit(Map dataToSave, Map defaultData) async {
    final userInfo = GetStorage().read('info');
    String author = '${userInfo['surname']} ${userInfo['name'][0]}.${userInfo['patronymic'][0]}.';
    Map requestData = { 'dataToSave': dataToSave, 'defaultData': defaultData, 'author': author };
    dynamic requestResult;
    await ConnectionImpl().request(simSaveItemEdit, requestData).then((value) async {
      requestResult = value;
    });
    return requestResult;
  }
  
  // Получение списка складов
  @override
  Future getPlaces(BuildContext context, Map replaceState) async {
    dynamic responce;
    await ConnectionImpl().request(simGetPlaces, {}).then((value) async {
      value is List ? await simElementsDialog(context, 'выберите размер паллета', value).then((value) { 
        value == null ? null : {
          replaceState['replace']['place'] = value,
          replaceState['replace']['cell'] = '',
          context.read<SimItemReplaceBloc>().add(UpdateReplaceValueEvent(updateData: Map.from(replaceState)))
        };
      }) : null;
      responce = value;
    });
    return responce;
  }

  // Получение списка ячеек
  @override
  Future getCells(BuildContext context, String place, Map replaceState) async {
    dynamic requestResult;
    await ConnectionImpl().request(simGetCells, {'place': place}).then((value) async {
      value is List ? {
        await cellDialog(context, value).then((cellValue){
          cellValue == null ? null : {
            replaceState['replace']['cell'] = cellValue,
            replaceState['replace']['pallet_size'] = replaceState['default']['pallet_size'],
            context.read<SimItemReplaceBloc>().add(UpdateReplaceValueEvent(updateData: replaceState))
          };
        })
      } : null;
      requestResult = value;
    });
    return requestResult;
  }

  // Проверка занятости выбранной ячейки
  @override
  Future checkCell(BuildContext context, List allItems, Map replaceState) async {
    List roommates = [];
    String place = replaceState['replace']['place'];
    String cell = replaceState['replace']['cell'];
    String itemId = replaceState['replace']['itemId'].toString();
    cell.contains('транзит') ? null :
      {for (var r in allItems){
        if(r['place'] == place && r['cell'] == cell && r['itemId'] != itemId){
          r.remove('date'),
          roommates.add(r)
        }
      },
      roommates.isEmpty ? {
        replaceState['merge'] = 'no', replaceState['merge_items'] = [],
        context.read<SimItemReplaceBloc>().add(UpdateReplaceValueEvent(updateData: replaceState))
      } : {
        await multipleCellsDialog(context, roommates).then((result){
          result == 'merge' ? {
            replaceState['merge'] = 'yes', replaceState['merge_items'] = roommates,
            replaceState['replace']['pallet_size'] = roommates[0]['pallet_size'],
            context.read<SimItemReplaceBloc>().add(UpdateReplaceValueEvent(updateData: replaceState))
          } : {
            replaceState['replace']['cell'] = '',
            context.read<SimItemReplaceBloc>().add(UpdateReplaceValueEvent(updateData: replaceState))
          };
        })
      }};
  }

  // перемещение ТМЦ (сохранение в БД)
  @override
  Future<String> replace(Map replaceData) async {
    final userInfo = GetStorage().read('info');
    String author = '${userInfo['surname']} ${userInfo['name'][0]}.${userInfo['patronymic'][0]}.';
    replaceData['author'] = author;
    late String requestResult;
    
    await ConnectionImpl().request(simItemReplace, replaceData).then((value) async {
      requestResult = value.toString();
    });
    return requestResult;
  }
  
  // получение записей истории выбранной позиции
  @override
  Future getHistory(String itemId) async {
    dynamic requestResult;
    await ConnectionImpl().request(simItemHistory, {'itemId': itemId}).then((value) async {
      requestResult = value;
    });
    if (requestResult is List){
      for (var r in requestResult){
        DateTime date = DateFormat('dd.MM.yyyy').parse(r['date']);
        r['format_date'] = date;
      }
    }
    return requestResult;
  }
  
  // изменение статуса ТМЦ
  @override
  Future changeStatus(Map defaultData, Map changeData) async {
    final userInfo = GetStorage().read('info');
    String author = '${userInfo['surname']} ${userInfo['name'][0]}.${userInfo['patronymic'][0]}.';
    Map requestData = {'default': defaultData, 'change': changeData, 'author': author};
    dynamic requestResult;
    await ConnectionImpl().request(simItemChangeStatus, requestData).then((value) async {
      requestResult = value;
    });
    return requestResult;
  }

  // КНОПКА удаления фото (проверка доступа)
  @override
  bool imageDeleteButton(Accesses? allAccesses) {
    bool deleteAccess = false;
    const String dependence = 'склад сырья и материалов';
    for (var dp in allAccesses!.accessesList) {
      dp['depence'] == dependence && dp['chapter'] == simDelPhoto ? deleteAccess = true : null;
    }
    return deleteAccess;
  }

  // сохранение фото
  @override
  Future savePhoto(Map itemData, ImageSource source) async {
    final getImage = await ImagePicker().pickImage(source: source, imageQuality: 100);
    File image = File(getImage!.path);
    List<int> imageBytes = image.readAsBytesSync();
    var imageCode = base64Encode(imageBytes);
    Map data = {'image': imageCode, 'item_data': itemData};
    dynamic requestResult;
    await ConnectionImpl().request(simItemSavePhoto, data).then((value) async {
      requestResult = value;
    });
    return requestResult;
  }

  // удаление фото
  @override
  Future deletePhoto(Map itemData, String link) async {
    Map data = {'item': itemData, 'link': link};
    dynamic requestResult;
    await ConnectionImpl().request(simItemDelPhoto, data).then((value) async {
      requestResult = value;
    });
    return requestResult;
  }

}