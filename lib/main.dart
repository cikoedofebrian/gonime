import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:gonime/providers/anime_provider.dart';
import 'package:gonime/providers/favorite_provider.dart';
import 'package:gonime/providers/search_provider.dart';
import 'package:gonime/screens/login.dart';
import 'package:gonime/screens/search_screen.dart';
import 'package:gonime/screens/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import './screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: ((context) => AnimeProvider())),
    ChangeNotifierProvider(create: ((context) => FavoriteProvider())),
    ChangeNotifierProvider(create: ((context) => SearchProvider()))
  ], child: const MyApp()));
}

// Future<void> initialize() async {
//   await Future.delayed(const Duration(seconds: 2));
// }
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(primary: Colors.black, secondary: Colors.grey[900]),
        fontFamily: GoogleFonts.josefinSans().fontFamily,
      ),
      home: StreamBuilder(
          builder: ((context, snapshot) {
            // if (snapshot.connectionState == ConnectionState.active) {
            //   return CircularProgressIndicator();
            // }
            if (snapshot.hasData) {
              return HomeScreen();
            }
            return AuthScreen();
          }),
          stream: FirebaseAuth.instance.authStateChanges()),
      routes: {
        '/search-screen': (context) => const SearchScreen(),
        '/register': (context) => RegisterScreen()
      },
    );
  }
}
