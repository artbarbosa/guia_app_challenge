import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/shared/consts/app_colors.dart';
import 'modules/motel/motel_module.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Teste',
      debugShowCheckedModeBanner: false,
      routerConfig: Modular.routerConfig,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
        ),
      ),
    );
  }
}

class AppModule extends Module {
  @override
  void routes(r) async {
    r.module("/", module: MotelModule());
  }
}
