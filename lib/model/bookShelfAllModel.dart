// To parse this JSON data, do
//
//     final bookShelfAllModel = bookShelfAllModelFromJson(jsonString);

import 'dart:convert';

List<BookShelfAllModel> bookShelfAllModelFromJson(String str) => List<BookShelfAllModel>.from(json.decode(str).map((x) => BookShelfAllModel.fromJson(x)));

String bookShelfAllModelToJson(List<BookShelfAllModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookShelfAllModel {
  int id;
  String isbn;
  String bookState;
  String title;
  String author;
  String image;
  double? grade;
  DateTime? startDate;
  DateTime? endDate;
  int? totalPage;
  int? readingPage;
  int? readingPercentage;

  BookShelfAllModel({
    required this.id,
    required this.isbn,
    required this.bookState,
    required this.title,
    required this.author,
    required this.image,
    this.grade,
    this.startDate,
    this.endDate,
    this.totalPage,
    this.readingPage,
    this.readingPercentage,
  });

  factory BookShelfAllModel.fromJson(Map<String, dynamic> json) => BookShelfAllModel(
    id: json["id"],
    isbn: json["isbn"],
    bookState: json["bookState"],
    title: json["title"],
    author: json["author"],
    image: json["image"],
    grade: json["grade"]?.toDouble(),
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
    totalPage: json["totalPage"],
    readingPage: json["readingPage"],
    readingPercentage: json["readingPercentage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "isbn": isbn,
    "bookState": bookState,
    "title": title,
    "author": author,
    "image": image,
    "grade": grade,
    "startDate": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "endDate": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "totalPage": totalPage,
    "readingPage": readingPage,
    "readingPercentage": readingPercentage,
  };
}
