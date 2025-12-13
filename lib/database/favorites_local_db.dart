import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FavoritesLocalDB {
  static final FavoritesLocalDB instance = FavoritesLocalDB._init();
  static Database? _database;

  FavoritesLocalDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('favorites.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorites (
        mealId INTEGER PRIMARY KEY
      )
    ''');
  }
}
