class AppAdapter {
  static final AppAdapter _ins = AppAdapter._();
  factory AppAdapter() {
    return _ins;
  }

  late Map<String, dynamic> _appAdapter;

  AppAdapter._() {
    _appAdapter = {};
  }

  Adapter getAdapter<Adapter>(String name) {
    if (_appAdapter.containsKey(name)) {
      return _appAdapter[name] as Adapter;
    }
    throw Exception("Don't have adapter");
  }

  void injectAdapter(String name, dynamic adapter) {
    print('inject $name');
    if (_appAdapter.containsKey(name)) {
      throw Exception('Adapter is allready');
    }
    _appAdapter[name] = adapter;
  }
}
