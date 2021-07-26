import 'package:flutter/material.dart';
import 'package:marvel_heroes/models/comics.dart';
import 'package:marvel_heroes/services/local_storage_service.dart';

class UserState extends ChangeNotifier {
  String userKey = 'user';
  LocalStorageService localStorageService;

  UserState({
    @required this.localStorageService,
  }) {
    _init();
  }

  void _init() {
    // var userJson = localStorageService.getComics(userKey);
    // if (userJson == null) {
    //   return null;
    // }
    // updateSavedComics(
    //   Comic.fromJson(
    //     json.decode(userJson),
    //   ),
    // );
  }

  void updateSavedComics(Comic comic) {
    try {
      localStorageService.saveComic(comic);
    } catch (error) {
      print(error);
    } finally {
      notifyListeners();
    }
  }
}
