import 'dart:async';
import 'package:flutter/material.dart';
import '';
import 'package:firebase_auth/firebase_auth.dart';
import 'helper.dart';
import 'instructor_homescreen.dart';
import 'signup.dart';


class LoginScreen extends StatelessWidget {
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
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 70)),
                  onPressed: () {

                  },
                  child: Text("LogIn")),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                child: Text("Don't have an account? SignUp"),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
// class InstructorRegister extends StatelessWidget {
//   AuthService authService = AuthService();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
//         child: Form(
//
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Register Your Account",
//                 style: TextStyle(
//                   color: Colors.lightBlue,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(
//                 height: 16.0,
//               ),
//               TextFormField(
//                 controller: authService.firstname,
//                 decoration: InputDecoration(
//                   hintText: "First Name",
//                   hintStyle: TextStyle(
//                     color: Colors.blue,
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//
//               ),
//               SizedBox(
//                 height: 16.0,
//               ),
//               TextFormField(
//                 controller: authService.lastname,
//                 decoration: InputDecoration(
//                   hintText: "Last Name",
//                   hintStyle: TextStyle(
//                     color: Colors.blue,
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//
//               ),
//               SizedBox(
//                 height: 16.0,
//               ),
//               TextFormField(
//                 controller: authService.email,
//                 decoration: InputDecoration(
//                   hintText: "E-Mail",
//                   hintStyle: TextStyle(
//                     color: Colors.blue,
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 16.0,
//               ),
//               TextFormField(
//                 controller: authService.password,
//                 decoration: InputDecoration(
//                   hintText: "Password",
//                   hintStyle: TextStyle(
//                     color: Colors.blue,
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//
//               ),
//               SizedBox(
//                 height: 16.0,
//               ),
//               ElevatedButton(
//                   style: TextButton.styleFrom(
//                       padding: EdgeInsets.symmetric(horizontal: 70)),
//                   onPressed: () {
//                     if(authService.email != "" && authService.password != ""){
//                       authService.InstructorRegister(context);
//                     }
//                   },
//                   child: Text("Register")),
//               TextButton(
//                 onPressed: () {
//                   // Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
//                 },
//                 child: Text("Already have an account? Login"),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

