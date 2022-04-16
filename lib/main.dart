import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:tracker_ui/BLoC/Login_BloC.dart';
import 'package:tracker_ui/BLoC/Signup_BloC.dart';
import 'package:tracker_ui/Common/theme.dart';
import 'package:tracker_ui/Screens/Registration/Login.dart';
import 'package:tracker_ui/Screens/Registration/Signup.dart';

import 'Common/Constants.dart';
import 'Common/Prefs.dart';
import 'Screens/Home/Home.dart';
import 'api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin{

  bool isLoggedIn, isExit = false;

  @override
  void initState() {
    Prefs.instance.getBooleanValue(CONST.status).then((value) =>
        setState(() {isLoggedIn = value;}));

    super.initState();
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
        home: SplashScreenView(
          navigateRoute: FutureBuilder(
            future: ApiService.getToken(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasData) {
                return Homepg();
              } else {
                return Loginpg();
              }
            },
          ),
          backgroundColor: Colors.white,
          duration: 3000,
          text: "TRACKER",
          textType: TextType.TyperAnimatedText,
          textStyle: TextStyle(
            fontSize: 35.0,
            color: CustomTheme.Coral1,
            fontWeight: FontWeight.bold,
          ),
          // backgroundColor: CustomTheme.Coral2,
        ),
        routes: {
          '/home': (_) => Homepg(),
          '/login': (_) => new Loginpg(),
          '/signup': (_) => new Signuppg(),
        },
      ),
    );
  }
}


//  splashscreen

/*SplashScreenView(
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
        ),*/
