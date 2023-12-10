import 'package:srisuntari_mobileapp/models/database_helper.dart';
import 'package:srisuntari_mobileapp/models/quiz_result.dart';

import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;
  int ageMonths = 0;
  int _quistotal = 0;
  String gender = "0";
  List<String> userQuestions = [];
  List<int> userAnswers = [];
  List<Question> allQuestions = [];
  int get questionNumber => _questionNumber;
  int get quistotal => _quistotal;

  Future<void> initializeQuiz() async {
    await initializeQuestions();
  }

  QuizBrain() {
    initializeQuestions();
  }
  Future<void> initializeQuestions() async {
    gender = await DatabaseHelper().getGender();
    ageMonths = await DatabaseHelper().getAgeMonths();
  }

  List<Question> get currentQuestionList {
    List<Question> questions = [];

    if (ageMonths >= 0 && ageMonths <= 5) {
      questions.addAll(_question0sampai5Bulan);
      _quistotal = 20;
    } else if (ageMonths >= 0 && ageMonths <= 23) {
      questions.addAll(_question0sampai23Bulan);
      _quistotal = 15;
    } else if (ageMonths >= 1 && ageMonths <= 3) {
      questions.addAll(_question1sampai3Bulan);
      _quistotal = 15;
    } else if (ageMonths >= 4 && ageMonths <= 6) {
      questions.addAll(_question4sampai6Bulan);
      _quistotal = 15;
    } else if (ageMonths >= 6 && ageMonths <= 23) {
      questions.addAll(_question6sampai23Bulan);
      _quistotal = 15;
    } else if (ageMonths >= 7 && ageMonths <= 10) {
      questions.addAll(_question7sampai10Bulan);
      _quistotal = 15;
    } else if (ageMonths >= 11 && ageMonths <= 59) {
      questions.addAll(_question11sampai59Bulan);
      _quistotal = 15;
    } else if (ageMonths >= 24 && ageMonths <= 59) {
      questions.addAll(_question24sampai59Bulan);
      _quistotal = 15;
    }

    return questions;
  }

  int get totalSoal => currentQuestionList.length;

  List<Question> _question0sampai5Bulan = [
    Question('Apakah anak anda lahir di fasilitas pelayanan kesehatan?',
        ['Ya', 'Tidak'], [0, 1], 0),
    Question('Apakah anak memiliki akta kelahiran', ['Ya', 'Tidak'], [0, 1], 0),
    Question(
        'Apakah berat badan lahir anak saat lahir kurang dari 2.500 gram ?',
        ['Ya', 'Tidak'],
        [0, 1],
        0),
    Question('Apakah panjang badan anak saat lahir kurang dari 48 cm ?',
        ['Ya', 'Tidak'], [0, 1], 0),
    Question('Apakah lingkar kepala anak anda saat lahir kurang dari 32 cm ?',
        ['Ya', 'Tidak'], [0, 1], 0),
    Question(
        'Apakah panjang badan / tinggi badan anak anda naik dalam 3 bulan terakhir  ?',
        ['Ya', 'Tidak'],
        [0, 1],
        0),
    Question('Apakah anak anda diperiksa perkembangannya ?', ['Ya', 'Tidak'],
        [0, 1], 0),
    // ========
    Question(
        'Apakah anak anda Pernah Ke Posyandu / pos penimbangan ?',
        [
          'a. Rutin setiap bulan',
          'b.Tidak rutin',
          'c. Jarang',
          'd. Tidak pernah'
        ],
        [0, 1, 20, 20],
        0),
    Question(
        'Apakah Anak anda diberikan Makanan Pendamping ASI ?',
        [
          'a. Tidak, Hanya ASI saja',
          'b. ASI dan Susu Formula',
          'c. Susu Formula',
          'd. Bubur Halus'
        ],
        [0, 0, 1, 20],
        0),

    // jump 1
    Question('Apakah pertumbuhan dan perkembangan anak dipantau',
        ['Ya', 'Tidak'], [0, 20], 0,
        jumpToQuestionIndices: {
          0: [10],
          1: [11],
        }),
    Question(
        'Dimana dilakukan pemantauan tumbuh kembang ?',
        [
          'a. Posyandu',
          'b. Puskesmas',
          'c. Rumah Sakit',
          'd. Klinik/ Praktek dokter',
          'e. PAUD'
        ],
        [0, 0, 0, 0, 0],
        0),
    Question(
        'Alasan tidak dipantau pertumbuhan dan perkembangan anak ?',
        [
          'a. Tidak perlu',
          'b. Tidak ada tempat yang cocok',
          'c. Tidak ada yang mengantar',
          'd. Klinik/ Praktek dokter',
          'e. Tidak tau'
        ],
        [0, 0, 0, 0, 0],
        0),

    // jump 2
    Question('Apakah anak anda  mendapat Imnuisasi bulan ini ?',
        ['Ya', 'Tidak'], [0, 20], 0,
        jumpToQuestionIndices: {
          0: [12],
          1: [13],
        }),
    Question(
        'Apakah anak anda  mendapat Imnuisasi bulan ini ?',
        [
          'a. Sesuai waktu imunisasi',
          'b. Tidak sesuai waktu imunisasi',
        ],
        [0, 1],
        0),
    Question(
        'Apakah anak anda  mendapat Imnuisasi bulan ini ?',
        [
          'a. Belum waktu imunisasi',
          'b. Imunisasi sudah lengkap',
          'c. Sudah melewati waktu imunisasi',
          'd. Tidak perlu diimunisasi',
        ],
        [0, 0, 20, 20],
        0),

    // jump 3

    Question(
        'Apakah anak anda diukur Berat Badan dan Panjang Badan / Tinggi Badan dalam 2 bulan terakhir ?',
        ['Ya', 'Tidak'],
        [0, 20],
        0,
        jumpToQuestionIndices: {
          0: [14],
          1: [15],
        }),

    Question(
        'Apakah anak anda diukur Berat Badan dan Panjang Badan / Tinggi Badan dalam 2 bulan terakhir ?',
        [
          'a. Diukur Berat Badan',
          'b. Diukur Pangjang Badan/Tinggi Badan',
          'c. Dikukur BB dan PB/TB',
        ],
        [1, 1, 0],
        0),
    Question(
        'Apakah anak anda diukur Berat Badan dan Panjang Badan / Tinggi Badan dalam 2 bulan terakhir ?',
        [
          'a. Tidak diukur 1 bulan',
          'b. Tidak diukur 2 bulan',
          'c. Tidak diukur lebih dari 2 bulan',
        ],
        [0, 1, 20],
        0),

    // jump 4

    Question('Apakah anak anda diperiksa perkembangannya ?', ['Ya', 'Tidak'],
        [0, 20], 0,
        jumpToQuestionIndices: {
          0: [16],
          1: [17],
        }),

    Question(
        'Apakah anak anda diperiksa perkembangannya ?',
        [
          'a. Perkembangan sesuai usia',
          'b. Terdapat penyimpangan / keterlambatan',
          'c. Tidak tau',
        ],
        [0, 1, 1],
        0),

    Question(
        'Apakah anak anda diperiksa perkembangannya ?',
        [
          'a. Tidak Pernah',
          'b. Tidak tau',
        ],
        [1, 1],
        0),
  ];

  List<Question> _question0sampai23Bulan = [
    Question('Apakah anak anda lahir di fasilitas pelayanan kesehatan?',
        ['Ya', 'Tidak'], [0, 1], 0),
    Question('Apakah anak memiliki akta kelahiran', ['Ya', 'Tidak'], [0, 1], 0),
    Question(
        'Apakah berat badan lahir anak saat lahir kurang dari 2.500 gram ?',
        ['Ya', 'Tidak'],
        [0, 1],
        0),
    Question('Apakah panjang badan anak saat lahir kurang dari 48 cm ?',
        ['Ya', 'Tidak'], [0, 1], 0),
    Question('Apakah lingkar kepala anak anda saat lahir kurang dari 32 cm ?',
        ['Ya', 'Tidak'], [0, 1], 0),
    Question(
        'Apakah panjang badan / tinggi badan anak anda naik dalam 3 bulan terakhir  ?',
        ['Ya', 'Tidak'],
        [0, 1],
        0),
    Question('Apakah anak anda diperiksa perkembangannya ?', ['Ya', 'Tidak'],
        [0, 1], 0),
    Question(
        'Apakah panjang badan / tinggi badan anak anda naik dalam 3 bulan terakhir  ?',
        ['Ya', 'Tidak'],
        [0, 1],
        0),
    Question(
        'Apakah anak anda Pernah Ke Posyandu / pos penimbangan ?',
        [
          'a. Rutin setiap bulan',
          'b.Tidak rutin',
          'c. Jarang',
          'd. Tidak pernah'
        ],
        [0, 1, 20, 20],
        0),
    Question(
        'Apakah anak anda minum Asi',
        [
          'a. Masih minum ASI ',
          'b. Minum Susu Formula',
          'c. Minum ASI campur Susu Formula',
          'c. Tidak minum susu'
        ],
        [0, 0, 0, 20],
        0),
    // jump 1
    Question('Apakah pertumbuhan dan perkembangan anak dipantau',
        ['Ya', 'Tidak'], [0, 20], 0,
        jumpToQuestionIndices: {
          0: [11],
          1: [12],
        }),
    Question(
        'Dimana dilakukan pemantauan tumbuh kembang ?',
        [
          'a. Posyandu',
          'b. Puskesmas',
          'c. Rumah Sakit',
          'd. Klinik/ Praktek dokter',
          'e. PAUD'
        ],
        [0, 0, 0, 0, 0],
        0),
    Question(
        'Alasan tidak dipantau pertumbuhan dan perkembangan anak ?',
        [
          'a. Tidak perlu',
          'b. Tidak ada tempat yang cocok',
          'c. Tidak ada yang mengantar',
          'd. Klinik/ Praktek dokter',
          'e. Tidak tau'
        ],
        [0, 0, 0, 0, 0],
        0),

    // jump 2
    Question('Apakah anak anda  mendapat Imnuisasi bulan ini ?',
        ['Ya', 'Tidak'], [0, 20], 0,
        jumpToQuestionIndices: {
          0: [13],
          1: [14],
        }),
    Question(
        'Apakah anak anda  mendapat Imnuisasi bulan ini ?',
        [
          'a. Sesuai waktu imunisasi',
          'b. Tidak sesuai waktu imunisasi',
        ],
        [0, 1],
        0),
    Question(
        'Apakah anak anda  mendapat Imnuisasi bulan ini ?',
        [
          'a. Belum waktu imunisasi',
          'b. Imunisasi sudah lengkap',
          'c. Sudah melewati waktu imunisasi',
          'd. Tidak perlu diimunisasi',
        ],
        [0, 0, 20, 20],
        0),

    // jump 3

    Question(
        'Apakah anak anda diukur Berat Badan dan Panjang Badan / Tinggi Badan dalam 2 bulan terakhir ?',
        ['Ya', 'Tidak'],
        [0, 20],
        0,
        jumpToQuestionIndices: {
          0: [15],
          1: [16],
        }),

    Question(
        'Apakah anak anda diukur Berat Badan dan Panjang Badan / Tinggi Badan dalam 2 bulan terakhir ?',
        [
          'a. Diukur Berat Badan',
          'b. Diukur Pangjang Badan/Tinggi Badan',
          'c. Dikukur BB dan PB/TB',
        ],
        [1, 1, 0],
        0),
    Question(
        'Apakah anak anda diukur Berat Badan dan Panjang Badan / Tinggi Badan dalam 2 bulan terakhir ?',
        [
          'a. Tidak diukur 1 bulan',
          'b. Tidak diukur 2 bulan',
          'c. Tidak diukur lebih dari 2 bulan',
        ],
        [0, 1, 20],
        0),

    // jump 4

    Question('Apakah anak anda diperiksa perkembangannya ?', ['Ya', 'Tidak'],
        [0, 20], 0,
        jumpToQuestionIndices: {
          0: [17],
          1: [18],
        }),

    Question(
        'Apakah anak anda diperiksa perkembangannya ?',
        [
          'a. Perkembangan sesuai usia',
          'b. Terdapat penyimpangan / keterlambatan',
          'c. Tidak tau',
        ],
        [0, 1, 1],
        0),

    Question(
        'Apakah anak anda diperiksa perkembangannya ?',
        [
          'a. Tidak Pernah',
          'b. Tidak tau',
        ],
        [1, 1],
        0),
  ];

  List<Question> _question1sampai3Bulan = [
    Question('Apakah anak anda lahir di fasilitas pelayanan kesehatan?',
        ['Ya', 'Tidak'], [0, 1], 0),
    Question('Apakah anak memiliki akta kelahiran', ['Ya', 'Tidak'], [0, 1], 0),
    Question(
        'Apakah berat badan lahir anak saat lahir kurang dari 2.500 gram ?',
        ['Ya', 'Tidak'],
        [0, 1],
        0),
    Question('Apakah panjang badan anak saat lahir kurang dari 48 cm ?',
        ['Ya', 'Tidak'], [0, 1], 0),
    Question('Apakah lingkar kepala anak anda saat lahir kurang dari 32 cm ?',
        ['Ya', 'Tidak'], [0, 1], 0),
    Question(
        'Apakah panjang badan / tinggi badan anak anda naik dalam 3 bulan terakhir  ?',
        ['Ya', 'Tidak'],
        [0, 1],
        0),
    Question('Apakah anak anda diperiksa perkembangannya ?', ['Ya', 'Tidak'],
        [0, 1], 0),
    Question(
        'Apakah anak anda Pernah Ke Posyandu / pos penimbangan ?',
        [
          'a. Rutin setiap bulan',
          'b.Tidak rutin',
          'c. Jarang',
          'd. Tidak pernah'
        ],
        [0, 1, 20, 20],
        0),
    Question(
        'Apakah berat badan anak anda naik  dalam 2 bulan terakhir ?',
        [
          'a. Tidak Naik',
          'b. Naik 100 - 700 gram per bulan',
          'c. Naik 800 - 900 gram per bulan',
          'd. Naik lebih dari 900 gram per bulan'
        ],
        [20, 20, 0, 0],
        0),

    // jump 1
    Question('Apakah pertumbuhan dan perkembangan anak dipantau',
        ['Ya', 'Tidak'], [0, 20], 0,
        jumpToQuestionIndices: {
          0: [10],
          1: [11],
        }),
    Question(
        'Dimana dilakukan pemantauan tumbuh kembang ?',
        [
          'a. Posyandu',
          'b. Puskesmas',
          'c. Rumah Sakit',
          'd. Klinik/ Praktek dokter',
          'e. PAUD'
        ],
        [0, 0, 0, 0, 0],
        0),
    Question(
        'Alasan tidak dipantau pertumbuhan dan perkembangan anak ?',
        [
          'a. Tidak perlu',
          'b. Tidak ada tempat yang cocok',
          'c. Tidak ada yang mengantar',
          'd. Klinik/ Praktek dokter',
          'e. Tidak tau'
        ],
        [0, 0, 0, 0, 0],
        0),

    // jump 2
    Question('Apakah anak anda  mendapat Imnuisasi bulan ini ?',
        ['Ya', 'Tidak'], [0, 20], 0,
        jumpToQuestionIndices: {
          0: [12],
          1: [13],
        }),
    Question(
        'Apakah anak anda  mendapat Imnuisasi bulan ini ?',
        [
          'a. Sesuai waktu imunisasi',
          'b. Tidak sesuai waktu imunisasi',
        ],
        [0, 1],
        0),
    Question(
        'Apakah anak anda  mendapat Imnuisasi bulan ini ?',
        [
          'a. Belum waktu imunisasi',
          'b. Imunisasi sudah lengkap',
          'c. Sudah melewati waktu imunisasi',
          'd. Tidak perlu diimunisasi',
        ],
        [0, 0, 20, 20],
        0),

    // jump 3

    Question(
        'Apakah anak anda diukur Berat Badan dan Panjang Badan / Tinggi Badan dalam 2 bulan terakhir ?',
        ['Ya', 'Tidak'],
        [0, 20],
        0,
        jumpToQuestionIndices: {
          0: [14],
          1: [15],
        }),

    Question(
        'Apakah anak anda diukur Berat Badan dan Panjang Badan / Tinggi Badan dalam 2 bulan terakhir ?',
        [
          'a. Diukur Berat Badan',
          'b. Diukur Pangjang Badan/Tinggi Badan',
          'c. Dikukur BB dan PB/TB',
        ],
        [1, 1, 0],
        0),
    Question(
        'Apakah anak anda diukur Berat Badan dan Panjang Badan / Tinggi Badan dalam 2 bulan terakhir ?',
        [
          'a. Tidak diukur 1 bulan',
          'b. Tidak diukur 2 bulan',
          'c. Tidak diukur lebih dari 2 bulan',
        ],
        [0, 1, 20],
        0),

    // jump 4

    Question('Apakah anak anda diperiksa perkembangannya ?', ['Ya', 'Tidak'],
        [0, 20], 0,
        jumpToQuestionIndices: {
          0: [16],
          1: [17],
        }),

    Question(
        'Apakah anak anda diperiksa perkembangannya ?',
        [
          'a. Perkembangan sesuai usia',
          'b. Terdapat penyimpangan / keterlambatan',
          'c. Tidak tau',
        ],
        [0, 1, 1],
        0),

    Question(
        'Apakah anak anda diperiksa perkembangannya ?',
        [
          'a. Tidak Pernah',
          'b. Tidak tau',
        ],
        [1, 1],
        0),

    // ========
  ];

  List<Question> _question4sampai6Bulan = [
    Question('Apakah anak anda lahir di fasilitas pelayanan kesehatan?',
        ['Ya', 'Tidak'], [0, 1], 0),
    Question('Apakah anak memiliki akta kelahiran', ['Ya', 'Tidak'], [0, 1], 0),
    Question(
        'Apakah berat badan lahir anak saat lahir kurang dari 2.500 gram ?',
        ['Ya', 'Tidak'],
        [0, 1],
        0),
    Question('Apakah panjang badan anak saat lahir kurang dari 48 cm ?',
        ['Ya', 'Tidak'], [0, 1], 0),
    Question('Apakah lingkar kepala anak anda saat lahir kurang dari 32 cm ?',
        ['Ya', 'Tidak'], [0, 1], 0),
    Question(
        'Apakah panjang badan / tinggi badan anak anda naik dalam 3 bulan terakhir  ?',
        ['Ya', 'Tidak'],
        [0, 1],
        0),
    Question('Apakah anak anda diperiksa perkembangannya ?', ['Ya', 'Tidak'],
        [0, 1], 0),
    Question(
        'Apakah anak anda Pernah Ke Posyandu / pos penimbangan ?',
        [
          'a. Rutin setiap bulan',
          'b.Tidak rutin',
          'c. Jarang',
          'd. Tidak pernah'
        ],
        [0, 1, 20, 20],
        0),
    Question(
        'Apakah berat badan anak anda naik  dalam 2 bulan terakhir ?',
        [
          'a. Tidak Naik',
          'b. Naik 50 - 350 gram per bulan',
          'c. Naik 400 - 600 gram per bulan',
          'd. Naik lebih dari 600 gram per bulan'
        ],
        [20, 20, 0, 0],
        0),
    // ========

    // jump 1
    Question('Apakah pertumbuhan dan perkembangan anak dipantau',
        ['Ya', 'Tidak'], [0, 20], 0,
        jumpToQuestionIndices: {
          0: [10],
          1: [11],
        }),
    Question(
        'Dimana dilakukan pemantauan tumbuh kembang ?',
        [
          'a. Posyandu',
          'b. Puskesmas',
          'c. Rumah Sakit',
          'd. Klinik/ Praktek dokter',
          'e. PAUD'
        ],
        [0, 0, 0, 0, 0],
        0),
    Question(
        'Alasan tidak dipantau pertumbuhan dan perkembangan anak ?',
        [
          'a. Tidak perlu',
          'b. Tidak ada tempat yang cocok',
          'c. Tidak ada yang mengantar',
          'd. Klinik/ Praktek dokter',
          'e. Tidak tau'
        ],
        [0, 0, 0, 0, 0],
        0),

    // jump 2
    Question('Apakah anak anda  mendapat Imnuisasi bulan ini ?',
        ['Ya', 'Tidak'], [0, 20], 0,
        jumpToQuestionIndices: {
          0: [12],
          1: [13],
        }),
    Question(
        'Apakah anak anda  mendapat Imnuisasi bulan ini ?',
        [
          'a. Sesuai waktu imunisasi',
          'b. Tidak sesuai waktu imunisasi',
        ],
        [0, 1],
        0),
    Question(
        'Apakah anak anda  mendapat Imnuisasi bulan ini ?',
        [
          'a. Belum waktu imunisasi',
          'b. Imunisasi sudah lengkap',
          'c. Sudah melewati waktu imunisasi',
          'd. Tidak perlu diimunisasi',
        ],
        [0, 0, 20, 20],
        0),

    // jump 3

    Question(
        'Apakah anak anda diukur Berat Badan dan Panjang Badan / Tinggi Badan dalam 2 bulan terakhir ?',
        ['Ya', 'Tidak'],
        [0, 20],
        0,
        jumpToQuestionIndices: {
          0: [14],
          1: [15],
        }),

    Question(
        'Apakah anak anda diukur Berat Badan dan Panjang Badan / Tinggi Badan dalam 2 bulan terakhir ?',
        [
          'a. Diukur Berat Badan',
          'b. Diukur Pangjang Badan/Tinggi Badan',
          'c. Dikukur BB dan PB/TB',
        ],
        [1, 1, 0],
        0),
    Question(
        'Apakah anak anda diukur Berat Badan dan Panjang Badan / Tinggi Badan dalam 2 bulan terakhir ?',
        [
          'a. Tidak diukur 1 bulan',
          'b. Tidak diukur 2 bulan',
          'c. Tidak diukur lebih dari 2 bulan',
        ],
        [0, 1, 20],
        0),

    // jump 4

    Question('Apakah anak anda diperiksa perkembangannya ?', ['Ya', 'Tidak'],
        [0, 20], 0,
        jumpToQuestionIndices: {
          0: [16],
          1: [17],
        }),

    Question(
        'Apakah anak anda diperiksa perkembangannya ?',
        [
          'a. Perkembangan sesuai usia',
          'b. Terdapat penyimpangan / keterlambatan',
          'c. Tidak tau',
        ],
        [0, 1, 1],
        0),

    Question(
        'Apakah anak anda diperiksa perkembangannya ?',
        [
          'a. Tidak Pernah',
          'b. Tidak tau',
        ],
        [1, 1],
        0),
  ];

  List<Question> _question6sampai23Bulan = [
    Question('Apakah anak anda lahir di fasilitas pelayanan kesehatan?',
        ['Ya', 'Tidak'], [0, 1], 0),
    Question('Apakah anak memiliki akta kelahiran', ['Ya', 'Tidak'], [0, 1], 0),
    Question(
        'Apakah berat badan lahir anak saat lahir kurang dari 2.500 gram ?',
        ['Ya', 'Tidak'],
        [0, 1],
        0),
    Question('Apakah panjang badan anak saat lahir kurang dari 48 cm ?',
        ['Ya', 'Tidak'], [0, 1], 0),
    Question('Apakah lingkar kepala anak anda saat lahir kurang dari 32 cm ?',
        ['Ya', 'Tidak'], [0, 1], 0),
    Question(
        'Apakah panjang badan / tinggi badan anak anda naik dalam 3 bulan terakhir  ?',
        ['Ya', 'Tidak'],
        [0, 1],
        0),
    Question('Apakah anak anda diperiksa perkembangannya ?', ['Ya', 'Tidak'],
        [0, 1], 0),
    Question(
        'Apakah anak anda Pernah Ke Posyandu / pos penimbangan ?',
        [
          'a. Rutin setiap bulan',
          'b.Tidak rutin',
          'c. Jarang',
          'd. Tidak pernah'
        ],
        [0, 1, 20, 20],
        0),
    // ========
    Question(
        'Apakah Anak anda diberikan Makanan Pendamping ASI ?',
        [
          'a. Belum diberikan makanan',
          'b.  Diberikan makan tanpa susu',
          'c. Susu Formula dan Makan',
          'd. ASI dan Makan',
          'e. ASI, Susu Formula dan makan'
        ],
        [20, 20, 1, 0, 0],
        0),

    // jump 1
    Question('Apakah pertumbuhan dan perkembangan anak dipantau',
        ['Ya', 'Tidak'], [0, 20], 0,
        jumpToQuestionIndices: {
          0: [10],
          1: [11],
        }),
    Question(
        'Dimana dilakukan pemantauan tumbuh kembang ?',
        [
          'a. Posyandu',
          'b. Puskesmas',
          'c. Rumah Sakit',
          'd. Klinik/ Praktek dokter',
          'e. PAUD'
        ],
        [0, 0, 0, 0, 0],
        0),
    Question(
        'Alasan tidak dipantau pertumbuhan dan perkembangan anak ?',
        [
          'a. Tidak perlu',
          'b. Tidak ada tempat yang cocok',
          'c. Tidak ada yang mengantar',
          'd. Klinik/ Praktek dokter',
          'e. Tidak tau'
        ],
        [0, 0, 0, 0, 0],
        0),

    // jump 2
    Question('Apakah anak anda  mendapat Imnuisasi bulan ini ?',
        ['Ya', 'Tidak'], [0, 20], 0,
        jumpToQuestionIndices: {
          0: [12],
          1: [13],
        }),
    Question(
        'Apakah anak anda  mendapat Imnuisasi bulan ini ?',
        [
          'a. Sesuai waktu imunisasi',
          'b. Tidak sesuai waktu imunisasi',
        ],
        [0, 1],
        0),
    Question(
        'Apakah anak anda  mendapat Imnuisasi bulan ini ?',
        [
          'a. Belum waktu imunisasi',
          'b. Imunisasi sudah lengkap',
          'c. Sudah melewati waktu imunisasi',
          'd. Tidak perlu diimunisasi',
        ],
        [0, 0, 20, 20],
        0),

    // jump 3

    Question(
        'Apakah anak anda diukur Berat Badan dan Panjang Badan / Tinggi Badan dalam 2 bulan terakhir ?',
        ['Ya', 'Tidak'],
        [0, 20],
        0,
        jumpToQuestionIndices: {
          0: [14],
          1: [15],
        }),

    Question(
        'Apakah anak anda diukur Berat Badan dan Panjang Badan / Tinggi Badan dalam 2 bulan terakhir ?',
        [
          'a. Diukur Berat Badan',
          'b. Diukur Pangjang Badan/Tinggi Badan',
          'c. Dikukur BB dan PB/TB',
        ],
        [1, 1, 0],
        0),
    Question(
        'Apakah anak anda diukur Berat Badan dan Panjang Badan / Tinggi Badan dalam 2 bulan terakhir ?',
        [
          'a. Tidak diukur 1 bulan',
          'b. Tidak diukur 2 bulan',
          'c. Tidak diukur lebih dari 2 bulan',
        ],
        [0, 1, 20],
        0),

    // jump 4

    Question('Apakah anak anda diperiksa perkembangannya ?', ['Ya', 'Tidak'],
        [0, 20], 0,
        jumpToQuestionIndices: {
          0: [16],
          1: [17],
        }),

    Question(
        'Apakah anak anda diperiksa perkembangannya ?',
        [
          'a. Perkembangan sesuai usia',
          'b. Terdapat penyimpangan / keterlambatan',
          'c. Tidak tau',
        ],
        [0, 1, 1],
        0),

    Question(
        'Apakah anak anda diperiksa perkembangannya ?',
        [
          'a. Tidak Pernah',
          'b. Tidak tau',
        ],
        [1, 1],
        0),
  ];

  List<Question> _question7sampai10Bulan = [
    Question('Apakah anak anda lahir di fasilitas pelayanan kesehatan?',
        ['Ya', 'Tidak'], [0, 1], 0),
    Question('Apakah anak memiliki akta kelahiran', ['Ya', 'Tidak'], [0, 1], 0),
    Question(
        'Apakah berat badan lahir anak saat lahir kurang dari 2.500 gram ?',
        ['Ya', 'Tidak'],
        [0, 1],
        0),
    Question('Apakah panjang badan anak saat lahir kurang dari 48 cm ?',
        ['Ya', 'Tidak'], [0, 1], 0),
    Question('Apakah lingkar kepala anak anda saat lahir kurang dari 32 cm ?',
        ['Ya', 'Tidak'], [0, 1], 0),
    Question(
        'Apakah panjang badan / tinggi badan anak anda naik dalam 3 bulan terakhir  ?',
        ['Ya', 'Tidak'],
        [0, 1],
        0),
    Question('Apakah anak anda diperiksa perkembangannya ?', ['Ya', 'Tidak'],
        [0, 1], 0),
    Question(
        'Apakah anak anda Pernah Ke Posyandu / pos penimbangan ?',
        [
          'a. Rutin setiap bulan',
          'b.Tidak rutin',
          'c. Jarang',
          'd. Tidak pernah'
        ],
        [0, 1, 20, 20],
        0),
    Question(
        'Apakah berat badan anak anda naik  dalam 2 bulan terakhir ?',
        [
          'a. Tidak Naik',
          'b. Naik 50 - 250 gram per bulan',
          'c. Naik 300  gram per bulan',
          'd. Naik lebih dari 300 gram per bulan'
        ],
        [20, 20, 0, 0],
        0),
    // ========

    // jump 1
    Question('Apakah pertumbuhan dan perkembangan anak dipantau',
        ['Ya', 'Tidak'], [0, 20], 0,
        jumpToQuestionIndices: {
          0: [10],
          1: [11],
        }),
    Question(
        'Dimana dilakukan pemantauan tumbuh kembang ?',
        [
          'a. Posyandu',
          'b. Puskesmas',
          'c. Rumah Sakit',
          'd. Klinik/ Praktek dokter',
          'e. PAUD'
        ],
        [0, 0, 0, 0, 0],
        0),
    Question(
        'Alasan tidak dipantau pertumbuhan dan perkembangan anak ?',
        [
          'a. Tidak perlu',
          'b. Tidak ada tempat yang cocok',
          'c. Tidak ada yang mengantar',
          'd. Klinik/ Praktek dokter',
          'e. Tidak tau'
        ],
        [0, 0, 0, 0, 0],
        0),

    // jump 2
    Question('Apakah anak anda  mendapat Imnuisasi bulan ini ?',
        ['Ya', 'Tidak'], [0, 20], 0,
        jumpToQuestionIndices: {
          0: [12],
          1: [13],
        }),
    Question(
        'Apakah anak anda  mendapat Imnuisasi bulan ini ?',
        [
          'a. Sesuai waktu imunisasi',
          'b. Tidak sesuai waktu imunisasi',
        ],
        [0, 1],
        0),
    Question(
        'Apakah anak anda  mendapat Imnuisasi bulan ini ?',
        [
          'a. Belum waktu imunisasi',
          'b. Imunisasi sudah lengkap',
          'c. Sudah melewati waktu imunisasi',
          'd. Tidak perlu diimunisasi',
        ],
        [0, 0, 20, 20],
        0),

    // jump 3

    Question(
        'Apakah anak anda diukur Berat Badan dan Panjang Badan / Tinggi Badan dalam 2 bulan terakhir ?',
        ['Ya', 'Tidak'],
        [0, 20],
        0,
        jumpToQuestionIndices: {
          0: [14],
          1: [15],
        }),

    Question(
        'Apakah anak anda diukur Berat Badan dan Panjang Badan / Tinggi Badan dalam 2 bulan terakhir ?',
        [
          'a. Diukur Berat Badan',
          'b. Diukur Pangjang Badan/Tinggi Badan',
          'c. Dikukur BB dan PB/TB',
        ],
        [1, 1, 0],
        0),
    Question(
        'Apakah anak anda diukur Berat Badan dan Panjang Badan / Tinggi Badan dalam 2 bulan terakhir ?',
        [
          'a. Tidak diukur 1 bulan',
          'b. Tidak diukur 2 bulan',
          'c. Tidak diukur lebih dari 2 bulan',
        ],
        [0, 1, 20],
        0),

    // jump 4

    Question('Apakah anak anda diperiksa perkembangannya ?', ['Ya', 'Tidak'],
        [0, 20], 0,
        jumpToQuestionIndices: {
          0: [16],
          1: [17],
        }),

    Question(
        'Apakah anak anda diperiksa perkembangannya ?',
        [
          'a. Perkembangan sesuai usia',
          'b. Terdapat penyimpangan / keterlambatan',
          'c. Tidak tau',
        ],
        [0, 1, 1],
        0),

    Question(
        'Apakah anak anda diperiksa perkembangannya ?',
        [
          'a. Tidak Pernah',
          'b. Tidak tau',
        ],
        [1, 1],
        0),
  ];

  List<Question> _question11sampai59Bulan = [
    Question('Apakah anak anda lahir di fasilitas pelayanan kesehatan?',
        ['Ya', 'Tidak'], [0, 1], 0),
    Question('Apakah anak memiliki akta kelahiran', ['Ya', 'Tidak'], [0, 1], 0),
    Question(
        'Apakah berat badan lahir anak saat lahir kurang dari 2.500 gram ?',
        ['Ya', 'Tidak'],
        [0, 1],
        0),
    Question('Apakah panjang badan anak saat lahir kurang dari 48 cm ?',
        ['Ya', 'Tidak'], [0, 1], 0),
    Question('Apakah lingkar kepala anak anda saat lahir kurang dari 32 cm ?',
        ['Ya', 'Tidak'], [0, 1], 0),
    Question(
        'Apakah panjang badan / tinggi badan anak anda naik dalam 3 bulan terakhir  ?',
        ['Ya', 'Tidak'],
        [0, 1],
        0),
    Question('Apakah anak anda diperiksa perkembangannya ?', ['Ya', 'Tidak'],
        [0, 1], 0),
    Question(
        'Apakah anak anda Pernah Ke Posyandu / pos penimbangan ?',
        [
          'a. Rutin setiap bulan',
          'b.Tidak rutin',
          'c. Jarang',
          'd. Tidak pernah'
        ],
        [0, 1, 20, 20],
        0),
    Question(
        'Apakah berat badan anak anda naik  dalam 2 bulan terakhir ?',
        [
          'a. Tidak Naik',
          'b. Naik 50 - 150 gram per bulan',
          'c. Naik 200 gram per bulan',
          'd. Naik lebih dari 200 gram per bulan'
        ],
        [20, 20, 0, 0],
        0),

    // jump 1
    Question('Apakah pertumbuhan dan perkembangan anak dipantau',
        ['Ya', 'Tidak'], [0, 20], 0,
        jumpToQuestionIndices: {
          0: [10],
          1: [11],
        }),
    Question(
        'Dimana dilakukan pemantauan tumbuh kembang ?',
        [
          'a. Posyandu',
          'b. Puskesmas',
          'c. Rumah Sakit',
          'd. Klinik/ Praktek dokter',
          'e. PAUD'
        ],
        [0, 0, 0, 0, 0],
        0),
    Question(
        'Alasan tidak dipantau pertumbuhan dan perkembangan anak ?',
        [
          'a. Tidak perlu',
          'b. Tidak ada tempat yang cocok',
          'c. Tidak ada yang mengantar',
          'd. Klinik/ Praktek dokter',
          'e. Tidak tau'
        ],
        [0, 0, 0, 0, 0],
        0),

    // jump 2
    Question('Apakah anak anda  mendapat Imnuisasi bulan ini ?',
        ['Ya', 'Tidak'], [0, 20], 0,
        jumpToQuestionIndices: {
          0: [12],
          1: [13],
        }),
    Question(
        'Apakah anak anda  mendapat Imnuisasi bulan ini ?',
        [
          'a. Sesuai waktu imunisasi',
          'b. Tidak sesuai waktu imunisasi',
        ],
        [0, 1],
        0),
    Question(
        'Apakah anak anda  mendapat Imnuisasi bulan ini ?',
        [
          'a. Belum waktu imunisasi',
          'b. Imunisasi sudah lengkap',
          'c. Sudah melewati waktu imunisasi',
          'd. Tidak perlu diimunisasi',
        ],
        [0, 0, 20, 20],
        0),

    // jump 3

    Question(
        'Apakah anak anda diukur Berat Badan dan Panjang Badan / Tinggi Badan dalam 2 bulan terakhir ?',
        ['Ya', 'Tidak'],
        [0, 20],
        0,
        jumpToQuestionIndices: {
          0: [14],
          1: [15],
        }),

    Question(
        'Apakah anak anda diukur Berat Badan dan Panjang Badan / Tinggi Badan dalam 2 bulan terakhir ?',
        [
          'a. Diukur Berat Badan',
          'b. Diukur Pangjang Badan/Tinggi Badan',
          'c. Dikukur BB dan PB/TB',
        ],
        [1, 1, 0],
        0),
    Question(
        'Apakah anak anda diukur Berat Badan dan Panjang Badan / Tinggi Badan dalam 2 bulan terakhir ?',
        [
          'a. Tidak diukur 1 bulan',
          'b. Tidak diukur 2 bulan',
          'c. Tidak diukur lebih dari 2 bulan',
        ],
        [0, 1, 20],
        0),

    // jump 4

    Question('Apakah anak anda diperiksa perkembangannya ?', ['Ya', 'Tidak'],
        [0, 20], 0,
        jumpToQuestionIndices: {
          0: [16],
          1: [17],
        }),

    Question(
        'Apakah anak anda diperiksa perkembangannya ?',
        [
          'a. Perkembangan sesuai usia',
          'b. Terdapat penyimpangan / keterlambatan',
          'c. Tidak tau',
        ],
        [0, 1, 1],
        0),

    Question(
        'Apakah anak anda diperiksa perkembangannya ?',
        [
          'a. Tidak Pernah',
          'b. Tidak tau',
        ],
        [1, 1],
        0),
    // ========
  ];

  List<Question> _question24sampai59Bulan = [
    Question('Apakah anak anda lahir di fasilitas pelayanan kesehatan?',
        ['Ya', 'Tidak'], [0, 1], 0),
    Question('Apakah anak memiliki akta kelahiran', ['Ya', 'Tidak'], [0, 1], 0),
    Question(
        'Apakah berat badan lahir anak saat lahir kurang dari 2.500 gram ?',
        ['Ya', 'Tidak'],
        [0, 1],
        0),
    Question('Apakah panjang badan anak saat lahir kurang dari 48 cm ?',
        ['Ya', 'Tidak'], [0, 1], 0),
    Question('Apakah lingkar kepala anak anda saat lahir kurang dari 32 cm ?',
        ['Ya', 'Tidak'], [0, 1], 0),
    Question(
        'Apakah panjang badan / tinggi badan anak anda naik dalam 3 bulan terakhir  ?',
        ['Ya', 'Tidak'],
        [0, 1],
        0),
    Question('Apakah anak anda diperiksa perkembangannya ?', ['Ya', 'Tidak'],
        [0, 1], 0),
    Question(
        'Apakah anak anda Pernah Ke Posyandu / pos penimbangan ?',
        [
          'a. Rutin setiap bulan',
          'b.Tidak rutin',
          'c. Jarang',
          'd. Tidak pernah'
        ],
        [0, 1, 20, 20],
        0),
    // ========
    Question('Apakah anak anda minum Asi',
        ['a. Minum Susu Formula', 'b. Tidak minum susu'], [0, 20], 0),
    Question(
        'Apakah Anak anda diberikan Makanan Pendamping ASI ?',
        [
          'a. Makan makanan dewasa',
          'b. Makan hanya bubur',
        ],
        [0, 20],
        0),
    // jump 1
    Question('Apakah pertumbuhan dan perkembangan anak dipantau',
        ['Ya', 'Tidak'], [0, 20], 0,
        jumpToQuestionIndices: {
          0: [11],
          1: [12],
        }),
    Question(
        'Dimana dilakukan pemantauan tumbuh kembang ?',
        [
          'a. Posyandu',
          'b. Puskesmas',
          'c. Rumah Sakit',
          'd. Klinik/ Praktek dokter',
          'e. PAUD'
        ],
        [0, 0, 0, 0, 0],
        0),
    Question(
        'Alasan tidak dipantau pertumbuhan dan perkembangan anak ?',
        [
          'a. Tidak perlu',
          'b. Tidak ada tempat yang cocok',
          'c. Tidak ada yang mengantar',
          'd. Klinik/ Praktek dokter',
          'e. Tidak tau'
        ],
        [0, 0, 0, 0, 0],
        0),

    // jump 2
    Question('Apakah anak anda  mendapat Imnuisasi bulan ini ?',
        ['Ya', 'Tidak'], [0, 20], 0,
        jumpToQuestionIndices: {
          0: [13],
          1: [14],
        }),
    Question(
        'Apakah anak anda  mendapat Imnuisasi bulan ini ?',
        [
          'a. Sesuai waktu imunisasi',
          'b. Tidak sesuai waktu imunisasi',
        ],
        [0, 1],
        0),
    Question(
        'Apakah anak anda  mendapat Imnuisasi bulan ini ?',
        [
          'a. Belum waktu imunisasi',
          'b. Imunisasi sudah lengkap',
          'c. Sudah melewati waktu imunisasi',
          'd. Tidak perlu diimunisasi',
        ],
        [0, 0, 20, 20],
        0),

    // jump 3

    Question(
        'Apakah anak anda diukur Berat Badan dan Panjang Badan / Tinggi Badan dalam 2 bulan terakhir ?',
        ['Ya', 'Tidak'],
        [0, 20],
        0,
        jumpToQuestionIndices: {
          0: [15],
          1: [16],
        }),

    Question(
        'Apakah anak anda diukur Berat Badan dan Panjang Badan / Tinggi Badan dalam 2 bulan terakhir ?',
        [
          'a. Diukur Berat Badan',
          'b. Diukur Pangjang Badan/Tinggi Badan',
          'c. Dikukur BB dan PB/TB',
        ],
        [1, 1, 0],
        0),
    Question(
        'Apakah anak anda diukur Berat Badan dan Panjang Badan / Tinggi Badan dalam 2 bulan terakhir ?',
        [
          'a. Tidak diukur 1 bulan',
          'b. Tidak diukur 2 bulan',
          'c. Tidak diukur lebih dari 2 bulan',
        ],
        [0, 1, 20],
        0),

    // jump 4

    Question('Apakah anak anda diperiksa perkembangannya ?', ['Ya', 'Tidak'],
        [0, 20], 0,
        jumpToQuestionIndices: {
          0: [17],
          1: [18],
        }),

    Question(
        'Apakah anak anda diperiksa perkembangannya ?',
        [
          'a. Perkembangan sesuai usia',
          'b. Terdapat penyimpangan / keterlambatan',
          'c. Tidak tau',
        ],
        [0, 1, 1],
        0),

    Question(
        'Apakah anak anda diperiksa perkembangannya ?',
        [
          'a. Tidak Pernah',
          'b. Tidak tau',
        ],
        [1, 1],
        0),
  ];

  void nextQuestion() {
    if (_questionNumber < currentQuestionList.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return currentQuestionList[_questionNumber].questionText;
  }

  List<String> getAnswerOptions() {
    return currentQuestionList[_questionNumber].options;
  }

  List<String> userSelectedOptions = []; // Add this line to declare the list

  void checksoal(int selectedAnswerIndex) {
    userQuestions.add(currentQuestionList[_questionNumber].questionText);
    userAnswers.add(selectedAnswerIndex);
    String selectedAnswer =
        currentQuestionList[_questionNumber].options[selectedAnswerIndex];
    userSelectedOptions.add(selectedAnswer);

    // Handle the jump logic here
    Map<int, List<int>> jumpToIndices =
        currentQuestionList[_questionNumber].jumpToQuestionIndices;

    if (jumpToIndices.isNotEmpty) {
      List<int>? jumpToQuestionIndices = jumpToIndices[selectedAnswerIndex];
      if (jumpToQuestionIndices != null) {
        // Jika ada pertanyaan yang harus dilompati
        _questionNumber = jumpToQuestionIndices[0];
      }
    }
  }

  Future<void> printUserAnswers() async {
    Map<int, int> scoreCount = Map();

    for (int i = 0; i < userQuestions.length; i++) {
      int score = currentQuestionList[i].scores[userAnswers[i]];
      scoreCount[score] = (scoreCount[score] ?? 0) + 1;
    }

    print('\nScore Summary:');
    scoreCount.forEach((score, count) {
      print('Score $score: $count');
    });

    int countScore0 = scoreCount[0] ?? 0;
    int countScore20 = scoreCount[20] ?? 0;

    if (countScore0 >= 4) {
      print('Status Hijau');
    } else if (countScore20 >= 4) {
      print('Status Merah');
    }

    QuizResult quizResult = QuizResult(
      score: countScore0 + countScore20,
      date: DateTime.now().toString(),
      status: countScore0 >= 4 ? 'Hijau' : 'Merah',
    );
    await DatabaseHelper().saveQuizResult(quizResult);

    DatabaseHelper().getAllQuizResults().then((value) {
      print('Quiz Results:');
      value.forEach((element) {
        print(element.toMap());
      });
    });
  }

  bool isFinished() {
    if (_questionNumber >= currentQuestionList.length - 1) {
      return true;
    } else {
      return false;
    }
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
  }
}
