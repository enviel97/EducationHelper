import 'package:faker/faker.dart';

class Classroom {
  final String id;
  final String creatorId;
  final String name;
  final List<dynamic> members;
  final List<String> exams;

  const Classroom({
    required this.name,
    required this.members,
    required this.exams,
    this.creatorId = '',
    this.id = '',
  });

  Map<String, dynamic> toJson() => {'name': name};

  static Classroom fromJson(dynamic json) {
    final exams = List<String>.from(json['exams'] ?? []);
    final members = List<dynamic>.from(json['members'] ?? []);

    return Classroom(
      name: json['name'],
      creatorId: json['creatorId'] ?? '',
      id: json['id'] ?? json['_id'] ?? '',
      exams: exams,
      members: members,
    );
  }

  factory Classroom.fake() {
    final faker = Faker();

    return Classroom(name: faker.job.title(), members: [], exams: []);
  }
}
