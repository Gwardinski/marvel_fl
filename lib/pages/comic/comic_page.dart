import 'package:flutter/material.dart';
import 'package:marvel_heroes/models/comics.dart';
import 'package:marvel_heroes/pages/comic/widgets/comic_characters_section.dart';
import 'package:marvel_heroes/pages/comic/widgets/comic_summary_section.dart';
import 'package:marvel_heroes/shared/resources_section.dart';

class ComicPage extends StatelessWidget {
  final Comic comic;

  ComicPage({
    @required this.comic,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ComicSummarySection(comic: comic),
            ResourcesSection(resources: comic.resources),
            Padding(padding: EdgeInsets.only(top: 16)),
            ComicCharactersSection(comic: comic),
          ],
        ),
      ),
    );
  }
}
