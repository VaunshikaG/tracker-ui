import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracker_ui/Expense/BLoC/Registration/Login_BloC.dart';
import 'package:tracker_ui/Expense/BLoC/Registration/Signup_BloC.dart';

import '../../Common/Constants.dart';
import '../../Common/Prefs.dart';
import '../../Common/theme.dart';
import '../../Widgets/snackbar.dart';
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
    width: 45,
    height: 50,
    textStyle: const TextStyle(
        fontSize: 15,
        color: Color.fromRGBO(30, 60, 87, 1.0),
        fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromRGBO(129, 174, 217, 1.0), width: 1),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final login_bloc = Provider.of<LoginBLoC>(context, listen: false);
    final signup_bloc = Provider.of<SignupBLoC>(context, listen: false);

    return WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.alphaBlend(const Color(0xAAFFFFFF), CustomTheme.grey2),
        body: LayoutBuilder(builder: (context, constraint) {
          return Container(
            alignment: Alignment.center,
            child: Stack(
              children: [
                //  bottom
                Positioned(
                  top: (constraint.maxHeight / 1.8),
                  left: (constraint.maxHeight / 9),
                  child: Container(
                    width: constraint.maxWidth / 0.8,
                    height: constraint.maxHeight / 1.5,
                    decoration: new BoxDecoration(
                      color: CustomTheme.grey2,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                //  top
                Positioned(
                  bottom: constraint.maxHeight / 2.6,
                  left: -(constraint.maxHeight / 2.9),
                  child: Container(
                    width: constraint.maxWidth / 0.6,
                    height: constraint.maxHeight / 1.5,
                    decoration: BoxDecoration(
                      color: Color.alphaBlend(const Color(0xAAFFFFFF),
                          CustomTheme.coral1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: constraint.maxHeight / 2.6,
                  left: -(constraint.maxHeight / 2.9),
                  child: Container(
                    width: constraint.maxWidth / 0.6,
                    height: constraint.maxHeight / 1.5,
                    decoration: new BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                //  middle
                Positioned(
                  bottom: constraint.maxHeight / 6,
                  right: -(constraint.maxHeight / 10),
                  child: Container(
                    width: constraint.maxWidth / 1.04,
                    height: constraint.maxHeight / 2,
                    decoration: BoxDecoration(
                      color: Color.alphaBlend(
                          const Color(0xAAFFFFFF), CustomTheme.coral1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                Positioned(
                  top: constraint.maxHeight / 6,
                  left: (constraint.maxHeight / 3.3),
                  child: Container(
                    alignment: AlignmentDirectional.topCenter,
                    width: constraint.maxWidth / 2.6,
                    padding: EdgeInsets.all(30),
                    decoration: new BoxDecoration(
                      color: CustomTheme.grey2,
                      shape: BoxShape.circle,
                    ),
                    child: _isSignup ? Text(
                      'Heyy\nnew user !!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ): Text(
                      'Welcome\nback !!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: (constraint.maxHeight / 10),
                  right: (constraint.maxHeight / 5.8),
                  child: Container(
                    alignment: AlignmentDirectional.topCenter,
                    width: constraint.maxWidth / 1.6,
                    height: constraint.maxWidth / 1.5,
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Image.asset(
                      _isLogin
                          ? 'assets/img/login_transparent.png'
                          : 'assets/img/signup_transparent.png',
                      height: 250,
                    ),
                  ),
                ),
                Positioned(
                  top: constraint.maxHeight / 2.5,
                  right: constraint.maxHeight / 70,
                  child: Container(
                    width: constraint.maxWidth / 1.5,
                    height: constraint.maxHeight / 1.8,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Image.asset(
                              "assets/img/logo02.png",
                              width: 150,
                            ),
                          ),
                          SizedBox(height: 10),
                          Visibility(
                            visible: _isLogin,
                            child: Column(
                              children: [
                                Form(
                                  key: formKeys,
                                  child: Column(
                                    children: [
                                      //  email streambuilder is to listen stream from bloc
                                      StreamBuilder<String>(
                                        stream: login_bloc.loginEmail,
                                        builder: (context,
                                            AsyncSnapshot<String>
                                            snapshot) =>
                                            Card(
                                              elevation: 5,
                                              margin:
                                              const EdgeInsets.only(bottom: 20),
                                              child: TextFormField(
                                                onChanged: login_bloc.changeLemail,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return "Please enter email";
                                                  } else if (!RegExp(
                                                      r'\S+@\S+\.\S+')
                                                      .hasMatch(value)) {
                                                    return "Please enter valid email";
                                                  }
                                                },
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.deny(
                                                      " "),
                                                  FilteringTextInputFormatter
                                                      .singleLineFormatter,
                                                ],
                                                controller: emailController,
                                                keyboardType:
                                                TextInputType.emailAddress,
                                                cursorColor: CustomTheme.blue1,
                                                style: const TextStyle(
                                                  // fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Color.alphaBlend(
                                                      Color(0xAAFFFFFF),
                                                      CustomTheme.blu3),
                                                  constraints:
                                                  BoxConstraints(maxWidth: 300),
                                                  hintText: 'Email',
                                                  errorText: snapshot.error,
                                                  errorStyle: const TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                  contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                      color: Colors.transparent,
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
                                                      color: Colors.transparent,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(5),
                                                  ),
                                                  focusedErrorBorder:
                                                  OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                      color: Colors.transparent,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(5),
                                                  ),
                                                ),
                                              ),
                                            ),
                                      ),

                                      //  password
                                      StreamBuilder(
                                        stream: login_bloc.loginPswd,
                                        builder: (context,
                                            AsyncSnapshot<String>
                                            snapshot) =>
                                            Card(
                                              elevation: 5,
                                              margin:
                                              const EdgeInsets.only(bottom: 20),
                                              child: TextFormField(
                                                onChanged: login_bloc.changeLpswd,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return "Please enter email";
                                                  }
                                                },
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      15),
                                                  FilteringTextInputFormatter
                                                      .singleLineFormatter,
                                                ],
                                                controller: pswdController,
                                                obscureText: _isObscure,
                                                keyboardType:
                                                TextInputType.visiblePassword,
                                                cursorColor: CustomTheme.blue1,
                                                style: const TextStyle(
                                                  // fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Color.alphaBlend(
                                                      Color(0xAAFFFFFF),
                                                      CustomTheme.blu3),
                                                  constraints:
                                                  BoxConstraints(maxWidth: 300),
                                                  hintText: 'Password',
                                                  errorText: snapshot.error,
                                                  errorStyle: const TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                  contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                      color: Colors.transparent,
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
                                                      color: Colors.transparent,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(5),
                                                  ),
                                                  focusedErrorBorder:
                                                  OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                      color: Colors.transparent,
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
                                      ),

                                      //  login btn
                                      StreamBuilder(
                                        stream: login_bloc.isValid,
                                        builder: (context, snapshot) =>
                                            SizedBox(
                                              height: 40,
                                              width: 120,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(5),
                                                  ),
                                                  backgroundColor:
                                                  snapshot.hasError ||
                                                      !snapshot.hasData
                                                      ? Colors.blueGrey
                                                      : CustomTheme.grey,
                                                  padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30,
                                                      vertical: 0),
                                                  elevation: 5,
                                                ),
                                                onPressed: () async {
                                                  print("pressed");
                                                  if (snapshot.hasData) {
                                                    login_bloc.submit(context);
                                                  } else if (snapshot.hasError) {
                                                    return CustomSnackBar(context,
                                                        Text(snapshot.error));
                                                  }
                                                  return const Text('error');
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

                                      /*//  forgot pswd
                                Container(
                                  child: TextButton(
                                    child: Text(
                                      'Forgot your password?',
                                      style: TextStyle(
                                        color: Colors.white,
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
                                const Padding(
                                  padding: const EdgeInsets.only(top: 90),
                                  child: Text(
                                    'Create a new account',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  width: 140,
                                  margin: const EdgeInsets.only(top: 5),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      backgroundColor: CustomTheme.grey,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 0),
                                      elevation: 5,
                                    ),
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
                              ],
                            ),
                          ),
                          Visibility(
                            visible: _isSignup,
                            child: Column(
                              children: [
                                Form(
                                  key: formKeys,
                                  child: Column(
                                    children: [

                                      //  email
                                      StreamBuilder(
                                        stream: signup_bloc.signupEmail,
                                        builder:
                                            (context, AsyncSnapshot snapshot) =>
                                            Card(
                                              elevation: 5,
                                              margin:
                                              const EdgeInsets.only(bottom: 20),
                                              child: TextFormField(
                                                onChanged: signup_bloc.changeSemail,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return "Please enter email";
                                                  } else if (!RegExp(
                                                      r'\S+@\S+\.\S+')
                                                      .hasMatch(value)) {
                                                    return "Please enter valid email";
                                                  }
                                                },
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.deny(
                                                      " "),
                                                  FilteringTextInputFormatter
                                                      .singleLineFormatter,
                                                ],
                                                controller: emailController,
                                                cursorColor: CustomTheme.blue1,
                                                keyboardType:
                                                TextInputType.emailAddress,
                                                style: const TextStyle(
                                                  // fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Color.alphaBlend(
                                                      Color(0xAAFFFFFF),
                                                      CustomTheme.blu3),
                                                  constraints:
                                                  BoxConstraints(maxWidth: 300),
                                                  hintText: 'Email',
                                                  errorText: snapshot.error,
                                                  errorStyle: const TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                  contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                      color: Colors.transparent,
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
                                                      color: Colors.transparent,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(5),
                                                  ),
                                                  focusedErrorBorder:
                                                  OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                      color: Colors.transparent,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(5),
                                                  ),
                                                ),
                                              ),
                                            ),
                                      ),

                                      //  password
                                      StreamBuilder(
                                        stream: signup_bloc.signupPswd,
                                        builder:
                                            (context, AsyncSnapshot snapshot) =>
                                            Card(
                                              elevation: 5,
                                              margin:
                                              const EdgeInsets.only(bottom: 20),
                                              child: TextFormField(
                                                onChanged: signup_bloc.changeSpswd,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return "Please enter email";
                                                  }
                                                },
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      15),
                                                  FilteringTextInputFormatter
                                                      .singleLineFormatter,
                                                ],
                                                controller: pswdController,
                                                cursorColor: CustomTheme.blue1,
                                                obscureText: _isObscure,
                                                keyboardType:
                                                TextInputType.visiblePassword,
                                                style: const TextStyle(
                                                  // fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Color.alphaBlend(
                                                      Color(0xAAFFFFFF),
                                                      CustomTheme.blu3),
                                                  constraints:
                                                  BoxConstraints(maxWidth: 300),
                                                  hintText: 'Password',
                                                  errorText: snapshot.error,
                                                  errorStyle: const TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                  contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                      color: Colors.transparent,
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
                                                      color: Colors.transparent,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(5),
                                                  ),
                                                  focusedErrorBorder:
                                                  OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                      color: Colors.transparent,
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
                                      ),

                                      //  sign up btn
                                      StreamBuilder(
                                        stream: signup_bloc.isValid,
                                        builder: (buildContext,
                                            AsyncSnapshot snapshot) =>
                                            SizedBox(
                                              height: 40,
                                              width: 120,
                                              // margin: const EdgeInsets.only(top: 150),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(5),
                                                  ),
                                                  backgroundColor:
                                                  snapshot.hasError ||
                                                      !snapshot.hasData
                                                      ? Colors.blueGrey
                                                      : CustomTheme.grey,
                                                  padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30,
                                                      vertical: 0),
                                                  elevation: 5,
                                                ),
                                                onPressed: () async {
                                                  if (snapshot.hasData && formKeys.currentState.validate()) {
                                                    formKeys.currentState.save();
                                                    otp_verify();
                                                  } else if (snapshot.hasError) {
                                                    formKeys.currentState.save();
                                                    return CustomSnackBar(context, Text(snapshot.error));
                                                  }
                                                  return Text('error');
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

                                //  login
                                const Padding(
                                  padding: EdgeInsets.only(top: 90),
                                  child: Text(
                                    'Already have an account',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  width: 140,
                                  margin: const EdgeInsets.only(top: 5),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      backgroundColor: CustomTheme.grey,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 0),
                                      elevation: 5,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isLogin = true;
                                        _isSignup = false;
                                        print('login');
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
      onWillPop: () => SystemNavigator.pop(),
    );
  }

  Widget otp_verify() {
    final signup_bloc = Provider.of<SignupBLoC>(context, listen: false);

    // signup_bloc.email_otp(context);
    print("otp_verify");
    showDialog(
        context: context,
        builder: (dialogcontext) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter stateSetter) {
            return AlertDialog(
              title: _isOtp
                  ? Text(
                      "Email Verification",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: true,
                    )
                  : null,
              content: Container(
                width: MediaQuery.of(dialogcontext).size.width * 1.5,
                height: _isOtp
                    ? MediaQuery.of(dialogcontext).size.height * 0.27
                    : MediaQuery.of(dialogcontext).size.height * 0.25,
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
                                vertical: 15, horizontal: 20),
                            child: Text(
                              'Enter the verification code received on ${emailController.text}',
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                              softWrap: true,
                            ),
                          ),
                          Pinput(
                            length: 6,
                            controller: otpController,
                            pinputAutovalidateMode:
                                PinputAutovalidateMode.onSubmit,
                            showCursor: true,
                            onCompleted: (pin) => print(pin),
                            defaultPinTheme: defaultPinTheme,
                            focusedPinTheme: defaultPinTheme.copyDecorationWith(
                              border: Border.all(
                                  color: Color.fromRGBO(92, 143, 191, 1)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            submittedPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration.copyWith(
                                color: Color.fromRGBO(233, 241, 248, 1.0),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            height: 40,
                            width: 130,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CustomTheme.grey,
                              ),
                              child: Text(
                                "Confirm",
                                style: const TextStyle(
                                  fontSize: 17,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onPressed: () async {
                                final prefs = await SharedPreferences.getInstance();
                                var str_otp = prefs.getString(CONST.otp);
                                print(otpController.text);
                                if (str_otp == otpController.text) {
                                  setState(() {
                                    print("verified");
                                    verified(stateSetter);
                                    otpController.text = "";
                                  });
                                } else {
                                  setState(() {
                                    print("invalid");
                                    otp(stateSetter);
                                    otpController.text = "";
                                  });
                                }
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
                                side: BorderSide(color: CustomTheme.grey),
                                // backgroundColor: CustomTheme.grey,
                              ),
                              child: Text(
                                "Continue",
                                style: const TextStyle(
                                  color: CustomTheme.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  print('register success!!');
                                  Prefs.instance.setBooleanValue(CONST.LoggedIn, true);
                                  signup_bloc.submit(dialogcontext);
                                  otp(stateSetter);
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
        });
  }

  Future<Null> verified(StateSetter updateState) async {
    updateState(() {
      _isVerified = true;
      _isOtp = false;
    });
  }

  Future<Null> otp(StateSetter updateState) async {
    updateState(() {
      _isVerified = false;
      _isOtp = true;
    });
  }


  @override
  void dispose() {
    super.dispose();
  }
}
