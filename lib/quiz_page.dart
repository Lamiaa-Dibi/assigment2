import 'package:flutter/material.dart';
import 'package:quizapplication/result_page.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class Question {
  final String text;
  final List<String> choices;
  final int correctIndex;

  Question(
      {required this.text, required this.choices, required this.correctIndex});
}

class _QuizPageState extends State<QuizPage> {
  int _currentIndex = 0;
  List<Question> _questions = [
    Question(
        text: 'What is the capital of France?',
        choices: ['Paris', 'London', 'Berlin', 'Madrid'],
        correctIndex: 0),
    Question(
        text: 'What is the largest planet in the solar system?',
        choices: ['Venus', 'Mars', 'Jupiter', 'Saturn'],
        correctIndex: 2),
    Question(
        text: 'What is the smallest country in the world by land area?',
        choices: ['Monaco', 'Vatican City', 'San Marino', 'Nauru'],
        correctIndex: 1),
    Question(
        text: 'What is the name of the tallest mountain in the world?',
        choices: ['Mount Everest', 'K2', 'Kangchenjunga', 'Lhotse'],
        correctIndex: 0),
  ];
  List<int> _answers = [];

  void _selectChoice(int choiceIndex) {
    if (_currentIndex < 0 || _currentIndex >= _questions.length) {
      return; // Invalid index, do nothing
    }
    if (choiceIndex < 0 ||
        choiceIndex >= _questions[_currentIndex].choices.length) {
      return; // Invalid choice index, do nothing
    }
    setState(() {
      _answers.add(choiceIndex);
      if (_currentIndex < _questions.length - 1) {
        _currentIndex++;
      }
    });
    if (_currentIndex == _questions.length) {
      _submitQuiz();
    }
  }


  void _submitQuiz() {
    int score = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (i >= _answers.length) {
        // Handle the case where the user didn't answer all the questions
        break;
      }
      if (_answers[i] == _questions[i].correctIndex) {
        score++;
      }
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsPage(
          score: score,
          totalQuestions: _questions.length,
          onResetPressed: () {
            setState(() {
              _answers.clear();
              _currentIndex = 0;
            });
            Navigator.pop(context);
          },
        ),
      ),
    );
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
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              _questions[_currentIndex].text,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _questions[_currentIndex].choices.length,
              itemBuilder: (BuildContext context, final index) {
                return GestureDetector(
                  onTap: () => _selectChoice(index),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepOrange),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      _questions[_currentIndex].choices[index],
                      style: const TextStyle(
                        fontSize: 18.0,
                        color:
                            Colors.white, // Change this to the color you want
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.deepOrange,
                ),
              ),
              onPressed: _currentIndex == _questions.length - 1
                  ? () {
                      int score = 0;
                      for (int i = 0; i < _questions.length; i++) {
                        if (_answers[i] == _questions[i].correctIndex) {
                          score++;
                        }
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultsPage(
                            score: score,
                            totalQuestions: _questions.length,
                            onResetPressed: () => Navigator.pop(context),
                          ),
                        ),
                      );
                    }
                  : () => _selectChoice(-1),
              child: Text(
                _currentIndex == _questions.length - 1 ? 'Submit' : 'Next',
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ),
          ]),
        )));
  }
}
