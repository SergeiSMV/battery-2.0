import 'package:battery_2_0/data/bloc/logistic/sim_items_bloc.dart';
import 'package:battery_2_0/domain/models/accesses/accesses.dart';
import 'package:battery_2_0/domain/repository/departments/logistic/sim_items_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../../domain/repository/departments/accesses_names.dart';
import '../../../domain/repository/server/sim.dart';
import '../../../presentation/widgets/logistic/sim_storage/selected_item/selected_item_fabmenu.dart';
import '../../../presentation/widgets/logistic/sim_storage/selected_item/set_item_cell.dart';
import '../../../presentation/widgets/logistic/sim_storage/selected_item/set_item_element.dart';
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

    for (var dp in allAccesses!.accessesList) {
      dp['depence'] == dependence && dp['chapter'] == simDelete ? itemMenu.add(delItem(context, itemData)) : null;
    }
    
    for (var dp in allAccesses.accessesList) {
      dp['depence'] == dependence && dp['chapter'] == simEdit ? itemMenu.add(itemEdit(context, itemData, refresh)) : null;
      dp['depence'] == dependence && dp['chapter'] == simMoving ? itemMenu.add(itemMoving(context, itemData, refresh, allItems)) : null;
      dp['depence'] == dependence && dp['chapter'] == simStatus ? itemMenu.add(itemStatus()) : null;
      dp['depence'] == dependence && dp['chapter'] == simAddPhoto ? itemMenu.add(itemAddPhoto()) : null;
      dp['depence'] == dependence && dp['chapter'] == simHistory ? itemMenu.add(itemHistory()) : null;
      // dp['depence'] == dependence && dp['chapter'] == simDelPhoto ? itemMenu.add(dp['chapter']) : null;
    }

    return itemMenu;
  }
  
  // удаление позиции
  @override
  Future<String> deleteItem(Map itemData) async {
    dynamic requestResult;
    await ConnectionImpl().request(simDeleteItem, {'itemData': itemData}).then((value) async {
      requestResult = value;
    });
    return requestResult;
  }
  
  // Получение списка категорий
  @override
  Future getCategories(BuildContext context, TextEditingController categoryCntr) async {
    dynamic requestResult;
    await ConnectionImpl().request(simGetCategories, {}).then((value) async {
      value is List ? await setItemElement(context, 'выберите категорию', value, categoryCntr) : null;
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
      value is List ? await setItemElement(context, 'выберите наименование', value, nameCntr) : null;
      requestResult = value;
    });
    return requestResult;
  }
  
  // Получение списка цветов
  @override
  Future getColors(BuildContext context, TextEditingController colorCntr) async {
    dynamic requestResult;
    await ConnectionImpl().request(simGetColors, {}).then((value) async {
      value is List ? await setItemElement(context, 'выберите цвет', value, colorCntr) : null;
      requestResult = value;
    });
    return requestResult;
  }
  
  @override
  Future getProducers(BuildContext context, TextEditingController colorCntr, Map itemData) async {
    String category = itemData['category'];
    String name = itemData['name'];
    Map requestData = {'category': category, 'name': name};
    dynamic requestResult;
    await ConnectionImpl().request(simGetProducers, requestData).then((value) async {
      value is List ? await setItemElement(context, 'выберите поставщика', value, colorCntr) : null;
      requestResult = value;
    });
    return requestResult;
  }
  
  @override
  Future getUnits(BuildContext context, TextEditingController colorCntr, Map itemData) async {
    String category = itemData['category'];
    String name = itemData['name'];
    String producer = itemData['producer'];
    Map requestData = {'category': category, 'name': name, 'producer': producer};
    dynamic requestResult;
    await ConnectionImpl().request(simGetUnits, requestData).then((value) async {
      value is List ? await setItemElement(context, 'выберите ед. измерения', value, colorCntr) : null;
      requestResult = value;
    });
    return requestResult;
  }
  
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
  Future getPlaces(BuildContext context, TextEditingController placeController) async {
    dynamic requestResult;
    await ConnectionImpl().request(simGetPlaces, {}).then((value) async {
      value is List ? await setItemElement(context, 'выберите склад', value, placeController) : null;
      requestResult = value;
    });
    return requestResult;
  }

  // Получение списка ячеек
  @override
  Future getCells(BuildContext context, TextEditingController placeController, String place) async {
    dynamic requestResult;
    await ConnectionImpl().request(simGetCells, {'place': place}).then((value) async {
      value is List ? await setItemCell(context, placeController, value) : null;
      requestResult = value;
    });
    return requestResult;
  }


  // Проверка занятости выбранной ячейки
  @override
  List checkCell(List allItems, String place, String cell, String itemId){
    List roommates = [];
    for (var r in allItems){
      if(r['place'] == place && r['cell'] == cell && r['itemId'] != itemId){
        roommates.add(r);
      }
    }
    return roommates;
  }



  // перемещение ТМЦ
  @override
  Future<String> replace(Map locatesData, Map defaultData) async {
    Map replaceData = {};
    final userInfo = GetStorage().read('info');
    String author = '${userInfo['surname']} ${userInfo['name'][0]}.${userInfo['patronymic'][0]}.';
    replaceData['itemId'] = defaultData['itemId'];
    replaceData['new_place'] = locatesData['place'];
    replaceData['new_cell'] = locatesData['cell'];
    replaceData['old_place'] = defaultData['place'];
    replaceData['old_cell'] = defaultData['cell'];
    replaceData['author'] = author;
    replaceData['pallet_size'] = defaultData['pallet_size'];
    replaceData['change_pallet'] = locatesData['change_pallet'] ? 'yes' : 'no';
    late String requestResult;
    
    await ConnectionImpl().request(simItemReplace, replaceData).then((value) async {
      requestResult = value.toString();
    });
    return requestResult;
  }
  
  

}