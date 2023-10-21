// To parse this JSON data, do
//
//     final searchBookMap = searchBookMapFromJson(jsonString);

import 'dart:convert';

List<MainSearchBookMapModel> searchBookMapFromJson(String str) => List<MainSearchBookMapModel>.from(json.decode(str).map((x) => MainSearchBookMapModel.fromJson(x)));

String searchBookMapToJson(List<MainSearchBookMapModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MainSearchBookMapModel {
  int bookMapId;
  String bookMapTitle;
  String bookMapContent;
  String? bookMapImage;
  List<String>? hashTag;
  bool share;
  int scrapCount;

  MainSearchBookMapModel({
    required this.bookMapId,
    required this.bookMapTitle,
    required this.bookMapContent,
    required this.bookMapImage,
    required this.hashTag,
    required this.share,
    required this.scrapCount,
  });

  factory MainSearchBookMapModel.fromJson(Map<String, dynamic> json) => MainSearchBookMapModel(
    bookMapId: json["bookMapId"],
    bookMapTitle: json["bookMapTitle"],
    bookMapContent: json["bookMapContent"],
    bookMapImage: json["bookMapImage"],
    hashTag: json["hashTag"] == null ? [] : List<String>.from(json["hashTag"]!.map((x) => x)),
    share: json["share"],
    scrapCount: json["scrapCount"]
  );

  Map<String, dynamic> toJson() => {
    "bookMapId": bookMapId,
    "bookMapTitle": bookMapTitle,
    "bookMapContent": bookMapContent,
    "bookMapImage": bookMapImage,
    "hashTag": hashTag == null ? [] : List<dynamic>.from(hashTag!.map((x) => x)),
    "share": share,
  };
}
