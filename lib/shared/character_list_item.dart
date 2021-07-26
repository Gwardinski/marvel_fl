import 'package:flutter/material.dart';
import 'package:marvel_heroes/models/character.dart';
import 'package:marvel_heroes/pages/character/character_page.dart';

class CharacterListItem extends StatelessWidget {
  const CharacterListItem({
    @required this.character,
  });

  final Character character;

  Future<void> _navigateToCharacterPage(context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CharacterPage(
          character: character,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _navigateToCharacterPage(context),
      child: Container(
        height: 120,
        width: double.infinity,
        child: Stack(
          children: [
            Hero(
              tag: "back${character.id}",
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                    image: NetworkImage(character.thumbnail),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Hero(
                  tag: "thumnail${character.id}",
                  child: Image.network(
                    character.thumbnail,
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          character.name,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          character.description,
                          maxLines: 3,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
