import 'dart:convert';

import 'package:app_challenge/app/modules/motel/infra/model/motel_model.dart';
import 'package:app_challenge/app/modules/motel/infra/model/motel_search_result_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const motelSearchResultJson = {
    "sucesso": true,
    "data": {
      "pagina": 1,
      "totalMoteis": 10,
      "totalSuites": 50,
      "maxPaginas": 5.0,
      "raio": 20,
      "moteis": [
        {
          "fantasia": "Motel Le Nid",
          "logo":
              "https://cdn.guiademoteis.com.br/imagens/logotipos/3148-le-nid.gif",
          "bairro": "Chácara Flora - São Paulo",
          "distancia": 28.27,
          "media": 4.6,
          "suites": []
        }
      ]
    }
  };

  group('MotelSearchResultModel', () {
    test('Should create a valid MotelSearchResultModel from JSON', () {
      final motelSearchResult =
          MotelSearchResultModel.fromJson(motelSearchResultJson);

      expect(motelSearchResult.success, true);
      expect(motelSearchResult.page, 1);
      expect(motelSearchResult.totalMotels, 10);
      expect(motelSearchResult.totalSuites, 50);
      expect(motelSearchResult.maxPages, 5);
      expect(motelSearchResult.radius, 20.0);
      expect(motelSearchResult.motels, isA<List<MotelModel>>());
      expect(motelSearchResult.motels.length, 1);
    });

    test('Should handle missing optional fields in JSON', () {
      final jsonWithoutOptionalFields = {
        "sucesso": true,
        "data": {
          "pagina": 1,
          "totalMoteis": 10,
          "totalSuites": 50,
          "maxPaginas": 5.0,
          "raio": 20,
          "moteis": []
        }
      };

      final motelSearchResult =
          MotelSearchResultModel.fromJson(jsonWithoutOptionalFields);

      expect(motelSearchResult.success, true);
      expect(motelSearchResult.page, 1);
      expect(motelSearchResult.totalMotels, 10);
      expect(motelSearchResult.totalSuites, 50);
      expect(motelSearchResult.maxPages, 5);
      expect(motelSearchResult.radius, 20.0);
      expect(motelSearchResult.motels, isEmpty);
    });

    test('Should correctly serialize a MotelSearchResultModel back to JSON',
        () {
      final motelSearchResult =
          MotelSearchResultModel.fromJson(motelSearchResultJson);

      final jsonOutput = jsonEncode({
        "sucesso": motelSearchResult.success,
        "data": {
          "pagina": motelSearchResult.page,
          "totalMoteis": motelSearchResult.totalMotels,
          "totalSuites": motelSearchResult.totalSuites,
          "maxPaginas": motelSearchResult.maxPages,
          "raio": motelSearchResult.radius,
          "moteis": motelSearchResult.motels
              .map((m) => {
                    "fantasia": m.name,
                    "logo": m.logo,
                    "bairro": m.neighborhood,
                    "distancia": m.distance,
                    "media": m.rating,
                    "suites": m.suites
                        .map((s) => {
                              "nome": s.name,
                              "qtd": s.quantity,
                              "exibirQtdDisponiveis": s.showAvailableQuantity,
                              "periodos": s.periods
                                  .map((p) => {
                                        "tempoFormatado": p.formattedTime,
                                        "tempo": p.time,
                                        "valor": p.price,
                                        "valorTotal": p.totalPrice,
                                        "temCortesia": p.hasCourtesy,
                                        "desconto": p.discount,
                                      })
                                  .toList(),
                            })
                        .toList(),
                  })
              .toList(),
        }
      });

      final expectedJson = jsonEncode(motelSearchResultJson);
      expect(jsonOutput, expectedJson);
    });

    test('Should return an empty list when "moteis" is null', () {
      final jsonWithNullMotels = {
        "sucesso": true,
        "data": {
          "pagina": 1,
          "totalMoteis": 10,
          "totalSuites": 50,
          "maxPaginas": 5.0,
          "raio": 20,
          "moteis": null
        }
      };

      final motelSearchResult =
          MotelSearchResultModel.fromJson(jsonWithNullMotels);

      expect(motelSearchResult.motels, isA<List<MotelModel>>());
      expect(motelSearchResult.motels.isEmpty, true);
    });
  });
}
