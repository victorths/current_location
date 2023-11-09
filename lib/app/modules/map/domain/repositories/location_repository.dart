import 'package:current_location/app/modules/map/domain/entities/current_position_entity.dart';

abstract class LocationRepository {
  Future<CurrentPositionEntity> fetchPosition();
}
