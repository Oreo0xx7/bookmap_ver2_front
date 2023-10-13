import 'package:bookmap_ver2/model/mainSearchBookMapModel.dart';
import 'package:flutter/material.dart';


class MainSearchBookMapViewTile extends StatelessWidget{

  final MainSearchBookMapModel bookMap;

  MainSearchBookMapViewTile(this.bookMap);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 130,
              width: 100,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: Image.network(
                bookMap.bookMapImage != null ? bookMap.bookMapImage.toString() : 'https://search.pstatic.net/sunny/?src=http%3A%2F%2Fimg.ssfshop.com%2Fcmd%2FLB_500x660%2Fsrc%2Fhttp%3A%2Fimg.ssfshop.com%2Fgoods%2FHMBR%2F19%2F04%2F08%2FGM0019040873391_7_ORGINL.jpg&type=sc960_832',
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(width: 8), //
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  bookMap.bookMapTitle ?? "",
                  maxLines: 2,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  makeHash(bookMap.hashTag).join(" ") ?? "",
                  style: TextStyle(fontSize: 14, fontFamily: 'Pretendard'),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 8),
                Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  bookMap.bookMapContent ?? "",
                  style: TextStyle(fontSize: 14, fontFamily: 'Pretendard', fontWeight: FontWeight.w200, color: Colors.black87),
                ),
              ],
            )
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
    if (tag.trim().isNotEmpty){
      newHash.add("#" + tag);
    }
  });
  return newHash;
}