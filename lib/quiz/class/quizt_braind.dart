import 'package:srisuntari_mobileapp/models/database_helper.dart';

import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;
  int ageMonths = 0;
  String gender = "0";
  List<String> userQuestions = [];
  List<bool> userAnswers = [];
  List<Question> allQuestions = [];

  Future<void> initializeQuiz() async {
    // Tunggu pemanggilan DatabaseHelper().getAgeMonths() selesai
    await initializeQuestions();
  }

  QuizBrain() {
    initializeQuestions();
  }
  Future<void> initializeQuestions() async {
    gender = await DatabaseHelper().getGender();
    ageMonths = await DatabaseHelper().getAgeMonths();
    // print('Debug: Initializing questions...');
    print('RENDER DB GENDER = $gender');
    print('RENDER DB BULAN = $ageMonths');
  }

  List<Question> get currentQuestionList {
    List<Question> questions = [];

    if (ageMonths >= 0 && ageMonths <= 6) {
      print('Debug: Adding questions from _question0sampai6Bulan');
      questions.addAll(_question0sampai6Bulan);
    } else if (ageMonths >= 7 && ageMonths <= 59) {
      print('Debug: Adding questions from _question6sampai59Bulan');
      questions.addAll(_question6sampai59Bulan);
    }

    print(
        'Debug: Final questions list: $questions'); // Print final questions list for debugging

    return questions;
  }

  int get totalSoal => currentQuestionList.length;

  List<Question> _question0sampai6Bulan = [
    Question('Apakah anak anda lahir di fasilitas pelayanan kesehatan?', true),
    Question('Apakah anak anda memiliki akta kelahiran ?', true),
    Question('Apakah anak anda hanya memperoleh ASI saja ?', true),
    Question(
        'Apakah Anda memberikan Makanan/ASI kepada anak sebanyak 8 sampai 12 kali sehari ?',
        true),
    Question(
        'Apakah di Rumah Anda memiliki tempat sampah yang tertutup ?  ', true),
  ];

  List<Question> _question6sampai59Bulan = [
    Question('Apakah anda mengetahui tentang Makanan Pendamping –ASI ?', true),
    Question('Apakah anak Anda mengonsumsi sayuran ?', true),
    Question(
        'Apakah anak Anda mengonsumsi Lauk Hewani seperti ikan/daging/telur?',
        true),
    Question(
        'Apakah anak Anda mengonsumsi Lauk Nabati seperti tahu/tempe/kacang/buah-buah ?',
        true),
    Question(
        'Apakah anak Anda mengonsumsi Makanan Jajanan seperti biskuit/roti ?',
        true),
    Question(
        'Apakah anak Anda mengonsumsi susu seperti susu UHT/ susu full cream dan sejenisnya ?',
        true),
    Question(
        'Apakah ibu mengetahui bahwa kekurangan asupan makanan bergizi dapat mengakibatkan anak menjadi stunting ?',
        true),
    Question('Apakah ibu memberi makan anak 3 kali dalam sehari ?', true),
    Question(
        'apakah Anda menghabiskan waktu bersama anak di rumah dalam 1 hari tanpa dengan orang lain selama 3 jam atau lebih ?',
        true),
    Question('Apakah air yang di berikan ke anak ada di masak ?', true),
    Question(
        'Apakah air minum yang dikonsumsi tidak berasa, berwarna, berbau dan berkapur ?',
        true),
    Question('Apakah tempat sampah anda di rumah tertutup ?  ', true),
  ];

  void nextQuestion() {
    if (_questionNumber < currentQuestionList.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return currentQuestionList[_questionNumber].questionText;
  }

  bool getCorrectAnswer() {
    return currentQuestionList[_questionNumber].questionAnswer;
  }

  bool isFinished() {
    if (_questionNumber >= currentQuestionList.length - 1) {
      print('Now returning true');
      return true;
    } else {
      return false;
    }
  }

  void checksoal(bool userPickedAnswer) {
    userQuestions.add(currentQuestionList[_questionNumber].questionText);
    userAnswers.add(userPickedAnswer);
  }

  void reset() {
    _questionNumber = 0;
  }
}
