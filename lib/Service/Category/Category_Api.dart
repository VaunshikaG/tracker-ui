import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Common/Constants.dart';
import '../../Common/snackbar.dart';
import '../../Models/Category/CategoryModel.dart';

class ApiService {

  //  categories
  Future<dynamic> categories(String title,
      String description, BuildContext buildContext) async {
    Uri url = Uri.parse(URL.app_url + URL.categories_url);


    try {
      final response = await http.post(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization': 'JWT $token',
        },
        body: jsonEncode(<String, String>{
          "title": title,
          "description": description,
        }),
      );

      print(jsonEncode(title).toString());
      print(response.body.toString());

      if (response.statusCode == 200 || response.statusCode == 400) {
        return CategoryModel.fromJson(jsonDecode(response.body));
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