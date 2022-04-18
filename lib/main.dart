import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracker_ui/BLoC/Login_BloC.dart';
import 'package:tracker_ui/BLoC/Signup_BloC.dart';
import 'package:tracker_ui/Common/Dialog.dart';
import 'package:tracker_ui/Common/theme.dart';
import 'package:tracker_ui/Screens/Registration/Login.dart';
import 'package:tracker_ui/Screens/Registration/Signup.dart';
import 'Common/Constants.dart';
import 'Common/Prefs.dart';
import 'Screens/Home/Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {

  AnimationController animationController;
  Animation<double> animation;

  bool _isLoggedIn = false;

  @override
  void initState() {

    _isLoggedIn = false;

    Prefs.instance.getBooleanValue(CONST.LoggedIn).then((value) =>
        setState(() {_isLoggedIn = value;}));
    animationController = AnimationController(vsync: this, duration: new Duration(seconds: 2));
    // animation = CurvedAnimation(parent: animationController, curve: Curves.easeInQuint);
    // animation.addListener(() => setState(() {}));
    animationController.forward();


    Timer(const Duration(seconds: 5), () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final bool loggged = prefs.getBool(CONST.LoggedIn);

      if (loggged == false) {
        _isLoggedIn = false;
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => new Loginpg()));
        print('login');
      } else if (loggged == true){
        _isLoggedIn = true;
        Navigator.pushReplacement((context),
            MaterialPageRoute(builder: (context) => new Homepg()));
        print('home');
      } else {
        print('Error');
      }
    });
  }

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tracker',
        theme: ThemeData(
          fontFamily: 'Nunito',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Container(
              // height: animation.value * 300,
              // width: animation.value * 300,
              child: Text(
                "TRACKER",
                style: TextStyle(
                  fontSize: 35.0,
                  color: CustomTheme.Coral1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _checkUserIsLogged() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool loggged = prefs.getBool(CONST.LoggedIn);

    if (loggged == false) {
      _isLoggedIn = false;
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => new Loginpg()));
      print('login');
    } else if (loggged == true){
      _isLoggedIn = true;
      Navigator.pushReplacement((context), MaterialPageRoute(builder: (context) => new Homepg()));
      print('home');
    } else {
      MyAlertDialog(
        actions: [
          TextButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: Text(
              'OK',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        content: 'Cannot open app',
      );
      print('Error');
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
    ],
  );
}



//  splashscreen

/*
Text(
                "TRACKER",
                style: TextStyle(
                  fontSize: 35.0,
                  color: CustomTheme.Coral1,
                  fontWeight: FontWeight.bold,
                ),
              ),
*/

/*
SplashScreen(
          navigateAfterFuture: checkUserIsLogged(),
          backgroundColor: Colors.white,
          seconds: 3,
          title: Text("TRACKER"),
          // title: text(),
          styleTextUnderTheLoader: TextStyle(
            fontSize: 35.0,
            color: CustomTheme.Coral1,
            fontWeight: FontWeight.bold,
            textBaseline: TextBaseline.alphabetic,
          ),
          // textType: TextType.TyperAnimatedText,
        ),
*/



/*
SplashScreenView(
          navigateRoute: FutureBuilder(
            // future: ApiService.getToken(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasData) {
                if (!isLoggedIn) {
                  print('here1');
                  return Loginpg();
                } else if (isLoggedIn) {
                  print('here2');
                  return Homepg();
                }
              } else {
                return Loginpg();
              }
            },
          ),
          backgroundColor: Colors.white,
          duration: 3000,
          // imageSize: 100,
          // imageSrc: "Splash.gif",
          text: "TRACKER",
          textType: TextType.TyperAnimatedText,
          textStyle: TextStyle(
            fontSize: 35.0,
            color: CustomTheme.Coral1,
            fontWeight: FontWeight.bold,
          ),
          // backgroundColor: CustomTheme.Coral2,
        ),
*/
