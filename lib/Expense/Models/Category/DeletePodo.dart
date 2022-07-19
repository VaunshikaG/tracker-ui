class DeletePodo {
  String message;
  String status;

  DeletePodo({this.message, this.status});

  DeletePodo.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}
