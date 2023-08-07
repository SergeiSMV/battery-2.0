import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../users/users_impl.dart';



final usersAccessesProvider = FutureProvider.autoDispose.family<List, String>((ref, id) async {
  List selectedUserAccesses = await UsersImpl().selectedUserAccesses(id);
  ref.onDispose(() { selectedUserAccesses.clear(); });
  return selectedUserAccesses;
});


final newAccessesProvider = StateProvider<List>((ref) => []);