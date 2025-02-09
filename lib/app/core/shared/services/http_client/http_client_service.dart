import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../../errors/base_error.dart';
import '../../result_wrapper/result_wrapper.dart';
import 'http_client_service_interface.dart';

class HttpClientService implements IHttpClientService {
  final Client client;
  final Duration timeoutDuration;

  HttpClientService({
    required this.client,
    this.timeoutDuration = const Duration(seconds: 30),
  });

  void logResponse(Response response, {Object? body}) {
    if (kDebugMode) {
      log("---- [LOG] REQUEST ----");
      log("URL: ${response.request?.url}");
      log("METHOD: ${response.request?.method}");
      if (body != null) {
        log("BODY: ${jsonEncode(body)}");
      }

      log("---- [LOG] RESPONSE ----");
      log("STATUS CODE: ${response.statusCode}");

      try {
        final decodedBody = response.body.isNotEmpty
            ? jsonDecode(response.body)
            : 'No Response Body';
        log("RESPONSE: $decodedBody");
      } catch (e) {
        log("Failed to decode response body: ${response.body}");
      }
    }
  }

  @override
  Future<Result<Response>> get(
    Uri url, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await client.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          ...?headers,
        },
      ).timeout(timeoutDuration);

      logResponse(response);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Success(response);
      } else {
        return Failure(BaseError(
          'Request failed with status: ${response.statusCode}',
          exception: response.body,
        ));
      }
    } on SocketException {
      return Failure(BaseError('No Internet Connection'));
    } on FormatException {
      return Failure(BaseError('Invalid JSON format in response'));
    } on HttpException {
      return Failure(BaseError('HTTP Exception occurred'));
    } on TimeoutException {
      return Failure(BaseError('Request timeout exceeded'));
    } catch (e, stackTrace) {
      return Failure(BaseError(
        'Unexpected error: $e',
        exception: e,
        stackTrace: stackTrace,
      ));
    }
  }
}
