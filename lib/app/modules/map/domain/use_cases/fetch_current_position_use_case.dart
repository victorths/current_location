import 'package:current_location/app/modules/map/domain/repositories/location_repository.dart';

import '../entities/current_position_entity.dart';

abstract class FetchCurrentPositionUseCase {
  Future<CurrentPositionEntity> call();
}

class FetchCurrentPositionUseCaseImpl implements FetchCurrentPositionUseCase {
  FetchCurrentPositionUseCaseImpl({
    required this.repository,
  });

  final LocationRepository repository;

  @override
  Future<CurrentPositionEntity> call() => repository.fetchPosition();
}
