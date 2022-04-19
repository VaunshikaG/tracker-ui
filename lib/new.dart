/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        title: 'Tracker',
        theme: ThemeData(
          fontFamily: 'Nunito',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        */
/*home: SplashScreenView(
          navigateRoute: Loginpg(),
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
        ),*//*

      ),
    );
  }
}

*/
/*{
try {
if(snapshot.error) {
CustomSnackBar(context, Text
(snapshot.error));
} else {
return bloc.register(context);
}
} catch (e) {
showDialog(
context: context,
barrierDismissible: true,
builder: (dialogContext) {
return MyAlertDialog(
content: e,
);
});
print(e);
}
},*/
