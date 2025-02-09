import 'dart:convert';

import 'package:app_challenge/app/modules/motel/infra/model/category_item_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const categoryItemJson = {
    "nome": "TV a Cabo",
    "icone": "https://example.com/tv_icon.png"
  };

  group('CategoryItemModel', () {
    test('Should create a valid CategoryItemModel from JSON', () {
      final categoryItem = CategoryItemModel.fromJson(categoryItemJson);

      expect(categoryItem.name, "TV a Cabo");
      expect(categoryItem.icon, "https://example.com/tv_icon.png");
    });

    test('Should handle missing optional fields in JSON', () {
      final jsonWithoutIcon = {"nome": "TV a Cabo"};

      final categoryItem = CategoryItemModel.fromJson(jsonWithoutIcon);

      expect(categoryItem.name, "TV a Cabo");
      expect(categoryItem.icon, isNull);
    });

    test('Should correctly serialize a CategoryItemModel back to JSON', () {
      final categoryItem = CategoryItemModel.fromJson(categoryItemJson);

      final jsonOutput = jsonEncode({
        "nome": categoryItem.name,
        "icone": categoryItem.icon,
      });

      final expectedJson = jsonEncode(categoryItemJson);
      expect(jsonOutput, expectedJson);
    });
  });
}
