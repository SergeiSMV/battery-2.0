

import 'dart:convert';

import 'package:battery_2_0/data/bloc/logistic/sim_items_bloc.dart';
import 'package:battery_2_0/domain/models/accesses/accesses.dart';
import 'package:battery_2_0/domain/repository/departments/logistic/sim_items_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../domain/repository/departments/accesses_names.dart';
import '../../../domain/repository/server_routers/server_data.dart';
import '../../../domain/repository/server_routers/sim.dart';
import '../../../presentation/view/logistic/sim_storage/selected_item/selected_item_fabmenu.dart';

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
    bool isConnected = true;
    WebSocketChannel channel = WebSocketChannel.connect(Uri.parse('$mainRoute$simCreateQrcode'));
    await channel.ready.onError((error, stackTrace) => isConnected = false);

    if(isConnected == false){
      return 'сервер отключен';
    } else {
      try{
        dynamic result;
        channel.sink.add(jsonEncode(itemsData));
        await channel.stream.single.then((value) {
          result = jsonDecode(value);
        });
        return result;
      } on Error catch (_){
        return '$_ (server ERROR)';
      } on Exception catch (_){
        return '$_ (server EXCEPTION)';
      }
    }
  }

  // запрос конкретного ТМЦ со списком одинаковых ТМЦ согласно выбранному
  @override
  Future selectedItem(String itemId) async {
    bool isConnected = true;
    WebSocketChannel channel = WebSocketChannel.connect(Uri.parse('$mainRoute$simSelectedItem'));
    await channel.ready.onError((error, stackTrace) => isConnected = false);

    if(isConnected == false){
      return 'сервер отключен';
    } else {
      try{
        dynamic result;
        channel.sink.add(jsonEncode({'itemId': itemId}));
        await channel.stream.single.then((value) {
          result = jsonDecode(value);
        });
        return result;
      } on Error catch (_){
        return '$_ (server ERROR)';
      } on Exception catch (_){
        return '$_ (server EXCEPTION)';
      }
    }
  }

  // FAB меню выбранной позиции
  @override
  List<Widget> selectedItemFabMenu(Accesses? allAccesses) {
    const String dependence = 'склад сырья и материалов';
    List<Widget> itemMenu = [const SizedBox.shrink()];

    for (var dp in allAccesses!.accessesList) {
      dp['depence'] == dependence && dp['chapter'] == simDelete ? itemMenu.add(delItem) : null;
    }
    
    for (var dp in allAccesses.accessesList) {
      
      dp['depence'] == dependence && dp['chapter'] == simMoving ? itemMenu.add(itemMoving) : null;
      dp['depence'] == dependence && dp['chapter'] == simEdit ? itemMenu.add(itemEdit) : null;
      dp['depence'] == dependence && dp['chapter'] == simStatus ? itemMenu.add(itemStatus) : null;
      dp['depence'] == dependence && dp['chapter'] == simAddPhoto ? itemMenu.add(itemAddPhoto) : null;
      dp['depence'] == dependence && dp['chapter'] == simHistory ? itemMenu.add(itemHistory) : null;

      // dp['depence'] == dependence && dp['chapter'] == simDelPhoto ? itemMenu.add(dp['chapter']) : null;

    }

    return itemMenu;
  }


  

}