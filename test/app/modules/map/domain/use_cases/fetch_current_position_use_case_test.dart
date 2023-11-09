import 'package:current_location/app/modules/map/domain/entities/current_position_entity.dart';
import 'package:current_location/app/modules/map/domain/repositories/location_repository.dart';
import 'package:current_location/app/modules/map/domain/use_cases/fetch_current_position_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class LocationRepositoryImpl extends Mock implements LocationRepository {}

void main() {
  late LocationRepositoryImpl repository;
  late FetchCurrentPositionUseCaseImpl fetchCurrentPositionUseCase;
  setUpAll(() {
    repository = LocationRepositoryImpl();
    fetchCurrentPositionUseCase =
        FetchCurrentPositionUseCaseImpl(repository: repository);
  });

  group('FetchCurrentPositionUseCase', () {
    test(
      'should return the CurrentPositionEntity that the repository returns',
      () async {
        // Fake position
        final position = CurrentPositionEntity(
          lat: -5.2056747,
          long: -37.3820791,
        );
        // Return the fake position when called
        when(
          () => repository.fetchPosition(),
        ).thenAnswer(
          (_) async => Future.value(
            position,
          ),
        );
        // Calls the use case
        final result = await fetchCurrentPositionUseCase();
        // Verify if the UseCase was called 1 time
        verify(fetchCurrentPositionUseCase).called(1);
        // the fake position should be returned
        expect(result, equals(position));
      },
    );

    test(
      'should throws the same Exception as fetchPosition() when it throws one',
      () async {
        // Fake exception
        final exception = Exception('Ops, something wrong.');
        // Throws the fake exception when call the fetchPosition()
        when(
          () => repository.fetchPosition(),
        ).thenThrow(exception);
        // Calls the use case and check if the exception was the same
        expect(
          () => fetchCurrentPositionUseCase(),
          throwsA(
            exception,
          ),
        );
      },
    );
  });
}
