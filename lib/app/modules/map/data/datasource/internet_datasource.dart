abstract class InternetDatasource {
  Future<String?> get ip;

  Future<bool> get isConnected;
}
