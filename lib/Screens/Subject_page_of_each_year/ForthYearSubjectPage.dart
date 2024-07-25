import 'package:flutter/material.dart';
import 'package:personal_chat/Screens/SubjectDetailPage.dart';

class ForthYearSubjectPage extends StatefulWidget {
  final String folderName;

  const ForthYearSubjectPage({Key? key, required this.folderName}) : super(key: key);

  @override
  _ForthYearSubjectPageState createState() => _ForthYearSubjectPageState();
}

class _ForthYearSubjectPageState extends State<ForthYearSubjectPage> {
  List<String> _subjects = [
    'ADVANCED DATABASE SYSTEMS',
    'COMPUTER NETWORKS',
    'DIGITAL SIGNAL PROCESSING',
    'MACHINE LEARNING',
    // Add more subjects as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.folderName),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: GridView.builder(
            shrinkWrap: true, // Added to make GridView scrollable inside SingleChildScrollView
            physics: NeverScrollableScrollPhysics(), // Added to make GridView scrollable inside SingleChildScrollView
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 0.9,
            ),
            itemCount: _subjects.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Handle subject selection
                  String selectedSubject = _subjects[index];
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SubjectDetailsPage(subjectName: selectedSubject, folderName: 'FOURTH YEAR')),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(selectedSubject),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.folder, size: 40.0),
                        SizedBox(height: 10.0),
                        Text(
                          _subjects[index],
                          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
