import 'package:dio/dio.dart';
import '../../../../domain/core/error/error_imports.dart';
import 'typedef.dart';

Future<JSON> hitAPI(Future<Response> Function() computation) async {
  try {
    final response = await computation();
    final code = response.statusCode;
    if (code == 200 || code == 201) {
      return response.data;
    } else {
      throw ServerException(response);
    }
  } on DioException catch (e) {
    throw ServerException(e);
  }
}
