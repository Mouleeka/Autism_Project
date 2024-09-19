import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.purple,
                child: const Icon(Icons.person, size: 50, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Name: John Doe',
              style: TextStyle(fontSize: 18, color: Colors.purple),
            ),
            const SizedBox(height: 10),
            const Text(
              'Email: johndoe@example.com',
              style: TextStyle(fontSize: 18, color: Colors.purple),
            ),
            // Add more profile information here
          ],
        ),
      ),
    );
  }
}
