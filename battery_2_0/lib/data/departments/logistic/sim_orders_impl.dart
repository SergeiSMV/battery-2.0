


import 'package:intl/intl.dart';

import '../../../domain/models/accesses/accesses.dart';
import '../../../domain/repository/departments/accesses_names.dart';
import '../../../domain/repository/departments/logistic/sim_orders_repo.dart';

class SimOrdersImpl extends SimOrdersRepository{

  // добавление к полученному API DateFormat для фильтра
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



}