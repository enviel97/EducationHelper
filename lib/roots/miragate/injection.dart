import 'package:education_helper/roots/parts/adapter.dart';
import 'package:flutter/material.dart';

class AppAdapter {
  static final AppAdapter _ins = AppAdapter._();
  factory AppAdapter() {
    return _ins;
  }

  late Map<String, dynamic> _appAdapter;

  AppAdapter._() {
    _appAdapter = {};
  }

  IAdapter getAdapter(String name) {
    if (_appAdapter.containsKey(name)) {
      return _appAdapter[name] as IAdapter;
    }
    throw Exception("Don't have adapter");
  }

  void injectAdapter(String name, dynamic adapter) {
    debugPrint('inject $name');
    if (_appAdapter.containsKey(name)) {
      throw Exception('Adapter is allready');
    }
    _appAdapter[name] = adapter;
  }
}
