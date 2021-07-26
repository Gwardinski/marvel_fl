import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:marvel_heroes/models/character.dart';
import 'package:marvel_heroes/pages/character/widgets/character_bio_section.dart';
import 'package:marvel_heroes/pages/character/widgets/character_comics_section.dart';
import 'package:marvel_heroes/shared/resources_section.dart';

class CharacterPage extends StatelessWidget {
  final Character character;

  CharacterPage({
    @required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Character"),
      ),
      body: Stack(
        children: [
          Hero(
            tag: "back${character.id}",
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                  image: NetworkImage(character.thumbnail),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                CharacterBioSection(character: character),
                ResourcesSection(resources: character.resources),
                Padding(padding: EdgeInsets.only(top: 16)),
                CharacterComicsSection(character: character),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
