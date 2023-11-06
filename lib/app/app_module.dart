import 'core/commons.dart';
import 'core/data/infra/dio_datasource.dart';
import 'modules/map/presentation/map_module.dart';

class AppModule extends Module {
  @override
  void exportedBinds(i) {
    i.add<RemoteDatasource>(() => DioDatasource());
  }

  @override
  void routes(r) {
    r.module(
      Paths.map,
      module: MapModule(),
    );
  }
}
