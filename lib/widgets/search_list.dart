import 'package:flutter/material.dart';
import 'package:gonime/providers/search_provider.dart';
import 'package:gonime/widgets/search_card.dart';
import 'package:provider/provider.dart';
import '../models/search_anime.dart';

class SearchList extends StatefulWidget {
  const SearchList({super.key});

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  String title = '';

  @override
  Widget build(BuildContext context) {
    final search = Provider.of<SearchProvider>(context);
    if (search.title != title) {
      title = search.title;
      return FutureBuilder(
        future: search.searchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (search.searchList.isEmpty) {
            return const Center(
              child: Text('Nothing found.'),
            );
          }

          return Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: const Text('RESULTS'),
              ),
              Expanded(
                child: ListView.builder(
                    itemBuilder: ((context, index) => SearchCard(
                        // score: search.searchList[index].score,
                        score: search.searchList[index].score,
                        title: search.searchList[index].title,
                        imageUrl: search.searchList[index].imageUrl,
                        id: search.searchList[index].malId)),
                    itemCount: search.searchList.length),
              ),
            ],
          );
        },
      );
    } else {
      return Container();
    }
  }
}
