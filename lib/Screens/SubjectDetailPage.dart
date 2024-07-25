import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_chat/widgets/studentprofile.dart';

class SubjectDetailsPage extends StatefulWidget {
  final String subjectName;
  final String folderName;

  const SubjectDetailsPage({Key? key, required this.subjectName, required this.folderName}) : super(key: key);

  @override
  _SubjectDetailsPageState createState() => _SubjectDetailsPageState();
}

class _SubjectDetailsPageState extends State<SubjectDetailsPage> {
  late Map<String, String> attendanceStatus; // Map to track the attendance status of each student

  @override
  void initState() {
    super.initState();
    attendanceStatus = {}; // Initialize the attendance status map
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subjectName),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Section C')
            .doc(widget.folderName)
            .collection(widget.subjectName)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10), // Add SizedBox between the 1st name
                  ...snapshot.data!.docs.map((documentSnapshot) {
                    var documentId = documentSnapshot.id;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(90.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(1),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          title: InkWell(
                            onTap: () {
                              // Handle Document click - Navigate to Student Profile Page
                              navigateToStudentProfilePage(
                                  context, widget.folderName, widget.subjectName,
                                  documentId);
                            },
                            child: Text(
                              documentId,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Handle Present button click
                                  markAttendance(documentId, 'Present');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: attendanceStatus[documentId] == 'Present'
                                      ? Colors.green
                                      : null, // Change color to green if present, null otherwise
                                ),
                                child: Text('P'),
                              ),

                              SizedBox(width: 8), // Add spacing between buttons
                              ElevatedButton(
                                onPressed: () {
                                  // Handle Absent button click
                                  markAttendance(documentId, 'Absent');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: attendanceStatus[documentId] == 'Absent'
                                      ? Colors.red
                                      : null, // Change color to red if absent, null otherwise
                                ),
                                child: Text('A'),
                              ),

                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void navigateToStudentProfilePage(BuildContext context, String folderName,
      String subjectName, String documentId) {
    // Navigate to Student Profile Page and pass folder name, subject name, and document ID
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            StudentProfilePage(folderName: folderName,
                subjectName: subjectName,
                documentId: documentId),
      ),
    );
  }

  void markAttendance(String documentId, String status) {
    // Get today's date in the format 'MM-DD-YYYY'
    DateTime now = DateTime.now();
    String month = now.month.toString().padLeft(2, '0');
    String day = now.day.toString().padLeft(2, '0');
    String year = now.year.toString();
    String currentDate = '$month-$day-$year';

    // Update the attendance status with the current date as the field name
    setState(() {
      attendanceStatus[documentId] = status; // Update attendance status
    });

    // Reference the Firestore document and update the field with today's date
    FirebaseFirestore.instance
        .collection('Section C')
        .doc(widget.folderName)
        .collection(widget.subjectName)
        .doc(documentId)
        .update({currentDate: status})
        .then((value) => print('Attendance updated successfully'))
        .catchError((error) => print('Failed to update attendance: $error'));
  }
}
