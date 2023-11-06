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
      final response = await remoteDatasource.get(url: '/json/$ip');
      return IPLocationModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Error while fetching IP Location from remote');
    }
  }
}
