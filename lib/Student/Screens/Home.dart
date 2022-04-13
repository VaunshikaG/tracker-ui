import 'package:flutter/material.dart';
import '../theme.dart';
import 'Details.dart';
import 'Register.dart';
import 'Update.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: CustomTheme.Blue1,
        centerTitle: true,
        title: const Text(
          'Student Management',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const Center(
        child: const Text(
          'Welcome\nto\nStudent Management',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: CustomTheme.Blue1,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      drawer: Drawer(
        backgroundColor: CustomTheme.Blue4,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          children: <Widget>[
            const DrawerHeader(
              duration: Duration(seconds: 3),
              child: Text(
                'Student Management',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              decoration: BoxDecoration(
                color: CustomTheme.Blue1,
              ),
            ),
            ListTile(
              title: const Text(
                'Register Student',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: CustomTheme.Blue1,
                ),
              ),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Register())),
              // visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            ),
            ListTile(
              title: const Text(
                'Student Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: CustomTheme.Blue1,
                ),
              ),
              onTap: () =>
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Details())),
              // visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            ),
          ],
        ),
      ),
    );
  }
}
