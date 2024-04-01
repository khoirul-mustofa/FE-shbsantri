import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:santrihub/domain/model/news.dart';
import 'package:santrihub/domain/model/params/news_params.dart';

import '../../../../domain/core/error/error_imports.dart';
import '../../../../domain/core/interfaces/news_repository.dart';
import '../../../../domain/model/params/detail_news.dart';
import '../../../../domain/model/params/news_body.dart';
import '../../endpoint/endpoint.dart';
import '../remote/dio_client.dart';
import '../remote/remote_data_source_impl.dart';
import '../remote/request_remote.dart';
import '../remote/upload_file_body.dart';

class NewsRepositoryImpl extends NewsRepository {
  final RemoteDataSourceImpl _remote;
  NewsRepositoryImpl() : _remote = RemoteDataSourceImpl(DioClient());

  @override
  Future<Either<RemoteFailure, List<NewsModel>>> getNews(
      NewsParams param) async {
    try {
      final response = await hitAPI(() => _remote.get(Endpoints.news, param));
      List<NewsModel> category = List.from(response['data'])
          .map((e) => NewsModel.fromJson(e))
          .toList();
      return Right(category);
    } on ServerException catch (e) {
      return Left(RemoteFailure(e));
    }
  }

  @override
  Future<Either<RemoteFailure, NewsModel>> getNewsById(
      DetailNewsParam param) async {
    try {
      final response =
          await hitAPI(() => _remote.get('${Endpoints.news}/${param.id}'));
      return Right(NewsModel.fromJson(response['data']));
    } on ServerException catch (e) {
      return Left(RemoteFailure(e));
    }
  }

  @override
  Future<Either<RemoteFailure, bool>> createNews(NewsBody body) async {
    log(body.toJson().toString());
    try {
      final response = await hitAPI(() => _remote.post(Endpoints.news, body));
      bool isSuccessed = response['code'] == 201;
      return Right(isSuccessed);
    } on ServerException catch (e) {
      return Left(RemoteFailure(e));
    }
  }

  @override
  Future<Either<RemoteFailure, bool>> deleteNews(DetailNewsParam param) async {
    try {
      final response = await hitAPI(() => _remote.del(
            '${Endpoints.news}/${param.id}',
          ));
      bool isSuccessed = response['code'] == 200;
      return Right(isSuccessed);
    } on ServerException catch (e) {
      return Left(RemoteFailure(e));
    }
  }

  @override
  Future<Either<RemoteFailure, String>> uploadImage(
      UploadImageBody body) async {
    try {
      final response =
          await hitAPI(() => _remote.uploadImage(Endpoints.uploadImage, body));
      String urlImage = response['data']['image_url'];
      log(response['data']);
      return Right(urlImage);
    } on ServerException catch (e) {
      return Left(RemoteFailure(e));
    }
  }
}
