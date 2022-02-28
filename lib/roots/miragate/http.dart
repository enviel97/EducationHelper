import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';

enum Method { post, get, put }

class RestApi {
  static final RestApi _ins = RestApi._internal();
  final Map<String, String> _header = {'api-key': '270897'};

  late Dio _client;
  RestApi._internal();

  Options options({String contentType = Headers.jsonContentType}) => Options(
        headers: _header,
        contentType: contentType,
      );

  factory RestApi() {
    _ins._client = Dio();
    return _ins;
  }

  String _baseUrl(String path, {Map<String, dynamic>? parametter}) {
    final uri = Uri(
        scheme: 'http',
        host: '10.0.2.2',
        port: 3000,
        path: path,
        queryParameters: parametter);
    // final uri = Uri.https('educationhelper1.herokuapp.com', path, parametter);
    debugPrint(uri.toString());
    return uri.toString();
  }

  bool isSuccess(Response response) {
    final sta = response.statusCode ?? 0;
    return sta > 199 && sta < 301;
  }

  void setHeaders(String? token) {
    if (token != null && token.isNotEmpty) {
      _header['authenticate'] = token;
    }
  }

  Future post(
    String path,
    Map<String, dynamic> body,
  ) async {
    final url = _baseUrl(path);

    try {
      final response = await _client.post(
        url,
        options: options(),
        data: jsonEncode(body),
      );
      return _result(response);
    } on DioError catch (error) {
      return Future.error(error.response?.data ?? error.message);
    }
  }

  Future put(
    String path,
    Map<String, dynamic> body,
  ) async {
    final url = _baseUrl(path);
    try {
      final response = await _client.put(
        url,
        options: options(),
        data: jsonEncode(body),
      );
      return _result(response);
    } on DioError catch (error) {
      return Future.error(error.response?.data ?? error.message);
    }
  }

  Future delete(String path) async {
    final url = _baseUrl(path);
    try {
      final response = await _client.delete(
        url,
        options: options(),
      );
      return _result(response);
    } on DioError catch (error) {
      return Future.error(error.response?.data ?? error.message);
    }
  }

  Future get(String path, {Map<String, dynamic>? parametter}) async {
    final url = _baseUrl(path, parametter: parametter);
    try {
      final response = await _client.get(
        url,
        options: options(),
      );
      return _result(response);
    } on DioError catch (error) {
      return Future.error(error.response?.data ?? error.message);
    }
  }

  Future upload(
    String path,
    Map<String, dynamic>? body,
    Map<String, File>? files,
  ) async {
    final url = _baseUrl(path);

    final Map<String, String> header = {};
    header.addAll(_header);

    final Map<String, dynamic> data = {};

    if (body != null) {
      body.forEach((key, value) => data[key] = value);
    }
    if (files != null) {
      files.forEach(
        (key, value) {
          final filename = value.path.split('/').last;
          final type = lookupMimeType(filename)?.split('/');
          data[key] = MultipartFile.fromBytes(
            value.readAsBytesSync(),
            filename: filename,
            contentType: type == null
                ? MediaType('application', 'octet-stream')
                : MediaType(type[0], type[1]),
          );
        },
      );
    }
    final formData = FormData.fromMap(data);
    try {
      final response = await _client.post(
        url,
        options: Options(headers: header),
        data: formData,
      );
      return _result(response);
    } on DioError catch (error) {
      return Future.error(error.response?.data ?? error.message);
    }
  }

  Future _result(Response response) {
    if (isSuccess(response)) {
      return Future.value(response.data);
    }
    return Future.error(response.data);
  }
}
