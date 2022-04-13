import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../Models/StudentModel.dart';
import '../theme.dart';
import 'Details.dart';
import 'Dialog.dart';

final String app_url = "http://10.0.0.12:8080/";

class Update extends StatefulWidget {
  StudentModel student;

  Update(this.student);

  @override
  State<Update> createState() => _UpdateState(student);
}

class _UpdateState extends State<Update> {
  StudentModel student;
  TextEditingController idController, firstController, lastController;
  Future<List<StudentModel>> students;
  final formKeys = GlobalKey<FormState>();

  //  constructor
  _UpdateState(this.student) {
    idController = TextEditingController(text: this.student.id.toString());
    firstController = TextEditingController(text: this.student.firstName);
    lastController = TextEditingController(text: this.student.lastName);
  }

  Future<StudentModel> updateStudent(
      StudentModel student, BuildContext context) async {
    try {
      var response = await http.put(Uri.parse(app_url + 'updatestudent'),
          headers: <String, String>{
            "Content-Type": "application/json",
          },
          body: jsonEncode(student));
      if (response.statusCode == 200) {
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext dialogContext) {
              return MyAlertDialog(
                // title: 'Backend Response',
                content: response.body,
              );
            });
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Editpg(student)));
            },
          ),
          backgroundColor: CustomTheme.Blue1,
          centerTitle: true,
          title: Text(
            'Update Student Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: formKeys,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: idController,
                    enabled: false,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter your ID';
                      }
                    },
                    keyboardType: TextInputType.number,
                    cursorColor: CustomTheme.Blue1,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: CustomTheme.Blue1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: CustomTheme.Blue1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: CustomTheme.Blue1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      labelText: 'Student ID',
                      hintText: 'Enter Student ID',
                      labelStyle: TextStyle(
                        color: CustomTheme.Blue1,
                      ),
                      errorStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    controller: firstController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter your name';
                      }
                    },
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      hintText: 'Enter Your First Name',
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: CustomTheme.Blue1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: CustomTheme.Blue1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: CustomTheme.Blue1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      labelStyle: TextStyle(
                        color: CustomTheme.Blue1,
                      ),
                      errorStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: lastController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter your name';
                      }
                    },
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      hintText: 'Enter Your First Name',
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: CustomTheme.Blue1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: CustomTheme.Blue1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: CustomTheme.Blue1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      labelStyle: TextStyle(
                        color: CustomTheme.Blue1,
                      ),
                      errorStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 160,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: CustomTheme.Blue1,
                      // side: BorderSide(color: Colors.black),
                    ),
                    onPressed: () async {
                      if (formKeys.currentState.validate()) {
                        formKeys.currentState.save();
                        print(student.id);
                        StudentModel studentModel = new StudentModel();
                        // idController.text = student.id.toString();
                        studentModel.id = student.id;
                        studentModel.firstName = firstController.text;
                        studentModel.lastName = lastController.text;
                        StudentModel newstud =
                        await updateStudent(studentModel, context);
                        setState(() {
                          student = newstud;
                        });
                      }
                    },
                    child: Text(
                      'Update Details',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => Editpg(student))),
    );
  }
}
