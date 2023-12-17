import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:srisuntari_mobileapp/models/database_helper.dart';
import 'package:srisuntari_mobileapp/models/quiz_result.dart';
import 'package:srisuntari_mobileapp/register/register_page.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeQuiz extends StatefulWidget {
  const HomeQuiz({Key? key}) : super(key: key);

  @override
  State<HomeQuiz> createState() => _HomeQuizState();
}

class _HomeQuizState extends State<HomeQuiz> {
  List<QuizResult> quizResults = [];

  Future<void> createDirectory() async {
    try {
      final Directory directory =
          Directory('/storage/emulated/0/Download/Srisuntari');
      if (await directory.exists()) {
        print('Directory already exists: ${directory.path}');
      } else {
        await directory.create(recursive: true);
        print('Directory created: ${directory.path}');
      }
    } catch (e) {
      print('Error creating directory: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // exit(0);
          // Show a confirmation dialog
          bool shouldExit = await _showQuitConfirmationDialog(context);
          return shouldExit;
        },
        child: Scaffold(
          backgroundColor: Color(0xFF6B81DE),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/icon_dashboard.png', // Ganti dengan path gambar Anda
                  width: 250, // Sesuaikan lebar gambar
                  height: 250, // Sesuaikan tinggi gambar
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Text(
                      'Selamat Datang! di aplikasi',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      'SKRINING STUNTING MANDIRI',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: 300,
                      child: Text(
                        'Aplikasi ini digunakan untuk mendeteksi kondisi anak dan memberikan pemantauan cepat oleh Orang Tua',
                        textAlign: TextAlign
                            .center, // Atur rata tengah secara horizontal
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 60),
                Column(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxWidth:
                            200, // Ganti dengan lebar maksimum yang diinginkan
                      ),
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ),
                          );
                          // Memeriksa status izin
                          PermissionStatus status =
                              await Permission.storage.status;

                          if (status.isDenied) {
                            // Menampilkan dialog atau pesan untuk meminta izin
                            await Permission.storage.request();
                          } else if (status.isPermanentlyDenied) {
                            // Menampilkan pesan untuk membuka pengaturan aplikasi
                            showSettingsDialog(context);
                          } else {
                            // Akses ke penyimpanan diizinkan, lanjutkan dengan operasi yang diinginkan
                            // ...
                          }
                          await createDirectory(); // Membuat Folder Srisuntari
                        },
                        child: Text(
                          "Mulai Kuis",
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black38,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white70,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Dinas Kesehatan Kabupaten Fak-Fak',
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      '@Copyright 2023',
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  // Menampilkan dialog untuk membuka pengaturan aplikasi
  void showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Izin Penyimpanan Dibutuhkan'),
          content: Text('Buka pengaturan untuk mengaktifkan izin penyimpanan.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings(); // Membuka pengaturan aplikasi
              },
              child: Text('Buka Pengaturan'),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> _showQuitConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Quit Confirmation'),
        content: Text('Are you sure you want to quit the app?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.black45),
            ),
          ),
          TextButton(
            onPressed: () {
              // Close the dialog and exit the app
              Navigator.of(context).pop(true);
              exit(0);
            },
            child: Text(
              'Quit',
              style: TextStyle(color: Colors.black45),
            ),
          ),
        ],
      ),
    );
  }
}
