import 'package:flutter/material.dart';
import 'package:gonime/models/home_anime.dart';
import 'package:dio/dio.dart';
import 'package:gonime/models/search_anime.dart';

class SearchProvider extends ChangeNotifier {
  // bool _isSearch = false;
  // bool get isSearch {
  //   return _isSearch;
  // }

  String _title = '';
  String get title {
    return _title;
  }

  void title_removed() {
    _searchList = [];
    _title = '';
  }

  List<SearchModel> _searchList = [];
  List<SearchModel> get searchList {
    return _searchList;
  }

  void TriggerSearch(String title) {
    _title = title;
    notifyListeners();
  }

  Future<void> searchData() async {
    List<SearchModel> list = [];
    final url = "https://api.jikan.moe/v4/anime?q=$_title&limit=12";
    final response = await Dio().get(url);
    for (var item in response.data['data']) {
      final searchItem = SearchModel.fromJson(item);
      list.add(searchItem);
    }
    _searchList = list;
  }
}
