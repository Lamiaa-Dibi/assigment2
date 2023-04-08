import 'package:flutter/material.dart';
import 'package:quizapplication/result_page.dart';
import 'package:quizapplication/quiz_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headline6: TextStyle(fontSize: 24.0),
          bodyText1: TextStyle(fontSize: 16.0),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _score = 0;

  void _startQuiz() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuizPage()),
    ).then((value) {
      if (value != null) {
        setState(() {
          _score = value;
        });
      }
    });
  }

  void _resetQuiz() {
    setState(() {
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Center(child: Text('Quiz App')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Quiz!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Start Quiz'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.deepOrange), // Change this to the color you want
              ),
              onPressed: _startQuiz,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Reset Quiz'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.deepOrange), // Change this to the color you want
              ),
              onPressed: _resetQuiz,
            ),
            SizedBox(height: 16.0),
            Text(
              'Your score: $_score',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
