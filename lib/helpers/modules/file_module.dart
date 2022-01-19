import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileModule {
  final String name;
  const FileModule(this.name);

  String get filename {
    final paths = name.split('/');
    return paths[paths.length - 1];
  }

  Future<String> get dir async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/$filename';
  }

  Future<File> loadFile() async {
    if (name.isEmpty) {
      return Future.error('Name is empty');
    }
    try {
      final path = await dir;
      final file = File(path);
      if (file.existsSync()) {
        debugPrint('[File]: Exits');
        return file;
      }
      return await _loadFile();
    } catch (error) {
      debugPrint('$error');
      return Future.error('Some error when load file');
    }
  }

  Future<File> _loadFile() async {
    final refPdf = FirebaseStorage.instance.ref().child(name);
    final bytes = await refPdf.getData();
    if (bytes != null) {
      return _storeFile(bytes);
    }

    return Future.error('Empty file');
  }

  Future<File> _storeFile(List<int> bytes) async {
    try {
      final file = File(await dir);
      file.writeAsBytesSync(bytes, flush: true);
      return file;
    } catch (error) {
      return Future.error('$error');
    }
  }
}
