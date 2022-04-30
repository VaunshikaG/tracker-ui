// To parse this JSON data, do
//
//     final model2 = model2FromJson(jsonString);

import 'dart:convert';

Model2 model2FromJson(String str) => Model2.fromJson(json.decode(str));

String model2ToJson(Model2 data) => json.encode(data.toJson());

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

  factory Model2.fromJson(Map<String, dynamic> json) => Model2(
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
  };
}
