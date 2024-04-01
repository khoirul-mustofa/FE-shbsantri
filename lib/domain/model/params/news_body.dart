import '../../../infrastructure/dal/daos/remote/param.dart';

class NewsBody extends RequestBody {
  final String title;
  final String content;
  final int categoryId;
  final int userId;
  final String image;

  NewsBody(
      {required this.title,
      required this.content,
      required this.categoryId,
      required this.userId,
      required this.image});

  @override
  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'category_id': categoryId,
        'user_id': userId,
        'image': image
      };
}
