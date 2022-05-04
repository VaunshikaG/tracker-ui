// To parse this JSON data, do
//
//     final model2 = model2FromJson(jsonString);

import 'dart:convert';

List<Model2> model2FromJson(String str) => List<Model2>.from(json.decode(str).map((x) => Model2.fromJson(x)));

String model2ToJson(List<Model2> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Model2 {
  Model2({
    this.userId,
    this.categoryId,
    this.title,
    this.description,
    this.totalexpense,
  });

  String userId;
  String categoryId;
  String title;
  String description;
  String totalexpense;

  Model2.fromJson(Map<String, dynamic> json) {
    userId = json['userId'].toString();
    categoryId = json['categoryId'].toString();
    title = json['title'];
    description = json['description'];
    totalexpense = json['totalexpense'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['categoryId'] = this.categoryId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['totalexpense'] = this.totalexpense;
    return data;
  }
/*  factory Model2.fromJson(Map<String, dynamic> json) => Model2(
    userId: json["userId"].toString(),
    categoryId: json["categoryId"].toString(),
    title: json["title"],
    description: json["description"],
    totalexpense: json["totalexpense"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "categoryId": categoryId,
    "title": title,
    "description": description,
    "totalexpense": totalexpense,
  };*/
}
