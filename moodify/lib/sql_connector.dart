import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'vars.dart';

class DatabaseHelper {
  // Singleton pattern for the database helper
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  late Database _database;

  Future<void> initializeDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'measurements.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE measurements(id TEXT PRIMARY KEY, value REAL, timestamp TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertDataModel(DataModel dataModel) async {
    await _database.insert(
      'measurements',
      dataModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DataModel>> allDataModel() async {
    final List<Map<String, dynamic>> maps =
        await _database.query('measurements');

    return List.generate(maps.length, (i) {
      return DataModel(
        id: maps[i]['id'],
        timestamp: maps[i]['timestamp'],
        value: maps[i]['value'],
      );
    });
  }

  Future<void> updateDataModel(DataModel dataModel) async {
    await _database.update(
      'measurements',
      dataModel.toMap(),
      where: 'id = ?',
      whereArgs: [dataModel.id],
    );
  }

  Future<void> deleteDataModel(int id) async {
    await _database.delete(
      'measurements',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllDataModels() async {
    await _database.delete('measurements');
  }
}
