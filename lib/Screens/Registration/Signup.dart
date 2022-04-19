import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracker_ui/BLoC/Signup_BloC.dart';
import 'package:tracker_ui/Common/Constants.dart';
import 'package:tracker_ui/Common/Prefs.dart';
import 'package:tracker_ui/Models/Registration/SignupModel.dart';
import 'package:tracker_ui/Screens/Registration/Login.dart';
import 'package:tracker_ui/api.dart';
import '../../Common/Dialog.dart';
import '../../Common/snackbar.dart';
import '../../Common/theme.dart';
import '../Home/Home.dart';

class Signuppg extends StatefulWidget {
  @override
  State<Signuppg> createState() => _SignuppgState();
}

class _SignuppgState extends State<Signuppg> {
  final formKeys = GlobalKey<FormState>();
  SignupModel signupModel;
  ApiService apiService = new ApiService();

  bool _isObscure1 = true;

  TextEditingController fnameController;
  TextEditingController lnameController;
  TextEditingController mobController;
  TextEditingController emailController;
  TextEditingController pswdController;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SignupBLoC>(context, listen: false);

    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Builder(builder: (context) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Card(
                  elevation: 5,
                  margin: const EdgeInsets.only(top: 200),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: const BorderSide(color: CustomTheme.Coral1),
                  ),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
                    decoration: BoxDecoration(
                      color: CustomTheme.Coral3,
                      borderRadius: BorderRadius.circular(5),
                      // border: Border.all(color: CustomTheme.Blue1),
                    ),
                    child: Column(
                      children: [
                        //  first name
                        StreamBuilder(
                          stream: bloc.fName,
                          builder: (context, AsyncSnapshot snapshot) => Card(
                            elevation: 0,
                            margin: const EdgeInsets.only(bottom: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextFormField(
                              controller: fnameController,
                              onChanged: bloc.changeFName,
                              cursorColor: CustomTheme.Blue1,
                              keyboardType: TextInputType.name,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                hintText: 'First name',
                                errorText: snapshot.error,
                                errorStyle: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                contentPadding: const EdgeInsets.only(left: 20),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: CustomTheme.Grey2,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: CustomTheme.Grey2,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: CustomTheme.Grey2,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                        ),

                        //  last name
                        StreamBuilder(
                          stream: bloc.lName,
                          builder: (context, AsyncSnapshot snapshot) => Card(
                            elevation: 0,
                            margin: const EdgeInsets.only(bottom: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextFormField(
                              controller: lnameController,
                              onChanged: bloc.changeLName,
                              cursorColor: CustomTheme.Blue1,
                              keyboardType: TextInputType.name,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Last name',
                                errorText: snapshot.error,
                                errorStyle: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                contentPadding: const EdgeInsets.only(left: 20),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: CustomTheme.Grey2,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: CustomTheme.Grey2,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: CustomTheme.Grey2,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                        ),

                        //  email
                        StreamBuilder(
                          stream: bloc.signupEmail,
                          builder: (context, AsyncSnapshot snapshot) => Card(
                            elevation: 0,
                            margin: const EdgeInsets.only(bottom: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextFormField(
                              controller: emailController,
                              onChanged: bloc.changeSemail,
                              cursorColor: CustomTheme.Blue1,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Email',
                                errorText: snapshot.error,
                                errorStyle: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                contentPadding: const EdgeInsets.only(left: 20),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: CustomTheme.Grey2,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: CustomTheme.Grey2,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: CustomTheme.Grey2,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                        ),

                        //  password
                        StreamBuilder(
                          stream: bloc.signupPswd,
                          builder: (context, AsyncSnapshot snapshot) => Card(
                            elevation: 0,
                            margin: const EdgeInsets.only(bottom: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextFormField(
                              controller: pswdController,
                              onChanged: bloc.changeSpswd,
                              cursorColor: CustomTheme.Blue1,
                              obscureText: _isObscure1,
                              keyboardType: TextInputType.visiblePassword,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Password',
                                errorText: snapshot.error,
                                errorStyle: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                contentPadding: const EdgeInsets.only(left: 20),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: CustomTheme.Grey2,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: CustomTheme.Grey2,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: CustomTheme.Grey2,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                suffixIcon: IconButton(
                                    icon: Icon(_isObscure1
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        _isObscure1 = !_isObscure1;
                                      });
                                    }),
                              ),
                            ),
                          ),
                        ),

                        //  sign up btn
                        StreamBuilder(
                          stream: bloc.isValid,
                          builder: (buildContext, AsyncSnapshot snapshot) => SizedBox(
                            height: 50,
                            width: 170,
                            // margin: const EdgeInsets.only(top: 150),
                            child: Card(
                              color: snapshot.hasError || !snapshot.hasData
                                  ? Colors.blueGrey
                                  : CustomTheme.Grey2,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                // side: BorderSide(color: CustomTheme.Blue3),
                              ),
                              child: MaterialButton(
                                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                                elevation: 5,
                                onPressed: snapshot.hasError || !snapshot
                                    .hasData ? null : () async {
                                  if(snapshot.hasData) {
                                    bloc.submit(context);
                                    print('register success!!');
                                    Prefs.instance.setBooleanValue(CONST.LoggedIn, true);
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Homepg()));
                                  }
                                },
                                child: const Text(
                                  'Sign up >',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //  login
                const Padding(
                  padding: EdgeInsets.only(top: 80),
                  child: Text(
                    'Already have an account',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 50,
                  width: 170,
                  margin: const EdgeInsets.only(top: 5),
                  child: Card(
                    color: CustomTheme.Grey2,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      // side: BorderSide(color: CustomTheme.Blue3),
                    ),
                    child: MaterialButton(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      elevation: 5,
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return Loginpg();
                        }));
                      },
                      child: const Text(
                        'Login >',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ),
      ),
      onWillPop: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => Loginpg())),
    );
  }
}
