import 'package:flutter/material.dart';
import '../about_us.dart';

class InstructorSelection extends StatelessWidget { // Change the class name here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ubhan Drive"),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Add your logout logic here
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
              Navigator.of(context).pushNamed('/instructor_booking');

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              color: Colors.grey[200], // Grey background color
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 80.0,

                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "Instructor Name",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text("Experience: 5 years"),
                  SizedBox(height: 10.0),
                  Text("Ratings: 4.5"),
                  SizedBox(height: 10.0),
                  Text("Students: 1000"),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      // Add your book now logic here
                      Navigator.of(context).pushNamed('/assistance_service_student');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      onPrimary: Colors.white,
                    ),
                    child: Text("Book Now"),
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
