import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NumberOfQuestions extends StatelessWidget {
  final void Function(int) selectNumberOfQuestions;
  final VoidCallback backToQuestionsType;

  NumberOfQuestions(this.selectNumberOfQuestions, this.backToQuestionsType);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  onTap: () => selectNumberOfQuestions(3),
                  child: SvgPicture.asset(
                    'assets/images/3_questions.svg',
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () => selectNumberOfQuestions(5),
                  child: SvgPicture.asset(
                    'assets/images/5_questions.svg',
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () => selectNumberOfQuestions(10),
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
              onTap: backToQuestionsType,
              child: SvgPicture.asset(
                'assets/images/back.svg',
                alignment: Alignment.center,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
