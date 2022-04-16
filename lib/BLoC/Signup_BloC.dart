import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:tracker_ui/BLoC/Validators.dart';
import 'package:tracker_ui/Models/Registration/SignupModel.dart';

import '../Screens/Home/Home.dart';
import '../api.dart';


final blocSignup = SignupBLoC();

class SignupBLoC with Validators{
  //  stream controllers
  final _fName = BehaviorSubject<String>();
  final _lName = BehaviorSubject<String>();
  final _sEmail = BehaviorSubject<String>();
  final _sPswd = BehaviorSubject<String>();

  final _data = PublishSubject();

  //  getters
  Stream<String> get fName => _fName.stream.transform(nameValidator);
  Stream<String> get lName => _lName.stream.transform(nameValidator);
  Stream<String> get signupEmail => _sEmail.stream.transform(emailValidator);
  Stream<String> get signupPswd => _sPswd.stream.transform(signupPswdValidator);

  Stream<bool> get isValid => Rx.combineLatest4(fName, lName, _sEmail,_sPswd, (a, b, c, d) => true);


  // setters
  Function(String) get changeFName => _fName.sink.add;
  Function(String) get changeLName => _lName.sink.add;
  Function(String) get changeSemail => _sEmail.sink.add;
  Function(String) get changeSpswd => _sPswd.sink.add;

  //  api call
  dynamic submit(BuildContext buildContext) async {
    ApiService apiService = new ApiService();

    final result = await apiService.Register(_fName.value, _lName.value,
      _sEmail.value, _sPswd.value, buildContext);
    final data = SignupModel.fromJson(jsonDecode(result)) as Map<SignupModel, dynamic>;

    if (data != null) {
      String firstName = _fName.value;
      String lastName = _lName.value;
      String email = _sEmail.value;
      String password = _sPswd.value;

      SignupModel signupModel = await apiService.Register(firstName,
          lastName, email, password, buildContext);
      _data.sink.add(signupModel);
      ApiService.setToken(data['token'], data['refresulthToken']);
      Navigator.pushNamed(buildContext, '/home');
    }

    print(_fName);
    print(_lName);
    print(_sEmail);
    print(_sPswd);
  }

  void dispose() {
    _fName.close();
    _lName.close();
    _sEmail.close();
    _sPswd.close();
  }
}

