import 'package:current_location/app/modules/map/data/datasource/internet_datasource.dart';
import 'package:current_location/app/modules/map/data/datasource/ip_datasource.dart';
import 'package:current_location/app/modules/map/data/datasource/location_datasource.dart';
import 'package:current_location/app/modules/map/data/models/location_model.dart';
import 'package:current_location/app/modules/map/data/repositories/location_repository.dart';
import 'package:current_location/app/modules/map/domain/entities/current_position_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class InternetDriver extends Mock implements InternetDatasource {}

class LocationDriver extends Mock implements LocationDatasource {}

class IpDatasourceImpl extends Mock implements IpDatasource {}

void main() {
  late InternetDriver internetDriver;
  late LocationDriver locationDriver;
  late IpDatasourceImpl datasource;
  late LocationRepositoryImpl locationRepository;

  setUpAll(() {
    internetDriver = InternetDriver();
    locationDriver = LocationDriver();
    datasource = IpDatasourceImpl();
    locationRepository = LocationRepositoryImpl(
      internetDatasource: internetDriver,
      ipDatasource: datasource,
      locationDatasource: locationDriver,
    );
  });

  group('LocationRepositoryImpl', () {
    test(
      'should return a CurrentPositionEntity with geolocation provider when the device location is on and the user accept the permission.',
      () async {
        // Fake position
        const CurrentPositionEntity position = CurrentPositionEntity(
          lat: -5.2056747,
          long: -37.3820791,
        );
        when(
          () => locationDriver.isServiceIsEnabled,
        ).thenAnswer(
          (_) => Future.value(
            true,
          ),
        );
        when(
          () => locationDriver.requestPermission(),
        ).thenAnswer(
          (_) => Future.value(
            true,
          ),
        );
        when(
          () => locationDriver.fetchPosition(),
        ).thenAnswer(
          (_) => Future.value(
            position,
          ),
        );
        // Calls the fetchPosition() method
        final result = await locationRepository.fetchPosition();
        // Verify if the isServiceIsEnabled was called 1 time
        verify(() => locationDriver.isServiceIsEnabled).called(1);
        // Verify if the requestPermission was called 1 time
        verify(locationDriver.requestPermission).called(1);
        // Verify if the fetchPosition was called 1 time
        verify(locationDriver.fetchPosition).called(1);
        // the fake position should be returned
        expect(result, equals(position));
      },
    );

    test(
      'should return a CurrentPositionEntity with internet provider when the device location is off or the user refuse the permission but has a active internet connection with a valid IP address.',
      () async {
        // Fake position
        const CurrentPositionEntity position = CurrentPositionEntity(
          lat: -5.2056747,
          long: -37.3820791,
          provider: LocationProvider.internet,
        );
        when(
          () => locationDriver.isServiceIsEnabled,
        ).thenAnswer(
          (_) => Future.value(
            false,
          ),
        );
        when(
          () => internetDriver.isConnected,
        ).thenAnswer(
          (_) => Future.value(
            true,
          ),
        );
        when(
          () => datasource.fetchIp(),
        ).thenAnswer(
          (_) => Future.value(
            '192.168.0.1',
          ),
        );
        when(
          () => datasource.fetchLocation('192.168.0.1'),
        ).thenAnswer(
          (_) => Future.value(
            IPLocationModel(
              lat: -5.2056747,
              long: -37.3820791,
            ),
          ),
        );

        // Calls the use case
        final result = await locationRepository.fetchPosition();
        // Verify if the isServiceIsEnabled was called 1 time
        verify(() => locationDriver.isServiceIsEnabled).called(1);
        // Verify if the requestPermission was not called
        verifyNever(locationDriver.requestPermission);
        // Verify if the fetchPosition was not called
        verifyNever(locationDriver.fetchPosition);
        // Verify if the isConnected was called 1 time
        verify(() => internetDriver.isConnected).called(1);
        // Verify if the datasource.fetchLocation was called 1 time
        verify(() => datasource.fetchLocation('192.168.0.1')).called(1);
        // Verify if the datasource.fetchLocation was called 1 time
        verify(datasource.fetchIp).called(1);
        // the fake position should be returned
        expect(result, equals(position));
      },
    );

    test(
      'should throw a Exception when both internetService and locationService is disabled',
      () async {
        when(
          () => locationDriver.isServiceIsEnabled,
        ).thenAnswer(
          (_) => Future.value(
            false,
          ),
        );
        when(
          () => internetDriver.isConnected,
        ).thenAnswer(
          (_) => Future.value(
            false,
          ),
        );
        try {
          await locationRepository.fetchPosition();
        } catch (e) {
          expect(
            e,
            isA<Exception>(),
          );
          expect(
            e.toString(),
            equals(
              'Exception: You need either the location service enabled or a active internet connection',
            ),
          );
        }
        // Verify if the isServiceIsEnabled was called 1 time
        verify(() => locationDriver.isServiceIsEnabled).called(1);
        // Verify if the requestPermission was not called
        verifyNever(locationDriver.requestPermission);
        // Verify if the fetchPosition was not called
        verifyNever(locationDriver.fetchPosition);
        // Verify if the isConnected was called 1 time
        verify(() => internetDriver.isConnected).called(1);
        // Verify if the datasource.fetchLocation was not called
        verifyNever(datasource.fetchIp);
        // Verify if the datasource.fetchLocation was not called
        verifyNever(() => datasource.fetchLocation('192.168.0.1'));
      },
    );

    test(
      'should throw a Exception when an invalid location is returned by the internet provider',
      () async {
        when(
          () => locationDriver.isServiceIsEnabled,
        ).thenAnswer(
          (_) => Future.value(
            false,
          ),
        );
        when(
          () => internetDriver.isConnected,
        ).thenAnswer(
          (_) => Future.value(
            true,
          ),
        );
        when(
          () => datasource.fetchIp(),
        ).thenAnswer(
          (_) => Future.value(
            '192.168.0.1',
          ),
        );
        when(
          () => datasource.fetchLocation('192.168.0.1'),
        ).thenAnswer(
          (_) => Future.value(
            // Invalid Location
            IPLocationModel(),
          ),
        );
        try {
          await locationRepository.fetchPosition();
        } catch (e) {
          expect(
            e,
            isA<Exception>(),
          );
          expect(
            e.toString(),
            equals(
              'Exception: Invalid location from yours internet provider',
            ),
          );
        }
        // Verify if the isServiceIsEnabled was called 1 time
        verify(() => locationDriver.isServiceIsEnabled).called(1);
        // Verify if the requestPermission was not called
        verifyNever(locationDriver.requestPermission);
        // Verify if the fetchPosition was not called
        verifyNever(locationDriver.fetchPosition);
        // Verify if the isConnected was called 1 time
        verify(() => internetDriver.isConnected).called(1);
        // Verify if the datasource.fetchLocation was called 1 time
        verify(datasource.fetchIp).called(1);
        // Verify if the datasource.fetchLocation was called 1 time
        verify(() => datasource.fetchLocation('192.168.0.1')).called(1);
      },
    );
  });
}
