class QuizResult {
  int? id;
  int score;
  String date;
  String status;

  QuizResult(
      {this.id, required this.score, required this.date, required this.status});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'score': score,
      'date': date,
      'status': status,
    };
  }

  factory QuizResult.fromMap(Map<String, dynamic> map) {
    return QuizResult(
      id: map['id'],
      score: map['score'],
      date: map['date'],
      status: map['status'],
    );
  }
}
