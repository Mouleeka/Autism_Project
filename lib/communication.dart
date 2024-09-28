import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class CommunicationPage extends StatefulWidget {
  @override
  _CommunicationPageState createState() => _CommunicationPageState();
}

class _CommunicationPageState extends State<CommunicationPage> {
  FlutterTts flutterTts = FlutterTts();
  TextEditingController _textToSpeechController = TextEditingController();
  TextEditingController _customPhraseController = TextEditingController();

  double _speechRate = 1.0;
  double _pitch = 1.0;

  // List of default phrases with emojis and colors
  List<Map<String, dynamic>> phrases = [
    {'text': 'Let’s play!', 'emoji': '🎮', 'color': Colors.orangeAccent},
    {'text': 'Good job!', 'emoji': '🌟', 'color': Colors.greenAccent},
    {'text': 'Can you help me?', 'emoji': '🆘', 'color': Colors.blueAccent},
    {'text': 'I need a break', 'emoji': '🛌', 'color': Colors.purpleAccent},
    {'text': 'I’m happy', 'emoji': '😊', 'color': Colors.yellowAccent},
    {'text': 'I’m sad', 'emoji': '😢', 'color': Colors.lightBlueAccent},
    {'text': 'Let’s explore!', 'emoji': '🌍', 'color': Colors.pinkAccent},
  ];

  // Function to speak the given text with current pitch and rate
  _speak(String text) async {
    await flutterTts.setSpeechRate(_speechRate);
    await flutterTts.setPitch(_pitch);
    await flutterTts.speak(text);
  }

  // Function to add a custom phrase
  void _addCustomPhrase() {
    if (_customPhraseController.text.isNotEmpty) {
      setState(() {
        phrases.add({
          'text': _customPhraseController.text,
          'emoji': '✨', // Default emoji for custom phrases
          'color': Colors.tealAccent,
        });
      });
      _customPhraseController.clear(); // Clear the input field
      Navigator.of(context).pop(); // Close the dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'VR Learning for Kids',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        width: double.infinity,  // Ensure gradient covers the full width
        height: double.infinity, // Ensure gradient covers the full height
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFD1DC), // Gold
              Color(0xFFFFEFD5),

            ],

            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Let’s Learn and Communicate!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Choose an activity below:',
                  style: TextStyle(fontSize: 22, color: Colors.black87),
                ),
                SizedBox(height: 20),
                _buildToolButton(
                  context: context,
                  icon: Icons.record_voice_over,
                  label: 'Text-to-Speech',
                  color: Colors.blueAccent,
                  onPressed: () => _showTextToSpeechDialog(context),
                ),
                _buildToolButton(
                  context: context,
                  icon: Icons.chat_bubble,
                  label: 'Common Phrases',
                  color: Colors.pinkAccent,
                  onPressed: () => _showCommonPhrasesDialog(context),
                ),
                _buildToolButton(
                  context: context,
                  icon: Icons.add_circle_outline,
                  label: 'Add Custom Phrase',
                  color: Colors.tealAccent,
                  onPressed: () => _showAddPhraseDialog(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method for creating colorful buttons
  Widget _buildToolButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 40, color: Colors.white),
        label: Text(
          label,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 80),
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          shadowColor: Colors.black,
          elevation: 10,
        ),
      ),
    );
  }

  // Dialog for Text-to-Speech with speech rate and pitch sliders
  void _showTextToSpeechDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Text-to-Speech',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _textToSpeechController,
                decoration: InputDecoration(
                  labelText: 'Enter text to speak',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Speed'),
                  Slider(
                    value: _speechRate,
                    min: 0.5,
                    max: 2.0,
                    divisions: 6,
                    label: _speechRate.toStringAsFixed(1),
                    onChanged: (value) {
                      setState(() {
                        _speechRate = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Pitch'),
                  Slider(
                    value: _pitch,
                    min: 0.5,
                    max: 2.0,
                    divisions: 6,
                    label: _pitch.toStringAsFixed(1),
                    onChanged: (value) {
                      setState(() {
                        _pitch = value;
                      });
                    },
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () => _speak(_textToSpeechController.text),
                child: Text('Speak'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Dialog for Common Phrases with animations and proper display
  void _showCommonPhrasesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Common Phrases',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          content: phrases.isNotEmpty
              ? Container(
            height: 300,
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: phrases.length,
              itemBuilder: (context, index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  child: Card(
                    color: phrases[index]['color'],
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      leading: Text(
                        phrases[index]['emoji'],
                        style: TextStyle(fontSize: 30),
                      ),
                      title: Text(
                        phrases[index]['text'],
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      onTap: () {
                        _speak(phrases[index]['text']);
                      },
                    ),
                  ),
                );
              },
            ),
          )
              : Text(
            'No common phrases available.',
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
        );
      },
    );
  }

  // Dialog to add a custom phrase
  void _showAddPhraseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Add Custom Phrase',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _customPhraseController,
                decoration: InputDecoration(
                  labelText: 'Enter your phrase',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addCustomPhrase,
                child: Text('Add Phrase'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
