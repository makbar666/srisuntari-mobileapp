import 'package:flutter/material.dart';
import 'package:srisuntari_mobileapp/quiz/class/quizt_braind.dart';

class ReviewQuiz extends StatelessWidget {
  final QuizBrain quizBrain;
  final int nilai;
  ReviewQuiz({required this.quizBrain, required this.nilai});

  @override
  Widget build(BuildContext context) {
    List<String> userQuestions = quizBrain.userQuestions;
    List<bool> userAnswers = quizBrain.userAnswers;
    String indikator = "Hijau";
    Color progressBarColor = Colors.green; // Warna awal progress indikator
// Menggunakan operator ternary untuk mengubah warna progress bar berdasarkan nilai 'nilai'
    if (nilai >= 1 && nilai <= 10) {
      indikator = "Merah";
      progressBarColor = Colors.red;
    } else if (nilai >= 10 && nilai <= 17) {
      indikator = "Kuning";
      progressBarColor = Colors.yellow;
    } else if (nilai >= 18) {
      indikator = "Hijau";
      progressBarColor = Colors.green;
    }

    return Scaffold(
      body: Container(
        padding:
            EdgeInsets.only(left: 32.0, top: 52.0, right: 32.0, bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 70,
                ),
                Text(
                  'Review Quiz',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text(
                  'Nama Lengkap',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
                Text(
                  'Srisuntari',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Jenis Kelamin',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
                Text(
                  'Perempuan',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Umur Kamu',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
                Text(
                  '1 Tahun 1 Bulan',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Lokasi Puskesmas',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
                Text(
                  'Pusekesmas',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Status Indikator',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                      color: progressBarColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
                SizedBox(width: 5),
                Text(
                  '$indikator',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Soal & Jawab :',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: userQuestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      '${index + 1}.  ${userQuestions[index]}',
                      style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 17, // Ukuran teks
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    ),
                    subtitle: Text(
                      'Jawaban: ${userAnswers[index] ? 'Iya' : 'Tidak'}',
                      style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 17, // Ukuran teks
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
