import 'package:fpdart/fpdart.dart';
import 'package:santrihub/domain/core/error/failure/remote_failure.dart';
import 'package:santrihub/domain/model/category.dart';

import '../../model/params/category.dart';

abstract class CategoryRepository {
  Future<Either<RemoteFailure, List<CategoryModel>>> getCategories();
  Future<Either<RemoteFailure, bool>> createCategories(CategoryBody body);
  Future<Either<RemoteFailure, bool>> deleteCategories(int id);
}
