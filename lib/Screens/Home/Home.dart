import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tracker_ui/Common/theme.dart';

class Homepg extends StatefulWidget {
  @override
  State<Homepg> createState() => _HomepgState();
}

class _HomepgState extends State<Homepg> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomTheme.Grey2,
          title: Text(
            'NEW',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 200),
          child: const Text(
            'Log out',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          /*MaterialButton(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
          elevation: 5,
          onPressed: () {
            Navigator.popAndPushNamed(context, '/login');
            ApiService.removeToken();
          },
          child: const Text(
            'Log out',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),*/
        ),
      ),
      onWillPop: () => SystemNavigator.pop(),
    );
  }
}
