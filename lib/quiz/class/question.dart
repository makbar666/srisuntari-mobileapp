class Question {
  String questionText;
  List<String> options;
  List<int> scores;
  int correctAnswerIndex;
  Map<int, List<int>>
      jumpToQuestionIndices; // Gunakan Map untuk menentukan pertanyaan yang harus dilompati

  Question(
      this.questionText, this.options, this.scores, this.correctAnswerIndex,
      {this.jumpToQuestionIndices = const {}});
}
