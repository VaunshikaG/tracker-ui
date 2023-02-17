import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tracker_ui/Demo/BLoC/Category/Validators.dart';
import 'package:tracker_ui/Demo/Common/Constants.dart';
import 'package:tracker_ui/Demo/Common/Prefs.dart';

import '../../Models/Category/CategoryListPodo.dart';
import '../../Models/Category/CategoryPodo.dart';
import '../../Models/Category/CategoryReqModel.dart';
import '../../Screens/Category/Category.dart';
import '../../Service/Category/Category_Api.dart';

final catbloc = CategoryBloC();

class CategoryBloC with Validators {
  final APIService apiService = new APIService();
  CategoryReqModel _categoryReqModel = new CategoryReqModel();

  //  stream controllers
  final _title = BehaviorSubject<String>();
  final _desc = BehaviorSubject<String>();
  final _amt = BehaviorSubject<String>();

  //  getter
  Stream<String> get title => _title.stream.transform(titleValidator);

  Stream<String> get desc => _desc.stream.transform(descValidator);

  Stream<String> get amt => _amt.stream.transform(amtValidator);

  Stream<bool> get isValid =>
      Observable.combineLatest3(title, desc, amt, (a, b, c) => true);

  //  setters
  Function(String) get changedTitle => _title.sink.add;

  Function(String) get changedDesc => _desc.sink.add;

  Function(String) get changedAmt => _amt.sink.add;

  //  get call
  Stream<CategoryListPodo> get catList async* {
    yield await apiService.category_by_user();
  }

  Stream<CategoryPodo> get cat_by_id async* {
    yield await apiService.category_by_id();
  }

  //  add category - post call
  final _data = PublishSubject();

  dynamic savecategory(BuildContext buildContext) async {
    apiService
        .add_category(_title.value, _desc.value, _amt.value, buildContext)
        .then((value) {
      if (value != null) {
        String title = _title.value;
        String desc = _desc.value;
        String amt = _amt.value;
        Prefs.instance.getStringValue(CONST.token);

        _data.sink.add;
        WidgetsBinding.instance.addPostFrameCallback((_) =>
            Navigator.push(
                buildContext,
                new MaterialPageRoute(
                    builder: (context) => new Category())));
        print('category added');
      }
    });
  }

  dynamic deletecategory(BuildContext buildContext) async {
    try {
      await apiService.delete_category(buildContext).then((value) {
        if (value != null) {
          print("delete_category ${value.status}");
          if (value.status.contains("200")) {
            print(value.message);
            WidgetsBinding.instance.addPostFrameCallback((_) =>
                Navigator.push(
                    buildContext,
                    new MaterialPageRoute(
                        builder: (context) => new Category())));
            ScaffoldMessenger(child: Text(value.message));
          } else {
            return "Failed to load data!";
          }
        }
      });
    } catch (e) {
      print('cart exception = $e');
    }
  }

  dynamic updatecategory(BuildContext buildContext) async {
    try {
      // _categoryReqModel.title = _title.value;
      // _categoryReqModel.description = _desc.value;
      // _categoryReqModel.amount = _amt.value;
      // print(_categoryReqModel.toJson());

      // await apiService.update_category(_categoryReqModel)
      await apiService
          .update_category(_title.value, _desc.value, _amt.value, buildContext)
          .then((value) {
        if (value != null) {
          print("update_category ${value.status}");
          if (value.status == 200) {
            _data.sink.add;


            WidgetsBinding.instance.addPostFrameCallback((_) =>
                Navigator.push(
                    buildContext,
                    new MaterialPageRoute(
                        builder: (context) => new Category())));
            print('category updated:  ${value.message}');
          } else {
            return "Failed to load data!";
          }
        }
      });
    } catch (e) {
      print('cart exception = $e');
    }
  }

  void dispose() {
    _title.close();
    _desc.close();
    _data.close();
  }
}
