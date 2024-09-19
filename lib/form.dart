import 'package:flutter/material.dart';
import 'home.dart';  // Import the home page

class ChildInfoForm extends StatefulWidget {
  @override
  _ChildInfoFormState createState() => _ChildInfoFormState();
}

class _ChildInfoFormState extends State<ChildInfoForm> {
  final _formKey = GlobalKey<FormState>();

  // Form field controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedASDLevel = 'Mild';
  String _selectedCommunicationLevel = 'Nonverbal';
  String _selectedAge = '3';
  String _selectedBehaviorLevel = 'Good';

  // Options for dropdowns
  final List<String> _asdLevels = ['Mild', 'Moderate', 'Severe'];
  final List<String> _communicationLevels = ['Nonverbal', 'Basic', 'Fluent'];
  final List<String> _ageOptions = ['3', '4', '5', '6', '7', '8', '9', '10'];
  final List<String> _behaviorLevels = ['Good', 'Average', 'Challenging'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Child Information Form'),
        backgroundColor: Colors.purple.shade700,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade100, Colors.purple.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                // Child Name Field
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Child Name',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the child\'s name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Level of ASD or ID Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedASDLevel,
                  decoration: InputDecoration(
                    labelText: 'Level of ASD or ID',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedASDLevel = newValue!;
                    });
                  },
                  items: _asdLevels.map((level) {
                    return DropdownMenuItem(
                      value: level,
                      child: Text(level),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),

                // Level of Communication Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedCommunicationLevel,
                  decoration: InputDecoration(
                    labelText: 'Level of Communication',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCommunicationLevel = newValue!;
                    });
                  },
                  items: _communicationLevels.map((level) {
                    return DropdownMenuItem(
                      value: level,
                      child: Text(level),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),

                // Age Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedAge,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedAge = newValue!;
                    });
                  },
                  items: _ageOptions.map((age) {
                    return DropdownMenuItem(
                      value: age,
                      child: Text(age),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),

                // Level of Behavior Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedBehaviorLevel,
                  decoration: InputDecoration(
                    labelText: 'Level of Behavior',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedBehaviorLevel = newValue!;
                    });
                  },
                  items: _behaviorLevels.map((level) {
                    return DropdownMenuItem(
                      value: level,
                      child: Text(level),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),

                // Description Field
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Navigate to home page after form submission
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      }
                    },
                    child: Text('Submit'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade700,
                      foregroundColor: Colors.white, // Button color
                      padding: EdgeInsets.symmetric(vertical: 16),
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
