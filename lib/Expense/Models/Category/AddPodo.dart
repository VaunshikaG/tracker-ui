class AddPodo {
  Data data;
  String message;
  String status;

  AddPodo({this.data, this.message, this.status});

  AddPodo.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'].toString();
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

class Data {
  String categoryId;
  String title;
  String description;
  String amount;

  Data({this.categoryId, this.title, this.description, this.amount});

  Data.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'].toString();
    title = json['title'];
    description = json['description'];
    amount = json['amount'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['amount'] = this.amount;
    return data;
  }
}
