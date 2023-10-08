import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'user_data.dart'; // Mengimpor model UserData

class DatabaseHelper {
  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'userdata.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE userdata(name TEXT, tanggalLahir TEXT, wilayah TEXT)",
        );
      },
    );
  }

  Future<int> insertUserdata(UserData userdata) async {
    int result = 0;
    final Database db = await initializedDB();

    // Hapus data yang ada sebelum menambah yang baru
    await deleteUserdata();

    String formattedDate =
        DateFormat('yyyy-MM-dd').format(userdata.tanggalLahir);

    Map<String, dynamic> data = {
      'name': userdata.name,
      'tanggalLahir': formattedDate, // Simpan sebagai teks
    };

    result = await db.insert('userdata', data);
    return result;
  }

  Future<UserData?> retrieveUserdata() async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult = await db.query('userdata');
    if (queryResult.isNotEmpty) {
      return UserData.fromMap(queryResult.first);
    } else {
      return null;
    }
  }

  Future<void> deleteUserdata() async {
    final Database db = await initializedDB();
    await db.delete('userdata');
  }
}
