import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FilePickerController {
  Future<PlatformFile?> getFilePicker(
      {FileType type = FileType.any, List<String>? allowedExtensions}) async {
    try {
      final result = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: type,
          allowedExtensions: allowedExtensions);
      if (result == null) return null;
      return result.files.first;
    } catch (error) {
      debugPrint(error.toString());
      return Future.error('File error');
    }
  }

  Future<File?> saveFile(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');
    if (file.path == null) return Future.error('File path is empty');
    return File(file.path!).copy(newFile.path);
  }
}
