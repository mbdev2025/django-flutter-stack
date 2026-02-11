import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/question.dart';

// Définition de l'état du Quiz
class QuizState {
  final List<QuizQuestion> questions;
  final int currentQuestionIndex;
  final int score;
  final bool isCompleted;

  const QuizState({
    required this.questions,
    this.currentQuestionIndex = 0,
    this.score = 0,
    this.isCompleted = false,
  });

  QuizState copyWith({
    List<QuizQuestion>? questions,
    int? currentQuestionIndex,
    int? score,
    bool? isCompleted,
  }) {
    return QuizState(
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      score: score ?? this.score,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

// Données Mock pour le test
final List<QuizQuestion> kMockQuestions = [
  const QuizQuestion(
    id: '1',
    text: 'Quel est le taux légal maximal d\'alcoolémie pour un jeune conducteur ?',
    options: ['0.2 g/l', '0.5 g/l', '0.8 g/l', '0.0 g/l'],
    correctAnswerIndex: 0,
    explanation: 'La limite est de 0.2g/l pour les permis probatoires.',
  ),
  const QuizQuestion(
    id: '2',
    text: 'Quelle est la distance d\'arrêt à 50 km/h sur sol sec ?',
    options: ['15 m', '25 m', '35 m', '50 m'],
    correctAnswerIndex: 1,
    explanation: 'Environ 25 mètres sur sol sec (calcul approximatif : 5x5 = 25).',
  ),
];

// Le Notifier (Logique métier)
class QuizNotifier extends StateNotifier<QuizState> {
  QuizNotifier()
      : super(QuizState(questions: kMockQuestions)); // Initialisation avec données mock

  void submitAnswer(int selectedIndex) {
    if (state.isCompleted) return;

    final currentQuestion = state.questions[state.currentQuestionIndex];
    final isCorrect = selectedIndex == currentQuestion.correctAnswerIndex;
    final newScore = isCorrect ? state.score + 1 : state.score;

    if (state.currentQuestionIndex < state.questions.length - 1) {
      // Prochaine question
      state = state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex + 1,
        score: newScore,
      );
    } else {
      // Fin du quiz
      state = state.copyWith(
        score: newScore,
        isCompleted: true,
      );
    }
  }

  void resetQuiz() {
    state = QuizState(questions: kMockQuestions);
  }
}

// Le Provider global accessible partout
final quizProvider = StateNotifierProvider<QuizNotifier, QuizState>((ref) {
  return QuizNotifier();
});
