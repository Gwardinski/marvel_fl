import 'package:flutter/material.dart';
import 'package:marvel_heroes/models/resource.dart';

class Comic {
  int id;
  String title;
  String description;
  String variantDescription;
  int pageCount;
  String thumbnail;
  List<Resource> resources;

  Comic({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.variantDescription,
    @required this.pageCount,
    @required this.thumbnail,
    this.resources,
  });

  Comic.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.title = json['title'];
    this.description = json['description'];
    this.variantDescription = json['variantDescription'];
    this.pageCount = json['pageCount'];
    this.thumbnail = "${json['thumbnail']['path']}.${json['thumbnail']['extension']}";
    if (json['urls'] != null) {
      List<Resource> resources = Resource.listFromJson(json['urls']);
      this.resources = resources;
    }
  }

  static List<Comic> listFromJson(List<dynamic> json) {
    List<Comic> formattedComics = [];
    if (json.length > 0) {
      formattedComics = json.map((c) => Comic.fromJson(c)).toList();
    }
    return formattedComics;
  }
}
