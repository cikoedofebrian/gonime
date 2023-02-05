import 'package:flutter/material.dart';
import 'package:gonime/widgets/custom_progress_indicator.dart';
import '../providers/anime_provider.dart';
import '../providers/favorite_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/anime_card.dart';

class TopAnime extends StatefulWidget {
  const TopAnime({super.key});

  @override
  State<TopAnime> createState() => _TopAnimeState();
}

class _TopAnimeState extends State<TopAnime> {
  late Future future;
  @override
  void initState() {
    future = Provider.of<AnimeProvider>(context, listen: false).getTop();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favoritedata = Provider.of<FavoriteProvider>(context).favorites;
    return Scaffold(
        appBar: AppBar(title: Text('Top Anime')),
        body: FutureBuilder(
          future: future,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(child: CustomProgressIndicator(color: Colors.black))
                  : Column(
                      children: [
                        Expanded(
                          child: GridView.builder(
                              padding: const EdgeInsets.all(15),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 2 / 3,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10),
                              itemBuilder: (context, index) => AnimeCard(
                                  id: snapshot.data![index].malId,
                                  title: snapshot.data![index].title,
                                  imageUrl: snapshot.data![index].imageUrl,
                                  favorite: favoritedata.contains(
                                      snapshot.data![index].malId.toString())),
                              itemCount: snapshot.data!.length),
                        ),
                      ],
                    ),
        ));
  }
}
