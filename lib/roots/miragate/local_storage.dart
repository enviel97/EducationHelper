import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final SharedPreferences _preferences;
  const LocalStorage(this._preferences);

  Future<String> readAsync(String key) async {
    final value = _preferences.getString(key);
    return value ?? '';
  }

  String read(String key) {
    final value = _preferences.getString(key);
    return value ?? '';
  }

  Future<bool> write(String key, String value) async {
    final bool result = await _preferences.setString(key, value);
    return result;
  }

  Future<bool> remove(String key) async {
    final bool result = await _preferences.remove(key);
    return result;
  }
}
