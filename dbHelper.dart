import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();
  static Database? _database;


  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB('Elec2.db');
      return _database!;
    }
  }


  Future<Database> _initDB(String fileName) async {
    String path = join(await getDatabasesPath(), fileName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
    );
  }


  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
     CREATE TABLE IF NOT EXISTS users (
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       firstName TEXT,
       middleName TEXT,
       lastName TEXT,
       email TEXT UNIQUE,
       password TEXT
     )
   ''');
  }


  Future<int> insertUser(
      String firstName,
      String middleName,
      String lastName,
      String email,
      String password,
      ) async {
    final db = await database;
    try {
      return await db.insert(
        'users',
        {
          'firstName': firstName,
          'middleName': middleName,
          'lastName': lastName,
          'email': email,
          'password': password,
        },
      );
    } catch (e) {
      return -1;
    }
  }


  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.rawQuery("SELECT * FROM users");
  }


  Future<int> updateUser(
      String firstName,
      String middleName,
      String lastName,
      String email,
      String password,
      int id,
      ) async {
    final db = await database;
    return await db.rawUpdate(
      "UPDATE users SET firstName = ?, middleName = ?, lastName = ?, email = ?, password = ? WHERE id = ?",
      [firstName, middleName, lastName, email, password, id],
    );
  }


  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.rawDelete(
      "DELETE FROM users WHERE id = ?",
      [id],
    );
  }


  Future<List<Map<String, Object?>>> loginUser(
      String email,
      String password,
      ) async {
    final db = await database;
    return await db.rawQuery(
      "SELECT * FROM users WHERE email = ? AND password = ?",
      [email, password],
    );
  }
}

