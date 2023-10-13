import 'dart:convert';

String bookMapSaveModelToJson(BookMapSaveModel data) => json.encode(data.toJson());

class BookMapSaveModel {
  String bookMapTitle;
  String bookMapContent;
  List<String>? hashTag;

  BookMapSaveModel({
    this.bookMapTitle = "",
    this.bookMapContent = "",
    this.hashTag,
  });

  Map<String, dynamic> toJson() => {
    "bookMapTitle": bookMapTitle,
    "bookMapContent": bookMapContent,
    "hashTag": List<dynamic>.from(hashTag!.map((x) => x)),
  };
}