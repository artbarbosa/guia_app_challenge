import 'package:app_challenge/app/core/shared/errors/base_error.dart';
import 'package:app_challenge/app/core/shared/result_wrapper/result_wrapper.dart';
import 'package:app_challenge/app/modules/motel/domain/entities/motel_search_result_entity.dart';
import 'package:app_challenge/app/modules/motel/domain/usecases/get_list_motel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../motel_mock.dart';

void main() {
  late IGetListMotelUseCase useCase;
  late MockMotelRepository mockRepository;

  setUp(() {
    mockRepository = MockMotelRepository();
    useCase = GetListMotelUseCase(repository: mockRepository);

    registerFallbackValue(FakeMotelSearchResultEntity());
  });

  const mockSearchResult = MotelSearchResultEntity(
    page: 1,
    totalMotels: 1,
    totalSuites: 0,
    maxPages: 1,
    radius: 0,
    motels: [],
  );

  group('GetListMotelUseCase', () {
    test('Should return a MotelSearchResultEntity when repository succeeds',
        () async {
      when(() => mockRepository.getListMotel())
          .thenAnswer((_) async => const Success(mockSearchResult));

      final result = await useCase.call();

      expect(result, isA<Success<MotelSearchResultEntity>>());
      expect(result.when(success: (data) => data, failure: (_) => null),
          mockSearchResult);
      verify(() => mockRepository.getListMotel()).called(1);
    });

    test('Should return a Failure when repository fails', () async {
      final error = BaseError('Failed to fetch motels');
      when(() => mockRepository.getListMotel())
          .thenAnswer((_) async => Failure(error));

      final result = await useCase.call();

      expect(result, isA<Failure<MotelSearchResultEntity>>());
      expect(result.when(success: (_) => '', failure: (err) => err.message),
          'Failed to fetch motels');
      verify(() => mockRepository.getListMotel()).called(1);
    });
  });
}
