import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('results.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final path = join(await getDatabasesPath(), filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE results (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        subject TEXT,
        marks INTEGER,
        creditHours INTEGER,
        grade TEXT,
        gradePoints REAL
      )
    ''');
  }

  Future<int> insertResult(Map<String, dynamic> result) async {
    final db = await instance.database;
    return await db.insert('results', result);
  }

  Future<List<Map<String, dynamic>>> getResults() async {
    final db = await instance.database;
    return await db.query('results');
  }
}
