import 'package:education_helper/helpers/extensions/datetime_x.dart';
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
  final double grade;
  final String memberId;

  const Answer({
    required this.status,
    this.memberId = '',
    this.grade = 0.0,
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
      grade: json['grade'] ?? 0.0,
    );
  }

  static Answer faker({String? id}) {
    final faker = Faker();
    return Answer(
      memberId: id ?? 'uuid-${DateTimeX.ctime}',
      status: StatusAnswer.values[faker.randomGenerator.integer(99) % 3],
      grade: faker.randomGenerator.integer(100) / 10,
    );
  }
}

class Topic {
  final String id;
  final Classroom classroom;
  final Exam exam;
  final DateTime expiredDate;
  final DateTime createDate;
  final List<Answer> answers;
  final String? note;

  const Topic({
    required this.classroom,
    required this.exam,
    required this.expiredDate,
    required this.createDate,
    required this.answers,
    this.id = '',
    this.note,
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
      createDate: json['createdAt'],
      answers: answers,
    );
  }

  int get members => classroom.members.length;
  int get success =>
      answers.where((ans) => ans.status == StatusAnswer.submit).length;
  int get missing =>
      answers.where((ans) => ans.status == StatusAnswer.empty).length;
  int get lated =>
      answers.where((ans) => ans.status == StatusAnswer.lated).length;

  String get type => exam.type;
  String get name => exam.name;

  static Topic faker() {
    final faker = Faker();
    final classroom = Classroom.fake();
    classroom.members.addAll(
      List<Member>.generate(45, (index) => Member.faker()),
    );
    final answers = List<Answer>.generate(
        45, (index) => Answer.faker(id: classroom.members[index].uid));
    final lorem = faker.randomGenerator.boolean()
        ? faker.lorem.sentences(faker.randomGenerator.integer(5)).join('\n')
        : null;
    return Topic(
      classroom: classroom,
      exam: Exam.faker(),
      createDate: DateTime.now(),
      expiredDate:
          DateTime.now().add(Duration(days: faker.randomGenerator.integer(10))),
      answers: answers,
      note: lorem,
    );
  }
}
