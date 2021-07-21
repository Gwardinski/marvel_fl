import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:marvel_heroes/services/http.dart';
import 'package:http/http.dart' as http;

class MarvelService {
  String baseurl = "http://gateway.marvel.com/v1/public/comics?";
  String apikey = "1b0b4dfb2dbba8cc9c126b03b6f513d6";
  String privateKey = "0a8f1d288fb11cf93bb586ee98b094e5cece4b5c";

  String _generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  Future<void> getComics() async {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final hash = _generateMd5(timestamp + privateKey + apikey);
    final url = baseurl + "ts=$timestamp&apikey=$apikey&hash=$hash";
    final res = await http.get(
      Uri.http(url, '/comics'),
    );
    print(res);
  }
}
