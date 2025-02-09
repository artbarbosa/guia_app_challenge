import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/shared/consts/app_colors.dart';
import '../../../../../core/shared/states/base_page_state.dart';
import '../../../domain/entities/motel_search_result_entity.dart';
import '../../../infra/model/motel_model.dart';
import '../../../infra/model/suite_model.dart';
import '../../bloc/get_motels_bloc.dart';
import '../widgets/app_bar/custom_app_bar.dart';
import '../widgets/app_bar/location_selector.dart';
import '../widgets/map_button.dart';
import '../widgets/motel_card/motel_card.dart';

class MotelListPage extends StatefulWidget {
  const MotelListPage({super.key});

  @override
  State<MotelListPage> createState() => _MotelListPageState();
}

class _MotelListPageState extends State<MotelListPage> {
  late IGetMotelsListBloc getMotelsListBloc;

  @override
  void initState() {
    super.initState();
    getMotelsListBloc = Modular.get<IGetMotelsListBloc>();
    getMotelsListBloc.getMotelsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomAppBar(
                    onAnotherDayTap: () {},
                    onMenuTap: () {},
                    onNowTap: () {},
                    onSearchTap: () {},
                  ),
                ),
                const SizedBox(height: 20),
                LocationSelector(onTap: () {}),
                const SizedBox(height: 20),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8F9FA),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      BlocBuilder<IGetMotelsListBloc, BaseState>(
                        bloc: getMotelsListBloc,
                        builder: (context, state) {
                          if (state is LoadingState) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else if (state is ErrorState) {
                            return _buildErrorWidget(context, state.message);
                          } else if (state is SuccessState) {
                            final result =
                                state.data as MotelSearchResultEntity;
                            return _buildMainContent(
                              context,
                              List<MotelModel>.from(result.motels),
                            );
                          }
                          return SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: const Center(
              child: MapButton(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, List<MotelModel> motels) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: motels.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final motel = motels[index];
        return MotelCard(
          reviews: motel.qtdAvaliacoes ?? 0,
          name: motel.name,
          distance: '${motel.distance.toStringAsFixed(1)} km',
          location: motel.neighborhood,
          rating: motel.rating,
          suits: List<SuiteModel>.from(motel.suites),
          imageUrl: motel.logo,
        );
      },
    );
  }

  Widget _buildErrorWidget(BuildContext context, String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 50, color: Colors.red),
            const SizedBox(height: 20),
            Text(
              'Erro ao carregar dados:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Tentar novamente'),
              onPressed: () => getMotelsListBloc.getMotelsList(),
            ),
          ],
        ),
      ),
    );
  }
}
