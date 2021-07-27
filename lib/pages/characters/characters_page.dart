import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:marvel_heroes/models/character.dart';
import 'package:marvel_heroes/pages/reading_list/reading_list_page.dart';
import 'package:marvel_heroes/services/http.dart';
import 'package:marvel_heroes/shared/character_list_item.dart';
import 'package:marvel_heroes/services/marvel_service.dart';
import 'package:provider/provider.dart';

class CharactersListPage extends StatefulWidget {
  @override
  _CharactersListPageState createState() => _CharactersListPageState();
}

class _CharactersListPageState extends State<CharactersListPage> {
  static const _pageSize = 20;

  MarvelService _service;
  final PagingController<int, Character> _controller = PagingController(firstPageKey: 0);

  @override
  void initState() {
    _service = Provider.of<MarvelService>(context, listen: false);
    _controller.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    // TODO add pull to refresh
    try {
      final res = await _service.getCharacters(pageKey);
      final newItems = res.results;
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _controller.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _controller.appendPage(newItems, nextPageKey);
      }
    } on OfflineException {
      // TODO default message says 'unknown error'
      // update to specifically mention being offline
      final snackBar = SnackBar(content: Text('Please go online to continue'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      _controller.error = '';
    } catch (error) {
      _controller.error = error;
    }
  }

  Future<void> _navigateToReadingPage(context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ReadingListPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Marvel Heroes"),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () => _navigateToReadingPage(context),
          )
        ],
        // TODO remove after creating bottom tabs
      ),
      body: PagedListView<int, Character>(
        pagingController: _controller,
        builderDelegate: PagedChildBuilderDelegate<Character>(
          itemBuilder: (context, item, index) => CharacterListItem(
            character: item,
          ),
        ),
      ),
    );
  }
}
