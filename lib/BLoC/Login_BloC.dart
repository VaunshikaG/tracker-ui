import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:tracker_ui/BLoC/Validators.dart';
import 'package:tracker_ui/Models/Registration/LoginModel.dart';

import '../Screens/Home/Home.dart';
import '../api.dart';

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


  //  api call
  dynamic submit(BuildContext buildContext) async {
    ApiService apiService = new ApiService();

    final result = await apiService.Login(_lEmail.value, _lPswd
        .value, buildContext);
    final data = LoginModel.fromJson(jsonDecode(result)) as Map<String, dynamic>;

    if (data != null) {
      String email = _lEmail.value;
      String password = _lPswd.value;

      LoginModel loginModel = await apiService.Login(email, password, buildContext);
      _data.sink.add(loginModel);
      ApiService.setToken(data['token'], data['refresulthToken']);
    }

    print(_lEmail.value);
    print(_lPswd.value);
  }


  void dispose() {
    _lEmail.close();
    _lPswd.close();
  }

}

