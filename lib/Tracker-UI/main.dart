import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:tracker_ui/Sports/Screens/Registration/Login.dart';
import 'package:tracker_ui/Student/theme.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: 'Nunito'),
      home: SplashScreenView(
        navigateRoute: Loginpg(),
        backgroundColor: CustomTheme.Blue3,
        duration: 3000,
        // imageSize: 100,
        // imageSrc: "Splash.gif",
        text: "TRACKER",
        textType: TextType.TyperAnimatedText,
        textStyle: TextStyle(
            fontSize: 40.0,
            color: CustomTheme.Blue1,
            fontWeight: FontWeight.bold
        ),
        // backgroundColor: MyTheme.Coral2,
      ),
    );
  }
}
