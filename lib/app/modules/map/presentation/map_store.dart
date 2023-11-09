import 'package:current_location/app/core/core.dart';
import 'package:current_location/app/modules/map/domain/entities/current_position_entity.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';

class MapStore extends StateStore {
  MapStore(this.mapController);

  final MapController mapController;

  final _currentPosition = Rxn<CurrentPositionEntity>();
  CurrentPositionEntity? get currentPosition => _currentPosition.value;
  set currentPosition(CurrentPositionEntity? value) =>
      _currentPosition.value = value;
}
