import 'package:flutter/material.dart';

import 'quiz/widgets.dart';
import 'student_login.dart';

class bookingcomplete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Booked', style: TextStyle(
          color: Colors.white, // Set app bar text color to white
        ),
        ),
        backgroundColor: Colors.purple,

      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: 300, // Adjust the container size as needed
              height: 400,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200], // Light grey background color
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Thank You For Booking ',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Kindly visit our center for further process.',
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
                  GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StudentLogin()));
                      },
                      child: orangeButton(context, "Login", MediaQuery.of(context).size.width/2, Colors.purple)
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
