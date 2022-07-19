import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import '../../Common/Constants.dart';
import '../../Models/Category/AddPodo.dart';
import '../../Models/Category/AllCategoriesPodo.dart';
import '../../Models/Category/DeletePodo.dart';

class APIService {

  //  add categories
  Future<AddPodo> add_category(
      String title, String description, String amount) async {
    final prefs = await SharedPreferences.getInstance();
    Uri url = Uri.parse(URL.category_url);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{
          "title": title,
          "description": description,
          "amount": amount,
        }),
      );

      print(jsonEncode(title).toString());
      print(response.body.toString());

      if (response.statusCode == 200 || response.statusCode == 400) {
        return AddPodo.fromJson(jsonDecode(response.body));
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

  //  category list
  Future<AllCategoriesPodo> get_Allcategories() async {
    final prefs = await SharedPreferences.getInstance();
    Uri url = Uri.parse(URL.category_url);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200 || response.statusCode == 400) {
        return AllCategoriesPodo.fromJson(jsonDecode(response.body));
      } else {
        ScaffoldMessenger(child: Text(response.statusCode.toString()));
        // throw Exception('Failed to load album');
      }
    } catch(e) {
      throw e;
    }
  }

  //  update categories
  Future<AddPodo> update_category(
      String title, String description, String amount) async {
    final prefs = await SharedPreferences.getInstance();

    var id = prefs.getString(CONST.categoryId);
    Uri url = Uri.parse(URL.category_url+"/$id");

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{
          "title": title,
          "description": description,
          "amount": amount,
        }),
      );

      print(jsonEncode(title).toString());
      print(response.body.toString());

      if (response.statusCode == 200 || response.statusCode == 400) {
        return AddPodo.fromJson(jsonDecode(response.body));
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

  //  delete category
  Future<DeletePodo> delete_category() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(CONST.token);

    var id = prefs.getString(CONST.categoryId);
    Uri url = Uri.parse(URL.category_url+"/$id");

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200 || response.statusCode == 400) {
        return DeletePodo.fromJson(jsonDecode(response.body));
      } else {
        ScaffoldMessenger(child: Text(response.statusCode.toString()));
        // throw Exception('Failed to load album');
      }
    } catch(e) {
      throw e;
    }
  }

}
