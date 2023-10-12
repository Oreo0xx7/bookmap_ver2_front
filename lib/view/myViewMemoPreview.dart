import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../asset.dart';
import '../model/profileViewModel.dart';

class MyViewMemoPreview extends StatelessWidget{
  final ProfileMemoResponseDto profileMemoResponseDto;

  MyViewMemoPreview(this.profileMemoResponseDto);

  @override
  Widget build(BuildContext context){
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
      ),
      elevation: 8,
      surfaceTintColor: appColor,
      margin: EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 3,
                    child: Image.network(profileMemoResponseDto.image, )),
                const Spacer(
                  flex: 1,
                ),
                Expanded(
                  flex: 11,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(profileMemoResponseDto.bookTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),),
                      Text(profileMemoResponseDto.bookAuthor, style: const TextStyle(fontSize: 13, fontFamily: 'Pretendard'),),
                      const Padding(padding: EdgeInsets.only(bottom: 10)),
                      Text('${profileMemoResponseDto.page}쪽을 읽고', style: TextStyle(fontSize: 13, fontFamily: 'Pretendard'),)
                    ],
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 20)),
            Text(profileMemoResponseDto.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),),
            Text(profileMemoResponseDto.content, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Pretendard'), overflow: TextOverflow.ellipsis,),
            //메모가 30자 미만인 경우의 처리가 필요함
          ],
        ),
      ),
    );
  }
}