import 'package:flutter/material.dart';
import '../providers/favorite_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/anime_card.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  // late Future future1;
  // late Future future2;

  // @override
  // void initState() {

  //   future2 = Provider.of<FavoriteProvider>(context, listen: false).fetchData();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              print(Provider.of<FavoriteProvider>(context, listen: false)
                  .favorites_anime
                  .length);
            },
            icon: Icon(Icons.abc))
      ]),
      backgroundColor: Colors.grey[900],
      body: FutureBuilder(
        builder: (context, snapshot) {
          final favoritedata =
              Provider.of<FavoriteProvider>(context, listen: false).favorites;
          final animedata =
              Provider.of<FavoriteProvider>(context, listen: false)
                  .favorites_anime;
          // final animedata = Provider.of<AnimeProvider>(context).animes;
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
        future: Provider.of<FavoriteProvider>(context).getDatabase(),
      ),
    );
  }
}
