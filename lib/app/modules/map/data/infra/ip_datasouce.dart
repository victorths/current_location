import 'package:current_location/app/core/core.dart';
import 'package:current_location/app/modules/map/data/models/location_model.dart';

import '../datasource/ip_datasource.dart';

class IpDatasourceImpl implements IpDatasource {
  IpDatasourceImpl({
    required this.remoteDatasource,
  });

  final RemoteDatasource remoteDatasource;

  @override
  Future<IPLocationModel> fetchLocation(String ip) async {
    try {
      final response =
          await remoteDatasource.get(url: 'http://ip-api.com/json/$ip');
      if (response['status'] == 'fail') {
        throw Exception();
      }
      return IPLocationModel.fromJson(response);
    } catch (e) {
      throw Exception('Error while fetching IP Location from remote');
    }
  }

  @override
  Future<String> fetchIp() async {
    try {
      final response =
          await remoteDatasource.get(url: 'https://api.ipify.org?format=json');

      return response['ip'];
    } catch (e) {
      throw Exception('Error while fetching IP Location from remote');
    }
  }
}
