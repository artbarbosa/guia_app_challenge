import 'package:flutter_modular/flutter_modular.dart';

import '../../core/core_module.dart';
import 'domain/repositories/motel_repository.dart';
import 'domain/usecases/get_list_motel.dart';
import 'external/datasources/motel_datasource.dart';
import 'infra/datasources/motel_datasource.dart';
import 'infra/respositories/motel_repository.dart';
import 'presentation/bloc/get_motels_bloc.dart';
import 'presentation/ui/pages/home_page.dart';

class MotelModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void binds(i) {
    i.addSingleton<IMotelDatasource>(() => MotelDatasource(client: i()));

    i.addSingleton<IMotelRepository>(() => MotelRepository(datasource: i()));

    i.add<IGetListMotelUseCase>(() => GetListMotelUseCase(repository: i()));

    i.add<IGetMotelsListBloc>(() => GetMotelsListBloc(i()));
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage());
  }
}
