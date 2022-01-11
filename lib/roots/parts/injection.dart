part of '../app_root.dart';

class _AppAdapter {
  static final _AppAdapter _ins = _AppAdapter._();
  factory _AppAdapter() {
    return _ins;
  }

  late Map<String, dynamic> _appAdapter;

  _AppAdapter._() {
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
