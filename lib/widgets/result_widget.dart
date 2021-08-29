import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Result extends StatelessWidget {
  final int userScore;
  final int numberOfQuestions;
  final Function resultFace;
  final VoidCallback restart;

  Result({
    required this.userScore,
    required this.numberOfQuestions,
    required this.resultFace,
    required this.restart,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
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
            "$userScore / $numberOfQuestions",
            style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Color(0xFF608A43)),
          ),
          SizedBox(height: 20),
          SvgPicture.asset(
            resultFace(),
            alignment: Alignment.center,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: restart,
            child: SvgPicture.asset(
              'assets/images/button_restart.svg',
              alignment: Alignment.center,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
