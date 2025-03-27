import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'users.db');
    print('Database path: $dbPath');

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        print("Creating table...");
        await db.execute('''
          CREATE TABLE credentials (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT NOT NULL,
            password TEXT NOT NULL
          )
        ''');
        print("Table Created");
      },
    );
  }

  Future<void> insertUser(String email, String password) async {
    final db = await database;
    print('Inserting user: $email, $password');
    await db.insert('credentials', {
      'email': email,
      'password': password,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
    print("User inserted successfully.");
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;
    print("Fetching all users from database...");
    return await db.query('credentials');
  }
}
