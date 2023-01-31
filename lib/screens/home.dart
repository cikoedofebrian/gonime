import 'package:flutter/material.dart';
import 'package:gonime/providers/search_provider.dart';
import 'package:gonime/widgets/drawer.dart';
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
      Provider.of<FavoriteProvider>(context, listen: false)
          .getDatabase()
          .whenComplete(
            () => Provider.of<FavoriteProvider>(context, listen: false)
                .getByList(Provider.of<FavoriteProvider>(context, listen: false)
                    .favorites),
          ),
      Provider.of<AnimeProvider>(context, listen: false).fetchData(),
    ]);
  }

  void _changePage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: _selectedPage == 1
            ? FloatingActionButton(
                backgroundColor: Colors.red,
                onPressed: Provider.of<FavoriteProvider>(context, listen: false)
                    .reverseList,
                child: Icon(Icons.sort),
              )
            : null,
        drawer: AppDrawer(),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: const Text('GoNime'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                onPressed: () => Navigator.pushNamed(context, '/search-screen')
                    .then((value) =>
                        Provider.of<SearchProvider>(context, listen: false)
                            .title_removed()),
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
      ),
    );
  }
}
