import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tracker_ui/Tracker-UI/BLoC/Signup_BloC.dart';
import 'package:tracker_ui/Tracker-UI/theme.dart';
import '../Home/Home.dart';
import 'Login.dart';

class Signuppg extends StatefulWidget {
  @override
  State<Signuppg> createState() => _SignuppgState();
}

class _SignuppgState extends State<Signuppg> {
  final formKeys = GlobalKey<FormState>();

  bool _isObscure1 = true;

  TextEditingController fnameController;
  TextEditingController lnameController;
  TextEditingController emailController;
  TextEditingController pswdController;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SignupBLoC>(context, listen: false);

    return new WillPopScope(
      child: Scaffold(
        backgroundColor: CustomTheme.Blue4,
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 110),
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    // border: Border.all(color: CustomTheme.Blue1),
                  ),
                  child: Column(
                    children: [
                      //  first name
                      StreamBuilder(
                        stream: bloc.Name,
                        builder: (context, AsyncSnapshot snapshot) => Card(
                          elevation: 0,
                          margin: const EdgeInsets.only(bottom: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextFormField(
                            controller: fnameController,
                            onChanged: bloc.changeName,
                            cursorColor: CustomTheme.Blue1,
                            keyboardType: TextInputType.name,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              hintText: 'First name',
                              errorText: snapshot.error,
                              errorStyle: TextStyle(fontWeight: FontWeight.bold),
                              contentPadding: EdgeInsets.only(left: 20),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: CustomTheme.Blue1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: CustomTheme.Blue1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: CustomTheme.Blue1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      ),

                      //  last name
                      StreamBuilder(
                        stream: bloc.Name,
                        builder: (context, AsyncSnapshot snapshot) => Card(
                          elevation: 0,
                          margin: const EdgeInsets.only(bottom: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextFormField(
                            controller: lnameController,
                            onChanged: bloc.changeName,
                            cursorColor: CustomTheme.Blue1,
                            keyboardType: TextInputType.name,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Last name',
                              errorText: snapshot.error,
                              errorStyle: TextStyle(fontWeight: FontWeight.bold),
                              contentPadding: EdgeInsets.only(left: 20),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: CustomTheme.Blue1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: CustomTheme.Blue1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: CustomTheme.Blue1,
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
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Email',
                              errorText: snapshot.error,
                              errorStyle: TextStyle(fontWeight: FontWeight.bold),
                              contentPadding: EdgeInsets.only(left: 20),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: CustomTheme.Blue1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: CustomTheme.Blue1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: CustomTheme.Blue1,
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
                            onChanged: (value) => bloc.changeSpswd,
                            cursorColor: CustomTheme.Blue1,
                            obscureText: _isObscure1,
                            keyboardType: TextInputType.visiblePassword,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Password',
                              errorText: snapshot.error,
                              errorStyle: TextStyle(fontWeight: FontWeight.bold),
                              contentPadding: EdgeInsets.only(left: 20),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: CustomTheme.Blue1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: CustomTheme.Blue1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: CustomTheme.Blue1,
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
                          builder: (context, AsyncSnapshot snapshot) => Container(
                            height: 50,
                            width: 170,
                            // margin: const EdgeInsets.only(top: 150),
                            child: Card(
                              color: snapshot.hasError || !snapshot.hasData ? Colors.grey.shade600 : CustomTheme.Blue1,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                // side: BorderSide(color: CustomTheme.Blue3),
                              ),
                              child: MaterialButton(
                                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                                elevation: 5,
                                onPressed: snapshot.hasError || !snapshot.hasData  ? null : () async {
                                  bloc.submit();
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                        return Homepg();
                                      }));
                                },
                                child: Text(
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

                //  login
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Text(
                    'Already have an account',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 170,
                  margin: const EdgeInsets.only(top: 5),
                  child: Card(
                    color: CustomTheme.Blue1,
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
                      child: Text(
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
      onWillPop: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => Loginpg())),
    );
  }
}
