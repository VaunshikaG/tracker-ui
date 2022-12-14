class CategoryPodo {
  CategoryData data;
  String message;
  int status;

  CategoryPodo({this.data, this.message, this.status});

  CategoryPodo.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new CategoryData.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class CategoryData {
  String categoryId;
  String title;
  String description;
  String amount;
  User user;

  CategoryData({this.categoryId, this.title, this.description, this.amount, this.user});

  CategoryData.fromJson(Map<String, dynamic> json) {
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
