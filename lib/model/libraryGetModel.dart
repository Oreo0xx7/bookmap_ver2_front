// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

LibraryGetModel bookFromJson(String str) => LibraryGetModel.fromJson(json.decode(str));

String bookToJson(LibraryGetModel data) => json.encode(data.toJson());

class LibraryGetModel {
  List<Document> documents;
  Meta meta;

  LibraryGetModel({
    required this.documents,
    required this.meta,
  });

  factory LibraryGetModel.fromJson(Map<String, dynamic> json) => LibraryGetModel(
    documents: List<Document>.from(json["documents"].map((x) => Document.fromJson(x))),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "documents": List<dynamic>.from(documents.map((x) => x.toJson())),
    "meta": meta.toJson(),
  };
}

class Document {
  List<String> authors;
  String contents;
  DateTime datetime;
  String isbn;
  int price;
  String publisher;
  int salePrice;
  String thumbnail;
  String title;
  List<String> translators;
  String url;

  Document({
    required this.authors,
    required this.contents,
    required this.datetime,
    required this.isbn,
    required this.price,
    required this.publisher,
    required this.salePrice,
    required this.thumbnail,
    required this.title,
    required this.translators,
    required this.url,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
    authors: List<String>.from(json["authors"].map((x) => x)),
    contents: json["contents"],
    datetime: DateTime.parse(json["datetime"]),
    isbn: json["isbn"],
    price: json["price"],
    publisher: json["publisher"],
    salePrice: json["sale_price"],
    thumbnail: json["thumbnail"],
    title: json["title"],
    translators: List<String>.from(json["translators"].map((x) => x)),
    url: json["url"],
  );

  get documents => null;

  Map<String, dynamic> toJson() => {
    "authors": List<dynamic>.from(authors.map((x) => x)),
    "contents": contents,
    "datetime": datetime.toIso8601String(),
    "isbn": isbn,
    "price": price,
    "publisher": publisher,
    "sale_price": salePrice,
    "thumbnail": thumbnail,
    "title": title,
    "translators": List<dynamic>.from(translators.map((x) => x)),
    "url": url,
  };
}

enum Status {
  EMPTY
}

final statusValues = EnumValues({
  "정상판매": Status.EMPTY
});

class Meta {
  bool isEnd;
  int pageableCount;
  int totalCount;

  Meta({
    required this.isEnd,
    required this.pageableCount,
    required this.totalCount,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    isEnd: json["is_end"],
    pageableCount: json["pageable_count"],
    totalCount: json["total_count"],
  );

  Map<String, dynamic> toJson() => {
    "is_end": isEnd,
    "pageable_count": pageableCount,
    "total_count": totalCount,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
