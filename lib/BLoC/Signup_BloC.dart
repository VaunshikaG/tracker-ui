import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracker_ui/BLoC/Validators.dart';
import 'package:tracker_ui/Models/Registration/SignupModel.dart';
import '../Common/Constants.dart';
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
  dynamic submit(BuildContext buildContext) {
    ApiService apiService = new ApiService();

    apiService.Register(_fName.value, _lName.value,
      _sEmail.value, _sPswd.value, buildContext).then((value) async {
      if (value != null) {
        final prefs = await SharedPreferences.getInstance();

        String firstName = _fName.value;
        String lastName = _lName.value;
        String email = _sEmail.value;
        String password = _sPswd.value;

        prefs.setBool(CONST.LoggedIn, true);
        prefs.setString(CONST.email, email);
        prefs.setString(CONST.pswd, password);

        SignupModel signupModel = await apiService.Register(firstName,
            lastName, email, password, buildContext);
        _data.sink.add(signupModel);
        // ApiService.setToken(data['token'], data['refreshToken']);
        Navigator.of(buildContext).pushReplacement(
            MaterialPageRoute(builder: (context) =>
                Homepg()));
      }
    });

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

