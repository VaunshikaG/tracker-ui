import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/StudentModel.dart';
import '../theme.dart';
import 'Details.dart';

final String app_url = "http://10.0.0.12:8080/";

class Delete extends StatefulWidget {
  @override
  State<Delete> createState() => _DeleteState();
}


Future<StudentModel> deleteStudent(String firstName, String lastName) async {
  var response = await http.delete(
    Uri.parse(app_url + 'deletestudent'),
    headers: <String, String>{
      "Content-Type": "application/json;charset=UTF-8,"
    },
  );
  return StudentModel.fromJson(jsonDecode(response.body));
}


class _DeleteState extends State<Delete> {
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      child: Details(),
      onWillPop: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => Details())),
    );
    // return Details();
  }
}

