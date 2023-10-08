import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:srisuntari_mobileapp/components/costum_button.dart';
import 'package:srisuntari_mobileapp/hasil/hasil_quis.dart';
import 'package:srisuntari_mobileapp/hasil/review_quis.dart';
import 'package:srisuntari_mobileapp/quiz/class/quizt_braind.dart';

class quiz extends StatefulWidget {
  const quiz({super.key});

  @override
  State<quiz> createState() => _quizState();
}

class _quizState extends State<quiz> {
  int nilai = 0;
  int totalQuestions = 1;
  QuizBrain quizBrain = QuizBrain();

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'Data Sudah di Jawab Semua, Silahkan Klik Berikutnya:)',
        ).show();
      } else {
        if (userPickedAnswer == correctAnswer) {
          nilai++;
        } else {}
        quizBrain.checksoal(userPickedAnswer);
        totalQuestions++;
        quizBrain.nextQuestion();
      }
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
              // alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 32.0, top: 52.0, right: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
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
                      SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        child: Text(
                          'Sedang Berjalan',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  LinearPercentIndicator(
                    animation: false,
                    animationDuration: 1000,
                    lineHeight: 15,
                    percent: totalQuestions / 20,
                    barRadius: Radius.circular(10.0),
                    progressColor: Colors.orange,
                    backgroundColor: Colors.deepOrange.shade100,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 11.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '$totalQuestions / 20', // Menampilkan skor dan total pertanyaan yang sudah dijawab.
                        // '3/20', // Ganti dengan teks Anda
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
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
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quizBrain.getQuestionText(),
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    CostumButton(
                      text: 'A. Iya',
                      onTap: () {
                        //The user picked true.
                        checkAnswer(true);
                      },
                    ),
                    SizedBox(height: 10),
                    CostumButton(
                      text: 'B. Tidak',
                      onTap: () {
                        //The user picked false.
                        checkAnswer(false);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20, // Sesuaikan jarak dari bawah sesuai kebutuhan Anda
            left: 40,
            right: 40,
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    if (!quizBrain.isFinished()) {
                      // Jika kuis belum selesai
                      // Tambahkan aksi yang ingin Anda lakukan saat tombol ditekan di sini

                      Alert(
                        context: context,
                        title: 'Opss!!',
                        desc: 'Selesaikan ki Dulu  Quiznya Bro',
                      ).show();
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return HasilQuis(quizBrain: quizBrain, nilai: nilai);
                      }));
                    }
                  },
                  child: Text("Berikutnya",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      )),
                  style: ElevatedButton.styleFrom(
                    primary: quizBrain.isFinished()
                        ? Color(0xFF6B81DE)
                        : Color.fromARGB(255, 140, 152, 205),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
