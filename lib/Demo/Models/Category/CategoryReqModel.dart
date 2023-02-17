// To parse this JSON data, do
//
//     final categoryReqModel = categoryReqModelFromJson(jsonString);

import 'dart:convert';

CategoryReqModel categoryReqModelFromJson(String str) => CategoryReqModel.fromJson(json.decode(str));

String categoryReqModelToJson(CategoryReqModel data) => json.encode(data.toJson());

class CategoryReqModel {
  CategoryReqModel({
    this.title,
    this.description,
    this.amount,
  });

  String title;
  String description;
  String amount;

  factory CategoryReqModel.fromJson(Map<String, dynamic> json) => CategoryReqModel(
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    amount: json["amount"] == null ? null : json["amount"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "amount": amount == null ? null : amount,
  };
}
