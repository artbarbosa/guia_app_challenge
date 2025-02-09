import 'dart:convert';

import 'package:app_challenge/app/modules/motel/infra/model/suite_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const suiteJson = {
    "nome": "Suíte Marselha",
    "qtd": 1,
    "exibirQtdDisponiveis": true,
    "fotos": [
      "https://cdn.guiademoteis.com.br/imagens/suites/big/3148_big_9827_1.jpg"
    ],
    "itens": [
      {"nome": "Banheira"},
      {"nome": "Sauna"}
    ],
    "categoriaItens": [
      {"nome": "Luxo", "icone": "icon_luxo.png"}
    ],
    "periodos": [
      {
        "tempoFormatado": "3 horas",
        "tempo": "3",
        "valor": 88.0,
        "valorTotal": 88.0,
        "temCortesia": false,
        "desconto": {"desconto": 10.0}
      }
    ]
  };

  group('SuiteModel', () {
    test('Should create a valid SuiteModel from JSON', () {
      final suiteModel = SuiteModel.fromJson(suiteJson);

      expect(suiteModel.name, "Suíte Marselha");
      expect(suiteModel.quantity, 1);
      expect(suiteModel.showAvailableQuantity, true);
      expect(suiteModel.photos, isA<List<String>>());
      expect(suiteModel.photos.length, 1);
      expect(suiteModel.items, isA<List<String>>());
      expect(suiteModel.items.length, 2);
      expect(suiteModel.categoryItems, isA<List>());
      expect(suiteModel.categoryItems.length, 1);
      expect(suiteModel.periods, isA<List>());
      expect(suiteModel.periods.length, 1);
    });

    test('Should handle missing optional fields in JSON', () {
      final jsonWithoutOptionalFields = {
        "nome": "Suíte Marselha",
        "qtd": 1,
        "exibirQtdDisponiveis": true,
        "periodos": []
      };

      final suiteModel = SuiteModel.fromJson(jsonWithoutOptionalFields);

      expect(suiteModel.name, "Suíte Marselha");
      expect(suiteModel.photos, isEmpty);
      expect(suiteModel.items, isEmpty);
      expect(suiteModel.categoryItems, isEmpty);
    });

    test('Should correctly serialize a SuiteModel back to JSON', () {
      final suiteModel = SuiteModel.fromJson(suiteJson);

      final jsonOutput = jsonEncode({
        "nome": suiteModel.name,
        "qtd": suiteModel.quantity,
        "exibirQtdDisponiveis": suiteModel.showAvailableQuantity,
        "fotos": suiteModel.photos,
        "itens": suiteModel.items.map((item) => {"nome": item}).toList(),
        "categoriaItens": suiteModel.categoryItems
            .map((c) => {
                  "nome": c.name,
                  "icone": c.icon,
                })
            .toList(),
        "periodos": suiteModel.periods
            .map((p) => {
                  "tempoFormatado": p.formattedTime,
                  "tempo": p.time,
                  "valor": p.price,
                  "valorTotal": p.totalPrice,
                  "temCortesia": p.hasCourtesy,
                  "desconto":
                      p.discount != null ? {"desconto": p.discount} : null,
                })
            .toList(),
      });

      final expectedJson = jsonEncode(suiteJson);
      expect(jsonOutput, expectedJson);
    });

    test(
        'Should return an empty list when "fotos", "itens" or "categoriaItens" are null',
        () {
      final jsonWithNullLists = {
        "nome": "Suíte Marselha",
        "qtd": 1,
        "exibirQtdDisponiveis": true,
        "fotos": null,
        "itens": null,
        "categoriaItens": null,
        "periodos": []
      };

      final suiteModel = SuiteModel.fromJson(jsonWithNullLists);

      expect(suiteModel.photos, isA<List<String>>());
      expect(suiteModel.photos.isEmpty, true);
      expect(suiteModel.items, isA<List<String>>());
      expect(suiteModel.items.isEmpty, true);
      expect(suiteModel.categoryItems, isA<List>());
      expect(suiteModel.categoryItems.isEmpty, true);
    });
  });
}
