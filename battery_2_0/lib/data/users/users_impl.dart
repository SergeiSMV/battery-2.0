import 'dart:convert';

import 'package:battery_2_0/domain/repository/users/users_repo.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../domain/repository/server_routers/server_data.dart';
import '../../domain/repository/server_routers/users.dart';

class UsersImpl extends UsersRepository {
  
  
  @override
  Future<List> allUsers() async {
    List users = [];
    WebSocketChannel channel = WebSocketChannel.connect(Uri.parse('$mainRoute$allUsersRoute'));
    channel.sink.add(jsonEncode([]));
    await channel.stream.single.then((value) {
      value == null ? null : users = jsonDecode(value);
    });

    return users;
  }
  
  @override
  Future<List> selectedUserAccesses(String id) async {
    List userAccesses = [];
    WebSocketChannel channel = WebSocketChannel.connect(Uri.parse('$mainRoute$accessesUserRoute'));
    channel.sink.add(jsonEncode({'user_id': id}));
    await channel.stream.single.then((value) {
      value == null ? null : userAccesses = jsonDecode(value);
    });

    return userAccesses;
  }
  
  @override
  Future<String> saveUserAccesses(Map accessesData) async {
    String responce = '';
    WebSocketChannel channel = WebSocketChannel.connect(Uri.parse('$mainRoute$accessesUpdateRoute'));
    channel.sink.add(jsonEncode(accessesData));
    await channel.stream.single.then((value) {
      value == null ? null : responce = jsonDecode(value);
    });

    return responce;
  }

  @override
  Future<String> deleteUser(String id) {
    throw UnimplementedError();
  }
  
  @override
  Future<String> editUser(String id) {
    throw UnimplementedError();
  }

}