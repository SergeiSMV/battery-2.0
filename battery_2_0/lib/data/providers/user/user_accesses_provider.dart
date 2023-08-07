import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../domain/models/accesses/accesses.dart';
import '../../../domain/models/user/user.dart';
import '../../../domain/repository/server_routers/server_data.dart';
import '../../../domain/repository/server_routers/users.dart';
import '../../user/device_impl.dart';
import '../../user/user_impl.dart';



final accessChannelProvider = Provider((ref) {
  return WebSocketChannel.connect(Uri.parse('$mainRoute$accessesRoute'));
});


final allAccessesProvider = StreamProvider.autoDispose<Accesses>((ref) async* {

  final User user = User(userInfoData: UserImpl().savedUserInfo());
  String device = DeviceImpl().getSavedDeviceId();
  Map<String, dynamic> data = {'device': device, 'user_id': user.id};

  var bStream = ref.watch(accessChannelProvider).stream.asBroadcastStream(onCancel: (sub) => sub.cancel());

  bool isSubControlError = false;

  ref.watch(accessChannelProvider).sink.add(jsonEncode(data));
  final sub = bStream.listen(
    (result) {
      
    },
    onError: (_, stack) => null,
    onDone: () async {
      isSubControlError = true;
      await Future.delayed(const Duration(seconds: 10));
      try {ref.container.refresh(accessChannelProvider);} catch (e){ null; }
    },
  );

  ref.onDispose(() {
    sub.cancel();
    if (isSubControlError == false){
      ref.watch(accessChannelProvider).sink.close(1000);
      ref.container.refresh(accessChannelProvider);
    }
  }); 

  await for (final result in bStream) {
    Accesses accesses = Accesses(accessesList: jsonDecode(result));
    List chapters = UserImpl().otherChaptersAccess(accesses);
    ref.read(otherChaptersAccess.notifier).state = chapters;
    yield accesses;
  }

});



final otherChaptersAccess = StateProvider((ref) => []);









// ВАРИАНТ С AUTODISPOSE


// final channelProvider = Provider.autoDispose((ref) {
//   return WebSocketChannel.connect(Uri.parse('$mainRoute$chapterAccessRoute'));
// });


// final streamProvider = StreamProvider.autoDispose<Accesses>((ref) async* {

//   final User user = User(userInfoData: UserImpl().savedUserInfo());
//   Map<String, dynamic> data = {'user_id': user.id};
//   var bStream = ref.watch(channelProvider).stream.asBroadcastStream(onCancel: (sub) => sub.cancel());

//   bool isSubControlError = false;  

//   ref.watch(channelProvider).sink.add(jsonEncode(data));
//   final sub = bStream.listen(
//     (result) {
      
//     },
//     onError: (_, stack) => null,
//     onDone: () async {
//         isSubControlError = true;
//         await Future.delayed(const Duration(seconds: 10));
//         try {ref.container.refresh(channelProvider);} catch (e){ null; }
//     },
//   );  

//   ref.onDispose(() {
//     sub.cancel();
//     if (isSubControlError == false){
//       ref.watch(channelProvider).sink.close(1001);
//     }
//   }); 

//     await for (final result in bStream) {
//     Accesses accesses = Accesses(accessesList: jsonDecode(result));

//     yield accesses;
//   }
// });