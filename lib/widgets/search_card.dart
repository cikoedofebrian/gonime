import 'package:flutter/material.dart';
import '../screens/anime_details.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SearchCard extends StatelessWidget {
  const SearchCard(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.id,
      required this.score});

  final String title;
  final double score;
  final int id;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [FadeEffect()],
      child: InkWell(
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
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              padding: EdgeInsets.all(10),
              height: 180,
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    width: 120,
                    height: 180,

                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          imageUrl,
                        ),
                      ),
                    ),
                    // child: Image.network(imageUrl),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(children: [
                            Row(
                              children: [
                                Flexible(
                                    child: Text(
                                  title,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.fade,
                                      fontSize: title.length < 20 ? 30 : 22),
                                ))
                              ],
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                          ]),
                          Row(
                            textDirection: TextDirection.rtl,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Icon(
                                  Icons.star_rate_rounded,
                                  color: Colors.green,
                                  size: 30,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                score != 0.0 ? '$score / 10' : "UNRATED",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
