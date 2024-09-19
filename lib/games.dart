import 'package:flutter/material.dart';
import 'dart:math';

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
      appBar: AppBar(
        title: Text('Games'),
        backgroundColor: Colors.blue,
      ),
      body: _selectedGame == null
          ? Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: List.generate(3, (index) {
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
        return PuzzleGame(onBack: () => _selectGame(null)); // Game 3 added here
      default:
        return Center(child: Text('Game not found'));
    }
  }
}

class GameCard extends StatelessWidget {
  final int game;
  final VoidCallback onTap;

  GameCard({required this.game, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.videogame_asset,
              size: 60,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              'Game $game',
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Description of Game $game',
              style: TextStyle(fontSize: 14, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ColorMatchingGame extends StatefulWidget {
  final VoidCallback onBack;

  ColorMatchingGame({required this.onBack});

  @override
  _ColorMatchingGameState createState() => _ColorMatchingGameState();
}

class _ColorMatchingGameState extends State<ColorMatchingGame> {
  final List<Color> _colors = [Colors.red, Colors.green, Colors.blue, Colors.yellow];
  late Color _targetColor;
  Color? _selectedColor;

  @override
  void initState() {
    super.initState();
    _setRandomTargetColor();
  }

  void _setRandomTargetColor() {
    setState(() {
      _targetColor = (_colors..shuffle()).first;
      _selectedColor = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Match the Color!',
                style: TextStyle(
                    fontSize: 28, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
              SizedBox(height: 20),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: _targetColor,
                  borderRadius: BorderRadius.circular(15),
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
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: _selectedColor == color
                          ? Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 50,
                        ),
                      )
                          : null,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: widget.onBack,
                child: Text('Back to Games'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onColorSelected(Color color) {
    setState(() {
      _selectedColor = color;
    });
    if (_selectedColor == _targetColor) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Correct!')),
      );
      Future.delayed(Duration(seconds: 1), _setRandomTargetColor);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Try again!')),
      );
    }
  }
}

class AlphabetGamePage extends StatefulWidget {
  final VoidCallback onBack;

  AlphabetGamePage({required this.onBack});

  @override
  _AlphabetGamePageState createState() => _AlphabetGamePageState();
}

class _AlphabetGamePageState extends State<AlphabetGamePage> {
  final List<String> _alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
  String _currentLetter = '';
  String _selectedLetter = '';

  @override
  void initState() {
    super.initState();
    _generateRandomLetter();
  }

  void _generateRandomLetter() {
    final random = Random();
    setState(() {
      _currentLetter = _alphabet[random.nextInt(_alphabet.length)];
    });
  }

  void _checkAnswer(String letter) {
    setState(() {
      _selectedLetter = letter;
    });

    if (_selectedLetter == _currentLetter) {
      _showDialog('Correct!', 'Well done! You selected the right letter.');
    } else {
      _showDialog('Try Again!', 'Oops! That\'s not the correct letter.');
    }
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _generateRandomLetter();
                setState(() {
                  _selectedLetter = '';
                });
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen.shade50,
      appBar: AppBar(
        title: Text('Alphabet Learning Game'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tap the letter that matches the shown letter!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Find: $_currentLetter',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
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
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.blue, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          letter,
                          style: TextStyle(
                            fontSize: 24,
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: widget.onBack,
              child: Text('Back to Games'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PuzzleGame extends StatefulWidget {
  final VoidCallback onBack;

  PuzzleGame({required this.onBack});

  @override
  _PuzzleGameState createState() => _PuzzleGameState();
}

class _PuzzleGameState extends State<PuzzleGame> {
  final Map<String, bool> score = {};
  final List<String> lettersUppercase = ['A', 'B', 'C', 'D'];
  final List<String> lettersLowercase = ['a', 'b', 'c', 'd'];
  int totalScore = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Match Uppercase with Lowercase'),
        backgroundColor: Colors.orangeAccent,
      ),
      backgroundColor: Colors.lightGreen.shade100,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: lettersUppercase.map((letter) {
                return Draggable<String>(
                  data: letter,
                  child: LetterCard(
                    letter: score[letter] == true ? '✔️' : letter,
                    color: Colors.blueAccent,
                  ),
                  feedback: LetterCard(letter: letter, color: Colors.blueAccent),
                  childWhenDragging: LetterCard(letter: '', color: Colors.grey),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: lettersLowercase.map((letter) {
                return DragTarget<String>(
                  builder: (BuildContext context, List<String?> incoming, List rejected) {
                    return LetterCard(letter: letter, color: Colors.greenAccent);
                  },
                  onWillAccept: (data) => true,
                  onAccept: (data) {
                    if (data.toLowerCase() == letter) {
                      setState(() {
                        score[data] = true;
                        totalScore += 1;
                      });
                    }
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Score: $totalScore',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: widget.onBack,
              child: Text('Back to Games'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LetterCard extends StatelessWidget {
  final String letter;
  final Color color;

  const LetterCard({required this.letter, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        letter,
        style: TextStyle(fontSize: 30, color: Colors.white),
      ),
    );
  }
}