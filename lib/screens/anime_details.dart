import 'package:flutter/material.dart';
import 'package:gonime/providers/anime_provider.dart';
import 'package:gonime/providers/favorite_provider.dart';
import 'package:provider/provider.dart';

class AnimeDetails extends StatefulWidget {
  const AnimeDetails(
      {super.key,
      required this.id,
      required this.favorite,
      required this.title});
  final String id;
  final String title;
  final bool favorite;

  @override
  State<AnimeDetails> createState() => _AnimeDetailsState();
}

class _AnimeDetailsState extends State<AnimeDetails> {
  late Future future;
  late bool isfavorite;

  @override
  void initState() {
    isfavorite = widget.favorite;
    future = Provider.of<AnimeProvider>(context, listen: false)
        .fetchDetails(widget.id);
    super.initState();
  }

  void favoriteToggler() {
    setState(() {
      isfavorite = !isfavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.check))],
      ),
      body: FutureBuilder(
        future: future,
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
        onPressed: () {
          setState(() {
            isfavorite = !isfavorite;
          });
          Provider.of<FavoriteProvider>(context, listen: false)
              .toggleFavorite(widget.id, !isfavorite);
        },
        child: Icon(
          !isfavorite ? Icons.favorite_border : Icons.favorite,
          color: Colors.white,
        ),
      ),
    );
  }
}
