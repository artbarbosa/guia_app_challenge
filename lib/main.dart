import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_widget.dart';
import 'app/core/shared/env/env.dart';
import 'app/core/shared/helpers/ssl_helper.dart';

void main() async {
  await Future.delayed(Duration(seconds: 10));
  WidgetsFlutterBinding.ensureInitialized();
  SSLHelper.ignoreCertificateErrors();

  Env.setEnvironment();

  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
