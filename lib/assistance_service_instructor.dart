import 'package:flutter/material.dart';
import 'homeScreen.dart';

class InstructorAssistance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Assistance', style: TextStyle(
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 300,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Icon(
                      Icons.headset_mic,
                      size: 100,
                      color: Colors.purple,
                    ),
                    SizedBox(height: 20),
                    TextField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        labelStyle: TextStyle(
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        labelStyle: TextStyle(
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Problem Description',
                        labelStyle: TextStyle(
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Add your submission logic here
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                        onPrimary: Colors.white,
                      ),
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            ],
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
        color: Colors.purple,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: Colors.purple,
          fontSize: 18.0,
        ),
      ),
      onTap: onTap,
    );
  }
}
