import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';

class CSVController<T> {
  final PlatformFile file;
  const CSVController(this.file);
  // get csv

  // read csv
  Future<Sheet?> readFileCSV() async {
    final content = File(file.path ?? '');
    if (await content.exists()) {
      final excel = Excel.decodeBytes(content.readAsBytesSync());
      final sheet = excel.tables[excel.tables.keys.first];
      return sheet;
    }
    return null;
  }

  List<Map<String, dynamic>> toJsons(Sheet sheet) {
    final List<String> keys = [];
    sheet.row(0).forEach((e) => keys.add(e?.value));

    final maxRow = sheet.maxRows;
    final List<Map<String, dynamic>> jsons = [];
    for (int i = 1; i < maxRow; ++i) {
      final Map<String, dynamic> json = {};
      final cells = sheet.row(i);
      for (int j = 0; j < keys.length; ++j) {
        json[keys[j]] = cells[j]?.value;
      }
      jsons.add(json);
    }
    return jsons;
  }
}
