import 'package:intl/intl.dart';

class UserData {
  int? id;
  String nama;
  DateTime? tanggalLahir;
  String? jenisKelamin;
  String? puskesmas;
  int? nilai;

  UserData({
    this.id,
    required this.nama,
    this.tanggalLahir,
    this.jenisKelamin,
    this.puskesmas,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'tanggal_lahir': tanggalLahir?.toIso8601String(),
      'jenisKelamin': jenisKelamin,
      'puskesmas': puskesmas,
    };
  }

  static const String dateFormat = 'yyyy-MM-dd';

  static UserData fromMap(Map<String, dynamic> map) {
    try {
      final dateFormatter = DateFormat(dateFormat);
      final dateFormatted = dateFormatter.parse(map['tanggal_lahir']);

      return UserData(
        id: map['id'],
        nama: map['nama'],
        tanggalLahir: dateFormatted,
        jenisKelamin: map['jenisKelamin'],
        puskesmas: map['puskesmas'],
      );
    } catch (e) {
      return UserData(
        id: map['id'],
        nama: map['nama'],
        tanggalLahir: null,
        jenisKelamin: map['jenis_kelamin'],
        puskesmas: map['puskesmas'],
      );
    }
  }
}
