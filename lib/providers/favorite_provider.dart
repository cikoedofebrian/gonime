import 'package:flutter/material.dart';
import '../utils/database.dart';
import '../models/home_anime.dart';
import 'package:dio/dio.dart';

class FavoriteProvider extends ChangeNotifier {
  List<String> _favorites = [];
  List<HomeAnime> _favorites_anime = [];
  List<String> get favorites {
    return _favorites;
  }

  void fetchData() async {
    List<HomeAnime> templist = [];
    final dio = Dio();
    for (var item in _favorites) {
      final url = "https://api.jikan.moe/v4/anime/$item";
      final response = await dio.get(url);
      // print(response.data);
      final data = HomeAnime.fromJson(response.data);
      templist.add(data);
      Future.delayed(const Duration(milliseconds: 500));
      // HomeAnime.fromJson(response.data);
    }
    _favorites_anime = templist;
    notifyListeners();
  }

  Future<void> getDatabase() async {
    final database = await DatabaseHelper.database();
    final data = await database.query('favoritesanime');
    final mappeddata = data.map((e) => e['id'] as String).toList();
    _favorites = mappeddata;
    notifyListeners();
  }

  Future<void> toggleFavorite(String id, bool favorite) async {
    final database = await DatabaseHelper.database();
    if (favorite) {
      _favorites.add(id);
      await database.rawInsert("INSERT INTO favoritesanime VALUES('$id')");
    } else {
      _favorites.removeWhere((element) => element == id);
      await database.rawDelete("DELETE from favoritesanime WHERE id='$id'");
    }
    notifyListeners();
  }
}
