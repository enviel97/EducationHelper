import 'dart:math';

import 'package:education_helper/models/members.model.dart';
import 'package:faker/faker.dart';

class Classroom {
  final String id;
  final String creatorId;
  final String name;
  final List<Member> members;
  final List<dynamic> exams;

  const Classroom({
    required this.name,
    required this.members,
    required this.exams,
    this.creatorId = '',
    this.id = '',
  });

  Map<String, dynamic> toJson() => {'name': name};

  factory Classroom.fromJson(Map<String, dynamic> json) {
    return Classroom(
      name: json['name'],
      creatorId: json['creatorId '],
      id: json['id'] ?? json['_id'],
      exams: json['exams'] ?? [],
      members: json['members'] == null
          ? []
          : (json['members'] as List<Map<String, dynamic>>)
              .map((m) => Member.fromJson(m))
              .toList(),
    );
  }

  factory Classroom.fake() {
    final faker = Faker();
    final rnd = Random();
    final members =
        List<Member>.generate(rnd.nextInt(60), (_) => Member.faker());

    return Classroom(name: faker.job.title(), members: members, exams: []);
  }
}
