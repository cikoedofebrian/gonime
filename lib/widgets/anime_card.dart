import 'package:flutter/material.dart';

class AnimeCard extends StatelessWidget {
  const AnimeCard(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.id});
  final String title;
  final String imageUrl;
  final int id;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, '/anime-details', arguments: id),
      child: ClipRRect(
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
      ),
    );
  }
}
