import 'package:current_location/app/modules/map/presentation/map_page_controller.dart';
import 'package:get/state_manager.dart';

import '../../../../core/core.dart';
import 'loading_map_widget.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({
    super.key,
    required this.controller,
  });

  final MapPageController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(
        () => switch (controller.store.status) {
          StateStoreStatus.loading => const LoadingWidget(),
          _ => const SizedBox.shrink(),
        },
      ),
    );
  }
}
