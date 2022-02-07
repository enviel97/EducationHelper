import 'package:equatable/equatable.dart';
import 'package:faker/faker.dart';

class Classroom extends Equatable {
  final String id;
  final String creatorId;
  final String name;
  final List<dynamic> members;
  final int size;
  final List<String> exams;

  const Classroom({
    required this.name,
    required this.exams,
    this.members = const [],
    this.creatorId = '',
    this.id = '',
    this.size = 0,
  });

  static Classroom fromJson(dynamic json) {
    final exams = List<String>.from(json['exams'] ?? []);
    final members = List<dynamic>.from(json['members'] ?? []);

    return Classroom(
      name: json['name'] ?? '',
      creatorId: json['creatorId'] ?? '',
      id: json['id'] ?? json['_id'] ?? '',
      size: json['size'] ?? 0,
      exams: exams,
      members: members,
    );
  }

  factory Classroom.fake() {
    final faker = Faker();

    return Classroom(name: faker.job.title(), members: [], exams: []);
  }

  @override
  List<Object?> get props => [name, members, exams, creatorId, id, size];
}
