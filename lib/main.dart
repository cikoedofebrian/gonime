import 'package:flutter/material.dart';
import 'package:gonime/providers/anime_provider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: ((context) => AnimeProvider()))
  ], child: MyApp()));
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
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.montserrat().fontFamily,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final dio = Dio();

    // void getData() async {
    //   const url = "https://api.jikan.moe/v4/recommensdations/anime";
    //   Response userData = await dio.get(url);
    //   print(userData.data["data"]);
    //   for (var i in userData.data["data"]) {
    //     print(i);
    //   }
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text('GoNime'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: GridView.builder(
      //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //           crossAxisCount: 2, childAspectRatio: 2 / 3),
      //       itemBuilder: (context, index) => AnimeCard(),
      //       itemCount: 10),
      // ),
      backgroundColor: Colors.grey[900],
      body: FutureBuilder(
        builder: (context, snapshot) {
          final animedata = Provider.of<AnimeProvider>(context).animes;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          // margin: const EdgeInsets.all(15.0),
          return GridView.builder(
              padding: EdgeInsets.all(15),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10),
              itemBuilder: (context, index) => AnimeCard(
                  title: animedata[index].title,
                  imageUrl: animedata[index].imageUrl),
              itemCount: animedata.length);
        },
        future: Provider.of<AnimeProvider>(context).fetchData(),
      ),
    );
  }
}

class AnimeCard extends StatelessWidget {
  const AnimeCard({super.key, required this.title, required this.imageUrl});
  final String title;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Column(children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imageUrl),
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          color: Colors.black,
          alignment: Alignment.center,
          height: 50,
          child: Text(
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            title,
            style: const TextStyle(color: Colors.white),
          ),
        )
      ]),
    );
  }
}
