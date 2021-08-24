import 'dart:math';

// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kids_math_app/models/questionsAnswers.dart';

class KidsHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => KidsHomePageState();
}

class KidsHomePageState extends State<KidsHomePage> {
  // late final AudioCache _audioCache;
  bool _isQuestionTypeAdd = false;
  bool _isQuestionTypeSubtract = false;
  var _numberOfQuestions;
  bool _hasQuizStarted = false;
  int _minNumber = 1;
  int _maxNumber = 9;
  int _currentDisplayedQuestion = 0;
  int _userScore = 0;
  List<QuestionAnswer> questionsAnswers = [];

  // @override
  // void initState() {
  //   super.initState();
  //   _audioCache = AudioCache(
  //     prefix: 'audio/',
  //     fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
  //   );
  // }

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
                ? Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFEFFFD9),
                      border: Border.all(
                        color: Color(0xFF608A43),
                        width: 7,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    padding: EdgeInsets.fromLTRB(10, 25, 10, 25),
                    height: 330,
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Select Questions' Type",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF608A43)),
                        ),
                        SizedBox(height: 35),
                        InkWell(
                          onTap: () => _selectQuestionType("ADD"),
                          child: SvgPicture.asset(
                            'assets/images/button_add.svg',
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () => _selectQuestionType("SUBTRACT"),
                          child: SvgPicture.asset(
                            'assets/images/button_subtract.svg',
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  )
                : _numberOfQuestions == null
                    ? Container(
                        height: 480,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFEFFFD9),
                                border: Border.all(
                                  color: Color(0xFF608A43),
                                  width: 7,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 25),
                              padding: EdgeInsets.fromLTRB(10, 25, 10, 25),
                              height: 430,
                              width: double.infinity,
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "How Many Questions?",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF608A43)),
                                  ),
                                  SizedBox(height: 35),
                                  InkWell(
                                    onTap: () => _selectNumberOfQuestions(3),
                                    child: SvgPicture.asset(
                                      'assets/images/3_questions.svg',
                                      alignment: Alignment.center,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  InkWell(
                                    onTap: () => _selectNumberOfQuestions(5),
                                    child: SvgPicture.asset(
                                      'assets/images/5_questions.svg',
                                      alignment: Alignment.center,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  InkWell(
                                    onTap: () => _selectNumberOfQuestions(10),
                                    child: SvgPicture.asset(
                                      'assets/images/10_questions.svg',
                                      alignment: Alignment.center,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: InkWell(
                                onTap: _backToQuestionsType,
                                child: SvgPicture.asset(
                                  'assets/images/back.svg',
                                  alignment: Alignment.center,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : !_hasQuizStarted
                        ? Container(
                            height: 300,
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEFFFD9),
                                    border: Border.all(
                                      color: Color(0xFF608A43),
                                      width: 7,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  margin: EdgeInsets.symmetric(horizontal: 25),
                                  padding: EdgeInsets.fromLTRB(10, 25, 10, 25),
                                  height: 250,
                                  width: double.infinity,
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Ready?",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF608A43)),
                                      ),
                                      SizedBox(height: 35),
                                      InkWell(
                                        onTap: _startQuiz,
                                        child: SvgPicture.asset(
                                          'assets/images/button_start.svg',
                                          alignment: Alignment.center,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: InkWell(
                                    onTap: _backToNumberOfQuestions,
                                    child: SvgPicture.asset(
                                      'assets/images/back.svg',
                                      alignment: Alignment.center,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : _currentDisplayedQuestion <= _numberOfQuestions - 1
                            ? Container(
                                height: 300,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFFEFFFD9),
                                        border: Border.all(
                                          color: Color(0xFF608A43),
                                          width: 7,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 25),
                                      padding:
                                          EdgeInsets.fromLTRB(10, 25, 10, 25),
                                      height: 280,
                                      width: double.infinity,
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            "Is this correct?",
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF608A43)),
                                          ),
                                          SizedBox(height: 35),
                                          Text(
                                            questionsAnswers[
                                                    _currentDisplayedQuestion]
                                                .question,
                                            style: TextStyle(
                                                fontSize: 48,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF608A43)),
                                          ),
                                          SizedBox(height: 35),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              InkWell(
                                                onTap: () =>
                                                    _answerSelectedByUser(true),
                                                child: SvgPicture.asset(
                                                  'assets/images/button_true.svg',
                                                  alignment: Alignment.center,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () =>
                                                    _answerSelectedByUser(
                                                        false),
                                                child: SvgPicture.asset(
                                                  'assets/images/button_false.svg',
                                                  alignment: Alignment.center,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFEFFFD9),
                                  border: Border.all(
                                    color: Color(0xFF608A43),
                                    width: 7,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                margin: EdgeInsets.symmetric(horizontal: 25),
                                padding: EdgeInsets.fromLTRB(10, 25, 10, 25),
                                height: 380,
                                width: double.infinity,
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Your Score",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF608A43)),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      "$_userScore / $_numberOfQuestions",
                                      style: TextStyle(
                                          fontSize: 48,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF608A43)),
                                    ),
                                    SizedBox(height: 20),
                                    SvgPicture.asset(
                                      _resultFace(),
                                      alignment: Alignment.center,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(height: 20),
                                    InkWell(
                                      onTap: _restart,
                                      child: SvgPicture.asset(
                                        'assets/images/button_restart.svg',
                                        alignment: Alignment.center,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
          ),
        ],
      ),
    );
  }
}
