import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracker_ui/Common/Prefs.dart';

import '../../Common/Constants.dart';
import '../../Models/Category/CategoryModel.dart';
import '../../Models/Category/Model2.dart';

class ApiService {
  //  add categories
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

  Future<List<CategoryModel>> get_Allcategories() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(CONST.token);
    Uri url = Uri.parse(URL.app_url + URL.categories_url);

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'JWT $token',
      });

      if (response.statusCode == 200 || response.statusCode == 400) {
        List<CategoryModel> categoryModelFromJson(String str) => List<CategoryModel>.from(json.decode(str).map((x) => CategoryModel.fromJson(x)));
        var body = categoryModelFromJson(response.body);
        return body;
      } else {
        ScaffoldMessenger(child: Text(response.statusCode.toString()));
        // throw Exception('Failed to load album');
      }
    } catch(e) {
      throw e;
    }
  }

  Future<CategoryModel> get_CategoryByID() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(CONST.token) ?? "";
    String id = prefs.getString(CONST.categoryId);
    print(id);
    Uri url = Uri.parse(URL.app_url + URL.categories_url + "$id");

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'JWT $token',
      });
      if (response.statusCode == 200 || response.statusCode == 400) {
        var responseData = json.decode(response.body);
        var user = CategoryModel.fromJson(responseData);
        Prefs.instance.setIntegerValue(CONST.userId, user.categoryId);
        print(user.categoryId);
        return user;
      } else {
        ScaffoldMessenger(child: Text(response.statusCode.toString()));
        // throw Exception('Failed to load album');
      }
    } catch(e) {
      print(e);
      throw e;
    }
  }
}
