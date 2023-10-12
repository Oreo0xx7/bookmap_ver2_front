// To parse this JSON data, do
//
//     final mainViewModel = mainViewModelFromJson(jsonString);

import 'dart:convert';

MainViewModel mainViewModelFromJson(String str) => MainViewModel.fromJson(json.decode(str));

String mainViewModelToJson(MainViewModel data) => json.encode(data.toJson());

class MainViewModel {
  List<BookEDto> bookImageDto;
  List<BookMapResponseDto> bookMapResponseDtos;
  List<BookEDto> bookTopResponseDtos;

  MainViewModel({
    required this.bookImageDto,
    required this.bookMapResponseDtos,
    required this.bookTopResponseDtos,
  });

  factory MainViewModel.fromJson(Map<String, dynamic> json) => MainViewModel(
    bookImageDto: List<BookEDto>.from(json["bookImageDto"].map((x) => BookEDto.fromJson(x))),
    bookMapResponseDtos: List<BookMapResponseDto>.from(json["bookMapResponseDtos"].map((x) => BookMapResponseDto.fromJson(x))),
    bookTopResponseDtos: List<BookEDto>.from(json["bookTopResponseDtos"].map((x) => BookEDto.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "bookImageDto": List<dynamic>.from(bookImageDto.map((x) => x.toJson())),
    "bookMapResponseDtos": List<dynamic>.from(bookMapResponseDtos.map((x) => x.toJson())),
    "bookTopResponseDtos": List<dynamic>.from(bookTopResponseDtos.map((x) => x.toJson())),
  };
}

class BookEDto {
  int id;
  String isbn;
  String image;
  String title;
  String author;
  String? publisher;

  BookEDto({
    required this.id,
    required this.isbn,
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

class BookMapResponseDto {
  int bookMapId;
  String bookMapTitle;
  String bookMapContent;
  String? bookMapImage;
  dynamic hashTag;
  bool share;

  BookMapResponseDto({
    required this.bookMapId,
    required this.bookMapTitle,
    required this.bookMapContent,
    this.bookMapImage,
    required this.hashTag,
    required this.share,
  });

  factory BookMapResponseDto.fromJson(Map<String, dynamic> json) => BookMapResponseDto(
    bookMapId: json["bookMapId"],
    bookMapTitle: json["bookMapTitle"],
    bookMapContent: json["bookMapContent"],
    bookMapImage: json["bookMapImage"],
    hashTag: json["hashTag"],
    share: json["share"],
  );

  Map<String, dynamic> toJson() => {
    "bookMapId": bookMapId,
    "bookMapTitle": bookMapTitle,
    "bookMapContent": bookMapContent,
    "bookMapImage": bookMapImage,
    "hashTag": hashTag,
    "share": share,
  };
}
