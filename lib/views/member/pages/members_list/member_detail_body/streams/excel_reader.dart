import 'dart:async';

import 'package:education_helper/helpers/modules/csv_modules.dart';
import 'package:education_helper/helpers/modules/file_picker.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

class ExcelReader {
  final _filePicker = FilePickerController();

  final _csvReaderStream = StreamController<PlatformFile?>.broadcast();
  final _transformStream =
      StreamTransformer<PlatformFile?, List<Member>>.fromHandlers(
          handleData: _handleData);
  Stream<List<Member>> get stream =>
      _csvReaderStream.stream.transform(_transformStream);

  Future<void> pickFile() async {
    try {
      final file = await _filePicker.getFilePicker(
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'xlsm', 'xls'],
      );
      if (file == null) return;
      _csvReaderStream.sink.add(file);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  static Future<void> _handleData(
    PlatformFile? file,
    EventSink<List<Member>> sink,
  ) async {
    if (file == null) return;
    final csvHandle = CSVController(file);
    final sheet = await csvHandle.readFileCSV();
    if (sheet == null) {
      sink.addError('File is empty');
      return;
    }
    final jsons = csvHandle.toJsons(sheet);
    sink.add(
      List.generate(
        jsons.length,
        (index) => Member.fromJson(jsons[index]),
      ),
    );
  }

  void dispose() {
    _csvReaderStream.close();
  }
}
