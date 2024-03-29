import 'package:flutter/material.dart';
import 'package:marvel_heroes/pages/characters/characters_page.dart';
import 'package:marvel_heroes/services/http.dart';
import 'package:marvel_heroes/services/local_storage_service.dart';
import 'package:marvel_heroes/services/marvel_service.dart';
import 'package:marvel_heroes/services/comic_state.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(InitialiserWidget());
}

const Color MarvelRed = Color.fromRGBO(230, 36, 41, 1);

class InitialiserWidget extends StatelessWidget {
  _init() async {
    final localStorageService = LocalStorageService();
    await localStorageService.init();
    return localStorageService;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final HttpService http = HttpService();
          final ComicState comicState = ComicState(
            localStorageService: snapshot.data,
          );
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<ComicState>(
                create: (BuildContext context) => comicState,
              ),
              Provider<MarvelService>(
                create: (BuildContext context) => MarvelService(
                  http: http,
                ),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData.dark().copyWith(
                accentColor: Colors.red,
                appBarTheme: AppBarTheme(
                  backgroundColor: MarvelRed,
                ),
                primaryColor: MarvelRed,
              ),
              home: CharactersListPage(),
              // TODO bottom tab bar
              // tab for characters, tab for ReadingList
              // give each tab it's own seperate navigation history using navigationKey / create navigationService
            ),
          );
        }
        return LoadingImage();
      },
    );
  }
}

class LoadingImage extends StatelessWidget {
  const LoadingImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Image.asset("assets/marvel.png"),
      ),
    );
  }
}
