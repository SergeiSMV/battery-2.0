

import '../../../models/accesses/accesses.dart';

abstract class SimOrdersRepository{

  // редактирование данных API ключ:значение списка заявок
  List editDataOrders(List orders);

  // фильтруем закрытые заявки
  List closedOrders(List orders);

  // фильтруем НЕ закрытые заявки
  List openedOrders(List orders);

  // кнопка создания заявки (проверка доступа)
  bool addOrderButton(Accesses? allAccesses);

  // сопоставление корзины и уникальных комплектующих
  int uiCheckQuantity(List cart, Map uniqItem);

  // получаем комментарий для отображения
  String uiGetComment(List cart, Map uniqItem);

  // редактирование данных API ключ:значение списка уникальных комплектующих
  List editDataUniqItems(List startItems);

  // отправка заявки (сохранение в БД)
  Future<String> sendNewOrder(List cart);

  // выдача комплектующих (проверка доступа)
  bool simExOrdersAccess(Accesses? allAccesses);

  // приемка комплектующих (проверка доступа)
  bool simTakeOrdersAccess(Accesses? allAccesses);


}

