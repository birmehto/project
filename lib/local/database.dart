import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  final String tableName = 'items';
  final String columnId = 'id';
  final String columnName = 'name';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'items.db');

    return await openDatabase(databasePath, version: 1,
        onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnName TEXT)',
      );
    });
  }

  Future<int> insertItem(String name) async {
    final db = await database;
    return await db.insert(tableName, {columnName: name});
  }

  Future<List<Map<String, dynamic>>> getItems() async {
    final db = await database;
    return await db.query(tableName);
  }

  Future<int> deleteItem(int id) async {
    final db = await database;
    return await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
