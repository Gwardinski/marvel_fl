import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:marvel_heroes/services/marvel_service.dart';

import 'package:dio/dio.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marvel Heroes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Marvel Heroes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    final res = await Dio().get(url);
    print(res.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getComics,
        tooltip: 'Get',
        child: Icon(Icons.add),
      ),
    );
  }
}
