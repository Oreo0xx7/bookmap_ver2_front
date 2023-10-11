// To parse this JSON data, do
//
//     final bookDetailGetModel = bookDetailGetModelFromJson(jsonString);

import 'dart:convert';

BookDetailGetModel bookDetailGetModelFromJson(String str) => BookDetailGetModel.fromJson(json.decode(str));

String bookDetailGetModelToJson(BookDetailGetModel data) => json.encode(data.toJson());

class BookDetailGetModel {
  int id;
  String bookState;
  BookResponseDto bookResponseDto;
  DateTime? startDate;
  int? totalPage;
  int? readingPage;
  int? readingPercentage;
  List<BookMemoResponseDto> bookMemoResponseDtos;
  double? grade;
  DateTime? endDate;

  BookDetailGetModel({
    required this.id,
    required this.bookState,
    required this.bookResponseDto,
    this.startDate,
    this.totalPage,
    this.readingPage,
    this.readingPercentage,
    required this.bookMemoResponseDtos,
    this.grade,
    this.endDate,
  });

  factory BookDetailGetModel.fromJson(Map<String, dynamic> json) => BookDetailGetModel(
    id: json["id"],
    bookState: json["bookState"]!,
    bookResponseDto: BookResponseDto.fromJson(json["bookResponseDto"]),
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    totalPage: json["totalPage"],
    readingPage: json["readingPage"],
    readingPercentage: json["readingPercentage"],
    bookMemoResponseDtos: List<BookMemoResponseDto>.from(json["bookMemoResponseDtos"].map((x) => BookMemoResponseDto.fromJson(x))),
    grade: json["grade"]?.toDouble(),
    endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bookState": bookStateValues.reverse[bookState],
    "startDate": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "totalPage": totalPage,
    "readingPage": readingPage,
    "grade": grade,
    "endDate": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "bookMemoResponseDtos": List<dynamic>.from(bookMemoResponseDtos.map((x) => x.toJson())),
  };


}
class BookMemoResponseDto {
  int id;
  String content;
  DateTime saved;
  int page;
  String title;

  BookMemoResponseDto({
    required this.id,
    required this.content,
    required this.saved,
    required this.page,
    required this.title,
  });

  factory BookMemoResponseDto.fromJson(Map<String, dynamic> json) => BookMemoResponseDto(
    id: json["id"],
    content: json["content"],
    saved: DateTime.parse(json["saved"]),
    page: json["page"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "saved": saved.toIso8601String(),
    "page": page,
    "title": title,
  };
}

class BookResponseDto {
  int id;
  String title;
  String author;
  String publisher;
  DateTime publishedDay;
  String isbn;
  String image;
  String description;

  BookResponseDto({
    required this.id,
    required this.title,
    required this.author,
    required this.publisher,
    required this.publishedDay,
    required this.isbn,
    required this.image,
    required this.description,
  });

  factory BookResponseDto.fromJson(Map<String, dynamic> json) => BookResponseDto(
    id: json["id"],
    title: json["title"],
    author: json["author"],
    publisher: json["publisher"],
    publishedDay: DateTime.parse(json["publishedDay"]),
    isbn: json["isbn"],
    image: json["image"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "author": author,
    "publisher": publisher,
    "publishedDay": "${publishedDay.year.toString().padLeft(4, '0')}-${publishedDay.month.toString().padLeft(2, '0')}-${publishedDay.day.toString().padLeft(2, '0')}",
    "isbn": isbn,
    "image": image,
    "description": description,
  };
}

enum BookState {
  BOOK_STATE,
  EMPTY,
  PURPLE
}

final bookStateValues = EnumValues({
  "읽은": BookState.BOOK_STATE,
  "읽는중인": BookState.EMPTY,
  "읽고싶은": BookState.PURPLE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }

  // Enum 값을 문자열로 변환하는 메서드 추가
  String enumToString(T key) {
    return reverseMap[key] ?? key.toString();
  }
}
