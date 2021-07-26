import 'package:flutter/material.dart';
import 'package:marvel_heroes/models/character.dart';

class CharacterBioSection extends StatelessWidget {
  const CharacterBioSection({
    @required this.character,
  });

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Hero(
          tag: "thumnail${character.id}",
          child: Image.network(
            character.thumbnail,
            width: double.infinity,
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          child: Text(
            character.name,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        character.description != ""
            ? Container(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Text(character.description),
              )
            : Container(),
      ],
    );
  }
}
