import 'package:flutter/material.dart';
import 'package:gonime/providers/favorite_provider.dart';
import 'package:gonime/screens/anime_details.dart';
import 'package:provider/provider.dart';

class AnimeCard extends StatelessWidget {
  const AnimeCard(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.id,
      required this.favorite});
  final String title;
  final String imageUrl;
  final int id;
  final bool favorite;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => AnimeDetails(
                title: title,
                id: id.toString(),
                // favorite: favorite,
              )),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(children: [
          Expanded(
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imageUrl),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.5),
                  child: IconButton(
                    onPressed: () {
                      Provider.of<FavoriteProvider>(context, listen: false)
                          .toggleFavorite(id.toString(), !favorite);
                    },
                    icon: Icon(
                      favorite ? Icons.favorite : Icons.favorite_border,
                    ),
                  ),
                ),
              ),
            ]),
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
      ),
    );
  }
}
