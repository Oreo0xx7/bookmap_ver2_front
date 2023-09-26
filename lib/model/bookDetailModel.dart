// To parse this JSON data, do
//
//     final bookDetailModel = bookDetailModelFromJson(jsonString);

import 'dart:convert';

BookDetailModel bookDetailModelFromJson(String str) => BookDetailModel.fromJson(json.decode(str));

String bookDetailModelToJson(BookDetailModel data) => json.encode(data.toJson());

class BookDetailModel {
  String title;
  String author;
  String publisher;
  DateTime publishedDay;
  String isbn;
  String image;
  String description;

  BookDetailModel({
    required this.title,
    required this.author,
    required this.publisher,
    required this.publishedDay,
    required this.isbn,
    required this.image,
    required this.description,
  });

  factory BookDetailModel.fromJson(Map<String, dynamic> json) => BookDetailModel(
    title: json["title"],
    author: json["author"],
    publisher: json["publisher"],
    publishedDay: DateTime.parse(json["publishedDay"]),
    isbn: json["isbn"],
    image: json["image"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "author": author,
    "publisher": publisher,
    "publishedDay": "${publishedDay.year.toString().padLeft(4, '0')}-${publishedDay.month.toString().padLeft(2, '0')}-${publishedDay.day.toString().padLeft(2, '0')}",
    "isbn": isbn,
    "image": image,
    "description": description,
  };
}
