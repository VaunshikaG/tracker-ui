import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracker_ui/BLoC/Registration/Validators.dart';
import 'package:tracker_ui/Common/Constants.dart';
import 'package:tracker_ui/Models/Registration/LoginModel.dart';
import '../../Screens/Category/Category.dart';
import '../../Service/Registration/Registration_Apis.dart';


class LoginBLoC with Validators{
  //  stream controllers
  final _lEmail = BehaviorSubject<String>();
  final _lPswd = BehaviorSubject<String>();

  final _data = PublishSubject();

  //  getters
  Stream<String> get loginEmail => _lEmail.stream.transform(emailValidator);
  Stream<String> get loginPswd => _lPswd.stream.transform(loginPswdValidator);

  Stream<bool> get isValid => Rx.combineLatest2(loginEmail, loginPswd,
          (a, b) => true);


  // setters
  Function(String) get changeLemail => _lEmail.sink.add;
  Function(String) get changeLpswd => _lPswd.sink.add;


  bool isLoggedIn = false;

  //  api call
  dynamic submit(BuildContext buildContext) {
    ApiService apiService = new ApiService();

    apiService.login(_lEmail.value, _lPswd
        .value, buildContext).then((value) async {
      if (value != null) {
        final prefs = await SharedPreferences.getInstance();

        String email = _lEmail.value;
        String password = _lPswd.value;

        prefs.setBool(CONST.LoggedIn, true);
        prefs.setString(CONST.email, email);
        prefs.setString(CONST.pswd, password);
        prefs.getString(CONST.token);

        LoginModel loginModel = await apiService.login(email, password, buildContext);
        _data.sink.add(loginModel);
        // ApiService.setToken(data['token'], data['refresulthToken']);
        // Navigator.of(buildContext).pushReplacement(MaterialPageRoute(builder: (buildContext) => Category()));
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

