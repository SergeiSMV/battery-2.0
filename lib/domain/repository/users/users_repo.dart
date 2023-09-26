

abstract class UsersRepository {

  Future<List> allUsers();

  Future<List> selectedUserAccesses(String id);

  Future<String> saveUserAccesses(Map accessesData);

  Future<String> editUser(String id);

  Future<String> deleteUser(String id);

}