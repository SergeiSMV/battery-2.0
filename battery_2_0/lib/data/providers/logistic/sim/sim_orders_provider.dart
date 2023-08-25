import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../../domain/models/user/user.dart';
import '../../../../domain/repository/server/server_data.dart';
import '../../../../domain/repository/server/sim.dart';
import '../../../departments/logistic/sim_orders_impl.dart';
import '../../../user/device_impl.dart';
import '../../../user/user_impl.dart';



final closeOrdersProvider = StateProvider((ref) => []);

// WebSocketChannel запроса всех заявок
final simOrdersChannelProvider = Provider((ref) {
  return WebSocketChannel.connect(Uri.parse('$mainRoute$simAllOrders'));
});


// WebSocketChannel запроса всех заявок
final simOrdersProvider = StreamProvider.autoDispose<List>((ref) async* {

  final User user = User(userInfoData: UserImpl().savedUserInfo());
  String device = DeviceImpl().getSavedDeviceId();
  Map<String, dynamic> data = {'device': device, 'user_id': user.id};
  try {ref.container.refresh(simOrdersChannelProvider);} catch (e){ null; }
  var bStream = ref.watch(simOrdersChannelProvider).stream.asBroadcastStream(onCancel: (sub) => sub.cancel());

  bool isSubControlError = false;

  ref.watch(simOrdersChannelProvider).sink.add(jsonEncode(data));
  final sub = bStream.listen(
    (result){},
    onError: (_, stack) => null,
    onDone: () async {
      isSubControlError = true;
      await Future.delayed(const Duration(seconds: 10));
      try {ref.container.refresh(simOrdersChannelProvider);} catch (e){ null; }
    },
  );

  ref.onDispose(() {
    sub.cancel();
    if (isSubControlError == false){
      ref.watch(simOrdersChannelProvider).sink.close(1000);
      ref.container.refresh(simOrdersChannelProvider);
    }
  }); 

  await for (final result in bStream) {
    List orders = jsonDecode(result);
    List fullDataOrders = SimOrdersImpl().editDataOrders(orders);
    List closedOrders = SimOrdersImpl().closedOrders(fullDataOrders);
    List openedOrders = SimOrdersImpl().openedOrders(fullDataOrders);
    ref.read(closeOrdersProvider.notifier).state = closedOrders;
    yield openedOrders;
  }

});


// WebSocketChannel запроса комплектующих по выбраной заявке
final simSelectedOrderChannelProvider = Provider((ref) {
  return WebSocketChannel.connect(Uri.parse('$mainRoute$simOrderItems'));
});

// stream WebSocketChannel запроса комплектующих по выбраной заявке
final simSelectedOrderProvider = StreamProvider.autoDispose.family<List, String>((ref, orederNum) async* {
  final User user = User(userInfoData: UserImpl().savedUserInfo());
  String device = DeviceImpl().getSavedDeviceId();
  Map<String, dynamic> data = {'device': device, 'user_id': user.id, 'num': orederNum};
  try {ref.container.refresh(simSelectedOrderChannelProvider);} catch (e){ null; }
  var bStream = ref.watch(simSelectedOrderChannelProvider).stream.asBroadcastStream(onCancel: (sub) => sub.cancel());

  bool isSubControlError = false;

  ref.watch(simSelectedOrderChannelProvider).sink.add(jsonEncode(data));
  final sub = bStream.listen(
    (result){},
    onError: (_, stack) => null,
    onDone: () async {
      isSubControlError = true;
      await Future.delayed(const Duration(seconds: 10));
      try {ref.container.refresh(simSelectedOrderChannelProvider);} catch (e){ null; }
    },
  );

  ref.onDispose(() {
    sub.cancel();
    if (isSubControlError == false){
      ref.watch(simSelectedOrderChannelProvider).sink.close(1000);
      ref.container.refresh(simSelectedOrderChannelProvider);
    }
  }); 

  await for (final result in bStream) {
    List items = jsonDecode(result);
    yield items;
  }

});



// WebSocketChannel запроса уникальных комплектующих для создания заявки
final simUniqItemsChannelProvider = Provider((ref) {
  return WebSocketChannel.connect(Uri.parse('$mainRoute$simUniqItems'));
});


// stream WebSocketChannel запроса уникальных комплектующих для создания заявки
final simUniqItemsProvider = StreamProvider.autoDispose<List>((ref) async* {
  final User user = User(userInfoData: UserImpl().savedUserInfo());
  String device = DeviceImpl().getSavedDeviceId();
  Map<String, dynamic> data = {'device': device, 'user_id': user.id};
  try {ref.container.refresh(simUniqItemsChannelProvider);} catch (e){ null; }
  var bStream = ref.watch(simUniqItemsChannelProvider).stream.asBroadcastStream(onCancel: (sub) => sub.cancel());

  bool isSubControlError = false;

  ref.watch(simUniqItemsChannelProvider).sink.add(jsonEncode(data));
  final sub = bStream.listen(
    (result){},
    onError: (_, stack) => null,
    onDone: () async {
      isSubControlError = true;
      await Future.delayed(const Duration(seconds: 10));
      try {ref.container.refresh(simUniqItemsChannelProvider);} catch (e){ null; }
    },
  );

  ref.onDispose(() {
    sub.cancel();
    if (isSubControlError == false){
      ref.watch(simUniqItemsChannelProvider).sink.close(1000);
      ref.container.refresh(simUniqItemsChannelProvider);
    }
  }); 

  await for (final result in bStream) {
    List items = jsonDecode(result);
    List uniqItems = SimOrdersImpl().editDataUniqItems(items);
    yield uniqItems;
  }

});

