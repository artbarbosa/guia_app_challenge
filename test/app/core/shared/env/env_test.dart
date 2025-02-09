import 'package:app_challenge/app/core/shared/env/env.dart';
import 'package:flutter_test/flutter_test.dart';

class MockDevelopment extends Env {
  MockDevelopment() {
    baseUrlAPI = 'https://api.dev.com';
    privateKey = 'mock_private_key';
  }
}

void main() {
  group('Env Tests', () {
    test('Should set environment to Development by default', () {
      Env.setEnvironment();

      expect(Env.to?.baseUrlAPI, "https://jsonkeeper.com/b/1IXK");
      expect(Env.to!.privateKey, isNull);
    });

    test('Should correctly initialize MockDevelopment environment', () {
      final mockEnv = MockDevelopment();
      expect(mockEnv.baseUrlAPI, 'https://api.dev.com');
      expect(mockEnv.privateKey, 'mock_private_key');
    });

    test('Should set correct instance on Env.to', () {
      final mockEnv = MockDevelopment();
      Env.to = mockEnv;

      expect(Env.to, equals(mockEnv));
      expect(Env.to!.baseUrlAPI, 'https://api.dev.com');
      expect(Env.to!.privateKey, 'mock_private_key');
    });

    test('Should handle ENV variable correctly', () {
      Env.setEnvironment();
      expect(Env.to, isA<Env>());
    });
  });
}
