import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'about_us.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LearnerEventScreen(),
    );
  }
}

class LearnerEvent {
  String id;
  String title;
  DateTime startTime;
  DateTime endTime;

  LearnerEvent({required this.id, required this.title, required this.startTime, required this.endTime});
}

class LearnerEventScreen extends StatefulWidget {
  const LearnerEventScreen({Key? key}) : super(key: key);

  @override
  State<LearnerEventScreen> createState() => _LearnerEventScreenState();
}

class _LearnerEventScreenState extends State<LearnerEventScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;

  Map<String, List> mySelectedEvents = {};

  final titleController = TextEditingController();
  final descpController = TextEditingController();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _selectedDate = _focusedDay;

    loadPreviousEvents();
  }

  loadPreviousEvents() async {
    QuerySnapshot querySnapshot = await _firestore.collection('events').get();

    querySnapshot.docs.forEach((doc) {
      DateTime startTime = (doc['start_time'] as Timestamp).toDate();
      DateTime endTime = (doc['end_time'] as Timestamp).toDate();

      if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(startTime)] != null) {
        mySelectedEvents[DateFormat('yyyy-MM-dd').format(startTime)]!.add({
          "eventTitle": doc['title'],
          "eventDescp": doc['description'],
          "start_time": startTime,
          "end_time": endTime,
        });
      } else {
        mySelectedEvents[DateFormat('yyyy-MM-dd').format(startTime)] = [
          {
            "eventTitle": doc['title'],
            "eventDescp": doc['description'],
            "start_time": startTime,
            "end_time": endTime,
          }
        ];
      }
    });
  }

  List _listOfDayEvents(DateTime dateTime) {
    if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
      return mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }

  _showAddEventDialog() async {
    DateTime selectedStartTime = _selectedDate ?? DateTime.now();
    DateTime selectedEndTime = selectedStartTime.add(Duration(hours: 1));

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(

        title: Container(

          child: const Text(
            'Add New Event',
            textAlign: TextAlign.center,


          ),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: descpController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    TimeOfDay? startTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(selectedStartTime),
                    );
                    if (startTime != null) {
                      setState(() {
                        selectedStartTime = DateTime(
                          _selectedDate!.year,
                          _selectedDate!.month,
                          _selectedDate!.day,
                          startTime.hour,
                          startTime.minute,
                        );
                      });
                    }
                  },
                  child: Text('Start Time'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    TimeOfDay? endTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(selectedEndTime),
                    );
                    if (endTime != null) {
                      setState(() {
                        selectedEndTime = DateTime(
                          _selectedDate!.year,
                          _selectedDate!.month,
                          _selectedDate!.day,
                          endTime.hour,
                          endTime.minute,
                        );
                      });
                    }
                  },
                  child: Text('End Time'),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            child: const Text('Add Event'),

            onPressed: () {
              if (titleController.text.isEmpty && descpController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Required title and description'),
                    duration: Duration(seconds: 2),
                  ),
                );
                return;
              } else {
                _firestore.collection('events').add({
                  "title": titleController.text,
                  "description": descpController.text,
                  "start_time": selectedStartTime,
                  "end_time": selectedEndTime,
                });

                setState(() {
                  if (mySelectedEvents[
                  DateFormat('yyyy-MM-dd').format(_selectedDate!)] !=
                      null) {
                    mySelectedEvents[
                    DateFormat('yyyy-MM-dd').format(_selectedDate!)]
                        ?.add({
                      "eventTitle": titleController.text,
                      "eventDescp": descpController.text,
                      "start_time": selectedStartTime,
                      "end_time": selectedEndTime,
                    });
                  } else {
                    mySelectedEvents[
                    DateFormat('yyyy-MM-dd').format(_selectedDate!)] = [
                      {
                        "eventTitle": titleController.text,
                        "eventDescp": descpController.text,
                        "start_time": selectedStartTime,
                        "end_time": selectedEndTime,
                      }
                    ];
                  }
                });

                titleController.clear();
                descpController.clear();
                Navigator.pop(context);
                return;
              }
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Learner Scheduling', style: TextStyle(
          color: Colors.white, // Set app bar text color to white
        ),
      ),
      backgroundColor: Colors.purple,

    ),
      drawer: Drawer(
        child: ListView(
          children: [
            FeatureDrawerButton(icon: Icons.school, text: 'Learning', onTap: () {
              Navigator.of(context).pushNamed('/student_learning_selection');
            },),
            FeatureDrawerButton(icon: Icons.book, text: 'Booking', onTap: () {
              Navigator.of(context).pushNamed('/instructor_view');

            },),
            FeatureDrawerButton(icon: Icons.schedule, text: 'Scheduling', onTap: () {
              Navigator.of(context).pushNamed('/learner_scheduling');
            },),
            FeatureDrawerButton(icon: Icons.track_changes, text: 'Tracking', onTap: () {
              Navigator.of(context).pushNamed('/learner_tracking');
            },),
            FeatureDrawerButton(icon: Icons.live_help, text: 'Assistance Service', onTap: () {
              Navigator.of(context).pushNamed('/assistance_service_student');
            },),
            FeatureDrawerButton(icon: Icons.info, text: 'About Us', onTap: () {
              Navigator.of(context).pushNamed('/about_us');
            },),
            FeatureDrawerButton(icon: Icons.logout, text: 'Logout', onTap: () {
              Navigator.of(context).pushNamed('/student_login');
            },),
          ],
        ),
      ),

      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.now().subtract(const Duration(days: 365)),
            lastDay: DateTime.now().add(const Duration(days: 365)),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDate, selectedDay)) {
                setState(() {
                  _selectedDate = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDate, day);
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },
            eventLoader: _listOfDayEvents,
          ),
          ..._listOfDayEvents(_selectedDate!).map(
                (myEvents) => ListTile(
              leading: const Icon(
                Icons.done,
                color: Colors.purple,
              ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                    'Event Title: ${myEvents['eventTitle']} - ${DateFormat('HH:mm').format(myEvents['start_time'])} to ${DateFormat('HH:mm').format(myEvents['end_time'])}'),
              ),
              subtitle: Text('Description: ${myEvents['eventDescp']}'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEventDialog(),
        label: const Text(
          'Add Event',
          style: TextStyle(
            color: Colors.white, // Set the text color to white
          ),
        ),
        backgroundColor: Colors.purple, // Set the background color for the FloatingActionButton
      ),
    );
  }
}
