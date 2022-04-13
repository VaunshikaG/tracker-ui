import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:tracker_ui/Student/theme.dart';
import 'Screens/Home.dart';

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
        navigateRoute: Home(),
        backgroundColor: CustomTheme.Blue3,
        duration: 3000,
        text: "STUDENT\nMANAGEMENT",
        textType: TextType.TyperAnimatedText,
        textStyle: TextStyle(
            fontSize: 30.0,
            color: CustomTheme.Blue1,
            fontWeight: FontWeight.bold
        ),
        // backgroundColor: MyTheme.Coral2,
      ),
    );
  }
}

