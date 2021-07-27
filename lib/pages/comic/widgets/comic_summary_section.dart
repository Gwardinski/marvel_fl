import 'package:cached_network_image/cached_network_image.dart';
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
        CachedNetworkImage(
          imageUrl: comic.thumbnail,
          placeholder: (c, s) => Center(child: CircularProgressIndicator()),
          errorWidget: (c, s, d) => Container(),
          imageBuilder: (context, imageProvider) => Hero(
            tag: "thumbnail${comic.id}",
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
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
                padding: EdgeInsets.fromLTRB(16, 0, 16, 32),
                child: Text(
                  comic.description,
                  style: TextStyle(fontSize: 16),
                ),
              )
            : Container(),
        comic.variantDescription != null && comic.variantDescription != ""
            ? Container(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 32),
                child: Text(
                  comic.variantDescription,
                  style: TextStyle(fontSize: 16),
                ),
              )
            : Container(),
      ],
    );
  }
}
