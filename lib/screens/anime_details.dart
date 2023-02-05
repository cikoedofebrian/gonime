import 'package:flutter/material.dart';
import 'package:gonime/providers/anime_provider.dart';
import 'package:gonime/providers/favorite_provider.dart';
import 'package:gonime/widgets/custom_progress_indicator.dart';
import 'package:provider/provider.dart';

class AnimeDetails extends StatefulWidget {
  const AnimeDetails(
      {super.key,
      required this.id,
      // required this.favorite,
      required this.title});
  final String id;
  final String title;
  // final bool favorite;

  @override
  State<AnimeDetails> createState() => _AnimeDetailsState();
}

class _AnimeDetailsState extends State<AnimeDetails> {
  late Future future;
  late bool isfavorite;

  @override
  void initState() {
    isfavorite = Provider.of<FavoriteProvider>(context, listen: false)
        .favorites
        .contains(widget.id);
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
            ? const Center(child: CustomProgressIndicator(color: Colors.black))
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      child: Row(
                        children: [
                          Container(
                            height: 260,
                            width: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        NetworkImage(snapshot.data!.imageUrl))),
                          ),
                          SizedBox(
                            height: 260,
                            width: MediaQuery.of(context).size.width - 220,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                        // textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                        "Genres",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        snapshot.data!.genres.join(', '),
                                        style: TextStyle(color: Colors.white),
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
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          snapshot.data!.score != 0
                                              ? "${snapshot.data!.score.toString()} / 10"
                                              : "UNRATED",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 4),
                                          child: Icon(
                                            Icons.star_rounded,
                                            size: 24,
                                            color: Colors.green,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
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
          Provider.of<FavoriteProvider>(context, listen: false)
              .toggleFavorite(widget.id, !isfavorite);
          setState(() {
            isfavorite = !isfavorite;
          });
        },
        child: Icon(
          !isfavorite ? Icons.favorite_border : Icons.favorite,
          color: Colors.white,
        ),
      ),
    );
  }
}
