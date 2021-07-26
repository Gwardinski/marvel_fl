import 'package:flutter/material.dart';
import 'package:marvel_heroes/models/character.dart';
import 'package:marvel_heroes/models/marvel.dart';
import 'package:marvel_heroes/shared/character_list_item.dart';
import 'package:marvel_heroes/services/marvel_service.dart';
import 'package:provider/provider.dart';

class CharactersListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Marvel Heroes"),
      ),
      body: FutureBuilder<MarvelReponseData<Character>>(
        future: Provider.of<MarvelService>(context).getCharacters(),
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
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.results.length,
                itemBuilder: (context, i) {
                  return CharacterListItem(
                    character: snapshot.data.results[i],
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
