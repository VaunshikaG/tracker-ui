import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Common/Constants.dart';
import '../../Models/Registration/LoginPodo.dart';
import '../../Models/Registration/RegisterPodo.dart';

class APIService {
  //  register
  Future<RegisterPodo> register(
      String email, String password, BuildContext buildContext) async {
    final prefs = await SharedPreferences.getInstance();
    Uri url = Uri.parse(URL.register_url);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{
          "email": email,
          "password": password,
          // "token": token,
        }),
      );

      print(response.body.toString());

      if (response.statusCode == 201 || response.statusCode == 400) {
        final res = RegisterPodo.fromJson(jsonDecode(response.body));
        print(res.data.email);
        print('user_id : ${res.data.uid}');
        return RegisterPodo.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 207) {
        return RegisterPodo.fromJson(jsonDecode(response.body));
      } else {
        print(response.body);
        throw Exception('Failed to load album');
      }
    } on SocketException {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontSize: 16.0,
        backgroundColor: Colors.black,
      );
    }
  }

  //  email verification
  Future<RegisterPodo> verify_email(
      String email, BuildContext buildContext) async {
    final prefs = await SharedPreferences.getInstance();
    Uri url = Uri.parse(URL.otp_url);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{"email": email}),
      );

      print(response.body.toString());

      if (response.statusCode == 200 || response.statusCode == 400) {
        final res = RegisterPodo.fromJson(jsonDecode(response.body));
        print(res.data.email);
        return RegisterPodo.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 207) {
        return RegisterPodo.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load album');
      }
    } on SocketException {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontSize: 16.0,
        backgroundColor: Colors.black,
      );
    }
  }

  //  login
  Future<LoginPodo> login(
      String email, String password, BuildContext buildContext) async {
    final prefs = await SharedPreferences.getInstance();
    Uri url = Uri.parse(URL.login_url);

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 400) {
        print(response.body);
        final res = LoginPodo.fromJson(jsonDecode(response.body));

        prefs.setString(CONST.userId, res.data.userId);
        print('user_id : ${res.data.userId}');

        prefs.setString(CONST.token, res.data.token);
        print('token : ${res.data.token}');

        return LoginPodo.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        // print(response.body);
      } else {
        print(response.body);
        throw Exception('Failed to load album');
      }
    } catch (e) {
      if (e is SocketException) {
        Fluttertoast.showToast(
            msg: "Please check your internet connection",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey[200],
            textColor: Colors.red,
            fontSize: 16.0);
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        print("Timeout exception: ${e.toString()}");
      } else {
        print("Unhandled exception: ${e.toString()}");
      }
    }
  }
}
