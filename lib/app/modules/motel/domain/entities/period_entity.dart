import 'package:equatable/equatable.dart';

class PeriodEntity extends Equatable {
  final String formattedTime;
  final String time;
  final double price;
  final double totalPrice;
  final bool hasCourtesy;
  final double? discount;

  const PeriodEntity({
    required this.formattedTime,
    required this.time,
    required this.price,
    required this.totalPrice,
    required this.hasCourtesy,
    this.discount,
  });

  @override
  List<Object?> get props => [
        formattedTime,
        time,
        price,
        totalPrice,
        hasCourtesy,
        discount,
      ];
}
