import 'package:education_helper/helpers/extensions/datetime_x.dart';
import 'package:education_helper/helpers/ultils/funtions.dart';
import 'package:flutter/material.dart';

class _Exams {
  final String id;
  final DateTime expiredDate;

  const _Exams({
    required this.id,
    required this.expiredDate,
  });

  Map<String, dynamic> get toJson {
    return {
      'id': id,
      'expiredDate': expiredDate,
    };
  }

  static _Exams fronJson(dynamic json) {
    final expiredDate = DateTime.tryParse(json['expiredDate']);
    if (expiredDate == null) {
      debugPrint(
        "User Exam error occuss: ${json['expiredDate']} try prase to datetime",
      );
    }
    return _Exams(
      id: json['id'] ?? json['_id'],
      expiredDate: expiredDate ?? DateTimeX.empty,
    );
  }
}

class User {
  final String? id;
  final String name;
  final String email;
  final String? avatar;
  final String phoneNumber;
  final List<_Exams> exams;

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
    final exams = mapToList<_Exams>(json['exams'], _Exams.fronJson);
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
