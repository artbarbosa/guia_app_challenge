import 'dart:convert';

import 'package:app_challenge/app/modules/motel/infra/model/motel_model.dart';
import 'package:app_challenge/app/modules/motel/infra/model/suite_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const motelJson = {
    "fantasia": "Motel Le Nid",
    "logo": "https://cdn.guiademoteis.com.br/imagens/logotipos/3148-le-nid.gif",
    "bairro": "Chácara Flora - São Paulo",
    "distancia": 28.27,
    "media": 4.6,
    "suites": [
      {
        "nome": "Suíte Marselha",
        "qtd": 1,
        "exibirQtdDisponiveis": true,
        "periodos": [
          {
            "tempoFormatado": "3 horas",
            "tempo": "3",
            "valor": 88.0,
            "valorTotal": 88.0,
            "temCortesia": false,
            "desconto": null
          }
        ]
      }
    ],
    "totalSuites": 5,
    "qtdFavoritos": 10,
    "qtdAvaliacoes": 2159
  };

  group('MotelModel', () {
    test('Should create a valid MotelModel from JSON', () {
      final motelModel = MotelModel.fromJson(motelJson);

      expect(motelModel.name, "Motel Le Nid");
      expect(motelModel.logo,
          "https://cdn.guiademoteis.com.br/imagens/logotipos/3148-le-nid.gif");
      expect(motelModel.neighborhood, "Chácara Flora - São Paulo");
      expect(motelModel.distance, 28.27);
      expect(motelModel.rating, 4.6);
      expect(motelModel.totalSuites, 5);
      expect(motelModel.qtdFavoritos, 10);
      expect(motelModel.qtdAvaliacoes, 2159);
      expect(motelModel.suites, isA<List<SuiteModel>>());
      expect(motelModel.suites.length, 1);
    });

    test('Should handle missing optional fields in JSON', () {
      final jsonWithoutOptionalFields = Map<String, dynamic>.from(motelJson)
        ..remove('totalSuites')
        ..remove('qtdFavoritos')
        ..remove('qtdAvaliacoes');

      final motelModel = MotelModel.fromJson(jsonWithoutOptionalFields);

      expect(motelModel.name, "Motel Le Nid");
      expect(motelModel.totalSuites, isNull);
      expect(motelModel.qtdFavoritos, isNull);
      expect(motelModel.qtdAvaliacoes, isNull);
    });

    test('Should handle missing suites field in JSON', () {
      final jsonWithoutSuites = Map<String, dynamic>.from(motelJson)
        ..remove('suites');

      final motelModel = MotelModel.fromJson(jsonWithoutSuites);

      expect(motelModel.suites, isEmpty);
    });

    test('Should correctly serialize a MotelModel back to JSON', () {
      final motelModel = MotelModel.fromJson(motelJson);

      final jsonOutput = jsonEncode({
        "fantasia": motelModel.name,
        "logo": motelModel.logo,
        "bairro": motelModel.neighborhood,
        "distancia": motelModel.distance,
        "media": motelModel.rating,
        "suites": motelModel.suites
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
        "totalSuites": motelModel.totalSuites,
        "qtdFavoritos": motelModel.qtdFavoritos,
        "qtdAvaliacoes": motelModel.qtdAvaliacoes,
      });

      final expectedJson = jsonEncode(motelJson);
      expect(jsonOutput, expectedJson);
    });
  });
}
