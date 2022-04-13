import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

import 'Validators.dart';

class SignupBLoC with Validators{
  //  stream controllers
  final _Name = BehaviorSubject<String>();
  final _Mob = BehaviorSubject<String>();
  final _sEmail = BehaviorSubject<String>();
  final _sPswd = BehaviorSubject<String>();
  final _ConfirmPswd = BehaviorSubject<String>();

  //  getters
  Stream<String> get Name => _Name.stream.transform(nameValidator);
  Stream<String> get Mob => _Mob.stream.transform(mobValidator);
  Stream<String> get signupEmail => _sEmail.stream.transform(emailValidator);
  Stream<String> get signupPswd => _sPswd.stream.transform(signupPswdValidator);
  Stream<String> get signupConfirmPswd => _ConfirmPswd.stream.transform(signupPswdValidator);

  Stream<bool> get isValid => Rx.combineLatest5(Name, Mob, signupEmail, signupPswd, signupConfirmPswd, (a, b, c, d, e) => true);
  
  Stream<bool> get matchPswd => Rx.combineLatest2(signupPswd, signupConfirmPswd, (a, b) {
    if(a != b) {
      return false;
    } else {
      return true;
    }
  });


  // setters
  Function(String) get changeName => _Name.sink.add;
  Function(String) get changeMob => _Mob.sink.add;
  Function(String) get changeSemail => _sEmail.sink.add;
  Function(String) get changeSpswd => _sPswd.sink.add;
  Function(String) get changeConfirmpswd => _ConfirmPswd.sink.add;


  //Submit
  void submit() {
    if (signupPswd != signupConfirmPswd) {
      _ConfirmPswd.sink.addError("Password doesn't match");
    } else {
      //TODO: CALL API
      print(_Name);
      print(_Mob);
      print(_sEmail);
      print(_sPswd);
      print(_ConfirmPswd);
    }
  }

  void dispose() {
    _Name.close();
    _Mob.close();
    _sEmail.close();
    _sPswd.close();
    _ConfirmPswd.close();
  }
}

