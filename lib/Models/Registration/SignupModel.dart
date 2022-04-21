class SignupModel {
  String firstName;
  String lastName;
  String email;
  String password;
  String token;

  SignupModel({this.firstName, this.lastName, this.email, this.password,this.token});

  SignupModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'] == null ? null : json["firstName"];
    lastName = json['lastName'] == null ? null : json["lastName"];
    email = json['email'] == null ? null : json["email"];
    password = json['password'] == null ? null : json["password"];
    token = json['token'] == null ? null : json["token"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['token'] = this.token;
    return data;
  }
}
