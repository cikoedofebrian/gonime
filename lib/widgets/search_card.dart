import 'package:flutter/material.dart';
import '../screens/anime_details.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.id,
  });

  final String title;
  final int id;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => AnimeDetails(
                title: title,
                id: id.toString(),
              )),
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            height: 200,
            width: double.infinity,
            child: Row(
              children: [
                SizedBox(
                  width: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(imageUrl),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(children: [
                          Row(
                            children: [
                              Flexible(
                                  child: Text(
                                title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ))
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                        ]),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            children: const [
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.blueAccent,
                              ),
                              Text(
                                'See details',
                                style: TextStyle(color: Colors.blueAccent),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.grey)
        ],
      ),
    );
  }
}
