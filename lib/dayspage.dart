import 'package:flutter/material.dart';

class DayPage extends StatelessWidget {
  final int level;
  final int day;

  DayPage({required this.level, required this.day});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Level $level - Day $day'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Placeholder for animation video
            Container(
              color: Colors.blueGrey,
              height: 200,
              width: double.infinity,
              child: Center(child: Text('Animation Video Placeholder')),
            ),
            SizedBox(height: 20),
            // Placeholder for quizzes
            Text('Quiz Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            // Add quiz widgets here
          ],
        ),
      ),
    );
  }
}
