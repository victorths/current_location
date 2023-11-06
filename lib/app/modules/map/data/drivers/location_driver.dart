import 'package:current_location/app/modules/map/domain/entities/current_position_entity.dart';
import 'package:geolocator/geolocator.dart';

import '../datasource/location_datasource.dart';

class LocationDriver implements LocationDatasource {
  @override
  Future<bool> get isServiceIsEnabled async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (serviceEnabled) {
        return true;
      }
      return false;
    } catch (e) {
      throw Exception('Error while trying to check location service status');
    }
  }

  @override
  Future<bool> requestPermission() async {
    try {
      final permission = await Geolocator.requestPermission();
      return switch (permission) {
        LocationPermission.deniedForever ||
        LocationPermission.denied ||
        LocationPermission.unableToDetermine =>
          false,
        _ => true,
      };
    } catch (e) {
      throw Exception('Error while trying to request location permission');
    }
  }

  @override
  Future<CurrentPositionEntity> fetchPosition() async {
    try {
      final position = await Geolocator.getCurrentPosition();
      return CurrentPositionEntity(
        lat: position.latitude,
        long: position.longitude,
      );
    } catch (e) {
      throw Exception('Error while trying to retrieve device position');
    }
  }
}
