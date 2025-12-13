import 'package:mis_lab2/database/favorites_local_db.dart';
import 'package:sqflite/sqflite.dart';

class FavoritesLocalRepository {
  final dbProvider = FavoritesLocalDB.instance;

  Future<void> addFavorite(int mealId) async {
    final db = await dbProvider.database;
    await db.insert(
        'favorites',
        {
          'mealId': mealId,
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeFavorite(int mealId) async {
    final db = await dbProvider.database;
    await db.delete('favorites', where: 'mealId = ?', whereArgs: [mealId]);
  }

  Future<List<int>> getFavorites() async {
    final db = await dbProvider.database;
    final result = await db.query('favorites');
    return result.map((row) => row['mealId'] as int).toList();
  }

  Future<bool> isFavorite(int mealId) async {
    final db = await dbProvider.database;
    final result = await db.query(
      'favorites',
      where: 'mealId = ?',
      whereArgs: [mealId],
      limit: 1,
    );
    return result.isNotEmpty;
  }
}
