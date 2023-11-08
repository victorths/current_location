enum LocationProvider {
  geolocation,
  internet,
}

class CurrentPositionEntity {
  CurrentPositionEntity({
    required this.lat,
    required this.long,
    this.provider = LocationProvider.geolocation,
  });

  final double lat;
  final double long;
  final LocationProvider provider;
}
