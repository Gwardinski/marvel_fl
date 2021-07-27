import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:marvel_heroes/models/character.dart';
import 'package:marvel_heroes/models/comics.dart';
import 'package:marvel_heroes/models/marvel.dart';
import 'package:marvel_heroes/services/http.dart';

// TODO secrets should be secret
const String apikey = "1b0b4dfb2dbba8cc9c126b03b6f513d6";
const String privateKey = "0a8f1d288fb11cf93bb586ee98b094e5cece4b5c";

const String baseurl = "http://gateway.marvel.com/v1/public";

class MarvelService {
  final HttpService http;

  MarvelService({
    @required this.http,
  });

  Future<MarvelReponseData<Character>> getCharacters(int offset) async {
    final url = "$baseurl/characters?offset=${offset.toString()}&${_appendUrl()}";
    var res = MarvelReponseData<Character>();
    try {
      dynamic resBody = await http.get(url);
      if (resBody != null) {
        return MarvelReponseData<Character>.fromApi(
          resBody['data'],
        );
      }
    } on OfflineException {
      // TODO add checks for further exceptions
      // use exceptions to update UI with useful information
      throw OfflineException();
    } catch (e) {
      print(e);
    }
    return res;
  }

  Future<MarvelReponseData<Comic>> getCharacterComics(String characterId) async {
    final url = "$baseurl/characters/$characterId/comics?${_appendUrl()}";
    var res = MarvelReponseData<Comic>();
    try {
      dynamic resBody = await http.get(url);
      if (resBody != null) {
        res = MarvelReponseData<Comic>.fromApi(
          resBody['data'],
        );
      }
    } on OfflineException {
      throw OfflineException();
    } catch (e) {
      print(e);
    }
    return res;
  }

  Future<MarvelReponseData<Character>> getComicCharacters(String comicId) async {
    final url = "$baseurl/comics/$comicId/characters?${_appendUrl()}";
    var res = MarvelReponseData<Character>();
    try {
      dynamic resBody = await http.get(url);
      if (resBody != null) {
        res = MarvelReponseData<Character>.fromApi(
          resBody['data'],
        );
      }
    } on OfflineException {
      throw OfflineException();
    } catch (e) {
      print(e);
    }
    return res;
  }

  String _appendUrl() {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final hash = _generateMd5(timestamp + privateKey + apikey);
    return "ts=$timestamp&apikey=$apikey&hash=$hash";
  }

  String _generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }
}
