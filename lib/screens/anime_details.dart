import 'package:flutter/material.dart';
import 'package:gonime/providers/anime_details_provider.dart';
import 'package:provider/provider.dart';

class AnimeDetails extends StatefulWidget {
  const AnimeDetails({super.key});

  @override
  State<AnimeDetails> createState() => _AnimeDetailsState();
}

class _AnimeDetailsState extends State<AnimeDetails> {
  void _FavoriteToggler() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    final String argument =
        (ModalRoute.of(context)!.settings.arguments as int).toString();
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: Provider.of<AnimeDProvider>(context).fetchDetails(argument),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 300,
                          width: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      NetworkImage(snapshot.data!.imageUrl))),
                        ),
                        SizedBox(
                          height: 300,
                          width: MediaQuery.of(context).size.width - 200,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Title :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  snapshot.data!.title,
                                  style: TextStyle(fontSize: 18),
                                  // textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Genres",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  snapshot.data!.genres.join(', '),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Status",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  snapshot.data!.status,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Sypnosis",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(snapshot.data!.synopsis),
                            ]))
                  ],
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          isFavorite ? Icons.favorite_border : Icons.favorite,
          color: Colors.white,
        ),
      ),
    );
  }
}
