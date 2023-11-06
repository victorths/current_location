import '../models/location_model.dart';

abstract class IpDatasource {
  Future<IPLocationModel> fetchLocation(String ip);
}
