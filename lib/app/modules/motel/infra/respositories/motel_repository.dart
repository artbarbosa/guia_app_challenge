import '../../../../core/shared/result_wrapper/result_wrapper.dart';
import '../../domain/entities/motel_search_result_entity.dart';
import '../../domain/errors/motel_errors.dart';
import '../../domain/repositories/motel_repository.dart';
import '../datasources/motel_datasource.dart';

class MotelRepository implements IMotelRepository {
  final IMotelDatasource datasource;

  MotelRepository({required this.datasource});

  @override
  Future<Result<MotelSearchResultEntity>> getListMotel() async {
    try {
      final result = await datasource.getListMotel();

      return result.when(
        success: (searchResult) {
          return Success(searchResult);
        },
        failure: (error) {
          return Failure(MotelRepositoryError(
            message: "Failed to fetch motels",
            exception: error,
          ));
        },
      );
    } catch (e, stackTrace) {
      return Failure(MotelRepositoryError(
        message: "Unexpected error in MotelRepository",
        exception: e,
        stackTrace: stackTrace,
      ));
    }
  }
}
