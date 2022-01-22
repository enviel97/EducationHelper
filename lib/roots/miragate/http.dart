import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';

enum Method { post, get, put }

class RestApi {
  static final RestApi _ins = RestApi._internal();
  late Dio _client;
  final Map<String, String> _header = {
    'Content-Type': 'application/json',
    'api-key': '270897'
  };

  RestApi._internal() {
    _client = Dio();
  }

  factory RestApi() => _ins;

  String _baseUrl(String path, {Map<String, dynamic>? parametter}) {
    final uri = Uri(
        scheme: 'http',
        host: '10.0.2.2',
        port: 3000,
        path: path,
        queryParameters: parametter);
    // final uri = Uri.https('educationhelper.herokuapp.com', path);
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
        options: Options(headers: _header),
        data: jsonEncode(body),
      );
      return _result(response);
    } catch (error) {
      debugPrint('[$path]: $error');
      return;
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
        options: Options(headers: _header),
        data: jsonEncode(body),
      );
      return _result(response);
    } catch (error) {
      debugPrint('[$path]: $error');
      return Future.error(error);
    }
  }

  Future delete(String path) async {
    final url = _baseUrl(path);
    try {
      final response = await _client.delete(
        url,
        options: Options(
          headers: _header,
        ),
      );
      return _result(response);
    } catch (error) {
      debugPrint('[$path]: $error');
      return Future.error(error);
    }
  }

  Future get(String path, {Map<String, dynamic>? parametter}) async {
    final url = _baseUrl(path, parametter: parametter);
    try {
      final response = await _client.get(
        url,
        options: Options(
          headers: _header,
        ),
      );
      return _result(response);
    } catch (error) {
      debugPrint('[$path]: $error');
      return Future.error(error);
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
    header.remove('Content-Type');

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
