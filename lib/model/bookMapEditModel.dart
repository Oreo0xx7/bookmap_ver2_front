import 'dart:convert';
import 'package:get/get.dart';

BookMap bookMapFromJson(String str) => BookMap.fromJson(json.decode(str));

String bookMapToJson(BookMap data) => json.encode(data.toJson());

class BookMap {
  int? bookMapId;
  String? bookMapTitle;
  String? bookMapContent;
  String? bookMapImage;
  List<String>? hashTag;
  bool share = true;
  List<BookMapIndex>? bookMapIndex;

  BookMap({
    this.bookMapId,
    this.bookMapTitle,
    this.bookMapContent,
    this.bookMapImage,
    this.hashTag,
    this.share = true,
    this.bookMapIndex,
  });

  factory BookMap.fromJson(Map<String, dynamic> json) => BookMap(
    bookMapId: json["bookMapId"],
    bookMapTitle: json["bookMapTitle"],
    bookMapContent: json["bookMapContent"],
    bookMapImage: json["bookMapImage"],
    hashTag: List<String>.from(json["hashTag"].map((x) => x)),
    share: json["share"],
    bookMapIndex: List<BookMapIndex>.from(json["bookMapIndex"].map((x) => BookMapIndex.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "bookMapId": bookMapId,
    "bookMapTitle": bookMapTitle,
    "bookMapContent": bookMapContent,
    "bookMapImage": bookMapImage,
    "hashTag": List<dynamic>.from(hashTag!.map((x) => x)),
    "share": share,
    "bookMapIndex": List<dynamic>.from(bookMapIndex!.map((x) => x.toJson())),
  };
}

class BookMapIndex {
  String type;
  List<MapElement>? map;
  String? memo;

  BookMapIndex({
    required this.type,
    this.map,
    this.memo,
  });

  factory BookMapIndex.fromJson(Map<String, dynamic> json) => BookMapIndex(
    type: json["type"],
    map: List<MapElement>.from(json["map"].map((x) => MapElement.fromJson(x))),
    memo: json["memo"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "map": List<dynamic>.from(map!.map((x) => x.toJson())),
    "memo": memo,
  };
}

class MapElement {
  int id;
  String isbn;
  String? image;

  MapElement({
    required this.id,
    required this.isbn,
    this.image,
  });

  factory MapElement.fromJson(Map<String, dynamic> json) => MapElement(
    id: json["id"],
    isbn: json["isbn"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "isbn": isbn,
    "image": image,
  };
}
