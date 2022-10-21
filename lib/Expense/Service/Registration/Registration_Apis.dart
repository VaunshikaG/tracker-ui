import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_session/flutter_session.dart';

import '../../Common/Constants.dart';
import '../../Common/Prefs.dart';
import '../../Models/Register/LoginPodo.dart';
import '../../Models/Register/RegisterPodo.dart';

class APIService {

  //  register
  Future<RegisterPodo> register(String email,
      String password) async {
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

      if (response.statusCode == 200 || response.statusCode == 400) {
        final res = RegisterPodo.fromJson(jsonDecode(response.body));
        print(res.data.email);
        return RegisterPodo.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 207) {
        return RegisterPodo.fromJson(jsonDecode(response.body));
      }
      else {
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
  Future<LoginPodo> login(String email,
      String password) async {
    final prefs = await SharedPreferences.getInstance();
    Uri url = Uri.parse(URL.login_url);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Credentials": 'true',
          'Access-Control-Allow-Headers': 'Access-Control-Allow-Origin, Accept',
          'Access-Control-Expose-Headers': 'Authorization, authenticated',
          'Access-Control-Allow-Methods': 'POST,OPTIONS',
        },
        body: jsonEncode(<String, String>{
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 400) {
        final res = LoginPodo.fromJson(jsonDecode(response.body));

        prefs.setString(CONST.userId, res.data.userId);
        print('user_id : ${res.data.userId}');

        prefs.setString(CONST.token, res.data.token);
        print('token : ${res.data.token}');

        return LoginPodo.fromJson(jsonDecode(response.body));
      }
      else {
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
}
