// class BookMapModel{
//   late final String mapName;
//   late final String description;
//   late final String keyword;
//   late final String makerName;
//   late final String makerEmail;
//   final String img;
//   final int sort;
//
//   BookMapModel({
//     required this.mapName,
//     required this.img,
//     required this.makerName,
//     required this.makerEmail,
//     required this.sort,
//     this.description = "",
//     this.keyword = ""
// });
// }

import 'dart:convert';

List<BookMapModel> bookMapModelFromJson(String str) => List<BookMapModel>.from(json.decode(str).map((x) => BookMapModel.fromJson(x)));

String bookMapModelToJson(List<BookMapModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookMapModel {
  int? bookMapId;
  int? userId;
  String? bookMapTitle;
  String? bookMapContent;
  String? bookMapImage;
  List<String>? hashTag;
  bool share;
  String? nickname;
  int? scrapCount;

  BookMapModel({
    this.bookMapId,
    this.userId,
    this.bookMapTitle,
    this.bookMapContent,
    this.bookMapImage,
    this.hashTag,
    this.share = true,
    this.nickname,
    this.scrapCount,
  });

  factory BookMapModel.fromJson(Map<String, dynamic> json) => BookMapModel(
    bookMapId: json["bookMapId"],
    userId: json["userId"],
    bookMapTitle: json["bookMapTitle"],
    bookMapContent: json["bookMapContent"],
    bookMapImage: json["bookMapImage"],
    hashTag: (json["hashTag"] ?? [] as List<dynamic>).cast<String>(),
    share: json["share"],
    nickname: json["nickname"],
    scrapCount: json["scrapCount"],
  );

  Map<String, dynamic> toJson() => {
    "bookMapId": bookMapId,
    "bookMapTitle": bookMapTitle,
    "bookMapContent": bookMapContent,
    "bookMapImage": bookMapImage,
    "hashTag": List<dynamic>.from(hashTag!.map((x) => x)),
    "share": share,
    "nickname": nickname,
  };
}