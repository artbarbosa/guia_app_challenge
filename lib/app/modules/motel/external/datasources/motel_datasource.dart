import 'dart:convert';

import 'package:app_challenge/app/core/shared/env/env.dart';

import '../../../../core/shared/errors/base_error.dart';
import '../../../../core/shared/result_wrapper/result_wrapper.dart';
import '../../../../core/shared/services/http_client/http_client_service_interface.dart';
import '../../infra/datasources/motel_datasource.dart';
import '../../infra/model/motel_search_result_model.dart';

class MotelDatasource implements IMotelDatasource {
  final IHttpClientService client;

  MotelDatasource({required this.client});

  @override
  Future<Result<MotelSearchResultModel>> getListMotel() async {
    try {
      final uri = Uri.parse(Env.to?.baseUrlAPI ?? "");

      final result = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      return result.when(
        success: (response) {
          if (response.statusCode < 200 || response.statusCode >= 300) {
            return Failure(BaseError(
              'Failed to fetch motels',
              exception: response.body,
            ));
          }

          try {
            final jsonData = jsonDecode(utf8.decode(response.bodyBytes))
                as Map<String, dynamic>;
            return Success(MotelSearchResultModel.fromJson(jsonData));
          } catch (e) {
            return Failure(BaseError(
              'Invalid JSON format',
              exception: e,
            ));
          }
        },
        failure: (error) {
          return Failure(BaseError(
            'Failed to fetch motels',
            exception: error,
          ));
        },
      );
    } catch (e, stackTrace) {
      return Failure(BaseError(
        'Unexpected error in datasource',
        exception: e,
        stackTrace: stackTrace,
      ));
    }
  }
}
