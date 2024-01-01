import 'package:flutter/material.dart';


class instructorbooking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text('Ubhan Drive'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                // Implement your logout logic here
              },
            ),
          ],
        ),
      drawer: Drawer(
        child: ListView(
          children: [
            FeatureDrawerButton(icon: Icons.school, text: 'Learning', onTap: () {
              Navigator.of(context).pushNamed('/learning_material');
            },),
            FeatureDrawerButton(icon: Icons.book, text: 'Booking', onTap: () {
              Navigator.of(context).pushNamed('/instructor_view');

            },),
            FeatureDrawerButton(icon: Icons.schedule, text: 'Scheduling', onTap: () {
              Navigator.of(context).pushNamed('/learner_scheduling');
            },),
            FeatureDrawerButton(icon: Icons.track_changes, text: 'Tracking', onTap: () {
              Navigator.of(context).pushNamed('/learner_tracking');
            },),
            FeatureDrawerButton(icon: Icons.live_help, text: 'Assistance Service', onTap: () {
              Navigator.of(context).pushNamed('/assistance_service_student');
            },),
            FeatureDrawerButton(icon: Icons.info, text: 'About Us', onTap: () {
              Navigator.of(context).pushNamed('/about_us');
            },),
            FeatureDrawerButton(icon: Icons.logout, text: 'Logout', onTap: () {
              Navigator.of(context).pushNamed('/login_student');
            },),
          ],
        ),
      ),
        body: LearningFeatures(),
    );
  }
}

class LearningFeatures extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        children: [
          FeatureCard(
            icon: Icons.person,
            instructorName: 'Instructor 1',
          ),
          FeatureCard(
            icon: Icons.person,
            instructorName: 'Instructor 2',
          ),
          FeatureCard(
            icon: Icons.person,
            instructorName: 'Instructor 3',
          ),
          FeatureCard(
            icon: Icons.person,
            instructorName: 'Instructor 4',
          ),
          FeatureCard(
            icon: Icons.person,
            instructorName: 'Instructor 5',
          ),
          FeatureCard(
            icon: Icons.person,
            instructorName: 'Instructor 6',
          ),
          FeatureCard(
            icon: Icons.person,
            instructorName: 'Instructor 7',
          ),
          FeatureCard(
            icon: Icons.person,
            instructorName: 'Instructor 8',
          ),
        ],
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String instructorName;

  FeatureCard({required this.icon, required this.instructorName});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 50.0,
            color: Colors.purple,
          ),
          SizedBox(height: 16.0),
          Text(
            instructorName,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/booking');
              // Implement your view profile button logic here
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.purple, // Button color
              onPrimary: Colors.white, // Text color
            ),
            child: Text('View Profile'),
          ),
        ],
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
