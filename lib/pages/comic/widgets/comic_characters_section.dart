import 'package:flutter/material.dart';
import 'package:marvel_heroes/models/character.dart';
import 'package:marvel_heroes/models/comics.dart';
import 'package:marvel_heroes/models/marvel.dart';
import 'package:marvel_heroes/services/marvel_service.dart';
import 'package:marvel_heroes/shared/character_list_item.dart';
import 'package:provider/provider.dart';

class ComicCharactersSection extends StatelessWidget {
  final Comic comic;

  ComicCharactersSection({
    @required this.comic,
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
            "Characters",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        FutureBuilder<MarvelReponseData<Character>>(
          future: service.getComicCharacters(comic.id),
          // TODO handle offline error
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("Failed to load characters."));
            }
            if (snapshot.hasData && snapshot.data.results.length == 0) {
              return Center(child: Text("${comic.title} has no characters to display."));
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.data.results.length,
              itemBuilder: (c, i) {
                return CharacterListItem(character: snapshot.data.results[i]);
              },
            );
          },
        ),
      ],
    );
  }
}
