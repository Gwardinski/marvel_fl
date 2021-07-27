import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marvel_heroes/models/comics.dart';
import 'package:marvel_heroes/services/local_storage_service.dart';

const key = "comic";

class ComicState extends ChangeNotifier {
  LocalStorageService localStorageService;
  List<String> comicsList = [];

  ComicState({
    @required this.localStorageService,
  }) {
    _init();
  }

  void _init() {
    List<String> list = localStorageService.getIdList(key);
    if (list == null) {
      comicsList = [];
    } else {
      comicsList = list;
    }
    print(comicsList);
    notifyListeners();
  }

  bool isSaved(String id) {
    return comicsList.contains(id);
  }

  Comic getComic(String id) {
    final comicString = localStorageService.getObject(id);
    final comicJson = jsonDecode(comicString);
    Comic comic = Comic.fromJson(comicJson);
    return comic;
  }

  void saveComic(Comic comic) {
    comicsList.add(comic.id);
    localStorageService.updateList(key, comicsList);
    localStorageService.saveObject(comic.id.toString(), jsonEncode(comic));
    notifyListeners();
  }

  void removeComic(String id) {
    comicsList.removeWhere((element) => element == id);
    localStorageService.updateList(key, comicsList);
    localStorageService.removeObject(id);
    notifyListeners();
  }
}
