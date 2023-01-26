import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'gonime.db'),
      onCreate: (db, version) =>
          db.execute('CREATE TABLE favoritesanime(id TEXT PRIMARY KEY)'),
      version: 1,
    );
  }
}
