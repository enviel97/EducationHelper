import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

enum Method { post, get, put }

class RestApi {
  static final RestApi _ins = RestApi._internal();
  late Client _client;
  Map<String, String>? _header;

  RestApi._internal() {
    _client = Client();
  }

  factory RestApi() => _ins;

  Uri _baseUrl(String path) => Uri.https('educationhelper.herokuapp.com', path);

  bool isSuccess(Response response) {
    final sta = response.statusCode;
    return sta > 200 && sta < 301;
  }

  void setHeaders(String? token) {
    _header = {'api-key': '270897'};
    if (token != null && token.isNotEmpty) {
      _header!['authenticate'] = token;
    }
  }

  Future post(
    String path,
    Map<String, dynamic> body,
  ) async {
    final url = _baseUrl(path);
    try {
      final response = await _client.post(url, headers: _header, body: body);
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
      final response = await _client.put(url, headers: _header, body: body);
      return _result(response);
    } catch (error) {
      debugPrint('[$path]: $error');
      return Future.error(error);
    }
  }

  Future get(String path) async {
    final url = _baseUrl(path);
    try {
      final response = await _client.get(url, headers: _header);
      return _result(response);
    } catch (error) {
      debugPrint('[$path]: $error');
      return Future.error(error);
    }
  }

  Future _result(Response response) {
    if (isSuccess(response)) {
      return Future.value(jsonDecode(response.body));
    }
    return Future.error(jsonDecode(response.body));
  }
}
