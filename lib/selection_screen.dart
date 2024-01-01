import 'package:flutter/material.dart';

import 'homeScreen.dart';
import 'instructor_homescreen.dart';
import 'login_instructor.dart';
import 'student_login.dart';


class SelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text('Panel Selection'),
            backgroundColor: Colors.purple,

          ),
          body: Container(
            color: Colors.white, // White background
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Select your panel based on your preferences.',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Evenly distribute the panels
                  children: [
                    Container(
                      width: 150.0, // Specify the width
                      height: 150.0, // Specify the height
                      child: PanelCard(
                        icon: Icons.person,
                        label: 'Instructor',
                      ),
                    ),
                    SizedBox(width: 20.0), // Gap between panels
                    Container(
                      width: 150.0, // Specify the width
                      height: 150.0, // Specify the height
                      child: PanelCard(
                        icon: Icons.school,
                        label: 'Student',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )

    );
  }
}

class PanelCard extends StatelessWidget {
  final IconData icon;
  final String label;

  PanelCard({
    required this.icon,
    required this.label,
  });
  void _handlePanelTap(BuildContext context) {
    // Add your desired action here when the panel is tapped.
    // For example, you can navigate to a new screen.
    if (label == 'Instructor') {
      // Navigate to the Instructor screen.
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Login()),
      );
    } else if (label == 'Student') {
      // Navigate to the Student screen.
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => StudentLogin()),
      );
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handlePanelTap(context),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[200], // Light grey background
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48.0,
              color: Colors.purple, // Purple icon
            ),
            SizedBox(height: 10.0),
            Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

