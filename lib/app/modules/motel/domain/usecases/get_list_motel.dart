import '../../../../core/shared/result_wrapper/result_wrapper.dart';
import '../entities/motel_search_result_entity.dart';
import '../repositories/motel_repository.dart';

abstract class IGetListMotelUseCase {
  Future<Result<MotelSearchResultEntity>> call();
}

class GetListMotelUseCase implements IGetListMotelUseCase {
  final IMotelRepository repository;

  GetListMotelUseCase({required this.repository});

  @override
  Future<Result<MotelSearchResultEntity>> call() async {
    return await repository.getListMotel();
  }
}
