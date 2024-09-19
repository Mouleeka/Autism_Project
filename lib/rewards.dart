import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RewardsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RewardsPage extends StatefulWidget {
  @override
  _RewardsPageState createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  // Mocked current level and rewards based on level
  int currentLevel = 3;
  Map<int, String> rewards = {
    1: "⭐ 1 Star + Gift",
    2: "⭐⭐ 2 Stars + Gift",
    3: "⭐⭐⭐ 3 Stars + Gift",
    4: "⭐⭐⭐⭐ 4 Stars + Gift",
    5: "⭐⭐⭐⭐⭐ 5 Stars + Special Gift"
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Share button action
        },
        child: Icon(Icons.share),
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.greenAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FadeTransition(
                  opacity: _animation,
                  child: RotationTransition(
                    turns: _animation,
                    child: Icon(
                      Icons.stars,
                      color: Colors.yellowAccent,
                      size: 100,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Congratulations!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Level $currentLevel Reward",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 16),
                _buildRewardCard(currentLevel),
                SizedBox(height: 16),
                _buildProgressBar(),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    // Action to claim reward or go to the next level
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                    shadowColor: Colors.black45,
                    backgroundColor: Colors.greenAccent,
                  ),
                  child: Text(
                    'CLAIM REWARD',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                SizedBox(height: 16),
                _buildRewardsCarousel(),
                SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    // View all offers action
                  },
                  child: Text(
                    'View all offers',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRewardCard(int level) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.card_giftcard,
            size: 48,
            color: Colors.green,
          ),
          SizedBox(height: 8),
          Text(
            rewards[level] ?? "No Reward",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Column(
      children: [
        Text(
          "Progress to next level:",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(height: 10),
        LinearProgressIndicator(
          value: currentLevel / rewards.length,
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
        ),
      ],
    );
  }

  Widget _buildRewardsCarousel() {
    return Container(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildRewardCard(1),
          _buildRewardCard(2),
          _buildRewardCard(3),
          _buildRewardCard(4),
          _buildRewardCard(5),
        ],
      ),
    );
  }
}
