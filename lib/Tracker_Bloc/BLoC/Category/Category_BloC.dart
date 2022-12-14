import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracker_ui/Tracker_Bloc/BLoC/Category/Validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tracker_ui/Tracker_Bloc/Common/Constants.dart';
import 'package:tracker_ui/Tracker_Bloc/Common/Prefs.dart';
import '../../Models/Category/CategoryModel.dart';
import '../../Models/Category/Model2.dart';
import '../../Service/Category/Category_Api.dart';

final catbloc = CategoryBloC();

class CategoryBloC with Validators {
  final ApiService apiService = new ApiService();

  //  stream controllers
  final _title = BehaviorSubject<String>();
  final _desc = BehaviorSubject<String>();

  //  getter
  Stream<String> get title => _title.stream.transform(titleValidator);
  Stream<String> get desc => _desc.stream.transform(titleValidator);
  Stream<bool> get isValid => Observable.combineLatest2(title, desc, (a, b) => true);

  //  setters
  Function(String) get changedTitle => _title.sink.add;
  Function(String) get changedDesc => _desc.sink.add;


  //  get call
  Stream<List<CategoryModel>> get usersList async* {
    yield await apiService.get_Allcategories();
  }

  Stream<List<Model2>> get catList async* {
    yield await apiService.get_CategoryByID();
  }

  //  add category - post call
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
      }
    });
  }

  //  update - post call
  final _update = PublishSubject();
  void update() {
    print(_title.value);
    print(_desc.value);
  }

  void dispose() {
    _title.close();
    _desc.close();
    _data.close();
  }
}