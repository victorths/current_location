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
    store.completed();
    super.onReady();
  }

  Future<void> fetchPosition() async {}
}
