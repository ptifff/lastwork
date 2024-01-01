import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'homeScreen.dart';
import 'instructor_homescreen.dart';
import 'login.dart';
import 'login_instructor.dart';
import 'student_login.dart';

class AuthService {
  final auth = FirebaseAuth.instance;
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController experience = TextEditingController();
  TextEditingController licenceNumber = TextEditingController();
  TextEditingController licenceExpiry = TextEditingController();
  TextEditingController password = TextEditingController();



  final firestore = FirebaseFirestore.instance;

  void LoginUser(context) async {
    try {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Center(
            child: CircularProgressIndicator(),
          ),
        );
      });
      await auth.signInWithEmailAndPassword(
          email: email!.text, password: password!.text).then((value) {
        print("User Is Logged In");
        Navigator.pop(context);

         Navigator.of(context).pushReplacement(
         MaterialPageRoute(builder: (context) =>
             InstructorHomeScreen()), // Replace with your login screen widget
        );
      });
    } catch (e) {
      Navigator.pop(context);
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text("Error Message"),
          content: Text(e.toString()),
        );
      });
    }
  }

  Future<void> InstructorRegister(BuildContext context, {File? image}) async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      );

      await auth.createUserWithEmailAndPassword(
        email: email!.text,
        password: password!.text,
      ).then((value) async {
        print("User Is Registered");
        String uid = auth.currentUser!.uid;

        // Check if the document already exists in Firestore
        bool documentExists = await FirebaseFirestore.instance
            .collection('instructors')
            .doc(uid)
            .get()
            .then((doc) => doc.exists);

        if (!documentExists) {
          // If the document doesn't exist, create a new one
          firestore.collection("instructors").doc(uid).set({
            "firstname": firstname.text,
            "lastname": lastname.text,
            "email": email.text,
            "experience": experience.text,
            "licencenumber": licenceNumber.text,
            "licenceexpiry": licenceExpiry.text,
            "password": password.text,
            "uid": uid,
          });
        }

        // Upload image to Firebase Storage
        // Upload image to Firebase Storage
        // Upload image to Firebase Storage
        if (image != null) {
          try {
            String imagePath = 'profile_images/$uid.jpg';
            Reference storageReference = FirebaseStorage.instance.ref().child(imagePath);
            await storageReference.putFile(image);
            String imageUrl = await storageReference.getDownloadURL();

            // Update the user's profile image URL in Firestore
            await FirebaseFirestore.instance.collection('instructors').doc(uid).update({
              'profileImageUrl': imageUrl,
            });
          } catch (e) {
            print("Error uploading profile picture: $e");
          }
        }


        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (c) => Login()));
      });
    } catch (e) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Error Message"),
            content: Text(e.toString()),
          );
        },
      );
    }
  }



//
  // void logOutUser(BuildContext context) async {
  //   // await auth.signOut();
  //   // Navigator.of(context).pushReplacement(
  //   //   MaterialPageRoute(builder: (context) =>
  //   //       Login()), // Replace with your login screen widget
  //   );
  // }
}

class StudentAuthService{
  final stuauth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  TextEditingController stufirstname = TextEditingController();
  TextEditingController stulastname = TextEditingController();
  TextEditingController stuemail = TextEditingController();
  TextEditingController stupassword = TextEditingController();

  void StudentLoginUser(context) async {
    try {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Center(
            child: CircularProgressIndicator(),
          ),
        );
      });
      await stuauth.signInWithEmailAndPassword(
          email: stuemail!.text, password: stupassword!.text).then((value) {
        print("Student Is Logged In");
        Navigator.pop(context);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) =>
              HomeScreen()), // Replace with your login screen widget
        );
      });
    } catch (e) {
      Navigator.pop(context);
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text("Error Message"),
          content: Text(e.toString()),
        );
      });
    }
  }



  void StudentRegister(context) async {
    try {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Center(
            child: CircularProgressIndicator(),
          ),
        );
      });
      await stuauth.createUserWithEmailAndPassword(
          email: stuemail!.text, password: stupassword!.text).then((value) {
        print("Student Is Registered");
        firestore.collection("student").add({
          "stufirstname": stufirstname.text,
          "stulastname": stulastname.text,
          "stuemail": stuemail.text,
          "stupassword": stupassword.text,
          "stuid": stuauth.currentUser!.uid
        });

        Navigator.pop(context);

        Navigator.push(context, MaterialPageRoute(builder: (c) => StudentLogin()));
      });
    } catch (e) {
      Navigator.pop(context);
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text("Error Message"),
          content: Text(e.toString()),
        );
      });
    }
  }

}