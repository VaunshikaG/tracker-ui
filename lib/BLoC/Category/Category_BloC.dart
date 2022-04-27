import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracker_ui/BLoC/Category/Validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tracker_ui/Common/Constants.dart';
import 'package:tracker_ui/Common/Prefs.dart';
import '../../Models/Category/CategoryModel.dart';
import '../../Service/Category/Category_Api.dart';

final bloc = CategoryBloC();

class CategoryBloC with Validators {
  //  stream controllers
  final _title = BehaviorSubject<String>();
  final _desc = BehaviorSubject<String>();

  //  getter
  Stream<String> get title => _title.stream.transform(titleValidator);
  Stream<String> get desc => _desc.stream.transform(titleValidator);
  Stream<bool> get isValid => Rx.combineLatest2(title, desc, (a, b) => true);

  //  setters
  Function(String) get changedTitle => _title.sink.add;
  Function(String) get changedDesc => _desc.sink.add;


  //  get call
  final _getData = PublishSubject<CategoryModel>();
  Stream<CategoryModel> get allCategory => _getData.stream;

  dynamic getData() async {
    ApiService apiService = new ApiService();
    CategoryModel categoryModel = await apiService.get_Allcategories();
    _getData.sink.add(categoryModel);
  }


  //  post call
  final _data = PublishSubject();
  dynamic submit(BuildContext buildContext) {
    ApiService apiService = new ApiService();

    apiService.categories(_title.value, _desc.value, buildContext).then((value) async {
      if(value != null) {

        String title = _title.value;
        String desc = _desc.value;
        Prefs.instance.getStringValue(CONST.token);

        CategoryModel categoryModel = await apiService.categories(title,
            desc, buildContext);
        _data.sink.add;
        print('category added');
        Navigator.pop(buildContext);
      }
    });
  }

  void dispose() {
    _title.close();
    _desc.close();
    _data.close();
    _getData.close();
  }
}