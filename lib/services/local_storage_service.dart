import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  SharedPreferences _preferences;

  init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  List<String> getIdList(String key) {
    return _preferences.getStringList(key);
  }

  updateList(String key, List<String> list) {
    _preferences.setStringList(key, list);
  }

  Object getObject(String id) {
    try {
      return _preferences.get(id.toString());
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<void> saveObject(String id, String objectString) async {
    try {
      await _preferences.setString(id, objectString);
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Object removeObject(String id) {
    try {
      return _preferences.remove(id.toString());
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
