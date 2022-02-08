import 'package:education_helper/helpers/extensions/datetime_x.dart';
import 'package:education_helper/helpers/ultils/funtions.dart';
import 'package:flutter/material.dart';

import 'exam.model.dart';

class ExamHome {
  final String id;
  final DateTime expiredDate;
  final String name;

  const ExamHome({
    required this.id,
    required this.expiredDate,
    required this.name,
  });

  static ExamHome fronJson(dynamic json) {
    final expiredDate = DateTime.tryParse(json['expiredDate']);
    if (expiredDate == null) {
      debugPrint(
        "User Exam error occuss: ${json['expiredDate']} try prase to datetime",
      );
    }
    final exam = mapToModel(json['exam'], Exam.fromJson);
    return ExamHome(
      id: json['id'] ?? json['_id'],
      expiredDate: expiredDate ?? DateTimeX.empty,
      name: exam.name,
    );
  }

  @override
  String toString() {
    return '$name $expiredDate';
  }
}

class User {
  final String? id;
  final String name;
  final String email;
  final String? avatar;
  final String phoneNumber;
  final List<ExamHome> exams;

  const User({
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.avatar,
    this.id,
    this.exams = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'avatar': avatar,
      'exams': exams
    };
  }

  static User fromJson(dynamic json) {
    final exams = mapToList<ExamHome>(json['exams'], ExamHome.fronJson);
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
      phoneNumber: json['phoneNumber'],
      exams: exams,
    );
  }
}
