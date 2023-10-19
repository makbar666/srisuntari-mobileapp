class QuizResult {
  int? id;
  int score;
  String date;

  QuizResult({this.id, required this.score, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'score': score,
      'date': date,
    };
  }

  factory QuizResult.fromMap(Map<String, dynamic> map) {
    return QuizResult(
      id: map['id'],
      score: map['score'],
      date: map['date'],
    );
  }
}
