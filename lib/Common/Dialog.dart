import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  // final String title;
  final String content;
  final List<Widget> actions;

  MyAlertDialog({
    // this.title,
    this.content,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // title: Text(
      //   this.title,
      //   style: TextStyle(
      //     fontSize: 18,
      //     fontWeight: FontWeight.bold,
      //   ),
      // ),
      actions: [
        TextButton(
          onPressed: () {
            // Navigator.push(context,MaterialPageRoute(builder: (context) => Details()));
          },
          child: Text(
            'OK',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
      content: Text(
        this.content,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}