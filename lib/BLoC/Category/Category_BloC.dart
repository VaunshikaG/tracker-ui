import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracker_ui/BLoC/Category/Validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tracker_ui/Common/Constants.dart';
import 'package:tracker_ui/Common/Prefs.dart';

import '../../Models/Category/CategoryModel.dart';
import '../../Service/Category/Category_Api.dart';

class CategoryBloC with Validators {
  //  stream controllers
  final _title = BehaviorSubject<String>();
  final _desc = BehaviorSubject<String>();

  final _data = PublishSubject();


  //  getter
  Stream<String> get title => _title.stream.transform(titleValidator);
  Stream<String> get desc => _desc.stream.transform(titleValidator);

  Stream<bool> get isValid => Rx.combineLatest2(title, desc, (a, b) => true);


  //  setters
  Function(String) get changedTitle => _title.sink.add;
  Function(String) get changedDesc => _desc.sink.add;

  void sub(BuildContext buildContext) {
    print(_title.value);
    print(_desc.value);
  }

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
    // _getData.close();
  }
}