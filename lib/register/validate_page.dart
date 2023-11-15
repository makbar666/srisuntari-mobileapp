import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:page_transition/page_transition.dart';
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
    EasyLoading.init();
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
                                      EasyLoading.show(
                                        status: 'Proses...',
                                        dismissOnTap: false,
                                        maskType: EasyLoadingMaskType.black,
                                        indicator: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      );
                                      await Future.delayed(
                                          Duration(milliseconds: 500));

                                      EasyLoading.dismiss();
                                      // Menuju mulai_quiz_page.dart
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              child: MulaiQuiz(),
                                              type: PageTransitionType
                                                  .rightToLeftWithFade));
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
                              ]),
                        );
                      }).toList(),
                    ),
                  ),
                ))
          ],
        ));
  }
}