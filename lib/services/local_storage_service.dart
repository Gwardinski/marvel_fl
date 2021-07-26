import 'dart:convert';

import 'package:marvel_heroes/models/comics.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  SharedPreferences _preferences;

  init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // void saveComic(Comic comic) {
  //   try {
  //     _preferences.setString(comic.id.toString(), jsonEncode(comic));
  //   } catch (error) {
  //     throw Exception(error.toString());
  //   }
  // }

  // dynamic getComic(Comic comic) {
  //   try {
  //     final value = _preferences.get(comic.id.toString());
  //     Comic.fromJson(value);
  //     return value;
  //   } catch (error) {
  //     throw Exception(error.toString());
  //   }
  // }

  dynamic getComics() {
    // try {
    //   final value = _preferences.get(comic.id.toString());
    //   Comic.fromJson(value);
    //   return value;
    // } catch (error) {
    //   throw Exception(error.toString());
    // }
  }
}
