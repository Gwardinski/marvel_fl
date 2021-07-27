import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marvel_heroes/models/comics.dart';
import 'package:marvel_heroes/pages/comic/comic_page.dart';
import 'package:provider/provider.dart';
import 'package:marvel_heroes/services/comic_state.dart';

class ReadingListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final comicState = Provider.of<ComicState>(context);
    final comicsList = comicState.comicsList;
    return Scaffold(
      appBar: AppBar(
        title: Text("Reading List"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 32,
        childAspectRatio: 0.7,
        children: comicsList
            .map((c) => SavedComicListItem(
                  comic: comicState.getComic(c),
                ))
            .toList(),
      ),
    );
  }
}

class SavedComicListItem extends StatelessWidget {
  const SavedComicListItem({
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
      child: CachedNetworkImage(
        imageUrl: comic.thumbnail,
        placeholder: (c, s) => Center(child: CircularProgressIndicator()),
        // errorWidget: (c, i, b) => Center(
        //   child: Padding(
        //     padding: EdgeInsets.all(8.0),
        //     child: Text(
        //       comic.title,
        //       textAlign: TextAlign.center,
        //       style: TextStyle(fontSize: 18),
        //     ),
        //   ),
        // ),
        // imageBuilder: (context, imageProvider) => Hero(
        //   tag: "thumbnail${comic.id}",
        //   child: Container(
        //     decoration: BoxDecoration(
        //       image: DecorationImage(
        //         image: imageProvider,
        //         fit: BoxFit.cover,
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
