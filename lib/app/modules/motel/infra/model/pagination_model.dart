class PaginationModel {
  final int? page;
  final int? qtdPerPage;
  final int? totalSuites;
  final int? totalMotels;
  final int? radius;
  final double? maxPages;

  PaginationModel({
    required this.page,
    required this.qtdPerPage,
    required this.totalSuites,
    required this.totalMotels,
    required this.radius,
    required this.maxPages,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      page: json['pagina'],
      qtdPerPage: json['qtdPorPagina'],
      totalSuites: json['totalSuites'],
      totalMotels: json['totalMoteis'],
      radius: json['raio'],
      maxPages: json['maxPaginas'],
    );
  }
}
