import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news/providers/news_provider.dart';
import 'package:news/views/main_board_view.dart';
import 'package:news/views/news_viewer.dart';
import 'package:news/views/search_view.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => NewsProvider()),
      ],
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: 'News',
          theme: ThemeData(
            canvasColor: Colors.black,
            fontFamily: 'Poppins',
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF000000),
              secondary: Colors.red
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: const MainBoard(),
          routes: {
            SearchView.routeName: (context) => const SearchView(),
            NewsView.routeName: (context) => const NewsView(),
          },
        );
      },
    );
  }
}