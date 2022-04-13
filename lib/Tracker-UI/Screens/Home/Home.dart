import 'package:flutter/material.dart';

class Homepg extends StatefulWidget {
  @override
  State<Homepg> createState() => _HomepgState();
}

class _HomepgState extends State<Homepg> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TRACKER'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('TRACKER'),
      ),
    );
  }
}
