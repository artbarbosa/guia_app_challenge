import 'package:app_challenge/app/core/shared/states/base_page_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BaseState Tests', () {
    test('LoadingState should be equal to another instance', () {
      const state1 = LoadingState();
      const state2 = LoadingState();

      expect(state1, equals(state2));
      expect(state1.props, isEmpty);
    });

    test('SuccessState should hold data and be comparable', () {
      const successState1 = SuccessState<int>(42);
      const successState2 = SuccessState<int>(42);
      const successState3 = SuccessState<int>(100);

      expect(successState1, equals(successState2));
      expect(successState1, isNot(equals(successState3)));
      expect(successState1.props, contains(42));
    });

    test('ErrorState should hold an error message and be comparable', () {
      const errorState1 = ErrorState('Error occurred');
      const errorState2 = ErrorState('Error occurred');
      const errorState3 = ErrorState('Another error');

      expect(errorState1, equals(errorState2));
      expect(errorState1, isNot(equals(errorState3)));
      expect(errorState1.props, contains('Error occurred'));
    });

    test('TypedErrorState should hold an error object and be comparable', () {
      const typedError1 = TypedErrorState<String>('Error occurred', 'E001');
      const typedError2 = TypedErrorState<String>('Error occurred', 'E001');
      const typedError3 = TypedErrorState<String>('Error occurred', 'E002');

      expect(typedError1, equals(typedError2));
      expect(typedError1, isNot(equals(typedError3)));
      expect(typedError1.props, containsAll(['Error occurred', 'E001']));
    });

    test('EmptyState should be equal to another instance', () {
      const emptyState1 = EmptyState();
      const emptyState2 = EmptyState();
      const emptyStateWithMessage = EmptyState(message: "No Data");

      expect(emptyState1, equals(emptyState2));
      expect(emptyState1.props, isEmpty);
      expect(emptyStateWithMessage.props, isEmpty);
    });

    test('ChangeState should hold data and be comparable', () {
      const changeState1 = ChangeState<int>(10);
      const changeState2 = ChangeState<int>(10);
      const changeState3 = ChangeState<int>(20);

      expect(changeState1, equals(changeState2));
      expect(changeState1, isNot(equals(changeState3)));
      expect(changeState1.props, contains(10));
    });
  });
}
