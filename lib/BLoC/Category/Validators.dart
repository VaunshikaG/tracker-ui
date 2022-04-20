//  transformers for validtion
import 'dart:async';

mixin Validators {

  //  title validator
  var titleValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (title, sink) {
      if (title.isEmpty) {
        return sink.addError("Please enter password");
      }
      if (title.length >= 20) {
        return sink.addError("Password should be less than 20 characters");
      }
      if (title.length < 3) {
        return sink.addError("Password should be more than 6 characters");
      }
      else {
        sink.add(title);
      }
    },
  );

  //  description validator
  var descValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (desc, sink) {
      if (desc.isEmpty) {
        return sink.addError("Please enter password");
      }
      if (desc.length >= 50) {
        return sink.addError("Password should be less than 20 characters");
      }
      if (desc.length < 8) {
        return sink.addError("Password should be more than 6 characters");
      }
      else {
        sink.add(desc);
      }
    },
  );
}