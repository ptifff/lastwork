import 'package:drive_ubhan/login.dart';
import 'package:drive_ubhan/signup.dart';
import 'package:drive_ubhan/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'about_us.dart';
import 'assistance_service_instructor.dart';
import 'assistance_service_student.dart';
import 'booking.dart';
import 'booking_complete.dart';
import 'homeScreen.dart';
import 'instructor_aboutus.dart';
import 'instructor_homescreen.dart';
import 'instructor_lecture_uploads.dart';
import 'instructor_scheduling.dart';
import 'instructor_tracking.dart';
import 'instructor_uploading.dart';
import 'instructor_view.dart';
import 'learner_scheduling.dart';
import 'learner_tracking.dart';
import 'learning_material.dart';
import 'login_instructor.dart';
import 'quiz/home.dart';
import 'selection_screen.dart';
import 'firebase_options.dart';
import 'student_learning_selection.dart';
import 'student_lectures.dart';
import 'student_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login_instructor': (context) => Login(),
        '/student_login': (context) => StudentLogin(),
        '/signup': (context) => InstructorRegister(),
        '/homeScreen': (context) => HomeScreen(),
        '/booking': (context) => InstructorSelection(),
        '/student_learning_selection': (context) => StudentTopicSelection(),
        '/student_lectures': (context) => StudentsLectureScreen(),
        '/learner_scheduling': (context) => LearnerEventScreen(),
        '/learner_tracking': (context) => learnertracking(),
        '/instructor_view': (context) => AllInstructorsScreen(),

        // You can pass actual data here
        '/assistance_service_student': (context) => AssistanceServiceScreen(),
        '/about_us': (context) => AboutUsScreen(),
        //instructor panel routing
        '/assistance_service_instructor': (context) => InstructorAssistance(),
        '/instructor_aboutus': (context) => InstructorAboutUs(),
        '/instructor_homescreen': (context) => InstructorHomeScreen(),
        '/instructor_uploading': (context) => InstructorTopicSelection(),
        '/instructor_lectures_uploads': (context) => InstructorUploadScreen(),
        '/instructor_tracking': (context) => InstructorTracking(),
        '/instructor_scheduling': (context) => EventCalendarScreen(),
        '/booking_complete': (context) => bookingcomplete(),
        '/home': (context) => Home(),


      },
    );
  }
}
