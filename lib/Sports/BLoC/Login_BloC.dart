import 'dart:async';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

import 'Validators.dart';

class LoginBLoC with Validators{
  //  stream controllers
  final _lEmail = BehaviorSubject<String>();
  final _lPswd = BehaviorSubject<String>();

  //  getters
  Stream<String> get loginEmail => _lEmail.stream.transform(emailValidator);
  Stream<String> get loginPswd => _lPswd.stream.transform(loginPswdValidator);

  Stream<bool> get isValid => Rx.combineLatest2(loginEmail, loginPswd, (a, b) => true);


  // setters
  Function(String) get changeLemail => _lEmail.sink.add;
  Function(String) get changeLpswd => _lPswd.sink.add;

  void submit() {
    // implement api call here
    print(_lEmail.value);
    print(_lPswd.value);
  }

  void dispose() {
    _lEmail.close();
    _lPswd.close();
  }
}

