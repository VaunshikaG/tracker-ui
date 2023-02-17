class Note {
  Note({
    this.id,
    this.title,
    this.content,
    this.amount,
    this.createdAt,
  });

  String id;
  String title;
  String content;
  String amount;
  DateTime createdAt;

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    id: json["id"] == null ? null : json["id"].toString(),
    title: json["title"] == null ? null : json["title"],
    content: json["content"] == null ? null : json["content"],
    amount: json["amount"] == null ? null : json["amount"].toString(),
    createdAt: json["createdAt"] == null ? null : json["createdAt"].toIso8601String(),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "content": content == null ? null : content,
    "amount": amount == null ? null : amount,
    "createdAt": createdAt == null ? null : createdAt,
  };

  Note copy({
    String id,
    String title,
    String content,
    String amount,
    // int color,
    // DateTime createdAt,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        amount: amount ?? this.amount,
        createdAt: createdAt ?? this.createdAt,
      );
}
