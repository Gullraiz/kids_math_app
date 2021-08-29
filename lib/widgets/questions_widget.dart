import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Questions extends StatelessWidget {
  final String currentQuestion;
  final Function(bool) answerSelectedByUser;

  Questions({
    required this.currentQuestion,
    required this.answerSelectedByUser,
  });

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
                  currentQuestion,
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF608A43)),
                ),
                SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      onTap: () => answerSelectedByUser(true),
                      child: SvgPicture.asset(
                        'assets/images/button_true.svg',
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                      ),
                    ),
                    InkWell(
                      onTap: () => answerSelectedByUser(false),
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
    );
  }
}
