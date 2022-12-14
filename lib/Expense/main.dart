import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker_ui/Expense/BLoC/Category/Category_BloC.dart';
import 'package:tracker_ui/Expense/BLoC/Registration/Login_BloC.dart';
import 'package:tracker_ui/Expense/BLoC/Registration/Signup_BloC.dart';
import 'package:tracker_ui/Expense/Common/theme.dart';
import 'package:tracker_ui/Expense/Screens/Category/Category.dart';
import 'package:tracker_ui/Expense/Screens/Registration/Login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoginBLoC>(
          create: (context) => LoginBLoC(),
        ),
        Provider<SignupBLoC>(
          create: (context) => SignupBLoC(),
        ),
        Provider<CategoryBloC>(
          create: (context) => CategoryBloC(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expense Tracker',
        theme: ThemeData(
          fontFamily: 'Nunito',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Splash(),
        // home: Category(),
      ),
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

  bool _isLoggedIn = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () => _checkUserIsLogged());
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
                color: CustomTheme.Grey2,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _checkUserIsLogged() {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // _isLoggedIn = Prefs.instance.getBooleanValue(CONST.LoggedIn) as bool;

    if (_isLoggedIn) {
      print('home');
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Category()));
    } else if (!_isLoggedIn) {
      print('login');
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Loginpg()));
    }
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
