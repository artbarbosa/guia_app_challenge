import '../../domain/entities/motel_search_result_entity.dart';
import 'motel_model.dart';
import 'pagination_model.dart';

class MotelSearchResultModel extends MotelSearchResultEntity {
  final bool success;
  final PaginationModel? pagination;

  MotelSearchResultModel({
    required this.success,
    required this.pagination,
    required List<MotelModel> motels,
  }) : super(
          page: pagination?.page,
          totalMotels: pagination?.totalMotels,
          totalSuites: pagination?.totalSuites,
          maxPages: pagination?.maxPages,
          radius: pagination?.radius,
          motels: motels,
        );

  factory MotelSearchResultModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return MotelSearchResultModel(
      success: json['sucesso'] ?? false,
      pagination: data != null ? PaginationModel.fromJson(data) : null,
      motels: data['moteis'] != null
          ? (data['moteis'] as List)
              .map((motel) => MotelModel.fromJson(motel))
              .toList()
          : [],
    );
  }
}
