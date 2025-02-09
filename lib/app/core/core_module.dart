import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';

import 'shared/services/http_client/http_client_service.dart';
import 'shared/services/http_client/http_client_service_interface.dart';

class CoreModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<IHttpClientService>(
      () => HttpClientService(
        client: Client(),
      ),
    );
  }
}
