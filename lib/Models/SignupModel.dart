class SignupModel {
  String firstName;
  String lastName;
  String email;
  String password;

  SignupModel({this.firstName, this.lastName, this.email, this.password});

  SignupModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'] == null ? null : json["firstName"];
    lastName = json['lastName'] == null ? null : json["lastName"];
    email = json['email'] == null ? null : json["email"];
    password = json['password'] == null ? null : json["password"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
