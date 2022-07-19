import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tracker_ui/Expense/Common/theme.dart';
import 'package:tracker_ui/Expense/Screens/Category/Category.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        fontFamily: 'Nunito',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash(),
    );
  }
}


class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () => Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Category())));
    // Future.delayed(const Duration(seconds: 1), () => _checkUserIsLogged());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            WavyAnimatedText(
              'EXPENSE TRACKER',
              textStyle: const TextStyle(
                fontSize: 36.0,
                color: CustomTheme.Coral1,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

}

Widget text() {
  AnimatedTextKit(
    animatedTexts: [
      TypewriterAnimatedText(
        'TRACKER',
        textStyle: TextStyle(
          fontSize: 35.0,
          color: CustomTheme.Coral1,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
        speed: const Duration(milliseconds: 2000),
      ),
      WavyAnimatedText(
        'TRACKER',
        textStyle: TextStyle(
          fontSize: 40.0,
          color: CustomTheme.Coral1,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}