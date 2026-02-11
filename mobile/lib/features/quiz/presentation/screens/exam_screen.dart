import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:permi_hub/core/theme/app_theme.dart';
import '../data/repositories/mock_quiz_provider.dart';

class QuizScreen extends ConsumerWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(quizProvider);
    final questions = quizState.questions;
    final index = quizState.currentQuestionIndex;
    final currentQuestion = questions[index];

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz PermiHub'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Indicateur de progression
            LinearProgressIndicator(
              value: (index + 1) / questions.length,
              backgroundColor: Colors.grey[200],
              color: AppTheme.primaryColor,
            ),
            const SizedBox(height: 24),
            
            // Question
            Text(
              'Question ${index + 1}/${questions.length}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              currentQuestion.text,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            
            // Options de réponse (Boutons)
            ...currentQuestion.options.asMap().entries.map((entry) {
              final optionIndex = entry.key;
              final optionText = entry.value;
              
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Logique de réponse via le Provider
                    ref.read(quizProvider.notifier).submitAnswer(optionIndex);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Fond blanc
                    foregroundColor: Colors.black87, // Texte noir
                    side: const BorderSide(color: AppTheme.primaryColor, width: 2), // Bordure violette
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    optionText,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              );
            }).toList(),
            
            const Spacer(),
            if (quizState.isCompleted)
              ElevatedButton(
                onPressed: () {
                  // Navigation vers stats ou reset
                  ref.read(quizProvider.notifier).resetQuiz();
                  context.go('/home'); // Retour accueil
                },
                child: const Text('Voir les résultats'),
              ),
          ],
        ),
      ),
    );
  }
}
