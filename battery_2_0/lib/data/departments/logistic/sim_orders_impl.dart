


import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../../domain/models/accesses/accesses.dart';
import '../../../domain/repository/departments/accesses_names.dart';
import '../../../domain/repository/departments/logistic/sim_orders_repo.dart';
import '../../../domain/repository/server/sim.dart';
import '../../server/connect_impl.dart';

class SimOrdersImpl extends SimOrdersRepository{

  // редактирование данных API ключ:значение списка заявок
  @override
  List editDataOrders(List orders) {
    List fullDataOrders = [];
    for (var i in orders){
      DateTime date = DateFormat('dd.MM.yyyy').parse(i['date'].toString());
      i['dateFormat'] = date; fullDataOrders.add(i);
    }
    return fullDataOrders;
  }
  
  // фильтруем закрытые заявки
  @override
  List closedOrders(List orders) {
    List closedOrdersList = [];
    for (var ord in orders){
      ord['status'] == 3 ? closedOrdersList.add(ord) : null;
    }
    return closedOrdersList;
  }
  
  // фильтруем НЕ закрытые заявки
  @override
  List openedOrders(List orders) {
    List openedOrdersList = [];
    for (var ord in orders){
      ord['status'] == 3 ? null : openedOrdersList.add(ord);
    }
    return openedOrdersList;
  }

  // кнопка создания заявки (проверка доступа)
  @override
  bool addOrderButton(Accesses? allAccesses) {
    bool addOrderAccess = false;
    const String dependence = 'склад сырья и материалов';
    for (var dp in allAccesses!.accessesList) {
      dp['depence'] == dependence && dp['chapter'] == simAddOrders ? addOrderAccess = true : null;
    }
    return addOrderAccess;
  }

  // сопоставление корзины и уникальных комплектующих
  @override
  int uiCheckQuantity(List cart, Map uniqItem) {
    int value = -1;
    if (cart.any((element) =>
        element.values.contains(uniqItem['category']) &&
        element.values.contains(uniqItem['name']) &&
        element.values.contains(uniqItem['color']) &&
        element.values.contains(uniqItem['producer']))) {
      for (var s in cart) {
        if (s['category'] == uniqItem['category'] &&
            s['name'] == uniqItem['name'] &&
            s['color'] == uniqItem['color'] &&
            s['producer'] == uniqItem['producer']) {
          value = uniqItem['quantity'] - int.parse(s['q_order']);
          break;
        } else {
          continue;
        }
      }
    } else {
      value = -1;
    }
    return value;
  }

  // получаем комментарий для отображения
  @override
  String uiGetComment(List cart, Map uniqItem){
    String comment = '';
    if (cart.any((element) =>
        element.values.contains(uniqItem['category']) &&
        element.values.contains(uniqItem['name']) &&
        element.values.contains(uniqItem['color']) &&
        element.values.contains(uniqItem['producer']))) {
      for (var s in cart) {
        if (s['category'] == uniqItem['category'] &&
            s['name'] == uniqItem['name'] &&
            s['color'] == uniqItem['color'] &&
            s['producer'] == uniqItem['producer']) {
          comment = s['comment'];
          break;
        } else {
          continue;
        }
      }
    } else {
      comment = '';
    }
    return comment;
  }

  // редактирование данных API ключ:значение списка уникальных комплектующих
  @override
  List editDataUniqItems(List startItems) {
    List fullNameItems = [];
    for (var i in startItems){
      i['fullName'] = '${i['category']} ${i['name']} ${i['color']}';
      i['searchName'] = '${i['category']} ${i['name']} ${i['color']} ${i['producer']}';
      fullNameItems.add(i);
    }
    return fullNameItems;
  }

  // отправка заявки (сохранение в БД)
  @override
  Future<String> sendNewOrder(List cart) async {
    final userInfo = GetStorage().read('info');
    String author = '${userInfo['surname']} ${userInfo['name'][0]}.${userInfo['patronymic'][0]}.';
    Map orderData = {'items': cart, 'author': author};
    late String requestResult;
    await ConnectionImpl().request(simAddOrder, orderData).then((value) async {
      requestResult = value.toString();
    });
    return requestResult;
  }

  // выдача комплектующих (проверка доступа)
  @override
  bool simExOrdersAccess(Accesses? allAccesses) {
    bool exOrderAccess = false;
    const String dependence = 'склад сырья и материалов';
    for (var dp in allAccesses!.accessesList) {
      dp['depence'] == dependence && dp['chapter'] == simExOrders ? exOrderAccess = true : null;
    }
    return exOrderAccess;
  }

  // приемка комплектующих (проверка доступа)
  @override
  bool simTakeOrdersAccess(Accesses? allAccesses) {
    bool takeOrderAccess = false;
    const String dependence = 'склад сырья и материалов';
    for (var dp in allAccesses!.accessesList) {
      dp['depence'] == dependence && dp['chapter'] == simTakeOrders ? takeOrderAccess = true : null;
    }
    return takeOrderAccess;
  }



}