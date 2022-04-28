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

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'].toString();
    userId = json['userId'].toString();
    title = json['title'] == null ? null : json["title"];
    description = json['description'] == null ? null : json['description'];
    totalexpense =
        json['totalexpense'] == null ? null : json['totalexpense'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['userId'] = this.userId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['totalexpense'] = this.totalexpense;
    return data;
  }
}
