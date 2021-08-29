import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReadyStart extends StatelessWidget {
  final VoidCallback startQuiz;
  final VoidCallback backToNumberOfQuestions;

  ReadyStart({required this.startQuiz, required this.backToNumberOfQuestions});
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  onTap: startQuiz,
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
              onTap: backToNumberOfQuestions,
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
