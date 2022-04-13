class SignupModel {
  // int id;
  String firstName;
  String lastName;
  String email;
  String password;

  SignupModel({this.firstName, this.lastName, this.email, this.password});

  SignupModel.fromJson(Map<String, dynamic> json) {
    // id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }

  String get firstname => firstName;
  String get lastname => lastName;
  String get semail => email;
  String get spassword => password;
}
