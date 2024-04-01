import 'package:fpdart/fpdart.dart';
import 'package:santrihub/domain/core/error/failure/remote_failure.dart';
import 'package:santrihub/domain/model/news.dart';
import 'package:santrihub/domain/model/params/news_body.dart';

import '../../../infrastructure/dal/daos/remote/upload_file_body.dart';
import '../../model/params/detail_news.dart';
import '../../model/params/news_params.dart';

abstract class NewsRepository {
  Future<Either<RemoteFailure, List<NewsModel>>> getNews(NewsParams param);
  Future<Either<RemoteFailure, NewsModel>> getNewsById(DetailNewsParam param);
  Future<Either<RemoteFailure, bool>> createNews(NewsBody body);
  Future<Either<RemoteFailure, bool>> deleteNews(DetailNewsParam param);
  Future<Either<RemoteFailure, String>> uploadImage(UploadImageBody body);
}
