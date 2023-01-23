import 'package:flutter/material.dart';
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
          final animedata = Provider.of<AnimeProvider>(context).animes;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // margin: const EdgeInsets.all(15.0),
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
                  imageUrl: animedata[index].imageUrl),
              itemCount: animedata.length);
        },
        future: Provider.of<AnimeProvider>(context).fetchData(),
      ),
    );
  }
}
