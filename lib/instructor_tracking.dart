import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

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
        title: Text('Live Tracking'),
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
