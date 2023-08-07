






abstract class LoginRepository {

  Future<String> login();
  
  Future checkLoginData(Map userData, bool autoLogin);

}