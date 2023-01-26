import 'package:flutter/material.dart';
import 'package:gonime/providers/anime_provider.dart';
import '../providers/favorite_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/anime_card.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final favoritedata = Provider.of<FavoriteProvider>(context);
    final animedata =
        Provider.of<AnimeProvider>(context).getByList(favoritedata.favorites);
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
            favorite: true),
        itemCount: animedata.length);
  }
}
