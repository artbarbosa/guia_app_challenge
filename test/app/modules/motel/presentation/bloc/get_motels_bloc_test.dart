import 'package:app_challenge/app/core/shared/errors/base_error.dart';
import 'package:app_challenge/app/core/shared/result_wrapper/result_wrapper.dart';
import 'package:app_challenge/app/core/shared/states/base_page_state.dart';
import 'package:app_challenge/app/modules/motel/domain/entities/motel_entity.dart';
import 'package:app_challenge/app/modules/motel/domain/entities/motel_search_result_entity.dart';
import 'package:app_challenge/app/modules/motel/presentation/bloc/get_motels_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../motel_mock.dart';

void main() {
  group('GetMotelsListBloc Tests', () {
    late MockGetListMotelUseCase mockUseCase;
    late GetMotelsListBloc getMotelsListBloc;

    setUp(() {
      mockUseCase = MockGetListMotelUseCase();
      getMotelsListBloc = GetMotelsListBloc(mockUseCase);
    });

    tearDown(() {
      getMotelsListBloc.close();
    });

    test('Initial state should be EmptyState', () {
      expect(getMotelsListBloc.state, equals(const EmptyState()));
    });

    final mockMotels = [
      const MotelEntity(
        name: 'Motel Le Nid',
        logo:
            'https://cdn.guiademoteis.com.br/imagens/logotipos/3148-le-nid.gif',
        neighborhood: 'Chácara Flora - São Paulo',
        distance: 28.27,
        rating: 4.6,
        suites: [],
      ),
    ];

    final mockSearchResult = MotelSearchResultEntity(
      page: 1,
      totalMotels: 10,
      totalSuites: 50,
      maxPages: 5,
      radius: 20,
      motels: mockMotels,
    );

    blocTest<GetMotelsListBloc, BaseState>(
      'Emits [LoadingState, SuccessState] when getMotelsList is successful',
      build: () {
        when(() => mockUseCase.call())
            .thenAnswer((_) async => Success(mockSearchResult));
        return getMotelsListBloc;
      },
      act: (bloc) => bloc.getMotelsList(),
      expect: () => [
        isA<LoadingState>(),
        isA<SuccessState>(),
      ],
    );

    blocTest<GetMotelsListBloc, BaseState>(
      'Emits [LoadingState, ErrorState] when getMotelsList fails',
      build: () {
        when(() => mockUseCase.call()).thenAnswer(
          (_) async => Failure(BaseError('Failed to fetch motels')),
        );
        return getMotelsListBloc;
      },
      act: (bloc) => bloc.getMotelsList(),
      expect: () => [
        isA<LoadingState>(),
        isA<ErrorState>(),
      ],
    );
  });
}
