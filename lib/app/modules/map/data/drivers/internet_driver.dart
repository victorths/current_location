import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';

import '../datasource/internet_datasource.dart';

class InternetDriver implements InternetDatasource {
  InternetDriver()
      : network = NetworkInfo(),
        connectivity = Connectivity();

  final NetworkInfo network;
  final Connectivity connectivity;

  @override
  Future<String?> get ip async {
    try {
      return network.getWifiIP();
    } catch (e) {
      throw Exception('Error while trying to fetch Device IP');
    }
  }

  @override
  Future<bool> get isConnected async {
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());
      return connectivityResult != ConnectivityResult.none;
    } catch (e) {
      throw Exception('Error while trying to check internet connectivity');
    }
  }
}
