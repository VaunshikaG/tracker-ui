import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../BLoC/Login_BloC.dart';
import '../../theme.dart';
import '../Home/Home.dart';
import 'Signup.dart';

class Loginpg extends StatefulWidget {
  @override
  State<Loginpg> createState() => _LoginpgState();
}

class _LoginpgState extends State<Loginpg> {
  final formKeys = GlobalKey<FormState>();

  bool _isObscure = true;

  TextEditingController emailController;
  TextEditingController pswdController;

  @override
  Widget build(BuildContext context) {
    //  calling bloc class
    final bloc = Provider.of<LoginBLoC>(context, listen: false);

    return new WillPopScope(
      child: Scaffold(
        backgroundColor: MyTheme.Blue4,
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //  gif
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  // width: MediaQuery.of(context).size.width * 0.2,
                  margin: const EdgeInsets.fromLTRB(20, 100, 20, 10),
                  // child: Image.asset(
                  //   'assets/gifs/Splash.gif',
                  //   height: 300,
                  // ),
                ),

                Container(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    // border: Border.all(color: MyTheme.Blue1),
                  ),
                  child: Column(
                    children: [
                      //  email streambuilder is to listen stream from bloc
                      StreamBuilder<String>(
                        stream: bloc.loginEmail,
                        builder: (context, AsyncSnapshot<String> snapshot) => Card(
                          elevation: 0,
                          margin: const EdgeInsets.only(bottom: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextFormField(
                            //  to set entered email
                            onChanged: bloc.changeLemail,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: MyTheme.Blue1,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Email',
                              errorText: snapshot.error,
                              errorStyle: TextStyle(fontWeight: FontWeight.bold),
                              contentPadding: EdgeInsets.symmetric(horizontal: 20),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MyTheme.Blue1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MyTheme.Blue1,
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
                                  color: MyTheme.Blue1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      ),


                      //  password
                      StreamBuilder(
                        stream: bloc.loginPswd,
                        builder: (context, AsyncSnapshot<String> snapshot) => Card(
                          elevation: 0,
                          margin: const EdgeInsets.only(bottom: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextFormField(
                            //  to set entered pswd
                            onChanged: bloc.changeLpswd,
                            controller: emailController,
                            obscureText: _isObscure,
                            keyboardType: TextInputType.visiblePassword,
                            cursorColor: MyTheme.Blue1,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Password',
                              errorText: snapshot.error,
                              errorStyle: TextStyle(fontWeight: FontWeight.bold),
                              contentPadding: EdgeInsets.symmetric(horizontal: 20),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MyTheme.Blue1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MyTheme.Blue1,
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
                                  color: MyTheme.Blue1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              suffixIcon: IconButton(
                                  icon: Icon(_isObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  }),
                            ),
                          ),
                        ),
                      ),


                      //  login btn
                      StreamBuilder(
                        stream: bloc.isValid,
                        builder: (context, snapshot) => Container(
                          height: 50,
                          width: 170,
                          child: Card(
                            color: snapshot.hasError || !snapshot.hasData ? Colors.grey.shade600 : MyTheme.Blue1,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              // side: BorderSide(color: MyTheme.Blue3),
                            ),
                            child: MaterialButton(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                              elevation: 5,
                              onPressed: snapshot.hasError || !snapshot.hasData ? null : () async {
                                bloc.submit();
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                      return Homepg();
                                    }));
                              },
                              child: Text(
                                'Login',
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

                      //  forgot pswd
                      /*Container(
                          child: TextButton(
                            child: Text(
                              'Forgot your password?',
                              style: TextStyle(
                                color: MyTheme.Blue1,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),*/
                    ],
                  ),
                ),

                //  sign up
                Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: Text(
                    'Create a new account',
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
                    color: MyTheme.Blue1,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      // side: BorderSide(color: MyTheme.Blue3),
                    ),
                    child: MaterialButton(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 0),
                      elevation: 5,
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                              return Signuppg();
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
              ],
            ),
          ),
        ),
      ),
      onWillPop: () => SystemNavigator.pop(),
    );
  }
}
