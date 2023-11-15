import 'package:intl/intl.dart';
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
        puskesmas TEXT)
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

  Future<String> getGender() async {
    var dbClient = await db;

    try {
      List<Map<String, dynamic>> result =
          await dbClient.query('contacts', columns: ['jenisKelamin']);

      if (result.isNotEmpty) {
        return result[0]['jenisKelamin'] as String;
      } else {
        return ''; // Nilai default jika data jenis kelamin tidak tersedia
      }
    } catch (e) {
      print('Error fetching gender: $e');
      return ''; // Nilai default jika terjadi kesalahan
    }
  }

  Future<int> getAgeMonths() async {
    var dbClient = await db;

    try {
      List<Map<String, dynamic>> result =
          await dbClient.query('contacts', columns: ['tanggal_lahir']);

      if (result.isNotEmpty) {
        String birthdate = result[0]['tanggal_lahir'] as String;
        DateTime birthDate = DateFormat('yyyy-MM-dd').parse(birthdate);
        DateTime currentDate = DateTime.now();

        // Menghitung selisih bulan
        int ageInMonths = (currentDate.year - birthDate.year) * 12 +
            (currentDate.month - birthDate.month);

        return ageInMonths;
      } else {
        return 0; // Umur default jika data tanggal lahir tidak tersedia
      }
    } catch (e) {
      print('Error parsing birthdate: $e');
      return 0; // Return nilai default jika parsing gagal
    }
  }
}
