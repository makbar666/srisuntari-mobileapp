import 'package:flutter/material.dart';
import 'package:srisuntari_mobileapp/hasil/review_quis.dart';
import 'package:srisuntari_mobileapp/models/database_helper.dart';
import 'package:srisuntari_mobileapp/models/user_data.dart';
import 'package:srisuntari_mobileapp/quiz/class/quizt_braind.dart';
import 'package:sliver_snap/sliver_snap.dart';

import '../models/quiz_result.dart';

class HasilQuis extends StatefulWidget {
  const HasilQuis({Key? key, required this.nilai, required this.quizBrain})
      : super(key: key);
  final int nilai;
  final QuizBrain quizBrain;

  @override
  _HasilQuisState createState() => _HasilQuisState();
}

class _HasilQuisState extends State<HasilQuis> {
  final dbHelper = DatabaseHelper();
  List<UserData> _contacts = [];
  List<QuizResult> _quizResults = [];

  @override
  void initState() {
    super.initState();
    _loadData();
    _loadDataQuiz();
  }

  void _loadData() async {
    final dbHelper = DatabaseHelper();
    final contacts = await dbHelper.getAllContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  void _loadDataQuiz() async {
    final dbHelper = DatabaseHelper();
    final quizResults = await dbHelper.getAllQuizResults();
    setState(() {
      _quizResults = quizResults;
    });
  }

  void loadQuizfromDB() async {
    List<QuizResult> quizResults = await dbHelper.getAllQuizResults();
    quizResults.forEach((quizResult) {
      print(quizResult.toMap());
    });
  }

  String indikator = "Hijau";
  String catatan = "Anda Masih Sehat";
  Color progressBarColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    if (_quizResults.isNotEmpty) {
      final lastQuizResult = _quizResults.last;

      if (lastQuizResult.score >= 1 && lastQuizResult.score <= 6) {
        indikator = "Merah";
        catatan = "Status Merah";
        progressBarColor = Colors.red;
      } else if (lastQuizResult.score >= 7 && lastQuizResult.score <= 9) {
        indikator = "Kurang";
        catatan = "Status Kurang";
        progressBarColor = Colors.yellow;
      } else if (lastQuizResult.score >= 10) {
        indikator = "Baik";
        catatan = "Status Baik";
        progressBarColor = Colors.green;
      }
    }

    return Scaffold(
      backgroundColor: Color(0xFF6B81DE),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(
              icon: Icon(Icons.close),
              padding: EdgeInsets.all(10),
              onPressed: () {},
            ),
            backgroundColor: Color(0xFF6B81DE),
            expandedHeight: 350,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Hasil Quiz',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              expandedTitleScale: 1,
              collapseMode: CollapseMode.parallax,
              background: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 32.0, top: 52.0, right: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // Mengatur ikon dan teks sejajar ke kiri
                  children: [
                    Center(
                      child: Container(
                        width: 250,
                        height: 300,
                        child: Image(image: AssetImage("images/family.png")),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                    height: 1000,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: _contacts.map((contact) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Text(
                                    "Hasil Quiz",
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Berikut Adalah Hasil Kuis Kamu",
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Row(
                                    children: [
                                      Text(
                                        'Nama Lengkap',
                                        style: TextStyle(
                                          fontFamily: 'Manrope',
                                          fontSize: 15.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        contact
                                            .nama, // Ganti dengan data yang sesuai dari contact
                                        style: TextStyle(
                                          fontFamily: 'Manrope',
                                          fontSize: 15.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        'Jenis Kelamin',
                                        style: TextStyle(
                                          fontFamily: 'Manrope',
                                          fontSize: 15.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        contact.jenisKelamin ??
                                            'Jenis Kelamin Tidak Diiisi',
                                        style: TextStyle(
                                          fontFamily: 'Manrope',
                                          fontSize: 15.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        'Umur Kamu',
                                        style: TextStyle(
                                          fontFamily: 'Manrope',
                                          fontSize: 15.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        contact.tanggalLahir != null
                                            ? "${(DateTime.now().difference(contact!.tanggalLahir!).inDays / 30).floor()} Bulan"
                                            : 'Umur Tidak Diisi', // Ganti dengan data yang sesuai dari contact
                                        style: TextStyle(
                                          fontFamily: 'Manrope',
                                          fontSize: 15.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        'Lokasi Puskesmas',
                                        style: TextStyle(
                                          fontFamily: 'Manrope',
                                          fontSize: 15.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        contact.puskesmas ??
                                            'Puskesmas Tidak Diisi', // Ganti dengan data yang sesuai dari contact
                                        style: TextStyle(
                                          fontFamily: 'Manrope',
                                          fontSize: 15.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        'Status',
                                        style: TextStyle(
                                          fontFamily: 'Manrope',
                                          fontSize: 15.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 15,
                                        height: 15,
                                        decoration: BoxDecoration(
                                            color: progressBarColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '$indikator', // Ganti dengan data yang sesuai dari contact
                                        style: TextStyle(
                                          fontFamily: 'Manrope',
                                          fontSize: 15.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        'Catatan',
                                        style: TextStyle(
                                          fontFamily: 'Manrope',
                                          fontSize: 15.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        '$catatan',
                                        style: TextStyle(
                                          fontFamily: 'Manrope',
                                          fontSize: 15.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          )
                        ],
                      ),
                    )),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReviewQuiz(
                nilai: widget.nilai,
                quizBrain: widget.quizBrain,
              ),
            ),
          );
        },
        label: Text('Review Quiz',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF6B81DE),
      ),
    );
  }
}
