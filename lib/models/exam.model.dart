import 'package:education_helper/helpers/extensions/map_x.dart';

class Exam {
  const Exam();

  static Exam fromJson(dynamic json) {
    return Exam();
  }

  Map<String, dynamic> toJson({bool fillterNull = false}) {
    final Map<String, dynamic> json = {};
    if (fillterNull) {
      return json.filterNull();
    }
    return json;
  }
}
