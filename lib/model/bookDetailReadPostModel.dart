// To parse this JSON data, do
//
//     final bookDetailReadPostModel = bookDetailReadPostModelFromJson(jsonString);

import 'dart:convert';

BookDetailReadPostModel bookDetailReadPostModelFromJson(String str) => BookDetailReadPostModel.fromJson(json.decode(str));

String bookDetailReadPostModelToJson(BookDetailReadPostModel data) => json.encode(data.toJson());

class BookDetailReadPostModel {
  String bookState;
  DateTime endDate;
  DateTime startDate;
  double grade;
  int totalPage;

  BookDetailReadPostModel({
    required this.bookState,
    required this.endDate,
    required this.startDate,
    required this.grade,
    required this.totalPage,
  });

  factory BookDetailReadPostModel.fromJson(Map<String, dynamic> json) => BookDetailReadPostModel(
    bookState: json["bookState"],
    endDate: DateTime.parse(json["endDate"]),
    startDate: DateTime.parse(json["startDate"]),
    grade: json["grade"]?.toDouble(),
    totalPage: json["totalPage"],
  );

  Map<String, dynamic> toJson() => {
    "bookState": bookState,
    "endDate": "${endDate?.year.toString().padLeft(4, '0')}-${endDate?.month.toString().padLeft(2, '0')}-${endDate?.day.toString().padLeft(2, '0')}",
    "startDate": "${startDate?.year.toString().padLeft(4, '0')}-${startDate?.month.toString().padLeft(2, '0')}-${startDate?.day.toString().padLeft(2, '0')}",
    "grade": grade,
    "totalPage": totalPage,
  };
}
