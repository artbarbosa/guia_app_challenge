import 'package:app_challenge/app/modules/motel/domain/entities/period_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PeriodEntity Tests', () {
    test('Should consider two identical PeriodEntity instances as equal', () {
      const period1 = PeriodEntity(
        formattedTime: '3 horas',
        time: '3',
        price: 88.0,
        totalPrice: 88.0,
        hasCourtesy: false,
        discount: 10.0,
      );

      const period2 = PeriodEntity(
        formattedTime: '3 horas',
        time: '3',
        price: 88.0,
        totalPrice: 88.0,
        hasCourtesy: false,
        discount: 10.0,
      );

      expect(period1, equals(period2));
    });

    test('Should consider different PeriodEntity instances as NOT equal', () {
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
        discount: 15.0,
      );

      expect(period1, isNot(equals(period2)));
    });

    test('Should consider discount = null and discount = 0.0 as different', () {
      const period1 = PeriodEntity(
        formattedTime: '3 horas',
        time: '3',
        price: 88.0,
        totalPrice: 88.0,
        hasCourtesy: false,
        discount: null,
      );

      const period2 = PeriodEntity(
        formattedTime: '3 horas',
        time: '3',
        price: 88.0,
        totalPrice: 88.0,
        hasCourtesy: false,
        discount: 0.0,
      );

      expect(period1, isNot(equals(period2)));
    });

    test('Should allow nullable discount and work with Equatable', () {
      const period = PeriodEntity(
        formattedTime: '12 horas',
        time: '12',
        price: 129.58,
        totalPrice: 81.58,
        hasCourtesy: false,
        discount: null,
      );

      expect(period.discount, isNull);
      expect(period.props.contains(null), isTrue);
    });

    test(
        'Should ensure that changing a single property makes instances different',
        () {
      const period1 = PeriodEntity(
        formattedTime: '3 horas',
        time: '3',
        price: 88.0,
        totalPrice: 88.0,
        hasCourtesy: false,
        discount: 10.0,
      );

      const period2 = PeriodEntity(
        formattedTime: '3 horas',
        time: '3',
        price: 100.0,
        totalPrice: 88.0,
        hasCourtesy: false,
        discount: 10.0,
      );

      expect(period1, isNot(equals(period2)));
    });
  });
}
