import 'package:education_helper/helpers/extensions/datetime_x.dart';
import 'package:education_helper/helpers/extensions/map_x.dart';
import 'package:education_helper/helpers/ultils/funtions.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:equatable/equatable.dart';
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

class Answer extends Equatable {
  final String id;
  final StatusAnswer status;
  final double? grade;
  final String memberId;

  const Answer({
    required this.status,
    this.memberId = '',
    this.grade,
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
    final status = StatusAnswer.values[faker.randomGenerator.integer(99) % 3];
    return Answer(
      memberId: id ?? 'uuid-${DateTimeX.ctime}',
      status: status,
      grade: status == StatusAnswer.empty
          ? 0.0
          : faker.randomGenerator.boolean()
              ? faker.randomGenerator.integer(100) / 10
              : null,
    );
  }

  @override
  List<Object?> get props => [status, memberId, grade, id];
}

class Topic extends Equatable {
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

  static Map<String, dynamic> toRequest({
    DateTime? expiredDate,
    String? note,
    String classroomId = '',
    String examId = '',
  }) =>
      {
        'classroomId': classroomId,
        'examId': examId,
        'expiredDate': expiredDate?.toIso8601String(),
        'note': note ?? '',
        'answers': []
      }.filterNull();

  static Topic fromJson(dynamic json) {
    final expiredDate = DateTime.tryParse(json['expiredDate']);
    final createAt = DateTime.tryParse(json['createdAt']);
    final answers = mapToList<Answer>(json['answers'], Answer.fromJson);
    return Topic(
      id: json['id'] ?? json['_id'] ?? '',
      note: json['note'] ?? '',
      classroom: Classroom.fromJson(json['classroom']),
      exam: Exam.fromJson(json['exam']),
      expiredDate: expiredDate ?? DateTimeX.empty,
      createDate: createAt ?? DateTimeX.empty,
      answers: answers,
    );
  }

// List<Member> get members => mapToList(classroom.members, Member.fromJson)
  int get totalMembers => classroom.members.length;
  int get success =>
      answers.where((ans) => ans.status == StatusAnswer.submit).length;
  int get lated =>
      answers.where((ans) => ans.status == StatusAnswer.lated).length;
  int get missing => totalMembers - success - lated;

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

  @override
  List<Object?> get props =>
      [classroom, exam, expiredDate, createDate, answers];
}
