import 'dart:developer';

import 'package:personal_chat/Screens/auth/loginscreen.dart' as Auth;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_chat/Screens/auth/loginscreen.dart';
import 'package:personal_chat/Screens/home_page.dart';
import 'package:personal_chat/api/apis.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isAnimate = false; // Declare _isAnimate variable

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

      if (Apis.auth.currentUser != null) {
        log('\nUser: ${Apis.auth.currentUser}');
        //navigate to home screen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) =>  HomePage()));
      } else {
        //navigate to login screen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: mq.height * .15 , // Animate based on _isAnimate
            right: mq.width * .25 ,
            width: mq.width * .5,
            child: Image.asset('assets/logo/Logo.png'),
          ),
          Positioned(
            bottom: mq.height * .15,
            width: mq.width * .9,
             child: const Text('      TRIROOP EDUCATION PRIVATE liMITED' ,
               textAlign: TextAlign.center,
               style: TextStyle(
                 fontSize: 16,
               color: Colors.black87,
               fontWeight: FontWeight.w500,
               fontStyle: FontStyle.italic,
               letterSpacing: .5),)

          ),
        ],
      ),
    );
  }
}
