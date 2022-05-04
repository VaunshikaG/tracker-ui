import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracker_ui/Common/Constants.dart';
import 'package:tracker_ui/Common/snackbar.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:tracker_ui/Models/Registration/LoginModel.dart';

import '../../Common/Prefs.dart';
import '../../Models/Registration/SignupModel.dart';

class _AuthData {
  String token, refreshToken, clientId;
  _AuthData(this.token, this.refreshToken, {this.clientId});

  // toJson
  // required by Session lib
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['token'] = token;
    data['refreshToken'] = refreshToken;
    data['clientId'] = clientId;
    return data;
  }
}

class ApiService {

  static final SESSION = FlutterSession();
  static setToken(String token, String refreshToken) async {
    _AuthData data = _AuthData(token, refreshToken);
    await SESSION.set('tokens', data);
  }

  static Future<Map<String, dynamic>> getToken() async {
    return await SESSION.get('tokens');
  }

  static removeToken()async {
    await SESSION.prefs.clear();
  }


  //  register
  Future<dynamic> register(String firstName, String lastName, String email,
      String password, BuildContext buildContext) async {
    final prefs = await SharedPreferences.getInstance();
    Uri url = Uri.parse(URL.app_url + URL.register_url);


    try {
      final response = await http.post(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "password": password,
          // "token": token,
        }),
      );

      print(jsonEncode(email).toString());
      print(response.body.toString());

      if (response.statusCode == 200 || response.statusCode == 400) {
        final res = SignupModel.fromJson(jsonDecode(response.body));
        prefs.setString(CONST.token, res.token);
        print(res.token);
        return SignupModel.fromJson(jsonDecode(response.body));
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
  Future<dynamic> login(String email,
      String password, BuildContext buildContext) async {
    final prefs = await SharedPreferences.getInstance();
    Uri url = Uri.parse(URL.app_url + URL.login_url);

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
          // "token": 'SdxIpaQp!81XS#QP5%w^cTCIV*DYr',
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 400) {
        final res = LoginModel.fromJson(jsonDecode(response.body));
        prefs.setString(CONST.userId, res.userId);
        print('user_id : ${res.userId}');
        prefs.setString(CONST.token, res.token);
        print('token : ${res.token}');
        return LoginModel.fromJson(jsonDecode(response.body));
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
