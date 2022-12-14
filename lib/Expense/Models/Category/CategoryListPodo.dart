/*
class CategoryListPodo {
  List<Data> data;
  String message;
  int status;

  CategoryListPodo({this.data, this.message, this.status});

  CategoryListPodo.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String categoryId;
  String title;
  String description;
  String amount;
  User user;

  Data({this.categoryId, this.title, this.description, this.amount, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'].toString();
    title = json['title'];
    description = json['description'];
    amount = json['amount'].toString();
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['amount'] = this.amount;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  String uid;
  String email;

  User({this.uid, this.email});

  User.fromJson(Map<String, dynamic> json) {
    uid = json['uid'].toString();
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['email'] = this.email;
    return data;
  }
}
*/


import 'dart:convert';

CategoryListPodo categoryListPodoFromJson(String str) => CategoryListPodo.fromJson(json.decode(str));

String categoryListPodoToJson(CategoryListPodo data) => json.encode(data.toJson());

class CategoryListPodo {
  CategoryListPodo({
    this.data,
    this.message,
    this.status,
  });

  List<Data> data;
  String message;
  int status;

  factory CategoryListPodo.fromJson(Map<String, dynamic> json) => CategoryListPodo(
    data: json["data"] == null ? null : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message == null ? null : message,
    "status": status == null ? null : status,
  };
}

class Data {
  Data({
    this.categoryId,
    this.title,
    this.description,
    this.amount,
    this.user,
  });

  String categoryId;
  String title;
  String description;
  String amount;
  User user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    categoryId: json["categoryId"] == null ? null : json["categoryId"].toString(),
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    amount: json["amount"] == null ? null : json["amount"].toString(),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId == null ? null : categoryId,
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "amount": amount == null ? null : amount,
    "user": user == null ? null : user.toJson(),
  };
}

class User {
  User({
    this.uid,
    this.email,
  });

  String uid;
  String email;

  factory User.fromJson(Map<String, dynamic> json) => User(
    uid: json["uid"] == null ? null : json["uid"].toString(),
    email: json["email"] == null ? null : json["email"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid == null ? null : uid,
    "email": email == null ? null : email,
  };
}
