import 'package:app_challenge/app/modules/motel/domain/entities/motel_search_result_entity.dart';

import '../../../../core/shared/result_wrapper/result_wrapper.dart';

abstract class IMotelDatasource {
  Future<Result<MotelSearchResultEntity>> getListMotel();
}
