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
  String? nickname;
  List<BookMapIndex>? bookMapIndex;

  BookMap({
    this.bookMapId,
    this.bookMapTitle,
    this.bookMapContent,
    this.bookMapImage,
    this.hashTag,
    this.share = true,
    this.nickname,
    this.bookMapIndex,
  });

  factory BookMap.fromJson(Map<String, dynamic> json) => BookMap(
    bookMapId: json["bookMapId"],
    bookMapTitle: json["bookMapTitle"],
    bookMapContent: json["bookMapContent"],
    bookMapImage: json["bookMapImage"],
    hashTag: (json["hashTag"] ?? [] as List<dynamic>).cast<String>(),
    share: json["share"],
    nickname: json["nickname"],
    bookMapIndex: (json["bookMapIndex"] as List<dynamic>?)?.map((x) => BookMapIndex.fromJson(x)).toList() ?? [],

    // bookMapIndex: List<BookMapIndex>.from(json["bookMapIndex"].map((x) => BookMapIndex.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "bookMapId": bookMapId,
    "bookMapTitle": bookMapTitle,
    "bookMapContent": bookMapContent,
    "bookMapImage": bookMapImage,
    "hashTag": List<dynamic>.from(hashTag!.map((x) => x)),
    "share": share,
    "nickname": nickname,
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
    map: (json["map"] as List<dynamic>?)?.map((x) => MapElement.fromJson(x)).toList() ?? [],
    memo: json["memo"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "map": List<dynamic>.from(map!.map((x) => x.toJson())),
    "memo": memo,
  };
}

class MapElement {
  int? id;
  String isbn;
  String? image;

  MapElement({
    this.id,
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
