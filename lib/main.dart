import 'package:flutter/material.dart';
import 'package:personal_chat/Screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:personal_chat/firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) {
    _initializeFirebaseApp();
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attandance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.black87),
          titleTextStyle: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
            fontSize: 20,
          ),
          backgroundColor: Colors.blue,
        ),
      ),
      home: SplashScreen(),
    );
  }
}


void _initializeFirebaseApp() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}
