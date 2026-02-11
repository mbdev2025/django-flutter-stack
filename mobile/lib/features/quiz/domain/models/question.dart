class QuizQuestion {
  final String id;
  final String text;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;

  const QuizQuestion({
    required this.id,
    required this.text,
    required this.options,
    required this.correctAnswerIndex,
    this.explanation = '',
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      id: json['id'] as String,
      text: json['text'] as String,
      options: List<String>.from(json['options']),
      correctAnswerIndex: json['correct_index'] as int,
      explanation: json['explanation'] ?? '',
    );
  }
}
