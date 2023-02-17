import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Common/Constants.dart';
import '../../Models/Category/CategoryListPodo.dart';
import '../../Models/Category/CategoryPodo.dart';
import '../../Models/Category/DeletePodo.dart';

class APIService {
  //  add categories
  Future<CategoryPodo> add_category(
      String title, String description, String amount, BuildContext buildContext) async {
    final prefs = await SharedPreferences.getInstance();

    var uid = prefs.getString(CONST.userId);
    final token = prefs.getString(CONST.token) ?? "";

    Uri url = Uri.parse(URL.user_url + "/$uid/category");

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'JWT $token',
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
        return CategoryPodo.fromJson(jsonDecode(response.body));
      } else {
        print(response.statusCode);
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

  //  category by user
  Future<CategoryListPodo> category_by_user() async {
    final prefs = await SharedPreferences.getInstance();

    var uid = prefs.getString(CONST.userId);

    // Uri url = Uri.parse(URL.user_url + "/1/category");
    Uri url = Uri.parse(URL.user_url + "/$uid/category");
    print(url);

    final token = prefs.getString(CONST.token) ?? "";

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'JWT $token',
        "Content-Type": "application/json",
        'Accept': '*/*',
      });

      if (response.statusCode == 200 || response.statusCode == 400) {
        // print('category_by_user ${response.body}');
        return CategoryListPodo.fromJson(
            jsonDecode(response.body));
      } else {
        print(response.statusCode);
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

  //  category by id
  Future<CategoryPodo> category_by_id() async {
    final prefs = await SharedPreferences.getInstance();

    var cid = prefs.getString(CONST.categoryId);

    // Uri url = Uri.parse(URL.user_url + "/1/category");
    Uri url = Uri.parse(URL.category_url + "/$cid");
    print(url);

    final token = prefs.getString(CONST.token) ?? "";

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'JWT $token',
        "Content-Type": "application/json",
        'Accept': '*/*',
      });

      if (response.statusCode == 200 || response.statusCode == 400) {
        return CategoryPodo.fromJson(
            jsonDecode(response.body));
      } else {
        print(response.statusCode);
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

  //  update categories
  Future<CategoryPodo> update_category(
      // CategoryReqModel reqModel) async {
      String title,
      String description,
      String amount, BuildContext buildContext) async {
    final prefs = await SharedPreferences.getInstance();

    var cid = prefs.getString(CONST.categoryId);
    final token = prefs.getString(CONST.token) ?? "";

    Uri url = Uri.parse(URL.category_url + "/$cid");

    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'JWT $token',
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body:
            // reqModel.toJson(),
        jsonEncode(<String, String>{
          "title": title,
          "description": description,
          "amount": amount,
        }),
      );

      print(response.body.toString());

      if (response.statusCode == 200 || response.statusCode == 400) {
        return CategoryPodo.fromJson(jsonDecode(response.body));
      } else {
        print(response.statusCode);
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

  //  delete category
  Future<DeletePodo> delete_category(BuildContext buildContext) async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString(CONST.token);
    var id = prefs.getString(CONST.categoryId);

    Uri url = Uri.parse(URL.category_url + "/$id");
    print(url);

    try {
      final response =
          await http.delete(url, headers: {'Authorization': 'JWT $token'});

      if (response.statusCode == 200 || response.statusCode == 400) {
        return DeletePodo.fromJson(jsonDecode(response.body));
      } else {
        print(response.statusCode);
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

  Future<CategoryPodo> search_category(
      String keyword) async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString(CONST.token) ?? "";
    Uri url = Uri.parse(URL.search_url + "/$keyword");

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'JWT $token',
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{
          "keyword": keyword,
        }),
      );

      print(jsonEncode(keyword).toString());
      print(response.body.toString());

      if (response.statusCode == 200 || response.statusCode == 400) {
        return CategoryPodo.fromJson(jsonDecode(response.body));
      } else {
        print(response.statusCode);
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
