import 'dart:async';
import 'dart:io';

import 'package:education_helper/helpers/modules/file_picker.dart';
import 'package:flutter/material.dart';

class FilePickerStream {
  final File? file;
  FilePickerStream(this.file);
  final _controller = FilePickerController();

  final _streamBroadcast = StreamController<File?>.broadcast();
  Stream<File?> get stream => _streamBroadcast.stream;

  void dispose() {
    _streamBroadcast.close();
  }

  Future<void> filePicker() async {
    try {
      final filePlatform = await _controller.getFilePicker();
      if (filePlatform == null) return;
      _streamBroadcast.sink.add(null);
      final file = File(filePlatform.path ?? '');
      if (file.existsSync()) {
        _streamBroadcast.sink.add(file);
      }
    } catch (error) {
      debugPrint('[File Picker]: $error');
      return;
    }
  }

  Future<void> remove() async {
    try {
      _streamBroadcast.sink.add(null);
    } catch (error) {
      debugPrint('[File Picker]: $error');
      return;
    }
  }
}
