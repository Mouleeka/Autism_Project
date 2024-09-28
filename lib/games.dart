import 'package:flutter/material.dart';
import 'dart:math';
import 'game 4.dart'; // Import game4.dart file

void main() {
  runApp(KidsGamesApp());
}

class KidsGamesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kids Games',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: GamesPage(),
    );
  }
}

class GamesPage extends StatefulWidget {
  @override
  _GamesPageState createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  int? _selectedGame;

  void _selectGame(int? gameNumber) {
    setState(() {
      _selectedGame = gameNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient AppBar for a playful look
      appBar: AppBar(
        title: Text('Fun Kids Games'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pinkAccent, Colors.orangeAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: _selectedGame == null
          ? Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount:
          MediaQuery.of(context).size.width > 600 ? 3 : 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: List.generate(4, (index) {
            return GameCard(
              game: index + 1,
              onTap: () => _selectGame(index + 1),
            );
          }),
        ),
      )
          : _buildGame(_selectedGame!),
    );
  }

  Widget _buildGame(int gameNumber) {
    switch (gameNumber) {
      case 1:
        return ColorMatchingGame(onBack: () => _selectGame(null));
      case 2:
        return AlphabetGamePage(onBack: () => _selectGame(null));
      case 3:
        return PuzzleGame(onBack: () => _selectGame(null));
      case 4: // Game 4 added here
        return Game4Page(onBack: () => _selectGame(null)); // Calls Game 4
      default:
        return Center(child: Text('Game not found'));
    }
  }
}

class GameCard extends StatelessWidget {
  final int game;
  final VoidCallback onTap;

  GameCard({required this.game, required this.onTap});

  // Playful color palette
  final List<Color> cardColors = [
    Colors.purpleAccent,
    Colors.tealAccent,
    Colors.orangeAccent,
    Colors.lightBlueAccent, // Added color for Game 4
  ];

  final List<IconData> gameIcons = [
    Icons.color_lens,
    Icons.sort_by_alpha,
    Icons.extension,
    Icons.gamepad, // Icon for Game 4
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColors[game - 1],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 8,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                gameIcons[game - 1],
                size: 60,
                color: Colors.white,
              ),
              SizedBox(height: 10),
              Text(
                'Game $game',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                'Fun description for Game $game',
                style: TextStyle(fontSize: 14, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// ------------------- Color Matching Game -------------------
class ColorMatchingGame extends StatefulWidget {
  final VoidCallback onBack;

  ColorMatchingGame({required this.onBack});

  @override
  _ColorMatchingGameState createState() => _ColorMatchingGameState();
}

class _ColorMatchingGameState extends State<ColorMatchingGame>
    with SingleTickerProviderStateMixin {
  final List<Color> _colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
  ];
  late Color _targetColor;
  Color? _selectedColor;
  bool _isCorrect = false;
  bool _showFeedback = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _setRandomTargetColor();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack);
  }

  void _setRandomTargetColor() {
    setState(() {
      _targetColor = (_colors..shuffle()).first;
      _selectedColor = null;
      _isCorrect = false;
      _showFeedback = false;
    });
  }

