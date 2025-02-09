import 'package:equatable/equatable.dart';

import 'motel_entity.dart';

class MotelSearchResultEntity extends Equatable {
  final int? page;
  final int? totalMotels;
  final int? totalSuites;
  final double? maxPages;
  final int? radius;
  final List<MotelEntity> motels;

  const MotelSearchResultEntity({
    required this.page,
    required this.totalMotels,
    required this.totalSuites,
    required this.maxPages,
    required this.radius,
    required this.motels,
  });

  @override
  List<Object?> get props =>
      [page, totalMotels, totalSuites, maxPages, radius, motels];
}
