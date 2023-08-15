import 'dart:convert';

import 'package:battery_2_0/domain/repository/user/login_repo.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../domain/repository/server/server_data.dart';
import '../../domain/repository/server/users.dart';
import 'device_impl.dart';
import 'user_impl.dart';

class LoginImpl extends LoginRepository{
  final Map<String, dynamic> userData;
  final bool autoLogin;
  final UserImpl user = UserImpl();
  LoginImpl({required this.userData, required this.autoLogin});


  @override
  Future<String> login() async {
    var checkLoginDataResult = await checkLoginData(userData, autoLogin);
    
    if (checkLoginDataResult == 0){ return 'не правильный логин или пароль'; }
    
    else if (checkLoginDataResult == 1){
      autoLogin ? await DeviceImpl().saveCurrentDeviceId() : null;
      var result = await user.saveUserInfo(userData);
      var accessIndexingResult = await user.accessIndexing();
      if (result == 'done' && accessIndexingResult == 'done'){ return 'доступ разрешен'; }
      else { return 'ошибка запроса данных о пользователе'; }
    }
    
    else  { return checkLoginDataResult.toString(); }
  }
  
  @override
  Future<dynamic> checkLoginData(userData, autoLogin) async {
    bool isConnected = true;
    WebSocketChannel channel = WebSocketChannel.connect(Uri.parse('$mainRoute$loginRoute'));
    await channel.ready.onError((error, stackTrace) => isConnected = false);

    if(isConnected == false){
      return 'сервер отключен';
    } else {
      try{
        dynamic result;
        channel.sink.add(jsonEncode(userData));
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

}