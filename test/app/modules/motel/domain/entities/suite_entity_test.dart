import 'package:app_challenge/app/modules/motel/domain/entities/period_entity.dart';
import 'package:app_challenge/app/modules/motel/domain/entities/suite_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SuiteEntity Tests', () {
    const period1 = PeriodEntity(
      formattedTime: '3 horas',
      time: '3',
      price: 88.0,
      totalPrice: 88.0,
      hasCourtesy: false,
      discount: 10.0,
    );

    const period2 = PeriodEntity(
      formattedTime: '6 horas',
      time: '6',
      price: 101.0,
      totalPrice: 101.0,
      hasCourtesy: false,
      discount: null,
    );

    test('Should consider two identical SuiteEntity instances as equal', () {
      const suite1 = SuiteEntity(
        name: 'Suíte Marselha',
        quantity: 1,
        showAvailableQuantity: true,
        periods: [period1, period2],
      );

      const suite2 = SuiteEntity(
        name: 'Suíte Marselha',
        quantity: 1,
        showAvailableQuantity: true,
        periods: [period1, period2],
      );

      expect(suite1, equals(suite2));
    });

    test('Should consider different SuiteEntity instances as NOT equal', () {
      const suite1 = SuiteEntity(
        name: 'Suíte Marselha',
        quantity: 1,
        showAvailableQuantity: true,
        periods: [period1],
      );

      const suite2 = SuiteEntity(
        name: 'Suíte Nice',
        quantity: 2,
        showAvailableQuantity: false,
        periods: [period2],
      );

      expect(suite1, isNot(equals(suite2)));
    });

    test('Should differentiate instances based on showAvailableQuantity', () {
      const suite1 = SuiteEntity(
        name: 'Suíte Marselha',
        quantity: 1,
        showAvailableQuantity: true,
        periods: [period1],
      );

      const suite2 = SuiteEntity(
        name: 'Suíte Marselha',
        quantity: 1,
        showAvailableQuantity: false,
        periods: [period1],
      );

      expect(suite1, isNot(equals(suite2)));
    });

    test(
        'Should ensure that changing a single property makes instances different',
        () {
      const suite1 = SuiteEntity(
        name: 'Suíte Marselha',
        quantity: 1,
        showAvailableQuantity: true,
        periods: [period1, period2],
      );

      const suite2 = SuiteEntity(
        name: 'Suíte Marselha',
        quantity: 2,
        showAvailableQuantity: true,
        periods: [period1, period2],
      );

      expect(suite1, isNot(equals(suite2)));
    });

    test('Should allow an empty list of periods', () {
      const suite = SuiteEntity(
        name: 'Suíte Nantes',
        quantity: 3,
        showAvailableQuantity: true,
        periods: [],
      );

      expect(suite.periods, isEmpty);
    });
  });
}
