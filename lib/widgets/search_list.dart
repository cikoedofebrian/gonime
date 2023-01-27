import 'package:flutter/material.dart';
import 'package:gonime/providers/search_provider.dart';
import 'package:gonime/widgets/search_card.dart';
import 'package:provider/provider.dart';

class SearchList extends StatelessWidget {
  const SearchList({super.key});

  @override
  Widget build(BuildContext context) {
    final search = Provider.of<SearchProvider>(context);
    if (search.isSearch) {
      return FutureBuilder(
        future: search.searchData(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: const Text('Results'),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemBuilder: ((context, index) => SearchCard(
                                title: search.searchList[index].title,
                                imageUrl: search.searchList[index].imageUrl,
                                id: search.searchList[index].malId)),
                            itemCount: search.searchList.length),
                      ),
                    ],
                  ),
      );
    } else {
      return Center(
        child: Text('real'),
      );
    }
    ;
  }
}
