import 'package:srisuntari_mobileapp/models/database_helper.dart';

import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;
  int umur = 0; // Properti umur

  late final DatabaseHelper dbHelper;

  List<String> userQuestions = [];
  List<bool> userAnswers = [];

  List<Question> _pertanyaanUmurKurangDari5Bulan = [
    Question('Pertanyaan 1 untuk umur kurang dari 5 bulan', true),
    Question('Pertanyaan 2 untuk umur kurang dari 5 bulan', true),
    Question('Pertanyaan 3 untuk umur kurang dari 5 bulan', true),
    Question('Pertanyaan 4 untuk umur kurang dari 5 bulan', true),
    Question('Pertanyaan 5 untuk umur kurang dari 5 bulan', true),
    Question('Pertanyaan 6 untuk umur kurang dari 5 bulan', true),
  ];

  List<Question> _pertanyaanUmurDiAtas5Bulan = [
    Question('Pertanyaan 1 untuk umur di atas 5 bulan', true),
    Question('Pertanyaan 2 untuk umur di atas 5 bulan', true),
    Question('Pertanyaan 3 untuk umur di atas 5 bulan', true),
    Question('Pertanyaan 4 untuk umur di atas 5 bulan', true),
    Question('Pertanyaan 5 untuk umur di atas 5 bulan', true),
    Question('Pertanyaan 6 untuk umur di atas 5 bulan', true),
  ];

  List<Question> get currentQuestions {
    return (umur < 5)
        ? _pertanyaanUmurKurangDari5Bulan
        : _pertanyaanUmurDiAtas5Bulan;
  }

  void nextQuestion() {
    if (_questionNumber < currentQuestions.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    // Pastikan umur diatur sebelum mengambil pertanyaan
    setUmurFromTanggalLahir(DateTime
        .now()); // Ganti dengan tanggal lahir yang diambil dari database
    return currentQuestions[_questionNumber].questionText;
  }

  bool getCorrectAnswer() {
    return currentQuestions[_questionNumber].questionAnswer;
  }

  bool isFinished() {
    if (_questionNumber >= currentQuestions.length - 1) {
      print('Now returning true');
      return true;
    } else {
      return false;
    }
  }

  void checksoal(bool userPickedAnswer) {
    userQuestions.add(currentQuestions[_questionNumber].questionText);
    userAnswers.add(userPickedAnswer);
    print('aasdadsadasa');
  }

  void reset() {
    _questionNumber = 0;
  }

  // Fungsi untuk mengatur umur dari tanggal lahir
  void setUmurFromTanggalLahir(DateTime tanggalLahir) {
    final now = DateTime.now();
    final difference = now.difference(tanggalLahir);
    umur = difference.inDays ~/ 30; // Menghitung umur dalam bulan
  }

  // Metode untuk memulai permainan
  void startGame() async {
    final tanggalLahirDariDatabase = await _retrieveTanggalLahir();
    if (tanggalLahirDariDatabase != null) {
      print('Tanggal Lahir dari Database: $tanggalLahirDariDatabase');
      setUmurFromTanggalLahir(tanggalLahirDariDatabase);
    }
    _questionNumber = 0;
  }

  Future<DateTime?> _retrieveTanggalLahir() async {
    final tanggalLahirDariDatabase = await dbHelper.retrieveTanggalLahir();
    return tanggalLahirDariDatabase;
  }
}
