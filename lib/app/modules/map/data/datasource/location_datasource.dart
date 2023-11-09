import 'package:current_location/app/modules/map/domain/entities/current_position_entity.dart';

abstract class LocationDatasource {
  Future<bool> get isServiceIsEnabled;

  Future<bool> requestPermission();

  Future<CurrentPositionEntity> fetchPosition();
}
