import 'dart:convert';
import 'dart:io';

import 'package:app_challenge/app/core/shared/result_wrapper/result_wrapper.dart';
import 'package:app_challenge/app/modules/motel/external/datasources/motel_datasource.dart';
import 'package:app_challenge/app/modules/motel/infra/model/motel_search_result_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../motel_mock.dart';

void main() {
  late MotelDatasource datasource;
  late MockHttpClientService mockHttpClient;

  const baseUrl = 'https://api.example.com';

  setUp(() {
    mockHttpClient = MockHttpClientService();
    datasource = MotelDatasource(client: mockHttpClient);
    registerFallbackValue(Uri.parse('$baseUrl/test'));
  });

  group('MotelDatasource - getListMotel', () {
    test('Should return Success when API returns 200 with valid JSON',
        () async {
      final responseJson = jsonEncode({
        "sucesso": true,
        "data": {
          "pagina": 1,
          "totalMoteis": 10,
          "totalSuites": 50,
          "maxPaginas": 5.0,
          "raio": 20,
          "moteis": []
        }
      });
      final response = http.Response(responseJson, 200);

      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => Success(response));

      final result = await datasource.getListMotel();

      expect(result, isA<Success<MotelSearchResultModel>>());
      verify(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .called(1);
    });

    test('Should return Failure when API returns a non-200 status code',
        () async {
      final responseJson = jsonEncode({'error': 'Unauthorized'});
      final response = http.Response(responseJson, 401);

      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => Success(response));

      final result = await datasource.getListMotel();

      expect(result, isA<Failure<MotelSearchResultModel>>());
      expect((result as Failure).error.message, 'Failed to fetch motels');
      verify(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .called(1);
    });

    test('Should return Failure when response body is not valid JSON',
        () async {
      final response = http.Response('Invalid JSON', 200);

      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => Success(response));

      final result = await datasource.getListMotel();

      expect(result, isA<Failure<MotelSearchResultModel>>());
      expect((result as Failure).error.message, 'Invalid JSON format');
      verify(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .called(1);
    });

    test('Should return Failure when there is no internet connection',
        () async {
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .thenThrow(const SocketException('No Internet Connection'));

      final result = await datasource.getListMotel();

      expect(result, isA<Failure<MotelSearchResultModel>>());
      expect(
          (result as Failure).error.message, 'Unexpected error in datasource');
      verify(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .called(1);
    });

    test('Should return Failure when an unexpected error occurs', () async {
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .thenThrow(Exception('Unexpected error'));

      final result = await datasource.getListMotel();

      expect(result, isA<Failure<MotelSearchResultModel>>());
      expect(
          (result as Failure).error.message, 'Unexpected error in datasource');
      verify(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .called(1);
    });
  });
}
