import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          'This is searching page',
        ),
      ),
    );
  }
}
