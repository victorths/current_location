import 'package:flutter/material.dart';
import 'package:current_location/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(
    ModularApp(
      module: AppModule(),
      child: const AppPage(),
    ),
  );
}
