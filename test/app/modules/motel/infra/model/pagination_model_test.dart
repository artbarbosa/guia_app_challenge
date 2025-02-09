import 'dart:convert';

import 'package:app_challenge/app/modules/motel/infra/model/pagination_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const paginationJson = {
    "pagina": 1,
    "qtdPorPagina": 10,
    "totalSuites": 50,
    "totalMoteis": 10,
    "raio": 20,
    "maxPaginas": 5.0
  };

  group('PaginationModel', () {
    test('Should create a valid PaginationModel from JSON', () {
      final paginationModel = PaginationModel.fromJson(paginationJson);

      expect(paginationModel.page, 1);
      expect(paginationModel.qtdPerPage, 10);
      expect(paginationModel.totalSuites, 50);
      expect(paginationModel.totalMotels, 10);
      expect(paginationModel.radius, 20);
      expect(paginationModel.maxPages, 5);
    });

    test('Should handle missing optional fields in JSON', () {
      final jsonWithoutOptionalFields = {
        "pagina": 1,
        "qtdPorPagina": 10,
        "totalSuites": 50,
        "totalMoteis": 10,
      };

      final paginationModel =
          PaginationModel.fromJson(jsonWithoutOptionalFields);

      expect(paginationModel.page, 1);
      expect(paginationModel.qtdPerPage, 10);
      expect(paginationModel.totalSuites, 50);
      expect(paginationModel.totalMotels, 10);
      expect(paginationModel.radius, isNull);
      expect(paginationModel.maxPages, isNull);
    });

    test('Should correctly serialize a PaginationModel back to JSON', () {
      final paginationModel = PaginationModel.fromJson(paginationJson);

      final jsonOutput = jsonEncode({
        "pagina": paginationModel.page,
        "qtdPorPagina": paginationModel.qtdPerPage,
        "totalSuites": paginationModel.totalSuites,
        "totalMoteis": paginationModel.totalMotels,
        "raio": paginationModel.radius,
        "maxPaginas": paginationModel.maxPages,
      });

      final expectedJson = jsonEncode(paginationJson);
      expect(jsonOutput, expectedJson);
    });

    test('Should return null for missing fields in JSON', () {
      final jsonWithNullValues = {
        "pagina": null,
        "qtdPorPagina": null,
        "totalSuites": null,
        "totalMoteis": null,
        "raio": null,
        "maxPaginas": null
      };

      final paginationModel = PaginationModel.fromJson(jsonWithNullValues);

      expect(paginationModel.page, isNull);
      expect(paginationModel.qtdPerPage, isNull);
      expect(paginationModel.totalSuites, isNull);
      expect(paginationModel.totalMotels, isNull);
      expect(paginationModel.radius, isNull);
      expect(paginationModel.maxPages, isNull);
    });
  });
}
