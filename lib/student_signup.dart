import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'helper.dart';
import 'student_login.dart';

void main() {
  runApp(StudentSignUpScreen());
}

class StudentSignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Student Sign Up'),
        backgroundColor: Colors.purple,
      ),
      body: StudentRegister(),
    );
  }
}

class StudentRegister extends StatelessWidget {
  StudentAuthService authService = StudentAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Register Your Account",
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: authService.stufirstname,
                  decoration: InputDecoration(
                    hintText: "First Name",
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
                  controller: authService.stulastname,
                  decoration: InputDecoration(
                    hintText: "Last Name",
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
                  controller: authService.stuemail,
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
                  controller: authService.stupassword,
                  decoration: InputDecoration(
                    hintText: "Password",
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
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(horizontal: 70),
                    ),
                  ),
                  onPressed: () {
                    if (authService.stuemail != "" && authService.stupassword != "") {
                      authService.StudentRegister(context);
                    }
                  },
                  child: Text("Register"),
                ),
                TextButton(
                  onPressed: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) =>StudentLogin()));
                  },
                  child: Text("Already have an account? Login",
                    style: TextStyle(
                      color: Colors.purple,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
