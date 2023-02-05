import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/database.dart';
import '../models/home_anime.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteProvider extends ChangeNotifier {
  List<String> _favorites = [];
  List<String> get favorites {
    return _favorites;
  }

  List<HomeAnime> _fav_anime = [];

  List<HomeAnime> get fav_anime {
    return _fav_anime.reversed.toList();
  }

  void reverseList() {
    _fav_anime = _fav_anime.reversed.toList();
    notifyListeners();
  }

  Future<void> getDatabase() async {
    List<HomeAnime> list = [];
    List<String> fav_list = [];
    final user = FirebaseAuth.instance.currentUser!.uid;
    final favoritedata = await FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .collection('favorites')
        .get();
    favoritedata.docs.forEach((element) {
      fav_list.add(element['malId'].toString());
      final HomeAnime anime = HomeAnime(
          imageUrl: element['imageUrl'] ?? '',
          malId: element['malId'] ?? '',
          title: element['title'] ?? '');

      list.add(anime);
    });
    _favorites = fav_list;
    _fav_anime = list;
    notifyListeners();
  }

  Future<void> toggleFavorite(String id, bool favorite) async {
    final database = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('favorites');
    if (favorite) {
      _favorites.add(id);
      final url = "https://api.jikan.moe/v4/anime/$id";
      final response = await Dio().get(url);
      final anime = HomeAnime.fromJson(response.data["data"]);
      _fav_anime.add(anime);
      await database.doc(id).set({
        'malId': anime.malId,
        'title': anime.title,
        'imageUrl': anime.imageUrl
      });
    } else {
      _favorites.removeWhere((element) => element == id);
      _fav_anime.removeWhere((element) => element.malId.toString() == id);
      await database.doc(id).delete();
    }
    notifyListeners();
  }
}
