import 'dart:async';

import 'package:education_helper/models/answer.model.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:flutter/material.dart';

class _Query {
  String text;
  StatusAnswer? status;

  _Query({this.text = '', this.status});
}

class GroupByStatus {
  static List<Member> _members = [];
  static Map<String, dynamic> _answerGroup = {};
  static final _query = _Query();

  GroupByStatus(List<Member> members, List<Answer> answers) {
    _members = members;
    _groupAnswer(members, answers);
    //  GroupByStatus._answerGroup = _answerGroup;
  }
  Map<String, dynamic> get answerGroup => _answerGroup;

  void _groupAnswer(List<Member> members, List<Answer> answers) {
    _answerGroup = {
      for (final member in members)
        member.uid: {'status': StatusAnswer.empty, 'grade': 0.0, 'id': ''}
    };
    if (answers.isEmpty) return;
    _answerGroup = _answerGroup.map((key, value) {
      final iAns = answers.indexWhere((ans) => ans.member.uid == key);
      if (iAns > -1) {
        final anss = answers[iAns];
        return MapEntry(
          key,
          {
            'status': anss.status,
            'grade': anss.grade,
            'id': anss.id,
          },
        );
      }
      return MapEntry(key, value);
    });
  }

  void dispose() {
    _controller.close();
  }

  final _controller = StreamController<_Query>.broadcast();
  Stream<List<Member>> get stream => _controller.stream.transform(_searchText);
  final _searchText = StreamTransformer<_Query, List<Member>>.fromHandlers(
    handleData: _transDate,
  );

  void sorted(StatusAnswer? status) {
    GroupByStatus._query.status = status;
    _controller.sink.add(GroupByStatus._query);
  }

  void gradeing(String idMember, double grade) {
    _answerGroup[idMember]['grade'] = grade;
    _controller.sink.add(GroupByStatus._query);
  }

  void search(String text) {
    GroupByStatus._query.text = text;
    _controller.sink.add(GroupByStatus._query);
  }

  static _buildMembers(List<Member> members, bool Function(Member) test) {
    return members.where(test).toList()
      ..sort((a, b) {
        final rule1 = a.firstName.compareTo(b.firstName);
        if (rule1 == 0) {
          return a.lastName.compareTo(b.lastName);
        }
        return rule1;
      });
  }

  static void _transDate(_Query data, EventSink<List<Member>> sink) {
    try {
      List<Member> members = _members;

      if (data.text.isNotEmpty) {
        members = [
          ...members.where((mem) => '${mem.lastName} ${mem.firstName}'
              .toLowerCase()
              .contains(data.text.toLowerCase()))
        ];
      }

      members = [
        ..._buildMembers(
            members, (mem) => _answerGroup[mem.uid]['status'] == data.status),
        ..._buildMembers(
            members, (mem) => _answerGroup[mem.uid]['status'] != data.status)
      ];

      sink.add(members);
    } catch (e) {
      debugPrint(e.toString());
      sink.addError('Sorted Error');
    }
  }
}
