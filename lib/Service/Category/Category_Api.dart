import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Common/Constants.dart';
import '../../Common/snackbar.dart';
import '../../Models/Category/CategoryModel.dart';

class ApiService {
  //  categories
  Future<dynamic> categories(
      String title, String description, BuildContext buildContext) async {
    final prefs = await SharedPreferences.getInstance();
    Uri url = Uri.parse(URL.app_url + URL.categories_url);
    String token = prefs.getString(CONST.token) ?? "";

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'JWT $token',
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

  Future<dynamic> get_Allcategories() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(CONST.token);
    Uri url = Uri.parse(URL.app_url + URL.categories_url);

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'JWT $token',
      });

      if (response.statusCode == 200 || response.statusCode == 400) {
        List<CategoryModel> data = [];
        final body = json.decode(response.body) as List;
        List sublist =  body.map((val) => new CategoryModel.fromJson(val)).toList();
        return sublist;
        // return CategoryModel.fromJson(jsonDecode(response.body));
      } else {
        ScaffoldMessenger(child: Text(response.statusCode.toString()));
        // throw Exception('Failed to load album');
      }
    } catch(e) {
      throw e;
    }
  }

  Future<dynamic> get_CategoryByID(BuildContext buildContext) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(CONST.token) ?? "";

    Uri url = Uri.parse(URL.app_url + URL.categories_url);
    // Uri url = Uri.parse(URL.app_url + URL.categories_url + "/${catgoryId}");

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'JWT $token',
      });
      if (response.statusCode == 200 || response.statusCode == 400) {
        return CategoryModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 404) {
        // not found
        CustomSnackBar(buildContext, Text(response.statusCode.toString()));
      } else if (response.statusCode == 500) {
        // server not responding.
        CustomSnackBar(buildContext, Text(response.statusCode.toString()));
      } else {
        CustomSnackBar(buildContext, Text(response.statusCode.toString()));
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
