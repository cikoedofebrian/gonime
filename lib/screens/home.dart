import 'package:flutter/material.dart';
import 'package:gonime/models/favorite.dart';
import 'package:gonime/providers/favorite_provider.dart';
import 'package:gonime/utils/database.dart';
import 'package:provider/provider.dart';
import '../providers/anime_provider.dart';
import '../widgets/anime_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GoNime'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[900],
      body: FutureBuilder(
        builder: (context, snapshot) {
          final favoritedata = Provider.of<FavoriteProvider>(context).favorites;
          final animedata = Provider.of<AnimeProvider>(context).animes;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return GridView.builder(
              padding: const EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10),
              itemBuilder: (context, index) => AnimeCard(
                  id: animedata[index].malId,
                  title: animedata[index].title,
                  imageUrl: animedata[index].imageUrl,
                  favorite:
                      favoritedata.contains(animedata[index].malId.toString())),
              itemCount: animedata.length);
        },
        future: Future.wait([
          Provider.of<AnimeProvider>(context).fetchData(),
          Provider.of<FavoriteProvider>(context, listen: false).getDatabase(),
        ]),
      ),
    );
  }
}
