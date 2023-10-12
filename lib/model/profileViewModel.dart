// To parse this JSON data, do
//
//     final profileViewModel = profileViewModelFromJson(jsonString);

import 'dart:convert';

ProfileViewModel profileViewModelFromJson(String str) => ProfileViewModel.fromJson(json.decode(str));

String profileViewModelToJson(ProfileViewModel data) => json.encode(data.toJson());

class ProfileViewModel {
  int id;
  String nickName;
  String status;
  int readBooksCount;
  int bookmapCount;
  String image;
  List<ProfileMemoResponseDto> profileMemoResponseDtos;

  ProfileViewModel({
    required this.id,
    required this.nickName,
    required this.status,
    required this.readBooksCount,
    required this.bookmapCount,
    required this.image,
    required this.profileMemoResponseDtos,
  });

  factory ProfileViewModel.fromJson(Map<String, dynamic> json) => ProfileViewModel(
    id: json["id"],
    nickName: json["nickName"],
    status: json["status"],
    readBooksCount: json["readBooksCount"],
    bookmapCount: json["bookmapCount"],
    image: json["image"],
    profileMemoResponseDtos: List<ProfileMemoResponseDto>.from(json["profileMemoResponseDtos"].map((x) => ProfileMemoResponseDto.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nickName": nickName,
    "status": status,
    "readBooksCount": readBooksCount,
    "bookmapCount": bookmapCount,
    "image": image,
    "profileMemoResponseDtos": List<dynamic>.from(profileMemoResponseDtos.map((x) => x.toJson())),
  };
}

class ProfileMemoResponseDto {
  int id;
  String bookTitle;
  String bookAuthor;
  int page;
  String title;
  String content;
  String image;
  String isbn;

  ProfileMemoResponseDto({
    required this.id,
    required this.bookTitle,
    required this.bookAuthor,
    required this.page,
    required this.title,
    required this.content,
    required this.image,
    required this.isbn,
  });

  factory ProfileMemoResponseDto.fromJson(Map<String, dynamic> json) => ProfileMemoResponseDto(
    id: json["id"],
    bookTitle: json["bookTitle"],
    bookAuthor: json["bookAuthor"],
    page: json["page"],
    title: json["title"],
    content: json["content"],
    image: json["image"],
    isbn: json["isbn"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bookTitle": bookTitle,
    "bookAuthor": bookAuthor,
    "page": page,
    "title": title,
    "content": content,
    "image": image,
    "isbn": isbn,
  };
}
