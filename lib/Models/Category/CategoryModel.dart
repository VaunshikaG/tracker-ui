class CategoryModel {
  String title;
  String description;

  CategoryModel({this.title, this.description});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    title = json['title'] == null ? null : json["title"];
    description = json['description'] == null ? null : json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}
