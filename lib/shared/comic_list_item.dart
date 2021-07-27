import 'package:flutter/material.dart';
import 'package:marvel_heroes/models/comics.dart';
import 'package:marvel_heroes/pages/comic/comic_page.dart';

class ComicListItem extends StatelessWidget {
  const ComicListItem({
    @required this.comic,
  });

  final Comic comic;

  Future<void> _navigateToComicPage(context) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ComicPage(
          comic: comic,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _navigateToComicPage(context),
      child: Container(
        width: 200,
        child: Column(
          children: [
            Hero(
              tag: "thumbnail${comic.id}",
              child: Image.network(
                comic.thumbnail,
                height: 300,
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Text(
                comic.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
