// import 'package:autism_project/parents.dart';
// import 'package:autism_project/rewards.dart';
// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
//
// import 'behavior.dart';
// import 'communication.dart';
// import 'dailyroute.dart';
// import 'games.dart';
// import 'levels.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'ASD & ID Learning App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         fontFamily: 'ComicSans',
//       ),
//       home: HomePage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   final AudioCache _audioCache = AudioCache(prefix: 'sounds/');
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     );
//     _controller.forward();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   void _playSound(String fileName) {
//     _audioCache.play(fileName);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.deepPurple,
//         title: Text(
//           'ASD & ID Learning App',
//           style: TextStyle(
//             fontFamily: 'ComicSans',
//             fontSize: 24,
//           ),
//         ),
//         actions: [
//           _buildNavButton(context, Icons.home, () {}),
//           _buildNavButton(context, Icons.info, () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => ParentGuidelinesScreen()),
//             );
//           }),
//           _buildNavButton(context, Icons.timer, () {}),
//           _buildNavButton(context, Icons.games, () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => GamesPage()),
//             );
//           }),
//           _buildNavButton(context, Icons.settings, () {}),
//         ],
//       ),
//       body: Stack(
//         children: [
//           // Background image
//           Positioned.fill(
//             child: Image.asset(
//               'assets/images/background.jpg',
//               fit: BoxFit.cover,
//             ),
//           ),
//           // Background gradient with animation
//           AnimatedContainer(
//             duration: Duration(seconds: 2),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xFFB3FFAB).withOpacity(0.7), Color(0xFF12FFF7).withOpacity(0.7)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),
//           // Main content with fade-in effect
//           FadeTransition(
//             opacity: _controller,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   // Title section
//                   Text(
//                     'Your Learning Adventure Awaits!',
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.pinkAccent,
//                       fontFamily: 'ComicSans',
//                       shadows: [
//                         Shadow(
//                           blurRadius: 10.0,
//                           color: Colors.black26,
//                           offset: Offset(3.0, 3.0),
//                         ),
//                       ],
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Explore daily routines, games, and more!',
//                     style: TextStyle(
//                       fontSize: 20,
//                       color: Colors.black87,
//                       fontFamily: 'ComicSans',
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 20),
//                   // Responsive Categories Grid
//                   Expanded(
//                     child: GridView.count(
//                       crossAxisCount: MediaQuery.of(context).size.width < 600 ? 2 : 3,
//                       crossAxisSpacing: 16,
//                       mainAxisSpacing: 16,
//                       children: [
//                         _buildCategoryCard(
//                           title: 'Daily Routine',
//                           color: Color(0xFFFFC107),
//                           icon: Icons.schedule,
//                           soundFile: 'daily_routine.mp3',
//                           onTap: () {
//                             _playSound('tap.wav');
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => DailyRoutinePage()),
//                             );
//                           },
//                         ),
//                         _buildCategoryCard(
//                           title: 'Communication Tools',
//                           color: Color(0xFF4CAF50),
//                           icon: Icons.message,
//                           soundFile: 'communication.mp3',
//                           onTap: () {
//                             _playSound('tap.wav');
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => CommunicationPage()),
//                             );
//                           },
//                         ),
//                         _buildCategoryCard(
//                           title: 'Learning Modules',
//                           color: Color(0xFF03A9F4),
//                           icon: Icons.school,
//                           soundFile: 'learning.mp3',
//                           onTap: () {
//                             _playSound('tap.wav');
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => LevelsPage()),
//                             );
//                           },
//                         ),
//                         _buildCategoryCard(
//                           title: 'Behavior Tracking',
//                           color: Color(0xFFFF5722),
//                           icon: Icons.track_changes,
//                           soundFile: 'behavior.mp3',
//                           onTap: () {
//                             _playSound('tap.wav');
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => BehaviorPage()),
//                             );
//                           },
//                         ),
//                         _buildCategoryCard(
//                           title: 'Games & Activities',
//                           color: Color(0xFF9C27B0),
//                           icon: Icons.games,
//                           soundFile: 'games.mp3',
//                           onTap: () {
//                             _playSound('tap.wav');
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => GamesPage()),
//                             );
//                           },
//                         ),
//                         _buildCategoryCard(
//                           title: 'Rewards System',
//                           color: Color(0xFFCDDC39),
//                           icon: Icons.star,
//                           soundFile: 'rewards.mp3',
//                           onTap: () {
//                             _playSound('tap.wav');
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => RewardsPage()),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCategoryCard({
//     required String title,
//     required Color color,
//     required IconData icon,
//     required String soundFile,
//     VoidCallback? onTap,
//   }) {
//     return GestureDetector(
//       onTap: () {
//         _playSound(soundFile);
//         if (onTap != null) onTap();
//       },
//       child: AnimatedContainer(
//         duration: Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(color: Colors.white, width: 3),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               blurRadius: 10,
//               offset: Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 icon,
//                 size: 50,
//                 color: Colors.white,
//                 shadows: [
//                   Shadow(
//                     blurRadius: 10,
//                     color: Colors.black45,
//                     offset: Offset(3, 3),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 12),
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   fontFamily: 'ComicSans',
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNavButton(BuildContext context, IconData icon, VoidCallback onPressed) {
//     return IconButton(
//       icon: Icon(icon, color: Colors.white),
//       iconSize: 28,
//       onPressed: onPressed,
//       splashColor: Colors.white,
//       tooltip: 'Go to ${icon.toString()}',
//     );
//   }
// }


import 'package:autism_project/parents.dart';
import 'package:autism_project/rewards.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import 'behavior.dart';
import 'communication.dart';
import 'dailyroute.dart';
import 'games.dart';
import 'levels.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ASD & ID Learning App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'ComicSans',
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioCache _audioCache = AudioCache(prefix: 'sounds/');
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _playSound(String fileName) {
    _audioCache.play(fileName);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'ASD & ID Learning App',
          style: TextStyle(
            fontFamily: 'ComicSans',
            fontSize: 24,
          ),
        ),
        actions: [
          _buildNavButton(context, Icons.home, () {}),
          _buildNavButton(context, Icons.info, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ParentGuidelinesScreen()),
            );
          }),
          _buildNavButton(context, Icons.timer, () {}),
          _buildNavButton(context, Icons.games, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GamesPage()),
            );
          }),
          _buildNavButton(context, Icons.settings, () {}),
        ],
      ),
      body: Stack(
        children: [
          // Updated Gradient Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFE3FDFD), // Light Blue
                  Color(0xFFFFA8D5), // Light Pink
                  Color(0xFFE4C1F9), // Soft Lavender
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          FadeTransition(
            opacity: _controller,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Your Learning Adventure Awaits!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.pinkAccent,
                      fontFamily: 'ComicSans',
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black26,
                          offset: Offset(3.0, 3.0),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Explore daily routines, games, and more!',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontFamily: 'ComicSans',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 3, // 3 circles per row
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1,
                      children: [
                        _buildCircularCard(
                          title: 'Daily Routine',
                          imagePath: 'Images/n1.jpg',
                          soundFile: 'daily_routine.mp3',
                          onTap: () {
                            _playSound('tap.wav');
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DailyRoutinePage()),
                            );
                          },
                        ),
                        _buildCircularCard(
                          title: 'Communication Tools',
                          imagePath: 'Images/f1.jpg',
                          soundFile: 'communication.mp3',
                          onTap: () {
                            _playSound('tap.wav');
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CommunicationPage()),
                            );
                          },
                        ),
                        _buildCircularCard(
                          title: 'Learning Modules',
                          imagePath: 'Images/f3.jpg',
                          soundFile: 'learning.mp3',
                          onTap: () {
                            _playSound('tap.wav');
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LevelsPage()),
                            );
                          },
                        ),
                        _buildCircularCard(
                          title: 'Behavior Tracking',
                          imagePath: 'Images/n4.jpg',
                          soundFile: 'behavior.mp3',
                          onTap: () {
                            _playSound('tap.wav');
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BehaviorPage()),
                            );
                          },
                        ),
                        _buildCircularCard(
                          title: 'Games & Activities',
                          imagePath: 'Images/n5.jpg',
                          soundFile: 'games.mp3',
                          onTap: () {
                            _playSound('tap.wav');
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => GamesPage()),
                            );
                          },
                        ),
                        _buildCircularCard(
                          title: 'Rewards System',
                          imagePath: 'Images/n6.jpg',
                          soundFile: 'rewards.mp3',
                          onTap: () {
                            _playSound('tap.wav');
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RewardsPage()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularCard({
    required String title,
    required String imagePath,
    required String soundFile,
    VoidCallback? onTap,
  }) {
    var screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        _playSound(soundFile);
        if (onTap != null) onTap();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: screenSize.width * 0.25, // Responsive circle size
            height: screenSize.width * 0.25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover, // Ensures the image fits inside the circle
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'ComicSans',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(BuildContext context, IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(icon, color: Colors.white),
      iconSize: 28,
      onPressed: onPressed,
      splashColor: Colors.white,
      tooltip: 'Go to ${icon.toString()}',
    );
  }
}

