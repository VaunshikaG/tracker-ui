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
        title: Text('SPORTS'),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
