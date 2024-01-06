import 'package:flutter/material.dart';

class InstructorAboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'About Us',
          style: TextStyle(
            color: Colors.white, // Set app bar text color to white
          ),
        ),
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
              Navigator.of(context).pushNamed('/assistance_service_instructor');

            },),
            FeatureDrawerButton(icon: Icons.info, text: 'About Us', onTap: () {
              Navigator.of(context).pushNamed('/instructor_aboutus');
            },),
            FeatureDrawerButton(icon: Icons.logout, text: 'Logout', onTap: () {
              Navigator.of(context).pushNamed('/login_instructor');
            },),

          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: 300, // Adjust the container size as needed
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200], // Light grey background color
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'OUR VISION',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Our Vision is to initiate to empower women through driving skill set and bring equality and freedom on the roads.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.purple,
                    ),
                  ),
                  SizedBox(height: 16),
                  Divider(
                    color: Colors.purple,
                    thickness: 1.5,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'OUR MISSION',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Our mission is to provide necessary information and techniques to be a Safe Responsible Female driver.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),
          ),
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
