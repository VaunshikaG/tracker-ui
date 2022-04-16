import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tracker_ui/Common/Constants.dart';
import 'package:tracker_ui/Common/snackbar.dart';
import 'Common/Dialog.dart';
import 'Models/SignupModel.dart';
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
      String password) async {
    Uri url = Uri.parse(URL.app_url + URL.register_url);

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

    if (response.statusCode == 200 || response.statusCode == 400) {
      return SignupModel.fromJson(jsonDecode(response.body));
    }
    else if (response.statusCode == 404) {
      // not found
      // CustomSnackBar(buildContext, Text(response.body));
    } else if (response.statusCode == 500) {
      // server not responding.
      // CustomSnackBar(buildContext, Text(response.body));
    } else {
      // CustomSnackBar(buildContext, Text(response.body));
    }
  }
}
