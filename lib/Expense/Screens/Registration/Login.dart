import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracker_ui/Expense/Common/snackbar.dart';
import 'package:tracker_ui/Expense/Screens/Registration/Signup.dart';
import '../../Common/Constants.dart';
import '../../Common/Helper.dart';
import '../../Common/Prefs.dart';
import '../../Common/theme.dart';
import '../../Service/Registration/Registration_Apis.dart';
import '../Category/Category.dart';

class Loginpg extends StatefulWidget {
  @override
  State<Loginpg> createState() => _LoginpgState();
}

class _LoginpgState extends State<Loginpg> {
  final formKeys = GlobalKey<FormState>();
  final formKeys2 = GlobalKey<FormState>();

  bool _isVerified = false, _isOtp = true;
  bool _isObscure = true, _isLogin = true, _isSignup = false;

  TextEditingController emailController = new TextEditingController();
  TextEditingController pswdController = new TextEditingController();
  TextEditingController otpController = TextEditingController();

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1.0), fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromRGBO(129, 174, 217, 1.0), width: 1),
      borderRadius: BorderRadius.circular(20),
    ),
  );


  @override
  void initState() {
    super.initState();
  }

  void login() async {
    try {
      showProgress(context, 'Please wait...', true);
      final prefs = await SharedPreferences.getInstance();

      var email = emailController.text;
      var password = pswdController.text;

      APIService apiService = new APIService();
      apiService.login(email, password).then((value) {
        setState(() {
          if (value != null) {
            hideProgress();
            print("add_category ${value.status}");
            if (value.status == 200) {
              hideProgress();
              print("$email  $password");
              ScaffoldMessenger(child: Text(value.message));
              print('login success!!');
              Prefs.instance.setBooleanValue(CONST.LoggedIn, true);
              Navigator.of(context).pushReplacement(
                  new MaterialPageRoute(builder: (context) => Category()));
            } else {
              return "Failed to load data!";
            }
          }
        });
      });
    } catch (e) {
      print('cart exception = $e');
    }
  }

  void register() async {
    showProgress(context, 'Please wait...', true);
    try {
      final prefs = await SharedPreferences.getInstance();

      var email = emailController.text;
      var password = pswdController.text;

      APIService apiService = new APIService();
      apiService.register(email, password).then((value) {
        setState(() {
          if (value != null) {
            hideProgress();
            print("register ${value.status}");
            if (value.status == 200) {
              print("$email  $password");
              ScaffoldMessenger(child: Text(value.message));
              print('register success!!');
              Prefs.instance.setBooleanValue(CONST.LoggedIn, true);
              Navigator.of(context).pushReplacement(
                  new MaterialPageRoute(builder: (context) => Category()));
            } else if (value.status == 207) {
              hideProgress();
              CustomSnackBar(context, Text(value.message.toString()));
            } else {
              return "Failed to load data!";
            }
          }
        });
      });
    } catch (e) {
      print('exception = $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
            child: Column(
              children: <Widget>[
                //  gif
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 80, 20, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        _isLogin
                            ? 'assets/img/signin.jpg'
                            : 'assets/img/signup.jpg',
                        height: 250,
                      ),
                      SizedBox(height: 40),
                      const Text(
                        'EXPENSE TRACKER',
                        style: TextStyle(
                          fontSize: 22,
                          color: CustomTheme.Grey2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                Visibility(
                  visible: _isLogin,
                  child: Column(
                    children: [
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: const BorderSide(color: CustomTheme.Blue3),
                        ),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          decoration: BoxDecoration(
                            color: CustomTheme.Blue4,
                            borderRadius: BorderRadius.circular(5),
                            // border: Border.all(color: CustomTheme.Grey2),
                          ),
                          child: Form(
                            key: formKeys,
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
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Please enter email";
                                      } else if (!RegExp(r'\S+@\S+\.\S+')
                                          .hasMatch(value)) {
                                        return "Please enter valid email";
                                      }
                                    },
                                    inputFormatters: [
                                      FilteringTextInputFormatter.deny(" "),
                                      FilteringTextInputFormatter
                                          .singleLineFormatter,
                                    ],
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    cursorColor: CustomTheme.Blue1,
                                    style: const TextStyle(
                                      // fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Email',
                                      errorStyle: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20),
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
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Please enter email";
                                      }
                                    },
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(15),
                                      FilteringTextInputFormatter
                                          .singleLineFormatter,
                                    ],
                                    controller: pswdController,
                                    obscureText: _isObscure,
                                    keyboardType: TextInputType.visiblePassword,
                                    cursorColor: CustomTheme.Blue1,
                                    style: const TextStyle(
                                      // fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      errorStyle: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20),
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

                                //  login btn
                                SizedBox(
                                  height: 45,
                                  width: 130,
                                  child: Card(
                                    color: CustomTheme.Grey2,
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      // side: BorderSide(color: CustomTheme.Blue3),
                                    ),
                                    child: MaterialButton(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 0),
                                      elevation: 5,
                                      onPressed: () {
                                        if (formKeys.currentState.validate()) {
                                          formKeys.currentState.save();
                                          login();
                                        }
                                      },
                                      child: const Text(
                                        'Login',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
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
                                color: CustomTheme.Blue1,
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
                        ),
                      ),

                      //  sign up
                      const Padding(
                        padding: const EdgeInsets.only(top: 90),
                        child: Text(
                          'Create a new account',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: 45,
                        width: 160,
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
                                horizontal: 30, vertical: 0),
                            elevation: 5,
                            onPressed: () {
                              setState(() {
                                print('signup');
                                _isLogin = false;
                                _isSignup = true;
                                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) { return Signuppg();}));
                              });
                            },
                            child: const Text(
                              'Sign up >',
                              style: TextStyle(
                                fontSize: 16,
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

                Visibility(
                  visible: _isSignup,
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Column(
                      children: [
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: const BorderSide(color: CustomTheme.Blue3),
                          ),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                            decoration: BoxDecoration(
                              color: CustomTheme.Blue4,
                              borderRadius: BorderRadius.circular(5),
                              // border: Border.all(color: CustomTheme.Grey2),
                            ),
                            child: Form(
                              key: formKeys,
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      'Heyy new user !!',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),

                                  //  email
                                  Card(
                                    elevation: 0,
                                    margin: const EdgeInsets.only(bottom: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Please enter email";
                                        } else if (!RegExp(r'\S+@\S+\.\S+')
                                            .hasMatch(value)) {
                                          return "Please enter valid email";
                                        }
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(" "),
                                        FilteringTextInputFormatter
                                            .singleLineFormatter,
                                      ],
                                      controller: emailController,
                                      cursorColor: CustomTheme.Blue1,
                                      keyboardType: TextInputType.emailAddress,
                                      style: const TextStyle(
                                        // fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Email',
                                        errorStyle: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        contentPadding:
                                            const EdgeInsets.only(left: 20),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: CustomTheme.Grey2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: CustomTheme.Grey2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: CustomTheme.Grey2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Please enter email";
                                        }
                                      },
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(15),
                                        FilteringTextInputFormatter
                                            .singleLineFormatter,
                                      ],
                                      controller: pswdController,
                                      cursorColor: CustomTheme.Blue1,
                                      obscureText: _isObscure,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      style: const TextStyle(
                                        // fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Password',
                                        errorStyle: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        contentPadding:
                                            const EdgeInsets.only(left: 20),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: CustomTheme.Grey2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: CustomTheme.Grey2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: CustomTheme.Grey2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
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

                                  //  sign up btn
                                  SizedBox(
                                    height: 45,
                                    width: 140,
                                    // margin: const EdgeInsets.only(top: 150),
                                    child: Card(
                                      color: CustomTheme.Grey2,
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        // side: BorderSide(color: CustomTheme.Blue3),
                                      ),
                                      child: MaterialButton(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 0),
                                        elevation: 5,
                                        onPressed: () {
                                          if (formKeys.currentState
                                              .validate()) {
                                            formKeys.currentState.save();
                                            // register();
                                            otp_verify();
                                          }
                                        },
                                        child: const Text(
                                          'Sign up',
                                          style: TextStyle(
                                            fontSize: 16,
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

                        //  login
                        const Padding(
                          padding: EdgeInsets.only(top: 60),
                          child: Text(
                            'Already have an account',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 160,
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
                                setState(() {
                                  _isLogin = true;
                                  _isSignup = false;
                                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) { return Loginpg();}));
                                });
                              },
                              child: const Text(
                                'Login >',
                                style: TextStyle(
                                  fontSize: 16,
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
              ],
            ),
          ),
        ),
      ),
      onWillPop: () => SystemNavigator.pop(),
    );
  }

  Widget otp_verify() {
    print("otp_verify");
    showDialog(
        context: context,
        builder: (BuildContext dialogcontext) {
          return AlertDialog(
              title: _isOtp ? Text(
                "Email Verification",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                softWrap: true,
              ) : null,
              content: Container(
                width: MediaQuery.of(context).size.width,
                height: _isOtp ? MediaQuery.of(context).size.height * 0.3 : MediaQuery.of(context).size.height * 0.25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: _isOtp,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 25, horizontal: 20),
                            child: Text(
                              'Enter the verification code received on ${emailController.text}',
                              style: const TextStyle(
                                fontSize: 16.5,
                                fontWeight: FontWeight.bold,
                              ),
                              softWrap: true,
                            ),
                          ),
                          Pinput(
                            controller: otpController,
                            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                            showCursor: true,
                            onCompleted: (pin) => print(pin),
                            defaultPinTheme: defaultPinTheme,
                            focusedPinTheme: defaultPinTheme.copyDecorationWith(
                              border:
                              Border.all(color: Color.fromRGBO(92, 143, 191, 1)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            submittedPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration.copyWith(
                                color: Color.fromRGBO(233, 241, 248, 1.0),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 40),
                            height: 40,
                            width: 130,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CustomTheme.Grey2,
                              ),
                              child: Text(
                                "Confirm",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  _isOtp = false;
                                  _isVerified = true;
                                  print("verified");
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    Visibility(
                      visible: _isVerified,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Email Verification Successful !!!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            softWrap: true,
                          ),
                          Image.asset(
                            'assets/img/verify.jpg',
                            height: 130,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            height: 40,
                            width: 130,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: CustomTheme.Grey2),
                                // backgroundColor: CustomTheme.Grey2,
                              ),
                              child: Text(
                                "Continue",
                                style: const TextStyle(
                                  color: CustomTheme.Grey2,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  register();
                                  Navigator.of(dialogcontext).pop();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          );
        });
    /*showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0)),
        ),
        builder: (bottomcontext) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.35,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                  child: Text(
                    "Enter the verification code received on \n${emailController.text}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                  ),
                ),
                Pinput(
                  controller: otpController,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (pin) => print(pin),
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyDecorationWith(
                    border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  submittedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration.copyWith(
                      color: Color.fromRGBO(234, 239, 243, 1),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  height: 40,
                  width: 130,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomTheme.Grey2,
                    ),
                    child: Text(
                      "Confirm",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              title: Text("Verified Successfully !!!"),
                              content: OutlinedButton(
                                child: Text(
                                  "Next",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // onPressed: () => register(),
                              ),
                            );
                          });
                    },
                  ),
                ),
              ],
            ),
          );
        });*/
  }

  @override
  void dispose() {
    super.dispose();
  }
}