  void _onColorSelected(Color color) {
    setState(() {
      _selectedColor = color;
      _isCorrect = color == _targetColor;
      _showFeedback = true;
    });

    _controller.forward(from: 0.0).then((_) {
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _showFeedback = false;
        });
        if (_isCorrect) {
          _setRandomTargetColor();
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Responsive sizing
    double targetSize = MediaQuery.of(context).size.width > 600 ? 200 : 150;
    double colorBoxSize = MediaQuery.of(context).size.width > 600 ? 120 : 80;

    return Scaffold(
      // Remove AppBar to keep a unified look
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue.shade100, Colors.pinkAccent.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Back button
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                  onPressed: widget.onBack,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Match the Color!',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width > 600
                        ? 36
                        : 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
              SizedBox(height: 20),
              Container(
                width: targetSize,
                height: targetSize,
                decoration: BoxDecoration(
                  color: _targetColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 4),
                ),
              ),
              SizedBox(height: 30),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: _colors.map((color) {
                  return GestureDetector(
                    onTap: () => _onColorSelected(color),
                    child: Container(
                      width: colorBoxSize,
                      height: colorBoxSize,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: Colors.white, width: 3), // White border
                      ),
                      child: _selectedColor == color
                          ? Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: colorBoxSize / 2,
                        ),
                      )
                          : null,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 30),
              // Feedback Animation
              if (_showFeedback)
                ScaleTransition(
                  scale: _animation,
                  child: _isCorrect
                      ? Column(
                    children: [
                      Icon(
                        Icons.card_giftcard,
                        color: Colors.green,
                        size: 60,
                      ),
                      Text(
                        'Great Job!',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ],
                  )
                      : Column(
                    children: [
                      Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 60,
                      ),
                      Text(
                        'Try Again!',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ],
                  ),
                ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------- Alphabet Learning Game -------------------
class AlphabetGamePage extends StatefulWidget {
  final VoidCallback onBack;

  AlphabetGamePage({required this.onBack});

  @override
  _AlphabetGamePageState createState() => _AlphabetGamePageState();
}

class _AlphabetGamePageState extends State<AlphabetGamePage>
    with SingleTickerProviderStateMixin {
  final List<String> _alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
  String _currentLetter = '';
  String _selectedLetter = '';
  bool _isCorrect = false;
  bool _showFeedback = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _generateRandomLetter();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack);
  }

  void _generateRandomLetter() {
    final random = Random();
    setState(() {
      _currentLetter = _alphabet[random.nextInt(_alphabet.length)];
      _selectedLetter = '';
      _isCorrect = false;
      _showFeedback = false;
    });
  }

  void _checkAnswer(String letter) {
    setState(() {
      _selectedLetter = letter;
      _isCorrect = letter == _currentLetter;
      _showFeedback = true;
    });

    _controller.forward(from: 0.0).then((_) {
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _showFeedback = false;
        });
        if (_isCorrect) {
          _generateRandomLetter();
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Responsive sizing
    double letterSize = MediaQuery.of(context).size.width > 600 ? 60 : 40;
    int crossAxisCount = MediaQuery.of(context).size.width > 600 ? 6 : 4;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightGreen.shade100, Colors.pinkAccent.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Back button
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                  onPressed: widget.onBack,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Alphabet Matching!',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width > 600
                        ? 36
                        : 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent),
              ),
              SizedBox(height: 20),
              Text(
                'Find: $_currentLetter',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 600
                      ? 48
                      : 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 30),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: _alphabet.length,
                    itemBuilder: (context, index) {
                      final letter = _alphabet[index];
                      return GestureDetector(
                        onTap: () => _checkAnswer(letter),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(15),
                            border:
                            Border.all(color: Colors.white, width: 3),
                          ),
                          child: Center(
                            child: Text(
                              letter,
                              style: TextStyle(
                                fontSize: letterSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Feedback Animation
              if (_showFeedback)
                ScaleTransition(
                  scale: _animation,
                  child: _isCorrect
                      ? Column(
                    children: [
                      Icon(
                        Icons.thumb_up,
                        color: Colors.green,
                        size: 60,
                      ),
                      Text(
                        'Awesome!',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ],
                  )
                      : Column(
                    children: [
                      Icon(
                        Icons.cancel,
                        color: Colors.red,
                        size: 60,
                      ),
                      Text(
                        'Try Again!',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// game 4



// ------------------- Puzzle Game -------------------
class PuzzleGame extends StatefulWidget {
  final VoidCallback onBack;

  PuzzleGame({required this.onBack});

  @override
  _PuzzleGameState createState() => _PuzzleGameState();
}

class _PuzzleGameState extends State<PuzzleGame>
    with SingleTickerProviderStateMixin {
  final Map<String, bool> score = {};
  final List<String> lettersUppercase = ['A', 'B', 'C', 'D'];
  final List<String> lettersLowercase = ['a', 'b', 'c', 'd'];
  int totalScore = 0;
  bool _showFeedback = false;
  bool _isCorrect = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack);
  }

  void _onAccept(String data, String target) {
    if (data.toLowerCase() == target) {
      setState(() {
        score[data] = true;
        totalScore += 1;
        _isCorrect = true;
        _showFeedback = true;
      });
    } else {
      setState(() {
        _isCorrect = false;
        _showFeedback = true;
      });
    }

    _controller.forward(from: 0.0).then((_) {
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _showFeedback = false;
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Responsive sizing
    double letterSize = MediaQuery.of(context).size.width > 600 ? 40 : 30;
    double boxSize = MediaQuery.of(context).size.width > 600 ? 60 : 50;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue.shade100, Colors.orangeAccent.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Back button
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                  onPressed: widget.onBack,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Match Uppercase with Lowercase',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width > 600
                        ? 36
                        : 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Score: $totalScore',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width > 600
                        ? 28
                        : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: lettersUppercase.map((letter) {
                  return Draggable<String>(
                    data: letter,
                    child: LetterCard(
                      letter: score[letter] == true ? '✔️' : letter,
                      color: Colors.blueAccent,
                      size: boxSize,
                    ),
                    feedback: LetterCard(
                      letter: letter,
                      color: Colors.blueAccent.withOpacity(0.7),
                      size: boxSize,
                    ),
                    childWhenDragging:
                    LetterCard(letter: '', color: Colors.grey, size: boxSize),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: lettersLowercase.map((letter) {
                  return DragTarget<String>(
                    builder: (BuildContext context, List<String?> incoming,
                        List rejected) {
                      return LetterCard(
                        letter: letter,
                        color: Colors.greenAccent,
                        size: boxSize,
                      );
                    },
                    onWillAccept: (data) => true,
                    onAccept: (data) => _onAccept(data, letter),
                  );
                }).toList(),
              ),
              SizedBox(height: 30),
              // Feedback Animation
              if (_showFeedback)
                ScaleTransition(
                  scale: _animation,
                  child: _isCorrect
                      ? Column(
                    children: [
                      Icon(
                        Icons.thumb_up,
                        color: Colors.green,
                        size: 60,
                      ),
                      Text(
                        'Good Job!',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ],
                  )
                      : Column(
                    children: [
                      Icon(
                        Icons.cancel,
                        color: Colors.red,
                        size: 60,
                      ),
                      Text(
                        'Oops! Try Again!',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class LetterCard extends StatelessWidget {
  final String letter;
  final Color color;
  final double size;

  const LetterCard(
      {required this.letter, required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.white, width: 3),
      ),
      child: Center(
        child: Text(
          letter,
          style: TextStyle(fontSize: size / 1.5, color: Colors.white),
        ),
      ),
    );
  }
}



