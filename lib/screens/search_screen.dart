import 'package:flutter/material.dart';
import 'package:gonime/widgets/search.dart';
import 'package:gonime/widgets/search_list.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
          appBar: AppBar(
            title: Text('Search'),
            centerTitle: true,
            backgroundColor: Colors.black,
          ),
          body: Column(
            children: [SearchForm(), Expanded(child: SearchList())],
          )),
    );
  }
}
