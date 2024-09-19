import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class CommunicationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Communication Tools'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Choose a Communication Tool',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            _buildToolButton(
              context: context,
              icon: Icons.speaker,
              label: 'Text-to-Speech',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TextToSpeechPage()),
                );
              },
            ),
            _buildToolButton(
              context: context,
              icon: Icons.image,
              label: 'Pictograms',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PictogramsPage()),
                );
              },
            ),
            _buildToolButton(
              context: context,
              icon: Icons.chat,
              label: 'Common Phrases',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CommonPhrasesPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 40),
        label: Text(
          label,
          style: TextStyle(fontSize: 20),
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.greenAccent[400],
          minimumSize: Size(double.infinity, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

// Page for Text-to-Speech
class TextToSpeechPage extends StatefulWidget {
  @override
  _TextToSpeechPageState createState() => _TextToSpeechPageState();
}

class _TextToSpeechPageState extends State<TextToSpeechPage> {
  FlutterTts flutterTts = FlutterTts();
  TextEditingController _controller = TextEditingController();

  _speak(String text) async {
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text-to-Speech'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter text to speak',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _speak(_controller.text),
              child: Text('Speak'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Page for Pictograms
class PictogramsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pictograms'),
        backgroundColor: Colors.green[700],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purpleAccent, Colors.tealAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          padding: const EdgeInsets.all(16.0),
          itemCount: 6,
          itemBuilder: (context, index) {
            return _buildPictogramCard(
              context,
              'assets/Images/h${index + 1}.png', // Ensure this path matches your assets
              'Pictogram ${index + 1}',
            );
          },
        ),
      ),
    );
  }

  Widget _buildPictogramCard(BuildContext context, String imagePath, String label) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PictogramDetailPage(
              imagePath: imagePath,
              label: label,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orangeAccent, Colors.deepOrangeAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    imagePath,
                    width: 80,
                    height: 80,
                  ),
                  SizedBox(height: 10),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
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

// Page for Pictogram Detail
class PictogramDetailPage extends StatelessWidget {
  final String imagePath;
  final String label;

  PictogramDetailPage({required this.imagePath, required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(label),
        backgroundColor: Colors.green[700],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.pinkAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  width: 150,
                  height: 150,
                ),
                SizedBox(height: 20),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Here you can add detailed information about the pictogram. This might include instructions, context of use, or any other relevant details to help the user understand the pictogram better.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    // textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Add any action here if needed
                  },
                  child: Text('Learn More'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Page for Common Phrases
class CommonPhrasesPage extends StatelessWidget {
  FlutterTts flutterTts = FlutterTts();

  _speakPhrase(String phrase) async {
    await flutterTts.speak(phrase);
  }

  final List<String> phrases = [
    'Hello!',
    'Good Morning!',
    'Thank you!',
    'Yes',
    'No',
    'Please help me'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Common Phrases'),
        backgroundColor: Colors.green[700],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: phrases.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.greenAccent[100],
            child: ListTile(
              title: Text(
                phrases[index],
                style: TextStyle(fontSize: 20),
              ),
              trailing: Icon(Icons.play_arrow),
              onTap: () => _speakPhrase(phrases[index]),
            ),
          );
        },
      ),
    );
  }
}
