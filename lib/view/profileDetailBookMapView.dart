import 'package:flutter/material.dart';

import '../asset.dart';
import '../model/userProfileModel.dart';

class ProfileDetailBookMapDetailView extends StatelessWidget {

  final UserBookMapResponseDto userBookMapResponseDto;

  ProfileDetailBookMapDetailView(this.userBookMapResponseDto);

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: appColor,
      margin: EdgeInsets.all(12),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 3,
                child: ( userBookMapResponseDto.bookMapImage == null)
                    ? Image.asset('src/sampleBook.jpg')
                    : Image.network(userBookMapResponseDto.bookMapImage ?? "", fit: BoxFit.fitWidth, width: 50,)),
            const Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 11,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(bottom: 10)),
                      Text('${userBookMapResponseDto.bookMapTitle}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),),
                      Text('${userBookMapResponseDto.bookMapContent}', style: TextStyle(fontSize: 13, fontFamily: 'Pretendard'),),
                      Text(makeHash(userBookMapResponseDto.hashTag).join(" "), style: TextStyle(fontSize: 13, fontFamily: 'Pretendard'),),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<String> makeHash(List<String>? tags) {
  List<String> newHash = [];
  tags?.forEach((tag) {
    if (tag.trim().isNotEmpty) {
      newHash.add("#" + tag);
    }
  });
  return newHash;
}
