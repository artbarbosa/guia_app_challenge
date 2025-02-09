import '../../../../core/shared/result_wrapper/result_wrapper.dart';
import '../entities/motel_search_result_entity.dart';

abstract class IMotelRepository {
  Future<Result<MotelSearchResultEntity>> getListMotel();
}
