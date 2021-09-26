class ConnectionService {
  static ConnectionService _instance;
  static ConnectionService get instance => _instance ?? ConnectionService();

  ConnectionService() {
    _instance = this;
  }

  final String apiKey = "9a03fa28b4268fc39e837e431fa0c1fc";
  final String authority = "ws.audioscrobbler.com";
  final String path = "2.0/";
}
