import 'package:flutter/material.dart';

import 'package:random_string/random_string.dart';

import 'database.dart';
import 'widgets.dart';


class AddQuestion extends StatefulWidget {

  final String quizId;
  AddQuestion(this.quizId);

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {

  final _formKey = GlobalKey<FormState>();
  String question="", option1="", option2="", option3="", option4="", correctAnswer="", questionId="";

  bool _isLoading = false;

  DatabaseService _databaseService = new DatabaseService(uid: '', email: '');

  _uploadQuestionData() async{
    if(_formKey.currentState!.validate()){

      setState(() {
        _isLoading = true;
      });

      questionId = randomAlphaNumeric(16);

      Map<String, dynamic> questionData = {
        "question" : question,
        "option1" : option1,
        "option2" : option2,
        "option3" : option3,
        "option4" : option4,
        "correctAnswer" : correctAnswer,
        "questionId" : questionId
      };

      await _databaseService.addQuestionData(questionData, widget.quizId, questionId).then((value) => {
        setState(() {
          _isLoading = false;
        })
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Questions', style: TextStyle(
          color: Colors.white, // Set app bar text color to white
        ),
        ),
        backgroundColor: Colors.purple,

      ),
      body: _isLoading ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) : Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Question"
                ),
                onChanged: (val){
                  question = val;
                },
                validator: (val){
                  return val!.isEmpty ? "Enter question" : null;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Option one"
                ),
                onChanged: (val){
                  option1 = val;
                },
                validator: (val){
                  return val!.isEmpty ? "Enter option one" : null;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Option two"
                ),
                onChanged: (val){
                  option2 = val;
                },
                validator: (val){
                  return val!.isEmpty ? "Enter option two" : null;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Option three"
                ),
                onChanged: (val){
                  option3 = val;
                },
                validator: (val){
                  return val!.isEmpty ? "Enter option three" : null;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Option four"
                ),
                onChanged: (val){
                  option4 = val;
                },
                validator: (val){
                  return val!.isEmpty ? "Enter option four" : null;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Correct answer"
                ),
                onChanged: (val){
                  correctAnswer = val;
                },
                validator: (val){
                  return val!.isEmpty ? "Enter correct answer" : null;
                },
              ),
              SizedBox(height: 50),

              Row(
                children: [
                  GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: orangeButton(context, "Submit", MediaQuery.of(context).size.width/2 - 36, Colors.red)
                  ),
                  SizedBox(width: 24,),
                  GestureDetector(
                      onTap: (){
                        _uploadQuestionData();
                      },
                      child: orangeButton(context, "Add Question", MediaQuery.of(context).size.width/2 - 36, Colors.purple)
                  ),
                ]
              ),
              SizedBox(height: 40.0)
            ],
          ),
        ),
      ),
    );
  }
}
