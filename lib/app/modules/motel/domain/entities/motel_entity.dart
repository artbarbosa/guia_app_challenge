import 'package:equatable/equatable.dart';

import 'suite_entity.dart';

class MotelEntity extends Equatable {
  final String name;
  final String logo;
  final String neighborhood;
  final double distance;
  final double rating;
  final List<SuiteEntity> suites;

  const MotelEntity({
    required this.name,
    required this.logo,
    required this.neighborhood,
    required this.distance,
    required this.rating,
    required this.suites,
  });

  @override
  List<Object?> get props => [
        name,
        logo,
        neighborhood,
        distance,
        rating,
        suites,
      ];
}
