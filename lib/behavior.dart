import 'package:flutter/material.dart';

class BehaviorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Behavior Tracking'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Behavior Logs & Tracking',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            _buildBehaviorChart(),
            SizedBox(height: 20),
            _buildLogButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBehaviorChart() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          'Behavior Chart Placeholder',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildLogButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // Add functionality for logging new behaviors
      },
      icon: Icon(Icons.add, size: 30),
      label: Text(
        'Log New Behavior',
        style: TextStyle(fontSize: 20),
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.orange,
        minimumSize: Size(double.infinity, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
