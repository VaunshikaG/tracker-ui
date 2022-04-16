import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:tracker_ui/BLoC/Validators.dart';
import 'package:tracker_ui/Models/SignupModel.dart';

import '../Screens/Home/Home.dart';
import '../api.dart';

class SignupBLoC with Validators{
  //  stream controllers
  final _fName = BehaviorSubject<String>();
  final _lName = BehaviorSubject<String>();
  final _sEmail = BehaviorSubject<String>();
  final _sPswd = BehaviorSubject<String>();

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

  dynamic register(BuildContext buildContext) async {
    ApiService apiService = new ApiService();

    final result = await apiService.Register(_fName.value, _lName.value, _sEmail.value, _sPswd.value);
    final data = SignupModel.fromJson(jsonDecode(result)) as Map<String, dynamic>;

    if (data['status'] == 200) {
      print('email : ' + _sEmail.value);
      print('password : ' + _sPswd.value);

      // ApiService.setToken(data['token'], data['refresulthToken']);
      Navigator.pushReplacement(buildContext, MaterialPageRoute(builder: (context) => Homepg()));
      return data;
    }
  }

  //Submit
  void submit() {
      //TODO: CALL API
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

