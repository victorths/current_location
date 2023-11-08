import 'package:latlong2/latlong.dart';

import '../../../core/core.dart';
import '../domain/use_cases/fetch_current_position_use_case.dart';
import 'map_store.dart';

class MapPageController extends PageLifeCycleController<MapStore> {
  MapPageController({
    required this.store,
    required this.fetchCurrentPositionUseCase,
  });

  final FetchCurrentPositionUseCase fetchCurrentPositionUseCase;

  @override
  final MapStore store;

  @override
  void onReady() {
    fetchPosition();
    super.onReady();
  }

  Future<void> fetchPosition() async {
    try {
      final position = await fetchCurrentPositionUseCase();
      store.currentPosition = position;
      store.mapController.move(LatLng(position.lat, position.long), 15);
      store.completed();
    } on Exception catch (e) {
      store.error = e;
    }
  }
}
