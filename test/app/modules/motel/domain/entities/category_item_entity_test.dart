import 'package:app_challenge/app/modules/motel/domain/entities/category_item_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CategoryItemEntity Tests', () {
    test('Should consider two identical CategoryItemEntity instances as equal',
        () {
      const category1 = CategoryItemEntity(
        name: 'Wi-Fi',
        icon: 'https://example.com/icons/wifi.png',
      );

      const category2 = CategoryItemEntity(
        name: 'Wi-Fi',
        icon: 'https://example.com/icons/wifi.png',
      );

      expect(category1, equals(category2));
    });

    test('Should consider different CategoryItemEntity instances as NOT equal',
        () {
      const category1 = CategoryItemEntity(
        name: 'Wi-Fi',
        icon: 'https://example.com/icons/wifi.png',
      );

      const category2 = CategoryItemEntity(
        name: 'Frigobar',
        icon: 'https://example.com/icons/frigobar.png',
      );

      expect(category1, isNot(equals(category2)));
    });

    test('Should differentiate instances based on the name field', () {
      const category1 = CategoryItemEntity(
        name: 'Wi-Fi',
        icon: 'https://example.com/icons/wifi.png',
      );

      const category2 = CategoryItemEntity(
        name: 'Internet',
        icon: 'https://example.com/icons/wifi.png',
      );

      expect(category1, isNot(equals(category2)));
    });

    test('Should differentiate instances based on the icon field', () {
      const category1 = CategoryItemEntity(
        name: 'Wi-Fi',
        icon: 'https://example.com/icons/wifi.png',
      );

      const category2 = CategoryItemEntity(
        name: 'Wi-Fi',
        icon: 'https://example.com/icons/new_wifi.png',
      );

      expect(category1, isNot(equals(category2)));
    });
  });
}
