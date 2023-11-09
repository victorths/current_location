import 'package:current_location/app/core/core.dart';
import 'package:current_location/app/modules/map/domain/entities/current_position_entity.dart';
import 'package:current_location/app/modules/map/domain/use_cases/fetch_current_position_use_case.dart';
import 'package:current_location/app/modules/map/presentation/map_page_controller.dart';
import 'package:current_location/app/modules/map/presentation/map_store.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:mocktail/mocktail.dart';

class FetchCurrentPositionUseCaseImpl extends Mock
    implements FetchCurrentPositionUseCase {}

class MockMapController extends Mock implements MapController {}

void main() {
  late MapPageController controller;
  late FetchCurrentPositionUseCaseImpl fetchCurrentPositionUseCase;

  setUpAll(() {
    // Mock the UseCase
    fetchCurrentPositionUseCase = FetchCurrentPositionUseCaseImpl();
    // Mock flutter_map MapController
    final mapController = MockMapController();
    // Mock the .move function on flutter_map MapController
    when(
      () => mapController.move(const LatLng(-5.2056747, -37.3820791), 15),
    ).thenAnswer(
      (_) => true,
    );
    // Create the controller instance
    controller = MapPageController(
      store: MapStore(mapController),
      fetchCurrentPositionUseCase: fetchCurrentPositionUseCase,
    );
  });

  group('MapPageController', () {
    test(
      'should save the CurrentPositionEntity on the store in case of success.',
      () async {
        // Fake position
        const position = CurrentPositionEntity(
          lat: -5.2056747,
          long: -37.3820791,
        );
        // Return the fake position when call the fetchCurrentPositionUseCase
        when(
          () => fetchCurrentPositionUseCase.call(),
        ).thenAnswer(
          (_) => Future.value(
            position,
          ),
        );
        // Before call the fetchPosition method the store should be on loading status
        expect(controller.store.status, equals(StateStoreStatus.loading));
        // Call the method
        await controller.fetchPosition();
        // Verify if the UseCase was called 1 time
        verify(fetchCurrentPositionUseCase).called(1);
        // Verify if the flutter_map MapController.move was called 1 time
        verify(() => controller.store.mapController
            .move(const LatLng(-5.2056747, -37.3820791), 15)).called(1);
        // After call the fetchPosition method the store should be on completed status if nothing goes wrong
        expect(controller.store.status, equals(StateStoreStatus.completed));
        // the fake position should be on the store currentPosition
        expect(controller.store.currentPosition, equals(position));
      },
    );

    test(
      'should change the store status to error when anything goes wrong and set the error to store ',
      () async {
        // Fake exception
        final exception = Exception('Ops, something wrong.');
        // Throws the fake exception when call the fetchCurrentPositionUseCase
        when(
          () => fetchCurrentPositionUseCase.call(),
        ).thenThrow(exception);
        // Before call the fetchPosition method the store should be on completed status after the previous invocation
        expect(controller.store.status, equals(StateStoreStatus.completed));
        // Call the method
        await controller.fetchPosition();
        // Verify if the UseCase was called 1 time
        verify(fetchCurrentPositionUseCase).called(1);
        // Verify if the flutter_map MapController.move was not called because the error occour before it's invocation
        verifyNever(() => controller.store.mapController
            .move(const LatLng(-5.2056747, -37.3820791), 15));
        // When anything goes wrong the store Status should be error
        expect(controller.store.status, equals(StateStoreStatus.error));
        //  the error value should be equals to the fake exception
        expect(controller.store.error, equals(exception));
      },
    );
  });
}
