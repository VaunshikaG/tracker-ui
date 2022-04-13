import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/StudentModel.dart';
import '../theme.dart';
import 'Dialog.dart';
import 'Home.dart';

final String app_url = "http://10.0.0.12:8080/";

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  StudentModel student;
  final formKeys = GlobalKey<FormState>();

  Future<StudentModel> registerStudent(String firstName, String lastName, BuildContext buildContext) async {
    Uri url =   Uri.parse(app_url + 'addstudent');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String> {
        "firstName": firstName,
        "lastName": lastName,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 400) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (dialogContext) {
            return MyAlertDialog(
              // title: 'Backend Response',
              content: response.body,
            );
          });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Home()));
          },
        ),
        backgroundColor: CustomTheme.Blue1,
        centerTitle: true,
        title: Text(
          'Student Registration',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Form(
          key: formKeys,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  validator: (String text) {
                    if (text.isEmpty || text.length >= 15) {
                      return "Please enter your name";
                    }
                  },
                  controller: fNameController,
                  keyboardType: TextInputType.name,
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
                    labelText: 'First Name',
                    labelStyle: TextStyle(
                      color: CustomTheme.Blue1,
                    ),
                    errorStyle: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: TextFormField(
                  validator: (String text) {
                    if (text.isEmpty || text.length >= 15) {
                      return "Please enter your name";
                    }
                  },
                  controller: lNameController,
                  keyboardType: TextInputType.name,
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
                    labelText: 'Last Name',
                    labelStyle: TextStyle(
                      color: CustomTheme.Blue1,
                    ),
                    errorStyle: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 40,
                width: 130,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: CustomTheme.Blue1,
                    // side: BorderSide(color: Colors.black),
                  ),
                  onPressed: () async {
                    if (formKeys.currentState.validate()) {
                      formKeys.currentState.save();
                      String firstName = fNameController.text;
                      String lastName = lNameController.text;
                      StudentModel newstudent =
                      await registerStudent(firstName, lastName, context);
                      fNameController.text = '';
                      lNameController.text = '';
                      setState(() {
                        student = newstudent;
                      });
                    }
                  },
                  child: Text(
                    'Submit',
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
    );
  }
}

