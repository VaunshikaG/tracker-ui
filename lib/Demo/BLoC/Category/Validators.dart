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
      } else {
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
      if (desc.length >= 200) {
        return sink.addError("Password should be less than 200 characters");
      }
      if (desc.length < 6) {
        return sink.addError("Password should be more than 10 characters");
      } else {
        sink.add(desc);
      }
    },
  );

  //  amt validator
  var amtValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (amt, sink) {
      if (amt.isEmpty) {
        return sink.addError("Please enter amount");
      }
      if (amt.length > 7) {
        return sink.addError("Amount should be less than 10000000 characters");
      }
      if (amt.length <= 0) {
        return sink.addError("Amount should be more than 0 characters");
      } else {
        sink.add(amt);
      }
    },
  );
}
