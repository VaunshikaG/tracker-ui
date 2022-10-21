import 'package:flutter/material.dart';
import 'package:tracker_ui/Expense/Common/Constants.dart';
import 'package:tracker_ui/Expense/Common/Prefs.dart';
import 'package:tracker_ui/Expense/Screens/Registration/Login.dart';
import '../../Common/theme.dart';
import '../Category/Category.dart';

class Signuppg extends StatefulWidget {
  @override
  State<Signuppg> createState() => _SignuppgState();
}

class _SignuppgState extends State<Signuppg> {
  final formKeys = GlobalKey<FormState>();

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

    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Builder(builder: (context) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Column(
                  children: [
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
                            //  email
                            Card(
                              elevation: 0,
                              margin: const EdgeInsets.only(bottom: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextFormField(
                                controller: emailController,
                                cursorColor: CustomTheme.Blue1,
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Email',
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

                            //  password
                            Card(
                              elevation: 0,
                              margin: const EdgeInsets.only(bottom: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextFormField(
                                controller: pswdController,
                                cursorColor: CustomTheme.Blue1,
                                obscureText: _isObscure1,
                                keyboardType: TextInputType.visiblePassword,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Password',
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

                            //  sign up btn
                            SizedBox(
                              height: 50,
                              width: 170,
                              // margin: const EdgeInsets.only(top: 150),
                              child: Card(
                                color: CustomTheme.Grey2,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  // side: BorderSide(color: CustomTheme.Blue3),
                                ),
                                child: MaterialButton(
                                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                                  elevation: 5,
                                  onPressed: ()
                                  async {
                                    print('register success!!');
                                    Prefs.instance.setBooleanValue(CONST.LoggedIn, true);
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Category()));
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

                Column(
                  children: [

                  ],
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
