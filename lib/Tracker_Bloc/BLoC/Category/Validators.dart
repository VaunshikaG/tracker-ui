//  transformers for validtion
import 'dart:async';

mixin Validators {

  //  title validator
  var titleValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (title, sink) {
      if (title.isEmpty) {
        return sink.addError("Please enter title");
      }
      if (title.length >= 20) {
        return sink.addError("Password should be less than 10characters");
      }
      if (title.length < 3) {
        return sink.addError("Password should be more than 3 characters");
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
        return sink.addError("Please enter description");
      }
      if (desc.length >= 100) {
        return sink.addError("Password should be less than 100 characters");
      }
      if (desc.length < 6) {
        return sink.addError("Password should be more than 6 characters");
      }
      else {
        sink.add(desc);
      }
    },
  );
}