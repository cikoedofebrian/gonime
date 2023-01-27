import 'package:flutter/material.dart';
import 'package:gonime/models/home_anime.dart';
import '../models/anime.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert';

class AnimeProvider extends ChangeNotifier {
  List<HomeAnime> _animes = [];
  final _dio = Dio();

  List<HomeAnime> get animes {
    return _animes;
  }

  // List<HomeAnime> _fav_anime = [];

  // List<HomeAnime> get fav_anime {
  //   return _fav_anime;
  // }

  Future<void> fetchData() async {
    List<HomeAnime> temp = [];
    const url = "https://api.jikan.moe/v4/recommendations/anime";
    Response userData = await _dio.get(url);
    for (var data in userData.data['data']) {
      for (var anime in data['entry']) {
        HomeAnime animedata = HomeAnime.fromJson(anime);
        temp.add(animedata);
      }
    }
    _animes = temp;
  }

  // Future<void> getByList(List<String> favorites) async {
  //   List<HomeAnime> list = [];
  //   for (var item in favorites) {
  //     String url = "https://api.jikan.moe/v4/anime/$item";
  //     final response = await http.get(Uri.parse(url));
  //     final converted = HomeAnime.fromJson(jsonDecode(response.body)['data']);
  //     list.add(converted);
  //   }
  //   _fav_anime = list;
  //   notifyListeners();
  // }

  Future<AnimeModel> fetchDetails(String id) async {
    final url = "https://api.jikan.moe/v4/anime/$id/full";
    final response = await Dio().get(url);

    final anime = AnimeModel.fromJson(response.data["data"]);
    return anime;
  }
}
