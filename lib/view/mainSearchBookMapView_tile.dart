import 'package:bookmap_ver2/model/mainSearchBookMapModel.dart';
import 'package:flutter/material.dart';


class MainSearchBookMapViewTile extends StatelessWidget{

  final MainSearchBookMapModel bookmap;

  MainSearchBookMapViewTile(this.bookmap);

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
                bookmap.bookMapImage != null ? bookmap.bookMapImage.toString() : 'https://search.pstatic.net/sunny/?src=http%3A%2F%2Fimg.ssfshop.com%2Fcmd%2FLB_500x660%2Fsrc%2Fhttp%3A%2Fimg.ssfshop.com%2Fgoods%2FHMBR%2F19%2F04%2F08%2FGM0019040873391_7_ORGINL.jpg&type=sc960_832',
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(width: 8), //
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${bookmap.bookMapTitle}',
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}