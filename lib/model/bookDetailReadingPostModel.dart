// To parse this JSON data, do
//
//     final bookDetailReadingPostModel = bookDetailReadingPostModelFromJson(jsonString);

import 'dart:convert';

BookDetailReadingPostModel bookDetailReadingPostModelFromJson(String str) => BookDetailReadingPostModel.fromJson(json.decode(str));

String bookDetailReadingPostModelToJson(BookDetailReadingPostModel data) => json.encode(data.toJson());

class BookDetailReadingPostModel {
  String bookState;
  DateTime startDate;
  int readingPage;
  int totalPage;

  BookDetailReadingPostModel({
    required this.bookState,
    required this.startDate,
    required this.readingPage,
    required this.totalPage,
  });

  factory BookDetailReadingPostModel.fromJson(Map<String, dynamic> json) => BookDetailReadingPostModel(
    bookState: json["bookState"],
    startDate: DateTime.parse(json["startDate"]),
    readingPage: json["readingPage"],
    totalPage: json["totalPage"],
  );

  Map<String, dynamic> toJson() => {
    "bookState": bookState,
    "startDate": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "readingPage": readingPage,
    "totalPage": totalPage,
  };
}
