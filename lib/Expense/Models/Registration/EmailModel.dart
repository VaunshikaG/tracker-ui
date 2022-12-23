// To parse this JSON data, do
//
//     final emailModel = emailModelFromJson(jsonString);

import 'dart:convert';

EmailModel emailModelFromJson(String str) => EmailModel.fromJson(json.decode(str));

String emailModelToJson(EmailModel data) => json.encode(data.toJson());

class EmailModel {
  EmailModel({
    this.data,
    this.message,
    this.status,
  });

  Data data;
  String message;
  int status;

  factory EmailModel.fromJson(Map<String, dynamic> json) => EmailModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data.toJson(),
    "message": message == null ? null : message,
    "status": status == null ? null : status,
  };
}

class Data {
  Data({
    this.isSuccessful,
    this.datetime,
    this.otp,
  });

  String isSuccessful;
  String datetime;
  String otp;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    isSuccessful: json["is_successful"] == null ? null : json["is_successful"],
    datetime: json["datetime"] == null ? null : json["datetime"],
    otp: json["otp"] == null ? null : json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "is_successful": isSuccessful == null ? null : isSuccessful,
    "datetime": datetime == null ? null : datetime,
    "otp": otp == null ? null : otp,
  };
}
