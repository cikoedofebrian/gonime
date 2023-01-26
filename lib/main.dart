import 'package:flutter/material.dart';
import 'package:gonime/providers/anime_provider.dart';
import 'package:gonime/providers/favorite_provider.dart';
import 'package:gonime/providers/search_provider.dart';
import 'package:gonime/screens/search_screen.dart';

import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import './screens/home.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: ((context) => AnimeProvider())),
    ChangeNotifierProvider(create: ((context) => FavoriteProvider())),
    ChangeNotifierProvider(create: ((context) => SearchProvider()))
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(primary: Colors.black, secondary: Colors.grey[900]),
        fontFamily: GoogleFonts.montserrat().fontFamily,
      ),
      home: const HomeScreen(),
      routes: {
        '/search-screen': (context) => const SearchScreen(),
      },
    );
  }
}
