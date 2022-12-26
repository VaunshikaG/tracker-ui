import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracker_ui/Expense/BLoC/Registration/Validators.dart';
import '../../Common/Constants.dart';
import '../../Screens/Category/Category.dart';
import '../../Screens/Registration/Login.dart';
import '../../Service/Registration/Registration_Apis.dart';
import '../../Widgets/Helper.dart';
import '../../Widgets/snackbar.dart';


final blocSignup = SignupBLoC();

class SignupBLoC with Validators{
  APIService apiService = new APIService();

  //  stream controllers
  final _sEmail = BehaviorSubject<String>();
  final _sPswd = BehaviorSubject<String>();

  final _data = PublishSubject();

  //  getters
  Stream<String> get signupEmail => _sEmail.stream.transform(emailValidator);
  Stream<String> get signupPswd => _sPswd.stream.transform(pswdValidator);

  Stream<bool> get isValid => Observable.combineLatest2(_sEmail,_sPswd, (a, b) => true);


  // setters
  Function(String) get changeSemail => _sEmail.sink.add;
  Function(String) get changeSpswd => _sPswd.sink.add;

  //  api call
  dynamic submit(BuildContext buildContext) async {
    showProgress(buildContext, 'Please wait...', false);

    await apiService.register(_sEmail.value, _sPswd.value, buildContext).then
      ((value) async {
      if (value != null) {
        hideProgress();
        if (value.status == 201) {
          final prefs = await SharedPreferences.getInstance();

          String email = _sEmail.value;
          String password = _sPswd.value;

          prefs.setBool(CONST.LoggedIn, true);
          prefs.setString(CONST.email, email);
          prefs.setString(CONST.userId, value.data.uid.toString());
          prefs.getString(CONST.token);

          _data.sink.add;
          WidgetsBinding.instance.addPostFrameCallback((_) => Navigator.push(buildContext,
                  new MaterialPageRoute(builder: (context) => new Loginpg())));
        } else if (value.status != 201) {
          hideProgress();
          CustomSnackBar(buildContext, Text(value.message));
        }
      }
    });

    print(_sEmail);
    print(_sPswd);
  }

  dynamic email_otp(BuildContext buildContext) async {
    // showProgress(buildContext, 'Sending email...', true);

    await apiService.email_otp(_sEmail.value, buildContext).then
      ((value) async {
      if (value != null) {
        // hideProgress();
        if (value.status == 200) {
          final prefs = await SharedPreferences.getInstance();

          String email = _sEmail.value;
          String password = _sPswd.value;

          prefs.setBool(CONST.LoggedIn, true);
          prefs.setString(CONST.email, email);
          prefs.setString(CONST.pswd, password);
          prefs.setString(CONST.otp, value.data.otp);

          _data.sink.add;


        } else if (value.status != 200) {
          // hideProgress();
          CustomSnackBar(buildContext, Text(value.message));
        }
      }
    });

    print(_sEmail);
    print(_sPswd);
  }

  void dispose() {
    _sEmail.close();
    _sPswd.close();
  }

}

