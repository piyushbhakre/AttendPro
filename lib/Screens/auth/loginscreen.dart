import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_chat/Screens/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Check if the user is already logged in
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      // Navigate to Home Page if the user is already logged in
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          // Disable back button functionality
          return false;
        },
        child: Container(
          color: Colors.blue.shade100,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              CircleAvatar(
                maxRadius: 50,
                backgroundColor: Colors.transparent,
                child: Icon(Icons.person),
              ),
              SizedBox(
                height: 20.0,
              ),
              _buildLoginForm(),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLoginButtonClick() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      // Show progress indicator while processing login
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        // If login is successful, navigate to home page
        if (userCredential != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomePage()),
          );
        }
      } catch (e) {
        // Handle login errors
        log(e.toString());

        // Hide progress indicator
        Navigator.pop(context);

        // Show snackbar with error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed. Please try again.'),
          ),
        );
      }
    } else {
      // Show snackbar with error message if email or password is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter email and password.'),
        ),
      );
    }
  }

  Container _buildLoginForm() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Stack(
        children: <Widget>[
          ClipPath(
            child: Container(
              height: 400,
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 90.0,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      controller: _emailController,
                      style: TextStyle(color: Colors.blue),
                      decoration: InputDecoration(
                        hintText: "Email address",
                        hintStyle: TextStyle(color: Colors.blue.shade200),
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.email,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                    child: Divider(
                      color: Colors.blue.shade400,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      controller: _passwordController,
                      style: TextStyle(color: Colors.blue),
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.blue.shade200),
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.lock,
                          color: Colors.blue,
                        ),
                      ),
                      obscureText: true,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                    child: Divider(
                      color: Colors.blue.shade400,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 420,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                  backgroundColor: Colors.blue,
                ),
                onPressed: _handleLoginButtonClick,
                child: Text("Login", style: TextStyle(color: Colors.white70)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
