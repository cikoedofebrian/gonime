import 'package:flutter/material.dart';
import 'package:gonime/models/anime.dart';
import 'package:gonime/providers/anime_details_provider.dart';
import 'package:gonime/providers/anime_provider.dart';
import 'package:gonime/providers/favorite_provider.dart';
import 'package:gonime/screens/anime_details.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import './screens/home.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: ((context) => AnimeProvider())),
    ChangeNotifierProvider(create: ((context) => AnimeDProvider())),
    ChangeNotifierProvider(create: ((context) => FavoriteProvider()))
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(primary: Colors.black, secondary: Colors.grey[900]),
        fontFamily: GoogleFonts.montserrat().fontFamily,
      ),
      home: const HomeScreen(),
    );
  }
}
