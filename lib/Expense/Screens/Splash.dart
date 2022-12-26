import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tracker_ui/Expense/Common/theme.dart';
import 'package:tracker_ui/Expense/Screens/Category/Category.dart';
import 'package:tracker_ui/Expense/Screens/Registration/Login.dart';

import '../Common/Constants.dart';
import '../Common/Prefs.dart';
import '../Widgets/CustomScreenRoute.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  bool _isLoggedIn = false;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 3500));
    animation = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);
    animation.addListener(() => this.setState(() {}));
    _controller.forward();

    Timer(const Duration(milliseconds: 3500), () {
      _checkUserIsLogged();
    });

    Prefs.instance
        .getBooleanValue(CONST.LoggedIn)
        .then((value) => setState(() {
      _isLoggedIn = value;
    }));

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.alphaBlend(const Color(0xAAFFFFFF), CustomTheme.coral2),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Align(
            alignment: Alignment(-0.8, 0.06),
            child: Container(
              child: Image.asset(
                "assets/img/blank_logo_transparent.png",
                color: Colors.black,
              ),
            ),
          ),
          Align(
            alignment: Alignment(-0.229, 0.11),
            child: Container(
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  WavyAnimatedText(
                    'Expensify',
                    textStyle: TextStyle(
                      fontSize: 55,
                      color: Colors.black,
                      // color: CustomTheme.grey,
                      // fontWeight: FontWeight.bold,
                      fontFamily: 'Sacramento',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _checkUserIsLogged() {
    if (_isLoggedIn) {
      print('home');
      Navigator.of(context)
          .pushReplacement(new CustomScreenRoute(child: new Category(),
          direction: AxisDirection.left));
    } else if (!_isLoggedIn) {
      print('login');
      Navigator.of(context)
          .pushReplacement(new CustomScreenRoute(child: new Loginpg(),
          direction: AxisDirection.right));
    }
  }
}

Widget text() {
  AnimatedTextKit(
    animatedTexts: [
      TypewriterAnimatedText(
        'Expensify',
        textStyle: TextStyle(
          fontSize: 35,
          color: CustomTheme.coral2,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
        speed: const Duration(milliseconds: 2000),
      ),
      WavyAnimatedText(
        'Expensify',
        textStyle: TextStyle(
          fontSize: 40,
          color: CustomTheme.coral2,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}
