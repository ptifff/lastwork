
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'create_quiz.dart';
import 'database.dart';
import 'play_quiz.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream quizStream = Stream.empty();


  DatabaseService _databaseService = new DatabaseService(uid: '', email: '');

  bool _isLoading = true;

  Future<void> _initializeData() async {
    var value = await _databaseService.getQuizData();
    setState(() {
      quizStream = value;
      _isLoading = false;
    });
  }

  Widget quizList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder(
        stream: quizStream,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: Text(
                  "No Quiz Available",
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
              ),
            );
          }

          QuerySnapshot querySnapshot = snapshot.data as QuerySnapshot;

          return ListView.builder(
            itemCount: querySnapshot.docs.length,
            itemBuilder: (context, index) {
              var quizData =
              querySnapshot.docs[index]?.data() as Map<String, dynamic>?;

              return QuizTile(
                imageUrl: quizData?["quizImgUrl"] ?? "",
                title: quizData?["quizTitle"] ?? "",
                description: quizData?["quizDescription"] ?? "",
                quizId: quizData?["quizId"] ?? "",
              );
            },
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Uploading Quiz', style: TextStyle(
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

            },),
            FeatureDrawerButton(icon: Icons.info, text: 'About Us', onTap: () {
              Navigator.of(context).pushNamed('/about_us');
            },),
            FeatureDrawerButton(icon: Icons.logout, text: 'Logout', onTap: () {
              Navigator.of(context).pushNamed('/login_instructor');
            },),
          ],
        ),
      ),
      body: _isLoading
          ? Container(
        child: Center(child: CircularProgressIndicator()),
      )
          : quizList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white, // Set the icon color to white
        ),
        backgroundColor: Colors.purple,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateQuiz()),
          );
        },
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String quizId;

  QuizTile({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.quizId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return PlayQuiz(quizId);
          }),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        height: 150,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                width: MediaQuery.of(context).size.width - 48,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black26,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
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
