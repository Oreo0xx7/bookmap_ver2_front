// To parse this JSON data, do
//
//     final mainViewModel = mainViewModelFromJson(jsonString);

import 'dart:convert';

MainViewModel mainViewModelFromJson(String str) => MainViewModel.fromJson(json.decode(str));

String mainViewModelToJson(MainViewModel data) => json.encode(data.toJson());

class MainViewModel {
  List<BookEDto> bookImageDto;
  List<dynamic> bookMapResponseDtos;
  List<BookEDto> bookTopResponseDtos;

  MainViewModel({
    required this.bookImageDto,
    required this.bookMapResponseDtos,
    required this.bookTopResponseDtos,
  });

  factory MainViewModel.fromJson(Map<String, dynamic> json) => MainViewModel(
    bookImageDto: List<BookEDto>.from(json["bookImageDto"].map((x) => BookEDto.fromJson(x))),
    bookMapResponseDtos: List<dynamic>.from(json["bookMapResponseDtos"].map((x) => x)),
    bookTopResponseDtos: List<BookEDto>.from(json["bookTopResponseDtos"].map((x) => BookEDto.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "bookImageDto": List<dynamic>.from(bookImageDto.map((x) => x.toJson())),
    "bookMapResponseDtos": List<dynamic>.from(bookMapResponseDtos.map((x) => x)),
    "bookTopResponseDtos": List<dynamic>.from(bookTopResponseDtos.map((x) => x.toJson())),
  };
}

class BookEDto {
  int id;
  String? isbn;
  String image;
  String title;
  String author;
  String? publisher;

  BookEDto({
    required this.id,
    this.isbn,
    required this.image,
    required this.title,
    required this.author,
    this.publisher,
  });

  factory BookEDto.fromJson(Map<String, dynamic> json) => BookEDto(
    id: json["id"],
    isbn: json["isbn"],
    image: json["image"],
    title: json["title"],
    author: json["author"],
    publisher: json["publisher"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "isbn": isbn,
    "image": image,
    "title": title,
    "author": author,
    "publisher": publisher,
  };
}
