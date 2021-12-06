import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

enum Method { post, get, put }

class RestfApi {
  static final RestfApi _ins = RestfApi._internal();
  late Client client;

  RestfApi._internal() {
    client = Client();
  }

  factory RestfApi() {
    return _ins;
  }

  Uri _baseUrl(
    String path, {
    Map<String, dynamic>? query,
  }) {
    return Uri.https('educationhelper.herokuapp.com', path, query);
  }

  Map<String, String> get _headers {
    return {
      'api_key': '270097',
    };
  }

  Future<dynamic> post(
    String path,
    Map<String, dynamic> body,
  ) async {
    final url = _baseUrl(path);
    try {
      final response = await client.post(url, headers: _headers, body: body);
      return Future.value(response.body);
    } catch (error) {
      debugPrint('[$path]: $error');
      return Future.error(error);
    }
  }

  Future<dynamic> put(
    String path,
    Map<String, dynamic> body,
  ) async {
    final url = _baseUrl(path);
    try {
      final response = await client.put(url, headers: _headers, body: body);
      return Future.value(response.body);
    } catch (error) {
      debugPrint('[$path]: $error');
      return Future.error(error);
    }
  }

  Future<dynamic> get(
    String path,
    Map<String, dynamic> body,
  ) async {
    final url = _baseUrl(path);
    try {
      final response = await client.get(url, headers: _headers);
      return Future.value(response.body);
    } catch (error) {
      debugPrint('[$path]: $error');
      return Future.error(error);
    }
  }
}
