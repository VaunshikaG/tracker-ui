import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tracker_ui/Common/Constants.dart';
import 'Common/Dialog.dart';
import 'Models/SignupModel.dart';

class ApiService {

  //  register
  Future<SignupModel> Register(String firstName, String lastName, String email,
      String password, BuildContext buildContext) async {
    Uri url = Uri.parse(URL.app_url + URL.register_url);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 400) {
      showDialog(
          barrierDismissible: true,
          builder: (dialogContext) {
            return MyAlertDialog(
              // title: 'Backend Response',
              content: response.body,
            );
          });
    }
  }
}
