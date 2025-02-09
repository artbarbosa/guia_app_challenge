import 'package:equatable/equatable.dart';

import 'period_entity.dart';

class SuiteEntity extends Equatable {
  final String name;
  final int quantity;
  final bool showAvailableQuantity;
  final List<PeriodEntity> periods;

  const SuiteEntity({
    required this.name,
    required this.quantity,
    required this.showAvailableQuantity,
    required this.periods,
  });

  @override
  List<Object?> get props => [
        name,
        quantity,
        showAvailableQuantity,
        periods,
      ];
}
