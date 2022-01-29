import 'dart:io';

import 'package:education_helper/helpers/extensions/datetime_x.dart';
import 'package:education_helper/helpers/extensions/map_x.dart';
import 'package:education_helper/helpers/ultils/funtions.dart';
import 'package:faker/faker.dart';

enum ExamType { quiz, essay }

extension _ExamType on ExamType {
  String get name => toString().split('.')[1].toUpperCase();
  static ExamType value(String value) {
    return ExamType.values
        .where((type) => type.name.toLowerCase() == value.toLowerCase())
        .first;
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

  String get type {
    final _type = name.split('/').first.toUpperCase();
    if (_type == 'PNG' ||
        _type == 'JPG' ||
        _type == 'JPEG' ||
        _type == 'IMAGE') {
      return 'IMG';
    }
    return _type;
  }

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

  static Content faker(String subject) {
    final faker = Faker();

    final content = faker.image.image(
      keywords: ['exam', 'homework', 'check'],
      random: true,
    );
    final exts = ['RAR', 'ZIP', 'PDF', 'PNG'];
    exts.shuffle();
    final ext = exts[faker.randomGenerator.integer(exts.length - 1)];

    return Content(
      download: content,
      name: '$ext/$ext-${DateTimeX.ctime}',
      originName: '$subject-'
          'N${faker.randomGenerator.integer(5)}'
          'T${faker.randomGenerator.integer(5)}',
      public: content,
    );
  }
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
      examType: _ExamType.value(json['examType']),
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

  String get type => content.type;
  String get name => content.originName;
  factory Exam.faker() {
    final faker = Faker();
    final subject = faker.sport.name();

    return Exam(
      subject: subject,
      content: Content.faker(subject),
    );
  }
}
