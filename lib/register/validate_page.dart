import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ValidatePage extends StatefulWidget {
  const ValidatePage({super.key});

  @override
  State<ValidatePage> createState() => _ValidatePageState();
}

class _ValidatePageState extends State<ValidatePage> {
  String namaLengkap = '';
  String tanggalLahir = '';
  String wilayah = '';
  String? gambarPath;

  @override
  void initState() {
    super.initState();
    loadSavedData();
    loadGambarPath();
  }

  Future<void> loadGambarPath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      gambarPath = prefs.getString('gambarPath');
      print("Path gambar: $gambarPath");
    });
  }

  Future<void> loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      namaLengkap = prefs.getString('namaLengkap') ?? '';
      tanggalLahir = prefs.getString('tanggalLahir') ?? '';
      wilayah = prefs.getString('wilayah') ?? '';
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
                              Text(wilayah),
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
                              // Text(
                              //   tanggalLahir != null
                              //       ? DateFormat('dd-MM-yyyy')
                              //           .format(DateTime.parse(tanggalLahir))
                              //       : '',
                              // ),
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
                              Text('sdsds'),
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
                              Text(wilayah),
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
                          Container(
                            width: 50,
                            height: 50,
                            child: gambarPath != null
                                ? Image.file(
                                    File(gambarPath!),
                                    fit: BoxFit.cover,
                                  )
                                : Placeholder(),
                          )
                        ],
                      )),
                ))
          ],
        ));
  }
}
