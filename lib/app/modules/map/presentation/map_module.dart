import 'package:flutter_map/flutter_map.dart';

import '../../../app_module.dart';
import '../../../core/core.dart';
import '../data/datasource/internet_datasource.dart';
import '../data/datasource/ip_datasource.dart';
import '../data/datasource/location_datasource.dart';
import '../data/drivers/internet_driver.dart';
import '../data/drivers/location_driver.dart';
import '../data/infra/ip_datasouce.dart';
import '../data/repositories/location_repository.dart';
import '../domain/repositories/location_repository.dart';
import '../domain/use_cases/fetch_current_position_use_case.dart';
import 'map_page_controller.dart';
import 'map_store.dart';
import 'map_page.dart';

class MapModule extends Module {
  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void binds(i) {
    i.addSingleton<LocationDatasource>(LocationDriver.new);
    i.addSingleton<InternetDatasource>(InternetDriver.new);
    i.addSingleton<IpDatasource>(IpDatasourceImpl.new);
    i.addSingleton<LocationRepository>(LocationRepositoryImpl.new);
    i.addSingleton<FetchCurrentPositionUseCase>(
      FetchCurrentPositionUseCaseImpl.new,
    );
    i.addSingleton<MapController>(MapController.new);
    i.addSingleton<MapStore>(MapStore.new);
    i.addSingleton<MapPageController>(MapPageController.new);
  }

  @override
  void routes(r) {
    r.child(
      Paths.root,
      child: (c) => const MapPage(),
    );
  }
}
