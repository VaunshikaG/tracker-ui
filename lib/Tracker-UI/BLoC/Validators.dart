//  transformers for validtion
import 'dart:async';

mixin Validators {

  //  email validator
  var emailValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (email.isEmpty) {
        return sink.addError("Please enter email");
      }
      if (email.length >= 20) {
        return sink.addError("Email should be less than 20 characters");
      }
      if (email.length <= 6) {
        return sink.addError("Email should be more than 6 characters");
      }
      if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
        return sink.addError('Enter valid email');
      } else {
        sink.add(email);
      }
    },
  );

  //  login pswd validator
  var loginPswdValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (pswd, sink) {
      if (pswd.isEmpty) {
        return sink.addError("Please enter password");
      }
      if (pswd.length >= 20) {
        return sink.addError("Password should be less than 20 characters");
      }
      if (pswd.length < 8) {
        return sink.addError("Password should be more than 6 characters");
      } else {
        sink.add(pswd);
      }
    },
  );

  //  name validator
  var nameValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink) {
      if (name.isEmpty) {
        return sink.addError("Please enter name");
      }
      if (name.length >= 20) {
        return sink.addError("Name should be less than 20 characters");
      }
      if (name.length <= 3) {
        return sink.addError("Name should be more than 3 characters");
      }
      if(!RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$").hasMatch(name)) {
        return sink.addError('Enter valid name');
      } else {
        sink.add(name);
      }
    },
  );

  //  mob validator
  var mobValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (mob, sink) {
      if (mob.isEmpty) {
        return sink.addError("Please enter phone number");
      }
      if (mob.length >=10) {
        return sink.addError("Number should be less than 10 digits");
      }
      if (mob.length < 10) {
        return sink.addError("Number should be more than 10 digits");
      }
      if(!RegExp(r"^[0-9]{10}").hasMatch(mob)) {
        return sink.addError('Enter valid phone number');
      } else {
        sink.add(mob);
      }
    },
  );

  //  signup pswd validator
  var signupPswdValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (pswd, sink) {
      if (pswd.isEmpty) {
        return sink.addError("Please enter password");
      }
      if (pswd.length >= 20) {
        return sink.addError("Password should be less than 20 characters");
      }
      if (pswd.length < 8) {
        return sink.addError("Password should be more than 6 characters");
      }
      if(!RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,15}$").hasMatch(pswd)) {
        return sink.addError('Enter valid email');
      } else {
        sink.add(pswd);
      }
    },
  );
}