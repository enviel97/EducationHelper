import 'package:education_helper/helpers/ultils/funtions.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:faker/faker.dart';

import 'exam.model.dart';
import 'classroom.model.dart';

enum StatusAnswer { submit, lated, empty }

extension _StatusAnswer on StatusAnswer {
  String get name => toString().split('.')[1].toUpperCase();
  static StatusAnswer value(String value) {
    return StatusAnswer.values
        .where((type) => type.name.toLowerCase() == value.toLowerCase())
        .first;
  }
}

class Answer {
  final String id;
  final StatusAnswer status;

  const Answer({
    required this.status,
    this.id = '',
  });

  Map<String, dynamic> get toJson {
    return {
      'id': id,
      'status': status.name,
    };
  }

  static Answer fromJson(dynamic json) {
    return Answer(
      id: json['id'] ?? json['_id'] ?? '',
      status: _StatusAnswer.value(json['json']),
    );
  }

  static Answer faker() {
    final faker = Faker();
    return Answer(
      status: StatusAnswer.values[faker.randomGenerator.integer(99) % 3],
    );
  }
}

class Topic {
  final String id;
  final Classroom classroom;
  final Exam exam;
  final DateTime expiredDate;
  final List<Answer> answers;

  const Topic({
    required this.classroom,
    required this.exam,
    required this.expiredDate,
    required this.answers,
    this.id = '',
  });

  Map<String, dynamic> get toJson {
    return {
      'classId': classroom.id,
      'examId': exam.id,
      'expiredDate': expiredDate.toIso8601String(),
      'answers': answers,
    };
  }

  static Topic fromJson(dynamic json) {
    final answers = mapToList<Answer>(json['answers'], Answer.fromJson);
    return Topic(
      classroom: Classroom.fromJson(json['classroom']),
      exam: Exam.fromJson(json['exam']),
      expiredDate: json['expiredDate'],
      answers: answers,
    );
  }

  static Topic faker() {
    final faker = Faker();
    final classroom = Classroom.fake();
    classroom.members.addAll(
      List<Member>.generate(45, (index) => Member.faker()),
    );
    final answers = List<Answer>.generate(45, (index) => Answer.faker());
    return Topic(
      classroom: classroom,
      exam: Exam.faker(),
      expiredDate:
          DateTime.now().add(Duration(days: faker.randomGenerator.integer(10))),
      answers: answers,
    );
  }
}
