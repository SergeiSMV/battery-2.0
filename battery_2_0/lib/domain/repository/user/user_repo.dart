


import '../../models/accesses/accesses.dart';

abstract class UserRepository {

  Future getUserInfo(Map<String, String> userData);

  Future<String> saveUserInfo(Map<String, String> userData);

  Map<String, dynamic> savedUserInfo();

  Future<String> accessIndexing();

  void clearUserInfo();

  List departmentsAccess(Accesses allAccesses);

  List otherChaptersAccess(Accesses allAccesses);

  Future exitAccount();

}