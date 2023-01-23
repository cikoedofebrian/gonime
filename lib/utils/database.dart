import 'package:sqflite/sqflite.dart';
import '../models/favorite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'gonime.db'),
      onCreate: (db, version) => db
          .execute('CREATE TABLE notes(id TEXT PRIMARY KEY, bool isfavorite)'),
      version: 1,
    );
  }
}
