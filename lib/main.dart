import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker_ui/BLoC/Registration/Login_BloC.dart';
import 'package:tracker_ui/BLoC/Registration/Signup_BloC.dart';
import 'package:tracker_ui/Common/theme.dart';
import 'package:tracker_ui/Screens/Registration/Login.dart';
import 'package:tracker_ui/Screens/Registration/Signup.dart';
import 'BLoC/Category/Category_BloC.dart';
import 'Common/Constants.dart';
import 'Common/Prefs.dart';
import 'Screens/Category/Category.dart';

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
        title: 'Tracker',
        theme: ThemeData(
          fontFamily: 'Nunito',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Splash(),
        routes: {
          '/myapp': (_) => MyApp(),
          '/home': (_) => Category(),
          '/login': (_) => new Loginpg(),
          '/signup': (_) => new Signuppg(),
        },
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
    _isLoggedIn = false;

    Prefs.instance.getBooleanValue(CONST.LoggedIn).then((value) =>
        setState(() {_isLoggedIn = value;}));

    Timer(const Duration(seconds: 3), () => _checkUserIsLogged());
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
              'TRACKER',
              textStyle: const TextStyle(
                fontSize: 40.0,
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

  void _checkUserIsLogged()  {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // _isLoggedIn = Prefs.instance.getBooleanValue(CONST.LoggedIn) as bool;

    if (_isLoggedIn){
      print('home');
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Category()));
    } else if (!_isLoggedIn) {
      print('login');
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Loginpg()));
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
