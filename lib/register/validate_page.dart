import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:srisuntari_mobileapp/models/database_helper.dart';
import 'package:srisuntari_mobileapp/models/user_data.dart';
import 'package:srisuntari_mobileapp/quiz/mulai_quiz_page.dart';

class ValidatePage extends StatefulWidget {
  const ValidatePage({super.key});

  @override
  State<ValidatePage> createState() => _ValidatePageState();
}

class _ValidatePageState extends State<ValidatePage> {
  List<UserData> _contacts = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final dbHelper =
        DatabaseHelper(); // Ganti dengan instance dari DatabaseHelper Anda
    final contacts = await dbHelper.getAllContacts();
    setState(() {
      _contacts = contacts;
    });
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
                    child: Column(
                      children: _contacts.map((contact) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 16.0),
                          child: Column(
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
                                    Text(contact.nama ??
                                        'Nama Lengkap Tidak Diisi'),
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
                                    Text(contact.tanggalLahir != null
                                        ? DateFormat('dd MMMM yyyy')
                                            .format(contact.tanggalLahir!)
                                        : 'Tanggal Lahir Tidak Diisi'),
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
                                    Text(contact?.tanggalLahir != null
                                        ? "${(DateTime.now().difference(contact!.tanggalLahir!).inDays / 30).floor()} Bulan"
                                        : 'Umur Tidak Diisi'),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    Text('Jenis Kelamin',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        )),
                                    Spacer(),
                                    Text(contact.jenisKelamin ??
                                        'Jenis Kelamin Tidak Diiisi'),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    Text('Puskesmas',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        )),
                                    Spacer(),
                                    Text(contact.puskesmas ??
                                        'Puskesmas Tidak Diisi'),
                                  ],
                                ),
                                SizedBox(height: 32),
                                Container(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      // Menuju mulai_quiz_page.dart
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MulaiQuiz()),
                                      );
                                    },
                                    child: Text(
                                      "Lanjut",
                                      style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFF6B81DE),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              // children: [
                              //   Text(
                              //     'Nama: ${contact.nama}',
                              //     style: TextStyle(
                              //       fontSize: 18,
                              //       fontWeight: FontWeight.bold,
                              //     ),
                              //   ),
                              //   Text(
                              //     'Tanggal Lahir: ${contact.tanggalLahir}',
                              //     style: TextStyle(fontSize: 16),
                              //   ),
                              //   Divider(
                              //     color: Colors.grey,
                              //   ),
                              // ],
                              ),
                        );
                      }).toList(),
                    ),
                  ),
                  // child: Padding(
                  //     padding: EdgeInsets.all(32.0),
                  //     child: FutureBuilder<UserData?>(
                  //         future:
                  //             _getUserData(), // Panggil fungsi untuk mendapatkan data pengguna
                  //         builder: (context, snapshot) {
                  //           if (snapshot.connectionState ==
                  //               ConnectionState.waiting) {
                  //             // Menampilkan indikator loading ketika data masih dimuat
                  //             return CircularProgressIndicator();
                  //           } else if (snapshot.hasError) {
                  //             // Menampilkan pesan kesalahan jika terjadi kesalahan
                  //             return Text('Error: ${snapshot.error}');
                  //           } else {
                  //             // Menampilkan data pengguna setelah berhasil dimuat
                  //             UserData? userData = snapshot.data;
                  //             return Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Text(
                  //                   "Validasi Data",
                  //                   style: TextStyle(
                  //                     fontFamily: 'Manrope',
                  //                     fontSize: 32,
                  //                     fontWeight: FontWeight.bold,
                  //                     shadows: [
                  //                       Shadow(
                  //                         blurRadius: 50.0,
                  //                         color: Colors.grey,
                  //                         offset: Offset(3.0, 3.0),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //                 SizedBox(height: 3),
                  //                 Text(
                  //                   "Silahkan Periksa Kembali Data Kamu",
                  //                   style: TextStyle(
                  //                     fontSize: 14,
                  //                     color: Colors.grey,
                  //                   ),
                  //                 ),
                  //                 SizedBox(height: 32),
                  //                 Row(
                  //                   children: [
                  //                     Text('Nama Lengkap',
                  //                         style: TextStyle(
                  //                           fontWeight: FontWeight.w600,
                  //                         )),
                  //                     Spacer(),
                  //                     // Text(userData?.name ??
                  //                     //     'Nama Lengkap Tidak Tersedia'),
                  //                   ],
                  //                 ),
                  //                 SizedBox(height: 16),
                  //                 Row(
                  //                   children: [
                  //                     Text('Tanggal Lahir',
                  //                         style: TextStyle(
                  //                           fontWeight: FontWeight.w600,
                  //                         )),
                  //                     Spacer(),
                  //                     // Text(userData?.tanggalLahir != null
                  //                     //     ? DateFormat('dd MMMM yyyy')
                  //                     //         .format(userData!.tanggalLahir)
                  //                     //     : 'Tanggal Lahir Tidak Tersedia'),
                  //                   ],
                  //                 ),
                  //                 SizedBox(height: 16),
                  //                 Row(
                  //                   children: [
                  //                     Text('Umur Kamu',
                  //                         style: TextStyle(
                  //                           fontWeight: FontWeight.w600,
                  //                         )),
                  //                     Spacer(),
                  //                     // Text(userData?.tanggalLahir != null
                  //                     //     ? "${(DateTime.now().difference(userData!.tanggalLahir).inDays / 30).floor()} Bulan"
                  //                     //     : 'Umur Tidak Tersedia'),
                  //                   ],
                  //                 ),
                  //                 SizedBox(height: 16),
                  //                 Row(
                  //                   children: [
                  //                     Text('Distrik / Wilayah',
                  //                         style: TextStyle(
                  //                           fontWeight: FontWeight.w600,
                  //                         )),
                  //                     Spacer(),
                  //                     // Text(userData?.wilayah ??
                  //                     //     'Distrik / Wilayah Tidak Tersedia'),
                  //                   ],
                  //                 ),
                  //                 SizedBox(height: 16),
                  //                 Row(
                  //                   children: [
                  //                     Text('Foto',
                  //                         style: TextStyle(
                  //                           fontWeight: FontWeight.w600,
                  //                         )),
                  //                     Spacer(),
                  //                     Text('sdsds'),
                  //                   ],
                  //                 ),
                  //                 SizedBox(height: 32),
                  //                 // button lanjut ke halaman berikutnya
                  //                 Container(
                  //                   width: double.infinity,
                  //                   height: 50,
                  //                   child: ElevatedButton(
                  //                     onPressed: () async {
                  //                       // Menuju mulai_quiz_page.dart
                  //                       Navigator.push(
                  //                         context,
                  //                         MaterialPageRoute(
                  //                             builder: (context) =>
                  //                                 MulaiQuiz()),
                  //                       );
                  //                     },
                  //                     child: Text(
                  //                       "Lanjut",
                  //                       style: TextStyle(
                  //                         fontFamily: 'Manrope',
                  //                         fontSize: 16,
                  //                         fontWeight: FontWeight.bold,
                  //                         color: Colors.white,
                  //                       ),
                  //                     ),
                  //                     style: ElevatedButton.styleFrom(
                  //                       primary: Color(0xFF6B81DE),
                  //                       shape: RoundedRectangleBorder(
                  //                         borderRadius:
                  //                             BorderRadius.circular(12.0),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             );
                  //           }
                  //         })),
                ))
          ],
        ));
  }
}
