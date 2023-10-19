import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:srisuntari_mobileapp/models/quiz_result.dart';

import 'user_data.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  DatabaseHelper.internal();

  Future<Database> initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'contacts.db');

    var db = await openDatabase(path,
        version: 2, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE contacts 
        (id INTEGER PRIMARY KEY,
        nama TEXT, 
        tanggal_lahir TEXT,
        jenisKelamin TEXT,
        puskesmas TEXT,)
    ''');

    await db.execute('''
        CREATE TABLE quiz_results 
        (id INTEGER PRIMARY KEY,
        score INTEGER,
        date TEXT)
    ''');
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion < 2) {
      // Jika versi sebelumnya kurang dari 2, tambahkan tabel quiz_results
      db.execute('''
        CREATE TABLE quiz_results 
        (id INTEGER PRIMARY KEY,
        score INTEGER,
        date TEXT)
    ''');
    }
  }

  Future<int> saveContact(UserData contact) async {
    var dbClient = await db;
    await dbClient.delete('contacts', where: '1=1');
    int id = await dbClient.insert('contacts', contact.toMap());
    return id;
  }

  Future<List<UserData>> getAllContacts() async {
    var dbClient = await db;
    List<Map<String, dynamic>> maps = await dbClient.query('contacts');
    return maps.map((map) => UserData.fromMap(map)).toList();
  }

  Future<int> saveQuizResult(QuizResult quizResult) async {
    var dbClient = await db;
    int id = await dbClient.insert('quiz_results', quizResult.toMap());
    return id;
  }

  Future<List<QuizResult>> getAllQuizResults() async {
    var dbClient = await db;
    List<Map<String, dynamic>> maps = await dbClient.query('quiz_results');
    return maps.map((map) => QuizResult.fromMap(map)).toList();
  }
}
