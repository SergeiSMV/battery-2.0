

import '../../../models/accesses/accesses.dart';

abstract class SimOrdersRepository{

  // добавление к полученному API DateFormat для фильтра
  List editDataOrders(List orders);

  // фильтруем закрытые заявки
  List closedOrders(List orders);

  // фильтруем НЕ закрытые заявки
  List openedOrders(List orders);

  // кнопка создания заявки (проверка доступа)
  bool addOrderButton(Accesses? allAccesses);


}

