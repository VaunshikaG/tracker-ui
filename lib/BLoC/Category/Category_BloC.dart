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
  final ApiService apiService = new ApiService();

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
  int datalength = 0;
  List<CategoryModel> data = [];
  final _getData = PublishSubject();

  dynamic getData() async {
    apiService.get_Allcategories().then((value) {
      if(value != null) {
        data = value;
        datalength = data.length;
        print('length = $datalength');
        print(data[0].userId);
        _getData.sink.add(data);
      }
    });
  }


  //  post call
  final _data = PublishSubject();
  dynamic submit(BuildContext buildContext) {
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