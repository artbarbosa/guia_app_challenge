import 'dart:convert';
import 'dart:io';

import 'package:app_challenge/app/core/shared/result_wrapper/result_wrapper.dart';
import 'package:app_challenge/app/core/shared/services/http_client/http_client_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../core_mock.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late HttpClientService httpClientService;

  const baseUrl = 'https://api.example.com';

  setUp(() {
    mockHttpClient = MockHttpClient();
    httpClientService = HttpClientService(client: mockHttpClient);

    registerFallbackValue(Uri.parse('$baseUrl/test'));
  });

  group('HttpClientService - GET method', () {
    test('Should return Success when API returns 200 with valid JSON',
        () async {
      final responseJson = jsonEncode({'message': 'Success'});
      final response = http.Response(responseJson, 200);

      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => response);

      final result = await httpClientService.get(Uri.parse('$baseUrl/test'));

      expect(result, isA<Success<http.Response>>());
      expect((result as Success).value.body, responseJson);
      verify(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .called(1);
    });

    test('Should return Failure when API returns a non-200 status code',
        () async {
      final responseJson = jsonEncode({'error': 'Unauthorized'});
      final response = http.Response(responseJson, 401);

      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => response);

      final result = await httpClientService.get(Uri.parse('$baseUrl/test'));

      expect(result, isA<Failure<http.Response>>());
      expect(
          (result as Failure).error.message, 'Request failed with status: 401');
      verify(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .called(1);
    });

    test('Should return Failure when there is no internet connection',
        () async {
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .thenThrow(const SocketException('No Internet Connection'));

      final result = await httpClientService.get(Uri.parse('$baseUrl/test'));

      expect(result, isA<Failure<http.Response>>());
      expect((result as Failure).error.message, 'No Internet Connection');
      verify(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .called(1);
    });

    test('Should return Failure when an unexpected error occurs', () async {
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .thenThrow(Exception('Unexpected error'));

      final result = await httpClientService.get(Uri.parse('$baseUrl/test'));

      expect(result, isA<Failure<http.Response>>());
      expect((result as Failure).error.message, contains('Unexpected error'));
      verify(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .called(1);
    });
  });
}
