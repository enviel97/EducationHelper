import 'dart:io';

import 'package:education_helper/helpers/extensions/datetime_x.dart';
import 'package:education_helper/helpers/extensions/map_x.dart';
import 'package:education_helper/helpers/ultils/funtions.dart';
import 'package:faker/faker.dart';

enum ExamType { quiz, essay }

extension _ on ExamType {
  String get name => toString().split('.')[1].toUpperCase();
  static ExamType value(String value) {
    return ExamType.values[0];
  }
}

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);

  static Point fromJson(dynamic json) {
    return Point(json['x'] ?? 0.0, json['y'] ?? 0.0);
  }

  Map<String, dynamic> toJson() => {
        'x': x,
        'y': y,
      };
}

class Quest {
  final Point ask;
  final List<Point> answer;

  Quest(this.ask, this.answer);

  static Quest fromJson(dynamic json) {
    final answer = mapToList<Point>(json['answer'], Point.fromJson);

    return Quest(Point.fromJson(json['ask']), answer);
  }

  Map<String, dynamic> toJson() => {
        'ask': ask,
        'answer': answer,
      };
}

class Content {
  final String name;
  final String originName;
  final String download;
  final String public;
  final List<Quest>? offset;

  const Content({
    required this.name,
    required this.originName,
    required this.download,
    required this.public,
    this.offset,
  });

  bool get isImage => name.toUpperCase().contains('IMAGE');
  bool get isPDF => name.toUpperCase().contains('PDF');

  static Content fromJson(dynamic json) {
    final offset = mapToList<Quest>(json['answer'], Quest.fromJson);
    return Content(
      name: json['name'] ?? '',
      originName: json['originName'] ?? '',
      download: json['download'] ?? '',
      public: json['public'] ?? '',
      offset: offset,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'originName': originName,
        'download': download,
        'public': public,
        'offset': offset,
      };
}

class Exam {
  final String id;
  final String creatorId;
  final String subject;
  final ExamType examType;
  final Content content;

  const Exam({
    required this.subject,
    required this.content,
    this.examType = ExamType.essay,
    this.creatorId = '',
    this.id = '',
  });

  static Exam fromJson(dynamic json) {
    return Exam(
      id: json['id'] ?? json['_id'] ?? '',
      creatorId: json['creatorId'] ?? '',
      subject: json['subject'] ?? '',
      examType: _.value(json['examType']),
      content: Content.fromJson(json['content']),
    );
  }

  Map<String, dynamic> toJson(File file, {bool fillterNull = false}) {
    final Map<String, dynamic> json = {
      'creatorId': creatorId,
      'subject': subject,
      'examType': examType.name,
      'content': file,
    };
    if (fillterNull) {
      return json.filterNull();
    }
    return json;
  }

  factory Exam.faker() {
    final faker = Faker();
    final subject = faker.sport.name();
    final content = faker.image.image(
      keywords: ['exam', 'homework', 'check'],
      random: true,
    );
    final isPdf = faker.randomGenerator.integer(9999) % 2 == 0;
    return Exam(
      subject: subject,
      content: Content(
        download: content,
        name: '${isPdf ? 'PDF' : 'Image'}-'
            '${DateTimeX.ctime}',
        originName: '$subject-'
            'N${faker.randomGenerator.integer(5)}'
            'T${faker.randomGenerator.integer(5)}',
        public: content,
      ),
    );
  }
}
