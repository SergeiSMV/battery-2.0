

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../users/users_impl.dart';

final allUsersProvider = FutureProvider.autoDispose((ref) async {
  List users = await UsersImpl().allUsers();
  return users;
});