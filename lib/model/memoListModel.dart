// To parse this JSON data, do
//
//     final memoListModel = memoListModelFromJson(jsonString);

import 'dart:convert';

List<MemoListModel> memoListModelFromJson(String str) => List<MemoListModel>.from(json.decode(str).map((x) => MemoListModel.fromJson(x)));

String memoListModelToJson(List<MemoListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MemoListModel {
  int id;
  String bookTitle;
  String bookAuthor;
  int page;
  String title;
  String content;
  String image;
  String isbn;

  MemoListModel({
    required this.id,
    required this.bookTitle,
    required this.bookAuthor,
    required this.page,
    required this.title,
    required this.content,
    required this.image,
    required this.isbn,
  });

  factory MemoListModel.fromJson(Map<String, dynamic> json) => MemoListModel(
    id: json["id"],
    bookTitle: json["bookTitle"],
    bookAuthor: json["bookAuthor"],
    page: json["page"],
    title: json["title"],
    content: json["content"],
    image: json["image"],
    isbn: json["isbn"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bookTitle": bookTitle,
    "bookAuthor": bookAuthor,
    "page": page,
    "title": title,
    "content": content,
    "image": image,
    "isbn": isbn,
  };
}
