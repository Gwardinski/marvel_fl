import 'package:flutter/material.dart';
import 'package:marvel_heroes/models/comics.dart';
import 'package:marvel_heroes/pages/comic/widgets/comic_characters_section.dart';
import 'package:marvel_heroes/pages/comic/widgets/comic_summary_section.dart';
import 'package:marvel_heroes/services/comic_state.dart';
import 'package:marvel_heroes/shared/resources_section.dart';
import 'package:provider/provider.dart';

class ComicPage extends StatelessWidget {
  final Comic comic;

  ComicPage({
    @required this.comic,
  });

  @override
  Widget build(BuildContext context) {
    final comicState = Provider.of<ComicState>(context);
    final isSaved = comicState.isSaved(comic.id);
    return Scaffold(
      appBar: AppBar(
        title: Text("Comic"),
        actions: [
          IconButton(
            icon: Icon(isSaved ? Icons.bookmark : Icons.bookmark_outline),
            onPressed: () {
              isSaved ? comicState.removeComic(comic.id) : comicState.saveComic(comic);
            },
          ),
        ],
      ),
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
