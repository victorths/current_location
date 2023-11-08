import 'dart:io';

import 'package:get/state_manager.dart';

import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_file_store/dio_cache_interceptor_file_store.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/core.dart';
import '../domain/entities/current_position_entity.dart';
import 'map_page_controller.dart';
import 'widgets/map_status_widget.dart';
import 'widgets/map_widget.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ModularInjector<MapPage, MapPageController> {
  final Future<CacheStore> _cacheStoreFuture = _getCacheStore();

  static Future<CacheStore> _getCacheStore() async {
    final dir = await getTemporaryDirectory();
    return FileCacheStore('${dir.path}${Platform.pathSeparator}MapTiles');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<CacheStore>(
            future: _cacheStoreFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final cacheStore = snapshot.data!;
                return MapWidget(
                  controller: controller,
                  cacheStore: cacheStore,
                );
              }
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
          StatusWidget(controller: controller),
          LocationProviderWidget(controller: controller)
        ],
      ),
    );
  }
}

class LocationProviderWidget extends StatelessWidget {
  const LocationProviderWidget({
    super.key,
    required this.controller,
  });

  final MapPageController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.store.currentPosition == null) {
        return const SizedBox.shrink();
      }
      return SafeArea(
        top: true,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 80,
            width: MediaQuery.sizeOf(context).width * 0.8,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                controller.store.currentPosition!.provider ==
                        LocationProvider.internet
                    ? 'Approximate location based on your internet provider.'
                    : 'Precise location using your device\'s GPS',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
    });
  }
}
