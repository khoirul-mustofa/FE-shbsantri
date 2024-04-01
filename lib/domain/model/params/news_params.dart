import '../../../infrastructure/dal/daos/remote/param.dart';

class NewsParams extends ToJson {
  final int page;
  final int limit;
  final int? categoryId;
  final int? userId;
  final String? search;

  NewsParams(
      {required this.page,
      required this.limit,
      this.categoryId,
      this.userId,
      this.search});

  @override
  Map<String, dynamic> toJson() => {
        'page': page,
        'limit': limit,
        'categoryId': categoryId,
        'userId': userId,
        'search': search
      }..removeWhere((key, value) => value == null || value == '');
}
