import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cache/flutter_map_cache.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/core.dart';
import '../map_page_controller.dart';
import 'current_position_marker.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({
    super.key,
    required this.controller,
    required this.cacheStore,
  });

  final MapPageController controller;
  final CacheStore cacheStore;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: controller.store.mapController,
      options: const MapOptions(
        keepAlive: true,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          tileProvider: CachedTileProvider(
            store: cacheStore,
          ),
          errorTileCallback: (tile, error, stackTrace) => showToast(
            context,
            "You need a internet connection to download the map once.",
          ),
        ),
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () =>
                  launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
            ),
          ],
        ),
        CurrentPositionMarker(controller: controller)
      ],
    );
  }
}
