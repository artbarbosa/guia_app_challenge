import 'package:app_challenge/app/modules/motel/domain/entities/motel_entity.dart';
import 'package:app_challenge/app/modules/motel/domain/entities/suite_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MotelEntity', () {
    test('Should return true when comparing two equal MotelEntity instances',
        () {
      const motel1 = MotelEntity(
        name: 'Motel Le Nid',
        logo:
            'https://cdn.guiademoteis.com.br/imagens/logotipos/3148-le-nid.gif',
        neighborhood: 'Chácara Flora - São Paulo',
        distance: 28.27,
        rating: 4.6,
        suites: [],
      );

      const motel2 = MotelEntity(
        name: 'Motel Le Nid',
        logo:
            'https://cdn.guiademoteis.com.br/imagens/logotipos/3148-le-nid.gif',
        neighborhood: 'Chácara Flora - São Paulo',
        distance: 28.27,
        rating: 4.6,
        suites: [],
      );

      expect(motel1, equals(motel2));
    });

    test(
        'Should return false when comparing two different MotelEntity instances',
        () {
      const motel1 = MotelEntity(
        name: 'Motel A',
        logo: 'https://example.com/logo_a.png',
        neighborhood: 'Neighborhood A',
        distance: 20.0,
        rating: 4.5,
        suites: [],
      );

      const motel2 = MotelEntity(
        name: 'Motel B',
        logo: 'https://example.com/logo_b.png',
        neighborhood: 'Neighborhood B',
        distance: 25.0,
        rating: 4.2,
        suites: [],
      );

      expect(motel1, isNot(equals(motel2)));
    });

    test('Should correctly compare instances with different suites', () {
      const suite1 = SuiteEntity(
        name: 'Suite Deluxe',
        quantity: 2,
        periods: [],
        showAvailableQuantity: false,
      );

      const suite2 = SuiteEntity(
        name: 'Suite Premium',
        quantity: 1,
        periods: [],
        showAvailableQuantity: true,
      );

      const motel1 = MotelEntity(
        name: 'Motel X',
        logo: 'https://example.com/logo_x.png',
        neighborhood: 'Downtown',
        distance: 15.0,
        rating: 4.8,
        suites: [suite1],
      );

      const motel2 = MotelEntity(
        name: 'Motel X',
        logo: 'https://example.com/logo_x.png',
        neighborhood: 'Downtown',
        distance: 15.0,
        rating: 4.8,
        suites: [suite2],
      );

      expect(motel1, isNot(equals(motel2)));
    });
  });
}
