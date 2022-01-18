import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PdfModule {
  final String url;
  const PdfModule(this.url);

  Future<File?> loadNetwork() async {
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final bytes = response.bodyBytes;
    return _storeFile(bytes);
  }

  String basename(String filename) {
    return filename;
  }

  Future<File?> _storeFile(List<int> bytes) async {
    try {
      final filename = basename(url);
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$filename');
      file.writeAsBytesSync(bytes, flush: true);
      return file;
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }
}
