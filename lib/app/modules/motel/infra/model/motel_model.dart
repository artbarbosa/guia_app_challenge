import '../../domain/entities/motel_entity.dart';
import 'suite_model.dart';

class MotelModel extends MotelEntity {
  final int? totalSuites;
  final int? qtdFavoritos;
  final int? qtdAvaliacoes;

  const MotelModel({
    required super.name,
    required super.logo,
    required super.neighborhood,
    required super.distance,
    required super.rating,
    required super.suites,
    this.totalSuites,
    this.qtdFavoritos,
    this.qtdAvaliacoes,
  });

  factory MotelModel.fromJson(Map<String, dynamic> json) {
    return MotelModel(
      name: json['fantasia'] ?? '',
      logo: json['logo'] ?? '',
      neighborhood: json['bairro'] ?? '',
      distance: (json['distancia'] as num?)?.toDouble() ?? 0.0,
      rating: (json['media'] as num?)?.toDouble() ?? 0.0,
      suites: (json['suites'] as List<dynamic>? ?? [])
          .map((suite) => SuiteModel.fromJson(suite as Map<String, dynamic>))
          .toList(),
      totalSuites: json['totalSuites'] as int?,
      qtdFavoritos: json['qtdFavoritos'] as int?,
      qtdAvaliacoes: json['qtdAvaliacoes'] as int?,
    );
  }
}
