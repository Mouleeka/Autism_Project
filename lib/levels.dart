import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LevelsPage(),
    );
  }
}

class LevelsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Levels'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildLevelCard(
                    context,
                    level: 'Level 1',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DaySelectionPage(level: 'Level 1')),
                    ),
                  ),
                  _buildLevelCard(
                    context,
                    level: 'Level 2',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DaySelectionPage(level: 'Level 2')),
                    ),
                  ),
                  _buildLevelCard(
                    context,
                    level: 'Level 3',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DaySelectionPage(level: 'Level 3')),
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

  Widget _buildLevelCard(BuildContext context, {required String level, required VoidCallback onTap}) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(
          level,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }
}

class DaySelectionPage extends StatelessWidget {
  final String level;

  DaySelectionPage({required this.level});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$level - Select a Day'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 7,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text('Day ${index + 1}'),
                trailing: Icon(Icons.arrow_forward),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DayDetailPage(day: index + 1)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class DayDetailPage extends StatelessWidget {
  final int day;

  DayDetailPage({required this.day});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Day $day Details'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.blueGrey[200],
                      child: Center(
                        child: Text(
                          'Animated Video Placeholder',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Quiz related to Day $day',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    // Add quiz widgets here
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
