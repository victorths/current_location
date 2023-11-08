import 'package:flutter_map/flutter_map.dart';
import 'package:get/state_manager.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/core.dart';
import '../map_page_controller.dart';

class CurrentPositionMarker extends StatelessWidget {
  const CurrentPositionMarker({
    super.key,
    required this.controller,
  });

  final MapPageController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final currentPosition = controller.store.currentPosition;
        return MarkerLayer(
          markers: [
            if (currentPosition != null)
              Marker(
                point: LatLng(currentPosition.lat, currentPosition.long),
                child: const Icon(
                  Icons.location_pin,
                  size: 36,
                ),
              ),
          ],
        );
      },
    );
  }
}
