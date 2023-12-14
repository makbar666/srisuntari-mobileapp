import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:srisuntari_mobileapp/hasil/review_quis.dart';
import 'package:srisuntari_mobileapp/home/home_quiz.dart';
import 'package:srisuntari_mobileapp/models/database_helper.dart';
import 'package:srisuntari_mobileapp/models/user_data.dart';
import 'package:srisuntari_mobileapp/quiz/class/quizt_braind.dart';
import 'package:sliver_snap/sliver_snap.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../models/quiz_result.dart';

class HasilQuis extends StatefulWidget {
  final QuizBrain quizBrain;
  final int nilai;
  HasilQuis({required this.quizBrain, required this.nilai});

  @override
  _HasilQuisState createState() => _HasilQuisState();
}

class _HasilQuisState extends State<HasilQuis> {
  List<UserData> _contacts = [];

  final dbHelper = DatabaseHelper();
  List<QuizResult> _quizResults = [];
  List<String> userQuestions = [];
  List<bool> userAnswers = [];
  List<String> userAnswerOption = [];
  Future<void> generatePdf() async {
    EasyLoading.show(status: 'Generating PDF...'); // Menampilkan dialog
    // if (_quizResults.isNotEmpty) {
    //   final lastQuizResult = _quizResults.last;

    //   if (lastQuizResult.score >= 0 && lastQuizResult.score <= 0) {
    //     indikator = "Hijau";
    //     catatan =
    //         "Anak anda beresiko Stunting, jika tidak dilakukan pemantauan pertumbuhan dan perkembangan secara rutin setiap bulan";
    //     progressBarColor = Colors.green;
    //   } else if (lastQuizResult.score >= 1 && lastQuizResult.score <= 19) {
    //     indikator = "Kuning";
    //     catatan =
    //         "Anak anda beresiko Stunting, perlu pemantauan pertumbuhan dan perkembangan di Posyandu";
    //     progressBarColor = Colors.yellow;
    //   } else if (lastQuizResult.score >= 20) {
    //     indikator = "Merah";
    //     catatan =
    //         "Anak anda beresiko Stunting, perlu dilakukan intervensi Segera ke Puskesmas Terdekat";
    //     progressBarColor = Colors.red;
    //   }
    // }

    if (widget.nilai >= 0 && widget.nilai <= 0) {
      indikator = "Hijau";
      catatan =
          "Anak anda beresiko Stunting, jika tidak dilakukan pemantauan pertumbuhan dan perkembangan secara rutin setiap bulan";
      progressBarColor = Colors.green;
    } else if (widget.nilai >= 1 && widget.nilai <= 19) {
      indikator = "Kuning";
      catatan =
          "Anak anda beresiko Stunting, perlu pemantauan pertumbuhan dan perkembangan di Posyandu";
      progressBarColor = Colors.yellow;
    } else if (widget.nilai >= 20) {
      indikator = "Merah";
      catatan =
          "Anak anda beresiko Stunting, perlu dilakukan intervensi Segera ke Puskesmas Terdekat";
      progressBarColor = Colors.red;
    }
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) {
          return _contacts.map((contact) {
            return pw.Container(
              child: pw.Column(
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
                      width: 450,
                      height: 2,
                      color: PdfColors.black,
                    ),
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
                        contact.nama ?? 'Nama Lengkap Tidak diisi',
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
                        contact.jenisKelamin ?? 'Jenis Kelamin Tidak diisi',
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
                        contact?.tanggalLahir != null
                            ? "${(DateTime.now().difference(contact!.tanggalLahir!).inDays / 30).floor()} Bulan"
                            : 'Umur Tidak Diisi',
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
                        contact.puskesmas ?? 'Puskesmas Tidak Diisi',
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
                    '${catatan}',
                    style: pw.TextStyle(
                      font: pw.Font.helveticaBold(),
                      fontSize: 17,
                      color: PdfColors.black,
                    ),
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Container(
                        height: 700,
                        child: pw.ListView.builder(
                          itemCount: userQuestions.length,
                          itemBuilder: (context, index) {
                            return pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Container(
                                    child: pw.Align(
                                        alignment: pw.Alignment.centerLeft,
                                        child: pw.Padding(
                                          padding:
                                              pw.EdgeInsets.only(left: 1.0),
                                          child: pw.Text(
                                            '${index + 1}. ${userQuestions[index]}',
                                            style: pw.TextStyle(
                                              font: pw.Font.helvetica(),
                                              fontSize: 15,
                                              color: PdfColors.black,
                                            ),
                                          ),
                                        ))),
                                pw.Container(
                                    child: pw.Align(
                                        alignment: pw.Alignment.centerLeft,
                                        child: pw.Padding(
                                          padding:
                                              pw.EdgeInsets.only(left: 1.0),
                                          child: pw.Text(
                                            'Jawaban: ${userAnswerOption[index]}',
                                            style: pw.TextStyle(
                                              font: pw.Font.helvetica(),
                                              fontSize: 15,
                                              color: PdfColors.black,
                                            ),
                                          ),
                                        )))
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }).toList();
        },
      ),
    );

    // Ganti lokasi penyimpanan ke direktori eksternal
    final externalDirectory = await getExternalStorageDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final file = File('${externalDirectory!.path}/Srisuntari_$timestamp.pdf');
    await file.writeAsBytes(await pdf.save());
    EasyLoading.dismiss();
    if (await file.exists()) {
      print('File PDF berhasil disimpan di: ${file.path}');
      // Buka file tersebut dengan OpenFile
      OpenFile.open(file.path);
    } else {
      print('Gagal menyimpan file PDF.');
    }
    // Setelah file PDF dibuat, buka file tersebut dengan OpenFile
    // OpenFile.open(file.path);
  }

  ScrollController _scrollController = ScrollController();
  bool isAppBarExpanded = true;
  @override
  void initState() {
    super.initState();
    _loadData();
    _loadDataQuiz();
    // Memastikan userQuestions dan userAnswers diisi dengan data dari widget.quizBrain
    userQuestions = widget.quizBrain.userQuestions;
    userAnswerOption = widget.quizBrain.userAnswerOption;

    _scrollController.addListener(() {
      if (_scrollController.offset <= 0) {
        // SliverAppBar sepenuhnya muncul setelah selesai di-scroll ke atas
        if (!isAppBarExpanded) {
          setState(() {
            isAppBarExpanded = true;
            // Tambahkan logika atau perubahan yang diinginkan
          });
        }
      } else {
        // SliverAppBar sedang digulir ke atas
        if (isAppBarExpanded) {
          setState(() {
            isAppBarExpanded = false;
            // Tambahkan logika atau perubahan yang diinginkan
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
    if (widget.nilai >= 0 && widget.nilai <= 0) {
      indikator = "Hijau";
      catatan =
          "Anak anda beresiko Stunting, jika tidak dilakukan pemantauan pertumbuhan dan perkembangan secara rutin setiap bulan";
      progressBarColor = Colors.green;
    } else if (widget.nilai >= 1 && widget.nilai <= 19) {
      indikator = "Kuning";
      catatan =
          "Anak anda beresiko Stunting, perlu pemantauan pertumbuhan dan perkembangan di Posyandu";
      progressBarColor = Colors.yellow;
    } else if (widget.nilai >= 20) {
      indikator = "Merah";
      catatan =
          "Anak anda beresiko Stunting, perlu dilakukan intervensi Segera ke Puskesmas Terdekat";
      progressBarColor = Colors.red;
    }

    return Scaffold(
      backgroundColor: Color(0xFF6B81DE),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(10),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeQuiz()),
                );
              },
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.picture_as_pdf_outlined,
                  color: Colors.white,
                ), // Gantilah 'your_icon' dengan ikon yang diinginkan
                onPressed: () {
                  // Tindakan yang akan dijalankan ketika ikon diklik
                  generatePdf();
                },
              ),
            ],
            backgroundColor: Color(0xFF6B81DE),
            expandedHeight: 350,
            floating: false,
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
              centerTitle: false,
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 1.0, right: 1.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                      child: Container(
                        height: 400,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            '$indikator',
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
                                          borderRadius:
                                              BorderRadius.circular(5.0),
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  // Bagian ini untuk SliverList yang berisi ListTile
                  int adjustedIndex = index - 1;
                  return ClipRRect(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 1.0, right: 1.0),
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                          child: ListTile(
                            title: Text(
                              '${adjustedIndex + 1}.  ${userQuestions[adjustedIndex]}',
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            subtitle: Text(
                              'Jawaban: ${userAnswerOption[adjustedIndex]}',
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
              childCount: userQuestions.length +
                  1, // Jangan lupa tambahkan 1 untuk bagian informasi kontak
            ),
          ),
        ],
      ),
    );
  }
}
