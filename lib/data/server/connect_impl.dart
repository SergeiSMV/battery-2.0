import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../../domain/repository/server/connect_repo.dart';
import '../../domain/repository/server/server_data.dart';

class ConnectionImpl extends ConnectionRepository{
  
  
  @override
  Future request(String route, Map data) async {
    bool isConnected = true;
    WebSocketChannel channel = WebSocketChannel.connect(Uri.parse('$mainRoute$route'));
    await channel.ready.onError((error, stackTrace) => isConnected = false);

    if(isConnected == false){
      return 'сервер отключен';
    } else {
      try{
        dynamic result;
        channel.sink.add(jsonEncode(data));
        await channel.stream.single.then((value) {
          result = jsonDecode(value);
          return result;
        });
        return result;
      } on Error catch (_){
        return '$_ (server ERROR)';
      } on Exception catch (_){
        return '$_ (server EXCEPTION)';
      }
    }
  }

}