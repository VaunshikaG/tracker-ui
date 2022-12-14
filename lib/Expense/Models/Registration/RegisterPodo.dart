class RegisterPodo {
  RegisterData data;
  String message;
  int status;

  RegisterPodo({this.data, this.message, this.status});

  RegisterPodo.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new RegisterData.fromJson(json['data']) : null;
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

class RegisterData {
  int uid;
  String email;

  RegisterData({this.uid, this.email});

  RegisterData.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['email'] = this.email;
    return data;
  }
}
