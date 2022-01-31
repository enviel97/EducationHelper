import 'dart:async';

import 'package:education_helper/models/members.model.dart';
import 'package:education_helper/models/topic.model.dart';
import 'package:flutter/material.dart';

class _Query {
  String text;
  StatusAnswer? status;

  _Query({this.text = '', this.status});
}

class GroupByStatus {
  static List<Member> _members = [];
  static Map<String, StatusAnswer> _answers = {};
  static final _query = _Query();

  GroupByStatus(List<Member> _members, Map<String, StatusAnswer> _answers) {
    GroupByStatus._members = _members;
    GroupByStatus._answers = _answers;
  }

  void dispose() {
    _controller.close();
  }

  final _controller = StreamController<_Query>.broadcast();
  Stream<List<Member>> get stream => _controller.stream.transform(_searchText);
  final _searchText = StreamTransformer<_Query, List<Member>>.fromHandlers(
    handleData: (data, sink) {
      try {
        List<Member> members = _members;

        if (data.text.isNotEmpty) {
          members = [
            ...members.where((mem) => '${mem.lastName} ${mem.firstName}'
                .toLowerCase()
                .contains(data.text.toLowerCase()))
          ];
        }

        if (data.status != null) {
          members = [
            ...members.where((mem) => _answers[mem.uid] == data.status),
            ...members.where((mem) => _answers[mem.uid] != data.status),
          ];
        }

        sink.add(members);
      } catch (e) {
        debugPrint(e.toString());
        sink.addError('Sorted Error');
      }
    },
  );

  void sorted(StatusAnswer? status) {
    GroupByStatus._query.status = status;
    _controller.sink.add(GroupByStatus._query);
  }

  void search(String text) {
    GroupByStatus._query.text = text;
    _controller.sink.add(GroupByStatus._query);
  }
}
