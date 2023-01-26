import 'package:flutter/material.dart';
import 'package:gonime/providers/anime_details_provider.dart';
import 'package:gonime/providers/anime_provider.dart';
import 'package:gonime/providers/favorite_provider.dart';
import './widgets/favorite.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(primary: Colors.black, secondary: Colors.grey[900]),
        fontFamily: GoogleFonts.montserrat().fontFamily,
      ),
      home: const HomeScreen(),
      // routes: {
      //   '/favorite-screen': (context) => const FavoriteScreen(),
      // },
    );
  }
}
