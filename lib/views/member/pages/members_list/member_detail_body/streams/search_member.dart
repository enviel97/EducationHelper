import 'dart:async';

import 'package:education_helper/models/members.model.dart';

class SearchMember {
  List<Member> list = [];
  SearchMember(this.list);

  final _searchController = StreamController<String>.broadcast();

  Stream<List<Member>> get stream => _searchController.stream.transform(
        StreamTransformer<String, List<Member>>.fromHandlers(
          handleData: _handleData,
        ),
      );

  void setMembers(List<Member> list) {
    this.list = list;
  }

  void refresh() {
    _searchController.sink.add('');
  }

  void onSearch(String query) {
    _searchController.sink.add(query.trim());
  }

  void dispose() {
    _searchController.close();
  }

  void _handleData(String data, EventSink<List<Member>> sink) {
    if (data.isEmpty) {
      sink.add(list);
      return;
    }
    sink.add(list.where((e) {
      final bool isMail = e.mail?.contains(data) ?? false;
      final bool isPhonenumber = e.phoneNumber?.contains(data) ?? false;
      return e.firstName.toLowerCase().contains(data.toLowerCase()) ||
          e.lastName.toLowerCase().contains(data.toLowerCase()) ||
          isMail ||
          isPhonenumber;
    }).toList());
  }
}
