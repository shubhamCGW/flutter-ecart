import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dashboard/home_screen.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      checkingTheSavedData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            // logo here
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                height: 80,
              ),
            ),
            SizedBox(
              height: 200,
            ),
            Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            // SizedBox(
            //   height: 200,
            // ),
            Center(
              child: Text(
                "From",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text("Shubham",
                  style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }

  checkingTheSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userProflie = prefs.getString('userProfile');
    if (userProflie == null) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => WelcomeScreen()));
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
    }
  }
}
