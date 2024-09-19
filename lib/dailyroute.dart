import 'package:flutter/material.dart';

void main() => runApp(DailyRoutineApp());

class DailyRoutineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DailyRoutinePage(),
    );
  }
}

class DailyRoutinePage extends StatefulWidget {
  @override
  _DailyRoutinePageState createState() => _DailyRoutinePageState();
}

class _DailyRoutinePageState extends State<DailyRoutinePage> {
  // Define the tasks for morning and evening
  final List<String> morningTasks = [
    'Make bed',
    'Exercise',
    'Eat breakfast',
    'Brush teeth',
    'Comb hair',
    'Get dressed',
    'Pack backpack'
  ];

  final List<String> eveningTasks = [
    'Cleanup toys',
    'Eat and clean',
    'Bath time',
    'Wear pjs',
    'Brush teeth',
    'Read book',
    'Bed time'
  ];

  // To track the state of the checkboxes
  List<bool> morningCheckStates = List.generate(7, (index) => false);
  List<bool> eveningCheckStates = List.generate(7, (index) => false);

  // Method to create the routine list with checkboxes
  Widget buildRoutineColumn(List<String> tasks, List<bool> checkStates, int startIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: tasks.asMap().entries.map((entry) {
        int idx = entry.key;
        String task = entry.value;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  task,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Checkbox(
                value: checkStates[idx],
                onChanged: (bool? value) {
                  setState(() {
                    checkStates[idx] = value!;
                  });
                },
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Routine'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Daily Routine',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Morning',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        buildRoutineColumn(morningTasks, morningCheckStates, 0),
                      ],
                    ),
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Evening',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        buildRoutineColumn(eveningTasks, eveningCheckStates, 7),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}