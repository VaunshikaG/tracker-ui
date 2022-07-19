import 'dart:convert';

List<CategoryModel> categoryModelFromJson(String str) => List<CategoryModel>.from(json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelToJson(List<CategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  String categoryId;
  String userId;
  String title;
  String description;
  String totalexpense;

  CategoryModel({
    this.categoryId,
    this.userId,
    this.title,
    this.description,
    this.totalexpense,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
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
class RequestModel {
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    return map;
  }
}