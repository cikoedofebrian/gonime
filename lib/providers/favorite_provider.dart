import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../utils/database.dart';
import '../models/home_anime.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FavoriteProvider extends ChangeNotifier {
  List<String> _favorites = [];
  // List<HomeAnime> _favorites_anime = [];
  List<String> get favorites {
    return _favorites;
  }

  // List<HomeAnime> get favorites_anime {
  //   return _favorites_anime;
  // }
  List<HomeAnime> _fav_anime = [];

  List<HomeAnime> get fav_anime {
    return _fav_anime;
  }

  // Future<void> fetchData() async {
  //   notifyListeners();
  // }

  Future<void> getDatabase() async {
    final database = await DatabaseHelper.database();
    final data = await database.query('favoritesanime');
    final mappeddata = data.map((e) => e['id'] as String).toList();
    _favorites = mappeddata;
    notifyListeners();
  }

  Future<void> getByList(List<String> favoritesdata) async {
    List<HomeAnime> list = [];
    for (var item in favoritesdata) {
      String url = "https://api.jikan.moe/v4/anime/$item";
      final response = await http.get(Uri.parse(url));
      final converted = HomeAnime.fromJson(jsonDecode(response.body)['data']);
      list.add(converted);
    }
    _fav_anime = list;
    notifyListeners();
  }

  Future<void> toggleFavorite(String id, bool favorite) async {
    final database = await DatabaseHelper.database();
    if (favorite) {
      _favorites.add(id);
      final url = "https://api.jikan.moe/v4/anime/$id";
      final response = await Dio().get(url);
      final anime = HomeAnime.fromJson(response.data["data"]);
      _fav_anime.add(anime);
      await database.rawInsert("INSERT INTO favoritesanime VALUES('$id')");
    } else {
      _favorites.removeWhere((element) => element == id);
      _fav_anime.removeWhere((element) => element.malId.toString() == id);
      await database.rawDelete("DELETE from favoritesanime WHERE id='$id'");
    }
    notifyListeners();
  }
}
