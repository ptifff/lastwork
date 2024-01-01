import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var accentColor;
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Learner Home Screen'),
            backgroundColor: Colors.purple,
            actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                // Implement logout functionality here
              },
            ),
          ],
        ),
                drawer: Drawer(
                  child: ListView(
                    children: [
                      FeatureDrawerButton(icon: Icons.school, text: 'Learning', onTap: () {
                        Navigator.of(context).pushNamed('/student_learning_selection');
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
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: FeatureButton(icon: Icons.school, text: 'Learning',onTap: () {
                      Navigator.of(context).pushNamed('/student_learning_selection');

                      },),
                  ),
                  Expanded(
                    child: FeatureButton(icon: Icons.book, text: 'Booking', onTap: () {
                      Navigator.of(context).pushNamed('/instructor_view');
                    },),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: FeatureButton(icon: Icons.schedule, text: 'Scheduling', onTap: () {
                      Navigator.of(context).pushNamed('/learner_scheduling');

                      },),

                  ),
                  Expanded(
                    child: FeatureButton(icon: Icons.track_changes, text: 'Tracking', onTap: () {
                      Navigator.of(context).pushNamed('/learner_tracking');

                      },),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: FeatureButton(icon: Icons.live_help, text: 'Assistance Service', onTap: () {
                      Navigator.of(context).pushNamed('/assistance_service_student');

                    },),
                  ),
                  Expanded(
                    child: FeatureButton(icon: Icons.info, text: 'About Us', onTap: () {
                      Navigator.of(context).pushNamed('/about_us');

                    },),
                  ),
                ],
              ),
            ],
          ),

    );
  }
}

class FeatureButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function() onTap;

  FeatureButton({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),
        height: 150.0,
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: Colors.purple,
                  size: 40.0,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
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
