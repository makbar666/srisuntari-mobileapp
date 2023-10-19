import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;
  List<String> userQuestions = [];
  List<bool> userAnswers = [];

  List<Question> _questionBank = [
    Question('Apakah anak anda lahir di fasilitas pelayanan kesehatan?', true),
    Question('Apakah anak anda memiliki akta kelahiran ?', true),
    Question(
        'Apakah berat badan anak saat lahir berkisar 2,5 s/d 3,9 kg ?', true),
    Question('Apakah panjang badan anak saat lahir berkisar 46,1 s/d 55,6 cm ?',
        true),
    Question(
        'Apakah ukuran lingkar kepala anak saat lahir berkisar 31,9 s/d 37,0 cm?',
        true),
    Question('Apakah anak anda sudah di imunisasi BCG dan OPV1 ?', true),
    Question('Apakah anak anda hanya memperoleh ASI saja ?', true),
    Question(
        'Apakah anak anda berkunjung ke fasilitas kesehatan setiap bulan (posyandu dan puskesmas) ',
        true),
    Question(
        'Apakah Anda memberikan Makanan/ASI kepada anak sebanyak 8 sampai 12 kali sehari ?',
        true),
    Question(
        'Dimana ibu biasa membuang sampah Ganti – Apakah Anda membuang sampah di tempat sampah yang disediakan pemerintah atau galian pembakaran sampah yang jauh dari rumah ?',
        true),
    Question(
        'Apakah di Rumah Anda memiliki tempat sampah yang tertutup ?  ', true),
    Question(
        'Apakah  Anak pernah menderita sakit batuk, pilek dan demam dalam 6 bulan terakhir? Jika Ya apakah Anda membawa Anak Anda ke Fasilitas Kesehatan seperti Puskesmas/ RSUD/ Klinik ?',
        true),
    Question(
        'Apakah anak sering mengalami diare, demam, sakit perut dan penurunan nafsu makan dan berobat di mana ?',
        true),
    // Question('Apakah Luis Tanvan', true),
    // Question('Apakah Luis Tanvan', true),
    // Question('Apakah Luis Tanvan', true),
    // Question('Apakah Luis Tanvan', true),
    // Question('Apakah Luis Tanvan', true),
    // Question('Apakah Luis Tanvan', true),
    // Question('Apakah Luis Tanvan', true),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      print('Now returning true');
      return true;
    } else {
      return false;
    }
  }

  void checksoal(bool userPickedAnswer) {
    userQuestions.add(_questionBank[_questionNumber].questionText);
    userAnswers.add(userPickedAnswer);
  }

  void reset() {
    _questionNumber = 0;
  }
}
