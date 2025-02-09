import 'package:app_challenge/app/core/shared/result_wrapper/result_wrapper.dart';
import 'package:app_challenge/app/modules/motel/domain/entities/motel_search_result_entity.dart';
import 'package:app_challenge/app/modules/motel/domain/errors/motel_errors.dart';
import 'package:app_challenge/app/modules/motel/infra/respositories/motel_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../motel_mock.dart';

void main() {
  late MotelRepository repository;
  late MockMotelDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockMotelDatasource();
    repository = MotelRepository(datasource: mockDatasource);
  });

  final MotelSearchResultEntity mockSearchResult = MotelSearchResultEntity(
    page: 1,
    totalMotels: 10,
    totalSuites: 50,
    maxPages: 5,
    radius: 20,
    motels: [],
  );

  group('MotelRepository - getListMotel', () {
    test('Should return Success when datasource returns data correctly',
        () async {
      when(() => mockDatasource.getListMotel())
          .thenAnswer((_) async => Success(mockSearchResult));

      final result = await repository.getListMotel();

      expect(result, isA<Success<MotelSearchResultEntity>>());
      expect((result as Success).value, mockSearchResult);
      verify(() => mockDatasource.getListMotel()).called(1);
    });

    test('Should return Failure when datasource returns an error', () async {
      final error = MotelRepositoryError(
        message: "Failed to fetch motels",
        exception: Exception("Datasource error"),
      );

      when(() => mockDatasource.getListMotel())
          .thenAnswer((_) async => Failure(error));

      final result = await repository.getListMotel();

      expect(result, isA<Failure<MotelSearchResultEntity>>());
      expect((result as Failure).error.message, "Failed to fetch motels");
      verify(() => mockDatasource.getListMotel()).called(1);
    });

    test('Should return Failure when an unexpected error occurs', () async {
      when(() => mockDatasource.getListMotel())
          .thenThrow(Exception("Unexpected error"));

      final result = await repository.getListMotel();

      expect(result, isA<Failure<MotelSearchResultEntity>>());
      expect((result as Failure).error.message,
          "Unexpected error in MotelRepository");
      verify(() => mockDatasource.getListMotel()).called(1);
    });
  });
}
