import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:tracker_ui/BLoC/Login_BloC.dart';
import 'package:tracker_ui/BLoC/Signup_BloC.dart';
import 'package:tracker_ui/Screens/Registration/Login.dart';
import 'package:tracker_ui/Common/theme.dart';

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'New Demo',
        theme: ThemeData(fontFamily: 'Nunito'),
        home: SplashScreenView(
          navigateRoute: Loginpg(),
          backgroundColor: Colors.white,
          duration: 3000,
          // imageSize: 100,
          // imageSrc: "Splash.gif",
          text: "NEW\nMANAGEMENT",
          textType: TextType.TyperAnimatedText,
          textStyle: TextStyle(
              fontSize: 30.0,
              color: CustomTheme.Coral1,
              fontWeight: FontWeight.bold,
          ),
          // backgroundColor: CustomTheme.Coral2,
        ),
      ),
    );
  }
}

