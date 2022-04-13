class StudentModel {
  int id;
  String firstName;
  String lastName;

  StudentModel({this.id, this.firstName, this.lastName});

  StudentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    return data;
  }

  String get firstname => firstName;
  String get lastname => lastName;
}
