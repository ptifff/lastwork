import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

import 'about_us.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InstructorTracking(),
    );
  }
}

class InstructorTracking extends StatefulWidget {
  @override
  _InstructorTrackingState createState() => _InstructorTrackingState();
}

class _InstructorTrackingState extends State<InstructorTracking> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Instructor Tracking', style: TextStyle(
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
        child: ElevatedButton(
          onPressed: () async {
            // Get current location
            Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high,
            );

            // Save location to Firebase
            await _firestore.collection('locations').add({
              'latitude': position.latitude,
              'longitude': position.longitude,
              'timestamp': FieldValue.serverTimestamp(),
            });

            // Open location in Google Maps
            String mapUrl = 'https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}';
            if (await canLaunch(mapUrl)) {
              await launch(mapUrl);
            } else {
              print('Could not launch Google Maps');
            }

            // Share location via WhatsApp
            String message = 'Check out my live location: $mapUrl';
            String whatsappUrl = 'https://wa.me/?text=${Uri.encodeFull(message)}';

            // Launch WhatsApp or fallback to browser if WhatsApp is not installed
            if (await canLaunch(whatsappUrl)) {
              await launch(whatsappUrl);
            } else {
              // If WhatsApp is not installed, open the link in a web browser
              launch(whatsappUrl);
            }
          },
          child: Text('Share My Location'),
        ),
      ),
    );
  }
}
