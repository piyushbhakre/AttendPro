import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:personal_chat/Screens/Subject_page_of_each_year/ForthYearSubjectPage.dart';
import 'package:personal_chat/Screens/Subject_page_of_each_year/SecondYearSubjectPage.dart';
import 'package:personal_chat/Screens/Subject_page_of_each_year/ThirdYearSubjectPage().dart';
import 'package:personal_chat/Screens/auth/loginscreen.dart';
import 'package:personal_chat/api/apis.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    // Initialize the stream subscription in initState
    _subscription = Apis.firestore.collection('Section C').snapshots().listen((snapshot) {
      // Handle stream data here
    }, onError: (error) {
      // Handle errors here
      print('Error: $error');
    });
  }

  @override
  void dispose() {
    // Cancel the stream subscription in dispose
    _subscription.cancel();
    super.dispose();
  }

  Future<void> _logout(BuildContext context) async {
    print('Logging out...');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    print('User logged out');

    // Navigate to the login page and remove all previous routes from the stack
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false,
    );
    print('Navigated to login page');
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        automaticallyImplyLeading: false, // Remove the leading back arrow button
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () {
                          _logout(context);
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: Apis.firestore.collection('Section C').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<String> folderNames = snapshot.data!.docs.map((doc) => doc.id).toList().cast<String>();

            return ListView.builder(
              itemCount: folderNames.length,
              padding: EdgeInsets.only(top: mq.height * .01),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final folderName = folderNames[index];
                return Column(
                  children: [
                    Card(
                      elevation: 2, // Add elevation for a card-like appearance
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // Custom shape
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Adjust margin as needed
                      child: ListTile(
                        onTap: () {
                          // Navigate to different pages based on folder name
                          if (folderName == 'THIRD YEAR') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ThirdYearSubjectPage(folderName: folderName)),
                            );
                          } else if (folderName == 'SECOND YEAR') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SecondYearSubjectPage()),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ForthYearSubjectPage(folderName: folderName)),
                            );
                          }
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // Custom shape
                        leading: Icon(Icons.pending_actions_outlined), // Icon for folder
                        title: Text(
                          folderName,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(Icons.arrow_forward), // Icon for navigating to folder
                      ),
                    ),
                    SizedBox(height: 8), // Add some space between list tiles
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
