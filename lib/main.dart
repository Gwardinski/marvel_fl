import 'package:flutter/material.dart';
import 'package:marvel_heroes/pages/characters/characters_page.dart';
import 'package:marvel_heroes/services/http.dart';
import 'package:marvel_heroes/services/local_storage_service.dart';
import 'package:marvel_heroes/services/marvel_service.dart';
import 'package:marvel_heroes/services/user_state.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(InitialiserWidget());
}

class InitialiserWidget extends StatelessWidget {
  _init() async {
    final localStorageService = LocalStorageService();
    await localStorageService.init();
    return localStorageService;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(accentColor: Colors.red),
      home: FutureBuilder(
        future: _init(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ProviderWrapper(
              localStorageService: snapshot.data,
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

class ProviderWrapper extends StatelessWidget {
  final LocalStorageService localStorageService;

  ProviderWrapper({
    this.localStorageService,
  });

  @override
  Widget build(BuildContext context) {
    final HttpService http = HttpService();
    final UserState userState = UserState(
      localStorageService: localStorageService,
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserState>(
          create: (BuildContext context) => userState,
        ),
        Provider<MarvelService>(
          create: (BuildContext context) => MarvelService(
            http: http,
          ),
        ),
      ],
      child: CharactersListPage(),
    );
  }
}
