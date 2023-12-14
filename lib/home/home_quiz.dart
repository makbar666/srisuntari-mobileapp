import 'package:flutter/material.dart';
import 'package:srisuntari_mobileapp/models/database_helper.dart';
import 'package:srisuntari_mobileapp/models/quiz_result.dart';
import 'package:srisuntari_mobileapp/register/register_page.dart';

class HomeQuiz extends StatefulWidget {
  const HomeQuiz({Key? key}) : super(key: key);

  @override
  State<HomeQuiz> createState() => _HomeQuizState();
}

class _HomeQuizState extends State<HomeQuiz> {
  List<QuizResult> quizResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'Aplikasi ini blblblblblbllblblbBLBLBLBLBLBLBL',
                    textAlign:
                        TextAlign.center, // Atur rata tengah secara horizontal
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ),
                      );
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
                  '@Copyright 2024',
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
    );
  }
}
