import 'dart:math';

class QuestionAnswer {
  int numberOfQuestions;
  int minNumber;
  int maxNumber;
  bool isQuestionTypeSubtract;
  bool isQuestionTypeAdd;

  QuestionAnswer({
    required this.numberOfQuestions,
    required this.minNumber,
    required this.maxNumber,
    required this.isQuestionTypeAdd,
    required this.isQuestionTypeSubtract,
  });

  List<Map<String, Object>> get questions {
    return List.generate(numberOfQuestions, (index) {
      var random = new Random();
      int firstNumber;
      int secondNumber;
      int answerNumber;
      String questionStatement;
      bool actualAnswer;

      firstNumber = minNumber + random.nextInt(maxNumber - minNumber);
      secondNumber = minNumber + random.nextInt(maxNumber - minNumber);

      if (firstNumber < secondNumber && isQuestionTypeSubtract) {
        firstNumber = secondNumber;
        secondNumber = firstNumber;
      }

      if (index == firstNumber || index == secondNumber) {
        answerNumber = minNumber + random.nextInt(maxNumber - minNumber);
      } else {
        if (isQuestionTypeAdd) {
          answerNumber = firstNumber + secondNumber;
        } else {
          answerNumber = firstNumber - secondNumber;
        }
      }

      questionStatement =
          "$firstNumber ${isQuestionTypeAdd ? '+' : '-'} $secondNumber = $answerNumber";

      if (isQuestionTypeAdd && answerNumber == firstNumber + secondNumber ||
          isQuestionTypeSubtract &&
              answerNumber == firstNumber - secondNumber) {
        actualAnswer = true;
      } else {
        actualAnswer = false;
      }

      return {"question": questionStatement, "answer": actualAnswer};
    });
  }
}
