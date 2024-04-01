import 'package:fpdart/fpdart.dart';
import 'package:santrihub/domain/model/category.dart';
import 'package:santrihub/domain/model/params/category.dart';
import 'package:santrihub/infrastructure/dal/daos/remote/request_remote.dart';

import '../../../../domain/core/error/error_imports.dart';
import '../../../../domain/core/interfaces/category_repository.dart';
import '../../endpoint/endpoint.dart';
import '../remote/dio_client.dart';
import '../remote/remote_data_source_impl.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final RemoteDataSourceImpl _remote;
  CategoryRepositoryImpl() : _remote = RemoteDataSourceImpl(DioClient());

  @override
  Future<Either<RemoteFailure, List<CategoryModel>>> getCategories() async {
    try {
      final response = await hitAPI(() => _remote.get(Endpoints.category));
      List<CategoryModel> category = List.from(response['data']['categories'])
          .map((e) => CategoryModel.fromJson(e))
          .toList();
      return Right(category);
    } on ServerException catch (e) {
      return Left(RemoteFailure(e));
    }
  }

  @override
  Future<Either<RemoteFailure, bool>> createCategories(
      CategoryBody body) async {
    try {
      final response =
          await hitAPI(() => _remote.post(Endpoints.category, body));
      bool isSuccessed = response['code'] == 201;
      return Right(isSuccessed);
    } on ServerException catch (e) {
      return Left(RemoteFailure(e));
    }
  }

  @override
  Future<Either<RemoteFailure, bool>> deleteCategories(int id) async {
    try {
      final response =
          await hitAPI(() => _remote.del('${Endpoints.category}/$id'));
      bool isSuccessed = response['code'] == 200;
      return Right(isSuccessed);
    } on ServerException catch (e) {
      return Left(RemoteFailure(e));
    }
  }
}
