import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:srisuntari_mobileapp/models/database_helper.dart';
import 'package:srisuntari_mobileapp/models/user_data.dart';

class ValidatePage extends StatefulWidget {
  const ValidatePage({super.key});

  @override
  State<ValidatePage> createState() => _ValidatePageState();
}

class _ValidatePageState extends State<ValidatePage> {
  DatabaseHelper dbHelper = DatabaseHelper();

  // get data dari database
  Future<UserData?> _getUserData() async {
    try {
      UserData? userData = await dbHelper.retrieveUserdata();
      if (userData != null) {
        print("Nama Lengkap: ${userData.name}");
        print("Tanggal Lahir: ${userData.tanggalLahir}");
        return userData;
      } else {
        print("Tidak ada data yang ditemukan.");
        return null;
      }
    } catch (error) {
      print("Terjadi kesalahan: $error");
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF6B81DE),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 32.0, top: 52.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // Mengatur ikon dan teks sejajar ke kiri
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Daftar",
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white, // Warna latar belakang putih
                    borderRadius: BorderRadius.only(
                      topLeft:
                          Radius.circular(20.0), // Ubah radius sesuai keinginan
                      topRight:
                          Radius.circular(20.0), // Ubah radius sesuai keinginan
                    ),
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: FutureBuilder<UserData?>(
                          future:
                              _getUserData(), // Panggil fungsi untuk mendapatkan data pengguna
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // Menampilkan indikator loading ketika data masih dimuat
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              // Menampilkan pesan kesalahan jika terjadi kesalahan
                              return Text('Error: ${snapshot.error}');
                            } else {
                              // Menampilkan data pengguna setelah berhasil dimuat
                              UserData? userData = snapshot.data;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Validasi Data",
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 50.0,
                                          color: Colors.grey,
                                          offset: Offset(3.0, 3.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    "Silahkan Periksa Kembali Data Kamu",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 32),
                                  Row(
                                    children: [
                                      Text('Nama Lengkap',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          )),
                                      Spacer(),
                                      Text(userData?.name ??
                                          'Nama Lengkap Tidak Tersedia'),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Text('Tanggal Lahir',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          )),
                                      Spacer(),
                                      Text(userData?.tanggalLahir != null
                                          ? DateFormat('dd MMMM yyyy')
                                              .format(userData!.tanggalLahir)
                                          : 'Tanggal Lahir Tidak Tersedia'),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Text('Umur Kamu',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          )),
                                      Spacer(),
                                      Text(userData?.tanggalLahir != null
                                          ? "${(DateTime.now().difference(userData!.tanggalLahir).inDays / 30).floor()} Bulan"
                                          : 'Umur Tidak Tersedia'),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Text('Distrik / Wilayah',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          )),
                                      Spacer(),
                                      Text(userData?.wilayah ??
                                          'Distrik / Wilayah Tidak Tersedia'),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Text('Foto',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          )),
                                      Spacer(),
                                      Text('sdsds'),
                                    ],
                                  ),
                                  SizedBox(height: 32),
                                  // image dari path gambar
                                  // Container(
                                  //   width: 50,
                                  //   height: 50,
                                  //   child: gambarPath != null
                                  //       ? Image.file(
                                  //           File(gambarPath!),
                                  //           fit: BoxFit.cover,
                                  //         )
                                  //       : Placeholder(),
                                  // )
                                ],
                              );
                            }
                          })),
                ))
          ],
        ));
  }
}
