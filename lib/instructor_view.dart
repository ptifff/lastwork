import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'booking_complete.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getAllInstructorsData() async {
    try {
      QuerySnapshot snapshot =
      await _firestore.collection('instructors').get();

      List<Map<String, dynamic>> instructorsData = [];

      for (QueryDocumentSnapshot doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        instructorsData.add({
          'uid': data['uid'],
          'firstname': data['firstname'],
          'lastname': data['lastname'],
          'experience': data['experience'],
          'profileImageUrl': data['profileImageUrl'],
        });
      }

      return instructorsData;
    } catch (e, stackTrace) {
      print('Error fetching instructor data: $e');
      print('Stack Trace: $stackTrace');
      throw Exception('Error fetching instructor data');
    }
  }
}

class AllInstructorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Instructors'),
        backgroundColor: Colors.purple,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            FeatureDrawerButton(
                icon: Icons.school,
                text: 'Learning',
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/student_learning_selection');
                }),
            FeatureDrawerButton(
                icon: Icons.book,
                text: 'Booking',
                onTap: () {
                  Navigator.of(context).pushNamed('/instructor_booking');
                }),
            FeatureDrawerButton(
                icon: Icons.schedule,
                text: 'Scheduling',
                onTap: () {
                  Navigator.of(context).pushNamed('/learner_scheduling');
                }),
            FeatureDrawerButton(
                icon: Icons.track_changes,
                text: 'Tracking',
                onTap: () {
                  Navigator.of(context).pushNamed('/learner_tracking');
                }),
            FeatureDrawerButton(
                icon: Icons.live_help,
                text: 'Assistance Service',
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/assistance_service_student');
                }),
            FeatureDrawerButton(
                icon: Icons.info, text: 'About Us', onTap: () {
              Navigator.of(context).pushNamed('/about_us');
            }),
            FeatureDrawerButton(
                icon: Icons.logout, text: 'Logout', onTap: () {
              Navigator.of(context).pushNamed('/login_student');
            }),
          ],
        ),
      ),
      body: FutureBuilder(
        future: FirestoreService().getAllInstructorsData(),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return showErrorDialog(context, snapshot.error.toString());
          } else if (!snapshot.hasData || snapshot.data == null) {
            return showErrorDialog(context, 'No instructors found');
          } else {
            List<Map<String, dynamic>> instructorsData = snapshot.data!;

            return Container(
              height: MediaQuery.of(context).size.height,
              // Set a height (you can adjust this value)

              child: SingleChildScrollView(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  padding: EdgeInsets.all(24.0),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: instructorsData.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> instructorData = instructorsData[index];
                    return InstructorBox(
                      firstname: instructorData['firstname'],
                      lastname: instructorData['lastname'],
                      experience: instructorData['experience'],
                      profileImageUrl: instructorData['profileImageUrl'],
                    );
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget showErrorDialog(BuildContext context, String errorMessage) {
    return AlertDialog(
      title: Text('Error Message'),
      content: Text(errorMessage),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('OK'),
        ),
      ],
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

class InstructorBox extends StatelessWidget {
  final String firstname;
  final String lastname;
  final String experience;
  final String profileImageUrl;

  InstructorBox({
    required this.firstname,
    required this.lastname,
    required this.experience,
    required this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0, // Set your desired height here

      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              child: CircleAvatar(
                radius: 35.0,
                backgroundImage: NetworkImage(profileImageUrl),
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Text('Name: $firstname $lastname', style: TextStyle(fontSize: 16.0)),
                  SizedBox(height: 8.0),
                  Text('Experience: $experience', style: TextStyle(fontSize: 14.0)),
                ],
              ),
            ),
          ),
          Container(
            height: 42.0, // Set a fixed height for the button container
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => bookingcomplete()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple, // Set the background color to purple
              ),

              child: Text('Book Now'),
            ),
          ),
        ],
      ),
    );
  }
}
