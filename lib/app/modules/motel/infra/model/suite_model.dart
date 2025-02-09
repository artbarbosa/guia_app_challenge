import '../../domain/entities/suite_entity.dart';
import 'category_item_model.dart';
import 'period_model.dart';

class SuiteModel extends SuiteEntity {
  final List<String> photos;
  final List<String> items;
  final List<CategoryItemModel> categoryItems;

  const SuiteModel({
    required super.name,
    required super.quantity,
    required this.photos,
    required super.periods,
    required super.showAvailableQuantity,
    required this.items,
    required this.categoryItems,
  });

  factory SuiteModel.fromJson(Map<String, dynamic> json) {
    return SuiteModel(
      name: json['nome'],
      quantity: json['qtd'],
      periods: (json['periodos'] as List?)
              ?.map((period) => PeriodModel.fromJson(period))
              .toList() ??
          [],
      showAvailableQuantity: json['exibirQtdDisponiveis'],
      photos: json['fotos'] != null ? List<String>.from(json['fotos']) : [],
      items: json['itens'] != null
          ? (json['itens'] as List)
              .map((item) => item['nome'] as String)
              .toList()
          : [],
      categoryItems: json['categoriaItens'] != null
          ? (json['categoriaItens'] as List)
              .map((category) => CategoryItemModel.fromJson(category))
              .toList()
          : [],
    );
  }
}
