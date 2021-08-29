import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kids_math_app/models/question_answer_model.dart';
import 'package:kids_math_app/widgets/number_of_questions_widget.dart';
import 'package:kids_math_app/widgets/questions_widget.dart';
import 'package:kids_math_app/widgets/quiz_type_widget.dart';
import 'package:kids_math_app/widgets/ready_start_widget.dart';
import 'package:kids_math_app/widgets/result_widget.dart';

class KidsHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => KidsHomePageState();
}

class KidsHomePageState extends State<KidsHomePage> {
  bool _isQuestionTypeAdd = false;
  bool _isQuestionTypeSubtract = false;
  var _numberOfQuestions;
  bool _hasQuizStarted = false;
  int _minNumber = 50;
  int _maxNumber = 99;
  int _currentDisplayedQuestion = 0;
  int _userScore = 0;
  List<QuestionAnswer> questionsAnswers = [];

  _selectQuestionType(String type) {
    // _audioCache.play('tap_sound.mp3');
    setState(() {
      if (type == "ADD") {
        _isQuestionTypeAdd = true;
      }
      if (type == "SUBTRACT") {
        _isQuestionTypeSubtract = true;
      }
    });
  }

  _selectNumberOfQuestions(int number) {
    setState(() {
      _numberOfQuestions = number;
    });
  }

  _backToQuestionsType() {
    setState(() {
      _isQuestionTypeAdd = false;
      _isQuestionTypeSubtract = false;
    });
  }

  _backToNumberOfQuestions() {
    setState(() {
      _numberOfQuestions = null;
    });
  }

  _startQuiz() {
    setState(() {
      _hasQuizStarted = false;
    });
    for (var i = 0; i < _numberOfQuestions; i++) {
      print(i);
      var random = new Random();
      int firstNumber;
      int secondNumber;
      int answerNumber;
      String questionStatement;
      bool actualAnswer;

      firstNumber = _minNumber + random.nextInt(_maxNumber - _minNumber);
      secondNumber = _minNumber + random.nextInt(_maxNumber - _minNumber);

      if (firstNumber < secondNumber && _isQuestionTypeSubtract) {
        firstNumber = secondNumber;
        secondNumber = firstNumber;
      }

      if (i == firstNumber || i == secondNumber) {
        answerNumber = _minNumber + random.nextInt(_maxNumber - _minNumber);
      } else {
        if (_isQuestionTypeAdd) {
          answerNumber = firstNumber + secondNumber;
        } else {
          answerNumber = firstNumber - secondNumber;
        }
      }

      questionStatement =
          "$firstNumber ${_isQuestionTypeAdd ? '+' : '-'} $secondNumber = $answerNumber";
      if (_isQuestionTypeAdd && answerNumber == firstNumber + secondNumber ||
          _isQuestionTypeSubtract &&
              answerNumber == firstNumber - secondNumber) {
        actualAnswer = true;
      } else {
        actualAnswer = false;
      }
      questionsAnswers.add(QuestionAnswer(questionStatement, actualAnswer));
      print(
          "$firstNumber + $secondNumber = $answerNumber ? Actual Answer will be $actualAnswer");
      setState(() {
        _hasQuizStarted = true;
      });
    }
  }

  _answerSelectedByUser(bool userAnswer) {
    print("userSelected Answer $userAnswer");
    print(
        "actual answer ${questionsAnswers[_currentDisplayedQuestion].answer}");
    if (userAnswer == questionsAnswers[_currentDisplayedQuestion].answer) {
      _userScore = _userScore + 1;
    }
    if (_currentDisplayedQuestion <= _numberOfQuestions - 1) {
      setState(() {
        _currentDisplayedQuestion = _currentDisplayedQuestion + 1;
      });
    }

    print("user Score is $_userScore");
    print("current question $_currentDisplayedQuestion");
    print("total question $_numberOfQuestions");
  }

  String _resultFace() {
    var _percentageScore = _userScore / _numberOfQuestions;
    if (_percentageScore >= 0.9) {
      return "assets/images/face_90.svg";
    }
    if (0.9 > _percentageScore && _percentageScore >= 0.6) {
      return "assets/images/face_60.svg";
    }
    if (0.6 > _percentageScore && _percentageScore >= 0.4) {
      return "assets/images/face_40.svg";
    } else {
      return "assets/images/face_0.svg";
    }
  }

  _restart() {
    print("Restarted");
    setState(() {
      _isQuestionTypeAdd = false;
      _isQuestionTypeSubtract = false;
      _numberOfQuestions = null;
      _hasQuizStarted = false;
      _currentDisplayedQuestion = 0;
      _userScore = 0;
      questionsAnswers = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SvgPicture.asset(
            'assets/images/screen_bg.svg',
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ),
          Center(
              child: _isQuestionTypeAdd == false &&
                      _isQuestionTypeSubtract == false
                  ? QuizType(_selectQuestionType)
                  : _numberOfQuestions == null
                      ? NumberOfQuestions(
                          _selectNumberOfQuestions, _backToQuestionsType)
                      : !_hasQuizStarted
                          ? ReadyStart(
                              startQuiz: _startQuiz,
                              backToNumberOfQuestions: _backToNumberOfQuestions,
                            )
                          : _currentDisplayedQuestion <= _numberOfQuestions - 1
                              ? Questions(
                                  currentQuestion: questionsAnswers[
                                          _currentDisplayedQuestion]
                                      .question,
                                  answerSelectedByUser: _answerSelectedByUser,
                                )
                              : Result(
                                  userScore: _userScore,
                                  numberOfQuestions: _numberOfQuestions,
                                  resultFace: _resultFace,
                                  restart: _restart)),
        ],
      ),
    );
  }
}
