import 'package:flutter/material.dart';

import '../utils/question.dart';
import '../utils/quiz.dart';

import '../UI/answer_button.dart';
import '../UI/question_text.dart';
import '../UI/correct_wrong_overlay.dart';

import './score_page.dart';

class QuizPage extends StatefulWidget {
  @override
  State createState() => new QuizPageState();

}

class QuizPageState extends State<QuizPage> {

  Question currentQuestion;
  Quiz quiz = new Quiz([
    new Question("Lightning never strikes in the same place twice.", false),
    new Question("If you cry in space the tears just stick to your face.", true),
    new Question("If you cut an earthworm in half, both halves can regrow their body.", false),
    new Question("Humans can distinguish between over a trillion different smells.", true),
    new Question("Adults have fewer bones than babies do.", true),
    new Question("Napoleon Bonaparte was extremely short.", false),
    new Question("Goldfish only have a memory of three seconds.", false),
    new Question("There are more cells of bacteria in your body than there are human cells.", true),
    new Question("Your fingernails and hair keep growing after you die.", false),
    new Question("Birds are dinosaurs.", true),
    new Question("Ajay Poudel is in Pokhara.", true),
    new Question("Swatantra is high. Are you high bruh ? LOL.", true),
    new Question("Buzz Aldrin was the first man to urinate on the moon.", true),
    new Question("Twinkies have an infinite shelf life.", false),
    new Question("Humans can’t breathe and swallow at the same time.", true),
    new Question("The top of the Eiffel Tower leans away from the sun.", true),
    new Question("Drinking alcohol kills brain cells.", false),
    new Question("Sangam has more accurate database than all of Google.", true),
    new Question("Khadke is stronger than Super-Man.", true),
    new Question("Bimal was drunk on the Holi of 2074", true)
  ]);
  String questionText;
  int questionNumber;
  bool isCorrect;
  bool overlayShouldBeVisible = false;

  @override
  void initState() {
    super.initState();
    currentQuestion = quiz.nextQuestion;
    questionText = currentQuestion.question;
    questionNumber = quiz.questionNumber;

  }

  void handleAnswer(bool answer) {
    isCorrect = (currentQuestion.answer == answer);
    quiz.answer(isCorrect);
    this.setState(() {
      overlayShouldBeVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column( // this is main page
          children: <Widget>[
            new AnswerButton(true, () => handleAnswer(true)),
            new QuestionText(questionText, questionNumber),
            new AnswerButton(false, () => handleAnswer(false)),
          ],
        ),
        overlayShouldBeVisible == true ? new CorrectWrongOverlay(
          isCorrect,
          () {
            if (quiz.length == questionNumber) {
              Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new ScorePage(quiz.score, quiz.length)), (Route route) => route == null);
              return;
            }
            currentQuestion = quiz.nextQuestion;
            this.setState(() {
              overlayShouldBeVisible = false;
              questionText = currentQuestion.question;
              questionNumber = quiz.questionNumber;
            });
          }
        ) : new Container()
      ],
    );
  }

}