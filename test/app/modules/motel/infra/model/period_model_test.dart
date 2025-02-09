import 'dart:convert';

import 'package:app_challenge/app/modules/motel/infra/model/period_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const periodJson = {
    "tempoFormatado": "3 horas",
    "tempo": "3",
    "valor": 88.0,
    "valorTotal": 88.0,
    "temCortesia": false,
    "desconto": {"desconto": 10.0}
  };

  group('PeriodModel', () {
    test('Should create a valid PeriodModel from JSON', () {
      final periodModel = PeriodModel.fromJson(periodJson);

      expect(periodModel.formattedTime, "3 horas");
      expect(periodModel.time, "3");
      expect(periodModel.price, 88.0);
      expect(periodModel.totalPrice, 88.0);
      expect(periodModel.hasCourtesy, false);
      expect(periodModel.discount, 10.0);
    });

    test('Should handle missing optional fields in JSON', () {
      final jsonWithoutDiscount = {
        "tempoFormatado": "3 horas",
        "tempo": "3",
        "valor": 88.0,
        "valorTotal": 88.0,
        "temCortesia": false,
        "desconto": null
      };

      final periodModel = PeriodModel.fromJson(jsonWithoutDiscount);

      expect(periodModel.formattedTime, "3 horas");
      expect(periodModel.discount, isNull);
    });

    test('Should correctly serialize a PeriodModel back to JSON', () {
      final periodModel = PeriodModel.fromJson(periodJson);

      final jsonOutput = jsonEncode({
        "tempoFormatado": periodModel.formattedTime,
        "tempo": periodModel.time,
        "valor": periodModel.price,
        "valorTotal": periodModel.totalPrice,
        "temCortesia": periodModel.hasCourtesy,
        "desconto": periodModel.discount != null
            ? {"desconto": periodModel.discount}
            : null,
      });

      final expectedJson = jsonEncode(periodJson);
      expect(jsonOutput, expectedJson);
    });

    test('Should return null when "desconto" is missing', () {
      final jsonWithNullDiscount = {
        "tempoFormatado": "3 horas",
        "tempo": "3",
        "valor": 88.0,
        "valorTotal": 88.0,
        "temCortesia": false,
        "desconto": null
      };

      final periodModel = PeriodModel.fromJson(jsonWithNullDiscount);

      expect(periodModel.discount, isNull);
    });
  });
}
