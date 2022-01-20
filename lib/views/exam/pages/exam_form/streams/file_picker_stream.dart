import 'dart:async';
import 'dart:io';

import 'package:education_helper/helpers/modules/file_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FilePickerStream {
  FilePickerStream();
  final _controller = FilePickerController();

  final _streamBroadcast = StreamController<PlatformFile?>.broadcast();
  Stream<File?> get stream => _streamBroadcast.stream.transform(_streamHandle);

  final _streamHandle = StreamTransformer<PlatformFile?, File?>.fromHandlers(
      handleData: (data, sink) {
    if (data == null) {
      sink.add(null);
      return;
    }
    final file = File(data.path ?? '');
    if (file.existsSync()) {
      sink.add(file);
      return;
    }
    sink.addError('Empty file');
  });

  Future<void> filePicker() async {
    try {
      final filePlatform = await _controller.getFilePicker();
      if (filePlatform == null) return;
      _streamBroadcast.sink.add(filePlatform);
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

  Future<void> replace() async {
    try {
      final filePlatform = await _controller.getFilePicker();
      if (filePlatform == null) return;
      _streamBroadcast.sink.add(filePlatform);
    } catch (error) {
      debugPrint('[File Picker]: $error');
      return;
    }
  }
}
