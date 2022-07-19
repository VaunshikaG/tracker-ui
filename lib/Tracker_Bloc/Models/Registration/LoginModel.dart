import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.firstName,
    this.lastName,
    this.userId,
    this.email,
    this.token,
  });

  String firstName;
  String lastName;
  String userId;
  String email;
  String token;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    firstName: json["firstName"],
    lastName: json["lastName"],
    userId: json["userId"].toString(),
    email: json["email"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "userId": userId,
    "email": email,
    "token": token,
  };
}
