import 'package:app_challenge/app/core/shared/services/http_client/http_client_service.dart';
import 'package:app_challenge/app/modules/motel/domain/entities/motel_search_result_entity.dart';
import 'package:app_challenge/app/modules/motel/domain/repositories/motel_repository.dart';
import 'package:app_challenge/app/modules/motel/domain/usecases/get_list_motel.dart';
import 'package:app_challenge/app/modules/motel/infra/datasources/motel_datasource.dart';
import 'package:mocktail/mocktail.dart';

class FakeMotelSearchResultEntity extends Fake
    implements MotelSearchResultEntity {}

class MockHttpClientService extends Mock implements HttpClientService {}

class MockGetListMotelUseCase extends Mock implements IGetListMotelUseCase {}

class MockMotelDatasource extends Mock implements IMotelDatasource {}

class MockMotelRepository extends Mock implements IMotelRepository {}
