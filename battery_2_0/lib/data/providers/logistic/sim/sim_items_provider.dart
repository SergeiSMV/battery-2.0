import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../../domain/models/user/user.dart';
import '../../../../domain/repository/server_routers/server_data.dart';
import '../../../../domain/repository/server_routers/sim.dart';
import '../../../departments/logistic/sim_items_impl.dart';
import '../../../user/device_impl.dart';
import '../../../user/user_impl.dart';




final simItemsChannelProvider = Provider((ref) {
  return WebSocketChannel.connect(Uri.parse('$mainRoute$simAllItemsRoute'));
});


final simItemsProvider = StreamProvider.autoDispose<List>((ref) async* {

  final User user = User(userInfoData: UserImpl().savedUserInfo());
  String device = DeviceImpl().getSavedDeviceId();
  Map<String, dynamic> data = {'device': device, 'user_id': user.id};
  try {ref.container.refresh(simItemsChannelProvider);} catch (e){ null; }
  var bStream = ref.watch(simItemsChannelProvider).stream.asBroadcastStream(onCancel: (sub) => sub.cancel());

  bool isSubControlError = false;

  ref.watch(simItemsChannelProvider).sink.add(jsonEncode(data));
  final sub = bStream.listen(
    (result) {
      
    },
    onError: (_, stack) => null,
    onDone: () async {
      isSubControlError = true;
      await Future.delayed(const Duration(seconds: 10));
      try {ref.container.refresh(simItemsChannelProvider);} catch (e){ null; }
    },
  );

  ref.onDispose(() {
    sub.cancel();
    if (isSubControlError == false){
      ref.watch(simItemsChannelProvider).sink.close(1000);
      ref.container.refresh(simItemsChannelProvider);
    }
  }); 

  await for (final result in bStream) {
    List items = jsonDecode(result);
    List fullNameItems = SimItemsImpl().editDataItems(items);
    yield fullNameItems;
  }

});



