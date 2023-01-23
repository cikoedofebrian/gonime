import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:gonime/models/anime.dart';

class AnimeDProvider extends ChangeNotifier {
  List<AnimeDProvider> _list = [];

  List<AnimeDProvider> get list {
    return list;
  }

  Future<AnimeModel> fetchDetails(String id) async {
    final url = "https://api.jikan.moe/v4/anime/$id/full";
    final response = await Dio().get(url);

    final anime = AnimeModel.fromJson(response.data["data"]);
    return anime;
  }
}
