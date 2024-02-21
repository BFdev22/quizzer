import 'question.dart';

class QuizBrain {
  List<Question> _questions = [
    Question(
        texte: "Le piton des neiges est un volcan de la Réunion ?",
        reponse: true),
    Question(
        texte: "Flutter permet de faire des applications web également ?",
        reponse: true),
    Question(texte: "Php est le langage utilisé par Flutter ?", reponse: false)
  ];

  int _questionNumber = 0;

  String getQuestionText() {
    return _questions[_questionNumber].texte;
  }

  bool getAnswer() {
    return _questions[_questionNumber].reponse;
  }

  void nextQuestion() {
    print(_questionNumber);
    if (_questionNumber < _questions.length - 1) {
      _questionNumber++;
    }
  }

  bool isLastQuestion() {
    return _questionNumber == _questions.length - 1;
  }

  void resetQuiz() {
    _questionNumber = 0;
  }
}
