import 'dart:convert';

import 'package:battery_2_0/domain/models/accesses/accesses.dart';
import 'package:battery_2_0/domain/repository/user/user_repo.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_storage/get_storage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../domain/models/departments/departments.dart';
import '../../domain/models/user/user.dart';
import '../../domain/repository/server/server_data.dart';
import '../../domain/repository/server/users.dart';
import '../server/connect_impl.dart';
import 'device_impl.dart';

class UserImpl extends UserRepository{

  final userInfo = GetStorage();
  final userChapters = GetStorage();

  @override
  Future getUserInfo(Map<String, dynamic> userData) async {
    bool isConnected = true;
    WebSocketChannel channel = WebSocketChannel.connect(Uri.parse('$mainRoute$userInfoRoute'));
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

  @override
  Future<String> saveUserInfo(Map<String, dynamic> userData) async {
    var info = await getUserInfo(userData);
    info is Map<String, dynamic> ? userInfo.write('info', info) : null;
    if (info is Map<String, dynamic>){
      userInfo.write('info', info);
      return 'done';
    }
    else { return info; }
  }

  @override
  Map<String, dynamic> savedUserInfo() {
    return userInfo.read('info') ?? {};
  }

  @override
  void clearUserInfo() async {
    userInfo.remove('info');
  }
  
  @override
  Future<String> accessIndexing() async {
    String? userToken = await FirebaseMessaging.instance.getToken();
    String device = DeviceImpl().getSavedDeviceId();
    final User user = User(userInfoData: savedUserInfo());
    Map<String, dynamic> data = {'user_id': user.id, 'device': device, 'token': userToken};
    bool isConnected = true;
    WebSocketChannel channel = WebSocketChannel.connect(Uri.parse('$mainRoute$accessesIndexingRoute'));
    await channel.ready.onError((error, stackTrace) => isConnected = false);

    if(isConnected == false){
      return 'сервер отключен';
    } else {
      try{
        dynamic result;
        channel.sink.add(jsonEncode(data));
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

  @override
  List departmentsAccess(Accesses allAccesses) {
    List<Departments> departments = [];
    
    for (var dp in allAccesses.accessesList) {
      dp['department'] == 'main' ? {
        dp['chapter'] == 'logistic' ? dp['route'] = '/logistic' : null,
        dp['chapter'] == 'starters' ? dp['route'] = '/starters' : null,
        departments.add(Departments(departments: dp))
      } : null;
    }


    return departments;
  }

  @override
  List otherChaptersAccess(Accesses allAccesses) {
    List chapters = [];
    
    for (var dp in allAccesses.accessesList) {
      dp['depence'] == '' ? null : {
        chapters.add(dp['chapter'])
      };
    }

    return chapters;

  }

  @override
  Future exitAccount() async {
    dynamic requestResult;
    String device = DeviceImpl().getSavedDeviceId();
    final User user = User(userInfoData: savedUserInfo());
    Map<String, dynamic> data = {'user_id': user.id, 'device': device};
    await ConnectionImpl().request(exitAccountRoute, data).then((value) async {
      requestResult = value;
    });
    return requestResult;
  }




}