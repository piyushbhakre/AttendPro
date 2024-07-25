import 'package:flutter/material.dart';


class SecondYearSubjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello, World!'),
        ),
        body: Center(
          child: Text(
            'SecondYearSubjectPage',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
