import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final VoidCallback onResetPressed;

  ResultsPage({
    required this.score,
    required this.totalQuestions,
    required this.onResetPressed,
  });

  String getScoreMessage() {
    double percentage = score / totalQuestions * 100;
    String message = '';

    if (percentage >= 90) {
      message = 'Great job!';
    } else if (percentage >= 60) {
      message = 'Not bad!';
    } else {
      message = 'You can do better!';
    }

    return message;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Center(child: Text('Quiz')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              getScoreMessage(),
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'You scored $score out of $totalQuestions',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onResetPressed,
              child: Text('Try Again'),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.deepOrange),
              ),
            )
          ],
        ),
      ),
    );
  }
}
