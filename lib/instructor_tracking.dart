import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Instructor Tracking',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.purple,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            // FeatureDrawerButton widgets go here
          ],
        ),
      ),
      body: GoogleMap(
        markers: _markers,
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0), // Initial position, set it to your default location
          zoom: 15,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Position senderPosition = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );

          // Save sender's location to Firebase
          await _firestore.collection('locations').add({
            'latitude': senderPosition.latitude,
            'longitude': senderPosition.longitude,
            'timestamp': FieldValue.serverTimestamp(),
            'sender': true,
          });

          // Update markers for sender
          _updateMarkers(senderPosition.latitude, senderPosition.longitude);

          // Open location in Google Maps for sender
          String mapUrl =
              'https://www.google.com/maps/search/?api=1&query=${senderPosition.latitude},${senderPosition.longitude}';
          if (await canLaunch(mapUrl)) {
            await launch(mapUrl);
          } else {
            print('Could not launch Google Maps');
          }

          // Share location via WhatsApp for sender
          String senderMessage =
              'Check out my live location at ${senderPosition.latitude}, ${senderPosition.longitude}. Open in Google Maps: $mapUrl';
          String senderWhatsappUrl =
              'https://wa.me/?text=${Uri.encodeFull(senderMessage)}';

          // Launch WhatsApp or fallback to browser if WhatsApp is not installed for sender
          if (await canLaunch(senderWhatsappUrl)) {
            await launch(senderWhatsappUrl);
          } else {
            // If WhatsApp is not installed, open the link in a web browser
            launch(senderWhatsappUrl);
          }

          // Fetch sender's location from Firebase for receiver
          QuerySnapshot senderSnapshot = await _firestore.collection('locations').where('sender', isEqualTo: true).get();

          if (senderSnapshot.docs.isNotEmpty) {
            // Get the first document (assuming only one sender for simplicity)
            var senderData = senderSnapshot.docs.first.data();

            if (senderData != null && senderData is Map<String, dynamic> && senderData.containsKey('latitude') && senderData.containsKey('longitude')) {
              double senderLatitude = senderData['latitude'];
              double senderLongitude = senderData['longitude'];

              // Update markers for sender
              _updateMarkers(senderLatitude, senderLongitude);

              // Open location in Google Maps for receiver
              String receiverMapUrl =
                  'https://www.google.com/maps/search/?api=1&query=$senderLatitude,$senderLongitude';
              if (await canLaunch(receiverMapUrl)) {
                await launch(receiverMapUrl);
              } else {
                print('Could not launch Google Maps');
              }

              // Share location via WhatsApp for receiver
              String receiverMessage =
                  'Check out the sender\'s live location at $senderLatitude, $senderLongitude. Open in Google Maps: $receiverMapUrl';
              String receiverWhatsappUrl =
                  'https://wa.me/?text=${Uri.encodeFull(receiverMessage)}';

              // Launch WhatsApp or fallback to browser if WhatsApp is not installed for receiver
              if (await canLaunch(receiverWhatsappUrl)) {
                await launch(receiverWhatsappUrl);
              } else {
                // If WhatsApp is not installed, open the link in a web browser
                launch(receiverWhatsappUrl);
              }
            }
          }
        },
        child: Icon(Icons.location_on),
      ),
    );
  }

  void _updateMarkers(double latitude, double longitude) {
    // Clear existing markers and add a new one for the sender
    setState(() {
      _markers = {
        Marker(
          markerId: MarkerId('sender'),
          position: LatLng(latitude, longitude),
          infoWindow: InfoWindow(title: 'Sender Location'),
        ),
      };
    });
  }
}

class FeatureDrawerButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const FeatureDrawerButton({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onTap,
    );
  }
}
