import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:srisuntari_mobileapp/quiz/quiz.dart';


class MulaiQuiz extends StatelessWidget {
  const MulaiQuiz({super.key});

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
                    "Mulai Kuis",
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(right: 32.0),
                    child: Center(
                      child: Container(
                        width: 300,
                        height: 300,
                        child: Image(
                            image: AssetImage("images/icon_mulaikuis.png")),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
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
                      "Persyaratan Kuis",
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Silahkan Periksa Kembali Data Kamu",
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: double.infinity, // Mengatur lebar menjadi penuh
                      height: 70.0, // Tinggi kontainer
                      decoration: BoxDecoration(
                        color: Colors
                            .grey.shade300, // Warna latar belakang kontainer
                        borderRadius:
                            BorderRadius.circular(5.0), // Mengatur sudut bulat
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              child: Image(
                                  image: AssetImage("images/askquestion.png")),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  textAlign: TextAlign.left,
                                  '20', // Teks di dalam kontainer
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 20.0, // Ukuran teks
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  // Rata kiri teks
                                ),
                                Text(
                                  'Pertanyaan Pilihan Ganda', // Teks di dalam kontainer
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 15.0, // Ukuran teks
                                    color: Colors.black, // Warna teks
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return quiz();
                    }));
                  },
                  child: Text("Mulai Kuis",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      )),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF6B81DE),
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
