import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'student_login.dart'; // Import this to use Future.delayed


void main() {
  runApp(StudentSignUp());
}
class StudentSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text('Student Sign Up'),
        ),
        body: SignUpForm(),

    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String firstName = '';
  String lastName = '';
  String password = '';

  void navigateToSignUpSuccessScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SignupSuccessScreen(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email';
                } else if (!value!.contains('@gmail.com')) {
                  return 'Email must contain @gmail.com';
                }
                return null;
              },
            ),
            SizedBox(height: 12.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'First Name'),
              onChanged: (value) {
                setState(() {
                  firstName = value;
                });
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your first name';
                }
                return null;
              },
            ),
            SizedBox(height: 12.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Last Name'),
              onChanged: (value) {
                setState(() {
                  lastName = value;
                });
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your last name';
                }
                return null;
              },
            ),
            SizedBox(height: 12.0),

            SizedBox(height: 12.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your password';
                } else if (value.length < 8) {
                  return 'Password must be at least 8 characters long';
                }

                return null;
              },
              obscureText: true,
            ),

            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Perform signup logic here
                  // You can access the form values using the variables defined above.
                  // Example: firstName, lastName, cnic, dob, address, email, password, role

                  // After successful signup, navigate to the success screen
                  navigateToSignUpSuccessScreen();
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
                onPrimary: Colors.white,
              ),
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

class SignupSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use a Timer to navigate after 4 seconds
    Timer(Duration(seconds: 4), () {
      // Push the Login screen onto the stack
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => StudentLogin(),
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Signup Success'),
      ),
      body: Center(
        child: Text('Congratulations! Your signup was successful.'),
      ),
    );
  }
}
