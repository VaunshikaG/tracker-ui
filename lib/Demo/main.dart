import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker_ui/Demo/BLoC/Category/Category_BloC.dart';
import 'package:tracker_ui/Demo/BLoC/Registration/Login_BloC.dart';
import 'package:tracker_ui/Demo/BLoC/Registration/Signup_BloC.dart';
import 'package:tracker_ui/Demo/Screens/Category/Category.dart';

import 'Screens/Splash.dart';

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
        title: 'Expensify',
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
