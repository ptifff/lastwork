import 'package:drive_ubhan/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'helper.dart';
import 'instructor_homescreen.dart';

final auth =FirebaseAuth.instance;

void main()  {
  runApp(MaterialApp(
    home:auth.currentUser == null?Login():InstructorHomeScreen(),
  ),
  );
}
class Login extends StatelessWidget {
  AuthService authService = AuthService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Form(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login Your Account",
                style: TextStyle(
                    color: Colors.purple,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: authService.email,
                decoration: InputDecoration(
                  hintText: "E-Mail",
                  hintStyle: TextStyle(
                    color: Colors.purple,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: authService.password,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(
                    color: Colors.purple,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                // Apply password validation
              ),
              SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(horizontal: 70),
                    ),
                  ),onPressed: () {
                    if(authService.email != "" && authService.password != ""){
                      authService.LoginUser(context);
                    }
                  },
                  child: Text("LogIn")),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                child: Text(
                  "Don't have an account? SignUp",
                  style: TextStyle(
                    color: Colors.purple, // Set text color to purple
                  ),
                ),),

            ],
          ),
        ),
      ),
    );
  }
}