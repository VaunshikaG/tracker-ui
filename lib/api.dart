import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:tracker_ui/Common/Constants.dart';
import 'package:tracker_ui/Common/snackbar.dart';
import 'Common/Dialog.dart';
import 'Models/Registration/SignupModel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_session/flutter_session.dart';

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
  Future<dynamic> Register(String firstName, String lastName, String email,
      String password, BuildContext buildContext) async {
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
          // "token": 'SdxIpaQp!81XS#QP5%w^cTCIV*DYr',
        }),
      );

      print(jsonEncode(email).toString());
      print(response.body.toString());

      if (response.statusCode == 200 || response.statusCode == 400) {
        return SignupModel.fromJson(jsonDecode(response.body));
      }
      else if (response.statusCode == 404) {
        // not found
        CustomSnackBar(buildContext, Text(response.body));
      } else if (response.statusCode == 500) {
        // server not responding.
        CustomSnackBar(buildContext, Text(response.body));
      } else {
        CustomSnackBar(buildContext, Text(response.body));
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


  //  register
  Future<dynamic> Login(String email,
      String password, BuildContext buildContext) async {
    Uri url = Uri.parse(URL.app_url + URL.login_url);


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
          // "token": 'SdxIpaQp!81XS#QP5%w^cTCIV*DYr',
        }),
      );

      print(jsonEncode(email).toString());
      print(response.body.toString());

      if (response.statusCode == 200 || response.statusCode == 400) {
        return SignupModel.fromJson(jsonDecode(response.body));
      }
      else if (response.statusCode == 404) {
        // not found
        CustomSnackBar(buildContext, Text(response.body));
      } else if (response.statusCode == 500) {
        // server not responding.
        CustomSnackBar(buildContext, Text(response.body));
      } else {
        CustomSnackBar(buildContext, Text(response.body));
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
