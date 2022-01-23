import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/parts/adapter.dart';
import 'package:education_helper/views/topic/topics.dart';
import 'package:flutter/material.dart';

class TopicAdapter extends IAdapter {
  static final TopicAdapter _ins = TopicAdapter._internal();

  factory TopicAdapter() {
    return _ins;
  }
  TopicAdapter._internal() {
    Root.ins.adapter.injectAdapter(topicAdapter, this);
  }

  @override
  Widget layout({Map<String, dynamic>? params}) {
    return const Topics();
  }
}
