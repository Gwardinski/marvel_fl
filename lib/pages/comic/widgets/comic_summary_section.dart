import 'package:flutter/material.dart';
import 'package:marvel_heroes/models/comics.dart';

class ComicSummarySection extends StatelessWidget {
  const ComicSummarySection({
    @required this.comic,
  });

  final Comic comic;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Hero(
          tag: "thumnail${comic.id}",
          child: Image.network(
            comic.thumbnail,
            height: 400,
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          child: Text(
            comic.title,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        comic.description != null && comic.description != ""
            ? Container(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Text(comic.description),
              )
            : Container(),
        comic.variantDescription != null && comic.variantDescription != ""
            ? Container(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Text(comic.variantDescription),
              )
            : Container(),
      ],
    );
  }
}
