import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: QuizApp(),
  ));
}

class QuizApp extends StatefulWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  QuizBrain quizBrain = QuizBrain();
  List<Icon> iconList = [];

  void checkAnswer(bool reponseUser) {
    bool bonneReponse = quizBrain.getAnswer();
    setState(() {
      if (reponseUser == bonneReponse) {
        iconList.add(Icon(Icons.check, color: Colors.green));
      } else {
        iconList.add(Icon(Icons.close, color: Colors.red));
      }

      if (quizBrain.isLastQuestion()) {
        showResultAlert();
      } else {
        quizBrain.nextQuestion();
      }
    });
  }

  void showResultAlert() {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Quiz terminé",
      desc:
          "Vous avez répondu à toutes les questions. Souhaitez-vous redémarrer le quiz ?",
      buttons: [
        DialogButton(
          child: Text(
            "Redémarrer",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            setState(() {
              quizBrain.resetQuiz();
              iconList.clear();
            });
            Navigator.pop(context);
          },
          width: 120,
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Center(
                  child: Text(
                    quizBrain.getQuestionText(),
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    color: Colors.green,
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        checkAnswer(true);
                      },
                      child: Center(
                        child: Text(
                          "VRAI",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    color: Colors.red,
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        checkAnswer(false);
                      },
                      child: Center(
                        child: Text(
                          "FAUX",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Row(
                children: iconList,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
