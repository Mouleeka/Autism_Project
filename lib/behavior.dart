import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(BehaviorPage());
}

class BehaviorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Behavior Tracking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        fontFamily: 'Arial',
        scaffoldBackgroundColor: Colors.purple[100],
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87),
          bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
          labelLarge: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      home: BehaviorTrackingPage(),
    );
  }
}

class BehaviorTrackingPage extends StatefulWidget {
  @override
  _BehaviorTrackingPageState createState() => _BehaviorTrackingPageState();
}

class _BehaviorTrackingPageState extends State<BehaviorTrackingPage> {
  List<Behavior> behaviors = [
    Behavior('Completed Homework', false),
    Behavior('Cleaned Room', false),
    Behavior('Did Not Interrupt Class', false),
    Behavior('Participated in Class Discussion', false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Behavior Tracking Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Navigation', style: TextStyle(color: Colors.white, fontSize: 24)),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.track_changes),
              title: Text('Behavior Tracking'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Track Behaviors for the Day',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: behaviors.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 6,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    color: behaviors[index].completed ? Colors.green[50] : Colors.white,
                    child: ListTile(
                      title: Text(behaviors[index].title, style: Theme.of(context).textTheme.bodyLarge),
                      trailing: Checkbox(
                        value: behaviors[index].completed,
                        activeColor: Colors.green,
                        onChanged: (value) {
                          setState(() {
                            behaviors[index].completed = value!;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Behavior Progress Overview',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            SizedBox(height: 200, child: PieChartWidget(behaviors: behaviors)),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SummaryPage(behaviors: behaviors)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.blueAccent,
                ),
                child: Text('Submit Daily Report', style: Theme.of(context).textTheme.labelLarge),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Behavior {
  String title;
  bool completed;

  Behavior(this.title, this.completed);
}

class PieChartWidget extends StatelessWidget {
  final List<Behavior> behaviors;

  PieChartWidget({required this.behaviors});

  @override
  Widget build(BuildContext context) {
    int completed = behaviors.where((b) => b.completed).length;
    int remaining = behaviors.length - completed;

    return Stack(
      alignment: Alignment.center,
      children: [
        PieChart(
          PieChartData(
            sections: [
              PieChartSectionData(
                color: Colors.greenAccent,
                value: completed.toDouble(),
                title: '$completed Completed',
                radius: 60,
                titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              PieChartSectionData(
                color: Colors.redAccent,
                value: remaining.toDouble(),
                title: '$remaining Remaining',
                radius: 60,
                titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
            centerSpaceRadius: 50,
            sectionsSpace: 4,
          ),
        ),
        Text(
          '$completed',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ],
    );
  }
}

class SummaryPage extends StatelessWidget {
  final List<Behavior> behaviors;

  SummaryPage({required this.behaviors});

  @override
  Widget build(BuildContext context) {
    int completed = behaviors.where((b) => b.completed).length;
    int total = behaviors.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Summary Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daily Summary',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            SizedBox(height: 20),
            Text('Total Behaviors: $total', style: Theme.of(context).textTheme.bodyLarge),
            Text('Behaviors Completed: $completed', style: Theme.of(context).textTheme.bodyLarge),
            // Add more summary details as needed
          ],
        ),
      ),
    );
  }
}