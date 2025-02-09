import 'package:app_challenge/app/modules/motel/domain/entities/motel_entity.dart';
import 'package:app_challenge/app/modules/motel/domain/entities/motel_search_result_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MotelSearchResultEntity', () {
    const motel1 = MotelEntity(
      name: 'Motel A',
      logo: 'https://example.com/motel_a.jpg',
      neighborhood: 'Downtown',
      distance: 10.5,
      rating: 4.3,
      suites: [],
    );

    const motel2 = MotelEntity(
      name: 'Motel B',
      logo: 'https://example.com/motel_b.jpg',
      neighborhood: 'Suburb',
      distance: 20,
      rating: 4.5,
      suites: [],
    );

    test('Should be equal when properties match', () {
      const result1 = MotelSearchResultEntity(
        page: 1,
        totalMotels: 2,
        totalSuites: 10,
        maxPages: 5,
        radius: 50,
        motels: [motel1, motel2],
      );

      const result2 = MotelSearchResultEntity(
        page: 1,
        totalMotels: 2,
        totalSuites: 10,
        maxPages: 5,
        radius: 50,
        motels: [motel1, motel2],
      );

      expect(result1, equals(result2));
    });

    test('Should not be equal when properties are different', () {
      const result1 = MotelSearchResultEntity(
        page: 1,
        totalMotels: 2,
        totalSuites: 10,
        maxPages: 5,
        radius: 50,
        motels: [motel1],
      );

      const result2 = MotelSearchResultEntity(
        page: 2,
        totalMotels: 3,
        totalSuites: 15,
        maxPages: 6,
        radius: 60,
        motels: [motel2],
      );

      expect(result1, isNot(equals(result2)));
    });

    test('Should maintain property values correctly', () {
      const result = MotelSearchResultEntity(
        page: 1,
        totalMotels: 5,
        totalSuites: 20,
        maxPages: 3,
        radius: 100,
        motels: [motel1],
      );

      expect(result.page, 1);
      expect(result.totalMotels, 5);
      expect(result.totalSuites, 20);
      expect(result.maxPages, 3);
      expect(result.radius, 100);
      expect(result.motels, contains(motel1));
    });
  });
}
