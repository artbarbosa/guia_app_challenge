import 'dart:io';

class SSLHelper {
  static void ignoreCertificateErrors({bool enable = true}) {
    if (enable) {
      HttpOverrides.global = _CustomHttpOverrides();
    }
  }
}

class _CustomHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
