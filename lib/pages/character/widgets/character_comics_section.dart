import 'package:flutter/material.dart';
import 'package:marvel_heroes/models/character.dart';
import 'package:marvel_heroes/models/comics.dart';
import 'package:marvel_heroes/models/marvel.dart';
import 'package:marvel_heroes/services/marvel_service.dart';
import 'package:marvel_heroes/shared/comic_list_item.dart';
import 'package:provider/provider.dart';

class CharacterComicsSection extends StatelessWidget {
  final Character character;

  CharacterComicsSection({
    @required this.character,
  });

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<MarvelService>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          child: Text(
            "Comics",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 500,
          child: FutureBuilder<MarvelReponseData<Comic>>(
            future: service.getCharacterComics(character.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("Failed to load comics."));
              }
              if (snapshot.hasData && snapshot.data.results.length == 0) {
                return Center(child: Text("${character.name} has no comics to display."));
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.results.length,
                itemBuilder: (c, i) {
                  return ComicListItem(comic: snapshot.data.results[i]);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
