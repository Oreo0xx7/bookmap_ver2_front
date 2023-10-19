// To parse this JSON data, do
//
//     final searchUserModel = searchUserModelFromJson(jsonString);

import 'dart:convert';

List<SearchUserModel> searchUserModelFromJson(String str) => List<SearchUserModel>.from(json.decode(str).map((x) => SearchUserModel.fromJson(x)));

String searchUserModelToJson(List<SearchUserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchUserModel {
  int id;
  String nickname;
  String status;
  bool followOrNot;
  String image;

  SearchUserModel({
    required this.id,
    required this.nickname,
    required this.status,
    required this.followOrNot,
    required this.image
  });

  factory SearchUserModel.fromJson(Map<String, dynamic> json) => SearchUserModel(
    id: json["id"],
    nickname: json["nickname"],
    status: json["status"],
    followOrNot: json["followOrNot"],
    image: json["image"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nickname": nickname,
    "status": status,
    "followOrNot": followOrNot,
    "image": image
  };
}
