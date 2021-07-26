import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:marvel_heroes/models/character.dart';
import 'package:marvel_heroes/models/comics.dart';
import 'package:marvel_heroes/models/marvel.dart';
import 'package:marvel_heroes/services/http.dart';

String apikey = "1b0b4dfb2dbba8cc9c126b03b6f513d6";
String privateKey = "0a8f1d288fb11cf93bb586ee98b094e5cece4b5c";
String baseurl = "http://gateway.marvel.com/v1/public";

class MarvelService {
  final HttpService http;

  MarvelService({
    this.http,
  });

  Future<MarvelReponseData<Character>> getCharacters() async {
    final url = "$baseurl/characters?${_appendUrl()}";
    try {
      dynamic resBody = await http.get(url);
      return MarvelReponseData<Character>.fromJson(
        resBody['data'],
      );
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<MarvelReponseData<Comic>> getCharacterComics(int characterId) async {
    final url = "$baseurl/characters/${characterId.toString()}/comics?${_appendUrl()}";
    try {
      dynamic resBody = await http.get(url);
      return MarvelReponseData<Comic>.fromJson(
        resBody['data'],
      );
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<MarvelReponseData<Character>> getComicCharacters(int comicId) async {
    final url = "$baseurl/comics/${comicId.toString()}/characters?${_appendUrl()}";
    try {
      dynamic resBody = await http.get(url);
      return MarvelReponseData<Character>.fromJson(
        resBody['data'],
      );
    } catch (e) {
      print(e);
    }
    return null;
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
