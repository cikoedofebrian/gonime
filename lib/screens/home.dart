import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';
import '../providers/anime_provider.dart';
import 'package:gonime/widgets/favorite.dart';
import 'package:gonime/widgets/recommended.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  int _selectedPage = 0;
  static const List<Widget> _page = [
    Recommended(),
    FavoriteScreen(),
  ];

  late Future data;
  @override
  void initState() {
    super.initState();
    data = Future.wait([
      Provider.of<AnimeProvider>(context, listen: false).fetchData(),
      Provider.of<FavoriteProvider>(context, listen: false).getDatabase(),
    ]);
  }

  void _changePage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text('GoNime'),
        actions: [
          // IconButton(
          //     onPressed: (() =>
          //         Provider.of<AnimeProvider>(listen: false, context)
          //             .searchData()),
          //     icon: Icon(Icons.check)),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () => Navigator.pushNamed(context, '/search-screen'),
              icon: const Icon(
                Icons.search,
                size: 26,
              ),
            ),
          )
        ],
      ),
      body: FutureBuilder(
          future: data,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : _page[_selectedPage]),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          unselectedFontSize: 10,
          selectedFontSize: 10,
          currentIndex: _selectedPage,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favorite'),
          ],
          onTap: (value) => _changePage(value),
        ),
      ),
    );
  }
}
