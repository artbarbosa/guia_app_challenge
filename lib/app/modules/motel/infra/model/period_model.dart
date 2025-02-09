import '../../domain/entities/period_entity.dart';

class PeriodModel extends PeriodEntity {
  const PeriodModel({
    required super.formattedTime,
    required super.time,
    required super.price,
    required super.totalPrice,
    required super.hasCourtesy,
    super.discount,
  });

  factory PeriodModel.fromJson(Map<String, dynamic> json) {
    return PeriodModel(
      formattedTime: json['tempoFormatado'],
      time: json['tempo'],
      price: (json['valor'] as num).toDouble(),
      totalPrice: (json['valorTotal'] as num).toDouble(),
      hasCourtesy: json['temCortesia'],
      discount: json['desconto'] != null
          ? (json['desconto']['desconto'] as num).toDouble()
          : null,
    );
  }
}
