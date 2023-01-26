import 'package:flutter/material.dart';
import 'package:gonime/models/home_anime.dart';
import 'package:dio/dio.dart';

class SearchProvider extends ChangeNotifier {
  bool _isSearch = false;
  bool get isSearch {
    return _isSearch;
  }

  String _title = '';
  // set title(String title) {
  //   _title = title;
  // }

  List<HomeAnime> _searchList = [];
  List<HomeAnime> get searchList {
    return _searchList;
  }

  void TriggerSearch(String title) {
    _title = title;
    _isSearch = !_isSearch;
    notifyListeners();
  }

  Future<void> searchData() async {
    List<HomeAnime> list = [];
    final url = "https://api.jikan.moe/v4/anime?q=$_title&limit=12";
    final response = await Dio().get(url);
    for (var item in response.data['data']) {
      list.add(HomeAnime.fromJson(item));
    }
    _searchList = list;
    _isSearch = false;
  }
}
