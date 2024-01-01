import 'package:flutter/material.dart';

import 'instructor_lecture_uploads.dart';
import 'quiz/home.dart';

class InstructorTopicSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Learning Material'),
        backgroundColor: Colors.purple,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            FeatureDrawerButton(icon: Icons.school, text: 'Learning', onTap: () {
              Navigator.of(context).pushNamed('/instructor_uploading');
            },),
            FeatureDrawerButton(icon: Icons.schedule, text: 'Scheduling', onTap: () {
              Navigator.of(context).pushNamed('/instructor_scheduling');
            },),
            FeatureDrawerButton(icon: Icons.track_changes, text: 'Tracking', onTap: () {
              Navigator.of(context).pushNamed('/instructor_tracking');
            },),
            FeatureDrawerButton(icon: Icons.live_help, text: 'Assistance Service', onTap: () {

            },),
            FeatureDrawerButton(icon: Icons.info, text: 'About Us', onTap: () {
              Navigator.of(context).pushNamed('/about_us');
            },),
            FeatureDrawerButton(icon: Icons.logout, text: 'Logout', onTap: () {
              Navigator.of(context).pushNamed('/login_instructor');
            },),
          ],
        ),
      ),
      body: Container(
        color: Colors.white, // White background
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Evenly distribute the panels
              children: [
                Container(
                  width: 150.0, // Specify the width
                  height: 150.0, // Specify the height
                  child: PanelCard(
                    icon: Icons.library_books,
                    label: 'Upload Lectures',
                  ),
                ),
                SizedBox(width: 20.0), // Gap between panels
                Container(
                  width: 150.0, // Specify the width
                  height: 150.0, // Specify the height
                  child: PanelCard(
                    icon: Icons.library_books,
                    label: 'Create Quizzes',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
    if (label == 'Lectures') {
      // // Navigate to the Instructor screen.
       Navigator.of(context).push(
       MaterialPageRoute(builder: (context) => InstructorUploadScreen()),
       );
    } else if (label == 'Quizzes') {
      // // Navigate to the Student screen.
       Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Home()),
       );
    }
  }

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

class FeatureDrawerButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function() onTap;

  FeatureDrawerButton({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.purple, // Set the color to purple
      ),
      title: Text(
        text,
        style: TextStyle(
          color: Colors.purple, // Set the color to purple
          fontSize: 18.0,
        ),
      ),
      onTap: onTap,
    );
  }
}
