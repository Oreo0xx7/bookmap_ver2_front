
import 'package:flutter/material.dart';

import '../asset.dart';

class BookDetailGetMemoViewTile extends StatelessWidget {
  const BookDetailGetMemoViewTile({super.key});


  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
      ),
      surfaceTintColor: appColor,
      margin: EdgeInsets.all(12),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 11,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(bottom: 10)),
                      // Text('${memoController.memos[index].startPage}~${memoController.memos[index].endPage}쪽을 읽고', style: TextStyle(fontSize: 13, fontFamily: 'Pretendard'),)
                    ],
                  ),
                ),
                Expanded(
                    flex:1,
                    child: IconButton(
                      splashColor: appColor,
                      splashRadius: 15,
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Get.bottomSheet(EditMemo(index),);
                      },
                    ))
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 20)),
            // Text('${memoController.memos[index].memoTitle}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),),
            // Text('${memoController.memos[index].memo}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Pretendard'),),
          ],
        ),
      ),
    );
  }
}
