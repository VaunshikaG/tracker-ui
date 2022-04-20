class LoginModel {
  String firstName;
  String lastName;
  String email;
  String token;

  LoginModel({
    this.firstName,
    this.lastName,
    this.email,
    this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'] == null ? null : json["firstName"];
    lastName = json['lastName'] == null ? null : json["lastName"];
    email = json['email'] == null ? null : json["email"];
    token = json['token'] == null ? null : json["token"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['token'] = this.token;
    return data;
  }
}
