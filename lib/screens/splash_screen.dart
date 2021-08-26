import 'dart:async';
import 'package:flutter/material.dart';
import 'package:resto_apps/screens/home_screen.dart';
import 'package:resto_apps/common/styles.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splashscreen';

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() {
    var duration = const Duration(seconds: 2);
    print(duration);
    return Timer(duration, () {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Restaurant Ku",
              style: TextStyle(
                color: secondaryColor,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
