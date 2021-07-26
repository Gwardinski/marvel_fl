import 'package:flutter/material.dart';
import 'package:marvel_heroes/models/character.dart';
import 'package:marvel_heroes/models/marvel.dart';
import 'package:marvel_heroes/shared/character_list_item.dart';
import 'package:marvel_heroes/services/marvel_service.dart';

class CharactersListPage extends StatefulWidget {
  CharactersListPage({
    Key key,
  }) : super(key: key);

  @override
  _CharactersListPageState createState() => _CharactersListPageState();
}

class _CharactersListPageState extends State<CharactersListPage> {
  MarvelService service = MarvelService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Marvel Heroes"),
      ),
      body: FutureBuilder<MarvelReponseData<Character>>(
        future: service.getCharacters(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.connectionState == ConnectionState.none) {
            return Center(child: Text("Please go online to use this app"));
          }
          if (snapshot.hasError) {
            return Center(child: Text("Failed to load characters."));
          }
          return SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.data.results.length,
              itemBuilder: (context, i) {
                return CharacterListItem(character: snapshot.data.results[i]);
              },
            ),
          );
        },
      ),
    );
  }
}