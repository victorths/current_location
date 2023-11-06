import 'dart:convert';

import '../../commons.dart';

class DioDatasource implements RemoteDatasource {
  final Dio _dio = Dio();
  final List<Interceptor> _interceptor;

  DioDatasource([this._interceptor = const []]) {
    _dio.interceptors.addAll(_interceptor);
    _dio.options.baseUrl = 'http://ip-api.com';
  }

  @override
  Future delete({
    required String url,
    Map<String, dynamic> query = const {},
    Map<String, String> headers = const {},
  }) async {
    try {
      final response = await _dio.delete(
        url,
        queryParameters: query,
        options: Options(headers: headers),
      );
      return response.data;
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future get({
    required String url,
    Map<String, dynamic> query = const {},
    Map<String, String> headers = const {},
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: query,
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future patch({
    required String url,
    Map body = const {},
    Map<String, dynamic> query = const {},
    Map<String, String> headers = const {},
  }) async {
    try {
      final response = await _dio.patch(
        url,
        queryParameters: query,
        data: json.encode(body),
        options: Options(headers: headers),
      );
      return response.data;
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future post({
    required String url,
    Map body = const {},
    Map<String, dynamic> query = const {},
    Map<String, String> headers = const {},
  }) async {
    try {
      final response = await _dio.post(
        url,
        queryParameters: query,
        data: json.encode(body),
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future put({
    required String url,
    required Map body,
    Map<String, dynamic> query = const {},
    Map<String, String> headers = const {},
  }) async {
    try {
      final response = await _dio.put(
        url,
        queryParameters: query,
        data: json.encode(body),
        options: Options(headers: headers),
      );
      return response.data;
    } on Exception catch (_) {
      rethrow;
    }
  }
}
