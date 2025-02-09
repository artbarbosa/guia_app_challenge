import 'package:app_challenge/app/core/shared/env/dev/dev.dart';
import 'package:app_challenge/app/core/shared/env/env.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Development Environment Tests', () {
    test('Should return correct baseUrlAPI for Development', () {
      final devEnv = Development();
      
      expect(devEnv.baseUrlAPI, 'https://jsonkeeper.com/b/1IXK');
    });

    test('Should set Development environment as Env.to', () {
      Env.to = Development();

      expect(Env.to, isA<Development>());
      expect(Env.to!.baseUrlAPI, 'https://jsonkeeper.com/b/1IXK');
    });
  });
}
