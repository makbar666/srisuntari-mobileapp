import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:srisuntari_mobileapp/models/database_helper.dart';
import 'package:srisuntari_mobileapp/models/user_data.dart';
import 'package:srisuntari_mobileapp/quiz/class/quizt_braind.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class ReviewQuiz extends StatefulWidget {
  final QuizBrain quizBrain;
  final int nilai;

  ReviewQuiz({required this.quizBrain, required this.nilai});

  @override
  _ReviewQuizState createState() => _ReviewQuizState();
}

class _ReviewQuizState extends State<ReviewQuiz> {
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

  double _progress = 0.0;

  @override
  Widget build(BuildContext context) {
    double _progress;
    List<String> userQuestions = widget.quizBrain.userQuestions;
    List<int> userAnswers = widget.quizBrain.userAnswers;
    String indikator = "Hijau";
    Color progressBarColor = Colors.green;
    String Catatan = "masi sehat";
    if (widget.nilai >= 1 && widget.nilai <= 10) {
      indikator = "Merah";
      progressBarColor = Colors.red;
      Catatan = "Anda Butuh Perawatan biar gak sakit";
    } else if (widget.nilai >= 10 && widget.nilai <= 17) {
      indikator = "Kuning";
      progressBarColor = Colors.yellow;
      Catatan = "yang dibutuhkan hanya nikah";
    } else if (widget.nilai >= 18) {
      indikator = "Hijau";
      progressBarColor = Colors.green;
      Catatan = "anda masi sehat";
    }

    return Scaffold(
      body: Container(
        padding:
            EdgeInsets.only(left: 32.0, top: 52.0, right: 32.0, bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _contacts.map((contact) {
            return Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          EasyLoading.showProgress(100, status: 'Mengunduh...');

                          await Future.delayed(Duration(seconds: 1));

                          EasyLoading.showSuccess('Success!');

                          await Future.delayed(Duration(seconds: 1));

                          EasyLoading.dismiss();

                          generatePdf();
                        },
                        child: Icon(
                          Icons.document_scanner,
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
                        'Nama Lengwkap',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Spacer(),
                      Text(
                        contact.nama ?? 'Nama Tidak diisi',
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
                          // subtitle: Text(
                          //   'Jawaban: ${userAnswers[index] ? 'Iya' : 'Tidak'}',
                          //   style: TextStyle(
                          //       fontFamily: 'Manrope',
                          //       fontSize: 17, // Ukuran teks
                          //       color: Colors.black,
                          //       fontWeight: FontWeight.bold),
                          // ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          // [

          // ],
        ),
      ),
    );
  }

  Future<void> generatePdf() async {
    String indikator = "Hijau";
    String Catatan = "masi sehat";
    Color progressBarColor = Colors.green;
    if (widget.nilai >= 1 && widget.nilai <= 10) {
      indikator = "Merah";
      progressBarColor = Colors.red;
      Catatan = "Anda Butuh Perawatan biar gak sakit";
    } else if (widget.nilai >= 10 && widget.nilai <= 17) {
      indikator = "Kuning";
      progressBarColor = Colors.yellow;
      Catatan = "yang dibutuhkan hanya nikah";
    } else if (widget.nilai >= 18) {
      indikator = "Hijau";
      progressBarColor = Colors.green;
      Catatan = "anda masi sehat";
    }

    List<String> userQuestions = widget.quizBrain.userQuestions;
    // List<bool> userAnswers = widget.quizBrain.userAnswers;

    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) {
          return [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Center(
                  child: pw.Text(
                    'Pemerintah Dinas Kesehatan',
                    style: pw.TextStyle(
                      font: pw.Font.helveticaBold(),
                      fontSize: 25,
                      color: PdfColors.black,
                    ),
                  ),
                ),
                pw.Center(
                  child: pw.Text(
                    'Kabupaten Fak Fak',
                    style: pw.TextStyle(
                      font: pw.Font.helveticaBold(),
                      fontSize: 25,
                      color: PdfColors.black,
                    ),
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Center(
                  child: pw.Container(
                      width: 450, height: 2, color: PdfColors.black),
                ),
                pw.SizedBox(height: 30),
                pw.Row(
                  children: [
                    pw.Text(
                      'Nama Lengkap',
                      style: pw.TextStyle(
                        font: pw.Font.helveticaBold(),
                        fontSize: 17,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.Spacer(),
                    pw.Text(
                      'Srisuntari',
                      style: pw.TextStyle(
                        font: pw.Font.helvetica(),
                        fontSize: 17,
                        color: PdfColors.black,
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text(
                      'Jenis Kelamin',
                      style: pw.TextStyle(
                        font: pw.Font.helveticaBold(),
                        fontSize: 17,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.Spacer(),
                    pw.Text(
                      'Perempuan',
                      style: pw.TextStyle(
                        font: pw.Font.helvetica(),
                        fontSize: 17,
                        color: PdfColors.black,
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text(
                      'Umur Kamu',
                      style: pw.TextStyle(
                        font: pw.Font.helveticaBold(),
                        fontSize: 17,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.Spacer(),
                    pw.Text(
                      '1 Tahun 1 Bulan',
                      style: pw.TextStyle(
                        font: pw.Font.helvetica(),
                        fontSize: 18,
                        color: PdfColors.black,
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text(
                      'Lokasi Puskesmas',
                      style: pw.TextStyle(
                        font: pw.Font.helveticaBold(),
                        fontSize: 17,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.Spacer(),
                    pw.Text(
                      'Puskesmas',
                      style: pw.TextStyle(
                        font: pw.Font.helvetica(),
                        fontSize: 17,
                        color: PdfColors.black,
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text(
                      'Status Indikator',
                      style: pw.TextStyle(
                        font: pw.Font.helveticaBold(),
                        fontSize: 17,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.Spacer(),
                    pw.Container(
                      width: 15,
                      height: 15,
                      decoration: pw.BoxDecoration(
                        color: PdfColor.fromInt(progressBarColor.value),
                        borderRadius: pw.BorderRadius.circular(10),
                      ),
                    ),
                    pw.SizedBox(width: 5),
                    pw.Text(
                      '${indikator}',
                      style: pw.TextStyle(
                        font: pw.Font.helvetica(),
                        fontSize: 18,
                        color: PdfColors.black,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Catatan :',
                  style: pw.TextStyle(
                    font: pw.Font.helveticaBold(),
                    fontSize: 17,
                    color: PdfColors.black,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  '${Catatan}',
                  style: pw.TextStyle(
                    font: pw.Font.helveticaBold(),
                    fontSize: 17,
                    color: PdfColors.black,
                  ),
                ),
              ],
            ),
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                    height: 700,
                    child: pw.ListView.builder(
                      itemCount: userQuestions.length,
                      itemBuilder: (context, index) {
                        return pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              '${index + 1}. ${userQuestions[index]}',
                              style: pw.TextStyle(
                                font: pw.Font.helvetica(),
                                fontSize: 15,
                                color: PdfColors.black,
                              ),
                            ),
                            // pw.Text(
                            //   'Jawaban: ${userAnswers[index] ? 'Iya' : 'Tidak'}',
                            //   style: pw.TextStyle(
                            //     font: pw.Font.helveticaBold(),
                            //     fontSize: 15,
                            //     color: PdfColors.black,
                            //   ),
                            // ),
                            pw.SizedBox(height: 3)
                          ],
                        );
                      },
                    ),
                  ),
                ])
          ];
        },
      ),
    );

    final externalDirectory = await getExternalStorageDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final file = File('${externalDirectory!.path}/Srisuntari_$timestamp.pdf');
    await file.writeAsBytes(await pdf.save());
    if (await file.exists()) {
      OpenFile.open(file.path);
    } else {
      // Handle file not found
    }
  }
}
