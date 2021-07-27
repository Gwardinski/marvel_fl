import 'package:flutter/material.dart';
import 'package:marvel_heroes/models/resource.dart';

class Character {
  String id;
  String name;
  String description;
  String thumbnail;
  List<Resource> resources;

  Character({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.thumbnail,
    this.resources,
  });

  Character.fromApi(Map<String, dynamic> json) {
    this.id = json['id'].toString();
    this.name = json['name'];
    this.description = json['description'];
    this.thumbnail = "${json['thumbnail']['path']}.${json['thumbnail']['extension']}";
    if (json['urls'] != null) {
      List<Resource> resources = Resource.listFromApi(json['urls']);
      this.resources = resources;
    }
  }

  static List<Character> listFromApi(List<dynamic> json) {
    List<Character> formattedCharacters = [];
    if (json.length > 0) {
      formattedCharacters = json.map((c) => Character.fromApi(c)).toList();
    }
    return formattedCharacters;
  }
}
