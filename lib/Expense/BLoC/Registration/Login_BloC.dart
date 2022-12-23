import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracker_ui/Expense/BLoC/Registration/Validators.dart';
import 'package:tracker_ui/Expense/Common/Constants.dart';
import 'package:tracker_ui/Expense/Models/Registration/LoginPodo.dart';

import '../../Common/Prefs.dart';
import '../../Screens/Category/Category.dart';
import '../../Service/Registration/Registration_Apis.dart';
import '../../Widgets/Helper.dart';
import '../../Widgets/snackbar.dart';



class LoginBLoC with Validators{
  APIService apiService = new APIService();

  //  stream controllers
  final _lEmail = BehaviorSubject<String>();
  final _lPswd = BehaviorSubject<String>();

  final _data = PublishSubject();

  //  getters
  Stream<String> get loginEmail => _lEmail.stream.transform(emailValidator);
  Stream<String> get loginPswd => _lPswd.stream.transform(pswdValidator);

  Stream<bool> get isValid => Observable.combineLatest2(loginEmail, loginPswd, (a, b) => true);


  // setters
  Function(String) get changeLemail => _lEmail.sink.add;
  Function(String) get changeLpswd => _lPswd.sink.add;


  bool isLoggedIn = false;

  //  api call
  dynamic submit(BuildContext buildContext) async {
    showProgress(buildContext, 'Please wait...', false);

    await apiService.login(_lEmail.value, _lPswd
        .value, buildContext).then((value) async {
      if (value != null) {
        hideProgress();
        if (value.status == 200) {
          final prefs = await SharedPreferences.getInstance();

          String email = _lEmail.value;
          String password = _lPswd.value;

          prefs.setBool(CONST.LoggedIn, true);
          prefs.setString(CONST.pswd, password);
          prefs.getString(CONST.token);

          prefs.setString(CONST.email, value.data.email);
          prefs.setString(CONST.userId, value.data.userId);
          print('user_id : ${value.data.userId}');

          prefs.setString(CONST.token, value.data.token);
          print('token : ${value.data.token}');

          print('login success!!');
          Prefs.instance.setBooleanValue(CONST.LoggedIn, true);

          WidgetsBinding.instance.addPostFrameCallback((_) =>
              Navigator.push(buildContext, new MaterialPageRoute(builder: (context) => new Category())));
          _data.sink.add;
        } else if (value.status != 200) {
          hideProgress();
          CustomSnackBar(buildContext, Text(value.message));
        }
      }
    });

    print(_lEmail.value);
    print(_lPswd.value);
  }


  void dispose() {
    _lEmail.close();
    _lPswd.close();
  }

}

