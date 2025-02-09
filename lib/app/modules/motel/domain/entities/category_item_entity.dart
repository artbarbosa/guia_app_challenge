import 'package:equatable/equatable.dart';

class CategoryItemEntity extends Equatable {
  final String? name;
  final String? icon;

  const CategoryItemEntity({
    required this.name,
    required this.icon,
  });

  @override
  List<Object?> get props => [name, icon];
}
