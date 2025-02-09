import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/states/base_page_state.dart';
import '../../domain/usecases/get_list_motel.dart';

abstract class IGetMotelsListBloc extends Cubit<BaseState> {
  IGetMotelsListBloc() : super(const EmptyState());
  Future<void> getMotelsList();
}

class GetMotelsListBloc extends IGetMotelsListBloc {
  final IGetListMotelUseCase useCase;
  GetMotelsListBloc(this.useCase);

  @override
  Future<void> getMotelsList() async {
    emit(LoadingState());
    try {
      final result = await useCase.call();

      result.when(
        success: (searchResult) {
          emit(SuccessState(searchResult));
        },
        failure: (error) {
          emit(ErrorState(error.message));
        },
      );
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
