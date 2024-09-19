import 'package:flutter/material.dart';

class LearningPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learning Modules'),
      ),
      body: Center(
        child: Text(
          'Graph or Chart for Learning Modules goes here!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
