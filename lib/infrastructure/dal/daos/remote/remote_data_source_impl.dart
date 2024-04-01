import 'package:dio/dio.dart';

import 'dio_client.dart';
import 'param.dart';
import 'upload_file_body.dart';

class RemoteDataSourceImpl {
  final DioClient _client;

  RemoteDataSourceImpl(this._client);

  Future<Response> post(String path, [RequestBody? body]) {
    return _client.post(path, body: body);
  }

  Future<Response> get(String path, [QueryParam? query]) {
    return _client.get(path, queryParameters: query);
  }

  Future<Response> put(String path, {RequestBody? body, QueryParam? query}) {
    return _client.put(path, body: body, queryParameters: query);
  }

  Future<Response> patch(String path, {RequestBody? body, QueryParam? query}) {
    return _client.patch(path, body: body, queryParameters: query);
  }

  Future<Response> del(String path, [QueryParam? query]) {
    return _client.delete(path, queryParameters: query);
  }

  Future<Response> delWithBody(String path, [RequestBody? body]) {
    return _client.delete(path, body: body);
  }

  Future<Response> bulkDelete(String path,
      {required List<dynamic> queries, required String queryKey}) {
    return _client.bulkDelete(path, queries: queries, queryKey: queryKey);
  }

  Future<Response> uploadImage(String path, UploadImageBody body) {
    return _client.uploadImage(url: path, body: body);
  }

  Future<Response> uploadFile(String path, UploadFileBody body) {
    return _client.uploadFile(url: path, body: body);
  }
}
