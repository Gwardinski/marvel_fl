import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marvel_heroes/models/resource.dart';

class Comic {
  String id;
  String title;
  String description;
  String variantDescription;
  String pageCount;
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

  Comic.fromApi(Map<String, dynamic> json) {
    this.id = json['id'].toString();
    this.title = json['title'];
    this.description = json['description'];
    this.variantDescription = json['variantDescription'];
    this.pageCount = json['pageCount'].toString();
    this.thumbnail = "${json['thumbnail']['path']}.${json['thumbnail']['extension']}";
    if (json['urls'] != null) {
      List<Resource> resources = Resource.listFromApi(json['urls']);
      this.resources = resources;
    }
  }

  Comic.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.title = json['title'];
    this.description = json['description'];
    this.variantDescription = json['variantDescription'];
    this.pageCount = json['pageCount'];
    this.thumbnail = json['thumbnail'];
    if (json['resources'] != null) {
      List<Resource> resources = Resource.listFromJson(jsonDecode(json['resources']));
      this.resources = resources;
    }
  }

  static List<Comic> listFromApi(List<dynamic> json) {
    List<Comic> formattedComics = [];
    if (json.length > 0) {
      formattedComics = json.map((c) => Comic.fromApi(c)).toList();
    }
    return formattedComics;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'variantDescription': variantDescription,
        'pageCount': pageCount,
        'thumbnail': thumbnail,
        'resources': jsonEncode(resources),
      };
}
