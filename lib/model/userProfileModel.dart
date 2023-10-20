// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) => UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) => json.encode(data.toJson());

class UserProfileModel {
    String picture;
    String nickName;
    int userId;
    String status;
    List<UserBookMapResponseDto> userBookMapResponseDto;

    UserProfileModel({
        required this.picture,
        required this.nickName,
        required this.userId,
        required this.status,
        required this.userBookMapResponseDto,
    });

    factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
        picture: json["picture"],
        nickName: json["nickName"],
        userId: json["userId"],
        status: json["status"],
        userBookMapResponseDto: List<UserBookMapResponseDto>.from(json["userBookMapResponseDto"].map((x) => UserBookMapResponseDto.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "picture": picture,
        "nickName": nickName,
        "userId": userId,
        "status": status,
        "userBookMapResponseDto": List<dynamic>.from(userBookMapResponseDto.map((x) => x.toJson())),
    };
}

class UserBookMapResponseDto {
    int bookMapId;
    int userId;
    String bookMapTitle;
    String bookMapContent;
    String bookMapImage;
    List<String> hashTag;
    bool share;
    String nickname;
    int scrapCount;

    UserBookMapResponseDto({
        required this.bookMapId,
        required this.userId,
        required this.bookMapTitle,
        required this.bookMapContent,
        required this.bookMapImage,
        required this.hashTag,
        required this.share,
        required this.nickname,
        required this.scrapCount,
    });

    factory UserBookMapResponseDto.fromJson(Map<String, dynamic> json) => UserBookMapResponseDto(
        bookMapId: json["bookMapId"],
        userId: json["userId"],
        bookMapTitle: json["bookMapTitle"],
        bookMapContent: json["bookMapContent"],
        bookMapImage: json["bookMapImage"],
        hashTag: List<String>.from(json["hashTag"].map((x) => x)),
        share: json["share"],
        nickname: json["nickname"],
        scrapCount: json["scrapCount"],
    );

    Map<String, dynamic> toJson() => {
        "bookMapId": bookMapId,
        "userId": userId,
        "bookMapTitle": bookMapTitle,
        "bookMapContent": bookMapContent,
        "bookMapImage": bookMapImage,
        "hashTag": List<dynamic>.from(hashTag.map((x) => x)),
        "share": share,
        "nickname": nickname,
        "scrapCount": scrapCount,
    };
}
