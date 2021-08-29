import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class QuizType extends StatelessWidget {

  final void Function(String) selectQuestionType;
  
  QuizType(this.selectQuestionType);
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
            onTap: () => selectQuestionType("ADD"),
            child: SvgPicture.asset(
              'assets/images/button_add.svg',
              alignment: Alignment.center,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () => selectQuestionType("SUBTRACT"),
            child: SvgPicture.asset(
              'assets/images/button_subtract.svg',
              alignment: Alignment.center,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
