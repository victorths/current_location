import 'package:current_location/app/modules/map/data/datasource/location_datasource.dart';

import '../../domain/entities/current_position_entity.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasource/internet_datasource.dart';
import '../datasource/ip_datasource.dart';

class LocationRepositoryImpl implements LocationRepository {
  LocationRepositoryImpl({
    required this.datasource,
    required this.locationDatasource,
    required this.internetDatasource,
  });

  final IpDatasource datasource;
  final LocationDatasource locationDatasource;
  final InternetDatasource internetDatasource;

  @override
  Future<CurrentPositionEntity> fetchPosition() async {
    if (await locationDatasource.isServiceIsEnabled) {
      final permited = await locationDatasource.requestPermission();
      if (permited) {
        final position = await locationDatasource.fetchPosition();
        return CurrentPositionEntity(
          lat: position.lat,
          long: position.long,
        );
      }
    }
    if (!(await internetDatasource.isConnected)) {
      throw Exception(
        'You need either the location service enabled or a active internet connection',
      );
    }
    final ip = await internetDatasource.ip;
    if (ip == null) {
      throw Exception('Invalid IP Address, check you internet connection');
    }
    final position = await datasource.fetchLocation(ip);
    if (position.lat == null || position.long == null) {
      throw Exception('Invalid location from yours internet provider');
    }
    return CurrentPositionEntity(lat: position.lat!, long: position.long!);
  }
}
