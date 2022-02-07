import 'package:education_helper/helpers/ultils/funtions.dart';
import 'package:education_helper/models/exam.model.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:equatable/equatable.dart';
import 'package:faker/faker.dart';

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
  final Member member;
  final StatusAnswer status;
  final double grade;
  final String note;
  final String review;
  final Content content;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Answer({
    required this.status,
    required this.content,
    required this.member,
    this.grade = 0.0,
    this.id = '',
    this.note = '',
    this.review = '',
    this.createdAt,
    this.updatedAt,
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
      status: _StatusAnswer.value(json['status'] ?? 'empty'),
      grade: double.tryParse('${json['grade']}') ?? 0.0,
      content: mapToModel(json['content'], Content.fromJson),
      member: mapToModel(json['member'], Member.fromJson),
      note: json['note'] ?? '',
      review: json['review'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  static Answer faker({String? id}) {
    final faker = Faker();
    final status = StatusAnswer.values[faker.randomGenerator.integer(99) % 3];
    return Answer(
        member: Member.faker(),
        status: status,
        grade: status == StatusAnswer.empty
            ? 0.0
            : faker.randomGenerator.integer(100) / 10,
        content: Content.faker('education'));
  }

  @override
  String toString() {
    return '[$status, $grade, $member]\n';
  }

  @override
  List<Object?> get props => [status, member, grade, id];
}
