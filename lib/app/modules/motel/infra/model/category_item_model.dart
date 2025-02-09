import '../../domain/entities/category_item_entity.dart';

class CategoryItemModel extends CategoryItemEntity {
  const CategoryItemModel({required super.name, required super.icon});

  factory CategoryItemModel.fromJson(Map<String, dynamic> json) {
    return CategoryItemModel(
      name: json['nome'],
      icon: json['icone'],
    );
  }
}
