import 'package:equatable/equatable.dart';

enum LocationProvider {
  geolocation,
  internet,
}

class CurrentPositionEntity extends Equatable {
  const CurrentPositionEntity({
    required this.lat,
    required this.long,
    this.provider = LocationProvider.geolocation,
  });

  final double lat;
  final double long;
  final LocationProvider provider;

  @override
  List<Object?> get props => [
        lat,
        long,
        provider,
      ];
}
