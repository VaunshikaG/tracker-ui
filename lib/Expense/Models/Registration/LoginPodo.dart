class LoginPodo {
  LoginData data;
  String message;
  int status;

  LoginPodo({this.data, this.message, this.status});

  LoginPodo.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
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

class LoginData {
  String userId;
  String email;
  String token;

  LoginData({this.userId, this.email, this.token});

  LoginData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    email = json['email'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['email'] = this.email;
    data['token'] = this.token;
    return data;
  }
}
