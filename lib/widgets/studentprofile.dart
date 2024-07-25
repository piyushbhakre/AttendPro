import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pie_chart/pie_chart.dart';

class StudentProfilePage extends StatelessWidget {
  final String documentId;
  final String subjectName;
  final String folderName;

  const StudentProfilePage({
    Key? key,
    required this.subjectName,
    required this.folderName,
    required this.documentId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Profile'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('Section C')
            .doc(folderName)
            .collection(subjectName)
            .doc(documentId)
            .get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            if (snapshot.hasData && snapshot.data!.exists) {
              Map<String, dynamic>? data =
              snapshot.data!.data() as Map<String, dynamic>?;

              if (data != null) {
                int totalDays = data.length;
                int presentDays = data.values.where((status) => status == 'Present').length;
                int absentDays = totalDays - presentDays;
                int fine = absentDays * 20;

                Map<String, double> dataMap = {
                  'Present': (presentDays / totalDays * 100),
                  'Absent': (absentDays / totalDays * 100),
                };

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        documentId, // Change this to the actual document name
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      _buildAttendancePieChart(context, dataMap),
                      SizedBox(height: 20),
                      _buildAttendanceSummary(totalDays, presentDays, absentDays, fine),
                      Divider(),
                      ...data.entries.map((entry) {
                        return _buildDailyAttendanceWidget(date: entry.key, status: entry.value);
                      }).toList(),
                    ],
                  ),
                );
              } else {
                return Center(child: Text('Document data is null'));
              }
            } else {
              return Center(child: Text('Document not found'));
            }
          }
        },
      ),
    );
  }

  Widget _buildDailyAttendanceWidget({
    required String date,
    required String status,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            status,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendancePieChart(BuildContext context, Map<String, double> dataMap) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: PieChart(
        dataMap: dataMap,
        chartRadius: MediaQuery.of(context).size.width / 2,
        chartType: ChartType.disc,
        animationDuration: Duration(milliseconds: 800),
      ),
    );
  }

  Widget _buildAttendanceSummary(int totalDays, int presentDays, int absentDays, int fine) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Attendance Summary',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Total Days: $totalDays'),
          Text('Present Days: $presentDays'),
          Text('Absent Days: $absentDays'),
          Text('Penalty: $fine Rs.'),
          Text('Attendance Percentage: ${(presentDays / totalDays * 100).toStringAsFixed(2)}%'),
        ],
      ),
    );
  }
}
