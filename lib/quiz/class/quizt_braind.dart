import 'package:srisuntari_mobileapp/models/database_helper.dart';

import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;
  int ageMonths = 0;
  int _quistotal = 0;
  String gender = "0";
  List<String> userQuestions = [];
  List<bool> userAnswers = [];
  List<Question> allQuestions = [];
  int get questionNumber => _questionNumber;
  int get quistotal => _quistotal;
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
      _quistotal = 13;
    } else if (ageMonths >= 7 && ageMonths <= 59) {
      print('Debug: Adding questions from _question6sampai59Bulan');
      questions.addAll(_question6sampai59Bulan);
      _quistotal = 15;
    }

    print(
        'Debug: Final questions list: $questions'); // Print final questions list for debugging

    return questions;
  }

  int get totalSoal => currentQuestionList.length;

  List<Question> _question0sampai6Bulan = [
    Question('Apakah anak anda lahir di fasilitas pelayanan kesehatan?', true),
    Question('Apakah anak anda memiliki akta kelahiran ?', true),
    Question('Berapa berat badan lahir anak saat lahir? < 2,4 atau > 3,7 kg ?',
        true),
    Question(
        'Berapa panjang badan anak saat lahir? < 45.6 atau > 55.6 cm ?', true),
    Question('Lingka kepala anak anda saat lahir <31,5 atau >37 cm ?', true),
    Question(
        'Apakah anak anda sudah di imunisasi BCG?DPT 1,DPT 2,DPT 3,polio tetes 1,polio tetes 2,polio tetes 3,polio tetes 4,Polio suntik 1,Rotavirus 1,ritavirus 2,PCV 1,PCV 2 ?',
        true),
    Question(
        'Apakah aanda tahu jika bayi anda usia 0-6 bulan  hanya minum Asi saja',
        true),
    Question(
        'Apakah anak anda setiap bulan di timbang di posyandu atau puskemsas ?',
        true),
    Question(
        'Apakah anda menyusui anak anda secara lanssung setiap 90 menit ? ',
        true),
    Question('Apakah anda membunagn sampah di sembarangan tempat?', true),
    Question('Apakah tempat sampah anda di rumah terbuka /tertutup ?', true),
    Question(
        'Jika anak anda sakit batu,pilek,demam apakah langsung di bawa untuk di obati di Fasilitas kesehatan?',
        true),
    Question(
        'Jika anak anda diare,sakit perut,demam apakah langsung di bawa untuk di obati di Fasilitas kesehatan?',
        true),
    Question(
        'Jika anak anda diare,sakit perut,demam apakah langsung di bawa untuk di obati di Fasilitas kesehatan?',
        true),
  ];

  List<Question> _question6sampai59Bulan = [
    Question('Apakah anak memiliki akta kelahiran', true),
    Question(
        'Apakah anak anda suda mendapat Imnuisasi Campak,PCV 3,Polioo suntik 2,DPT lanjutan,Campak lanjuta?',
        true),
    Question(
        'Apakah anak anda rutin setiap bulan ke posyandu/puskesmas ?', true),
    Question('Apakah berat badan anak anda naik bulan ini ?', true),
    Question(
        'Apakah anda mengetahui tentang Makanan Pendamping ASI dan makanan Tambahan ?',
        true),
    Question(
        'Apakkah anak anda makan nasi,sayur ,ikan ,daging,buah,setiap hari ?',
        true),
    Question(
        'Apakah anda mengerti,asupan Gizi pada anak kurang dapat menyebabkab stunting ?',
        true),
    Question('Apakah anak anda makan 3 kali sehari ?', true),
    Question(
        'Apakah dalam selama 3 jam dalam sehari anda menghabiskan waktu bersama anak tanpa orang lain yang besama anak ?',
        true),
    Question('Apakah air Minum yang di Konsumsi di rumah di rebus ?', true),
    Question(
        'Apakah air minum yang di konsumsi berwarna,berbau,dan berasa ?', true),
    Question(
        'Apakah tempat sampah anda di rumah tertutup dan terdapat sampah basah dan kering ',
        true),
    Question(
        'Apakah anda membuanag samapah dengan cara di bunag ke tempat sampah? ',
        true),
    Question(
        'Jika anak anda sakit batu,pilek demam,apakah anda membawa langsung ke Puskesmas/RSUD/Klinik dokter ? ',
        true),
    Question(
        'Jika anak anda Diare,demam,sakit perut,anda langsung membawa ke Puskesmas/RSUD/Klinik Swasta ?',
        true),
    Question(
        'Jika anak anda Diare,demam,sakit perut,anda langsung membawa ke Puskesmas/RSUD/Klinik Swasta ?',
        true),
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

class MulaiQuis {
  int _quistotal = 0;
  int ageMonths = 0;
  int get quistotal => _quistotal;
  Future<void> initializeData() async {
    // Tunggu pemanggilan DatabaseHelper().getAgeMonths() selesai
    await initializeDataQuestions();
  }

  MulaiQuis() {
    initializeDataQuestions();
  }

  Future<void> initializeDataQuestions() async {
    ageMonths = await DatabaseHelper().getAgeMonths();
    if (ageMonths >= 0 && ageMonths <= 6) {
      _quistotal = 13;
    } else if (ageMonths >= 7 && ageMonths <= 59) {
      _quistotal = 15;
    }
    print('RENDER DB BULAN = $ageMonths');
  }
}
