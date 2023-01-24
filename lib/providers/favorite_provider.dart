import 'package:flutter/material.dart';
import '../utils/database.dart';

class FavoriteProvider extends ChangeNotifier {
  List<String> _favorites = [];
  List<String> get favorites {
    return _favorites;
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
