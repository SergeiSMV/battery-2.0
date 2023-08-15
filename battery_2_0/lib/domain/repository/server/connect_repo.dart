


abstract class ConnectionRepository {

  // разовый запрос к серверу
  Future request(String route, Map data);

}