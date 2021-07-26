import 'package:marvel_heroes/models/character.dart';
import 'package:marvel_heroes/models/comics.dart';

Type typeOf<T>() => T;

class MarvelReponseData<T> {
  int offset;
  int limit;
  int total;
  int count;
  List<T> results;

  MarvelReponseData.fromJson(json) {
    this.offset = json['offset'];
    this.limit = json['limit'];
    this.total = json['total'];
    this.count = json['count'];
    if (json['results'] != null) {
      List<T> models = [];
      Type type = typeOf<T>();
      assert(type != null);
      switch (type) {
        case Character:
          models = Character.listFromJson(json['results']) as List<T>;
          break;
        case Comic:
          models = Comic.listFromJson(json['results']) as List<T>;
          break;
        default:
          models = [];
      }
      this.results = models;
    }
  }
}
