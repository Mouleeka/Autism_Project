import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(Game4Page(onBack: () => print('Back button pressed!')));
}

class Game4Page extends StatelessWidget {
  final VoidCallback onBack; // Define the onBack callback

  // Constructor to accept the onBack callback
  Game4Page({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Game with Icons',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(color: Colors.black),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
      home: MathGame(onBack: onBack), // Pass the onBack function to MathGame
    );
  }
}

class MathGame extends StatefulWidget {
  final VoidCallback onBack; // Add onBack callback to MathGame

  MathGame({required this.onBack}); // Constructor to accept the onBack callback

  @override
  _MathGameState createState() => _MathGameState();
}

class _MathGameState extends State<MathGame> {
  int number1 = 0;
  int number2 = 0;
  int correctAnswer = 0;
  int score = 0;
  List<int> options = [];
  String operation = '+';

  @override
  void initState() {
    super.initState();
    generateNewQuestion();
  }

  void generateNewQuestion() {
    // Generate random numbers and operation
    Random random = Random();
    number1 = random.nextInt(5) + 1; // Random number between 1 and 5
    number2 = random.nextInt(5) + 1; // Random number between 1 and 5
    int op = random.nextInt(2); // 0 for addition, 1 for subtraction
    operation = op == 0 ? '+' : '-';

    if (operation == '+') {
      correctAnswer = number1 + number2;
    } else {
      correctAnswer = number1 - number2;
    }

    // Generate 4 options with the correct answer mixed in
    options = List.generate(4, (index) => random.nextInt(10)); // Random wrong answers
    options[random.nextInt(4)] = correctAnswer; // Ensure one option is the correct answer

    setState(() {});
  }

  void checkAnswer(int selectedAnswer) {
    if (selectedAnswer == correctAnswer) {
      setState(() {
        score++;
      });
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Correct!'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.card_giftcard, color: Colors.green, size: 80), // Gift icon
                SizedBox(height: 20),
                Text('Great job! You got the correct answer.'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  generateNewQuestion();
                },
                child: Text('Next'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Incorrect'),
            content: Text('Oops! That\'s not the correct answer.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  generateNewQuestion();
                },
                child: Text('Try Again'),
              ),
            ],
          );
        },
      );
    }
  }

  Widget buildCupcakeIcons(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(Icons.cake, size: 50, color: Colors.pink),
        );
      }),
    );
  }

  Widget buildOperationIcon() {
    IconData operationIcon;
    if (operation == '+') {
      operationIcon = Icons.add;
    } else {
      operationIcon = Icons.remove;
    }
    return Icon(operationIcon, size: 50, color: Colors.black);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; // Get device size

    return Scaffold(
      appBar: AppBar(
        title: Text('Math Game', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: widget.onBack, // Use the onBack callback to go back
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Display the Score
                Text(
                  'Score: $score',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: Colors.blueAccent),
                ),
                SizedBox(height: 30),

                // Card for displaying the question with icons
                Card(
                  color: Colors.blue[50],
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Cupcake Icons and operation
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(child: buildCupcakeIcons(number1)),
                            SizedBox(width: 20),
                            buildOperationIcon(),
                            SizedBox(width: 20),
                            Flexible(child: buildCupcakeIcons(number2)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40),

                // Text asking to select the correct answer
                Text(
                  'Select the correct answer:',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: 20),

                // Display answer options as buttons
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      return ElevatedButton(
                        onPressed: () => checkAnswer(options[index]),
                        child: Text(
                          options[index].toString(),
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
